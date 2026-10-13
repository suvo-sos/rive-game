// Storm pipeline v3: the level-3 haboob as GPU-driven dust.
// Same 12-float verts (pos + color + info + local) and the same 80-byte
// UBO prefix as every other pipeline. Geometry is 5 static tessellated
// curtains that NEVER move; the charge is pure illusion done here: the
// noise domain streams out of the wall face toward the jet + rises
// (never sideways — columns stand straight and boil vertically), streaks
// fall straight down the face, and each sheet surges slowly forward/back
// net-zero. Domain-warped 5-octave fbm + ridged billows, fake volume
// lighting, gust nose, straight fraying crown. Opaque pipeline: edges
// dissolve via screen-space dither (stable, no crawl).
// local = (u along wall, v up it, layer 0 front / 2 back).
// info.x = density 1..0, info.y = seed, info.z = kind (8 = storm).
struct VertexIn {
    @location(0) pos: vec3<f32>,
    @location(1) col: vec3<f32>,
    @location(2) info: vec3<f32>,
    @location(3) local: vec3<f32>,
};

struct VertexOutput {
    @builtin(position) clip: vec4<f32>,
    @location(0) color: vec3<f32>,
    @location(1) world: vec3<f32>,
    @location(2) info: vec3<f32>,
    @location(3) local: vec3<f32>,
};

struct Uniforms {
    mvp: mat4x4<f32>,
    time: f32,
    camX: f32,
    sunI: f32,
    camZ: f32,
};

@group(0) @binding(0)
var<uniform> u: Uniforms;

fn hash21(p: vec2<f32>) -> f32 {
    let q = fract(p * vec2<f32>(234.34, 435.345));
    return fract(q.x + q.y + dot(q, q + vec2<f32>(34.23, 34.23)));
}

fn vnoise(p: vec2<f32>) -> f32 {
    let i = floor(p);
    let f = fract(p);
    let s = f * f * (3.0 - 2.0 * f);
    let a = hash21(i);
    let b = hash21(i + vec2<f32>(1.0, 0.0));
    let c = hash21(i + vec2<f32>(0.0, 1.0));
    let d = hash21(i + vec2<f32>(1.0, 1.0));
    return mix(mix(a, b, s.x), mix(c, d, s.x), s.y);
}

fn fbm3(p: vec2<f32>) -> f32 {
    return vnoise(p) * 0.55 + vnoise(p * 2.13 + 7.7) * 0.28 + vnoise(p * 4.41 + 3.1) * 0.17;
}

fn fbm5(p: vec2<f32>) -> f32 {
    var v = vnoise(p) * 0.45;
    v += vnoise(p * 2.03 + 11.3) * 0.25;
    v += vnoise(p * 4.17 + 5.9) * 0.15;
    v += vnoise(p * 8.31 + 2.7) * 0.09;
    v += vnoise(p * 16.63 + 9.1) * 0.06;
    return v;
}

fn ridged(p: vec2<f32>) -> f32 {
    var v = (1.0 - abs(2.0 * vnoise(p) - 1.0)) * 0.45;
    v += (1.0 - abs(2.0 * vnoise(p * 2.11 + 4.4) - 1.0)) * 0.27;
    v += (1.0 - abs(2.0 * vnoise(p * 4.23 + 8.8) - 1.0)) * 0.18;
    v += (1.0 - abs(2.0 * vnoise(p * 8.47 + 1.2) - 1.0)) * 0.10;
    return v;
}

fn ign(pix: vec2<f32>) -> f32 {
    return fract(52.9829189 * fract(dot(pix, vec2<f32>(0.06711056, 0.00583715))));
}

@vertex
fn vs_main(in: VertexIn) -> VertexOutput {
    var out: VertexOutput;
    // Straight boil: NO sideways slide (nothing scrolls along the wall).
    // Columns churn vertically (rising boil) while the whole sheet surges
    // slowly toward the jet and back — net-zero geometry, but it reads as
    // an incoming wall. Ground-pinned (ev^2) so the base stays planted.
    let seed = in.info.y * 61.7;
    let dens = clamp(in.info.x, 0.0, 1.0);
    let layer = in.local.z;
    let eu = in.local.x;
    let ev = in.local.y;
    let n1 = fbm3(vec2<f32>(eu * 9.0 + seed * 13.0, ev * 4.0 - u.time * 0.22 + seed * 5.0));
    let n2 = fbm3(vec2<f32>(eu * 5.0 - seed * 7.0, ev * 6.0 - u.time * 0.35 - seed * 3.0));
    let amp = ev * ev;
    let surge = (0.5 + 0.5 * sin(u.time * 0.30 + seed * 7.0)) * -340.0 * (0.35 + 0.65 * dens);
    let disp = vec3<f32>((n1 - 0.5) * 200.0 * amp, (n2 - 0.5) * 200.0 * amp * (1.0 - ev * 0.45), surge * amp + (n1 - n2) * 120.0 * amp);
    out.clip = u.mvp * vec4<f32>(in.pos + disp, 1.0);
    out.color = in.col;
    out.world = in.pos;
    out.info = in.info;
    out.local = in.local;
    return out;
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let w = in.world;
    let dens = clamp(in.info.x, 0.0, 1.0);
    let seed = in.info.y * 61.7;
    let layer = in.local.z;
    let eu = in.local.x;
    let ev = in.local.y;
    // NOTE: in.clip in the fragment is window pixel coords (not the
    // vertex clip pos) — used for stable screen-space dither + grain.
    let pix = floor(in.clip.xy);
    let dith = ign(pix);

    // Front layers rush harder than the back ones (parallax charge).
    let rush = u.time * (95.0 - layer * 14.0);

    // Straight-column wind field: variation runs ACROSS the wall, columns
    // stand VERTICAL (y frequency squashed), and the whole domain streams
    // out of the wall face toward the jet (-z) + rises — never sideways.
    // Sampling w.z + rush makes dust perpetually rush at the lens; sampling
    // w.y - rise makes the boil climb. The wall itself never moves.
    let wz = w.z + rush * 9.0;
    let wy = w.y - u.time * 55.0;
    var q = vec2<f32>(w.x * 0.00095 + wz * 0.00085, wy * 0.00030 + wz * 0.00030);
    let warp = fbm3(q * 3.1 + vec2<f32>(seed, u.time * 0.05));
    let wq = q * 4.2 + (warp - 0.5) * 2.6 + vec2<f32>(0.0, u.time * 0.04) + seed * 1.7;
    let m = fbm5(wq);
    let billow = ridged(wq * 1.35 + warp);
    let body = m * 0.62 + billow * 0.38;
    // Straight fall-streaks: thin across, long vertically, scrolling down
    // out of the crown like dust raining inside the wall — vertical grain.
    let streak = fbm3(vec2<f32>((w.x + wz * 0.5) * 0.006 + seed * 3.0,
        (wy * 0.5 + w.y * 0.5) * 0.006 + warp * 2.0));
    let grain = vnoise(vec2<f32>((w.x + wz) * 0.05, wy * 0.045));

    // Fake volume lighting from the noise slope: lit flanks vs shadowed
    // pockets, sampled cheaply with two extra taps of the warp field.
    let e = 0.35;
    let sx = fbm3(wq + vec2<f32>(e, 0.0)) - fbm3(wq - vec2<f32>(e, 0.0));
    let sy = fbm3(wq + vec2<f32>(0.0, e)) - fbm3(wq - vec2<f32>(0.0, e));
    let slope = clamp(0.5 + (sx - sy) * 2.2, 0.0, 1.0);

    // Vertical ramp: near-black occluded base -> rust heart -> pale crown.
    // Broken by turbulence so bands never stripe.
    let t = clamp(w.y / 2600.0, 0.0, 1.0);
    var col = mix(vec3<f32>(0.115, 0.062, 0.034), vec3<f32>(0.52, 0.30, 0.135),
        smoothstep(0.0, 0.5, t + (body - 0.5) * 0.45));
    col = mix(col, vec3<f32>(0.86, 0.70, 0.54),
        smoothstep(0.5, 1.0, t + (body - 0.5) * 0.35));
    // Sun-scattered heart: the middle glows through the dust.
    col += vec3<f32>(0.50, 0.24, 0.08) * body * body * (1.0 - t) * 0.85;
    // Slope light + streak/grain modulation: pockets go dark, flanks catch
    // the sky. Upper dust brighter (roof-lit), base in its own shadow.
    col *= 0.62 + 0.62 * slope;
    col *= 0.70 + 0.55 * streak;
    col *= 0.92 + 0.16 * grain;
    col *= 0.72 + 0.42 * clamp(ev + (streak - 0.5) * 0.5, 0.0, 1.0);

    // Gust nose: churning dark-red roll at the foot with faint advected
    // Kelvin-Helmholtz bands suggesting the outflow tumble.
    let nose = (1.0 - smoothstep(0.0, 0.32, ev)) * (1.0 - layer * 0.25);
    col = mix(col, vec3<f32>(0.28, 0.14, 0.06), nose * 0.5 * (0.45 + 0.55 * body));
    col *= 1.0 + sin(ev * 26.0 - u.time * 3.2 + body * 6.0) * 0.07 * nose;

    // Diffuse crown: even at full density the top runs thin and hazy like
    // a real haboob, never a solid cliff top. Mostly straight: only fine
    // streak noise frays it, big billows are flattened near the top.
    let crownThin = smoothstep(0.55, 1.0, t);
    col = mix(col, vec3<f32>(0.80, 0.66, 0.50), crownThin * 0.55);
    let densH = dens * (1.0 - smoothstep(0.5, 1.0, ev) * 0.15);

    // Silhouette: all four edges erode with noise-broken dither; the top
    // uses fine streaks only (small weight) so it stays mostly straight
    // with wispy fray, while sides/base break up more.
    let side = min(eu, 1.0 - eu) * 2.0;
    let top = 1.0 - ev;
    let bot = ev * 3.0 + 0.15;
    let edge = min(side, min(top * 2.2, bot));
    let topFray = (streak - 0.5) * 0.30 + (grain - 0.5) * 0.18;
    let sideBreak = (body - 0.5) * (0.55 + (1.0 - ev) * 0.55);
    let edgeN = edge + mix(sideBreak, topFray, smoothstep(0.55, 0.95, ev));
    var cov = densH * smoothstep(0.0, 0.28, edgeN);
    cov *= smoothstep(0.02, 0.22, body * 0.55 + streak * 0.30 + densH * 0.55);
    // Seal: at full density the interior is SOLID (no sightline through
    // to the other side) — only the silhouette frays. Falls off cubed
    // so the reveal/break thinning still reads.
    cov = max(cov, densH * densH * densH * smoothstep(0.0, 0.10, edgeN) * 0.97);
    if (cov < dith) {
        discard;
    }

    // Far-field sit: a whisper of the night horizon purple so the wall
    // sits in the scene instead of floating pasted-on. Very light — the
    // storm must stay dusty from 12k out.
    let camXZ = vec2<f32>(u.camX, u.camZ);
    let dist = length(w.xz - camXZ);
    let sit = 1.0 - exp(-dist * dist * 0.00000012);
    col = mix(col, vec3<f32>(0.23, 0.13, 0.28), sit * 0.18);
    // Film grain against banding + distant shimmer in the dust.
    col += (dith - 0.5) * 0.035;
    col *= 1.0 + 0.03 * sin(dist * 0.05 - u.time * 2.0) * smoothstep(2000.0, 9000.0, dist);

    // Lightning: per-face strike cycles (~2-3.5s, ~90% fire). Each cycle
    // rolls for a strike cell (1 of 7 along the wall); when it fires, a
    // jagged channel forks down the face with a double-blink envelope, a
    // violet halo around it, and a wall-wide uplift so the whole wall
    // flashes.
    let cyc = 2.0 + fract(seed * 7.0) * 1.5;
    let ct = u.time / cyc + seed * 3.0;
    let ci = floor(ct);
    let cf = fract(ct);
    let strikeOn = step(0.10, hash21(vec2<f32>(ci * 1.7, seed * 91.0)));
    let cell = floor(hash21(vec2<f32>(ci * 3.1, seed * 57.0)) * 7.0);
    let bl = cf / 0.20;
    let env = exp(-bl * 4.0) * (0.6 + 0.4 * sin(bl * 40.0)) * (1.0 - step(0.20, cf)) * strikeOn;
    let wob = (fbm3(vec2<f32>(cell * 7.0 + seed * 10.0, ev * 3.0)) - 0.5) * 0.06;
    let bx = (cell + 0.5) / 7.0 + wob;
    let dchan = abs(eu - bx);
    let core = 1.0 - smoothstep(0.0, 0.004 + (1.0 - ev) * 0.002, dchan);
    let halo = exp(-dchan * dchan * 900.0);
    col += (vec3<f32>(0.85, 0.88, 1.0) * core * 3.0 + vec3<f32>(0.55, 0.60, 1.0) * halo * 0.8) * env;
    // Second bolt: same flash moment, different cell — twin strikes.
    let cell2 = floor(hash21(vec2<f32>(ci * 5.3, seed * 31.0)) * 7.0);
    let wob2 = (fbm3(vec2<f32>(cell2 * 7.0 + seed * 4.0, ev * 3.0 + 2.0)) - 0.5) * 0.06;
    let bx2 = (cell2 + 0.5) / 7.0 + wob2;
    let dchan2 = abs(eu - bx2);
    let core2 = 1.0 - smoothstep(0.0, 0.004 + (1.0 - ev) * 0.002, dchan2);
    let halo2 = exp(-dchan2 * dchan2 * 900.0);
    col += (vec3<f32>(0.85, 0.88, 1.0) * core2 * 3.0 + vec3<f32>(0.55, 0.60, 1.0) * halo2 * 0.8) * env;
    col += vec3<f32>(0.45, 0.50, 0.80) * env * 0.35 * (0.3 + 0.7 * body);
    return vec4<f32>(col, 1.0);
}
