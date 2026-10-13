// Tunnel pipeline: Level 2 HAUNTED TUNNEL - the road down to hell.
// Same 80-byte UBO prefix as every other pipeline. Verts are
// pos + color + phase. Circular tube, hell skin done per-pixel:
// charred black-red rock, throbbing magma veins, lava bands, flame
// licks racing down the bore toward the jet, ember sparks, deep
// hellglow from below. Bright on purpose: the fire lights the run.
struct VertexIn {
    @location(0) pos: vec3<f32>,
    @location(1) col: vec3<f32>,
    @location(2) phase: f32,
};

struct VertexOutput {
    @builtin(position) clip: vec4<f32>,
    @location(0) color: vec3<f32>,
    @location(1) world: vec3<f32>,
    @location(2) phase: f32,
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
    var p = in.pos;
    // faint breathing so the bore feels alive, never moves the walls
    p.x += sin(u.time * 0.7 + in.pos.z * 0.001 + in.phase * 5.0) * 6.0;
    p.y += cos(u.time * 0.6 + in.pos.z * 0.0013 + in.phase * 3.0) * 6.0;
    out.clip = u.mvp * vec4<f32>(p, 1.0);
    out.color = in.col;
    out.world = p;
    out.phase = in.phase;
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

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let eye = vec3<f32>(u.eye.x, u.eye.y, u.eye.z);
    let v = normalize(eye - in.world);
    var faceN = normalize(cross(dpdx(in.world), dpdy(in.world)));
    if (dot(faceN, v) < 0.0) { faceN = -faceN; }
    // charred base, black with a red-hot core
    var col = vec3<f32>(0.09, 0.015, 0.01);
    // large scorched blotches down the bore
    let blotch = vnoise(vec2<f32>(in.world.z * 0.004, in.world.y * 0.01 + in.world.x * 0.01));
    let blotch2 = vnoise(vec2<f32>(in.world.z * 0.0016 + 7.0, in.world.x * 0.006 - in.world.y * 0.006));
    col += vec3<f32>(0.25, 0.02, 0.0) * smoothstep(0.55, 0.9, blotch2) * 0.6;
    // magma veins splitting the rock, white-hot at the core
    let vein = vnoise(vec2<f32>(in.world.z * 0.015 - u.time * 0.7, (in.world.x + in.world.y) * 0.02));
    let crack = smoothstep(0.5, 0.92, vein);
    col += mix(vec3<f32>(0.9, 0.12, 0.0), vec3<f32>(1.0, 0.85, 0.3), crack * crack) * crack * 2.2;
    // lava bands ringing the bore every ~800u, slowly throbbing
    let band = pow(0.5 + 0.5 * sin(in.world.z * 0.008 + blotch * 4.0 + u.time * 1.5), 4.0);
    col += vec3<f32>(0.85, 0.1, 0.0) * band * 0.9;
    // flame licks racing down-course toward the jet
    let lick = pow(vnoise(vec2<f32>((in.world.x + in.world.y) * 0.035, in.world.z * 0.012 - u.time * 2.2)), 5.0);
    col += vec3<f32>(1.0, 0.32, 0.02) * lick * 1.8;
    // rising embers / sparks
    let spark = pow(vnoise(vec2<f32>(in.world.x * 0.09 + in.world.y * 0.07, in.world.z * 0.03 - u.time * 3.0)), 8.0);
    col += vec3<f32>(1.0, 0.6, 0.1) * spark * 2.5;
    // hellfire flicker crawling down-course
    let fl = 0.6 + 0.4 * sin(u.time * 9.0 + in.world.z * 0.05) * sin(u.time * 13.0 + in.world.y * 0.1);
    col *= 0.9 + 0.35 * fl * (0.4 + band);
    // hot underlight so the bore keeps volume, coals below
    let l = normalize(vec3<f32>(0.22, 0.38, 0.90));
    let ndl = max(dot(faceN, l), 0.0);
    col *= 0.7 + 0.5 * ndl;
    return vec4<f32>(col, 1.0);
}
