// Sand pipeline: level-3 blowing sand on its own GPU Canvas pipeline.
// Same 12-float box verts as storm (pos + color + info + local) and the
// full 96-byte UBO (reads the camera eye tail for distance softening).
// Two jobs: streaming sand sheets around the jet (runway flow, thick
// after liftoff) and a camera-pinned whiteout veil that blinds the
// screen when the jet pushes inside the storm wall.
struct VertexIn {
    @location(0) pos: vec3<f32>,
    @location(1) col: vec3<f32>,
    @location(2) info: vec3<f32>, // density 0..1, seed 0..1, kind (ignored)
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
    eye: vec3<f32>,
    level: f32,
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

fn ign(pix: vec2<f32>) -> f32 {
    return fract(52.9829189 * fract(dot(pix, vec2<f32>(0.06711056, 0.00583715))));
}

@vertex
fn vs_main(in: VertexIn) -> VertexOutput {
    var out: VertexOutput;
    // Light flutter so sheets shimmer as they stream past.
    let fl = vec3<f32>(sin(u.time * 6.0 + in.pos.x * 0.5 + in.info.y * 20.0) * 0.8, 0.0, 0.0);
    out.clip = u.mvp * vec4<f32>(in.pos + fl, 1.0);
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
    let dith = ign(floor(in.clip.xy));
    // Outflow streaks racing at the jet (-z) + churning body. Fine
    // high-frequency grain: sand reads as wisps hugging the dunes.
    let flow = u.time * (3.4 + in.info.y * 1.6);
    let s = fbm3(vec2<f32>((w.x + w.z) * 0.045 + flow + seed * 23.0, w.y * 0.20));
    let b = fbm3(vec2<f32>(w.x * 0.022 - flow * 0.6 + w.z * 0.018, w.y * 0.06 + seed * 9.0));
    var col = mix(vec3<f32>(0.34, 0.24, 0.13), vec3<f32>(0.66, 0.49, 0.28), s);
    col *= 0.55 + 0.9 * b;
    col += vec3<f32>(0.20, 0.12, 0.05) * s * b;
    // Far sheets melt away entirely (no popping at the recycle edge).
    let d = distance(w, u.eye);
    col = mix(col, vec3<f32>(0.35, 0.24, 0.30), clamp(d / 900.0, 0.0, 1.0) * 0.2);
    // Whiteout veil (density pinned to 1.0 by the CPU): solid blowing
    // sand, zero visibility — no discard, nothing shows through.
    if (in.info.x >= 0.99) {
        var vcol = mix(vec3<f32>(0.32, 0.22, 0.12), vec3<f32>(0.60, 0.44, 0.25), s);
        vcol *= 0.6 + 0.8 * b;
        vcol += (dith - 0.5) * 0.03;
        return vec4<f32>(vcol, 1.0);
    }
    // Patchy gust cores only: most of each sheet is air.
    var cov = dens * smoothstep(0.38, 0.72, s * 0.6 + b * 0.40);
    cov *= 1.0 - smoothstep(600.0, 900.0, d);
    if (cov < dith) {
        discard;
    }
    col += (dith - 0.5) * 0.03;
    return vec4<f32>(col, 1.0);
}
