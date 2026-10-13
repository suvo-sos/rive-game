// Missile pipeline: the SEEKER gun's homing missiles + their explosions.
// Same 12-float verts as the nuke pipe (pos + col + info + local) and the
// full 96-byte UBO (eye tail aims the explosion billboards), so the same
// uniform buffer feeds it. Three kinds, one draw:
//   kind 0: missile cruise body. The CPU packs an oriented box along the
//     velocity (local = corner signs, +z = nose). The shader paints the
//     gunmetal airframe, a white-hot nose tip, a flickering exhaust flame
//     at the tail, and a strobing belly beacon.
//   kind 1: explosion fireball billboard. Staged once at detonation
//     (center + size + birth in the verts), animated purely by u.time:
//     blackbody churn that blows out, erodes, and dies in ~1.2s.
//   kind 2: shock ring billboard. Thin bright front racing outward, ~0.9s.
// Opaque pipeline: soft edges via screen-space dither (nuke precedent).
struct VertexIn {
    @location(0) pos: vec3<f32>, // kind 0: world vertex; kind 1/2: boom center
    @location(1) col: vec3<f32>, // kind, size, seed
    @location(2) info: vec3<f32>, // kind 0: heat, 0, 0; kind 1/2: birth, hx, hy
    @location(3) local: vec3<f32>, // kind 0: box corner (-1..1); else quad corner
};

struct VertexOutput {
    @builtin(position) clip: vec4<f32>,
    @location(0) uv: vec2<f32>,
    @location(1) age: f32,
    @location(2) kind: f32,
    @location(3) seed: f32,
    @location(4) world: vec3<f32>,
    @location(5) local: vec3<f32>,
    @location(6) heat: f32,
};

struct Uniforms {
    mvp: mat4x4<f32>,
    time: f32,
    camX: f32,
    sunI: f32,
    camZ: f32,
    eye: vec3<f32>,
    pad: f32,
};

@group(0) @binding(0)
var<uniform> u: Uniforms;

@vertex
fn vs_main(in: VertexIn) -> VertexOutput {
    var out: VertexOutput;
    let kind = in.col.x;
    out.kind = kind;
    out.seed = in.col.z;
    out.local = in.local;
    if (kind < 0.5 || kind > 2.5) {
        // Cruise body: verts are already world-placed by the CPU.
        out.clip = u.mvp * vec4<f32>(in.pos, 1.0);
        out.world = in.pos;
        out.uv = vec2<f32>(in.local.x, in.local.y);
        out.age = 0.0;
        out.heat = in.info.x;
    } else {
        // Explosion billboards: camera-face around the staged center.
        let birth = in.info.x;
        let age = max(u.time - birth, 0.0);
        var grow = 1.0;
        var rise = 0.0;
        if (kind < 1.5) { // fireball swells fast, climbs a little
            grow = 0.4 + min(age * 3.0, 1.4);
            rise = age * 60.0;
        } else { // shock ring races out flat
            grow = 0.2 + age * 2.6;
            rise = 20.0;
        }
        let center = in.pos + vec3<f32>(0.0, rise, 0.0);
        let toEye = u.eye - center;
        let fwd = toEye / max(length(toEye), 0.001);
        var right = cross(vec3<f32>(0.0, 1.0, 0.0), fwd);
        right = right / max(length(right), 0.001);
        let upv = cross(fwd, right);
        let world = center + (right * in.local.x * in.info.y
            + upv * in.local.y * in.info.z) * grow;
        out.clip = u.mvp * vec4<f32>(world, 1.0);
        out.world = world;
        out.uv = vec2<f32>(in.local.x, in.local.y);
        out.age = age;
        out.heat = 1.0;
    }
    return out;
}

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

fn fbm(p: vec2<f32>) -> f32 {
    return vnoise(p) * 0.55 + vnoise(p * 2.13 + 7.7) * 0.28 + vnoise(p * 4.41 + 3.1) * 0.17;
}

// Blackbody ramp: cold char -> deep red -> orange -> pale yellow -> white.
fn ramp(t: f32) -> vec3<f32> {
    var c = mix(vec3<f32>(0.25, 0.02, 0.01), vec3<f32>(1.0, 0.15, 0.02), smoothstep(0.0, 0.35, t));
    c = mix(c, vec3<f32>(1.0, 0.55, 0.10), smoothstep(0.3, 0.6, t));
    c = mix(c, vec3<f32>(1.0, 0.9, 0.55), smoothstep(0.55, 0.8, t));
    c = mix(c, vec3<f32>(1.6, 1.6, 1.5), smoothstep(0.8, 1.0, t));
    return c;
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let kind = in.kind;
    let w = in.world;
    let l = in.local;
    let seed = in.seed * 91.0;
    var col = vec3<f32>(0.0);
    if (kind < 0.5) {
        // Cruise body: bright gunmetal airframe, sun-lit top, dark belly.
        // Boosted well above the old 0.55 gray so the fat dart reads at
        // combat range, with a hot orange spine stripe down both flanks.
        var body = vec3<f32>(0.85, 0.87, 0.95) * (0.65 + 0.35 * (l.y * 0.5 + 0.5));
        body *= 0.85 + 0.25 * u.sunI;
        // Spine stripe: blazing orange band along the flanks (|y| mid).
        let spine = smoothstep(0.9, 0.2, abs(l.y)) * smoothstep(0.6, 0.9, abs(l.x));
        body = mix(body, vec3<f32>(1.5, 0.45, 0.05) * 1.4, clamp(spine, 0.0, 1.0) * 0.85);
        // Panel seams down the flank.
        let seam = step(0.96, fract(w.x * 0.5 + w.y * 0.35 + seed));
        body *= 1.0 - seam * 0.25;
        // White-hot nose tip (+z end).
        let nose = smoothstep(0.45, 0.95, l.z);
        body = mix(body, vec3<f32>(1.4, 1.3, 1.1), nose);
        // Exhaust flame at the tail: flickering orange-white licks.
        let fl = fbm(vec2<f32>(w.x * 0.8 + seed, w.y * 0.8 - u.time * 9.0));
        let tail = smoothstep(-0.35, -0.95, l.z);
        let flame = tail * (0.45 + 0.75 * fl);
        body = mix(body, vec3<f32>(1.3, 0.55, 0.10) * 1.6, clamp(flame, 0.0, 1.0));
        body += vec3<f32>(1.2, 1.1, 0.9) * tail * pow(fl, 3.0) * 1.2;
        // Belly beacon: red strobe blinking at ~6Hz, wide band so it
        // flashes across the whole fat belly.
        let blink = step(0.55, fract(u.time * 6.0 + fract(seed) * 7.0));
        body = mix(body, vec3<f32>(1.6, 0.08, 0.05), step(l.y, -0.45) * blink * 0.9);
        col = body;
    } else if (kind < 2.5) {
        let uv = in.uv;
        let r = length(uv);
        let age = in.age;
        let gkey = hash21(floor(w.xy * 0.05) + floor(u.time * 24.0) + seed);
        var alpha = 0.0;
        if (kind < 1.5) {
            // Fireball: domain-warped churn, hottest in the middle,
            // eroding to sparks at the rim, dead by ~1.2s.
            let w1 = fbm(uv * 2.0 + seed);
            let dom = uv * 2.4 + vec2<f32>(w1 - 0.5, -age * 2.2) * 1.6;
            let n = fbm(dom + seed * 3.1);
            var temp = (1.0 - age / 1.2) * 0.9 + (n - 0.5) * 0.7 + (1.0 - r) * 0.45;
            col = ramp(clamp(temp, 0.0, 1.0)) * 2.4;
            alpha = smoothstep(1.0, 0.4, r + (n - 0.5) * 1.1) * step(age, 1.2);
        } else {
            // Shock ring: thin bright front racing out, faint disc inside.
            let fr = 0.12 + age * 0.9;
            let ring = exp(-pow((r - fr) * 9.0, 2.0));
            let a = ring * (1.0 - age / 0.9) + smoothstep(fr, 0.0, r) * 0.10 * (1.0 - age / 0.9);
            col = vec3<f32>(1.25, 1.12, 0.95) * 1.6;
            alpha = a * step(age, 0.9);
            if (alpha < 0.01) { discard; }
        }
        if (alpha <= 0.0) { discard; }
        if (gkey > alpha) { discard; }
    } else {
        // Zombie launcher missile: rust airframe, blood-red nose,
        // sickly green exhaust flame, red strobe belly.
        var zbody = vec3<f32>(0.42, 0.15, 0.09) * (0.65 + 0.35 * (l.y * 0.5 + 0.5));
        zbody *= 0.85 + 0.25 * u.sunI;
        let zstripe = smoothstep(0.9, 0.2, abs(l.y)) * smoothstep(0.6, 0.9, abs(l.x));
        zbody = mix(zbody, vec3<f32>(0.25, 1.3, 0.15) * 1.4, clamp(zstripe, 0.0, 1.0) * 0.85);
        let zseam = step(0.96, fract(w.x * 0.5 + w.y * 0.35 + seed));
        zbody *= 1.0 - zseam * 0.25;
        let znose = smoothstep(0.45, 0.95, l.z);
        zbody = mix(zbody, vec3<f32>(1.6, 0.08, 0.05), znose);
        let zfl = fbm(vec2<f32>(w.x * 0.8 + seed, w.y * 0.8 - u.time * 9.0));
        let ztail = smoothstep(-0.35, -0.95, l.z);
        let zflame = ztail * (0.45 + 0.75 * zfl);
        zbody = mix(zbody, vec3<f32>(0.45, 1.4, 0.25) * 1.6, clamp(zflame, 0.0, 1.0));
        zbody += vec3<f32>(0.8, 1.3, 0.6) * ztail * pow(zfl, 3.0) * 1.2;
        let zblink = step(0.55, fract(u.time * 6.0 + fract(seed) * 7.0));
        zbody = mix(zbody, vec3<f32>(1.6, 0.08, 0.05), step(l.y, -0.45) * zblink * 0.9);
        col = zbody;
    }
    // Missiles + booms sink into the same purple night haze as the world.
    let camXZ = vec2<f32>(u.camX, u.camZ);
    let dist = length(w.xz - camXZ);
    var f = 1.0 - exp(-dist * dist * 0.00000025);
    f *= exp(-max(w.y - 2.0, 0.0) * 0.05);
    col = mix(col, vec3<f32>(0.13, 0.06, 0.20), clamp(f, 0.0, 1.0));
    return vec4<f32>(col, 1.0);
}
