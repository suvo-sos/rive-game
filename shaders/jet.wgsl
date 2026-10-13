// Jet pipeline: a real-time lit fighter for the GPU Canvas.
// Normal-based moonlight key + purple-sky hemisphere ambient, Blinn-Phong
// metal specular, fresnel rim, refractive-look glass canopy, object-space
// panel seams + weathering, emissive afterburner / nav lights / strobe.
// Vertex buffers come from game.luau buildHero (pos + normal + color + local).
struct VertexIn {
    @location(0) pos: vec3<f32>,
    @location(1) nrm: vec3<f32>,
    @location(2) col: vec3<f32>,
    @location(3) local: vec3<f32>,
};

struct VertexOutput {
    @builtin(position) clip: vec4<f32>,
    @location(0) color: vec3<f32>,
    @location(1) normal: vec3<f32>,
    @location(2) world: vec3<f32>,
    @location(3) local: vec3<f32>,
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
    // Afterburner churn: plume verts (blue marker band) shiver along their
    // normals, growing toward the tip, stepped at 24Hz for a licking feel.
    // (hash inlined: hash21 is declared below this entry point.)
    let plumeMask = step(0.90, in.col.b) * (1.0 - step(0.25, in.col.r)) * (1.0 - step(0.55, in.col.g));
    let hq = fract(vec2<f32>(in.local.z * 9.0, floor(u.time * 24.0)) * vec2<f32>(234.34, 435.345));
    let hh = fract(hq.x + hq.y + dot(hq, hq + vec2<f32>(34.23, 34.23)));
    let p = in.pos + in.nrm * ((hh - 0.5) * 0.12 * plumeMask * in.local.z);
    out.clip = u.mvp * vec4<f32>(p, 1.0);
    out.color = in.col;
    out.normal = in.nrm;
    out.world = p;
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
    let u = f * f * (3.0 - 2.0 * f);
    let a = hash21(i);
    let b = hash21(i + vec2<f32>(1.0, 0.0));
    let c = hash21(i + vec2<f32>(0.0, 1.0));
    let d = hash21(i + vec2<f32>(1.0, 1.0));
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let sn = normalize(in.normal);
    let eye = vec3<f32>(u.eye.x, u.eye.y, u.eye.z);
    let v = normalize(eye - in.world);

    // Flat facets: face normal from screen-space derivatives, so every
    // plate shades as one crisp tone instead of a smooth pixel blob.
    // (Flipped toward the viewer; glass keeps its smooth bubble normal.)
    var faceN = normalize(cross(dpdx(in.world), dpdy(in.world)));
    if (dot(faceN, v) < 0.0) { faceN = -faceN; }

    // Material masks from the vertex-color bands (same bands as desert.wgsl).
    let isPumpkin = step(0.80, in.color.r) * step(0.30, in.color.g)
        * (1.0 - step(0.60, in.color.g)) * (1.0 - step(0.20, in.color.b));
    let isGlow = step(0.90, in.color.r) * step(0.75, in.color.g) * (1.0 - step(0.35, in.color.b));
    let isHot = step(0.95, in.color.r) * step(0.80, in.color.g)
        * step(0.18, in.color.b) * (1.0 - step(0.30, in.color.b));
    let isStrobe = step(0.90, in.color.r) * step(0.90, in.color.g) * step(0.90, in.color.b);
    let isGlass = step(0.45, in.color.r) * (1.0 - step(0.65, in.color.r))
        * step(0.65, in.color.g) * step(0.85, in.color.b);
    // Tire rubber: near-black band (intake mouths match too: matte voids).
    let isRubber = step(in.color.r, 0.12) * step(in.color.g, 0.12) * step(in.color.b, 0.16);
    // Polished metal: bright aluminum (hub rim band, chrome oleo pistons).
    let isBright = step(0.75, in.color.r) * step(0.75, in.color.g)
        * step(0.75, in.color.b) * (1.0 - isStrobe);
    let emis = max(max(isPumpkin, isGlow), max(isHot, isStrobe));
    let mMetal = (1.0 - emis) * (1.0 - isGlass) * (1.0 - isRubber);
    // Airframe lighting uses the facet normal (flat plates); canopy and
    // lamp glass keep the smooth interpolated normal (real curved glass).
    let n = normalize(mix(sn, faceN, mMetal));

    // Moon key light out of the northern sky, warm sand bounce below.
    let l = normalize(vec3<f32>(0.22, 0.38, 0.90));
    let ndl = max(dot(n, l), 0.0);
    let hemi = mix(vec3<f32>(0.34, 0.22, 0.12), vec3<f32>(0.15, 0.09, 0.27), n.y * 0.5 + 0.5);
    let moon = vec3<f32>(1.05, 1.08, 1.22) * 1.5 * u.sunI;

    // Afterburner plume: blue marker band, fully emissive. Blue-white root
    // (hottest, like the real nozzle exit) melting through gold and orange,
    // Mach-diamond shock bands racing down the core, cooling to a pale
    // shimmer that dissolves at the tip.
    let isPlume = step(0.90, in.color.b) * (1.0 - step(0.25, in.color.r)) * (1.0 - step(0.55, in.color.g));
    if (isPlume > 0.5) {
        let t = clamp(in.local.z, 0.0, 1.0);
        let isCore = 1.0 - step(0.30, in.color.g);
        // Speed heat rides the marker red channel (outer 0.13-0.24, core
        // 0.08-0.19): the tip burns from bright orange toward deep red.
        let heat = clamp(mix((in.color.r - 0.13) / 0.11, (in.color.r - 0.08) / 0.11, isCore), 0.0, 1.0);
        var grad = mix(vec3<f32>(0.82, 0.90, 1.0), vec3<f32>(1.0, 0.72, 0.22), smoothstep(0.05, 0.35, t));
        grad = mix(grad, vec3<f32>(1.0, 0.38, 0.05), smoothstep(0.30, 0.70, t));
        grad = mix(grad, mix(vec3<f32>(1.0, 0.45, 0.05), vec3<f32>(0.72, 0.07, 0.01), heat), smoothstep(0.45, 0.62, t));
        grad = mix(grad, vec3<f32>(0.72, 0.82, 1.0), smoothstep(0.58, 0.90, t));
        grad = mix(grad, vec3<f32>(1.0, 0.99, 0.95), (1.0 - smoothstep(0.0, 0.25, t)) * isCore * 0.9);
        let dia = pow(0.5 + 0.5 * sin(t * 22.0 - u.time * 26.0), 6.0) * (1.0 - t) * (1.0 - t);
        let cell = vec2<f32>(in.local.x * 2.2 + t * 4.0 - u.time * 9.0, in.local.y * 2.2 + t * 10.0 - u.time * 7.0);
        let turb = vnoise(cell * 3.0) * 0.6 + vnoise(cell * 7.0 + 13.1) * 0.4;
        var pcol = grad * (0.65 + 0.70 * turb);
        pcol += vec3<f32>(0.75, 0.85, 1.0) * dia * (0.5 + 0.5 * isCore);
        let facing = abs(dot(n, v));
        pcol *= 0.85 + 0.15 * facing;
        // Transparent-style tip: screen-door dissolve from mid-flame out,
        // grain re-rolled at 24Hz so it shimmers instead of sitting as dots.
        let fade = 1.0 - smoothstep(0.55, 1.0, t);
        if (fade < 1.0) {
            let gkey = hash21(floor(in.world.xy * 90.0) + floor(u.time * 24.0));
            if (gkey > fade) { discard; }
        }
        return vec4<f32>(pcol * 1.6, 1.0);
    }

    // Airframe detail in object space (stable while the jet moves):
    // panel seams along the fuselage + across the wings, plus cast-metal
    // weathering so big faces never read as one flat slab.
    var alb = in.color;
    let fz = fract(in.local.z * 1.4);
    let seamZ = 1.0 - smoothstep(0.015, 0.05, min(fz, 1.0 - fz));
    let fx = fract(in.local.x * 2.2 + in.local.z * 0.7);
    let seamX = 1.0 - smoothstep(0.015, 0.05, min(fx, 1.0 - fx));
    alb *= 1.0 - 0.22 * max(seamZ, seamX) * mMetal;
    let wob = hash21(floor(in.local.xz * 5.0) + in.local.y * 3.7);
    alb *= 1.0 - mMetal * (0.10 - 0.20 * wob);
    alb *= 1.0 - isRubber * 0.30 * wob; // cast-tire grain
    // Per-plate tone: top plates catch sky, sides fall darker, bellies go
    // warm from sand bounce. Stable per face (facet normal only), so plates
    // never melt into each other.
    alb *= 1.0 + mMetal * (0.10 * faceN.y - 0.05 * abs(faceN.x) - 0.03 * (1.0 - abs(faceN.y)));

    // Lit metal: moonlit diffuse + tight Blinn-Phong specular (pow 120:
    // glints snap per plate instead of smearing across the airframe).
    // Rubber gets a broad soft sheen (pow 12, smooth normals); polished
    // rim/chrome adds a hard pow-240 glint on top.
    var col = alb * (moon * ndl + hemi * 1.6);
    let h = normalize(l + v);
    let specPow = mix(120.0 + isGlass * 120.0, 12.0, isRubber);
    col += moon * pow(max(dot(n, h), 0.0), specPow) * (mMetal * 0.9 + isGlass * 1.8 + isRubber * 0.22);
    col += moon * pow(max(dot(n, h), 0.0), 240.0) * isBright * 2.2;

    // Halloween-night fresnel: purple rim on every silhouette edge.
    let fres = pow(1.0 - max(dot(n, v), 0.0), 3.0);
    col += vec3<f32>(0.38, 0.28, 0.85) * fres * (0.25 + 0.75 * max(mMetal, isGlass));

    // Canopy: deep tinted glass, sky reflected at grazing angles,
    // sun-catch glint sweeping across the bubble.
    let glassBase = vec3<f32>(0.04, 0.09, 0.20)
        + vec3<f32>(0.45, 0.60, 1.0) * fres * 1.4;
    let sweep = pow(max(0.0, sin(u.time * 2.2 + in.world.x * 1.3 + in.world.z * 1.1 + in.world.y * 2.0)), 8.0);
    col = mix(col, glassBase + vec3<f32>(1.0, 0.98, 0.92) * sweep * 1.6, isGlass);

    // Emissive dressing (unlit, like the world shader): pulsing pumpkin
    // tips, flaring afterburner cores, twinkling tail strobe.
    let flick = 0.70 + 0.30 * sin(u.time * 5.0 + in.world.x * 1.7 + in.world.z * 1.3)
        + 0.15 * sin(u.time * 17.0 + in.world.z * 9.0 + in.world.y * 6.0);
    col += vec3<f32>(1.0, 0.42, 0.08) * isPumpkin * flick * 1.4;
    let coreFlick = 0.85 + 0.30 * sin(u.time * 11.0 + in.world.x * 7.0 + in.world.y * 5.0 + in.world.z * 6.0)
        + 0.15 * sin(u.time * 23.0 + in.world.z * 13.0);
    col += vec3<f32>(1.0, 0.85, 0.30) * isGlow * (1.2 + 0.5 * sin(u.time * 7.0)) * coreFlick;
    col += vec3<f32>(1.0, 0.95, 0.55) * isHot * (0.9 + 0.4 * sin(u.time * 13.0 + in.world.z * 9.0));
    let tw = 0.55 + 0.45 * sin(u.time * 3.0 + in.world.x * 2.1 + in.world.z * 1.7);
    col += vec3<f32>(0.85, 0.90, 1.0) * isStrobe * tw * 1.6;
    // Formation (slime) lights: pale-green electroluminescent strips,
    // steady-burn like the real jet. Band dodges every other mask.
    let isSlime = step(0.50, in.color.r) * (1.0 - step(0.65, in.color.r))
        * step(0.95, in.color.g) * step(0.40, in.color.b) * (1.0 - step(0.55, in.color.b));
    col += vec3<f32>(0.45, 1.0, 0.38) * isSlime * 1.3;
    return vec4<f32>(col, 1.0);
}
