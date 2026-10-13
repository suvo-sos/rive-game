// Haunted Ship atmosphere: river fog, torch flicker, moonlight water, ghost-trail glitch.
// Fullscreen triangle, no vertex buffers. Uniforms driven from game.luau each frame.
struct VertexOutput {
    @builtin(position) position: vec4<f32>,
    @location(0) uv: vec2<f32>,
};

struct Uniforms {
    time: f32,
    sanity: f32,
    torchX: f32,
    torchY: f32,
    ghostX: f32,
    ghostY: f32,
    flicker: f32,
    pad: f32,
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
    // uv (0,0) bottom-left. Rive y is down, so flip y for game coords.
    let torchUv = vec2<f32>(u.torchX, 1.0 - u.torchY);
    let ghostUv = vec2<f32>(u.ghostX, 1.0 - u.ghostY);
    let aspect = vec2<f32>(1.6, 1.0);

    let dTorch = length((uv - torchUv) * aspect);
    let dGhost = length((uv - ghostUv) * aspect);

    // Torch pool with flicker from CPU + fine shimmer here.
    let shimmer = 0.94 + 0.06 * sin(u.time * 11.0) * sin(u.time * 5.7 + 1.3);
    let radius = 0.34 * u.flicker * shimmer + 0.04;
    let dark = smoothstep(radius, radius + 0.42, dTorch);

    // Fog: two drifting noise octaves, thicker low + edges.
    let f1 = vnoise(uv * vec2<f32>(7.0, 5.0) + vec2<f32>(u.time * 0.12, u.time * 0.05));
    let f2 = vnoise(uv * vec2<f32>(14.0, 11.0) - vec2<f32>(u.time * 0.21, u.time * 0.13));
    var fog = f1 * 0.65 + f2 * 0.35;
    fog *= 0.45 + 0.55 * smoothstep(0.75, 0.15, uv.y);
    fog += 0.25 * smoothstep(0.55, 1.05, length((uv - vec2<f32>(0.5, 0.5)) * aspect));

    // Moonlight river band (top of screen = high uv.y).
    let river = smoothstep(0.68, 0.92, uv.y);
    let ripple = 0.5 + 0.5 * sin(uv.x * 46.0 + u.time * 2.2 + sin(uv.y * 30.0 + u.time) * 1.5);
    let moon = river * (0.35 + 0.65 * ripple * fog);

    // Ghost trail + glitch slice.
    let pulse = 0.5 + 0.5 * sin(u.time * 6.0);
    let glow = exp(-dGhost * 7.0) * (0.45 + 0.55 * pulse);
    let slice = step(0.965, fract(uv.y * 28.0 + u.time * 2.7 + hash21(vec2<f32>(floor(uv.y * 28.0), 1.0)) * 2.0));
    let glitch = slice * exp(-dGhost * 3.0) * 0.6;

    let insanity = clamp(1.0 - u.sanity / 100.0, 0.0, 1.0);
    let vig = smoothstep(0.55, 1.15, length((uv - vec2<f32>(0.5, 0.5)) * aspect));

    var col = vec3<f32>(0.03, 0.06, 0.11);
    col += vec3<f32>(0.35, 0.48, 0.62) * fog * 0.45;
    col += vec3<f32>(0.55, 0.75, 1.0) * moon * 0.35;
    col = mix(col, vec3<f32>(1.0, 0.72, 0.38), (1.0 - dark) * 0.55);
    col += vec3<f32>(0.45, 0.95, 1.0) * (glow * 0.8 + glitch);
    col = mix(col, vec3<f32>(0.55, 0.06, 0.09), insanity * (0.25 + 0.55 * vig));

    var alpha = 0.18 + dark * 0.52 + fog * 0.22 + vig * 0.12 + insanity * 0.18;
    alpha += glow * 0.25 + glitch * 0.4 + moon * 0.12;
    // Keep torch core readable.
    alpha *= smoothstep(0.0, 0.14, dTorch) * 0.9 + 0.1;
    alpha = clamp(alpha, 0.0, 0.88);
    return vec4<f32>(col, alpha);
}
