// Dead Earth Revival atmosphere: one shader, 5 location moods.
// Fullscreen triangle, no vertex buffers. Uniforms driven from game.luau.
struct VertexOutput {
    @builtin(position) position: vec4<f32>,
    @location(0) uv: vec2<f32>,
};

struct Uniforms {
    time: f32,
    location: f32, // 0 desert, 1 ocean, 2 snow, 3 jungle, 4 digital
    heroX: f32,
    heroY: f32,
    ghostX: f32,
    ghostY: f32,
    flicker: f32,
    hit: f32, // 0..1 hit flash
};

@group(0) @binding(0)
var<uniform> u: Uniforms;

@vertex
fn vs_main(@builtin(vertex_index) idx: u32) -> VertexOutput {
    var pos = array<vec2<f32>, 3>(
        vec2<f32>(-1.0, -1.0),
        vec2<f32>(3.0, -1.0),
        vec2<f32>(-1.0, 3.0),
    );
    let p = pos[idx];
    var out: VertexOutput;
    out.position = vec4<f32>(p, 0.0, 1.0);
    out.uv = p * 0.5 + vec2<f32>(0.5, 0.5);
    return out;
}

fn hash21(p: vec2<f32>) -> f32 {
    let q = fract(p * vec2<f32>(234.34, 435.345));
    let d = dot(q, q + vec2<f32>(34.23, 34.23));
    return fract(q.x + q.y + d);
}

fn vnoise(p: vec2<f32>) -> f32 {
    let i = floor(p);
    let f = fract(p);
    let s = f * f * (vec2<f32>(3.0, 3.0) - 2.0 * f);
    let a = hash21(i);
    let b = hash21(i + vec2<f32>(1.0, 0.0));
    let c = hash21(i + vec2<f32>(0.0, 1.0));
    let d = hash21(i + vec2<f32>(1.0, 1.0));
    return mix(mix(a, b, s.x), mix(c, d, s.x), s.y);
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let uv = in.uv;
    let loc = u.location;
    let aspect = vec2<f32>(1.6, 1.0);

    // Base palettes per location.
    var col = vec3<f32>(0.05, 0.04, 0.07);
    // desert
    col = mix(col, vec3<f32>(0.16, 0.10, 0.05), 1.0 - clamp(abs(loc - 0.0), 0.0, 1.0));
    // ocean
    col = mix(col, vec3<f32>(0.02, 0.09, 0.14), 1.0 - clamp(abs(loc - 1.0), 0.0, 1.0));
    // snow
    col = mix(col, vec3<f32>(0.07, 0.10, 0.16), 1.0 - clamp(abs(loc - 2.0), 0.0, 1.0));
    // jungle
    col = mix(col, vec3<f32>(0.03, 0.10, 0.05), 1.0 - clamp(abs(loc - 3.0), 0.0, 1.0));
    // digital
    col = mix(col, vec3<f32>(0.05, 0.02, 0.10), 1.0 - clamp(abs(loc - 4.0), 0.0, 1.0));

    // Sandstorm streaks (desert).
    let sand = vnoise(vec2<f32>(uv.x * 18.0 - u.time * 1.6, uv.y * 6.0)) * (1.0 - clamp(abs(loc - 0.0), 0.0, 1.0));
    // Ocean shimmer band top.
    let band = smoothstep(0.62, 0.95, uv.y) * (1.0 - clamp(abs(loc - 1.0), 0.0, 1.0));
    let ripple = 0.5 + 0.5 * sin(uv.x * 40.0 + u.time * 2.0 + sin(uv.y * 26.0 + u.time) * 1.6);
    // Snowfall.
    let snowN = hash21(vec2<f32>(floor(uv.x * 90.0), floor(uv.y * 60.0 - u.time * 6.0)));
    let snow = step(0.965, snowN) * (1.0 - clamp(abs(loc - 2.0), 0.0, 1.0));
    // Jungle spores drifting.
    let spores = vnoise(uv * vec2<f32>(9.0, 7.0) + vec2<f32>(u.time * 0.15, -u.time * 0.1)) * (1.0 - clamp(abs(loc - 3.0), 0.0, 1.0));
    // Digital grid + glitch slices.
    let grid = (step(0.96, fract(uv.x * 40.0)) + step(0.96, fract(uv.y * 24.0))) * (1.0 - clamp(abs(loc - 4.0), 0.0, 1.0));
    let slice = step(0.97, fract(uv.y * 30.0 + u.time * 3.0)) * (1.0 - clamp(abs(loc - 4.0), 0.0, 1.0));

    col += vec3<f32>(0.45, 0.30, 0.12) * sand * 0.5;
    col += vec3<f32>(0.20, 0.55, 0.75) * band * (0.25 + 0.45 * ripple);
    col += vec3<f32>(0.85, 0.92, 1.0) * snow * 0.8;
    col += vec3<f32>(0.25, 0.75, 0.35) * spores * 0.35;
    col += vec3<f32>(0.45, 0.15, 0.95) * grid * 0.35 + vec3<f32>(0.1, 0.9, 1.0) * slice * 0.5;

    // Hero torch pool + ghost glow.
    let heroUv = vec2<f32>(u.heroX, 1.0 - u.heroY);
    let ghostUv = vec2<f32>(u.ghostX, 1.0 - u.ghostY);
    let dHero = length((uv - heroUv) * aspect);
    let dGhost = length((uv - ghostUv) * aspect);
    col = mix(col, vec3<f32>(1.0, 0.62, 0.25), (1.0 - smoothstep(0.0, 0.30 * u.flicker + 0.08, dHero)) * 0.35);
    let pulse = 0.5 + 0.5 * sin(u.time * 5.0);
    col += vec3<f32>(0.55, 0.2, 0.75) * exp(-dGhost * 6.0) * (0.4 + 0.4 * pulse);

    // Hit flash + vignette.
    col = mix(col, vec3<f32>(1.0, 0.15, 0.12), clamp(u.hit, 0.0, 1.0) * 0.45);
    let vig = smoothstep(0.55, 1.15, length((uv - vec2<f32>(0.5, 0.5)) * aspect));
    col = mix(col, vec3<f32>(0.02, 0.0, 0.03), vig * 0.45);

    var alpha = 0.32 + vig * 0.18 + clamp(u.hit, 0.0, 1.0) * 0.25;
    alpha += sand * 0.12 + band * 0.10 + snow * 0.20 + spores * 0.10 + grid * 0.12 + slice * 0.25;
    alpha = clamp(alpha, 0.0, 0.85);
    return vec4<f32>(col, alpha);
}
