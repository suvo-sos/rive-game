// Foe pipeline: floating jack-o'-lanterns for Level 1 training.
// Same 80-byte UBO prefix as every other pipeline, so the shared uniform
// buffer feeds it. Verts are pos + color + phase (one seed per pumpkin).
// Moonlit rind, breathing inner glow, candle-flicker face, violet float aura.
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
    // VOIDPUS PRIME: octopus legs writhe in WGSL so the bottom monster
    // swims even when the CPU frame holds still. Tentacle verts only.
    var p = in.pos;
    let isTentV = step(0.35, in.col.r) * (1.0 - step(0.50, in.col.r)) * step(0.08, in.col.g) * (1.0 - step(0.20, in.col.g)) * step(0.55, in.col.b) * (1.0 - step(0.70, in.col.b));
    let wphase = in.phase * 7.0 + in.pos.y * 0.02 + in.pos.x * 0.015;
    p.x += isTentV * sin(u.time * 3.1 + wphase) * 18.0;
    p.z += isTentV * cos(u.time * 2.3 + wphase * 1.3) * 18.0;
    p.y += isTentV * sin(u.time * 4.2 + wphase * 2.0) * 8.0;
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

    // Material masks from the vertex-color bands.
    let isFace = step(0.90, in.color.r) * step(0.75, in.color.g) * (1.0 - step(0.35, in.color.b));
    let isBody = step(0.60, in.color.g) * (1.0 - step(0.40, in.color.r))
        * (1.0 - step(0.35, in.color.b));
    let isGhost = step(0.80, in.color.r) * step(0.90, in.color.g) * step(0.80, in.color.b);
    // Level 3 Rotten Court bands (disjoint from face/body/ghost by design).
    let isBruise = step(0.50, in.color.r) * (1.0 - step(0.70, in.color.r))
        * (1.0 - step(0.40, in.color.g)) * step(0.70, in.color.b); // cackler purple
    let isBlood = step(0.80, in.color.r) * (1.0 - step(0.30, in.color.g))
        * (1.0 - step(0.30, in.color.b)); // spitter blood-red
    let isRust = step(0.80, in.color.r) * step(0.35, in.color.g)
        * (1.0 - step(0.60, in.color.g)) * (1.0 - step(0.25, in.color.b)); // brute rust
    let isHell = step(0.95, in.color.r) * step(0.45, in.color.g)
        * (1.0 - step(0.60, in.color.g)) * (1.0 - step(0.10, in.color.b)); // hell-pumpkin: hotter rind
    let isGold = step(0.95, in.color.r) * step(0.55, in.color.g)
        * (1.0 - step(0.75, in.color.g)) * (1.0 - step(0.25, in.color.b)); // prime crown
    let isBone = step(0.85, in.color.r) * step(0.78, in.color.g)
        * (1.0 - step(0.90, in.color.g)) * step(0.55, in.color.b)
        * (1.0 - step(0.75, in.color.b)); // prime bone horns
    // VOIDPUS PRIME bands: purple pumpkin head + octopus legs + suckers.
    // All disjoint from face/body/ghost/bruise/blood/rust/hell/gold/bone.
    let isPurple = step(0.70, in.color.r) * (1.0 - step(0.90, in.color.r))
        * step(0.10, in.color.g) * (1.0 - step(0.30, in.color.g))
        * step(0.85, in.color.b); // purple pumpkin rind
    let isTent = step(0.35, in.color.r) * (1.0 - step(0.50, in.color.r))
        * step(0.08, in.color.g) * (1.0 - step(0.20, in.color.g))
        * step(0.55, in.color.b) * (1.0 - step(0.70, in.color.b)); // octopus legs
    let isSuck = step(0.95, in.color.r) * step(0.55, in.color.g)
        * (1.0 - step(0.70, in.color.g)) * step(0.70, in.color.b)
        * (1.0 - step(0.85, in.color.b)); // leg suckers, pale pink
    let isStem = (1.0 - isFace) * (1.0 - isBody) * (1.0 - isGhost)
        * (1.0 - isBruise) * (1.0 - isBlood) * (1.0 - isRust)
        * (1.0 - isHell) * (1.0 - isGold) * (1.0 - isBone)
        * (1.0 - isPurple) * (1.0 - isTent) * (1.0 - isSuck);

    // Moon key + purple-sky hemisphere, same night as the jet.
    let l = normalize(vec3<f32>(0.22, 0.38, 0.90));
    let ndl = max(dot(faceN, l), 0.0);
    let hemi = mix(vec3<f32>(0.34, 0.22, 0.12), vec3<f32>(0.15, 0.09, 0.27), faceN.y * 0.5 + 0.5);
    let moon = vec3<f32>(1.05, 1.08, 1.22) * 1.5 * u.sunI;
    var col = in.color * (moon * ndl + hemi * 1.6);

    // Rind glow: the whole pumpkin breathes, each on its own phase.
    let breath = 0.5 + 0.5 * sin(u.time * 2.6 + in.phase * 7.0);
    col += vec3<f32>(0.25, 1.0, 0.30) * isBody * (0.45 + 0.85 * breath);
    // Lit from within: up-facing rind burns brighter, belly stays dark.
    col += vec3<f32>(0.40, 1.0, 0.35) * isBody * max(faceN.y, 0.0) * (0.4 + 0.6 * breath);

    // Carved face: candlelight flicker, hot white core on the peaks.
    let fl = hash21(floor(in.world.xy * 3.0) + floor(u.time * 9.0) * 0.37 + in.phase)
        * 0.6 + hash21(floor(in.world.zy * 5.0) - floor(u.time * 13.0) * 0.53) * 0.4;
    col += vec3<f32>(1.0, 0.80, 0.25) * isFace * (1.3 + 1.5 * fl);
    col += vec3<f32>(1.0, 0.97, 0.88) * isFace * smoothstep(0.75, 1.0, fl) * 1.2;

    // Ghost eyes: cold white-cyan pulse, out of phase per monster.
    col += vec3<f32>(0.65, 1.0, 1.0) * isGhost * (1.1 + 0.9 * sin(u.time * 5.0 + in.phase * 9.0));

    // Rotten Court: bruise-purple rind breathes violet, blood-red cracks
    // throb, rust-orange embers flicker, prime gold burns white-hot.
    col += vec3<f32>(0.55, 0.25, 1.0) * isBruise * (0.7 + 0.7 * breath);
    let throb = 0.5 + 0.5 * sin(u.time * 3.4 + in.phase * 11.0);
    col += vec3<f32>(1.0, 0.15, 0.08) * isBlood * (0.8 + 1.2 * throb);
    col += vec3<f32>(1.0, 0.50, 0.15) * isBlood * smoothstep(0.7, 1.0, fl) * 0.8;
    col += vec3<f32>(1.0, 0.45, 0.10) * isRust * (1.0 - isHell) * (0.7 + 1.0 * fl);
    col += vec3<f32>(1.0, 0.85, 0.40) * isRust * (1.0 - isHell) * smoothstep(0.75, 1.0, fl) * 0.9;
    col += vec3<f32>(1.0, 0.55, 0.12) * isHell * (1.0 + 1.6 * fl);
    col += vec3<f32>(1.0, 0.80, 0.35) * isGold * (1.2 + 1.4 * fl);
    col += vec3<f32>(1.0, 0.97, 0.88) * isGold * smoothstep(0.7, 1.0, fl) * 1.0;
    col = mix(col, in.color * (moon * ndl * 0.8 + hemi), isBone);
    // VOIDPUS PRIME: purple pumpkin head ribbed + breathing violet,
    // lit from within on up-faces, hot white core on flicker peaks.
    let rib = 0.5 + 0.5 * sin((in.world.x + in.world.z) * 0.22 + in.phase);
    col *= 1.0 - isPurple * smoothstep(0.35, 0.95, rib) * 0.38;
    col += vec3<f32>(0.62, 0.20, 1.0) * isPurple * (0.7 + 0.9 * breath);
    col += vec3<f32>(0.75, 0.35, 1.0) * isPurple * max(faceN.y, 0.0) * (0.5 + 0.7 * breath);
    col += vec3<f32>(1.0, 0.95, 0.90) * isPurple * smoothstep(0.8, 1.0, fl) * 0.9;
    // Octopus legs: dark violet flesh, mottled crawl + wet sheen + ember veins.
    let crawl = 0.5 + 0.5 * sin(u.time * 2.2 + in.world.y * 0.05 + in.phase * 9.0);
    col += vec3<f32>(0.45, 0.15, 0.85) * isTent * (0.5 + 0.8 * crawl);
    col += vec3<f32>(0.55, 0.25, 1.0) * isTent * smoothstep(0.6, 1.0, fl) * 0.7;
    col += vec3<f32>(1.0, 0.30, 0.10) * isTent * smoothstep(0.75, 1.0, throb) * 0.35;
    // Suckers: pale pink pulse, out of phase per monster.
    col += vec3<f32>(1.0, 0.55, 0.75) * isSuck * (0.9 + 0.9 * sin(u.time * 5.0 + in.phase * 9.0));

    // Stem: dry matte stalk, kills the glow where it sits.
    col = mix(col, in.color * (moon * ndl * 0.7 + hemi), isStem);

    // Float aura: violet fresnel on the rind silhouette only.
    let fres = pow(1.0 - max(dot(faceN, v), 0.0), 3.0);
    col += vec3<f32>(0.45, 0.25, 0.95) * fres * isBody * 0.8;
    col += vec3<f32>(0.45, 0.25, 0.95) * fres * isBruise * 0.9;
    return vec4<f32>(col, 1.0);
}
