// Nuke pipeline: the GIGA atom bomb as GPU-driven fire.
// The chunk boxes read as debris; the explosion itself lives here: eight
// camera-facing billboards staged once at detonation (center + kind +
// size + birth in the verts, everything else animated by u.time) —
// white-out core flash, churning blackbody fireball, rising mushroom stem
// + rolling cap lit from below, expanding shock rings, lingering smoke.
// Opaque pipeline: soft edges via screen-space dither (plume precedent).
// 12-float verts (pos + col + info + local), full 96-byte UBO (eye tail
// for the billboard basis), same bind as sand/jet.
struct VertexIn {
    @location(0) pos: vec3<f32>, // billboard center (world)
    @location(1) col: vec3<f32>, // kind, size, seed
    @location(2) info: vec3<f32>, // birth, half-x, half-y
    @location(3) local: vec3<f32>, // corner signs (cx, cy, 0)
};

struct VertexOutput {
    @builtin(position) clip: vec4<f32>,
    @location(0) uv: vec2<f32>,
    @location(1) age: f32,
    @location(2) kind: f32,
    @location(3) seed: f32,
    @location(4) world: vec3<f32>,
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
    let size = in.col.y;
    let seed = in.col.z;
    let birth = in.info.x;
    let age = max(u.time - birth, 0.0);
    // Per-kind growth + rise: the flash snaps huge and dies, the fireball
    // swells and climbs, stem + cap rise as they spread, rings race out.
    var grow = 1.0;
    var rise = 0.0;
    if (kind < 0.5) { // flash
        grow = 0.3 + min(age * 5.0, 2.2);
    } else if (kind < 1.5) { // fireball
        grow = 0.4 + min(age * 0.9, 1.6);
        rise = age * 120.0;
    } else if (kind < 2.5) { // stem
        grow = 0.6 + min(age * 0.25, 0.9);
        rise = age * 300.0;
    } else if (kind < 3.5) { // cap
        grow = 0.5 + min(age * 0.35, 1.3);
        rise = age * 200.0;
    } else if (kind < 4.5) { // shock
        grow = 0.2 + age * 2.2;
        rise = 100.0;
    } else { // smoke
        grow = 0.7 + min(age * 0.2, 0.8);
        rise = age * 150.0;
    }
    let center = in.pos + vec3<f32>(0.0, rise, 0.0);
    // Camera-facing basis from the UBO eye tail (jet.wgsl precedent).
    let toEye = u.eye - center;
    let fwd = toEye / max(length(toEye), 0.001);
    var right = cross(vec3<f32>(0.0, 1.0, 0.0), fwd);
    right = right / max(length(right), 0.001);
    let upv = cross(fwd, right);
    let world = center + (right * in.local.x * in.info.y
        + upv * in.local.y * in.info.z) * grow;
    out.clip = u.mvp * vec4<f32>(world, 1.0);
    out.uv = vec2<f32>(in.local.x, in.local.y);
    out.age = age;
    out.kind = kind;
    out.seed = seed + size * 0.001;
    out.world = world;
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

fn fbm3(p: vec2<f32>) -> f32 {
    return vnoise(p) * 0.55 + vnoise(p * 2.13 + 7.7) * 0.28 + vnoise(p * 4.41 + 3.1) * 0.17;
}

fn fbm5(p: vec2<f32>) -> f32 {
    return vnoise(p) * 0.45 + vnoise(p * 2.13 + 7.7) * 0.25
        + vnoise(p * 4.41 + 3.1) * 0.15 + vnoise(p * 8.7 + 5.3) * 0.10
        + vnoise(p * 17.3 + 9.1) * 0.05;
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
    let age = in.age;
    let kind = in.kind;
    let uv = in.uv;
    let r = length(uv);
    // Screen-door dither key, re-rolled at 24Hz (plume precedent).
    let gkey = hash21(floor(in.world.xy * 0.05) + floor(u.time * 24.0) + in.seed * 91.0);
    var col = vec3<f32>(0.0);
    var alpha = 0.0;
    if (kind < 0.5) {
        // CORE FLASH: full white that blows out then dies inside ~1.2s.
        let i = 10.0 * exp(-age * 3.5);
        alpha = smoothstep(1.0, 0.4, r) * step(age, 1.4);
        col = vec3<f32>(1.5, 1.45, 1.35) * i;
        if (alpha <= 0.0 || i < 0.02) { discard; }
    } else if (kind < 1.5) {
        // FIREBALL: domain-warped churn scrolling upward, hottest in the
        // middle, eroding to sparks at the rim, dying to smoke by ~5s.
        let w1 = fbm5(uv * 2.0 + in.seed * 17.0);
        let dom = uv * 2.4 + vec2<f32>(w1 - 0.5, -age * 0.9) * 1.6;
        let n = fbm5(dom + vec2<f32>(0.0, -age * 1.4) + in.seed * 31.0);
        var temp = (1.0 - age / 5.0) * 0.85 + (n - 0.5) * 0.7 + (1.0 - r) * 0.45;
        col = ramp(clamp(temp, 0.0, 1.0)) * 2.4;
        alpha = smoothstep(1.0, 0.45, r + (n - 0.5) * 1.1) * step(age, 6.0);
    } else if (kind < 2.5) {
        // MUSHROOM STEM: vertical streaks racing up, fire at the base
        // going to brown smoke as it climbs and ages.
        let s = fbm3(vec2<f32>(uv.x * 3.0 + in.seed * 13.0, uv.y * 1.2 - age * 1.3));
        let s2 = fbm3(vec2<f32>(uv.x * 7.0 - in.seed * 7.0, uv.y * 3.0 - age * 2.6));
        var temp = (1.0 - age / 6.0) * (0.4 + s * 0.7 + (1.0 - uv.y) * 0.35);
        var c = ramp(clamp(temp, 0.0, 1.0));
        c = mix(c, vec3<f32>(0.30, 0.18, 0.12) * (0.5 + s2), clamp(age / 6.0, 0.0, 1.0));
        col = c * 2.0;
        alpha = smoothstep(1.0, 0.35, abs(uv.x) + (s2 - 0.5) * 0.8) * step(age, 8.0);
    } else if (kind < 3.5) {
        // MUSHROOM CAP: rolling boil (uv rotated by radius), lit orange
        // from the fire below, smoking out over ~8s.
        let ang = r * 2.5 + in.seed * 6.28 + age * 0.5;
        let ca = cos(ang);
        let sa = sin(ang);
        let ruv = vec2<f32>(uv.x * ca - uv.y * sa, uv.x * sa + uv.y * ca);
        let n = fbm5(ruv * 2.6 + vec2<f32>(0.0, -age * 0.7) + in.seed * 23.0);
        var temp = (1.0 - age / 7.0) * (0.55 + (n - 0.5) * 0.8);
        var c = ramp(clamp(temp, 0.0, 1.0));
        c += vec3<f32>(1.0, 0.35, 0.05) * (1.0 - uv.y) * 0.6 * exp(-age * 0.8);
        c = mix(c, vec3<f32>(0.28, 0.17, 0.12), clamp(age / 7.0, 0.0, 1.0));
        col = c * 2.0;
        alpha = smoothstep(1.05, 0.5, r + (n - 0.5) * 1.0) * step(age, 9.0);
    } else if (kind < 4.5) {
        // SHOCK RING: thin bright front racing out, faint dust disc inside.
        let fr = 0.12 + age * 0.55;
        let ring = exp(-pow((r - fr) * 9.0, 2.0));
        let a = ring * (1.0 - age / 2.2) + smoothstep(fr, 0.0, r) * 0.10 * (1.0 - age / 2.2);
        col = vec3<f32>(1.25, 1.12, 0.95) * 1.6;
        alpha = a * step(age, 2.2);
        if (alpha < 0.01) { discard; }
    } else {
        // LINGERING SMOKE: dark boil, warm-lit from below while young.
        let n = fbm5(uv * 2.2 + in.seed * 11.0 + vec2<f32>(0.0, -age * 0.4));
        var c = mix(vec3<f32>(0.10, 0.07, 0.06), vec3<f32>(0.34, 0.20, 0.12), n);
        c += vec3<f32>(1.0, 0.35, 0.06) * (1.0 - uv.y) * 0.5 * exp(-age * 0.8);
        col = c;
        alpha = 0.85 * smoothstep(1.05, 0.5, r + (n - 0.5) * 0.9) * (1.0 - age / 11.0) * step(age, 11.0);
    }
    if (alpha <= 0.0) { discard; }
    if (gkey > alpha) { discard; }
    return vec4<f32>(col, 1.0);
}
