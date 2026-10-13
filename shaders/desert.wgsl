// Desert land v1: true 3D procedural dune field + ruined village.
// Vertex buffers come from game.luau (pos + color). Camera MVP via uniforms.
struct VertexIn {
    @location(0) pos: vec3<f32>,
    @location(1) col: vec3<f32>,
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
    eye: vec3<f32>, // shared 96-byte UBO: desert reads the head only
    level: f32, // 0 clean night, 1 round-3 green/red grade, <0 L3 ember burn (eased by script)
};

@group(0) @binding(0)
var<uniform> u: Uniforms;

@vertex
fn vs_main(in: VertexIn) -> VertexOutput {
    var out: VertexOutput;
    out.clip = u.mvp * vec4<f32>(in.pos, 1.0);
    out.color = in.col;
    out.world = in.pos;
    return out;
}

fn hash21(p: vec2<f32>) -> f32 {
    let q = fract(p * vec2<f32>(234.34, 435.345));
    return fract(q.x + q.y + dot(q, q + vec2<f32>(34.23, 34.23)));
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    // Sand grain + moonlight shading by height. Base lifted so the sandy
    // vertex colors read bright instead of sinking into the night.
    let grain = hash21(floor(in.world.xz * 3.0));
    var col = in.color * (0.92 + 0.08 * grain);
    col *= 1.22 + 0.13 * clamp(in.world.y * 0.25 + 0.5, 0.0, 1.0) * u.sunI;
    col += vec3<f32>(0.045, 0.038, 0.030);

    // Jack-o-lantern glow: pumpkin-orange verts pulse like candles.
    let isPumpkin = step(0.80, in.color.r) * step(0.30, in.color.g)
        * (1.0 - step(0.60, in.color.g)) * (1.0 - step(0.20, in.color.b));
    let flick = 0.70 + 0.30 * sin(u.time * 5.0 + in.world.x * 1.7 + in.world.z * 1.3)
        + 0.15 * sin(u.time * 17.0 + in.world.z * 9.0 + in.world.y * 6.0);
    col += vec3<f32>(1.0, 0.42, 0.08) * isPumpkin * flick * 1.4;

    // Eerie candle-yellow eyes + jet core glow brighter, with fine flame flicker.
    let isGlow = step(0.90, in.color.r) * step(0.75, in.color.g) * (1.0 - step(0.35, in.color.b));
    let coreFlick = 0.85 + 0.30 * sin(u.time * 11.0 + in.world.x * 7.0 + in.world.y * 5.0 + in.world.z * 6.0)
        + 0.15 * sin(u.time * 23.0 + in.world.z * 13.0);
    col += vec3<f32>(1.0, 0.85, 0.30) * isGlow * (1.2 + 0.5 * sin(u.time * 7.0)) * coreFlick;
    // White-hot inner core: extra pop so the nested core reads inside the sheath.
    let isHot = step(0.95, in.color.r) * step(0.80, in.color.g)
        * step(0.18, in.color.b) * (1.0 - step(0.32, in.color.b));
    col += vec3<f32>(1.0, 0.95, 0.55) * isHot * (0.9 + 0.4 * sin(u.time * 13.0 + in.world.z * 9.0));

    // Jet airframe: cool moonlit metal sheen on gray-blue verts, plus a
    // sliding glint on canopy glass so it reads curved, not flat.
    let isMetal = step(0.28, in.color.r) * (1.0 - step(0.46, in.color.r))
        * step(0.28, in.color.g) * (1.0 - step(0.44, in.color.g))
        * step(0.33, in.color.b) * (1.0 - step(0.52, in.color.b));
    col += vec3<f32>(0.10, 0.13, 0.20) * isMetal * (0.55 + 0.45 * sin(u.time * 1.7 + in.world.x * 0.8 + in.world.z * 0.6));
    let isGlass = step(0.45, in.color.r) * (1.0 - step(0.65, in.color.r))
        * step(0.65, in.color.g) * step(0.85, in.color.b);
    let glint = pow(max(0.0, sin(u.time * 2.2 + in.world.x * 1.3 + in.world.z * 1.1 + in.world.y * 2.0)), 8.0);
    col += vec3<f32>(1.0, 0.98, 0.92) * isGlass * glint * 1.6;

    // Golden beam bolt: hot core strobes hard so it reads at distance.
    let isBeam = step(0.95, in.color.r) * step(0.60, in.color.g) * (1.0 - step(0.32, in.color.b));
    col += vec3<f32>(1.0, 0.72, 0.22) * isBeam * (1.6 + 0.6 * sin(u.time * 10.0));
    // Giga Beam: straight red laser - blood-red burn so it reads at distance.
    let isGiga = step(0.95, in.color.r) * (1.0 - step(0.20, in.color.g)) * (1.0 - step(0.25, in.color.b));
    col += vec3<f32>(1.0, 0.07, 0.04) * isGiga * (2.4 + 0.8 * sin(u.time * 24.0));
    // Zombie pop-blue fire: vivid electric-blue dots that punch through haze.
    let isPop = step(0.15, in.color.r) * (1.0 - step(0.35, in.color.r))
        * step(0.45, in.color.g) * (1.0 - step(0.75, in.color.g)) * step(0.95, in.color.b);
    let pop = 1.7 + 0.9 * sin(u.time * 14.0 + in.world.x * 3.0 + in.world.z * 2.0);
    col += vec3<f32>(0.25, 0.55, 1.0) * isPop * pop;
    col += vec3<f32>(0.85, 0.95, 1.0) * isPop * smoothstep(0.6, 1.0, sin(u.time * 14.0 + in.world.y * 4.0)) * 1.2;

    // Runway lights: warm-white lamp band (edge heads + centerline studs).
    // Edge lamps steady-burn with a hot filament core; centerline studs run
    // a chase sequence down the strip (takeoff direction, +z).
    let isRwy = step(0.99, in.color.r) * step(0.88, in.color.g)
        * step(0.55, in.color.b) * (1.0 - step(0.70, in.color.b));
    let isEdge = step(2.0, abs(in.world.x));
    let chase = fract(u.time * 0.8 - in.world.z * 0.05);
    let seq = smoothstep(0.0, 0.12, chase) * (1.0 - smoothstep(0.12, 0.5, chase));
    let lampHot = 2.4 + 0.25 * sin(u.time * 31.0 + in.world.z * 12.0)
        + (1.0 - isEdge) * seq * 2.2;
    col += vec3<f32>(1.0, 0.97, 0.90) * isRwy * lampHot;
    col += vec3<f32>(1.0, 0.60, 0.22) * isRwy * (0.85 + (1.0 - isEdge) * seq * 1.2);
    // Green threshold bars: steady airfield green.
    let isThr = step(0.15, in.color.r) * (1.0 - step(0.35, in.color.r))
        * step(0.90, in.color.g) * step(0.35, in.color.b) * (1.0 - step(0.55, in.color.b));
    col += vec3<f32>(0.20, 1.0, 0.42) * isThr * 2.4;
    // PAPI approach lights: red / white, steady.
    let isPapiR = step(0.90, in.color.r) * (1.0 - step(0.27, in.color.g)) * (1.0 - step(0.20, in.color.b));
    col += vec3<f32>(1.0, 0.12, 0.08) * isPapiR * 2.2;
    let isPapiW = step(0.90, in.color.r) * step(0.90, in.color.g)
        * step(0.78, in.color.b) * (1.0 - step(0.90, in.color.b));
    col += vec3<f32>(1.0, 0.97, 0.90) * isPapiW * 2.0;
    // Zombie launcher strobes: red blink on the horde racks.
    let isBeacon = step(0.70, in.color.r) * (1.0 - step(0.30, in.color.g)) * (1.0 - step(0.30, in.color.b));
    col += vec3<f32>(1.6, 0.08, 0.05) * isBeacon * (0.35 + 0.65 * step(0.5, fract(u.time * 1.5 + in.world.x * 0.01)));
    // Zombie armor: dusty two-tone camo + panel seams on the war machines.
    let isArmor = step(0.34, in.color.r) * (1.0 - step(0.48, in.color.r))
        * step(0.36, in.color.g) * (1.0 - step(0.50, in.color.g))
        * step(0.24, in.color.b) * (1.0 - step(0.34, in.color.b));
    let camo = 0.5 + 0.5 * sin(in.world.x * 0.045 + 2.0) * sin(in.world.z * 0.038 + in.world.y * 0.05);
    col = mix(col, col * 0.7 + vec3<f32>(0.06, 0.055, 0.02), isArmor * smoothstep(0.55, 0.95, camo));
    let pseam = step(0.965, fract(in.world.x * 0.02 + in.world.y * 0.013 + in.world.z * 0.017));
    col *= 1.0 - isArmor * pseam * 0.3;
    // Light pools spilled on the pavement under each edge lamp: warm
    // ellipses fading with distance from the strip edges, strongest at
    // each lamp station (10u spacing) so the slabs read lit, not painted.
    let onStrip = step(abs(in.world.x), 9.0)
        * step(-14990.0, in.world.z) * step(in.world.z, -14910.0);
    let isSlab = step(0.08, in.color.r) * (1.0 - step(0.26, in.color.r))
        * step(abs(in.world.y + 0.4), 1.0);
    let station = 0.5 + 0.5 * cos((in.world.z + 14950.0) * 6.2831 / 10.0);
    let edgeDx = abs(abs(in.world.x) - 4.2);
    let pool = onStrip * isSlab * station * exp(-edgeDx * edgeDx * 0.35);
    col += vec3<f32>(1.0, 0.72, 0.40) * pool * 0.55;

    // Stars twinkle; moon stays steady.
    let isStar = step(0.90, in.color.r) * step(0.90, in.color.g) * step(0.90, in.color.b);
    let tw = 0.55 + 0.45 * sin(u.time * 3.0 + in.world.x * 2.1 + in.world.z * 1.7);
    col += vec3<f32>(0.85, 0.90, 1.0) * isStar * tw;

    // Heat shimmer far away (camera-relative so it follows the jet anywhere).
    let camXZ = vec2<f32>(u.camX, u.camZ);
    let dist = length(in.world.xz - camXZ);
    let shimmer = sin(dist * 2.0 - u.time * 3.0) * 0.02 * smoothstep(40.0, 120.0, dist);
    col += vec3<f32>(0.06, 0.05, 0.03) * shimmer;

    // Halloween night horizon: deep purple + burnt-orange band.
    // Haze only hugs the ground — moon and stars above stay clear.
    // Kept thin so mid-field dunes keep their sandy color; only the far
    // horizon melts into purple.
    let sky = vec3<f32>(0.17, 0.09, 0.26);
    var f = 1.0 - exp(-dist * dist * 0.00000025);
    f *= exp(-max(in.world.y - 2.0, 0.0) * 0.05);
    col = mix(col, sky, clamp(f, 0.0, 1.0));
    // Orange dusk band near horizon + green ghost-wisp near ground.
    let band = exp(-dist * 0.012) * 0.22;
    col += vec3<f32>(0.55, 0.20, 0.05) * band;
    let wisp = (0.5 + 0.5 * sin(in.world.x * 0.35 + u.time * 0.8)
        * sin(in.world.z * 0.30 - u.time * 0.6)) * exp(-abs(in.world.y - 1.0) * 0.6) * 0.08;
    col += vec3<f32>(0.20, 0.85, 0.45) * wisp;
    // Round 3 grade: toxic-green horizon bleeding up into blood red.
    // Emissives (lamps, faces, bolts, stars) keep their colors; the world
    // itself washes green low and red high, moon included (blood moon).
    if (u.level > 0.001) {
        let hgt = clamp(in.world.y / 60.0, 0.0, 1.0);
        var lgrad = mix(vec3<f32>(0.04, 0.50, 0.16), vec3<f32>(0.42, 0.04, 0.07), smoothstep(0.0, 0.55, hgt));
        lgrad += vec3<f32>(0.04, 0.42, 0.14) * exp(-max(in.world.y, 0.0) * 0.08)
            * (0.7 + 0.3 * sin(u.time * 2.0 + dist * 0.05));
        lgrad += vec3<f32>(0.48, 0.07, 0.09) * smoothstep(20.0, 120.0, in.world.y)
            * (0.6 + 0.4 * sin(u.time * 1.3 + in.world.z * 0.02));
        let keep = max(max(max(isPumpkin, isGlow), max(max(isHot, isStar), max(max(max(isRwy, isBeam), isThr), isGiga))), max(max(max(isPapiR, isPapiW), max(isGlass, isMetal)), isPop));
        lgrad *= 1.0 - clamp(keep, 0.0, 1.0);
        col = mix(col, lgrad + col * 0.25, clamp(u.level, 0.0, 1.0));
    }
    // L3 ember burn: blood-orange horizon under a dark crimson sky while
    // the court stands. Red-hot emissives keep their colors; the world burns.
    if (u.level < -0.001) {
        let estr = clamp(-u.level, 0.0, 1.0);
        let hgt = clamp(in.world.y / 120.0, 0.0, 1.0);
        var egrad = mix(vec3<f32>(0.45, 0.10, 0.03), vec3<f32>(0.16, 0.02, 0.05), smoothstep(0.0, 0.6, hgt));
        egrad += vec3<f32>(0.55, 0.12, 0.03) * exp(-max(in.world.y, 0.0) * 0.05) * (0.7 + 0.3 * sin(u.time * 1.7 + dist * 0.04));
        egrad += vec3<f32>(0.50, 0.06, 0.08) * smoothstep(30.0, 200.0, in.world.y) * (0.6 + 0.4 * sin(u.time * 1.1 + in.world.z * 0.015));
        let ekeep = step(0.9, in.color.r);
        egrad *= 1.0 - ekeep;
        col = mix(col, egrad + col * 0.25, estr);
    }
    return vec4<f32>(col, 1.0);
}
