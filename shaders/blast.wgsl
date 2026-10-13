// Blast pipeline: crash debris rendered as GPU-driven fire and smoke.
// Same box geometry as the world, but each vertex also carries
// (heat, seed, kind) + normalized local coords, so the fragment shader
// can shade round soft fireballs, noise-eroded flames, billowing smoke,
// glowing wreck debris, strobing sparks, and an expanding shockwave ring.
// Uniforms share the world layout (MVP + time + camera), same UBO.
struct VertexIn {
    @location(0) pos: vec3<f32>,
    @location(1) col: vec3<f32>,
    @location(2) info: vec3<f32>, // heat 0..1, seed 0..1, kind 0..7
    @location(3) local: vec3<f32>, // -1..1 box corners, for round falloff
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

@vertex
fn vs_main(in: VertexIn) -> VertexOutput {
    var out: VertexOutput;
    out.clip = u.mvp * vec4<f32>(in.pos, 1.0);
    out.color = in.col;
    out.world = in.pos;
    out.info = in.info;
    out.local = in.local;
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

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let w = in.world;
    let heat = clamp(in.info.x, 0.0, 1.0);
    let seed = in.info.y * 39.7;
    let kind = in.info.z;
    let r = length(in.local);
    var col = in.color;

    if (kind < 0.5) {
        // Fireball: blackbody ramp white -> orange -> char, tongues of
        // flame lick upward via scrolling noise, rim chars to soft round.
        let white = vec3<f32>(1.0, 0.93, 0.70);
        let orange = vec3<f32>(1.0, 0.45, 0.07);
        let char = vec3<f32>(0.30, 0.05, 0.02);
        col = mix(char, mix(orange, white, smoothstep(0.45, 0.95, heat)), smoothstep(0.0, 0.5, heat));
        let rise = fbm(w.xz * 0.22 + vec2<f32>(seed, -u.time * 1.9) + w.y * 0.18);
        let detail = fbm(w.zx * 0.55 + vec2<f32>(-u.time * 2.6, seed * 1.3));
        col *= 0.50 + 1.0 * rise;
        col *= smoothstep(0.12, 0.72, rise * 0.62 + detail * 0.38 + heat * 0.42);
        col = mix(col, vec3<f32>(0.04, 0.02, 0.02), smoothstep(0.55, 1.05, r));
        col += vec3<f32>(1.0, 0.48, 0.10) * (1.0 - smoothstep(0.0, 0.55, r)) * heat * 0.7;
        col *= 0.82 + 0.32 * sin(u.time * (9.0 + fract(seed) * 5.0) + w.x * 2.0 + w.y * 3.1);
    } else if (kind < 1.5) {
        // Bloom flash: near-white core dying fast, soft round edge.
        col = vec3<f32>(1.0, 0.88, 0.66) * (0.35 + 2.2 * heat * heat);
        col *= 1.0 - smoothstep(0.25, 1.0, r);
    } else if (kind < 2.5) {
        // Smoke: dark warm billows, mottled by slow noise, lit from above,
        // edges dissolve into the night instead of cut as boxes.
        let m = fbm(w.xz * 0.10 + w.y * 0.09 + seed + vec2<f32>(u.time * 0.22, -u.time * 0.1));
        col = mix(vec3<f32>(0.04, 0.035, 0.05), vec3<f32>(0.30, 0.26, 0.30), m);
        col *= 0.65 + 0.55 * (in.local.y * 0.5 + 0.5);
        col *= 1.0 - smoothstep(0.55, 1.0, r) * 0.75;
        col *= 0.35 + 0.65 * heat;
    } else if (kind < 3.5) {
        // Wreck debris: near-black metal, cracks glow orange while fresh,
        // faint moonlit top so tumbling chunks read in 3D.
        let cracks = fbm(w.xy * 0.9 + w.zx * 0.7 + seed * 2.0);
        col = vec3<f32>(0.025, 0.025, 0.035);
        col += vec3<f32>(1.0, 0.28, 0.04) * pow(heat, 2.0) * smoothstep(0.45, 0.85, cracks) * 1.6;
        col += vec3<f32>(0.10, 0.12, 0.18) * max(in.local.y, 0.0) * 0.6;
    } else if (kind < 4.5) {
        // Sparks: white-hot strobing embers cooling to ember-orange.
        let strobe = pow(max(0.0, sin(u.time * 34.0 + seed * 43.0)), 6.0);
        col = mix(vec3<f32>(0.9, 0.25, 0.03), vec3<f32>(1.0, 0.95, 0.70), clamp(heat + strobe * 0.5, 0.0, 1.0));
        col *= (0.6 + 1.8 * strobe) * (0.25 + heat);
    } else if (kind < 5.5) {
        // Dust ring: sand-colored ground-hugging disc, noisy broken edge.
        let rr = length(in.local.xz);
        let m = fbm(w.xz * 0.18 + seed * 3.0);
        col = vec3<f32>(0.45, 0.33, 0.21) * (0.55 + 0.7 * m);
        col *= 1.0 - smoothstep(0.45, 1.0, rr);
        col *= 0.25 + 0.75 * heat;
    } else if (kind < 6.5) {
        // Shockwave: thin bright ring racing outward, fading behind it.
        let rr = length(in.local.xz);
        let front = (1.0 - heat) * 1.15;
        let d = rr - front;
        let ring = exp(-d * d * 55.0);
        col = vec3<f32>(1.0, 0.72, 0.35) * ring * (0.3 + 1.8 * heat)
            + vec3<f32>(0.35, 0.25, 0.16) * 0.25 * (1.0 - smoothstep(0.0, 1.0, rr));
    } else if (kind < 7.5) {
        // Gun flash: small bright pop that burns OUT, never black.
        // White core -> orange -> dark ember floor, always glowing.
        let white = vec3<f32>(1.0, 0.93, 0.70);
        let orange = vec3<f32>(1.0, 0.50, 0.10);
        let ember = vec3<f32>(0.35, 0.10, 0.02);
        col = mix(ember, mix(orange, white, smoothstep(0.40, 0.90, heat)), smoothstep(0.0, 0.45, heat));
        let lick = fbm(w.xz * 0.9 + vec2<f32>(seed, -u.time * 4.0) + w.y * 0.5);
        col *= 0.60 + 0.80 * lick;
        col *= smoothstep(0.05, 0.55, lick * 0.5 + heat * 0.55);
        col = mix(col, ember * 0.7, smoothstep(0.55, 1.0, r));
        col += vec3<f32>(1.0, 0.55, 0.15) * (1.0 - smoothstep(0.0, 0.5, r)) * heat * 0.8;
        col *= 0.85 + 0.30 * sin(u.time * 31.0 + seed * 17.0);
    } else {
        // Shockwave: thin bright ring racing outward, fading behind it.
        let rr = length(in.local.xz);
        let front = (1.0 - heat) * 1.15;
        let d = rr - front;
        let ring = exp(-d * d * 55.0);
        col = vec3<f32>(1.0, 0.72, 0.35) * ring * (0.3 + 1.8 * heat)
            + vec3<f32>(0.35, 0.25, 0.16) * 0.25 * (1.0 - smoothstep(0.0, 1.0, rr));
    }

    // Distant blasts sink into the same purple night haze as the world.
    let camXZ = vec2<f32>(u.camX, u.camZ);
    let dist = length(w.xz - camXZ);
    var f = 1.0 - exp(-dist * dist * 0.00000025);
    f *= exp(-max(w.y - 2.0, 0.0) * 0.05);
    col = mix(col, vec3<f32>(0.13, 0.06, 0.20), clamp(f, 0.0, 1.0));
    return vec4<f32>(col, 1.0);
}
