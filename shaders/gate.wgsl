// Gate pipeline: Level 2 HAUNTED CIRCUS parkour blocks + dotted line.
// Same 80-byte UBO prefix as every other pipeline, so the shared uniform
// buffer feeds it. Verts are pos + color + phase (one seed per gate).
// Chunky theme-colored spinning blocks; the ring STATE rides
// the phase seed (seed + state*100, decoded here): upcoming runs bright
// with a violet aura, the live block burns white-hot, cleared blocks keep
// their bright theme color. Dotted-line cubes ride state 3 (plain steady).
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
    let st = floor(in.phase / 100.0);
    let seed = in.phase - st * 100.0;
    // Rings bob; plain slabs (landing strip) sit still.
    p.y += sin(u.time * 1.3 + seed * 7.0) * 3.0 * (1.0 - step(2.5, st));
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

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let eye = vec3<f32>(u.eye.x, u.eye.y, u.eye.z);
    let v = normalize(eye - in.world);
    var faceN = normalize(cross(dpdx(in.world), dpdy(in.world)));
    if (dot(faceN, v) < 0.0) { faceN = -faceN; }

    // State from the seed: 0 upcoming, 1 live, 2 cleared, 3+ plain slab.
    let st = floor(in.phase / 100.0);
    let seed = in.phase - st * 100.0;
    let isLive = step(0.5, st) * (1.0 - step(1.5, st));
    let isDone = step(1.5, st) * (1.0 - step(2.5, st));
    let isPlain = step(2.5, st);

    // Pumpkin ember-orange boxes flicker like candles.
    let isFlame = step(0.80, in.color.r) * step(0.30, in.color.g)
        * (1.0 - step(0.60, in.color.g)) * (1.0 - step(0.20, in.color.b));

    // Moon key + purple-sky hemisphere, same night as everything else.
    let l = normalize(vec3<f32>(0.22, 0.38, 0.90));
    let ndl = max(dot(faceN, l), 0.0);
    let hemi = mix(vec3<f32>(0.34, 0.22, 0.12), vec3<f32>(0.15, 0.09, 0.27), faceN.y * 0.5 + 0.5);
    let moon = vec3<f32>(1.05, 1.08, 1.22) * 1.5 * u.sunI;
    var col = in.color * (moon * ndl + hemi * 1.6);

    let fl = hash21(floor(in.world.xy * 2.0) + floor(u.time * 9.0) * 0.37 + seed) * 0.6
        + hash21(floor(in.world.zy * 3.0) - floor(u.time * 13.0) * 0.53) * 0.4;
    col += vec3<f32>(1.0, 0.42, 0.08) * isFlame * (1.0 + 1.2 * fl);

    // Upcoming: light dim only (bright Halloween paint must read for
    // miles), violet fresnel aura on the silhouette.
    // Plain slabs skip every state effect.
    col *= 1.0 - (1.0 - isLive) * (1.0 - isDone) * (1.0 - isPlain) * 0.30;
    let fres = pow(1.0 - max(dot(faceN, v), 0.0), 3.0);
    col += vec3<f32>(0.45, 0.25, 0.95) * fres * (1.0 - isLive) * (1.0 - isDone) * (1.0 - isPlain) * 0.9;

    // Live gate: white-hot pulse + white core, visible for miles.
    let pulse = 0.5 + 0.5 * sin(u.time * 6.0 + seed * 9.0);
    col += vec3<f32>(1.0, 0.97, 0.90) * isLive * (1.2 + 1.6 * pulse);

    // Dotted-line cubes: bright green glow, readable for miles.
    col += vec3<f32>(0.12, 1.0, 0.20) * isPlain * 1.8;

    // Rock-wall texture: coursed stone blocks on every standing ring
    // (state 2 = all wall obstacles), tinted by each wall's own pop color.
    // Brick courses run in the wall face plane (world xy), with dark mortar
    // joints, per-block tone variation, stone speckle, and a chiseled
    // top-edge highlight. The portal (state 1) keeps its clean glow.
    let isWall = isDone;
    let rowH = 95.0;
    let colW = 150.0;
    let wrow = floor((in.world.y + 10000.0) / rowH);
    let wshift = (wrow - floor(wrow / 2.0) * 2.0) * colW * 0.5;
    let wcol = floor((in.world.x + wshift + 10000.0) / colW);
    let wfx = fract((in.world.x + wshift + 10000.0) / colW);
    let wfy = fract((in.world.y + 10000.0) / rowH);
    let wex = min(wfx, 1.0 - wfx) * colW;
    let wey = min(wfy, 1.0 - wfy) * rowH;
    let mortar = 1.0 - step(7.0, wex) * step(8.0, wey);
    let wtone = hash21(vec2<f32>(wcol, wrow)) * 0.35;
    let wsp = hash21(floor(in.world.xy * 0.35) + seed);
    var wallC = col;
    wallC *= 0.82 + wtone;
    wallC *= 1.0 - mortar * 0.45;
    wallC *= 0.90 + wsp * 0.20;
    wallC += vec3<f32>(0.10, 0.08, 0.06) * (1.0 - mortar) * step(0.75, wfy);
    col = mix(col, wallC, isWall);

    // Cleared: keeps its bright theme color — no change after passing.
    return vec4<f32>(col, 1.0);
}
