// Zombie pipeline: the level-3 horde on its own GPU Canvas pipeline.
// One zombie design baked 2000 times into a single VBO — one look,
// cloned into thousands. 7-float verts (pos + color + per-body seed):
// the seed drives the run scatter so every clone fans left/right on
// its own phase while the CPU replicates the exact formula for hits.
// Same 80-byte UBO prefix.
//
// GIGA (mode 2) is a different animal on the same pipe: a Godzilla-class
// kaiju whose realism lives here, not in the boxes. The CPU stages an
// articulated frame with DRUM-built round masses (octagonal thighs,
// gut, chest, skull — boxes read square at 30x, drums read organic)
// plus detail boxes (knuckles, knees, claws); this shader turns it into
// wet rotting hide: derivative face normals + moon key + warm sand
// bounce + purple rim, multi-octave mottled flesh with brown rot blooms
// + scar tissue + pore grain, deep scale crevices, fake-bevel grazing
// falloff, wet glints, crawling magma veins (rage/flash), burning
// slit-pupil eyes, ivory teeth, dark drooling mouth, and bone spikes
// that glow at the tips when enraged.
// Horde flesh (mode < 1.5) keeps the cheap flat path — GIGA pays for
// the lighting, the horde never does.
struct VertexIn {
    @location(0) pos: vec3<f32>,
    @location(1) col: vec3<f32>,
    @location(2) seed: f32,
};

struct VertexOutput {
    @builtin(position) clip: vec4<f32>,
    @location(0) color: vec3<f32>,
    @location(1) world: vec3<f32>,
};

struct Uniforms {
    mvp: mat4x4<f32>,
    time: f32,
    camX: f32,
    sunI: f32,
    camZ: f32,
};

struct March {
    marchT: f32, // mission time of the storm break (-1 = hold position)
    speed: f32, // advance speed toward the target (u/s)
    holdR: f32, // stop ring radius around the target
    mode: f32, // 0 jet, 1 merge center, 2 hold (giant acts on CPU)
    cx: f32, // merge center x
    cz: f32, // merge center z
    rage: f32, // GIGA enrage 0/1 (mode 2 only; horde ignores it)
    flash: f32, // GIGA strike telegraph 0/1 (mode 2 only)
    doom: f32, // GIGA death 0->1 (mode 2, dying: cracks split + magma glow)
};

@group(0) @binding(0)
var<uniform> u: Uniforms;
@group(0) @binding(1)
var<uniform> z: March;

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

@vertex
fn vs_main(in: VertexIn) -> VertexOutput {
    var out: VertexOutput;
    // March: after the break (marchT >= 0) every body advances toward the
    // jet (camX/camZ) at march speed, halting in a ring of holdR around
    // it. Per-vertex dir is near-identical across one body, so clones
    // stay whole while the horde converges.
    var base = in.pos;
    // Portal keep-out: pure-white globe verts are the merge portal, not
    // bodies — they never march, weave, pump, breathe or taunt (the march
    // would crush the whole ball into a knot at the merge point).
    let isGlobeV = step(0.95, in.col.r) * step(0.95, in.col.g) * step(0.95, in.col.b);
    let gm = 1.0 - isGlobeV;
    if (z.marchT >= 0.0 && z.mode < 1.5) {
        var tgt = vec2<f32>(u.camX, u.camZ);
        if (z.mode > 0.5) {
            tgt = vec2<f32>(z.cx, z.cz);
        }
        let toTgt = vec2<f32>(tgt.x - in.pos.x, tgt.y - in.pos.z);
        let dist = max(length(toTgt), 0.001);
        // Per-body villain gait (mirrors zombieLivePos exactly): own pace,
        // own start delay — the horde breaks in waves, never one line.
        let sf = 0.7 + fract(in.seed * 5.7) * 0.6;
        let dto = in.seed * 6.0;
        let dt = max(u.time - z.marchT - dto, 0.0);
        let marStep = min(dt * z.speed * sf, max(dist - z.holdR, 0.0)) * gm;
        base.x += toTgt.x / dist * marStep;
        base.z += toTgt.y / dist * marStep;
        // Scatter run: jet-chase only, every body weaves left/right on
        // its own seed phase so the horde fans out instead of marching
        // in lines. The CPU (zombieLivePos) runs this exact formula.
        if (z.mode < 0.5) {
            let wv = sin(u.time * 1.7 + in.seed * 6.2831) * (15.0 + 30.0 * in.seed);
            base.x += -toTgt.y / dist * wv;
            base.z += toTgt.x / dist * wv;
        }
    }
    // Run cycle: limb frequency scales with march speed (capped 3x), so
    // the horde sprints instead of shuffling. Straight-line drive only —
    // vertical bob + symmetric fore-aft, near-zero lateral slide so
    // bodies never crab sideways up close.
    let h = hash21(floor(base.xz / 80.0));
    let ph = h * 6.2831;
    // Limbs run only while the horde advances; standing bodies shamble
    // in place (speed floors at 60 so planted ranks never freeze solid).
    var runK = 1.0;
    if (z.marchT >= 0.0 && z.mode < 1.5) {
        runK = min(max(z.speed, 60.0) / 60.0, 3.0);
    }
    let wstep = sin(u.time * 2.2 * runK + ph);
    let sw = vec3<f32>(
        sin(u.time * 0.9 * runK + ph) * 3.5,
        abs(wstep) * 7.5,
        wstep * 3.0);
    var moved = base + sw * gm;
    // Charge lean: the frame hurls itself at the target — steady forward
    // tilt + pumping lunge scaled by height, so feet stay planted while
    // the torso throws its weight. Kills the rigid-gliding stick look.
    if (z.marchT >= 0.0 && z.mode < 1.5) {
        var tgt2 = vec2<f32>(u.camX, u.camZ);
        if (z.mode > 0.5) { tgt2 = vec2<f32>(z.cx, z.cz); }
        let t2 = vec2<f32>(tgt2.x - base.x, tgt2.y - base.z);
        let d2 = max(length(t2), 0.001);
        let hFrac = clamp((base.y + 30.0) / 350.0, 0.0, 1.0);
        let runI = min(z.speed / 60.0, 3.0) / 3.0;
        let pump2 = sin(u.time * 2.2 * runK + ph);
        let lunge = (runI * 9.0 + pump2 * 3.0 * runI) * hFrac * gm;
        moved.x += t2.x / d2 * lunge;
        moved.z += t2.y / d2 * lunge;
        moved.y += abs(pump2) * 3.5 * runI;
        // Walk/run gait: legs drive fore/aft, arms counter-pump, feet stamp —
        // per-body gait constant from seed so the horde mixes lumbering
        // walkers with sprinters instead of stepping in sync.
        let gait = 0.7 + fract(in.seed * 7.31) * 0.6;
        let stride = sin(u.time * 2.2 * runK * gait + ph) * runI;
        let legBand = 1.0 - smoothstep(0.10, 0.35, hFrac);
        let armBand = smoothstep(0.40, 0.55, hFrac) * (1.0 - smoothstep(0.70, 0.85, hFrac));
        moved.x += t2.x / d2 * stride * 15.0 * legBand;
        moved.z += t2.y / d2 * stride * 15.0 * legBand;
        moved.x -= t2.x / d2 * stride * 12.0 * armBand;
        moved.z -= t2.y / d2 * stride * 12.0 * armBand;
        moved.y += max(stride, 0.0) * 3.5 * legBand;
    }
    // Idle life: planted ranks breathe, shift their weight and track the
    // jet with their heads — standing ground, never statues.
    if (z.marchT >= 0.0 && z.mode < 0.5 && z.speed < 1.0) {
        var htg = vec2<f32>(u.camX, u.camZ);
        let td = vec2<f32>(htg.x - base.x, htg.y - base.z);
        let tl = max(length(td), 0.001);
        let hFrac2 = clamp((base.y + 30.0) / 350.0, 0.0, 1.0);
        moved.y += sin(u.time * 1.3 + in.seed * 40.0) * 5.0
            * smoothstep(0.30, 0.55, hFrac2) * (1.0 - smoothstep(0.75, 0.95, hFrac2));
        moved.x += sin(u.time * 0.7 + in.seed * 21.0) * 3.5;
        let headBand = smoothstep(0.70, 0.85, hFrac2);
        moved.x += td.x / tl * headBand * 9.0;
        moved.z += td.y / tl * headBand * 9.0;
    }
    // Break taunt (staff opening only): ~7s after the wall falls the
    // horde jumps with its hands in the sky — a war-dance for the reveal,
    // the whole army reaching up at once.
    if (z.marchT >= 0.0 && z.mode < 0.5) {
        let tb = u.time - z.marchT;
        if (tb >= 0.0 && tb < 7.0) {
            let tenv = smoothstep(0.0, 1.0, tb) * (1.0 - smoothstep(5.0, 7.0, tb));
            let hp = abs(sin(u.time * 4.0 + in.seed * 6.2831));
            moved.y += hp * hp * 45.0 * tenv;
            moved.x += sin(u.time * 3.1 + in.seed * 9.0) * 14.0 * tenv;
            moved.z += cos(u.time * 2.3 + in.seed * 7.0) * 14.0 * tenv;
            let hFracT = clamp((base.y + 30.0) / 350.0, 0.0, 1.0);
            moved.y += smoothstep(0.45, 0.75, hFracT) * 60.0 * tenv;
        }
    }
    // GIGA fury (mode 2 only): enraged tremble shakes the whole frame,
    // and the body rears up through each strike telegraph. Plus a slow
    // breathing heave (chest rises ~14u on a 3s cycle) and micro skin
    // crawl so the hide never sits dead-still between moves.
    let giga = step(1.5, z.mode);
    moved += vec3<f32>(
        sin(u.time * 37.0 + base.y * 0.05),
        sin(u.time * 43.0 + base.x * 0.05) * 0.6,
        cos(u.time * 31.0 + base.z * 0.05)) * (giga * z.rage * 12.0);
    moved.y += giga * z.flash * 60.0;
    // Death throes (doom 0->1): violent shudder that grows as the cracks
    // spread — the body knows it's about to blow.
    moved += vec3<f32>(
        sin(u.time * 61.0 + base.y * 0.11 + base.x * 0.07),
        sin(u.time * 55.0 + base.z * 0.11) * 0.7,
        cos(u.time * 67.0 + base.x * 0.09 + base.y * 0.05)) * (giga * z.doom * 45.0);
    moved.y += giga * sin(u.time * 2.1) * 14.0 * smoothstep(400.0, 1500.0, base.y - floor(base.y / 4000.0) * 4000.0);
    moved.x += giga * (fbm3(base.xz * 0.01 + u.time * 0.6) - 0.5) * 10.0;
    moved.z += giga * (fbm3(base.zx * 0.01 - u.time * 0.5) - 0.5) * 10.0;
    out.clip = u.mvp * vec4<f32>(moved, 1.0);
    out.color = in.col;
    out.world = base;
    return out;
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let w = in.world;
    var col = in.color;
    let giga = step(1.5, z.mode);
    // ---- shared masks (horde + GIGA) ----
    // Rotting flesh: green-dominant verts get wound blotches + moonlit tops.
    let isFlesh = step(0.30, in.color.g) * (1.0 - step(0.65, in.color.g))
        * step(in.color.r, in.color.g) * (1.0 - step(0.35, in.color.b));
    // Tattered rags: dark verts stay matte, slight variation only.
    let isRag = 1.0 - isFlesh - step(0.90, in.color.g);
    // Eyes: near-white-green verts burn toxic, pulsing hard enough to
    // read across the desert. The GIGA (mode 2) burns them white-hot
    // through each telegraph and shifts them molten-red while enraged.
    let isEye = step(0.90, in.color.g) * step(0.40, in.color.r) * (1.0 - step(0.70, in.color.r));
    // Muzzle tips: hot orange verts flash with the volley cycle, staggered
    // per body — the shooting animation. Tips smoulder between volleys.
    let isTip = step(0.90, in.color.r) * step(0.40, in.color.g) * (1.0 - step(0.60, in.color.g))
        * (1.0 - step(0.20, in.color.b));
    // Magma: molten orange-red verts churn yellow-hot, cracking bright.
    let isMag = step(0.90, in.color.r) * step(0.10, in.color.g) * (1.0 - step(0.40, in.color.g))
        * (1.0 - step(0.15, in.color.b));
    // Pumpkin rind: burnt-orange shell verts (the deadly face).
    let isRind = step(0.75, in.color.r) * (1.0 - step(0.95, in.color.r))
        * step(0.20, in.color.g) * (1.0 - step(0.40, in.color.g)) * (1.0 - step(0.15, in.color.b));
    // Red eyes: ember-red glow sockets.
    let isRedEye = step(0.70, in.color.r) * (1.0 - step(0.25, in.color.g)) * (1.0 - step(0.20, in.color.b));
    // Carved maw: dark maroon mouth slit with banked ember.
    let isMaw = step(0.25, in.color.r) * (1.0 - step(0.50, in.color.r))
        * (1.0 - step(0.10, in.color.g)) * (1.0 - step(0.10, in.color.b));
    // ---- GIGA-only masks (CPU paints these bands; horde never emits them) ----
    // Teeth: warm ivory (g 0.80-0.89 stays clear of the eye band at 0.90+).
    let isTooth = step(0.80, in.color.r) * step(0.78, in.color.g) * step(0.65, in.color.b)
        * (1.0 - step(0.90, in.color.g)) * (1.0 - isFlesh) * giga;
    // Mouth: near-black red gut — the open maw interior.
    let isMouth = step(in.color.g, 0.12) * step(in.color.b, 0.12) * step(0.12, in.color.r)
        * (1.0 - step(0.35, in.color.r)) * giga;
    // Dorsal spikes: pale bone blue-gray, glow at the tips when enraged.
    let isSpike = step(0.60, in.color.b) * step(in.color.b, in.color.g + 0.15)
        * step(0.45, in.color.g) * (1.0 - isEye) * (1.0 - isTooth) * giga;

    // ================= HORDE PATH (voxel horror: Minecraft blocks, lit) =================
    // Blocky texel skin: 8u texels with per-texel tone + dark grout seams,
    // so every clone reads built from rotting cubes, not smooth plastic.
    let tex = floor(w / 8.0);
    let th = hash21(tex.xy + vec2<f32>(tex.z * 3.7, tex.z * 1.3));
    let tfr = fract(w / 8.0) - 0.5;
    let tedge = max(abs(tfr.x), max(abs(tfr.y), abs(tfr.z)));
    // Derivative face normals (GIGA precedent): flat plates light crisp.
    let eyeH = vec3<f32>(u.camX, 2000.0, u.camZ);
    let hvv = eyeH - w;
    let hvl = max(length(hvv), 0.001);
    let hv = hvv / hvl;
    var hfn = normalize(cross(dpdx(w), dpdy(w)));
    if (dot(hfn, hv) < 0.0) { hfn = -hfn; }
    let hl = normalize(vec3<f32>(0.22, 0.38, 0.90)); // moon key
    let hndl = max(dot(hfn, hl), 0.0);
    let hwrap = clamp((dot(hfn, hl) + 0.6) / 1.6, 0.0, 1.0);
    let wound = fbm3(w.xz * 0.35 + w.y * 0.3);
    var horde = col;
    horde *= 0.80 + th * 0.40; // texel tone drift
    horde *= 1.0 - smoothstep(0.36, 0.5, tedge) * 0.38; // grout seams
    horde *= 1.0 - isFlesh * smoothstep(0.55, 0.85, wound) * 0.55; // rot blotches
    // Rags: faded cloth patches + woven thread grain.
    let weave = sin(w.x * 2.1) * sin(w.y * 2.3 + 1.0) * sin(w.z * 1.9 + 2.0);
    horde *= 1.0 - clamp(isRag, 0.0, 1.0) * th * 0.30;
    horde *= 1.0 + clamp(isRag, 0.0, 1.0) * weave * 0.07;
    // Lit like the world: moon key + wrap fill + sky-lit crown.
    var hlight = 0.38 + 0.85 * hwrap + 0.50 * hndl;
    hlight *= 0.72 + 0.42 * clamp(hfn.y * 0.5 + 0.5, 0.0, 1.0);
    horde *= hlight;
    let hrim = pow(1.0 - abs(dot(hfn, hv)), 3.0);
    horde += vec3<f32>(0.45, 0.20, 0.75) * hrim * 0.30; // faint violet rim
    // Pumpkin rind: ribbed shell grooves + candle-lit inner glow, breathing ember.
    let rib = 0.5 + 0.5 * sin((w.x + w.z) * 0.22);
    horde *= 1.0 - isRind * smoothstep(0.35, 0.95, rib) * 0.38;
    horde += vec3<f32>(1.0, 0.32, 0.04) * isRind * (0.55 + 0.30 * sin(u.time * 3.2 + w.y * 0.05));
    // Red eyes + carved maw: pulsing ember glow, horde only.
    horde += vec3<f32>(1.0, 0.06, 0.02) * isRedEye * (3.0 + 2.0 * (0.7 + 0.3 * sin(u.time * 6.0 + w.x * 0.8))) * (1.0 - giga);
    horde += vec3<f32>(1.0, 0.15, 0.02) * isMaw * (0.8 + 0.4 * sin(u.time * 5.0 + w.z * 0.6)) * (1.0 - giga);
    let pulse = 0.75 + 0.25 * sin(u.time * 4.0 + w.x * 0.5 + w.z * 0.4);
    horde += vec3<f32>(0.35, 1.0, 0.25) * isEye * (3.2 + 1.6 * pulse) * (1.0 - giga);
    let hh = hash21(floor(w.xz / 80.0));
    let vol = 1.0 - step(0.15, fract(u.time * 0.33 + hh * 7.0));
    horde += vec3<f32>(1.0, 0.45, 0.08) * isTip * (0.5 + vol * 3.0) * (1.0 - giga);
    let churn = fbm3(w.xz * 0.05 + w.y * 0.04 + u.time * 0.8);
    var mag = mix(vec3<f32>(0.45, 0.05, 0.01), vec3<f32>(1.0, 0.75, 0.15), churn);
    mag *= 1.2 + 0.6 * sin(u.time * 5.0 + w.x * 0.2 + w.y * 0.3);
    horde = mix(horde, mag * 2.2, isMag);
    let isGlobe = step(0.95, in.color.r) * step(0.95, in.color.g) * step(0.95, in.color.b);
    horde = mix(horde, mag * 2.6, isGlobe * (1.0 - giga)); // magma-red portal skin (globe only; GIGA flash stays white-hot)
    horde += vec3<f32>(1.0, 0.98, 0.95) * isGlobe * giga * (1.7 + 0.5 * sin(u.time * 5.0)); // white-hot globe glow
    horde += vec3<f32>(1.0, 0.25, 0.03) * isGlobe * (1.0 - giga) * (1.2 + 0.5 * sin(u.time * 5.0)); // ember pulse

    if (giga < 0.5) { // horde early-out: skip the full GIGA lighting below
        let camHXZ = vec2<f32>(u.camX, u.camZ);
        let hdist = length(w.xz - camHXZ);
        var hf = 1.0 - exp(-hdist * hdist * 0.00000025);
        hf *= exp(-max(w.y - 2.0, 0.0) * 0.05);
        hf *= 1.0 - isGlobe; // the merge portal burns through haze at any range
        horde = mix(horde, vec3<f32>(0.17, 0.09, 0.26), clamp(hf, 0.0, 1.0));
        return vec4<f32>(horde, 1.0);
    }

    // ================= GIGA PATH (full creature lighting) =================
    // Face normal from derivatives (flat plates read crisp, like jet.wgsl).
    let eyeW = vec3<f32>(u.camX, 2000.0, u.camZ);
    let vdir = eyeW - w;
    let vlen = max(length(vdir), 0.001);
    let v = vdir / vlen;
    var faceN = normalize(cross(dpdx(w), dpdy(w)));
    if (dot(faceN, v) < 0.0) { faceN = -faceN; }
    let l = normalize(vec3<f32>(0.22, 0.38, 0.90)); // moon key
    // Wet rotting hide: large mottling + medium variation + fine pores.
    // Hue drifts olive -> grey-green -> brown so 30x faces never read
    // as one flat green plastic slab (the old fake look).
    let mott = fbm5(w.xz * 0.02 + w.y * 0.025);
    let mott2 = fbm3(vec2<f32>(w.x * 0.08 - w.z * 0.06, w.y * 0.09) + u.time * 0.05);
    let pore = vnoise(vec2<f32>(w.x * 0.55 + w.z * 0.43, w.y * 0.60));
    let plates = vnoise(w.xz * 0.06 + w.y * 0.07);
    let crevice = 1.0 - smoothstep(0.30, 0.55, plates);
    // patchwork: brown rot blooms + pale scar tissue + dark back wash
    let brown = smoothstep(0.58, 0.80, fbm3(w.zx * 0.035 + 4.7));
    let scar = smoothstep(0.62, 0.85, fbm3(vec2<f32>(w.x * 0.05 - w.y * 0.04, w.z * 0.06) + 9.1));
    var alb = col;
    alb *= 0.62 + mott * 0.95; // wider large tone drift
    alb *= 0.85 + mott2 * 0.35; // medium variation
    alb *= 0.92 + pore * 0.16; // fine skin grain
    alb = mix(alb, vec3<f32>(0.38, 0.26, 0.13) * (0.62 + mott * 0.9), brown * 0.55 * isFlesh); // rot blooms
    alb = mix(alb, vec3<f32>(0.55, 0.55, 0.48), scar * 0.35 * isFlesh); // scar tissue
    alb *= 1.0 - crevice * 0.55 * isFlesh; // scale seams sink deep
    alb *= 1.0 - smoothstep(0.60, 0.88, fbm3(w.xz * 0.11 + w.y * 0.10)) * 0.55 * isFlesh; // rot pits
    alb *= 1.0 + clamp(w.y * 0.00012, 0.0, 0.22) * isFlesh; // moonlit crown lift
    // Wrap diffuse (subsurface feel) + warm sand bounce + purple rim.
    let wrap = clamp((dot(faceN, l) + 0.55) / 1.55, 0.0, 1.0);
    let ndl = max(dot(faceN, l), 0.0);
    let back = clamp(dot(faceN, normalize(vec3<f32>(-0.3, 0.25, -0.9))), 0.0, 1.0);
    let rim = pow(1.0 - abs(dot(faceN, v)), 3.0);
    var lit = alb * (vec3<f32>(0.30, 0.24, 0.20) // ambient rot
        + vec3<f32>(1.05, 1.08, 1.22) * 1.5 * u.sunI * (wrap * 0.85 + ndl * 0.35)
        + vec3<f32>(0.45, 0.28, 0.12) * back * 0.35);
    lit += vec3<f32>(0.45, 0.20, 0.75) * rim * (0.35 + z.rage * 0.65); // violet rim
    // Fake bevel: grazing faces darken + desaturate slightly, so the
    // remaining box edges read as rounded rolls instead of hard corners.
    let graze = pow(1.0 - abs(dot(faceN, v)), 5.0);
    lit *= 1.0 - graze * 0.30 * isFlesh;
    // Wet specular: broad sheen on hide, tight glint on teeth/eyes/spikes.
    let hvec = normalize(l + v);
    let specHide = pow(max(dot(faceN, hvec), 0.0), 36.0) * 0.55 * isFlesh;
    lit += vec3<f32>(0.9, 0.95, 1.0) * specHide * (0.5 + mott2 * 0.8); // sweaty patches
    // Scale glints: rare tiny sparks on plate ridges catch the moon.
    let glint = step(0.965, pore) * smoothstep(0.4, 0.7, plates) * ndl;
    lit += vec3<f32>(0.85, 0.9, 1.0) * glint * 0.7 * isFlesh;
    // GIGA veins: rot-lit cracks crawl molten while enraged, flare white
    // on the telegraph.
    let vein = smoothstep(0.60, 0.90, fbm3(w.xz * 0.02 + w.y * 0.03 + u.time * 0.5));
    lit += vec3<f32>(1.0, 0.30, 0.05) * isFlesh * vein
        * (z.rage * 1.5 + z.flash * 1.0) * (0.7 + 0.3 * sin(u.time * 9.0));
    // GIGA eyes: burning slit pupils — emissive sclera, dark vertical
    // slit, hot specular dot. Rage shifts them molten-red, the telegraph
    // flashes them white-hot.
    let gpulse = 0.75 + 0.25 * sin(u.time * (4.0 + z.flash * 14.0) + w.x * 0.5 + w.z * 0.4);
    let eyeHot = mix(vec3<f32>(0.35, 1.0, 0.25), vec3<f32>(1.0, 0.25, 0.05), z.rage);
    var eyeCol = eyeHot * (2.6 + 1.4 * gpulse + z.flash * 3.0);
    let slit = 1.0 - smoothstep(0.02, 0.10, abs(fract(w.x * 0.05 + w.z * 0.05) - 0.5) * 2.0 - 0.55);
    eyeCol *= 1.0 - slit * 0.75; // dark slit pupil
    eyeCol += vec3<f32>(1.0) * pow(max(dot(faceN, hvec), 0.0), 120.0) * 2.0; // wet glint
    lit = mix(lit, eyeCol, clamp(isEye, 0.0, 1.0));
    // Teeth: aged ivory with per-tooth tone + hard glint.
    var tooth = vec3<f32>(0.82, 0.78, 0.66) * (0.85 + mott2 * 0.3);
    tooth *= 0.55 + 0.45 * ndl + 0.25;
    tooth += vec3<f32>(1.0, 0.98, 0.92) * pow(max(dot(faceN, hvec), 0.0), 90.0) * 1.2;
    lit = mix(lit, tooth, clamp(isTooth, 0.0, 1.0));
    // Mouth: near-black throat, ember glow deep inside + drool gloss.
    var throat = vec3<f32>(0.10, 0.015, 0.01);
    throat += vec3<f32>(1.0, 0.30, 0.05) * smoothstep(0.5, 1.0, fbm3(w.xz * 0.2 + u.time * 0.7)) * (0.4 + z.rage * 0.9);
    throat += vec3<f32>(0.9, 0.95, 1.0) * pow(max(dot(faceN, hvec), 0.0), 60.0) * 0.8; // wet drool
    lit = mix(lit, throat, clamp(isMouth, 0.0, 1.0));
    // Spikes: bone shafts, ember tips that ignite with rage/flash.
    var spike = vec3<f32>(0.62, 0.64, 0.70) * (0.5 + 0.5 * ndl + 0.3);
    spike += vec3<f32>(1.0, 0.45, 0.10) * smoothstep(0.55, 0.95, mott) * (z.rage * 1.6 + z.flash * 1.2);
    spike += vec3<f32>(1.0) * pow(max(dot(faceN, hvec), 0.0), 120.0) * 0.8;
    lit = mix(lit, spike, clamp(isSpike, 0.0, 1.0));
    // Rags stay matte under the same key.
    lit *= 1.0 - clamp(isRag, 0.0, 1.0) * 0.25;
    // Death cracks: random jagged lines split the hide and glow magma.
    // Ridged noise gives thin random veins; the spread threshold falls as
    // doom rises so a few hairlines become a fully cracked shell, with a
    // white-hot core inside the red glow. The whole body chars around them.
    let bodyM = clamp(isFlesh + clamp(isRag, 0.0, 1.0) + isSpike, 0.0, 1.0);
    let crackN = fbm5(vec2<f32>(w.x * 0.045 + w.z * 0.031, w.y * 0.055 + w.z * 0.017));
    let ridge = 1.0 - abs(crackN * 2.0 - 1.0);
    let spread = mix(0.985, 0.68, z.doom);
    let crack = smoothstep(spread, 1.0, ridge) * z.doom * bodyM;
    let core = smoothstep(mix(0.995, 0.86, z.doom), 1.0, ridge) * z.doom * bodyM;
    let throb = 0.8 + 0.4 * sin(u.time * 20.0 + w.y * 0.05);
    lit = mix(lit, vec3<f32>(0.12, 0.01, 0.005), z.doom * 0.55 * bodyM); // char
    lit += vec3<f32>(1.0, 0.14, 0.02) * crack * 3.0 * throb; // magma glow
    lit += vec3<f32>(1.0, 0.85, 0.45) * core * 4.0; // white-hot heart
    lit = mix(lit, mag * 2.2, isMag);

    col = mix(horde, lit, giga);
    // Sink into the night haze with distance like everything else.
    let camXZ = vec2<f32>(u.camX, u.camZ);
    let dist = length(w.xz - camXZ);
    var f = 1.0 - exp(-dist * dist * 0.00000025);
    f *= exp(-max(w.y - 2.0, 0.0) * 0.05);
    col = mix(col, vec3<f32>(0.17, 0.09, 0.26), clamp(f, 0.0, 1.0));
    return vec4<f32>(col, 1.0);
}
