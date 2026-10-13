-- Dead Earth Revival: DESERT SKIES v1, true 3D.
-- Procedural dune field + ruined mud-village + Halloween props under a starry sky.
-- Fighter jet starts on a desert runway: manual takeoff, then free flight.
-- Hold Q to spool up for speed, W rotates at Vr - rolling off the strip
-- without lifting off wrecks the jet.
-- W climbs, S descends, A/D strafe, Q boosts 2x, Space fires bolts.
-- Click playfield to lock mouse (cursor hides), move mouse to look, ESC releases.

type Game = {
    size: Vector,
    msg: Property<string>?,
    welcome: Property<string>?,
    welcomeA: Property<number>?,
    welcomeX: Property<number>?,
    welcomeY: Property<number>?,
    welcomeS: Property<number>?,
    tut: Property<string>?,
    tutA: Property<number>?,
    niceA: Property<number>?,
    tutX: Property<number>?,
    tutY: Property<number>?,
    gateScore: Property<string>?,
    gateScoreA: Property<number>?,
    gateScoreX: Property<number>?,
    gateScoreY: Property<number>?,
    niceX: Property<number>?,
    niceY: Property<number>?,
    lockMsg: Property<string>?,
    lockA: Property<number>?,
    lockX: Property<number>?,
    lockMsgT: number, -- steer banner countdown, 0 = parked
    lvlLock2: Property<number>?,
    lvlLock3: Property<number>?,
    loc: Property<number>?,
    keyF: Property<boolean>?,
    keyB: Property<boolean>?,
    keyL: Property<boolean>?,
    keyR: Property<boolean>?,
    keyJump: Property<boolean>?,
    keyBoost: Property<boolean>?,
    speed: Property<number>?,
    alt: Property<number>?,
    hudSpdLabX: Property<number>?,
    hudSpdNumX: Property<number>?,
    hudAltLabX: Property<number>?,
    hudAltNumX: Property<number>?,
    hudStatY: Property<number>?,
    keyRun: Property<boolean>?,
    locked: Property<boolean>?,
    health: Property<number>?,
    hudBarX: Property<number>?,
    hudBarY: Property<number>?,
    hudHpX: Property<number>?,
    hudNumX: Property<number>?,
    hudMapX: Property<number>?,
    hudMapY: Property<number>?,
    overA: Property<number>?,
    overTitle: Property<string>?,
    overRetry: Property<string>?,
    overTitleX: Property<number>?,
    overTitleY: Property<number>?,
    overBtnX: Property<number>?,
    overHomeX: Property<number>?,
    overRetryY: Property<number>?,
    overHomeY: Property<number>?,
    overBX: number,
    overHX: number,
    overRY: number,
    overHY: number,
    mapPlaneX: Property<number>?,
    mapPlaneY: Property<number>?,
    aimX: Property<number>?,
    aimY: Property<number>?,
    aimA: Property<number>?,
    aimLX: Property<number>?,
    aimRX: Property<number>?,
    aimTY: Property<number>?,
    aimBY: Property<number>?,
    bossHp: Property<number>?,
    bossBarX: Property<number>?,
    bossBarY: Property<number>?,
    bossBarA: Property<number>?,
    bossNameY: Property<number>?,
    bossName: Property<string>?,
    unlockA: Property<number>?,
    unlockX: Property<number>?,
    unlockY: Property<number>?,
    unlockLit: Property<number>?,
    unlockMsg: Property<string>?,
    vitCubeA: Property<string>?,
    vitCubeB: Property<string>?,
    vitA: Property<number>?,
    vitTitleA: Property<number>?,
    vitTitleY: Property<number>?,
    vitL1X: Property<number>?,
    vitL2X: Property<number>?,
    vitL2A: Property<number>?,
    vitLockA: Property<number>?,
    vitLockX: Property<number>?,
    vitLockY: Property<number>?,
    vitContA: Property<number>?,
    vitContX: Property<number>?,
    vitContY: Property<number>?,
    vitFlash: Property<number>?,
    vitL2Lit: Property<number>?,
    vitSubA: Property<number>?,
    vitRowY: Property<number>?,
    vitTitleX: Property<number>?,
    vitUnlockY: Property<number>?,
    vitEdgeL: Property<number>?,
    vitEdgeR: Property<number>?,
    vitEdgeT: Property<number>?,
    vitEdgeB: Property<number>?,
    vitArrowX: Property<number>?,
    vitSparkA: Property<number>?,
    vitSparkX: { Property<number> },
    vitSparkY: { Property<number> },
    vitConfA: Property<number>?,
    vitConfX: { Property<number> },
    vitConfY: { Property<number> },
    vitSubY: Property<number>?,
    vitDotY: Property<number>?,
    vitDotX: { Property<number> },
    vitL2FX: Property<number>?,
    vitL2FY: Property<number>?,
    pumpX: Property<number>?,
    pumpY: Property<number>?,
    pump2A: Property<number>?,
    pk3A: Property<number>?,
    pk3X: Property<number>?,
    pk3Y: Property<number>?,
    vitContBX: number,
    vitContBY: number,
    vicTitleA: Property<number>?,
    vicTitleY: Property<number>?,
    vitL1A: Property<number>?,
    svLvl2: Property<boolean>?,
    svLvl3: Property<boolean>?,
    svTut: Property<boolean>?,
    svSnd: Property<boolean>?,
    gunX1: Property<number>?,
    gunX2: Property<number>?,
    gunX3: Property<number>?,
    gunX4: Property<number>?, -- 4th gun-bar row (SEEKER)
    gunRowY: Property<number>?,
    gunHLX: Property<number>?,
    gunDim: Property<number>?,
    gunHL: Property<string>?,
    msls: { Msl },
    mslBooms: { MslBoom },
    trailX: { Property<number> },
    trailY: { Property<number> },
    trail: { TrailDot },
    trailIdx: number,
    trailAcc: number,
    foeX: { Property<number> },
    foeY: { Property<number> },
    foes: { Foe },
    gates: { Gate },
    gateIdx: number, -- next live circus gate (1..GATE_N+1, past the end = complete)
    gateGraceT: number, -- post-respawn mercy: ground kisses don't count down
    gatePipe: GPUPipeline?,
    gateBind: GPUBindGroup?,
    gateVbo: GPUBuffer?,
    gateCpu: buffer?,
    armyVbo: GPUBuffer?, -- level-3 ground army, baked static, world pipeline
    stormVbo: GPUBuffer?, -- level-3 storm wall, churning dynamic, world pipeline
    stormCpu: buffer?,
    sandVbo: GPUBuffer?, -- level-3 blowing sand sheets + whiteout veil
    sandCpu: buffer?,
    nukePipe: GPUPipeline?, -- GIGA atom bomb: shader billboards, staged once
    nukeBind: GPUBindGroup?,
    nukeVbo: GPUBuffer?,
    nukeCpu: buffer?,
    mslPipe: GPUPipeline?, -- SEEKER missiles + their explosion billboards
    mslBind: GPUBindGroup?,
    mslVbo: GPUBuffer?,
    mslCpu: buffer?,
    auroraPipe: GPUPipeline?,
    auroraBind: GPUBindGroup?,
    auroraVbo: GPUBuffer?,
    auroraCpu: buffer?,
    zombiePipe: GPUPipeline?,
    zombieBind: GPUBindGroup?,
    zubo: GPUBuffer?,
    zuboCpu: buffer?,
    armyCpu: buffer?, -- horde bytes kept for kill burials
    giantCpu: buffer?, -- magma ball / giant boss, rebuilt per frame
    giantVbo: GPUBuffer?,
    kills: number,
    round: number, -- level 1: 1 pumpkins, 2 boss approach (unused), 3 MORGATHA
    hp: number, -- round-2 hit points, mirrored to the HUD bar
    mapOX: number,
    mapOY: number,
    cursorC: Property<string>?,
    takeoffSnd: AudioSource?,
    takeoffInst: any,
    takeoffPlayed: boolean,
    jetSnd: AudioSource?,
    jetInst: any,
    jetT: number,
    homeBellsSnd: AudioSource?,
    homeBellsInst: any,
    homeBellsT: number,
    heroA: Property<number>?,
    heroX: Property<number>?,
    heroY: Property<number>?,
    heroSX: Property<number>?,
    heroSY: Property<number>?,
    heroImg: Image?,
    homeImg: Image?,
    loadW: Property<number>?,
    loadBarX: Property<number>?,
    loadBarY: Property<number>?,
    loadLabY: Property<number>?,
    homeA: Property<number>?,
    homeX: Property<number>?,
    homeY: Property<number>?,
    homeSX: Property<number>?,
    homeSY: Property<number>?,
    homeTitleX: Property<number>?,
    homeTitleY: Property<number>?,
    startX: Property<number>?,
    startBtnY: Property<number>?,
    startLabY: Property<number>?,
    btnA: Property<number>?,
    setA: Property<number>?,
    rulA: Property<number>?,
    backA: Property<number>?,
    panelTA: Property<number>?,
    mainX: Property<number>?,
    hovPlay: Property<number>?,
    hovSet: Property<number>?,
    hovRul: Property<number>?,
    playY: Property<number>?,
    lvlX1: Property<number>?,
    lvlX2: Property<number>?,
    lvlX3: Property<number>?,
    lvlY: Property<number>?,
    lvlLineY: Property<number>?,
    lvlLabX1: Property<number>?,
    lvlLabX2: Property<number>?,
    lvlLabX3: Property<number>?,
    lvlLabY: Property<number>?,
    lockX2: Property<number>?,
    lockBY2: Property<number>?,
    lockSY2: Property<number>?,
    lockX3: Property<number>?,
    lockBY3: Property<number>?,
    lockSY3: Property<number>?,
    connX0: Property<number>?,
    connX1: Property<number>?,
    connY: Property<number>?,
    lvlBX: number, lvlBY: number,
    setY: Property<number>?,
    rulY: Property<number>?,
    rulX: Property<number>?,
    sndX: Property<number>?,
    sndY: Property<number>?,
    setCtlX: Property<number>?,
    setCtlY: Property<number>?,
    backX: Property<number>?,
    backY: Property<number>?,
    rulBodyX: Property<number>?,
    rulBodyY: Property<number>?,
    ctlBodyX: Property<number>?,
    ctlBodyY: Property<number>?,
    ctlBodyRX: Property<number>?,
    ctlLY: { Property<number> }?,
    ctlRY: { Property<number> }?,
    ctlA: Property<number>?,
    ctlPanelX: Property<number>?,
    ctlPanelY: Property<number>?,
    ctlTitleX: Property<number>?,
    ctlTitleY: Property<number>?,
    ctlXBtnX: Property<number>?,
    ctlXBtnY: Property<number>?,
    helpT: number,
    helpXX: number, helpXY: number,
    dimX: Property<number>?,
    dimY: Property<number>?,
    dimW: Property<number>?,
    clickX: Property<number>?,
    clickY: Property<number>?,
    clickA: Property<number>?,
    fogX: { Property<number> }?,
    smokeX: { Property<number> }?,
    smokeY: { Property<number> }?,
    smokeA: { Property<number> }?,
    smokeS: { Property<number> }?,
    smokeBaseY: number,
    mouseNX: number, mouseNY: number,
    parX: number, parY: number,
    cardA: Property<number>?,
    cardX: Property<number>?,
    cardY: Property<number>?,
    cardBtnX: Property<number>?,
    cardResY: Property<number>?,
    cardHomeY: Property<number>?,
    cardCtlY: Property<number>?,
    cardTitleX: Property<number>?,
    cardTitleY: Property<number>?,
    cardResBX: number, cardResBY: number,
    cardHomeBX: number, cardHomeBY: number,
    cardCtlBX: number, cardCtlBY: number,
    sfx: any,
    titleTxt: Property<string>?,
    sndTxt: Property<string>?,
    pauseTxt: Property<string>?,
    paused: boolean,
    homePanel: number,
    soundOn: boolean,
    homeTarget: number,
    homeFade: number,
    playBX: number, playBY: number,
    setCtlBX: number, setCtlBY: number,
    setBX: number, setBY: number,
    rulBX: number, rulBY: number,
    sndBX: number, sndBY: number,
    backBX: number, backBY: number,
    loadT: number,
    startBX: number,
    startBY: number,
    time: number,
    angle: number,
    camYaw: number,
    lookH: number, -- look-target height above ground (drag up/down to look at sky/feet)
    radius: number,
    height: number,
    tx: number,
    tz: number,
    keys: { [number]: boolean },
    lastPX: number,
    lastPY: number,
    dragging: boolean,
    mouseFire: boolean, -- left button held on the playfield: autofire
    mouseClimb: number, -- mouse elevator trim (-1 dive..1 climb), decays
    cursorPeek: boolean, -- ESC reveals the cursor mid-flight until R/click
    camHold: number,
    hy: number, -- jump height above ground
    vy: number,
    yaw: number, -- jet facing
    phase: number, -- walk cycle
    moving: boolean,
    grounded: boolean, -- on the runway until takeoff roll completes
    roll: number, -- takeoff roll 0..1 (throttle while holding W on ground)
    boostLock: boolean, -- double-tap Q latches max speed until double-tapped again
    qPrev: boolean, -- Q held last frame (rising-edge tap detect)
    qTapT: number, -- time of last Q press
    running: boolean,
    sitting: boolean,
    dust: { DustPuff },
    dustIdx: number,
    dustTimer: number,
    wasAir: boolean,
    heroVbo: GPUBuffer?,
    heroCpu: buffer?,
    beamVbo: GPUBuffer?,
    beamCpu: buffer?,
    foeVbo: GPUBuffer?,
    foeCpu: buffer?,
    bossVbo: GPUBuffer?,
    bossCpu: buffer?,
    beams: { Beam },
    beamIdx: number,
    beamCd: number,
    windVbo: GPUBuffer?,
    windCpu: buffer?,
    winds: { Beam },
    windIdx: number,
    windAcc: number,
    chunkVbo: GPUBuffer?,
    chunkCpu: buffer?,
    chunks: { Chunk },
    chunkIdx: number,
    crashAcc: number,
    crashed: boolean,
    crashT: number,
    canvas: GPUCanvas?,
    pipeline: GPUPipeline?,
    heroPipe: GPUPipeline?,
    heroBind: GPUBindGroup?,
    blastPipe: GPUPipeline?,
    blastBind: GPUBindGroup?,
    stormPipe: GPUPipeline?,
    stormBind: GPUBindGroup?,
    sandPipe: GPUPipeline?,
    sandBind: GPUBindGroup?,
    foePipe: GPUPipeline?,
    foeBind: GPUBindGroup?,
    vbo: GPUBuffer?,
    ubo: GPUBuffer?,
    bindGroup: GPUBindGroup?,
    uboCpu: buffer?,
    sampler: ImageSampler?,
    moonImg: Image?,
    depthTex: GPUTexture?,
    depthView: GPUTextureView?,
    aspect: number,
    cw: number,
    ch: number,
    vertCount: number,
    gpuOk: boolean,
}

local GRID_N = 120
local LAND = 2400.0
local WRAP = 520000.0 -- half-tile of the map (plane wraps at +/-WRAP, 20x the old 52k)
local TOP_SPEED = 2000.0 -- absolute max; only a long Q hold gets here
local START_SPEED = 900.0 -- liftoff throttle (holds whatever Q/E leave behind)
local LIFTOFF_THR = 130.0 -- rotation throttle: just above STALL, so the jet
-- leaves the strip at roll speed and the player spools up with Q (no 21-to-900 kick)
local MIN_SPEED = 0.0 -- E brakes to a full stop, then the jet sinks
local STALL = 120.0 -- below this throttle there is no lift (liftoff throttle sits just above)
local SINK = 90.0 -- max sink rate at zero throttle
local Q_RATE = 150.0 -- throttle charge per second while Q is held (~7s to top)
local E_RATE = 600.0 -- braking per second while E is held
local VR = 21.0 -- rotation speed: W lifts off at or above this ground speed
local THRUST = 5.0 -- full-throttle takeoff acceleration (flings off the 120 strip)
local DRAGK = 0.0032 -- aero drag coefficient (quadratic in ground speed)
local ROLL_R = 0.6 -- rolling resistance on the gear
local _CEIL = 2000.0 -- max height above the dunes
local MAP_W, MAP_H = 90.0, 90.0 -- HUD minimap circle diameter in px
local TRAIL_N = 16 -- breadcrumb dots on the minimap
local TRAIL_EVERY = 500.0 -- world units of travel per breadcrumb
local N_STARS = 800
-- Afterburner plume shells: smooth 8-sided tubes (outer sheath + hot core
-- per engine) shaded by the jet WGSL pipeline. Non-indexed tris per shell:
-- bands * sides quads * 6 verts + an 8-tri tip fan.
local PLUME_SIDES = 8
local PLUME_OUTER_BANDS = 9 -- 10 rings down the sheath
local PLUME_CORE_BANDS = 6 -- 7 rings down the core
local PLUME_VERTS = 2 * ((PLUME_OUTER_BANDS * PLUME_SIDES * 6 + PLUME_SIDES * 3)
    + (PLUME_CORE_BANDS * PLUME_SIDES * 6 + PLUME_SIDES * 3)) -- 1536
local BEAM_SLOTS = 32 -- scatter volleys eat 5 slots a shot (sized for 0.28s Inferno + fan)
local ORB_SLOTS = 12288 -- bullet-hell tracer pool: ~920 horde needles/s x ~9s lives run thousands live
local BEAM_EACH = 72 -- golden core (36) + halo (36)
local BEAM_VERTS = BEAM_SLOTS * BEAM_EACH
local BEAM_SPEED = 2400.0 -- bolts must outrun everything: near-hitscan
-- Four guns: 1 Inferno (rapid pulse), 2 Hammer (scatter
-- volley), 3 Giga Beam (straight red laser, 3s burn, massive damage), 4 Seeker (homing
-- missile: locks any enemy, dumbfires + airbursts with none).
-- Keys 1/2/3/4 select, G cycles.
local GUN_CD = { 0.056, 0.45, 0.18, 0.9 } -- hammer + giga run hot: near-double rate
local GUN_LIFE = { 5.0, 4.0, 6.0, 0 } -- seeker flies its own missile sim, giga burns 6s straight
local GUN_SPD = { 1.6, 1.6, 1.6, 0 } -- seeker flies its own missile sim
local GUN_NAMES = { "INFERNO", "HAMMER", "GIGA BEAM", "SEEKER" }
local GUN_LEAD = 55.0 -- crosshair distance ahead of the nose, on the bolt line

-- Level 1 (training for level 2): 5 floating pumpkins ringed ahead of
-- the runway takeoff path. Bolts down them with segment-sphere hits
-- (bolts step ~100u/frame: point checks tunnel). Live ones show as
-- green dots on the minimap. Shaded by their own WGSL foe pipeline.
local FOE_N = 5
-- Round 2 (next round, not level): survival. Mysterious light beams hunt
-- the jet for 60s; dodge them. 20 HP per hit, 100 HP total.
local SURVIVE_TIME = 60.0
local ORB_SPEED = 2800.0
local ORB_R = 12.0 -- jet hit radius: airframe ~7u + beam girth, swept per step
-- Round-3 waves (after its 5 pumpkins): survive each in turn.
local WAVE_TIMES = { 10.0, 15.0, 20.0 }
local WAVE_SPD = { 2800.0, 3000.0, 3200.0 }
local _WAVE_GAP = 4.0 -- breather between waves
local FOE_EACH = 180 -- body + stem + 2 eyes + mouth, 36 verts each
local FOE_VERTS = FOE_N * FOE_EACH
local FOE_R = 70.0 -- bolt hit radius (matches the big green pumpkin body)
-- Round 3 boss: MORGATHA, THE ROTTEN ONE. Giant green pumpkin with
-- ghost-white eyes: stalks the jet, volleys aimed fireballs, telegraphs
-- charges. 400 health in level 1; killing him opens level 2.
local BOSS_HP = 400
-- Level 3 finale: VOIDPUS PRIME, greatest super-villain after GIGA
-- falls. Purple pumpkin head + octopus-leg bottom monster on the foe
-- WGSL pipe: violet rind, writhing tentacles, molten-gold crown.
local PRIME_HP = 1500
local PRIME_SUMMON_CD = 20.0 -- P3 calls one cackler back, max 2 live
-- Level 3 storm opening: no foes up first. The jet takes off and flies
-- straight at a giant dust wall; proximity thins it (suspense), then it
-- breaks over the court's ground army and staff wave 1 rises to fight.
local L3_STORM_X = 0.0 -- map center line, takeoff heading +z
local L3_STORM_Z = -8000.0 -- 7000 past the spawn: massive on the horizon,
local L3_ARMY_X = 0.0 -- never on top of the strip (you would stand inside it)
local L3_ARMY_Z = 0.0 -- deep past the storm exit: horde ring + merge + GIGA all sit 10k beyond it, clean off the runway side
local L3_MID_D = 5500.0 -- hold-steady reminder inside this range
local L3_NAG_D = 12000.0 -- further than this: turned around, nag back
local L3_REVEAL_D = 3500.0 -- suspense: the wall starts thinning
local L3_BREAK_D = 1500.0 -- the storm lifts, the army stands revealed
local N_ARMY = 10000 -- zombie horde, 11 boxes each (50 ring columns x 200 radial rows)
local ZOMBIE_BOXES = 11 -- boots x2, coat torso, purple head, sleeves x2, gun, muzzle tip, red eyes x2, carved maw
local ARMY_VERTS = N_ARMY * ZOMBIE_BOXES * 36
local STORM_NU = 96 -- wall tessellation: 96 across, 14 up, front + back face
local STORM_NV = 14
local STORM_SKIRT = 12 -- ground dust flats blowing out at the base
local STORM_DEPTH = 6000.0 -- thick slab: faces this far apart, no sightline gets through
local STORM_VERTS = 2 * STORM_NU * STORM_NV * 6 + STORM_SKIRT * 36
-- Blowing sand: 32 streaming sheets around the jet + 480 sand dots
-- packed inside the storm slab. Drawn on the sand pipeline.
local SAND_N = 32
local SAND_DOTS = 480
local SAND_VERTS = 513 * 36 -- +1 camera veil box (whiteout inside the wall)
local FOE_HP = { 0, 6, 10, 24 } -- index by kind: 0 pumpkin one-shot, 1/2/3 staff
local FOE_NAMES = { "", "CACKLER", "SPITTER", "BRUTE", "PUMPKIN", "LAUNCHER" }
local BOSS_R = 110.0 -- bolt + contact generous radius (body spans ~100)
local BOSS_VERTS = 792 -- 11 boxes x 36 + prime 22-box octopus rig x 36
local GUN_DMG = { 2, 4, 250, 60 } -- per-bolt boss damage: Inferno / Hammer pellet (2x) / Giga laser (brutal) / Seeker AoE
-- Seeker missiles: homing anti-everything with a proximity fuse. Fired
-- from alternating wing rails, steers toward the locked target, bursts
-- into a WGSL fireball + shock ring that burns everything in radius.
-- No lock: short dumb run, then the same airburst mid-air.
local MSL_SLOTS = 6 -- two full volleys in flight at once
local MSL_BOOMS = 12 -- explosion quads, 2 per boom (fireball + ring)
local MSL_VERTS = MSL_SLOTS * 36 + MSL_BOOMS * 6 + 432 -- +12 zombie-launcher bodies x36
local MSL_SPD0 = 2800.0 -- leaves the rail fast, still bends hard, then sprints
local MSL_SPD1 = 10400.0 -- 4x a Q-boosted jet, nothing escapes slow
local MSL_TURN = 6.5 -- steering, rad/s: U-turns onto targets behind the jet
local MSL_UTURN_BOOST = 1.8 -- extra turn when the target is behind (>90 deg off)
local MSL_LIFE = 30.0 -- locked hunt time before it gives up + bursts (5x legs)
local MSL_DUMB_LIFE = 15.0 -- no lock at fire: time to curve onto something (5x legs)
local MSL_R = 320.0 -- proximity fuse + AoE burn radius
local MSL_ACQ = 75000.0 -- lock range: anything live ahead of the nose (5x reach)
local MSL_DMG = 60 -- AoE damage: one-shots staff, chunks bosses
-- Level 2 HAUNTED CIRCUS: 10 fly-through circus gates on their own WGSL
-- gate pipeline, same desert map. Sequential: gateIdx is the next live
-- gate, gold in the world and big on the minimap. Crashing respawns at
-- the last cleared gate (mercy), never a run reset.
local GATE_N = 20
-- Level 2 HAUNTED TUNNEL: 15 fly-through obstacles + 5 shootable
-- enemies = 20 stages total, straight circular bore. Enemy stages
-- block progress until the foe dies (guns do the talking).
-- If-chains (not a table) to keep type inference cheap.
local function tunEnemySlot(gi: number): number?
    if gi == 4 then return 1
    elseif gi == 8 then return 2
    elseif gi == 12 then return 3
    elseif gi == 16 then return 4
    elseif gi == 20 then return 5 end
    return nil
end
local function tunEnemyGate(slot: number): number?
    if slot == 1 then return 4
    elseif slot == 2 then return 8
    elseif slot == 3 then return 12
    elseif slot == 4 then return 16
    elseif slot == 5 then return 20 end
    return nil
end
-- Shared tunnel kill-advance: killing the guard opens its stage
-- (fly-through alone never passes an enemy stage). Global (not local):
-- level2Complete lives further down the file. Called by both the bolt
-- loop and the seeker blast, so the logic lives once.
function tunEnemyDown(self: Game, gi: number)
    local gg = self.gates[gi]
    if gg == nil then return end
    if not gg.done and (self.gateIdx or 1) == gi then
        if gi == 4 then -- guard down, but the eye must still be threaded
            if self.msg ~= nil then self.msg.value = "GUARD DOWN - THREAD THE EYE 4/20!" end
            playSfx(self, "click")
            return
        end
        gg.done = true
        self.gateIdx = gi + 1
        self.hp = 100
        if self.health ~= nil then self.health.value = 100 end
        if self.msg ~= nil then self.msg.value = "ENEMY DOWN " .. gi .. "/20!" end
        if ((self :: any).gateIntroT or 0) <= 0 and self.gateScore ~= nil then
            self.gateScore.value = self.gateIdx .. "/20"
        end
        if self.gateIdx > GATE_N then
            if self.gateScore ~= nil then self.gateScore.value = "20/20 - PORTAL!" end
            if self.msg ~= nil then self.msg.value = "ENTER THE PORTAL!" end
            ;(self :: any).gateIntroT = 0
        end
        playSfx(self, "click")
    elseif not gg.done then
        gg.done = true
    end
end
-- Tunnel guard behavior: hover its gate, spit an aimed orb every 2.2s.
-- Global like tunEnemyDown (advance calls it far below). One copy keeps
-- the per-foe loop cheap for the typechecker.
function tunGuard(self: Game, f: Foe, gi: number, gyJ: number, dt: number)
    f.atkT -= dt
    if f.atkT <= 0 and (self.homeTarget or 0) <= 0 and ((self :: any).countT or 0) <= 0 then
        f.atkT = 2.2
        local ddx, ddy, ddz = self.tx - f.x, gyJ - f.y, self.tz - f.z
        local ddl = math.sqrt(ddx * ddx + ddy * ddy + ddz * ddz)
        if ddl < 0.001 then ddl = 0.001 end
        for _, oo in ipairs((self :: any).orbs) do
            if not oo.on then
                oo.on = true
                oo.x, oo.y, oo.z = f.x, f.y, f.z
                oo.vx, oo.vy, oo.vz = ddx / ddl * ORB_SPEED, ddy / ddl * ORB_SPEED, ddz / ddl * ORB_SPEED
                oo.life = 5.0
                oo.dmg = (f.kind or 0) == 0 and 50 or 8 -- finale horrors fire 50-HP missiles, guards keep 8
                break
            end
        end
    end
end
-- Flyby checkpoint per gate (no frames to thread); the block slab kills.
-- Movers roam small so blocks stay near the dotted line.
local GATE_MAXBOX = 12 -- middle block only (frames removed); dots live apart
local GATE_EACH = GATE_MAXBOX * 36
local GATE_VERTS = GATE_N * GATE_EACH
local DOT_N = 304 -- dotted line: 19 legs x 16 steady cubes
local DOT_VERTS = DOT_N * 36
-- Aurora tunnel tube: 1 straight run x 8 octagon sides x 36 verts.
local AUR_VERTS = 288
-- Straight haunted-tunnel course: 20 stages down +z off the strip, side
-- always 0 (straight bore). Anchors stay UNWRAPPED; tile coords derive
-- per frame. Indices 4/8/12/16/20 are ENEMY stages (foe must die).
-- Alts ride a data table (cheap); dist runs 4000/i with a short head.
local GATE_ALT = { 200, 350, 200, 300, 200, 400, 200, 350, 200, 400, 200, 300, 200, 400, 200, 350, 200, 400, 200, 300 }
-- Flyby checkpoint: within this ball of the block heart counts as a pass.
local GATE_FLY = 700.0
type Foe = {
    on: boolean,
    x: number, y: number, z: number,
    ax: number, az: number, alt: number,
    r: number, sp: number, ph: number, spin: number,
    kind: number, -- 0 level-1 pumpkin, 1 cackler, 2 spitter, 3 brute
    hp: number, -- staff multi-hit pool (pumpkins die on first bolt)
    tchCd: number, -- contact-damage cooldown
    atkT: number, -- spitter orb timer
}
-- Level 2 HAUNTED CIRCUS gate: a floating circus ring. state is owned
-- by the CPU (0 upcoming, 1 next, 2 cleared); the gate WGSL pipeline
-- glows by those colors. theme picks the topper (1 pumpkin, 2 moon,
-- 3 bat, 4 witch, 5 ghost, 6 bone, 7 crown).
type Gate = {
    on: boolean,
    x: number, y: number, z: number,
    ax: number, ay: number, az: number, -- parked anchor for movers
    alt: number, yaw: number,
    ph: number, theme: number, shape: number, mv: number,
    done: boolean,
    enemy: boolean?, -- tunnel ENEMY stage: foe must die to advance
    foeSlot: number?, -- foe index guarding this stage
}
local WIND_SLOTS = 64
local WIND_EACH = 36 -- one thin streak box each
local WIND_VERTS = WIND_SLOTS * WIND_EACH
local CHUNK_SLOTS = 256 -- room for the GIGA atom-bomb volley (~174 at once)
local NUKE_QUADS = 8 -- flash + fireball + stem + cap + 2 shock + smoke x2
local NUKE_VERTS = NUKE_QUADS * 6
local CHUNK_EACH = 36 -- one box per chunk (fire, flash, smoke, debris, spark, dust)
local CHUNK_VERTS = CHUNK_SLOTS * CHUNK_EACH

type DustPuff = {
    x: number, y: number, z: number,
    vx: number, vy: number, vz: number,
    life: number, max: number,
}

type Beam = {
    on: boolean,
    x: number, y: number, z: number,
    vx: number, vy: number, vz: number,
    life: number,
    gun: number,
    stretch: number, -- tracer length factor: spans its per-frame step
}

-- Seeker missile: tkind is the lock (0 dumb, 1 foe slot, 2 boss,
-- 3 GIGA, 4 horde body); tidx is the slot/body index. The lock is
-- re-resolved every frame, so kills mid-flight just go dumb.
type Msl = {
    on: boolean,
    x: number, y: number, z: number,
    vx: number, vy: number, vz: number,
    spd: number,
    life: number,
    tkind: number,
    tidx: number,
    trailT: number, -- smoke-puff timer for the exhaust trail
}

-- Staged missile explosion billboard (fireball + shock ring pair),
-- animated purely by shader time on the missile pipeline.
type MslBoom = {
    on: boolean,
    x: number, y: number, z: number,
    kind: number, -- 1 fireball, 2 shock ring
    size: number,
    seed: number,
    birth: number,
}

-- Crash chunk kinds: 0 fire, 1 bloom flash, 2 smoke, 3 debris, 4 spark, 5 dust, 6 shockwave, 7 gun flash.
type Chunk = {
    on: boolean,
    x: number, y: number, z: number,
    vx: number, vy: number, vz: number,
    life: number, life0: number,
    kind: number,
    seed: number, -- stable per-particle random for the blast shader
}

-- Minimap breadcrumb: a past world position.
type TrailDot = {
    x: number, z: number,
}

-- Fighter-jet hero. Rigid airframe, faces +Z at yaw 0.
-- Tapered fuselage segments + stepped swept wings read as a real F-18
-- silhouette from the chase cam. Orange tips + strobe reuse the WGSL glow
-- bands; the afterburner is twin shader-driven plume shells (below).
local JET_CX, JET_CY, JET_CZ = 0.0, 1.8, 0.0
local PARTS = {
    { w = 0.35, h = 0.35, d = 0.7, cx = 0.0, cy = 1.70, cz = 3.60, r = 0.24, g = 0.22, b = 0.28, ex = 0, top = 0.80, front = 0.45 }, -- nose tip (radome)
    { w = 0.65, h = 0.60, d = 1.0, cx = 0.0, cy = 1.72, cz = 2.90, r = 0.30, g = 0.28, b = 0.34, ex = 0, front = 0.70 }, -- nose cone
    { w = 0.95, h = 0.80, d = 1.0, cx = 0.0, cy = 1.75, cz = 2.15, r = 0.33, g = 0.31, b = 0.37, ex = 0, front = 0.90 }, -- gun bay
    { w = 1.15, h = 0.90, d = 1.2, cx = 0.0, cy = 1.78, cz = 1.35, r = 0.36, g = 0.34, b = 0.40, ex = 0 }, -- fwd fuselage
    { w = 1.35, h = 1.00, d = 1.6, cx = 0.0, cy = 1.80, cz = 0.20, r = 0.38, g = 0.36, b = 0.43, ex = 0 }, -- mid / wing box
    { w = 1.45, h = 0.95, d = 1.4, cx = 0.0, cy = 1.78, cz = -1.20, r = 0.34, g = 0.32, b = 0.39, ex = 0 }, -- rear / engine hump
    { w = 0.90, h = 0.40, d = 1.2, cx = 0.0, cy = 2.05, cz = -1.90, r = 0.26, g = 0.24, b = 0.30, ex = 0, top = 0.80 }, -- tail deck
    { w = 0.50, h = 0.25, d = 2.2, cx = 0.0, cy = 2.25, cz = 0.30, r = 0.42, g = 0.40, b = 0.47, ex = 0, top = 0.70, front = 0.85 }, -- spine hump
    { w = 0.55, h = 0.50, d = 1.1, cx = 0.0, cy = 2.35, cz = 1.50, r = 0.55, g = 0.75, b = 0.95, ex = 0, top = 0.62, front = 0.70 }, -- canopy glass
    { w = 0.60, h = 0.15, d = 0.3, cx = 0.0, cy = 2.15, cz = 0.85, r = 0.18, g = 0.17, b = 0.22, ex = 0, top = 0.80 }, -- canopy frame
    { w = 0.10, h = 0.06, d = 0.5, cx = 0.15, cy = 2.62, cz = 1.50, r = 1.00, g = 0.85, b = 0.30, ex = 0 }, -- canopy sun glint
    { w = 1.00, h = 0.15, d = 1.8, cx = -0.90, cy = 1.85, cz = 0.60, r = 0.35, g = 0.33, b = 0.40, ex = 0, top = 0.85 }, -- LERX L
    { w = 1.00, h = 0.15, d = 1.8, cx = 0.90, cy = 1.85, cz = 0.60, r = 0.35, g = 0.33, b = 0.40, ex = 0, top = 0.85 }, -- LERX R
    { w = 1.20, h = 0.16, d = 1.6, cx = -1.10, cy = 1.72, cz = -0.20, r = 0.33, g = 0.31, b = 0.38, ex = 0, top = 0.90 }, -- wing root L
    { w = 1.10, h = 0.14, d = 1.2, cx = -2.10, cy = 1.70, cz = -0.55, r = 0.31, g = 0.29, b = 0.36, ex = 0, top = 0.90 }, -- wing mid L
    { w = 0.80, h = 0.12, d = 0.8, cx = -2.95, cy = 1.68, cz = -0.85, r = 0.29, g = 0.27, b = 0.34, ex = 0, top = 0.90 }, -- wing tip L
    { w = 1.20, h = 0.16, d = 1.6, cx = 1.10, cy = 1.72, cz = -0.20, r = 0.33, g = 0.31, b = 0.38, ex = 0, top = 0.90 }, -- wing root R
    { w = 1.10, h = 0.14, d = 1.2, cx = 2.10, cy = 1.70, cz = -0.55, r = 0.31, g = 0.29, b = 0.36, ex = 0, top = 0.90 }, -- wing mid R
    { w = 0.80, h = 0.12, d = 0.8, cx = 2.95, cy = 1.68, cz = -0.85, r = 0.29, g = 0.27, b = 0.34, ex = 0, top = 0.90 }, -- wing tip R
    { w = 0.20, h = 0.16, d = 0.4, cx = -3.35, cy = 1.68, cz = -0.85, r = 0.95, g = 0.50, b = 0.10, ex = 0 }, -- wingtip glow L
    { w = 0.20, h = 0.16, d = 0.4, cx = 3.35, cy = 1.68, cz = -0.85, r = 0.95, g = 0.50, b = 0.10, ex = 0 }, -- wingtip glow R
    { w = 0.18, h = 0.12, d = 1.0, cx = -1.70, cy = 1.55, cz = -0.30, r = 0.20, g = 0.19, b = 0.23, ex = 0 }, -- rail L
    { w = 0.16, h = 0.16, d = 0.9, cx = -1.70, cy = 1.42, cz = -0.20, r = 0.70, g = 0.68, b = 0.65, ex = 0, front = 0.50 }, -- missile L
    { w = 0.18, h = 0.12, d = 1.0, cx = 1.70, cy = 1.55, cz = -0.30, r = 0.20, g = 0.19, b = 0.23, ex = 0 }, -- rail R
    { w = 0.16, h = 0.16, d = 0.9, cx = 1.70, cy = 1.42, cz = -0.20, r = 0.70, g = 0.68, b = 0.65, ex = 0, front = 0.50 }, -- missile R
    { w = 0.50, h = 0.70, d = 1.4, cx = -0.85, cy = 1.45, cz = 0.90, r = 0.32, g = 0.30, b = 0.37, ex = 0, top = 0.90 }, -- intake L
    { w = 0.40, h = 0.50, d = 0.15, cx = -0.85, cy = 1.45, cz = 1.60, r = 0.03, g = 0.03, b = 0.04, ex = 0 }, -- intake mouth L
    { w = 0.50, h = 0.70, d = 1.4, cx = 0.85, cy = 1.45, cz = 0.90, r = 0.32, g = 0.30, b = 0.37, ex = 0, top = 0.90 }, -- intake R
    { w = 0.40, h = 0.50, d = 0.15, cx = 0.85, cy = 1.45, cz = 1.60, r = 0.03, g = 0.03, b = 0.04, ex = 0 }, -- intake mouth R
    { w = 0.55, h = 0.55, d = 1.2, cx = -0.55, cy = 1.6, cz = -2.2, r = 0.20, g = 0.19, b = 0.24, ex = 0, front = 0.90 }, -- engine nacelle L
    { w = 0.55, h = 0.55, d = 1.2, cx = 0.55, cy = 1.6, cz = -2.2, r = 0.20, g = 0.19, b = 0.24, ex = 0, front = 0.90 }, -- engine nacelle R
    { w = 0.14, h = 0.90, d = 1.0, cx = -0.55, cy = 2.50, cz = -1.90, r = 0.36, g = 0.34, b = 0.41, ex = 0, top = 0.55, front = 0.75 }, -- fin lower L
    { w = 0.12, h = 0.60, d = 0.7, cx = -0.62, cy = 3.20, cz = -2.05, r = 0.85, g = 0.35, b = 0.10, ex = 0, top = 0.55, front = 0.70 }, -- fin tip L (pumpkin)
    { w = 0.14, h = 0.90, d = 1.0, cx = 0.55, cy = 2.50, cz = -1.90, r = 0.36, g = 0.34, b = 0.41, ex = 0, top = 0.55, front = 0.75 }, -- fin lower R
    { w = 0.12, h = 0.60, d = 0.7, cx = 0.62, cy = 3.20, cz = -2.05, r = 0.85, g = 0.35, b = 0.10, ex = 0, top = 0.55, front = 0.70 }, -- fin tip R (pumpkin)
    { w = 1.30, h = 0.12, d = 0.7, cx = -0.95, cy = 1.95, cz = -2.20, r = 0.30, g = 0.28, b = 0.35, ex = 0, top = 0.90, front = 0.80 }, -- tailplane L
    { w = 1.30, h = 0.12, d = 0.7, cx = 0.95, cy = 1.95, cz = -2.20, r = 0.30, g = 0.28, b = 0.35, ex = 0, top = 0.90, front = 0.80 }, -- tailplane R
    { w = 0.12, h = 0.50, d = 0.6, cx = 0.0, cy = 1.25, cz = -2.00, r = 0.22, g = 0.21, b = 0.26, ex = 0, top = 0.60 }, -- ventral fin
    { w = 0.12, h = 0.10, d = 0.12, cx = 0.0, cy = 2.32, cz = -1.90, r = 0.95, g = 0.95, b = 0.95, ex = 0 }, -- tail strobe
    { w = 0.70, h = 0.70, d = 0.25, cx = -0.55, cy = 1.6, cz = -2.75, r = 0.22, g = 0.13, b = 0.08, ex = 8 }, -- nozzle rim L
    { w = 0.12, h = 0.12, d = 0.30, cx = -0.88, cy = 1.60, cz = -2.90, r = 0.16, g = 0.15, b = 0.18, ex = 8 }, -- petal L1
    { w = 0.12, h = 0.12, d = 0.30, cx = -0.22, cy = 1.60, cz = -2.90, r = 0.16, g = 0.15, b = 0.18, ex = 8 }, -- petal L2
    { w = 0.12, h = 0.12, d = 0.30, cx = -0.55, cy = 1.27, cz = -2.90, r = 0.16, g = 0.15, b = 0.18, ex = 8 }, -- petal L3
    { w = 0.12, h = 0.12, d = 0.30, cx = -0.55, cy = 1.93, cz = -2.90, r = 0.16, g = 0.15, b = 0.18, ex = 8 }, -- petal L4
    { w = 0.70, h = 0.70, d = 0.25, cx = 0.55, cy = 1.6, cz = -2.75, r = 0.22, g = 0.13, b = 0.08, ex = 8 }, -- nozzle rim R
    { w = 0.12, h = 0.12, d = 0.30, cx = 0.22, cy = 1.60, cz = -2.90, r = 0.16, g = 0.15, b = 0.18, ex = 8 }, -- petal R1
    { w = 0.12, h = 0.12, d = 0.30, cx = 0.88, cy = 1.60, cz = -2.90, r = 0.16, g = 0.15, b = 0.18, ex = 8 }, -- petal R2
    { w = 0.12, h = 0.12, d = 0.30, cx = 0.55, cy = 1.27, cz = -2.90, r = 0.16, g = 0.15, b = 0.18, ex = 8 }, -- petal R3
    { w = 0.12, h = 0.12, d = 0.30, cx = 0.55, cy = 1.93, cz = -2.90, r = 0.16, g = 0.15, b = 0.18, ex = 8 }, -- petal R4
    { w = 0.50, h = 0.06, d = 0.90, cx = 0.0, cy = 2.32, cz = -0.60, r = 0.25, g = 0.24, b = 0.29, ex = 0 }, -- speedbrake panel
    { w = 0.06, h = 0.18, d = 1.00, cx = -0.69, cy = 1.95, cz = 0.20, r = 0.55, g = 1.00, b = 0.45, ex = 0 }, -- slime light L
    { w = 0.06, h = 0.18, d = 1.00, cx = 0.69, cy = 1.95, cz = 0.20, r = 0.55, g = 1.00, b = 0.45, ex = 0 }, -- slime light R
    { w = 0.04, h = 0.20, d = 0.50, cx = -0.49, cy = 1.75, cz = 2.15, r = 0.05, g = 0.05, b = 0.06, ex = 0 }, -- gun vent
    { w = 0.08, h = 0.85, d = 0.08, cx = 0.0, cy = 0.92, cz = 2.50, r = 0.40, g = 0.38, b = 0.44, ex = 0, gear = 1 }, -- nose strut
    { w = 0.06, h = 0.40, d = 0.06, cx = 0.0, cy = 0.72, cz = 2.50, r = 0.80, g = 0.82, b = 0.85, ex = 0, gear = 1 }, -- nose oleo piston (chrome)
    { cyl = 1, r = 0.25, w = 0.20, h = 0, d = 0, ex = 0, g = 0, b = 0, hub = 0.11, cx = 0.0, cy = 0.37, cz = 2.50, gear = 1 }, -- nose wheel (round, WGSL rubber)
    { w = 0.10, h = 0.90, d = 0.10, cx = -0.95, cy = 0.90, cz = 0.00, r = 0.40, g = 0.38, b = 0.44, ex = 0, gear = 1 }, -- main strut L
    { w = 0.07, h = 0.42, d = 0.07, cx = -0.95, cy = 0.70, cz = 0.00, r = 0.80, g = 0.82, b = 0.85, ex = 0, gear = 1 }, -- main oleo piston L (chrome)
    { cyl = 1, r = 0.28, w = 0.24, h = 0, d = 0, ex = 0, g = 0, b = 0, hub = 0.12, cx = -0.95, cy = 0.40, cz = 0.00, gear = 1 }, -- main wheel L (round, WGSL rubber)
    { w = 0.10, h = 0.90, d = 0.10, cx = 0.95, cy = 0.90, cz = 0.00, r = 0.40, g = 0.38, b = 0.44, ex = 0, gear = 1 }, -- main strut R
    { w = 0.07, h = 0.42, d = 0.07, cx = 0.95, cy = 0.70, cz = 0.00, r = 0.80, g = 0.82, b = 0.85, ex = 0, gear = 1 }, -- main oleo piston R (chrome)
    { cyl = 1, r = 0.28, w = 0.24, h = 0, d = 0, ex = 0, g = 0, b = 0, hub = 0.12, cx = 0.95, cy = 0.40, cz = 0.00, gear = 1 }, -- main wheel R (round, WGSL rubber)
    { w = 0.14, h = 0.14, d = 0.80, cx = 0.0, cy = 1.70, cz = 4.10, r = 0.12, g = 0.12, b = 0.14, ex = 0 }, -- nose cannon barrel
    { w = 0.20, h = 0.20, d = 0.15, cx = 0.0, cy = 1.70, cz = 4.45, r = 0.18, g = 0.17, b = 0.20, ex = 0 }, -- muzzle brake ring
}

-- Plane paint: 4 settings-box picks. Multiplicative tints applied to
-- gray airframe parts only (glass, glows, rubber, plume markers and
-- dark vents keep their colors, so no jet.wgsl emissive band misfires).
-- Plain if-chain (not a table) to keep type inference cheap.

-- Vert-exact hero size: boxes are 36 verts, round wheels (cyl=1: 24
-- tread + 48 sidewall + 32 hub + 20 spoke tris = 124 tris) are 372.
local HERO_VERTS = PLUME_VERTS
for _, p in ipairs(PARTS) do
    if (p :: any).cyl == 1 then
        HERO_VERTS += 372
    else
        HERO_VERTS += 36
    end
end

-- Rigid-body builder: pitch about X, roll about Z, then yaw about Y.
-- swings[1] = pitch, swings[2] = roll (kept as swings table so call sites stay small).
local function buildHero(buf: buffer, hx: number, hy: number, hz: number, yaw: number, swings: { number }, flash: number?, glow: number?)
    local o = 0
    local cy = math.cos(yaw)
    local sy = math.sin(yaw)
    -- Damage flash: 1 right after an orb hit, decays in advance().
    -- Body + wheels lerp to white; plume markers stay raw (WGSL bands).
    -- GIGA glow: a hotter, longer burn stacked on top — pushed past 1.0
    -- so the whole airframe catches the jet.wgsl strobe band and blazes.
    local fl = math.clamp(flash or 0, 0, 1)
    local gl = math.clamp(glow or 0, 0, 1)
    local function fw(c: number): number return c + (1 - c) * fl + gl * 1.8 end
    local pitch = swings[1] or 0
    local roll = swings[2] or 0
    -- Paint pick rides swings[7] (call site appends planeTint, default 1).
    local t7 = swings[7] or 1
    local tr0, tg0, tb0 = 1.0, 1.0, 1.0
    if t7 == 2 then tr0, tg0, tb0 = 1.45, 0.62, 0.62 -- CRIMSON
    elseif t7 == 3 then tr0, tg0, tb0 = 0.62, 1.05, 1.55 -- AZURE
    elseif t7 == 4 then tr0, tg0, tb0 = 0.62, 1.35, 0.62 -- VIPER
    elseif t7 == 5 then tr0, tg0, tb0 = 1.30, 0.70, 1.60 end -- PURPLE
    local cp, sp = math.cos(pitch), math.sin(pitch)
    local cr, sr = math.cos(roll), math.sin(roll)
    -- 12 floats per vert: pos(3) + world normal(3) + color(3) + object-space(3).
    local function push12(x: number, y: number, z: number,
        nx: number, ny: number, nz: number,
        r: number, g: number, b: number,
        lx: number, ly: number, lz: number)
        buffer.writef32(buf, o, x); o += 4
        buffer.writef32(buf, o, y); o += 4
        buffer.writef32(buf, o, z); o += 4
        buffer.writef32(buf, o, nx); o += 4
        buffer.writef32(buf, o, ny); o += 4
        buffer.writef32(buf, o, nz); o += 4
        buffer.writef32(buf, o, r); o += 4
        buffer.writef32(buf, o, g); o += 4
        buffer.writef32(buf, o, b); o += 4
        buffer.writef32(buf, o, lx); o += 4
        buffer.writef32(buf, o, ly); o += 4
        buffer.writef32(buf, o, lz); o += 4
    end
    -- Round aircraft wheel (cyl=1): treaded tire with molded tread blocks,
    -- dished sidewalls, polished hub + rim band, 5 steel spokes per side.
    -- Rigid-body path matches the boxes; winding auto-faces outward.
    -- Tire verts carry smooth radial normals (rubber shades smooth in WGSL);
    -- metal bits carry facet normals. Roll spin comes in on swings[6].
    local function buildWheel(p: any, gearDn: number, spin: number)
        local wr: number = p.r
        local ww: number, hr: number = p.w, p.hub
        if p.gear == 1 and gearDn <= 0 then wr, ww, hr = 0, 0, 0 end -- retracted: a point
        local cx0, cy0, cz0 = p.cx - JET_CX, p.cy - JET_CY, p.cz - JET_CZ
        local csp, snp = math.cos(spin), math.sin(spin)
        local function xf(lx: number, ly: number, lz: number): { number }
            local vx, vy, vz = lx + cx0, ly + cy0, lz + cz0
            local py = vy * cp - vz * sp
            local pz = vy * sp + vz * cp
            local rx = vx * cr - py * sr
            local ry2 = vx * sr + py * cr
            return { rx * cy + pz * sy + JET_CX + hx,
                ry2 + JET_CY + hy, -rx * sy + pz * cy + JET_CZ + hz }
        end
        local function xn(nx: number, ny: number, nz: number): { number }
            local py = ny * cp - nz * sp
            local pz = ny * sp + nz * cp
            local rx = nx * cr - py * sr
            local ry2 = nx * sr + py * cr
            return { rx * cy + pz * sy, ry2, -rx * sy + pz * cy }
        end
        -- One tri, auto-wound: flips when the facet normal opposes the
        -- outward reference, so caps/fans can share one code path.
        local function tri(ax: number, ay: number, az: number,
            bx: number, by: number, bz: number,
            cx: number, cyv: number, cz: number,
            ox: number, oy: number, oz: number,
            anx: number, any: number, anz: number,
            bnx: number, bny: number, bnz: number,
            cnx: number, cny: number, cnz: number,
            r: number, g: number, b: number,
            lax: number, lay: number, laz: number,
            lbx: number, lby: number, lbz: number,
            lcx: number, lcy: number, lcz: number)
            local abx, aby, abz = bx - ax, by - ay, bz - az
            local acx, acy, acz = cx - ax, cyv - ay, cz - az
            local nx = aby * acz - abz * acy
            local ny = abz * acx - abx * acz
            local nz = abx * acy - aby * acx
            if nx * ox + ny * oy + nz * oz < 0 then
                bx, by, bz, bnx, bny, bnz, lbx, lby, lbz,
                    cx, cyv, cz, cnx, cny, cnz, lcx, lcy, lcz =
                    cx, cyv, cz, cnx, cny, cnz, lcx, lcy, lcz,
                    bx, by, bz, bnx, bny, bnz, lbx, lby, lbz
            end
            local a = xf(ax, ay, az)
            local bb = xf(bx, by, bz)
            local cc = xf(cx, cyv, cz)
            local an = xn(anx, any, anz)
            local bn = xn(bnx, bny, bnz)
            local cn = xn(cnx, cny, cnz)
            push12(a[1], a[2], a[3], an[1], an[2], an[3], fw(r), fw(g), fw(b),
                lax + cx0, lay + cy0, laz + cz0)
            push12(bb[1], bb[2], bb[3], bn[1], bn[2], bn[3], fw(r), fw(g), fw(b),
                lbx + cx0, lby + cy0, lbz + cz0)
            push12(cc[1], cc[2], cc[3], cn[1], cn[2], cn[3], fw(r), fw(g), fw(b),
                lcx + cx0, lcy + cy0, lcz + cz0)
        end
        -- Spin a design-space ring point (axle = X axis) into place.
        local function ring(px: number, ang: number, rad: number): { number }
            local dy, dz = rad * math.cos(ang), rad * math.sin(ang)
            return { px, dy * csp - dz * snp, dy * snp + dz * csp }
        end
        local T, H, SPK = 12, 8, 5
        local RUB_R, RUB_G, RUB_B = 0.055, 0.055, 0.065
        for i = 0, T - 1 do
            local a0 = i / T * math.pi * 2.0
            local a1 = (i + 1) / T * math.pi * 2.0
            local r0 = wr * (1 - 0.07 * (i % 2)) -- molded tread blocks
            local r1 = wr * (1 - 0.07 * ((i + 1) % 2))
            local sh0 = 1.0 - 0.28 * (i % 2)
            local sh1 = 1.0 - 0.28 * ((i + 1) % 2)
            local hwx = ww / 2.0
            local p0 = ring(-hwx, a0, r0)
            local p1 = ring(hwx, a0, r0)
            local p2 = ring(hwx, a1, r1)
            local p3 = ring(-hwx, a1, r1)
            local n0 = { 0, math.cos(a0), math.sin(a0) }
            local n1 = { 0, math.cos(a1), math.sin(a1) }
            local amid = (a0 + a1) / 2.0
            local out = { 0, math.cos(amid), math.sin(amid) }
            tri(p0[1], p0[2], p0[3], p1[1], p1[2], p1[3], p2[1], p2[2], p2[3],
                out[1], out[2], out[3],
                n0[1], n0[2], n0[3], n0[1], n0[2], n0[3], n1[1], n1[2], n1[3],
                RUB_R * sh0, RUB_G * sh0, RUB_B * sh0,
                p0[1], p0[2], p0[3], p1[1], p1[2], p1[3], p2[1], p2[2], p2[3])
            tri(p0[1], p0[2], p0[3], p2[1], p2[2], p2[3], p3[1], p3[2], p3[3],
                out[1], out[2], out[3],
                n0[1], n0[2], n0[3], n1[1], n1[2], n1[3], n1[1], n1[2], n1[3],
                RUB_R * sh1, RUB_G * sh1, RUB_B * sh1,
                p0[1], p0[2], p0[3], p2[1], p2[2], p2[3], p3[1], p3[2], p3[3])
            -- Dished sidewalls: fan from the tread ring down to the hub.
            for _, sgn in ipairs({ -1.0, 1.0 }) do
                local sx = sgn * hwx
                local c0 = ring(sx, a0, r0)
                local c1 = ring(sx, a1, r1)
                local h0 = ring(sx, a0, hr)
                local h1 = ring(sx, a1, hr)
                local sn2 = { sgn, 0, 0 }
                tri(c0[1], c0[2], c0[3], c1[1], c1[2], c1[3], h1[1], h1[2], h1[3],
                    sn2[1], sn2[2], sn2[3],
                    sn2[1], sn2[2], sn2[3], sn2[1], sn2[2], sn2[3], sn2[1], sn2[2], sn2[3],
                    RUB_R, RUB_G, RUB_B,
                    c0[1], c0[2], c0[3], c1[1], c1[2], c1[3], h1[1], h1[2], h1[3])
                tri(c0[1], c0[2], c0[3], h1[1], h1[2], h1[3], h0[1], h0[2], h0[3],
                    sn2[1], sn2[2], sn2[3],
                    sn2[1], sn2[2], sn2[3], sn2[1], sn2[2], sn2[3], sn2[1], sn2[2], sn2[3],
                    RUB_R, RUB_G, RUB_B,
                    c0[1], c0[2], c0[3], h1[1], h1[2], h1[3], h0[1], h0[2], h0[3])
            end
        end
        local AL_R, AL_G, AL_B = 0.62, 0.64, 0.68 -- cast aluminum hub
        local RIM_R, RIM_G, RIM_B = 0.82, 0.84, 0.87 -- polished rim band
        local hwx2 = ww * 0.58
        for i = 0, H - 1 do
            local a0 = i / H * math.pi * 2.0
            local a1 = (i + 1) / H * math.pi * 2.0
            local q0 = ring(-hwx2, a0, hr)
            local q1 = ring(hwx2, a0, hr)
            local q2 = ring(hwx2, a1, hr)
            local q3 = ring(-hwx2, a1, hr)
            local amid = (a0 + a1) / 2.0
            local out = { 0, math.cos(amid), math.sin(amid) }
            local n0 = { 0, math.cos(a0), math.sin(a0) }
            local n1 = { 0, math.cos(a1), math.sin(a1) }
            tri(q0[1], q0[2], q0[3], q1[1], q1[2], q1[3], q2[1], q2[2], q2[3],
                out[1], out[2], out[3],
                n0[1], n0[2], n0[3], n0[1], n0[2], n0[3], n1[1], n1[2], n1[3],
                RIM_R, RIM_G, RIM_B,
                q0[1], q0[2], q0[3], q1[1], q1[2], q1[3], q2[1], q2[2], q2[3])
            tri(q0[1], q0[2], q0[3], q2[1], q2[2], q2[3], q3[1], q3[2], q3[3],
                out[1], out[2], out[3],
                n0[1], n0[2], n0[3], n1[1], n1[2], n1[3], n1[1], n1[2], n1[3],
                RIM_R, RIM_G, RIM_B,
                q0[1], q0[2], q0[3], q2[1], q2[2], q2[3], q3[1], q3[2], q3[3])
            for _, sgn in ipairs({ -1.0, 1.0 }) do -- hub caps (aluminum)
                local sx = sgn * hwx2
                local c = { sx, 0, 0 }
                local e0 = ring(sx, a0, hr)
                local e1 = ring(sx, a1, hr)
                local sn2 = { sgn, 0, 0 }
                tri(c[1], c[2], c[3], e0[1], e0[2], e0[3], e1[1], e1[2], e1[3],
                    sn2[1], sn2[2], sn2[3],
                    sn2[1], sn2[2], sn2[3], sn2[1], sn2[2], sn2[3], sn2[1], sn2[2], sn2[3],
                    AL_R, AL_G, AL_B,
                    c[1], c[2], c[3], e0[1], e0[2], e0[3], e1[1], e1[2], e1[3])
            end
        end
        local SP_R, SP_G, SP_B = 0.25, 0.26, 0.30 -- steel spokes
        -- Spokes, polar quads: inner/outer radius x angular half-width.
        for s = 0, SPK - 1 do
            local m = (s + 0.5) / SPK * math.pi * 2.0
            local da = hr * 0.26 / hr
            local r1, r2 = hr * 0.30, hr * 0.95
            for _, sgn in ipairs({ -1.0, 1.0 }) do
                local sx = sgn * (hwx2 + 0.005)
                local function sp2(rr: number, aa: number): { number }
                    local yy, zz = rr * math.cos(aa), rr * math.sin(aa)
                    return { sx, yy * csp - zz * snp, yy * snp + zz * csp }
                end
                local v0 = sp2(r1, m - da)
                local v1 = sp2(r2, m - da)
                local v2 = sp2(r2, m + da)
                local v3 = sp2(r1, m + da)
                local sn2 = { sgn, 0, 0 }
                tri(v0[1], v0[2], v0[3], v1[1], v1[2], v1[3], v2[1], v2[2], v2[3],
                    sn2[1], sn2[2], sn2[3],
                    sn2[1], sn2[2], sn2[3], sn2[1], sn2[2], sn2[3], sn2[1], sn2[2], sn2[3],
                    SP_R, SP_G, SP_B,
                    v0[1] - sx, v0[2], v0[3], v1[1] - sx, v1[2], v1[3], v2[1] - sx, v2[2], v2[3])
                tri(v0[1], v0[2], v0[3], v2[1], v2[2], v2[3], v3[1], v3[2], v3[3],
                    sn2[1], sn2[2], sn2[3],
                    sn2[1], sn2[2], sn2[3], sn2[1], sn2[2], sn2[3], sn2[1], sn2[2], sn2[3],
                    SP_R, SP_G, SP_B,
                    v0[1] - sx, v0[2], v0[3], v2[1] - sx, v2[2], v2[3], v3[1] - sx, v3[2], v3[3])
            end
        end
    end
    for pi, p in ipairs(PARTS) do
        local hxw = p.w / 2.0
        local hyw = p.h / 2.0
        local hzw = p.d / 2.0
        -- Retractable gear: airborne collapses the part to a point (zero
        -- pixels, vert count untouched). swings[5] = 1 while on the gear.
        if (p :: any).gear == 1 and (swings[5] or 1) <= 0 then
            hxw, hyw, hzw = 0, 0, 0
        end
        -- Round wheels branch off to the WGSL-shaded wheel builder.
        if (p :: any).cyl == 1 then
            buildWheel(p, swings[5] or 1, swings[6] or 0)
            continue
        end
        -- Nozzle collar (ex 7): grows backward from its design front face
        -- with the throttle root so it never gaps the plume shells.
        local zoff = 0.0
        local ex = p.ex or 0
        if ex >= 1 and ex <= 6 then
            local ese = (swings[3] or 1) * (1 + 0.12 * math.sin((swings[4] or 0) * 43.0 + ex * 1.3))
            local front = p.cz + p.d / 2.0
            hzw *= ese
            zoff = (front - hzw) - p.cz
        elseif ex == 7 then
            local e2 = math.sqrt(swings[3] or 1)
            local front = p.cz + p.d / 2.0
            hzw *= e2
            zoff = (front - hzw) - p.cz
        end
        -- Tapered corners: p.top shrinks the roof face (canopy bubble,
        -- knife-edge fins), p.front shrinks the nose face (pointed nose,
        -- missile tips). Facet normals come from the world-space tris, so
        -- every slope lights correctly in the jet WGSL pipeline.
        local tops = (p :: any).top or 1.0
        local fronts = (p :: any).front or 1.0
        local ox, oy, oz = p.cx - JET_CX, p.cy - JET_CY, p.cz - JET_CZ
        local wpts = {}
        local lpts = {}
        for _, sg in ipairs({
            { -1.0, -1.0, -1.0 }, { 1.0, -1.0, -1.0 }, { 1.0, 1.0, -1.0 }, { -1.0, 1.0, -1.0 },
            { -1.0, -1.0, 1.0 }, { 1.0, -1.0, 1.0 }, { 1.0, 1.0, 1.0 }, { -1.0, 1.0, 1.0 },
        }) do
            local ts = 1.0
            if sg[2] > 0 then ts = tops end
            local fs = 1.0
            if sg[3] > 0 then fs = fronts end
            local qx = sg[1] * hxw * ts * fs
            local qy = sg[2] * hyw * fs
            local qz = sg[3] * hzw * ts
            table.insert(lpts, { qx + ox, qy + oy, qz + oz })
            -- offset from jet center, pitch about X, roll about Z, yaw about Y.
            local vx = qx + ox
            local vy = qy + oy
            local vz = qz + oz + zoff
            local py = vy * cp - vz * sp
            local pz = vy * sp + vz * cp
            local rx = vx * cr - py * sr
            local ry2 = vx * sr + py * cr
            local wx = rx * cy + pz * sy + JET_CX
            local wz = -rx * sy + pz * cy + JET_CZ
            local wy = ry2 + JET_CY
            table.insert(wpts, { wx + hx, wy + hy, wz + hz })
        end
        local F = {
            { 5, 6, 7 }, { 5, 7, 8 }, -- front z+
            { 2, 1, 4 }, { 2, 4, 3 }, -- back z-
            { 1, 5, 8 }, { 1, 8, 4 }, -- left x-
            { 6, 2, 3 }, { 6, 3, 7 }, -- right x+
            { 8, 7, 3 }, { 8, 3, 4 }, -- top y+
            { 1, 2, 6 }, { 1, 6, 5 }, -- bottom y-
        }
        -- Flat facets: one world-space normal per tri (exact under taper
        -- and exhaust stretch). Baked shading is just a whisper of belly
        -- AO + panel tone now; the jet shader does the real lighting.
        local ph = math.sin(pi * 12.9898) * 43758.5453
        local tone = 0.985 + 0.03 * (ph - math.floor(ph))
        local shades = { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.82, 0.82 }
        for fi, f in ipairs(F) do
            local a = wpts[f[1]]
            local b = wpts[f[2]]
            local cc = wpts[f[3]]
            local abx, aby, abz = b[1] - a[1], b[2] - a[2], b[3] - a[3]
            local acx, acy, acz = cc[1] - a[1], cc[2] - a[2], cc[3] - a[3]
            local nx = aby * acz - abz * acy
            local ny = abz * acx - abx * acz
            local nz = abx * acy - aby * acx
            local nl = math.sqrt(nx * nx + ny * ny + nz * nz)
            if nl > 0.00001 then nx, ny, nz = nx / nl, ny / nl, nz / nl end
            local s = tone * shades[fi]
            -- Airframe paint: gray box parts (no exhaust/gear/cyl) take the
            -- settings tint; everything else keeps its authored color.
            local tr, tg, tb = 1, 1, 1
            if (p :: any).cyl == nil and (p :: any).gear == nil and (p.ex or 0) == 0
                and p.r >= 0.25 and p.r <= 0.45 and p.g >= 0.22 and p.g <= 0.42
                and p.b >= 0.28 and p.b <= 0.50 then
                tr, tg, tb = tr0, tg0, tb0
            end
            for _, vi in ipairs(f) do
                local v = wpts[vi]
                local lp = lpts[vi]
                push12(v[1], v[2], v[3], nx, ny, nz,
                    fw(p.r * s * tr), fw(p.g * s * tg), fw(p.b * s * tb), lp[1], lp[2], lp[3])
            end
        end
    end
    -- Twin afterburner plumes (WGSL-shaded): smooth 8-sided shells, outer
    -- sheath + hot core per engine. Marker colors catch no other WGSL band
    -- (outer r 0.13-0.24/g 0.35, core r 0.08-0.19/g 0.22, b 1.0; red
    -- encodes speed heat); local packs (cos a, sin a,
    -- axial t) for Mach diamonds + edge erosion. Length + girth follow
    -- cruising speed via swings[3].
    do
        local est = swings[3] or 1
        local plen = 0.8 + 0.9 * est
        local rsc = 0.85 + 0.28 * est
        -- Speed heat: 0 lazing, 1 full chat. Encoded in the plume marker
        -- red channel (outer 0.13->0.24, core 0.08->0.19); the WGSL tip
        -- gradient burns from orange toward deep red with it.
        local heat = math.clamp((est - 0.7) / 1.8, 0, 1)
        local z0 = -2.95
        local function rad(r0: number, t: number): number
            -- Exit starts slim (0.78x), swells by t=0.25, then tapers to a
            -- blunt tip keeping ~25% width.
            local g = math.clamp(t / 0.25, 0, 1)
            g = g * g * (3 - 2 * g)
            local r = r0 * (0.78 + 0.30 * g)
            local s = math.clamp((t - 0.05) / 0.95, 0, 1)
            r *= 1 - 0.75 * s * s * (3 - 2 * s)
            -- Rounded close: the last stretch shuts to near-point so no
            -- flat cap disc faces the viewer (no dots from behind).
            local e = math.clamp((t - 0.85) / 0.15, 0, 1)
            e = e * e * (3 - 2 * e)
            r *= 1 - 0.92 * e
            if r < 0.008 then r = 0.008 end
            return r
        end
        local function emit(lx: number, ly: number, lz: number,
            nx: number, ny: number, nz: number,
            mr: number, mg: number, mb: number, ca: number, sa: number, t: number)
            local vx = lx - JET_CX
            local vy = ly - JET_CY
            local vz = lz - JET_CZ
            local qy = vy * cp - vz * sp
            local qz = vy * sp + vz * cp
            local qx = vx * cr - qy * sr
            local qy2 = vx * sr + qy * cr
            local nqy = ny * cp - nz * sp
            local nqz = ny * sp + nz * cp
            local nqx = nx * cr - nqy * sr
            local nqy2 = nx * sr + nqy * cr
            push12(qx * cy + qz * sy + JET_CX + hx, qy2 + JET_CY + hy, -qx * sy + qz * cy + JET_CZ + hz,
                nqx * cy + nqz * sy, nqy2, -nqx * sy + nqz * cy,
                mr, mg, mb, ca, sa, t)
        end
        local function shell(ecx: number, len: number, r0: number, bands: number,
            mr: number, mg: number, mb: number)
            local rings = {}
            for j = 0, bands do
                local t = j / bands
                local r = rad(r0, t)
                local ta = math.max(0, t - 0.02)
                local tb = math.min(1, t + 0.02)
                local rp = (rad(r0, tb) - rad(r0, ta)) / (tb - ta)
                local nl = math.sqrt(len * len + rp * rp * r * r)
                local row = {}
                for s = 0, PLUME_SIDES - 1 do
                    local a = (s / PLUME_SIDES) * math.pi * 2
                    local ca, sa = math.cos(a), math.sin(a)
                    row[s + 1] = { ecx + r * ca, 1.6 + r * sa, z0 - t * len,
                        len * ca / nl, len * sa / nl, rp * r / nl, ca, sa, t }
                end
                rings[j + 1] = row
            end
            for j = 1, bands do
                for s = 1, PLUME_SIDES do
                    local s2 = s % PLUME_SIDES + 1
                    local a = rings[j][s]
                    local b = rings[j][s2]
                    local c = rings[j + 1][s]
                    local d = rings[j + 1][s2]
                    emit(a[1], a[2], a[3], a[4], a[5], a[6], mr, mg, mb, a[7], a[8], a[9])
                    emit(b[1], b[2], b[3], b[4], b[5], b[6], mr, mg, mb, b[7], b[8], b[9])
                    emit(d[1], d[2], d[3], d[4], d[5], d[6], mr, mg, mb, d[7], d[8], d[9])
                    emit(a[1], a[2], a[3], a[4], a[5], a[6], mr, mg, mb, a[7], a[8], a[9])
                    emit(d[1], d[2], d[3], d[4], d[5], d[6], mr, mg, mb, d[7], d[8], d[9])
                    emit(c[1], c[2], c[3], c[4], c[5], c[6], mr, mg, mb, c[7], c[8], c[9])
                end
            end
            local tip = rings[bands + 1]
            for s = 1, PLUME_SIDES do
                local s2 = s % PLUME_SIDES + 1
                local a = tip[s]
                local b = tip[s2]
                emit(a[1], a[2], a[3], a[4], a[5], a[6], mr, mg, mb, a[7], a[8], a[9])
                emit(b[1], b[2], b[3], b[4], b[5], b[6], mr, mg, mb, b[7], b[8], b[9])
                emit(ecx, 1.6, z0 - len, 0, 0, -1, mr, mg, mb, 0, 0, 1)
            end
        end
        for _, ecx in ipairs({ -0.55, 0.55 }) do
            shell(ecx, plen, 0.34 * rsc, PLUME_OUTER_BANDS, 0.13 + 0.11 * heat, 0.35, 1.0)
            shell(ecx, plen * 0.55, 0.20 * rsc, PLUME_CORE_BANDS, 0.08 + 0.11 * heat, 0.22, 1.0)
        end
    end
    return o
end

-- Single-color box writer at an explicit buffer offset (for dust puffs).
-- Oriented golden beam: core + halo boxes stretched along yaw.
-- Appends BEAM_EACH verts at offset o. Colors trigger the WGSL gold glow.
local function buildBeam(buf: buffer, o: number, bx: number, by: number, bz: number, yaw: number, pulse: number, gun: number, stretch: number): number
    local function box(len: number, h: number, w: number, r: number, g: number, b: number)
        local fx, fz = math.sin(yaw), math.cos(yaw)
        local sx, sz = math.cos(yaw), -math.sin(yaw)
        local hl, hh, hw = len / 2.0, h / 2.0, w / 2.0
        local c = {}
        for _, sgn in ipairs({ -1.0, 1.0 }) do
            for _, up in ipairs({ -1.0, 1.0 }) do
                for _, side in ipairs({ -1.0, 1.0 }) do
                    table.insert(c, {
                        bx + fx * hl * sgn + sx * hw * side,
                        by + hh * up,
                        bz + fz * hl * sgn + sz * hw * side,
                    })
                end
            end
        end
        -- c order: for sgn(-1,1) -> up(-1,1) -> side(-1,1): indices 1..8.
        -- 1=(-l,-h,-w) 2=(-l,-h,+w) 3=(-l,+h,-w) 4=(-l,+h,+w)
        -- 5=(+l,-h,-w) 6=(+l,-h,+w) 7=(+l,+h,-w) 8=(+l,+h,+w)
        local F = {
            { 5, 6, 8 }, { 5, 8, 7 }, -- +len cap
            { 2, 4, 3 }, { 2, 3, 1 }, -- -len cap
            { 1, 5, 6 }, { 1, 6, 2 }, -- bottom
            { 3, 4, 8 }, { 3, 8, 7 }, -- top
            { 1, 3, 7 }, { 1, 7, 5 }, -- -side
            { 2, 6, 8 }, { 2, 8, 4 }, -- +side
        }
        for _, f in ipairs(F) do
            for _, vi in ipairs(f) do
                local v = c[vi]
                buffer.writef32(buf, o, v[1]); o += 4
                buffer.writef32(buf, o, v[2]); o += 4
                buffer.writef32(buf, o, v[3]); o += 4
                buffer.writef32(buf, o, r); o += 4
                buffer.writef32(buf, o, g); o += 4
                buffer.writef32(buf, o, b); o += 4
            end
        end
    end
    if gun == 3 then -- Giga Beam: long straight red laser, 3s burn
        box((80.0 + pulse * 4) * stretch, 0.9, 0.9, 1.0, 0.08, 0.06)
        box((82.0 + pulse * 4) * stretch, 2.6, 2.6, 1.0, 0.14, 0.10)
    elseif gun == 2 then -- Hammer: short fat ember-orange pellet
        box((5.0 + pulse) * stretch, 2.2 + pulse * 0.4, 2.2 + pulse * 0.4, 1.0, 0.45, 0.08)
        box((5.4 + pulse) * stretch, 3.6 + pulse * 0.6, 3.6 + pulse * 0.6, 0.90, 0.30, 0.05)
    elseif gun == 4 then -- zombie orb: bright-blue ball, blue-hot heart
        box((8.0 + pulse) * stretch, 2.6 + pulse * 0.4, 2.6 + pulse * 0.4, 0.30, 0.60, 1.0)
        box((8.6 + pulse) * stretch, 4.2 + pulse * 0.6, 4.2 + pulse * 0.6, 0.50, 0.80, 1.0)
    elseif gun == 5 then -- Horde needle: thin blood-red tracer, hot core
        box((30.0 + pulse * 2) * stretch, 0.35, 0.35, 1.0, 0.25, 0.10)
        box((32.0 + pulse * 2) * stretch, 1.10, 1.10, 0.80, 0.08, 0.03)
    elseif gun == 6 then -- zombie fire: thin pop-blue needles, small bright halo (dotted, never streaks)
        box(3.0 + pulse * 0.3, 1.8 + pulse * 0.2, 1.8 + pulse * 0.2, 0.30, 0.70, 1.0)
        box(5.0 + pulse * 0.5, 3.2 + pulse * 0.3, 3.2 + pulse * 0.3, 0.20, 0.50, 1.0)
    elseif gun == 7 then -- launcher missile: fat white-hot head, long white trail (reads at 20k+)
        box(16.0 + pulse, 5.0 + pulse * 0.5, 5.0 + pulse * 0.5, 1.0, 1.0, 1.0)
        box(500.0 + pulse * 4, 2.2, 2.2, 0.95, 0.97, 1.0)
    else -- Inferno: thick golden slug, ammo only (3x size)
        box((42.0 + pulse * 3) * stretch, 1.65 + pulse * 0.24, 1.65 + pulse * 0.24, 1.0, 0.85, 0.30)
        box((43.8 + pulse * 3) * stretch, 3.60 + pulse * 0.45, 3.60 + pulse * 0.45, 1.0, 0.65, 0.20)
    end
    return o
end

-- Floating pumpkin foe for the WGSL foe pipeline: 7 floats per vert
-- (pos + color + phase seed), spun around Y so the jack-o-lantern
-- slowly rotates. Green body, glowing yellow face, dry stem.
local function buildFoe(buf: buffer, o: number, f: Foe): number
    local S = 8.0 -- round-1 pumpkins fly big and green, face carved large
    local bodyR, bodyG, bodyB = 0.16, 0.72, 0.18 -- level-1 green rind
    if f.kind == 1 then -- cackler: bruise-purple rind, same candle face
        bodyR, bodyG, bodyB = 0.60, 0.25, 0.95
    elseif f.kind == 2 then -- spitter: blood-red rind
        bodyR, bodyG, bodyB = 0.85, 0.12, 0.10
    elseif f.kind == 3 then -- brute: rust-orange slab, 25% bigger
        bodyR, bodyG, bodyB = 0.95, 0.45, 0.10
        S = 10.0
    elseif f.kind == 4 then -- hell pumpkin: bright-orange rind, same candle face
        bodyR, bodyG, bodyB = 1.00, 0.50, 0.06
    end
    local cs, sn = math.cos(f.spin), math.sin(f.spin)
    local function box(w: number, h: number, d: number, ox: number, oy: number, oz: number, r: number, g: number, b: number)
        local hw, hh, hd = w / 2.0, h / 2.0, d / 2.0
        local c = {}
        for _, sz in ipairs({ -1.0, 1.0 }) do
            for _, up in ipairs({ -1.0, 1.0 }) do
                for _, sx in ipairs({ -1.0, 1.0 }) do
                    local lx, lz = sx * hw + ox, sz * hd + oz
                    table.insert(c, {
                        f.x + lx * cs + lz * sn,
                        f.y + oy + up * hh,
                        f.z - lx * sn + lz * cs,
                    })
                end
            end
        end
        local F = {
            { 5, 6, 8 }, { 5, 8, 7 },
            { 2, 4, 3 }, { 2, 3, 1 },
            { 1, 5, 6 }, { 1, 6, 2 },
            { 3, 4, 8 }, { 3, 8, 7 },
            { 1, 3, 7 }, { 1, 7, 5 },
            { 2, 6, 8 }, { 2, 8, 4 },
        }
        for _, fc in ipairs(F) do
            for _, vi in ipairs(fc) do
                local v = c[vi]
                buffer.writef32(buf, o, v[1]); o += 4
                buffer.writef32(buf, o, v[2]); o += 4
                buffer.writef32(buf, o, v[3]); o += 4
                buffer.writef32(buf, o, r); o += 4
                buffer.writef32(buf, o, g); o += 4
                buffer.writef32(buf, o, b); o += 4
                buffer.writef32(buf, o, f.ph); o += 4 -- foe WGSL phase seed
            end
        end
    end
    box(7.0 * S, 6.0 * S, 7.0 * S, 0, 0, 0, bodyR, bodyG, bodyB) -- body
    box(1.2 * S, 2.0 * S, 1.2 * S, 0, 4.0 * S, 0, 0.35, 0.22, 0.10) -- stem
    box(2.6 * S, 2.6 * S, 0.6 * S, -1.8 * S, 1.0 * S, -3.5 * S, 1.0, 0.85, 0.20) -- left eye
    box(2.6 * S, 2.6 * S, 0.6 * S, 1.8 * S, 1.0 * S, -3.5 * S, 1.0, 0.85, 0.20) -- right eye
    box(5.2 * S, 1.8 * S, 0.6 * S, 0, -1.4 * S, -3.5 * S, 1.0, 0.85, 0.20) -- grinning mouth
    return o
end

-- Box writer for the gate pipeline (pos + color + phase seed), same
-- layout as foes. One axis-aligned box, 36 verts. Serves the exit
-- portal (white core + pinkish edges, state 1 = white-hot pulse).
local function buildDot(buf: buffer, o: number, cx: number, cy: number, cz: number, hw: number, hh: number, hd: number, r: number, g: number, b: number, phase: number): number
    local c = {}
    for _, sz in ipairs({ -1.0, 1.0 }) do
        for _, up in ipairs({ -1.0, 1.0 }) do
            for _, sx in ipairs({ -1.0, 1.0 }) do
                table.insert(c, { cx + sx * hw, cy + up * hh, cz + sz * hd })
            end
        end
    end
    local F = {
        { 5, 6, 8 }, { 5, 8, 7 },
        { 2, 4, 3 }, { 2, 3, 1 },
        { 1, 5, 6 }, { 1, 6, 2 },
        { 3, 4, 8 }, { 3, 8, 7 },
        { 1, 3, 7 }, { 1, 7, 5 },
        { 2, 6, 8 }, { 2, 8, 4 },
    }
    for _, fc in ipairs(F) do
        for _, vi in ipairs(fc) do
            local v = c[vi]
            buffer.writef32(buf, o, v[1]); o += 4
            buffer.writef32(buf, o, v[2]); o += 4
            buffer.writef32(buf, o, v[3]); o += 4
            buffer.writef32(buf, o, r); o += 4
            buffer.writef32(buf, o, g); o += 4
            buffer.writef32(buf, o, b); o += 4
            buffer.writef32(buf, o, phase); o += 4
        end
    end
    return o
end

-- HAUNTED CIRCUS gate for the WGSL gate pipeline: 7 floats per vert
-- (pos + color + phase seed), same layout as foes. One big spinning
-- theme-colored block per gate (5 kinds, x4); flybys within GATE_FLY
-- count, touching the block wrecks. State rides the phase seed
-- (seed + state*100, decoded by the shader): 0 upcoming bright,
-- 1 next white-hot pulse, 2 cleared keeps color.
-- Block faces +Z at yaw 0. Max 12 boxes per gate; dotted-line cubes apart.
local TUBE_R = 320.0 -- haunted tunnel bore: jet lives inside it (tight: a light wall touch wrecks)
-- (exit portal = gate pipeline boxes written inline at the draw site:
-- white core + pinkish edges, state 1 white-hot pulse. Kept inline so
-- the module stays under the 200-register instantiation limit.)
-- Single tunnel axis through the gate line, extended both ways for the
-- mouth and the exit. buildTube + the clamp share it so visuals and
-- walls never disagree.
local function tubeAxis(gs: { Gate })
    local A0, B0 = gs[1], gs[GATE_N]
    local dx, dy, dz = B0.ax - A0.ax, B0.ay - A0.ay, B0.az - A0.az
    local L = math.sqrt(dx * dx + dy * dy + dz * dz)
    if L < 0.001 then L = 0.001 end
    dx, dy, dz = dx / L, dy / L, dz / L
    local A = { A0.ax - dx * 1500.0, A0.ay - dy * 1500.0, A0.az - dz * 1500.0 }
    local B = { B0.ax + dx * 3500.0, B0.ay + dy * 3500.0, B0.az + dz * 3500.0 }
    return A, B
end

-- Round tunnel tube for the aurora WGSL pipeline: ONE straight run, eight
-- thin faceted octagon plates along the axis. Each plate is a radial shell
-- (thickness 32, inner face exactly at TUBE_R) so there is no hollow box
-- volume to fly into: touching the visible wall IS the crash radius.
-- The shader scrolls the bands.
local function buildTube(buf: buffer, o: number, gs: { Gate }): number
    local A, B = tubeAxis(gs)
    local function panel(w: number, h: number, d: number, cx: number, cy: number, cz: number, cs: number, sn: number, ph: number, ca: number, sa: number)
        local hw: number, hh: number, hd: number = w / 2.0, h / 2.0, d / 2.0
        local c: {{number}} = {}
        for _, sz: number in ipairs({ -1.0, 1.0 }) do
            for _, up: number in ipairs({ -1.0, 1.0 }) do
                for _, sx: number in ipairs({ -1.0, 1.0 }) do
                    local lx: number, lz: number = sx * hw, sz * hd
                    local ly: number = up * hh
                    -- roll (u,v) so width lies tangent to the bore, thickness radial
                    local ru: number = lx * ca - ly * sa
                    local rv: number = lx * sa + ly * ca
                    table.insert(c, {
                        cx + ru * cs + lz * sn,
                        cy + rv,
                        cz - ru * sn + lz * cs,
                    })
                end
            end
        end
        local F = {
            { 5, 6, 8 }, { 5, 8, 7 },
            { 2, 4, 3 }, { 2, 3, 1 },
            { 1, 5, 6 }, { 1, 6, 2 },
            { 3, 4, 8 }, { 3, 8, 7 },
            { 1, 3, 7 }, { 1, 7, 5 },
            { 2, 6, 8 }, { 2, 8, 4 },
        }
        for _, fc in ipairs(F) do
            for _, vi in ipairs(fc) do
                local v = c[vi]
                buffer.writef32(buf, o, v[1]); o += 4
                buffer.writef32(buf, o, v[2]); o += 4
                buffer.writef32(buf, o, v[3]); o += 4
                buffer.writef32(buf, o, 0.06); o += 4
                buffer.writef32(buf, o, 0.03); o += 4
                buffer.writef32(buf, o, 0.14); o += 4
                buffer.writef32(buf, o, ph); o += 4
            end
        end
    end
    local ax = (A[1] + B[1]) / 2
    local ay = (A[2] + B[2]) / 2
    local az = (A[3] + B[3]) / 2
    local dx, dy, dz = B[1] - A[1], B[2] - A[2], B[3] - A[3]
    local segLen = math.sqrt(dx * dx + dy * dy + dz * dz)
    local yaw = math.atan2(dx, dz)
    local cs, sn = math.cos(yaw), math.sin(yaw)
    for k = 0, 7 do -- octagon side k, thin radial shell at TUBE_R
        local a0 = k / 8 * math.pi * 2
        local a1 = (k + 1) / 8 * math.pi * 2
        local am = (a0 + a1) / 2
        local nx, nv = math.cos(am), math.sin(am) -- outward normal
        local chord = 2 * TUBE_R * math.sin(math.pi / 8)
        -- center rides just outside the bore so the INNER face sits at TUBE_R
        local cu, cv = nx * (TUBE_R + 16.0), nv * (TUBE_R + 16.0)
        -- width axis = tangent (-sin am, cos am): roll = am + pi/2
        panel(chord + 48.0, 32.0, segLen + 60.0,
            ax + cu * cs, ay + cv, az - cu * sn, cs, sn, k * 0.9,
            -nv, nx)
    end
    return o
end

-- MORGATHA, THE ROTTEN ONE: giant green pumpkin boss for round 3.
-- Same 7-float foe verts (pos + color + phase), so the foe WGSL pipeline
-- shades him: green rind, candle mouth, ghost-white eyes, matte horns.
-- Faces the jet (face yaw); draw pos in b.x/y/z, anchor in ax/az/alt.
local function buildBoss(buf: buffer, o: number, b: any): number
    local S = 14.0
    local cs, sn = math.cos(b.face or 0), math.sin(b.face or 0)
    local function box(w: number, h: number, d: number, ox: number, oy: number, oz: number, r: number, g: number, bl: number)
        local hw, hh, hd = w / 2.0, h / 2.0, d / 2.0
        local c = {}
        for _, sz in ipairs({ -1.0, 1.0 }) do
            for _, up in ipairs({ -1.0, 1.0 }) do
                for _, sx in ipairs({ -1.0, 1.0 }) do
                    local lx, lz = sx * hw + ox, oz + sz * hd
                    table.insert(c, {
                        b.x + lx * cs + lz * sn,
                        b.y + oy + up * hh,
                        b.z - lx * sn + lz * cs,
                    })
                end
            end
        end
        local F = {
            { 5, 6, 8 }, { 5, 8, 7 },
            { 2, 4, 3 }, { 2, 3, 1 },
            { 1, 5, 6 }, { 1, 6, 2 },
            { 3, 4, 8 }, { 3, 8, 7 },
            { 1, 3, 7 }, { 1, 7, 5 },
            { 2, 6, 8 }, { 2, 8, 4 },
        }
        for _, fc in ipairs(F) do
            for _, vi in ipairs(fc) do
                local v = c[vi]
                buffer.writef32(buf, o, v[1]); o += 4
                buffer.writef32(buf, o, v[2]); o += 4
                buffer.writef32(buf, o, v[3]); o += 4
                buffer.writef32(buf, o, r); o += 4
                buffer.writef32(buf, o, g); o += 4
                buffer.writef32(buf, o, bl); o += 4
                buffer.writef32(buf, o, b.ph); o += 4 -- foe WGSL phase seed
            end
        end
    end
    local prime = (b.prime == true)
    local rindR, rindG, rindB = 0.16, 0.72, 0.18
    local stalkR, stalkG, stalkB = 0.12, 0.10, 0.12
    local hornR, hornG, hornB = 0.12, 0.10, 0.12
    if prime then -- VOIDPUS PRIME paint: purple pumpkin head, gold stalk
        rindR, rindG, rindB = 0.78, 0.20, 0.95
        stalkR, stalkG, stalkB = 1.00, 0.65, 0.12
        hornR, hornG, hornB = 0.88, 0.82, 0.62
    end
    box(7.0 * S, 6.0 * S, 7.0 * S, 0, 0, 0, rindR, rindG, rindB) -- rind body
    box(1.2 * S, 2.4 * S, 1.2 * S, 0, 4.2 * S, 0, stalkR, stalkG, stalkB) -- crown stalk
    box(2.2 * S, 3.0 * S, 0.8 * S, -2.0 * S, 1.4 * S, 3.4 * S, 0.85, 1.0, 1.0) -- ghost eye L
    box(2.2 * S, 3.0 * S, 0.8 * S, 2.0 * S, 1.4 * S, 3.4 * S, 0.85, 1.0, 1.0) -- ghost eye R
    box(4.6 * S, 1.2 * S, 0.8 * S, 0, -1.8 * S, 3.4 * S, 1.0, 0.85, 0.20) -- jagged maw
    box(0.9 * S, 1.6 * S, 0.7 * S, -1.5 * S, -2.8 * S, 3.4 * S, 1.0, 0.85, 0.20) -- fang L
    box(0.9 * S, 1.6 * S, 0.7 * S, 1.5 * S, -2.8 * S, 3.4 * S, 1.0, 0.85, 0.20) -- fang R
    if not prime then
        box(1.0 * S, 2.8 * S, 1.0 * S, -3.8 * S, 3.8 * S, 0, hornR, hornG, hornB) -- horn L
        box(1.0 * S, 2.8 * S, 1.0 * S, 3.8 * S, 3.8 * S, 0, hornR, hornG, hornB) -- horn R
        box(3.4 * S, 1.6 * S, 1.6 * S, -5.0 * S, -0.5 * S, 0, rindR, rindG, rindB) -- arm L
        box(3.4 * S, 1.6 * S, 1.6 * S, 5.0 * S, -0.5 * S, 0, rindR, rindG, rindB) -- arm R
    end
    if prime then -- VOIDPUS PRIME: gold crown + 8 octopus legs + suckers
        box(4.4 * S, 1.0 * S, 4.4 * S, 0, 3.2 * S, 0, 1.00, 0.65, 0.12) -- crown band
        box(0.8 * S, 2.2 * S, 0.8 * S, -1.8 * S, 4.6 * S, 0, 1.00, 0.65, 0.12) -- spike L
        box(0.8 * S, 2.2 * S, 0.8 * S, 1.8 * S, 4.6 * S, 0, 1.00, 0.65, 0.12) -- spike R
        for k = 0, 7 do -- octopus ring under the head, WGSL writhes them
            local a = k / 8 * math.pi * 2
            local lx, lz = math.cos(a) * 3.0 * S, math.sin(a) * 3.0 * S
            box(1.4 * S, 4.5 * S, 1.4 * S, lx, -5.5 * S, lz, 0.42, 0.14, 0.62)
        end
        for k = 0, 3 do -- pale sucker mouths on the front legs
            local a = (k - 1.5) * 0.5
            box(0.5 * S, 1.2 * S, 0.3 * S, math.sin(a) * 3.6 * S, -5.0 * S, 3.6 * S, 1.00, 0.62, 0.78)
        end
    end
    return o
end

-- Thin pale speed-line streak oriented along yaw. Color sits outside all
-- WGSL glow bands on purpose: wind stays flat white-blue, never flares.
local function buildWind(buf: buffer, o: number, bx: number, by: number, bz: number, yaw: number, pitchW: number, len: number): number
    local cy, sy = math.cos(yaw), math.sin(yaw)
    local cp, sp = math.cos(pitchW), math.sin(pitchW)
    local hl = len / 2.0
    local c = {}
    for _, sgn in ipairs({ -1.0, 1.0 }) do
        for _, up in ipairs({ -1.0, 1.0 }) do
            for _, side in ipairs({ -1.0, 1.0 }) do
                -- Hair-thin streak: length along Z, pitch about X, yaw about Y.
                local lx = 0.02 * side
                local ly = 0.02 * up
                local lz = hl * sgn
                local py = ly * cp - lz * sp
                local pz = ly * sp + lz * cp
                table.insert(c, {
                    bx + lx * cy + pz * sy,
                    by + py,
                    bz - lx * sy + pz * cy,
                })
            end
        end
    end
    local F = {
        { 5, 6, 8 }, { 5, 8, 7 },
        { 2, 4, 3 }, { 2, 3, 1 },
        { 1, 5, 6 }, { 1, 6, 2 },
        { 3, 4, 8 }, { 3, 8, 7 },
        { 1, 3, 7 }, { 1, 7, 5 },
        { 2, 6, 8 }, { 2, 8, 4 },
    }
    for _, f in ipairs(F) do
        for _, vi in ipairs(f) do
            local v = c[vi]
            buffer.writef32(buf, o, v[1]); o += 4
            buffer.writef32(buf, o, v[2]); o += 4
            buffer.writef32(buf, o, v[3]); o += 4
            buffer.writef32(buf, o, 0.50); o += 4
            buffer.writef32(buf, o, 0.56); o += 4
            buffer.writef32(buf, o, 0.68); o += 4
        end
    end
    return o
end

-- Crash chunk: 12 floats/vert (pos + color + heat/seed/kind + local -1..1).
-- frac f goes 1 (fresh) -> 0 (dying). CPU picks size and base tone; the
-- blast WGSL pipeline does the fire/smoke/shock shading per pixel.
local function buildChunk(buf: buffer, o: number, c: Chunk): number
    local f = math.clamp(c.life / math.max(c.life0, 0.01), 0, 1)
    local r, g, b = 1.0, 1.0, 1.0
    local hx, hy, hz = 0.25, 0.25, 0.25
    local yaw = 0
    if c.kind == 0 then -- fireball: big, stretches tall, shrinks as it burns out
        r, g, b = 1.0, 0.55, 0.10
        local s = 4.2 * (0.4 + 0.6 * f)
        hx, hy, hz = s, s * 1.25, s -- flames stretch taller than wide
    elseif c.kind == 1 then -- bloom flash, swells huge then dies fast
        r, g, b = 1.0, 0.95, 0.80
        local s = (2.0 + (1 - f) * 22.0) / 2
        hx, hy, hz = s, s, s
    elseif c.kind == 2 then -- smoke, grows as it billows up
        r, g, b = 0.25, 0.23, 0.28
        local s = (2.5 + (1 - f) * 3.0) / 2
        hx, hy, hz = s, s, s
    elseif c.kind == 3 then -- wreck debris chunk
        r, g, b = 0.10, 0.09, 0.11
        hx, hy, hz = 0.4, 0.4, 0.4
    elseif c.kind == 4 then -- spark streak along its velocity
        r, g, b = 1.0, 0.85, 0.25
        yaw = math.atan2(c.vx, c.vz)
        hx, hz, hy = 0.12, 1.4, 0.12
    elseif c.kind == 6 then -- shockwave: wide flat disc racing outward
        r, g, b = 1.0, 0.72, 0.35
        local s = 6.0 + (1 - f) * 46.0
        hx, hy, hz = s, 0.35, s
    elseif c.kind == 7 then -- gun flash: small bright pop, never chars black
        r, g, b = 1.0, 0.70, 0.20
        local s = 1.6 * (0.5 + 0.5 * f)
        hx, hy, hz = s, s * 1.2, s
    else -- dust ring, flat and wide, spreads out
        r, g, b = 0.55, 0.45, 0.32
        local s = (2.5 + (1 - f) * 6.0) / 2
        hx, hy, hz = s, 0.18, s
    end
    local cy, sy = math.cos(yaw), math.sin(yaw)
    local c8 = {}
    for _, sx in ipairs({ -1.0, 1.0 }) do
        for _, ux in ipairs({ -1.0, 1.0 }) do
            for _, sz in ipairs({ -1.0, 1.0 }) do
                local lx = hx * sx
                local lz = hz * sz
                table.insert(c8, {
                    c.x + lx * cy + lz * sy,
                    c.y + hy * ux,
                    c.z - lx * sy + lz * cy,
                    sx, ux, sz,
                })
            end
        end
    end
    -- c8 order: sx(-1,1) -> ux(-1,1) -> sz(-1,1), same layout as buildWind.
    local F = {
        { 5, 6, 8 }, { 5, 8, 7 },
        { 2, 4, 3 }, { 2, 3, 1 },
        { 1, 5, 6 }, { 1, 6, 2 },
        { 3, 4, 8 }, { 3, 8, 7 },
        { 1, 3, 7 }, { 1, 7, 5 },
        { 2, 6, 8 }, { 2, 8, 4 },
    }
    for _, fq in ipairs(F) do
        for _, vi in ipairs(fq) do
            local v = c8[vi]
            buffer.writef32(buf, o, v[1]); o += 4
            buffer.writef32(buf, o, v[2]); o += 4
            buffer.writef32(buf, o, v[3]); o += 4
            buffer.writef32(buf, o, r); o += 4
            buffer.writef32(buf, o, g); o += 4
            buffer.writef32(buf, o, b); o += 4
            buffer.writef32(buf, o, f); o += 4 -- heat: fresh 1 -> burnt 0
            buffer.writef32(buf, o, c.seed); o += 4
            buffer.writef32(buf, o, c.kind); o += 4
            buffer.writef32(buf, o, v[4]); o += 4
            buffer.writef32(buf, o, v[5]); o += 4
            buffer.writef32(buf, o, v[6]); o += 4
        end
    end
    return o
end

-- Axis-aligned box writer for 6-float (pos + color) world-pipeline buffers.
-- Returns the new offset. The level-3 army bake + storm churn pack here.
local function buildBox6(buf: buffer, o: number, cx: number, cy: number, cz: number,
    hx: number, hy: number, hz: number, r: number, g: number, b: number, sd: number?): number
    local seed = sd or 0 -- 7th float: per-body seed (zombie pipe only)
    local x0, x1 = cx - hx, cx + hx
    local y0, y1 = cy - hy, cy + hy
    local z0, z1 = cz - hz, cz + hz
    local v: {{ number }} = {
        -- top
        { x0, y1, z0 }, { x1, y1, z0 }, { x0, y1, z1 },
        { x1, y1, z0 }, { x1, y1, z1 }, { x0, y1, z1 },
        -- front (z1)
        { x0, y0, z1 }, { x1, y0, z1 }, { x0, y1, z1 },
        { x1, y0, z1 }, { x1, y1, z1 }, { x0, y1, z1 },
        -- back (z0)
        { x1, y0, z0 }, { x0, y0, z0 }, { x0, y1, z0 },
        { x1, y0, z0 }, { x0, y1, z0 }, { x1, y1, z0 },
        -- left (x0)
        { x0, y0, z0 }, { x0, y0, z1 }, { x0, y1, z1 },
        { x0, y0, z0 }, { x0, y1, z1 }, { x0, y1, z0 },
        -- right (x1)
        { x1, y0, z1 }, { x1, y0, z0 }, { x1, y1, z0 },
        { x1, y0, z1 }, { x1, y1, z0 }, { x1, y1, z1 },
        -- bottom
        { x0, y0, z0 }, { x1, y0, z0 }, { x0, y0, z1 },
        { x1, y0, z0 }, { x1, y0, z1 }, { x0, y0, z1 },
    }
    for _, p in ipairs(v) do
        buffer.writef32(buf, o, p[1]); o += 4
        buffer.writef32(buf, o, p[2]); o += 4
        buffer.writef32(buf, o, p[3]); o += 4
        buffer.writef32(buf, o, r); o += 4
        buffer.writef32(buf, o, g); o += 4
        buffer.writef32(buf, o, b); o += 4
        buffer.writef32(buf, o, seed); o += 4
    end
    return o
end

-- Octagonal frustum drum (7-float verts): the circular half-globe is
-- stacked drums, not boxes — boxes read square, drums read round.
local function buildDrum(buf: buffer, o: number, cx: number, y0: number, cz: number,
    r0: number, r1: number, h: number, r: number, g: number, b: number, sd: number?): number
    local dseed = sd or 0
    local function sv(oo: number, x: number, y: number, z: number): number
        buffer.writef32(buf, oo, x); oo += 4
        buffer.writef32(buf, oo, y); oo += 4
        buffer.writef32(buf, oo, z); oo += 4
        buffer.writef32(buf, oo, r); oo += 4
        buffer.writef32(buf, oo, g); oo += 4
        buffer.writef32(buf, oo, b); oo += 4
        buffer.writef32(buf, oo, dseed); oo += 4
        return oo
    end
    for s = 0, 7 do
        local a0 = s / 8 * math.pi * 2
        local a1 = (s + 1) / 8 * math.pi * 2
        local bx0, bz0 = cx + math.cos(a0) * r0, cz + math.sin(a0) * r0
        local bx1, bz1 = cx + math.cos(a1) * r0, cz + math.sin(a1) * r0
        local tx0, tz0 = cx + math.cos(a0) * r1, cz + math.sin(a0) * r1
        local tx1, tz1 = cx + math.cos(a1) * r1, cz + math.sin(a1) * r1
        o = sv(o, bx0, y0, bz0)
        o = sv(o, bx1, y0, bz1)
        o = sv(o, tx1, y0 + h, tz1)
        o = sv(o, bx0, y0, bz0)
        o = sv(o, tx1, y0 + h, tz1)
        o = sv(o, tx0, y0 + h, tz0)
    end
    return o
end

-- Flat octagon fan (7-float verts): halo spill + dome cap.
local function buildFan(buf: buffer, o: number, cx: number, y: number, cz: number,
    rad: number, r: number, g: number, b: number, sd: number?): number
    local fseed = sd or 1 -- zombie pipe reads this float as density: the globe must be fully dense
    for s = 0, 7 do
        local a0 = s / 8 * math.pi * 2
        local a1 = (s + 1) / 8 * math.pi * 2
        buffer.writef32(buf, o, cx); o += 4
        buffer.writef32(buf, o, y); o += 4
        buffer.writef32(buf, o, cz); o += 4
        buffer.writef32(buf, o, r); o += 4
        buffer.writef32(buf, o, g); o += 4
        buffer.writef32(buf, o, b); o += 4
        buffer.writef32(buf, o, fseed); o += 4
        for _, a in ipairs({ a0, a1 }) do
            buffer.writef32(buf, o, cx + math.cos(a) * rad); o += 4
            buffer.writef32(buf, o, y); o += 4
            buffer.writef32(buf, o, cz + math.sin(a) * rad); o += 4
            buffer.writef32(buf, o, r); o += 4
            buffer.writef32(buf, o, g); o += 4
            buffer.writef32(buf, o, b); o += 4
            buffer.writef32(buf, o, fseed); o += 4
        end
    end
    return o
end

-- Storm curtain: tessellated wall segment for the storm pipeline.
-- local carries (u along, v up, layer); density/seed ride info. Bowed
-- toward the jet at midspan so the front reads concave, planet-scale.
local function buildStormCurtain(buf: buffer, o: number, cx: number, yb: number, cz: number,
    len: number, h: number, bow: number, dens: number, seed: number, layer: number): number
    local r, g, b = 0.55, 0.34, 0.18 -- neutral dust; the shader re-ramps
    -- Billow swells: broad low-frequency height variation along the
    -- wall (real crowns roll, they don't spike into peaks).
    local function hmAt(u: number): number
        return 0.90 + 0.05 * math.sin(u * 13.0 + seed * 40.0)
            + 0.02 * math.sin(u * 31.0 + seed * 17.0)
    end
    local function sv(oo: number, x: number, y: number, z: number, u: number, v: number): number
        buffer.writef32(buf, oo, x); oo += 4
        buffer.writef32(buf, oo, y); oo += 4
        buffer.writef32(buf, oo, z); oo += 4
        buffer.writef32(buf, oo, r); oo += 4
        buffer.writef32(buf, oo, g); oo += 4
        buffer.writef32(buf, oo, b); oo += 4
        buffer.writef32(buf, oo, dens); oo += 4
        buffer.writef32(buf, oo, seed); oo += 4
        buffer.writef32(buf, oo, 8); oo += 4 -- storm kind
        buffer.writef32(buf, oo, u); oo += 4
        buffer.writef32(buf, oo, v); oo += 4
        buffer.writef32(buf, oo, layer); oo += 4
        return oo
    end
    for iu = 0, STORM_NU - 1 do
        local u0 = iu / STORM_NU
        local u1 = (iu + 1) / STORM_NU
        local x0 = cx - len / 2 + u0 * len
        local x1 = cx - len / 2 + u1 * len
        -- concave bow: midspan reaches toward the jet (-z, south)
        local fx0 = 1 - ((x0 - cx) / (len / 2)) ^ 2
        local fx1 = 1 - ((x1 - cx) / (len / 2)) ^ 2
        local z0 = cz - fx0 * bow
        local z1 = cz - fx1 * bow
        for iv = 0, STORM_NV - 1 do
            local v0 = iv / STORM_NV
            local v1 = (iv + 1) / STORM_NV
            local ya0 = yb + v0 * h * hmAt(u0)
            local yb0 = yb + v0 * h * hmAt(u1)
            local ya1 = yb + v1 * h * hmAt(u0)
            local yb1 = yb + v1 * h * hmAt(u1)
            o = sv(o, x0, ya0, z0, u0, v0)
            o = sv(o, x1, yb0, z1, u1, v0)
            o = sv(o, x0, ya1, z0, u0, v1)
            o = sv(o, x1, yb0, z1, u1, v0)
            o = sv(o, x1, yb1, z1, u1, v1)
            o = sv(o, x0, ya1, z0, u0, v1)
        end
    end
    return o
end
-- Ground-skirt flat for the storm pipeline: same 12-float verts, but
-- local is pinned to the (u, v) center so the WGSL erodes it by noise
-- only, never cutting a curtain edge through the dust at the base.
local function buildStormBox(buf: buffer, o: number, cx: number, cy: number, cz: number,
    hx: number, hy: number, hz: number, r: number, g: number, b: number,
    density: number, seed: number): number
    local c8 = {}
    for _, sx in ipairs({ -1.0, 1.0 }) do
        for _, ux in ipairs({ -1.0, 1.0 }) do
            for _, sz in ipairs({ -1.0, 1.0 }) do
                table.insert(c8, {
                    cx + hx * sx,
                    cy + hy * ux,
                    cz + hz * sz,
                    sx, ux, sz,
                })
            end
        end
    end
    local F = {
        { 5, 6, 8 }, { 5, 8, 7 },
        { 2, 4, 3 }, { 2, 3, 1 },
        { 1, 5, 6 }, { 1, 6, 2 },
        { 3, 4, 8 }, { 3, 8, 7 },
        { 1, 3, 7 }, { 1, 7, 5 },
        { 2, 6, 8 }, { 2, 8, 4 },
    }
    for _, fq in ipairs(F) do
        for _, vi in ipairs(fq) do
            local vv = c8[vi]
            buffer.writef32(buf, o, vv[1]); o += 4
            buffer.writef32(buf, o, vv[2]); o += 4
            buffer.writef32(buf, o, vv[3]); o += 4
            buffer.writef32(buf, o, r); o += 4
            buffer.writef32(buf, o, g); o += 4
            buffer.writef32(buf, o, b); o += 4
            buffer.writef32(buf, o, density); o += 4
            buffer.writef32(buf, o, seed); o += 4
            buffer.writef32(buf, o, 8); o += 4 -- storm kind
            buffer.writef32(buf, o, 0.5); o += 4 -- u center: erode by noise only
            buffer.writef32(buf, o, 0.5); o += 4 -- v center: never a curtain edge
            buffer.writef32(buf, o, 0); o += 4 -- front layer
        end
    end
    return o
end

-- Nuke billboard quad (12-float verts for the nuke pipeline): center +
-- kind/size/seed + birth/half-extents + corner signs. Two tris, corners
-- (-1,-1)..(1,1); the WGSL faces it at the camera and animates by age.
local function buildNukeQuad(buf: buffer, o: number, cx: number, cy: number, cz: number,
    kind: number, size: number, hx: number, hy: number, seed: number, birth: number): number
    local corners = { { -1.0, -1.0 }, { 1.0, -1.0 }, { -1.0, 1.0 },
        { 1.0, -1.0 }, { 1.0, 1.0 }, { -1.0, 1.0 } }
    for _, c in ipairs(corners) do
        buffer.writef32(buf, o, cx); o += 4
        buffer.writef32(buf, o, cy); o += 4
        buffer.writef32(buf, o, cz); o += 4
        buffer.writef32(buf, o, kind); o += 4
        buffer.writef32(buf, o, size); o += 4
        buffer.writef32(buf, o, seed); o += 4
        buffer.writef32(buf, o, birth); o += 4
        buffer.writef32(buf, o, hx); o += 4
        buffer.writef32(buf, o, hy); o += 4
        buffer.writef32(buf, o, c[1]); o += 4
        buffer.writef32(buf, o, c[2]); o += 4
        buffer.writef32(buf, o, 0); o += 4
    end
    return o
end

-- Seeker cruise body (12-float verts for the missile pipeline): one
-- oriented box along the velocity, +z = nose. Colors stay raw steel —
-- the WGSL paints the hot nose, exhaust flame, and beacon by local.z.
-- zk tags the paint: 0 player steel, 3 zombie rust-green.
local function buildMsl(buf: buffer, o: number, m: any, seed: number, zk: number?): number
    local vl = math.sqrt(m.vx * m.vx + m.vy * m.vy + m.vz * m.vz)
    if vl < 0.001 then vl = 0.001 end
    local fx, fy, fz = m.vx / vl, m.vy / vl, m.vz / vl
    local hl = math.sqrt(fx * fx + fz * fz)
    local rx, rz = 1.0, 0.0
    if hl > 0.001 then rx, rz = fz / hl, -fx / hl end
    local ux, uy, uz = fy * rz, fz * rx - fx * rz, -fy * rx -- upv = fwd x right
    local ul = math.sqrt(ux * ux + uy * uy + uz * uz)
    if ul < 0.001 then ux, uy, uz, ul = 0.0, 1.0, 0.0, 1.0 end
    ux, uy, uz = ux / ul, uy / ul, uz / ul
    local HL, HH, HW = 26.0, 4.5, 4.5 -- big fat dart: 52u body, 9u thick, reads far
    if (zk or 0) == 3 then HL, HH, HW = 30.0, 5.0, 5.0 end -- zombie heavies fly big + read far
    local c8 = {}
    for _, sz in ipairs({ -1.0, 1.0 }) do
        for _, up in ipairs({ -1.0, 1.0 }) do
            for _, sx in ipairs({ -1.0, 1.0 }) do
                table.insert(c8, {
                    m.x + fx * HL * sz + ux * HH * up + rx * HW * sx,
                    m.y + fy * HL * sz + uy * HH * up,
                    m.z + fz * HL * sz + uz * HH * up + rz * HW * sx,
                    sx, up, sz,
                })
            end
        end
    end
    local F = {
        { 5, 6, 8 }, { 5, 8, 7 },
        { 2, 4, 3 }, { 2, 3, 1 },
        { 1, 5, 6 }, { 1, 6, 2 },
        { 3, 4, 8 }, { 3, 8, 7 },
        { 1, 3, 7 }, { 1, 7, 5 },
        { 2, 6, 8 }, { 2, 8, 4 },
    }
    for _, fq in ipairs(F) do
        for _, vi in ipairs(fq) do
            local v = c8[vi]
            buffer.writef32(buf, o, v[1]); o += 4
            buffer.writef32(buf, o, v[2]); o += 4
            buffer.writef32(buf, o, v[3]); o += 4
            buffer.writef32(buf, o, zk or 0); o += 4 -- kind 0 cruise, kind 3 zombie missile
            buffer.writef32(buf, o, 14.0); o += 4 -- size tag (unused by kind 0)
            buffer.writef32(buf, o, seed); o += 4
            buffer.writef32(buf, o, 1.0); o += 4 -- heat: always fresh in flight
            buffer.writef32(buf, o, 0); o += 4
            buffer.writef32(buf, o, 0); o += 4
            buffer.writef32(buf, o, v[4]); o += 4
            buffer.writef32(buf, o, v[5]); o += 4
            buffer.writef32(buf, o, v[6]); o += 4
        end
    end
    return o
end

-- Spawn one crash chunk at the wreck with radial velocity.
-- Self-contained hash (no forward refs); caller passes ground height.
local function puff(self: Game, kind: number, spread: number, up: number, life: number, gyC: number, ox: number?, oz: number?)
    local c = self.chunks[self.chunkIdx]
    self.chunkIdx = self.chunkIdx % CHUNK_SLOTS + 1
    local function h(s: number): number
        local x = math.sin(self.chunkIdx * 12.9898 + (self.time + s) * 78.233) * 43758.5453
        return x - math.floor(x)
    end
    local a = h(kind * 11.0) * math.pi * 2.0
    local rr = h(kind * 17.0) * spread
    c.x = self.tx + (ox or 0) + math.cos(a) * rr * 0.3
    c.z = self.tz + (oz or 0) + math.sin(a) * rr * 0.3
    if kind == 5 then
        c.y = gyC + 0.4
    elseif kind == 6 then
        c.y = gyC + 0.6 -- shockwave hugs the dunes
    else
        c.y = gyC + 1.0 + h(kind * 23.0) * 1.5
    end
    c.vx = math.cos(a) * rr
    c.vz = math.sin(a) * rr
    c.vy = up * (0.5 + h(kind * 31.0))
    c.life0 = life
    c.life = life * (0.7 + 0.6 * h(kind * 41.0))
    c.kind = kind
    c.seed = h(kind * 53.0)
    c.on = true
end

-- Safe untyped field write: a statement starting with `(` or `;` is
-- rejected at block starts by the script parser, so route those there.
local function setAny(t: any, k: string, v: any)
    (t :: any)[k] = v
end

-- View-model write that tolerates a missing prop (nil fetch): keeps
-- optional HUD bindings cheap without growing the Game type.
local function setVal(self: Game, k: string, v: any)
    local p = (self :: any)[k]
    if p ~= nil then p.value = v end
end

-- Level 1: ring 5 floating pumpkins ahead of the jet nose, far enough
-- to fly to and close enough to see. Anchored to the jet's current
-- position, heading AND height, so round 2 and round 3 both start
-- dead ahead in view wherever the run has carried the plane.
local function spawnFoes(self: Game)
    local fx, fz = math.sin(self.yaw), math.cos(self.yaw)
    local rx, rz = math.cos(self.yaw), -math.sin(self.yaw)
    -- Eye height snapshot by stageFoes (nil on reset paths: parked anyway).
    local eyeY = (self :: any).foeEyeY or 150.0
    for i = 1, FOE_N do
        local f = self.foes[i]
        if f == nil then
            f = { on = true, x = 0, y = 0, z = 0, ax = 0, az = 0, alt = 0, r = 90, sp = 0.3, ph = 0, spin = 0, kind = 0, hp = 1, tchCd = 0, atkT = 3.0 }
            self.foes[i] = f
        end
        f.on = true
        local ahead = 2600 + (i - 1) * 350.0
        local side = (i - 3) * 350.0
        local ax = self.tx + fx * ahead + rx * side
        local az = self.tz + fz * ahead + rz * side
        if ax > WRAP then ax -= WRAP * 2 elseif ax < -WRAP then ax += WRAP * 2 end
        if az > WRAP then az -= WRAP * 2 elseif az < -WRAP then az += WRAP * 2 end
        f.ax = ax
        f.az = az
        f.alt = eyeY + (i - 3) * 40.0
        f.r = 90.0
        f.sp = 0.25 + 0.05 * ((i - 1) % 2)
        f.ph = i * 0.8
        f.kind = 0
        f.hp = 1
        f.tchCd = 0
        f.atkT = 3.0
        f.x, f.z = f.ax + f.r, f.az
        f.y = f.alt
        f.spin = f.ph
    end
    self.kills = 0
end

-- Minimap: refill every breadcrumb with the current position (used at

-- Minimap: refill every breadcrumb with the current position (used at
-- spawn and on wrap teleports so no streak crosses the whole map).
local function resetTrail(self: Game)
    for _, d in ipairs(self.trail) do
        d.x = self.tx
        d.z = self.tz
    end
    self.trailAcc = 0
end

-- Park the boss: hidden, full health, story off. doReset + init share it.
local function resetBoss(self: Game)
    local B = (self :: any).boss
    if B == nil then B = {}; (self :: any).boss = B end
    B.on = false
    B.live = false
    B.hp = BOSS_HP
    B.max = BOSS_HP
    B.prime = false
    B.mode = "stalk"
    B.modeT = 0
    B.atkT = 2.5
    B.chgT = 7.0
    B.tchCd = 0
    B.dvx, B.dvz = 0, 0
    B.enraged = false
    B.p2told = false
    B.sumT = PRIME_SUMMON_CD
    B.ph = 1.7
    B.face = 0
    B.ax, B.az, B.alt = 0, 0, -500
    B.x, B.y, B.z = 0, -500, 0
    setAny(self, "r3intro", -1)
    ;(self :: any).r3introT = 0
    -- Boss bar parked off-screen until the first hit lands.
    if self.bossHp ~= nil then self.bossHp.value = B.max end
    if self.bossBarA ~= nil then self.bossBarA.value = 0 end
    if self.bossBarX ~= nil then self.bossBarX.value = -300 end
    if self.bossBarY ~= nil then self.bossBarY.value = -300 end
    if self.bossNameY ~= nil then self.bossNameY.value = -300 end
end

-- Full run reset shared by the P key and the game-over buttons.
-- Chase-cam frame: low gear-level follow while on the runway so the
-- takeoff roll feels planted (close + near the pavement), easing up to
-- the normal wide chase within ~10u of climb-out after liftoff.
local function camFrame(self: Game): (number, number, number)
    local gf = 1.0
    if not self.grounded then gf = math.clamp(1 - self.hy / 10, 0, 1) end
    local back = self.radius * (1 - gf) + 10.0 * gf
    local h = self.height * (1 - gf) + 3.6 * gf
    local lh = self.lookH * (1 - gf) + 1.6 * gf
    return back, h, lh
end

local function doReset(self: Game)
    self.crashed = false
    self.crashT = 0
    self.crashAcc = 0
    if self.takeoffInst ~= nil then
        pcall(function() (self.takeoffInst :: any):stop() end)
        self.takeoffInst = nil
    end
    if self.jetInst ~= nil then
        pcall(function() (self.jetInst :: any):stop() end)
        self.jetInst = nil
    end
    self.jetT = 0
    if self.homeBellsInst ~= nil then
        pcall(function() (self.homeBellsInst :: any):stop() end)
        self.homeBellsInst = nil
    end
    self.homeBellsT = 0
    self.takeoffPlayed = false
    self.grounded = true
    self.roll = 0
    self.mouseFire = false
    ;(self :: any).gspd = 0
    ;(self :: any).gun = 1
    if self.gunHL ~= nil then self.gunHL.value = "> INFERNO <" end
    self.boostLock = false
    self.tx = 0
    self.tz = -15000
    self.yaw = 0
    self.camYaw = 0
    self.hy = 0
    self.vy = 0
    ;(self :: any).throttle = START_SPEED
    ;(self :: any).fwd = 7
    ;(self :: any).bank = 0
    setAny(self, "kbx", 0) -- GIGA knockback never leaks across resets
    setAny(self, "kbz", 0)
    setAny(self, "kby", 0)
    setAny(self, "tumble", 0)
    setAny(self, "shakeT", 0)
    for _, b in ipairs(self.beams) do b.on = false end
    for _, m in ipairs(self.msls) do m.on = false end
    for _, mb in ipairs(self.mslBooms) do mb.on = false end
    for _, c in ipairs(self.chunks) do c.on = false end
    resetTrail(self)
    spawnFoes(self) -- built fresh every run, parked off until tutorial ends
    for _, f in ipairs(self.foes) do f.on = false end
    self.kills = 0 -- fresh run: stale L1 kills must not leak into L2/L3 progress
    ;(self :: any).tutDone = false
    self.round = 1
    self.hp = 100
    ;(self :: any).hitFlash = 0 -- white damage flash, set on orb hits
    ;(self :: any).gigaGlow = 0 -- hot GIGA-hit burn, set on hand/kick lands
    if self.health ~= nil then self.health.value = 100 end
    ;(self :: any).roundT = 0
    ;(self :: any).surviveT = 0
    ;(self :: any).orbT = 0
    ;(self :: any).lastTick = -1
    ;(self :: any).levelBlend = 0
    ;(self :: any).wave = 0
    ;(self :: any).waveT = 0
    ;(self :: any).waveGap = 0
    ;(self :: any).orbSpeed = ORB_SPEED
    for _, o in ipairs((self :: any).orbs) do o.on = false end
    if self.overA ~= nil then self.overA.value = 0 end
    if self.msg ~= nil then
        if (self :: any).level == 2 then
            self.msg.value = "LEVEL 2: BREAK THE WALL! SHOOT THE RED SLAB TO SMASH IT, THEN DODGE THE HAMMER, FAN, ROCKS AND THREAD THE NEEDLE! 5 PUMPKINS GUARD THE DEEP!"
        else
            self.msg.value = "ROUND 1 TRAINING: follow the white prompts to learn flying"
        end
    end
    if (self :: any).level ~= 2 then self.helpT = 12 end -- runway reopens: pop the controls board (never L2)
    ;(self :: any).welcomed = false
    ;(self :: any).hadHelp = false
    ;(self :: any).welcomeT = 0
    if self.welcomeA ~= nil then self.welcomeA.value = 0 end
    if self.welcome ~= nil then self.welcome.value = "" end
    if self.welcomeS ~= nil then self.welcomeS.value = 1 end
    ;(self :: any).tutStage = 0
    ;(self :: any).tutIdx = 0
    ;(self :: any).tutAirT = 0
    ;(self :: any).tutH0 = nil
    ;(self :: any).r2intro = -1
    ;(self :: any).r2introT = 0
    resetBoss(self) -- MORGATHA parked, story off
    ;(self :: any).niceT = 0
    if self.tutA ~= nil then self.tutA.value = 0 end
    if self.niceA ~= nil then self.niceA.value = 0 end
    if (self :: any).tutMaster or false then
        retireTutorial(self, false) -- reset keeps the lessons retired
        if (self :: any).level ~= 2 and self.msg ~= nil then self.msg.value = "WELCOME BACK, HERO - HIT THE PUMPKINS!" end
    end
    if (self :: any).level == 2 then
        stageParkour(self) -- circus restaged: tutorial stays retired, gates live
    end
    if (self :: any).level == 3 then
        -- Rotten Court: staff waves first, PRIME stages after they fall.
        stageCourt(self)
        if self.tutA ~= nil then self.tutA.value = 0 end
    end
    -- Victory leftovers: a manual reset cancels the lap home + the show.
    ;(self :: any).winT = 0
    ;(self :: any).unlockT = -1
    ;(self :: any).vitT = -1
    ;(self :: any).vicWin = false
    ;(self :: any).vicT = -1
    setAny(self, "vicBoom", false)
    setAny(self, "shakeSnd", false)
    setAny(self, "broke", false)
    setAny(self, "vitBroke", false)
    setAny(self, "vitShake", false)
    if self.unlockA ~= nil then self.unlockA.value = 0 end
    if self.unlockLit ~= nil then self.unlockLit.value = 0 end
    if self.vitA ~= nil then self.vitA.value = 0 end
    if self.vitTitleA ~= nil then self.vitTitleA.value = 0 end
    if self.vitSubA ~= nil then self.vitSubA.value = 0 end
    if self.vitL2A ~= nil then self.vitL2A.value = 0 end
    if self.vitL2Lit ~= nil then self.vitL2Lit.value = 0 end
    if self.vitLockA ~= nil then self.vitLockA.value = 0 end
    if self.vitFlash ~= nil then self.vitFlash.value = 0 end
    if self.vitContA ~= nil then self.vitContA.value = 0 end
    if self.vitSparkA ~= nil then self.vitSparkA.value = 0 end
    if self.vitConfA ~= nil then self.vitConfA.value = 0 end
    if self.vicTitleA ~= nil then self.vicTitleA.value = 0 end
    if self.vitL1A ~= nil then self.vitL1A.value = 0 end
    if self.vitRowY ~= nil then self.vitRowY.value = self.ch / 2 + 10 end
    -- (lock icons ride resize only: a second writer here used to park
    -- cube 2's lock over the rules button until the next resize)
    if (self :: any).level == 1 then cineStart(self) end -- round 1 opens on the cinematic orbit (L2/L3 stage their own)
end

-- Player-centered follow map: the plane dot sits in the middle, everything
-- else plots relative to it, so nearby pumpkins spread visibly instead of
-- piling under the plane on a world-fixed map. +z is up on the map.
-- Far objects clamp to the circle edge as direction hints.
local MAP_RANGE = 3000.0 -- default world units from center to map edge
-- GIGA hunt: the range opens up to hold the zombie's TRUE position —
-- no edge-clamp guessing while it stalks far off.
local function mapRange(self: Game): number
    local GG: any = (self :: any).l3giant
    if (self :: any).level == 3 and GG ~= nil
        and ((self :: any).l3phase == "giant" or (self :: any).l3phase == "dying")
        and (GG.rise or 0) >= 1 then
        local dx, dz = GG.x - self.tx, GG.z - self.tz
        return math.min(30000.0, math.max(3000.0, math.sqrt(dx * dx + dz * dz) + 800.0))
    end
    return MAP_RANGE
end
local function mapPX(self: Game, wx: number, wz: number): (number, number)
    local cx = self.mapOX + MAP_W / 2
    local cy = self.mapOY + MAP_H / 2
    local scale = (MAP_W / 2 - 5) / mapRange(self)
    local px = cx + (wx - self.tx) * scale
    local py = cy - (wz - self.tz) * scale
    local dx, dy = px - cx, py - cy
    local dist = math.sqrt(dx * dx + dy * dy)
    local maxR = MAP_W / 2 - 5
    if dist > maxR then
        px = cx + dx / dist * maxR
        py = cy + dy / dist * maxR
    end
    return px, py
end

local RWY_H = -0.4 -- graded runway pad height
local RWY_CX = 0.0 -- runway center x (map center line, south of middle)
local RWY_X0, RWY_X1 = RWY_CX - 4.0, RWY_CX + 4.0 -- runway strip edges (x)
local RWY_Z0, RWY_Z1 = -15010.0, -14890.0 -- runway strip ends (z), 120 long
local RWY_CZ = (RWY_Z0 + RWY_Z1) / 2.0 -- runway center z (-14950)
-- Fitted lakebed pad around the strip (100u cells sample the true
-- ground; the giant skirt cell underneath is cut around it, see bake).
local PAD_X0 = -650.0 -- strip + taxi room + tuck-under margin
local PAD_Z0 = -16200.0 -- overrun both ends + margin
local PAD_STEP = 100.0
local PAD_NX = 13
local PAD_NZ = 25
local PAD_VERTS = PAD_NX * PAD_NZ * 6 -- 1950, in sync with the pad loop
-- The one skirt cell holding the strip (cut out of the bake, replaced
-- by 4 surround quads + the pad). Bounds must match the south-band loop.
local HOLE_IX = 26 -- x0 = -556500 + 26*21000 = -10500
local HOLE_IZ = 0 -- z -22160..-1160
local HOLE_X0, HOLE_X1 = -600.0, 600.0 -- pad tucks 50u under every edge
local HOLE_Z0, HOLE_Z1 = -16150.0, -13750.0
-- Dry lakebed around the strip: fully flat this far out, then 600u of
-- smooth blend back up to the dunes. Must exceed the 1000u skirt cells so
-- every skirt corner near the strip is flat and never cuts the slabs.

local function sstep(a: number, b: number, t: number): number
    local u = math.clamp((t - a) / (b - a), 0, 1)
    return u * u * (3 - 2 * u)
end

-- Overshoot pop: 0 -> 1 past ~1.1, settling back to 1. Victory title
-- drops in and cubes slam to rest with it.
local function easeOutBack(t: number): number
    local c1, c3 = 1.70158, 2.70158
    local u = t - 1
    return 1 + c3 * u * u * u + c1 * u * u
end

local function groundH(x: number, z: number): number
    -- Rolling dunes: wavelengths stay well above the 20u mesh cells.
    -- Big L3 rollers ride on long waves (840u/370u: sampled exact, never
    -- alias), so the desert reads uneven everywhere, not flat.
    local base = 1.6 * math.sin(x * 0.11) * math.cos(z * 0.09)
        + 0.8 * math.sin(x * 0.045 + z * 0.038)
        + 0.4 * math.sin(x * 0.021 - z * 0.017)
        + 7.0 * math.sin(x * 0.0075 + 1.7) * math.cos(z * 0.0062)
        + 2.5 * math.sin(x * 0.017 + z * 0.013 + 0.6)
    -- Dry lakebed under the runway so the strip sits exact. Centered on
    -- the real strip (RWY_CX, RWY_CZ), not the origin.
    -- NOTE (Oct 9): the outer skirt now uses 21km cells, so its corners
    -- sit in full dunes and the interpolated sheet floats ~+0.2 over the
    -- strip, swallowing the slabs (spawn showed bare sand). The skirt is
    -- buried under the pad rect below, and a fitted 100u-cell pad mesh
    -- carries the true ground instead.
    local wx = 1 - sstep(800.0, 1400.0, math.abs(x - RWY_CX))
    local wz = 1 - sstep(900.0, 1500.0, math.abs(z - RWY_CZ))
    local w = wx * wz
    return base * (1 - w) + RWY_H * w
end

-- Stage foes for a live hunt: snapshot the jet's eye height, then ring
-- them ahead of the nose. Reset/park paths call spawnFoes directly.
local function stageFoes(self: Game)
    setAny(self, "foeEyeY", groundH(self.tx, self.tz) + self.hy + 1.8)
    spawnFoes(self)
end

-- Browser save bridge: the runtime has no storage, so an embedding
-- page persists three flags (localStorage) and restores them through
-- these view-model props. syncSave publishes every change; advance
-- adopts restored values. Standalone (preview / Rive link) the props
-- sit at false and nothing changes.
function syncSave(self: Game)
    local lvl2 = (self :: any).lvl2open or false
    local lvl3 = (self :: any).lvl3open or false
    local tut = (self :: any).tutMaster or false
    if self.svLvl2 ~= nil then self.svLvl2.value = lvl2 end
    if self.svLvl3 ~= nil then self.svLvl3.value = lvl3 end
    if self.svTut ~= nil then self.svTut.value = tut end
    if self.svSnd ~= nil then self.svSnd.value = self.soundOn end
    setVal(self, "svDone", ((self :: any).lvl3done or false))
    setVal(self, "svMus", ((self :: any).musicOn ~= false))
    setVal(self, "svTint", ((self :: any).planeTint or 4))
end
-- Retire the flight lessons: fresh patch at cruise height, hunt on.
-- Shared by PLAY (returning hero) and resets.
function retireTutorial(self: Game, welcomeBack: boolean)
    if (self :: any).level == 2 then
        stageParkour(self) -- returning hero skips straight to the circus
        return
    end
    if (self :: any).level == 3 then
        stageCourt(self) -- returning hero rejoins the storm, never the pumpkins
        return
    end
    setAny(self, "foeEyeY", 150.0)
    spawnFoes(self)
    ;(self :: any).tutIdx = -1
    ;(self :: any).tutDone = true
    if welcomeBack and self.msg ~= nil then
        self.msg.value = "WELCOME BACK, HERO - HIT THE PUMPKINS!"
    end
    if self.tut ~= nil then self.tut.value = "HIT THE PUMPKINS WITH YOUR GUNS!" end
    if self.tutA ~= nil then self.tutA.value = 1 end
    ;(self :: any).r2intro = 0
    ;(self :: any).r2introT = 2.0
end
-- Raise MORGATHA ahead of the jet nose at eye height, harmless until the
-- story briefing runs out (live). Called on the 5th pumpkin kill.
local function stageBoss(self: Game)
    local B = (self :: any).boss
    if B == nil then B = {}; (self :: any).boss = B end
    local fx, fz = math.sin(self.yaw), math.cos(self.yaw)
    local eye = groundH(self.tx, self.tz) + self.hy + 1.8
    local ax = self.tx + fx * 2000.0
    local az = self.tz + fz * 2000.0
    if ax > WRAP then ax -= WRAP * 2 elseif ax < -WRAP then ax += WRAP * 2 end
    if az > WRAP then az -= WRAP * 2 elseif az < -WRAP then az += WRAP * 2 end
    B.on = true
    B.live = false
    local prime = ((self :: any).level == 3)
    B.prime = prime
    B.max = prime and PRIME_HP or BOSS_HP
    B.hp = B.max
    B.sumT = PRIME_SUMMON_CD
    B.ax, B.az, B.alt = ax, az, eye
    B.x, B.y, B.z = ax, eye, az
    B.face = self.yaw
    B.mode = "stalk"
    B.modeT = 0
    B.atkT = 2.5
    B.chgT = 7.0
    B.tchCd = 0
    B.dvx, B.dvz = 0, 0
    B.enraged = false
    B.p2told = false
    B.sumT = PRIME_SUMMON_CD
    B.ph = 1.7
    -- Boss bar starts hidden: it pops up over him on the first hit.
    if self.bossHp ~= nil then self.bossHp.value = B.max end
    if self.bossBarA ~= nil then self.bossBarA.value = 0 end
    if self.bossNameY ~= nil then self.bossNameY.value = -300 end
end

-- Storm break shared by both triggers: proximity push-in AND liftoff.
-- The wall lifts over the ground army, thunder cracks, the horde stands
-- revealed. Global (advance calls it).
function courtBreak(self: Game, sx: number, sz: number)
    setAny(self, "l3phase", "staff")
    self.hy = 2000.0 -- the storm throws the plane out at the ceiling
    self.vy = 0
    setAny(self, "l3stormK", 0)
    setAny(self, "l3marchT", self.time) -- the horde starts marching now
    -- the storm throws the plane into the ring heart: exit INTO the army
    self.tx = (self :: any).l3armyX or L3_ARMY_X
    self.tz = ((self :: any).l3armyZ or L3_ARMY_Z) + 20000.0
    ;(self :: any).uwx = self.tx
    ;(self :: any).uwz = self.tz
    ;(self :: any).ptx = self.tx
    ;(self :: any).ptz = self.tz
    self.grounded = false
    self.roll = 0
    -- thunder-break: flashes inside the dying wall + a boom
    local gyS = groundH(sx, sz)
    if #self.chunks > 0 then
        for _ = 1, 6 do puff(self, 1, 300, 60, 0.9, gyS + 150, sx - self.tx, sz - self.tz) end
        for _ = 1, 8 do puff(self, 5, 200, 20, 2.6, gyS, sx - self.tx, sz - self.tz) end
    end
    playSfx(self, "crash", 1.0)
    -- No staff wave: the horde shootout runs clean, merge → GIGA → PRIME.
    -- Break greeting: instant volley + corpse timers (the sky-volley
    -- below is the fire wall now).
    setAny(self, "l3volT", 0.05)
    setAny(self, "l3zfireT", 2.5) -- corpse barrage joins after the jump intro
    setAny(self, "l3breakT", self.time + 1.0) -- break line hides a second after showing
    setAny(self, "throttle", 25.0) -- slow-mo reveal: crawl speed while the horde stands
    setAny(self, "l3floatT", 5.0) -- awe beat: level float, no sink, Q held through it just queues
    setAny(self, "l3chalFull", false)
    if self.tut ~= nil then self.tut.value = "THE HORDE WAKES - DODGE THE BARRAGE, SHOOT BACK!" end
    if self.tutA ~= nil then self.tutA.value = 1 end
    if self.msg ~= nil then self.msg.value = "THE HORDE STANDS - 10000 STRONG - HOLD HEIGHT + DISTANCE!" end
end

local GIANT_HP = 1000 -- GIGA: melee-only super-hunter, 1000 HP of kiting
local L3_MERGE_NEED = 6000 -- 60% of the horde dead: the rest run for the magma portal

-- Bury one clone: collapse its 360 verts underground in the kept CPU
-- copy; the draw pass uploads the batch. Global (bolt kills call it).
function buryZombie(self: Game, i: number)
    local cpu = self.armyCpu
    if cpu == nil then return end
    local sx, gy, sz = zombieBase(i)
    local j1 = math.sin(i * 12.9898) * 43758.5453
    j1 -= math.floor(j1)
    local o = (i - 1) * 396 * 7 * 4
    local c = cpu :: buffer
    for _ = 1, 396 do
        buffer.writef32(c, o, sx); o += 4
        buffer.writef32(c, o, gy - 1500.0); o += 4
        buffer.writef32(c, o, sz); o += 4
        buffer.writef32(c, o, 0.02); o += 4
        buffer.writef32(c, o, 0.02); o += 4
        buffer.writef32(c, o, 0.02); o += 4
        buffer.writef32(c, o, j1); o += 4
    end
    setAny(self, "l3armyDirty", true)
end

-- 6000 dead (60%): the rest run together to one center point and feed the
-- magma ball. Global (kill code calls it).
function startMerge(self: Game)
    setAny(self, "l3phase", "merge")
    setAny(self, "l3mergeX", L3_ARMY_X)
    setAny(self, "l3mergeZ", ((self :: any).l3armyZ or L3_ARMY_Z) + 20000.0)
    setAny(self, "l3mergeT", 18.0) -- run-in seconds: the horde pours into the globe
    setAny(self, "l3marchT", self.time) -- fresh origin: they RUN from
    -- wherever they stand, all the way into the globe heart
    if self.tut ~= nil then self.tut.value = "STOP THEM FROM ENTERING THE MAGMA GLOBE!" end
    if self.tutA ~= nil then self.tutA.value = 1 end
    if self.msg ~= nil then self.msg.value = "60% DOWN - HOLD THE GLOBE!" end
    playSfx(self, "crash", 0.5)
end

-- Retry from the giant: past-storm airborne restart at the boss, never
-- from the beginning. Global (retry click calls it).
function stageGiant(self: Game)
    local mx = (self :: any).l3mergeX or L3_ARMY_X
    local mz = (self :: any).l3mergeZ or L3_ARMY_Z
    setAny(self, "l3phase", "giant")
    setAny(self, "armyHidden", true) -- the horde is inside the giant now
    setAny(self, "l3giant", { x = mx, z = mz, hp = GIANT_HP, rise = 0, swpT = 0,
        windT = 0, windKind = "right", windAnim = "windR", side = 1, recT = 0,
        campT = 0, dustT = 0, enraged = false, roarT = 0, anim = "rise", briefT = 2.0,
        iconT = 15.0, iconDash = 0, iconSlam = false,
        deathT = 0, sink = 0 })
    for _, o in ipairs((self :: any).orbs) do o.on = false end
    for _, m in ipairs(self.msls) do m.on = false end
    for _, mb in ipairs(self.mslBooms) do mb.on = false end
    for _, b in ipairs(self.beams) do b.on = false end
    for _, c in ipairs(self.chunks) do c.on = false end
    setAny(self, "throttle", 700.0); setAny(self, "bank", 0); setAny(self, "kbx", 0); setAny(self, "kbz", 0); setAny(self, "kby", 0); setAny(self, "tumble", 0); setAny(self, "shakeT", 0); setAny(self, "l3floatT", 0)
    self.crashed = false
    self.hp = 100
    ;(self :: any).hitFlash = 0
    ;(self :: any).gigaGlow = 0
    if self.health ~= nil then self.health.value = 100 end
    if self.overA ~= nil then self.overA.value = 0 end
    self.grounded = false
    self.roll = 0
    self.tx = mx
    self.tz = mz - 4000.0
    ;(self :: any).uwx = self.tx
    ;(self :: any).uwz = self.tz
    ;(self :: any).ptx = self.tx
    ;(self :: any).ptz = self.tz
    self.yaw = 0
    self.camYaw = 0
    self.hy = 400.0
    self.vy = 0
    ;(self :: any).fwd = 700.0
    ;(self :: any).gspd = 700.0
    if self.tut ~= nil then self.tut.value = "THE GIGA RISES - IT CAN'T SHOOT, BUT DON'T LET IT TOUCH YOU!" end
    if self.tutA ~= nil then self.tutA.value = 1 end
    if self.msg ~= nil then self.msg.value = "GIGA " .. GIANT_HP .. " HP - OUTRUN ITS HANDS, AIM FOR THE TORSO!" end
end

-- GIGA 3-falls rule: the first two giant-phase falls rejoin at the giant,
-- the third restarts the whole level-3 run from the storm. Global (REMATCH
-- button + P key share it, so both count the same falls).
function giantRetry(self: Game)
    local php = (self :: any).l3phase
    if php ~= "giant" and php ~= "dying" then stageGiant(self); return end -- merge/magma/prime falls rejoin free, only GIGA falls count
    local w = ((self :: any).giantWrecks or 0) + 1
    setAny(self, "giantWrecks", w)
    if w >= 3 then
        setAny(self, "giantWrecks", 0)
        doReset(self) -- back to the beginning: runway + storm + horde
        if self.msg ~= nil then self.msg.value = "3 FALLS TO GIGA - BACK TO THE BEGINNING!" end
        return
    end
    stageGiant(self)
    if self.msg ~= nil then self.msg.value = "GIGA " .. GIANT_HP .. " HP - FALL " .. w .. "/3!" end
end

-- GIGA fell: full level-3 victory show, no PRIME ever rises. Global (the
-- dying block calls it; keeps advance lean).
function gigaWin(self: Game)
    self.hp = 100
    if self.health ~= nil then self.health.value = 100 end
    if self.msg ~= nil then self.msg.value = "GIGA DOWN - EARTH REVIVED! YOU WIN!" end
    if self.vitCubeA ~= nil then self.vitCubeA.value = "LEVEL 3" end
    if self.vitCubeB ~= nil then self.vitCubeB.value = "YOU WIN!" end
    setVal(self, "vitSub", "- YOUR THIRD VICTORY -")
    if self.bossBarA ~= nil then self.bossBarA.value = 0 end
    ;(self :: any).lvl2open = true
    ;(self :: any).lvl3open = true
    setAny(self, "lvl3done", true) -- GIGA felled: level 3 BEATEN, cube 3 earns its pumpkin
    setAny(self, "nextLevel", 3) -- game complete: CONTINUE replays level 3, never level 2
    syncSave(self)
    ;(self :: any).winT = 2.5
end

-- Zombie base position from clone index (deterministic: bake, hit
-- tests and burials all derive the same sx/gy/sz). Global (boot + frame).
function zombieBase(i: number): (number, number, number)
    -- Full war-ring around the heart (opens nowhere: the horde
    -- surrounds the jet), WIDE apart: 50 columns over 2π + 200
    -- radial rows + heavy jitter, so standing bodies show big gaps.
    -- Inner ranks stay in orb range so the barrage never goes quiet.
    -- Hollow pocket at the formation heart where the merge globe seeds.
    local col = (i - 1) % 50
    local row = math.floor((i - 1) / 50)
    local j1 = math.sin(i * 12.9898) * 43758.5453
    j1 -= math.floor(j1)
    local j2 = math.sin(i * 78.233 + 3.7) * 12543.1234
    j2 -= math.floor(j2)
    local ang = ((col + 0.5) / 50.0) * math.pi * 2.0 -- full ring, 50 wide columns
    local rad = 10000.0 + ((row + 0.5) / 200.0) * 10000.0 -- 10k..20k out: grand ring, dots still arrive on 14/12s lives
    local sx = L3_ARMY_X + math.cos(ang) * rad + (j1 - 0.5) * 2400.0
    local sz = L3_ARMY_Z + 20000.0 + math.sin(ang) * rad + (j2 - 0.5) * 2000.0
    return sx, groundH(sx, sz) - 0.3, sz
end

-- Live zombie position: base + analytic chase, replicating the zombie
-- WGSL march EXACTLY (bolt hits, zombie fire, and the shader must agree).
-- Staff/prime: the force STANDS its ground and fires from there, each
-- clone swaying on its own width; only the merge sprints. Merge:
-- Merge: straight sprint into the globe heart, no weave. Global (frame code).
function zombieLivePos(self: Game, i: number): (number, number, number)
    -- Zone aura: guaranteed A/B/C pressure (1.5/15/25 per second) that no
    -- amount of dodging avoids -- dumb ballistics alone go 100%-or-0% once
    -- you maneuver, so the spec numbers ride this tick, not orb connects.
    -- Piggybacked here (not advance): this runs several times a second
    -- through all staff/prime combat while advance has no budget left.
    -- Ticks at most once per second off the mission clock.
    if (self :: any).level == 3 then
        local php = (self :: any).l3phase
        if php == "staff" or php == "prime" then
            local now = self.time or 0
            local last = (self :: any).l3auraT or 0
            if now - last >= 1.0 then
                setAny(self, "l3auraT", now)
                local axx = (self :: any).l3armyX or 0.0
                local azz = ((self :: any).l3armyZ or 0.0) + 20000.0
                local ddx, ddz = self.tx - axx, self.tz - azz
                local dd = math.sqrt(ddx * ddx + ddz * ddz)
                local dps = 35.0
                if dd < 6000.0 then dps = 5.0 elseif dd < 13000.0 then dps = 25.0 end
                if not self.crashed and (self.homeTarget or 0) <= 0 then
                    self.hp -= dps
                    if self.health ~= nil then self.health.value = math.max(0, self.hp) end
                    setAny(self, "hitFlash", 1.0)
                    if self.hp <= 0 then downJet(self)
                    elseif self.msg ~= nil then self.msg.value = "HORDE BURNS YOU! HP " .. math.max(0, math.floor(self.hp)) end
                end
            end
        end
    end
    local sx, gy, sz = zombieBase(i)
    local mt = (self :: any).l3marchT or -1
    if mt < 0 then return sx, gy, sz end
    local mtx, mtz, mhold = self.tx, self.tz, 800.0
    local mspdBase = 0.0 -- the force STANDS its ground and fires; only the merge sprints
    local weave = true
    if (self :: any).l3phase == "merge" then
        mtx = (self :: any).l3mergeX or 0
        mtz = (self :: any).l3mergeZ or 0
        mspdBase, mhold, weave = 1500.0, 10.0, false
    end
    -- Per-body villain gait: own pace, own start delay, own sway width —
    -- no two clones walk the same line (the shader mirrors this exactly).
    local j1 = math.sin(i * 12.9898) * 43758.5453
    j1 -= math.floor(j1)
    local mspd = mspdBase * (0.7 + ((j1 * 5.7) % 1.0) * 0.6)
    local dto = j1 * 6.0
    local mdx, mdz = mtx - sx, mtz - sz
    local mdl = math.sqrt(mdx * mdx + mdz * mdz)
    local px, pz = sx, sz
    if mdl > 0.001 then
        local mst = math.min(math.max(self.time - mt - dto, 0) * mspd, math.max(mdl - mhold, 0))
        px += mdx / mdl * mst
        pz += mdz / mdl * mst
        if weave then
            local wv = math.sin(self.time * 1.7 + j1 * 6.2831) * (15.0 + 30.0 * j1)
            px += -mdz / mdl * wv
            pz += mdx / mdl * wv
        end
    end
    return px, gy, pz
end

-- Exact intercept aim: orb from M (mx,my,mz) at speed s to hit the
-- jet at P moving with velocity V. Solves |P + V*t - M| = s*t (smallest
-- positive root) — the old one/two-pass fixed-point leads missed a fast
-- jet by thousands of units (v_jet/v_orb ~ 0.5 diverges). Returns unit
-- dir + true, or false when there is no solution (then don't fire).
local function leadAim(px: number, py: number, pz: number,
    vx: number, vy: number, vz: number,
    mx: number, my: number, mz: number, s: number): (number, number, number, boolean)
    local rx, ry, rz = px - mx, py - my, pz - mz
    local a = vx * vx + vy * vy + vz * vz - s * s
    local b = 2.0 * (rx * vx + ry * vy + rz * vz)
    local c = rx * rx + ry * ry + rz * rz
    local t = -1.0
    if math.abs(a) < 0.001 then
        if math.abs(b) > 0.001 then t = -c / b end
    else
        local disc = b * b - 4.0 * a * c
        if disc >= 0 then
            local sq = math.sqrt(disc)
            local t1, t2 = (-b - sq) / (2.0 * a), (-b + sq) / (2.0 * a)
            if t1 > 0 and t2 > 0 then t = math.min(t1, t2)
            elseif t1 > 0 then t = t1
            elseif t2 > 0 then t = t2 end
        end
    end
    if t <= 0 then return 0, 0, 0, false end
    local dx, dy, dz = rx + vx * t, ry + vy * t, rz + vz * t
    local dl = math.sqrt(dx * dx + dy * dy + dz * dz)
    if dl < 0.001 then return 0, 0, 0, false end
    return dx / dl, dy / dl, dz / dl, true
end

-- SEEKER lock: crosshair first, nearest fallback. If the pinned
-- crosshair sits on a live enemy (smallest off-axis body inside a ~4deg
-- camera-ray cone, out to MSL_ACQ), that target wins; empty crosshair
-- falls back to nearest live enemy in MSL_ACQ, ANY direction — the
-- missile bends, so behind-the-jet targets lock too. Covers every
-- MORGATHA/PRIME, GIGA's torso, and the horde (sampled every 10th
-- body so the acquire stays cheap over 10000 clones). Returns
-- tkind/tidx (0/0 = nothing: dumbfire + airburst) — the lock is only
-- a starting guess, re-resolved every frame in flight.
local function mslAcquire(self: Game, dx: number, dy: number, dz: number): (number, number)
    local bestK, bestI, bestD = 0, 0, MSL_ACQ
    -- Stashed camera ray (written per frame where the crosshair looks).
    local ROx = (self :: any).gunPx
    local rayOn = ROx ~= nil and (self :: any).gunDx ~= nil
    local ROy, ROz, RDx, RDy, RDz = 0, 0, 0, 0, 0
    if rayOn then
        ROy = (self :: any).gunPy or 0
        ROz = (self :: any).gunPz or 0
        RDx = (self :: any).gunDx or 0
        RDy = (self :: any).gunDy or 0
        RDz = (self :: any).gunDz or 0
    end
    local xK, xI, xP = 0, 0, 1e18
    local function consider(k: number, i: number, px: number, py: number, pz: number)
        local ox, oy, oz = px - self.tx, py - (groundH(self.tx, self.tz) + self.hy + 1.8), pz - self.tz
        local d = math.sqrt(ox * ox + oy * oy + oz * oz)
        if d < 1.0 then d = 1.0 end
        -- No boresight gate: the missile bends, so anything in range
        -- locks even directly behind the jet. Nearest wins.
        if d < bestD then bestK, bestI, bestD = k, i, d end
        if rayOn then
            local rx, ry, rz = px - ROx, py - ROy, pz - ROz
            local t = rx * RDx + ry * RDy + rz * RDz
            if t > 0.0 and t < MSL_ACQ then
                local perp2 = rx * rx + ry * ry + rz * rz - t * t
                local allow = t * 0.07
                if perp2 >= 0.0 and perp2 < allow * allow and perp2 < xP then xK, xI, xP = k, i, perp2 end
            end
        end
    end
    if (self :: any).tutDone then
        for i, f in ipairs(self.foes) do
            if f.on then consider(1, i, f.x, f.y, f.z) end
        end
    end
    local BB = (self :: any).boss
    if BB ~= nil and BB.on and self.round == 3 then
        consider(2, 1, BB.x, BB.y, BB.z)
    end
    local G: any = (self :: any).l3giant
    if (self :: any).level == 3 and ((self :: any).l3phase == "giant")
        and G ~= nil and (G.rise or 0) >= 1 and (G.hp or 0) > 0 then
        consider(3, 1, G.x, groundH(G.x, G.z) + 3560.0, G.z)
    end
    do
        local phz = (self :: any).l3phase
        if (self :: any).level == 3 and not ((self :: any).armyHidden or false)
            and (phz == "staff" or phz == "prime" or phz == "merge") then
            local dead = (self :: any).armyDead or {}
            for i = 1, N_ARMY, 10 do
                if not dead[i] then
                    local px, gy, pz = zombieLivePos(self, i)
                    consider(4, i, px, gy + 165.0, pz)
                end
            end
        end
    end
    if xK > 0 then return xK, xI end -- crosshair sat on something: it wins
    return bestK, bestI
end

-- Resolve a live lock to a world point + fuse radius. Second return
-- is false when the lock died mid-flight (kill it dumb: short fuse).
local function mslTarget(self: Game, m: Msl): (number, number, number, number, boolean)
    if m.tkind == 1 then
        local f = self.foes[m.tidx]
        if f ~= nil and f.on then return f.x, f.y, f.z, FOE_R + 120.0, true end
    elseif m.tkind == 2 then
        local BB = (self :: any).boss
        if BB ~= nil and BB.on and (BB.hp or 0) > 0 then
            return BB.x, BB.y, BB.z, BOSS_R + 120.0, true
        end
    elseif m.tkind == 3 then
        local G: any = (self :: any).l3giant
        if G ~= nil and (G.rise or 0) >= 1 and (G.hp or 0) > 0 then
            return G.x, groundH(G.x, G.z) + 3560.0, G.z, 1750.0, true
        end
    elseif m.tkind == 4 then
        local dead = (self :: any).armyDead or {}
        if not dead[m.tidx] and not ((self :: any).armyHidden or false) then
            local px, gy, pz = zombieLivePos(self, m.tidx)
            return px, gy + 165.0, pz, 45.0, true
        end
    end
    return m.x + m.vx, m.y + m.vy, m.z + m.vz, 0, false
end

-- Seeker detonation: stages the WGSL fireball + shock ring pair,
-- throws a blast-pipe debris volley, booms, and burns EVERYTHING in
-- MSL_R — foes, boss, GIGA, and horde bodies (capped per boom so one
-- airburst can't eat the whole merge quota silently: it still counts).
local function mslBoom(self: Game, m: Msl)
    m.on = false
    local bt = self.time
    for _, kd in ipairs({ 1, 2 }) do
        local b = self.mslBooms[(self :: any).mslBoomIdx or 1]
        ;(self :: any).mslBoomIdx = ((self :: any).mslBoomIdx or 1) % MSL_BOOMS + 1
        b.on = true
        b.x, b.y, b.z = m.x, m.y, m.z
        b.kind = kd
        b.size = (kd == 1) and 2100.0 or 2800.0 -- 5x hit fireball + ring: the Seeker goes off huge
        b.seed = (m.x * 0.13 + m.z * 0.29 + kd * 17.0) % 1.0
        b.birth = bt + (kd == 2 and 0.08 or 0)
    end
    if #self.chunks > 0 then
        local ox, oz = m.x - self.tx, m.z - self.tz
        for _ = 1, 4 do puff(self, 0, 120, 60, 1.1, m.y, ox, oz) end
        for _ = 1, 2 do puff(self, 1, 80, 30, 0.6, m.y, ox, oz) end
        for _ = 1, 6 do puff(self, 2, 90, 120, 2.2, m.y, ox, oz) end
        for _ = 1, 8 do puff(self, 4, 200, 120, 0.8, m.y, ox, oz) end
        puff(self, 6, 60, 0, 0.9, m.y, ox, oz)
    end
    playSfx(self, "crash", 0.7)
    -- Own blast burns the shooter: point-blank = 100 (kill), fading to
    -- 0 at the fireball edge. Don't pop a seeker into a guy hugging you.
    do
        if not self.crashed then
            local jy = groundH(self.tx, self.tz) + self.hy + 1.8
            local jx, jyy, jz = self.tx - m.x, jy - m.y, self.tz - m.z
            local jd = math.sqrt(jx * jx + jyy * jyy + jz * jz)
            local RB = MSL_R + 120.0
            if jd < RB then
                local dealt = math.floor(100.0 * (1.0 - jd / RB) + 0.5)
                if dealt < 1 then dealt = 1 end
                self.hp -= dealt
                if self.health ~= nil then self.health.value = math.max(0, self.hp) end
                setAny(self, "hitFlash", 1.0) -- airframe flashes white
                if #self.chunks > 0 then -- sparks off the airframe
                    puff(self, 4, 12, 14, 0.5, jy, 0, 0)
                    puff(self, 1, 6, 4, 0.4, jy, 0, 0)
                end
                if self.hp <= 0 then
                    downJet(self)
                elseif self.msg ~= nil then
                    self.msg.value = "OWN BLAST! HP " .. math.max(0, self.hp)
                end
            end
        end
    end
    local R2 = (MSL_R + 120.0) * (MSL_R + 120.0)
    -- Foes + staff: pumpkins pop, staff eats MSL_DMG out of its pool.
    if (self :: any).tutDone then
        for fidx, f in ipairs(self.foes) do
            if f.on then
                local ex, ey, ez = f.x - m.x, f.y - m.y, f.z - m.z
                if ex * ex + ey * ey + ez * ez <= R2 then
                    local deadOne = true
                    if (self :: any).level == 3 and (f.kind or 0) > 0 or gateMode(self) and f.on then
                        f.hp -= MSL_DMG
                        deadOne = f.hp <= 0
                    end
                    if deadOne then
                        f.on = false
                        self.kills += 1
                        if gateMode(self) then
                            local gi = tunEnemyGate(fidx)
                            if gi ~= nil then tunEnemyDown(self, gi) end
                        end
                        if self.tutA ~= nil then self.tutA.value = 0 end
                        if #self.chunks > 0 then
                            local iox, ioz = f.x - self.tx, f.z - self.tz
                            puff(self, 7, 6, 8, 0.6, f.y, iox, ioz)
                            puff(self, 6, 10, 0, 0.9, f.y, iox, ioz)
                        end
                        if (self :: any).level == 3 then
                            courtAdvance(self)
                        elseif gateMode(self) then
                            -- Tunnel guards + heads: tunEnemyDown above owns progress and messages; the L1 round-advance below must never fire here (it staged MORGATHA in the tunnel on the 5th kill, and his death showed LEVEL 1 >> LEVEL 2)
                        elseif self.round == 3 and self.kills >= FOE_N and ((self :: any).wave or 0) == 0 then
                            setAny(self, "wave", 1)
                            ;(self :: any).lvl2open = true
                            ;(self :: any).waveT = WAVE_TIMES[1]
                            ;(self :: any).waveGap = 0
                            ;(self :: any).orbSpeed = WAVE_SPD[1]
                            ;(self :: any).lastTick = -1
                            if self.msg ~= nil then self.msg.value = "LEVEL 1 CLEAR - LEVEL 2 OPEN! Survive wave 1/3!" end
                        elseif self.msg ~= nil then
                            -- Same round-advance as the bolts: all pumpkins
                            -- down in round 1 stages MORGATHA himself.
                            if self.kills >= FOE_N then
                                self.msg.value = "ROUND 2 CLEAR!"
                                if self.round == 1 then
                                    self.round = 3 -- the patch has a king: straight to MORGATHA
                                    self.hp = 100
                                    if self.health ~= nil then self.health.value = 100 end
                                    stageBoss(self)
                                    setAny(self, "r3intro", 0)
                                    ;(self :: any).r3introT = 2.5
                                end
                            else
                                self.msg.value = "ROUND 2: PUMPKINS " .. self.kills .. "/5 - test your aim!"
                            end
                        end
                    elseif self.msg ~= nil then
                        self.msg.value = (FOE_NAMES[(f.kind or 1) + 1] or "MINION") .. " " .. math.max(0, f.hp) .. " HP!"
                    end
                end
            end
        end
    end
    -- Rock slab eats the blast: firing Seekers at wall 1 cracks it.
    -- Later walls never break (fly them) - Seeker blasts only spark there.
    do
        if gateMode(self) and (self.gateIdx or 1) == 1 then
            local w1: any = self.gates[1]
            if w1 ~= nil and w1.on and not w1.done then
                local ex, ey, ez = w1.x - m.x, w1.y - m.y, w1.z - m.z
                if ex * ex + ey * ey + ez * ez <= R2 then
                    damageWall(self, MSL_DMG)
                end
            end
        end
    end
    -- MORGATHA / PRIME eats the blast too.
    do
        local BB = (self :: any).boss
        if BB ~= nil and BB.on and self.round == 3 and (BB.hp or 0) > 0 then
            local ex, ey, ez = BB.x - m.x, BB.y - m.y, BB.z - m.z
            if ex * ex + ey * ey + ez * ez <= (MSL_R + BOSS_R) * (MSL_R + BOSS_R) then
                BB.hp -= MSL_DMG
                if #self.chunks > 0 then
                    local iox, ioz = BB.x - self.tx, BB.z - self.tz
                    puff(self, 7, 4, 6, 0.5, BB.y, iox, ioz)
                    puff(self, 4, 10, 14, 0.4, BB.y, iox, ioz)
                end
                if BB.hp <= 0 then
                    bossDie(self)
                elseif self.msg ~= nil then
                    local bname = (BB.prime == true) and "VOIDPUS " or "MORGATHA "
                    self.msg.value = "SEEKER HIT! " .. bname .. math.max(0, BB.hp) .. "/" .. (BB.max or BOSS_HP)
                end
            end
        end
    end
    -- GIGA torso eats the blast.
    do
        local G: any = (self :: any).l3giant
        if (self :: any).level == 3 and ((self :: any).l3phase == "giant")
            and G ~= nil and (G.rise or 0) >= 1 and (G.hp or 0) > 0 then
            local gyG = groundH(G.x, G.z)
            local ex, ey, ez = G.x - m.x, (gyG + 3560.0) - m.y, G.z - m.z
            if ex * ex + ey * ey + ez * ez <= (MSL_R + 1500.0) * (MSL_R + 1500.0) then
                G.hp -= MSL_DMG
                G.flashT = 1.0
                if #self.chunks > 0 then
                    local iox, ioz = G.x - self.tx, G.z - self.tz
                    puff(self, 7, 60, 80, 0.6, gyG + 3500, iox, ioz)
                    puff(self, 4, 80, 100, 0.5, gyG + 3750, iox, ioz)
                end
                if G.hp <= 0 then
                    if #self.chunks > 0 then
                        local kox, koz = G.x - self.tx, G.z - self.tz
                        for _ = 1, 20 do puff(self, 0, 400, 200, 2.2, gyG + 8000, kox, koz) end
                        for _ = 1, 10 do puff(self, 1, 300, 120, 0.9, gyG + 12000, kox, koz) end
                        for _ = 1, 4 do puff(self, 6, 100, 0, 1.2, gyG + 2000, kox, koz) end
                    end
                    playSfx(self, "crash", 1.0)
                    for _, oo in ipairs((self :: any).orbs) do oo.on = false end
                    G.deathT = 0
                    G.sink = 0
                    G.windT = 0
                    G.anim = "death"
                    setAny(self, "l3phase", "dying")
                    if self.msg ~= nil then self.msg.value = "GIGA FALLS..." end
                elseif self.msg ~= nil then
                    self.msg.value = "SEEKER HIT! GIGA " .. math.max(0, G.hp) .. "/" .. GIANT_HP
                end
            end
        end
    end
    -- Horde bodies inside the fireball die where they stand.
    do
        local phz = (self :: any).l3phase
        if (self :: any).level == 3 and not ((self :: any).armyHidden or false)
            and (phz == "staff" or phz == "prime" or phz == "merge") then
            local dead = (self :: any).armyDead or {}
            local got = 0
            for i = 1, N_ARMY do
                if got >= 150 then break end
                if not dead[i] then
                    local px, gy, pz = zombieLivePos(self, i)
                    local ex, ez = px - m.x, pz - m.z
                    if ex > -MSL_R * 25 and ex < MSL_R * 25 and ez > -MSL_R * 25 and ez < MSL_R * 25
                        and m.y > gy - 10.0 and m.y < gy + 325.0
                        and ex * ex + ez * ez <= MSL_R * MSL_R * 625 then
                        dead[i] = true
                        got += 1
                        ;(self :: any).armyDead = dead
                        ;(self :: any).l3zdead = ((self :: any).l3zdead or 0) + 1
                        buryZombie(self, i)
                        if ((self :: any).l3zdead or 0) % 50 == 0 and self.hp < 100 then
                            self.hp = math.min(100, self.hp + 5)
                            if self.health ~= nil then self.health.value = math.max(0, self.hp) end
                        end
                        if ((self :: any).l3zdead or 0) >= L3_MERGE_NEED
                            and ((self :: any).l3phase == "staff" or (self :: any).l3phase == "prime") then
                            startMerge(self)
                        end
                    end
                end
            end
            if got > 0 and self.msg ~= nil and (self :: any).l3phase ~= "merge" then
                self.msg.value = "SEEKER HIT! " .. ((self :: any).l3zdead or 0) .. " ZOMBIES DOWN!"
            end
        end
    end
end

-- Zombie damage tuning: full force (huge from first contact). One knob
-- over every horde hit (orbs, stomp, contact, bullet storm) so it tunes
-- in one place.
local L3_ZDMG = 2.0

-- Damage zones: concentric rings around the formation heart. The guaranteed
-- A/B/C pressure (1.5/15/25 per second) rides the aura tick in zombieLivePos,
-- not orb connects -- dodging beats dumb ballistics 100%, so per-hit tuning
-- can never land spec numbers. Orb tracers are visual-only chip now (below
-- the hit gate); homing missiles (boss-flagged) skip the scale and stay full
-- 30 everywhere. Global (all zombie hits).
local _L3_SAFE_DIST = 24000.0
function l3dmgScale(self: Game): number
    return 0.001 -- visual-only chip, always under the hit gate
end

-- Court reset: the storm opening. No foes up first: the jet takes off
-- and flies straight at the dust wall; proximity thins it (suspense),
-- then it breaks over the ground army and staff wave 1 rises to fight.
function stageCourt(self: Game)
    (self :: any).tutIdx = -1
    ;(self :: any).tutDone = true
    ;(self :: any).r2intro = -1
    if self.gateScore ~= nil then self.gateScore.value = "" end -- scoreboard is L2-only: never bleed into L3
    if self.gateScoreA ~= nil then self.gateScoreA.value = 0 end
    self.round = 3
    self.kills = 0
    ;(self :: any).l3phase = "storm"
    ;(self :: any).l3wave = 1
    ;(self :: any).l3stormK = 1
    ;(self :: any).l3mid = false
    setAny(self, "l3steadyT", -1.0) -- hold-steady hide timer (armed at MID)
    ;(self :: any).l3nagT = 0
    ;(self :: any).l3thunT = 3.0
    ;(self :: any).l3marchT = -1 -- horde holds until the storm breaks
    ;(self :: any).armyDead = {} -- clone kill flags, indexed 1..N_ARMY
    ;(self :: any).l3zdead = 0 -- horde kills toward the 60% merge (6000)
    ;(self :: any).armyHidden = false
    ;(self :: any).zsweep = 1 -- rotating bolt hit window over the horde
    ;(self :: any).l3volT = 1.5
    setAny(self, "l3floatT", 0) -- awe-beat timer, armed at the storm break
    ;(self :: any).l3giant = nil -- giant boss state, staged after magma
    ;(self :: any).l3gigaDown = false -- MORGATHA waits for the GIGA to fall
    ;(self :: any).l3chalShown = false -- storm-side challenge line not shown yet
    setAny(self, "l3chalFull", false) -- mission typewriter buffer (string while typing)
    setAny(self, "l3chalN", 0.0)
    setAny(self, "l3chalHid", false) -- mission hidden once the jet rolls
    setAny(self, "l3shotHid", false) -- DONT THINK hides on the first shootout shot
    setAny(self, "l3zfire", 1) -- round-robin zombie-fire cursor
    setAny(self, "giantWrecks", 0) -- GIGA falls reset on a fresh court run
    setAny(self, "l3zfireT", 1.0) -- first corpse-flame volley delay
    setAny(self, "l3runX", self.tx) -- runway roll anchor
    setAny(self, "l3runZ", self.tz)
    ;(self :: any).welcomed = true -- block the help-close greeting; L3 welcomes on the runway
    ;(self :: any).welcomeFull = "WELCOME ABOARD, HERO"
    ;(self :: any).welcomeT = 4.0 -- welcome plays the moment level 3 starts
    self.helpT = 0 -- Rotten Court never shows the controls board
    if self.ctlA ~= nil then self.ctlA.value = 0 end
    if self.welcome ~= nil then self.welcome.value = "" end
    if self.welcomeA ~= nil then self.welcomeA.value = 0 end
    resetBoss(self)
    for _, f in ipairs(self.foes) do f.on = false end
    ;(self :: any).l3stormX = L3_STORM_X
    ;(self :: any).l3stormZ = L3_STORM_Z
    ;(self :: any).l3armyX = L3_ARMY_X
    ;(self :: any).l3armyZ = L3_ARMY_Z
    -- One thick storm wall on the map center line: 275k long (5x, edge
    -- to edge past the horizon), 5500 tall, two faces 6000 apart (front
    -- + back). The WGSL boils + erodes them; the CPU only packs density.
    ;(self :: any).stormCells = {
        { yb = groundH(L3_STORM_X, L3_STORM_Z) - 50.0, zoff = 0.0, h = 5500.0, seed = 0.47, layer = 0 },
    }
    if self.tut ~= nil then self.tut.value = "" end
    if self.tutA ~= nil then self.tutA.value = 0 end
    if self.msg ~= nil then self.msg.value = "LEVEL 3: THE STORM AHEAD HIDES THE ROTTEN COURT" end
    cineStart(self) -- cinematic orbit first; the welcome + challenge line follow it
end

-- Court kill advance: called after a staff death (bolt or probe).
-- Rack kill advance: staff waves were cut, only the 2 launcher racks
-- live here now. Killing one silences its 5s twin-volley slot for good;
-- no waves stage, ever.
function courtAdvance(self: Game)
    local left = 0
    for _, g in ipairs(self.foes) do
        if g.on and (g.kind or 0) == 5 then left += 1 end
    end
    if self.msg ~= nil then
        if left > 0 then self.msg.value = "LAUNCHER DOWN - ONE STILL FIRING!"
        else self.msg.value = "BOTH LAUNCHERS DOWN - THE SKY IS YOURS!" end
    end
end

-- MORGATHA rots: the patch falls, level 2 opens, the sky stays red.
-- Global: the seeker detonation above calls it (forward-ref rule).
function bossDie(self: Game)
    local B = (self :: any).boss
    if B ~= nil then
        B.on = false
        B.live = false
    end
    for _, o in ipairs((self :: any).orbs) do o.on = false end
    ;(self :: any).lvl2open = true -- the patch falls: level 2 opens
    setAny(self, "nextLevel", 2) -- CONTINUE after an L1 win opens level 2
    syncSave(self) -- fresh code covers the unlock + trophy
    self.hp = 100
    if self.health ~= nil then self.health.value = 100 end
    if #self.chunks > 0 and B ~= nil then
        local iox, ioz = B.x - self.tx, B.z - self.tz
        for _ = 1, 3 do puff(self, 1, 14, 8, 0.7, B.y, iox, ioz) end
        for _ = 1, 20 do puff(self, 0, 50, 36, 2.0, B.y, iox, ioz) end
        for _ = 1, 12 do puff(self, 2, 22, 16, 3.0, B.y, iox, ioz) end
        for _ = 1, 14 do puff(self, 4, 44, 40, 1.2, B.y, iox, ioz) end
        for _ = 1, 2 do puff(self, 6, 8, 0, 0.9, B.y, iox, ioz) end
    end
    if gateMode(self) then return end -- leaked boss in the tunnel must never stage a victory show
    if not gateMode(self) then
        if self.msg ~= nil then self.msg.value = "MORGATHA ROTS - LEVEL 1 COMPLETE!" end
        if self.vitCubeA ~= nil then self.vitCubeA.value = "LEVEL 1" end
        if self.vitCubeB ~= nil then self.vitCubeB.value = "LEVEL 2" end
        setVal(self, "vitSub", "- YOUR FIRST VICTORY -")
    end
    if (self :: any).level == 3 then
        -- Final boss fell on his own stage: the whole earth revives.
        if self.msg ~= nil then self.msg.value = "VOIDPUS ROTS - EARTH REVIVED! YOU WIN!" end
        if self.vitCubeA ~= nil then self.vitCubeA.value = "LEVEL 3" end
        if self.vitCubeB ~= nil then self.vitCubeB.value = "YOU WIN!" end
        setVal(self, "vitSub", "- YOUR THIRD VICTORY -")
        ;(self :: any).lvl2open = true -- prime win unlocks like every other win (trophies read this)
        ;(self :: any).lvl3open = true
        setAny(self, "lvl3done", true) -- PRIME rotted: level 3 BEATEN, cube 3 earns its pumpkin
        syncSave(self)
        setAny(self, "nextLevel", 3) -- game complete: CONTINUE replays level 3, never level 2
    end
    playSfx(self, "crash", 1.0)
    -- Boss bar goes away with him.
    if self.bossBarA ~= nil then self.bossBarA.value = 0 end
    -- Victory lap: savor the explosion on the staged overlay, then home
    -- opens only via CONTINUE. vitT starts below once winT burns off.
    ;(self :: any).winT = 2.5
end

-- Level 2 parkour is live (same desert, circus rules: no foes, no boss).
function gateMode(self: Game): boolean
    return (self :: any).level == 2
end

-- Stage the 10 circus gates off the strip along the takeoff heading.
-- Each faces the next gate so the frames read head-on in flight.
-- Anchors are UNWRAPPED (exact across tile seams); altitude samples the
-- tile copy of the terrain under each gate.
function stageGates(self: Game)
    local sx, sz = 0.0, -15000.0 -- runway spawn, heading +z
    ;(self :: any).gates = {}
    self.gates = (self :: any).gates
    for _, f in ipairs(self.foes) do f.on = false end
    for i = 1, GATE_N do -- anchors by formula+table (theme/shape/mv were write-only)
        local dist = 4000.0 * i + (i == 1 and 1000.0 or 0.0) - (i == 2 and 1000.0 or 0.0)
        local alt = GATE_ALT[i]
        local gx, gz = sx, sz + dist
        local tgx = ((gx + WRAP) % (WRAP * 2)) - WRAP
        local tgz = ((gz + WRAP) % (WRAP * 2)) - WRAP
        local gy = groundH(tgx, tgz) + alt
        table.insert(self.gates, {
            on = true, x = gx, y = gy, z = gz,
            ax = gx, ay = gy, az = gz,
            alt = alt, yaw = 0, ph = i * 1.3, theme = 0,
            done = false, shape = 0, mv = 0,
            wall = i < 12 or i == 13 or i == 14 or i == 15 or i == 17,
            enemy = tunEnemySlot(i) ~= nil,
            foeSlot = tunEnemySlot(i),
        })
    end
    self.gateIdx = 1
    self.gateGraceT = 0
    ;(self :: any).gateWreckT = 0
    for gi = 1, GATE_N do
        local slot = tunEnemySlot(gi)
        local g = self.gates[gi]
        if slot ~= nil and g ~= nil then
            local f = self.foes[slot]
            f.on = true
            f.x, f.y, f.z = g.x, g.y, g.z
            f.ax, f.az, f.alt = g.x, g.z, g.y
            f.r, f.sp, f.ph, f.spin = 60.0, 0.0, gi * 1.7, 0.0
            f.kind, f.hp, f.tchCd, f.atkT = 4, 12, 0, 2.0
        end
    end
    ;(self :: any).fin = false -- finale re-stages on a fresh run
end

-- Shared wall-break flash + boom: bolts and Seeker pay out identically.
-- Global (zero registers); keeps the two break sites small for the budget.
function wallBoom(self: any, w: any)
    if #self.chunks > 0 then
        local iox: any, ioz: any = w.x - self.tx, w.z - self.tz
        puff(self, 1, 14, 8, 0.7, w.y, iox, ioz)
        puff(self, 4, 30, 40, 1.0, w.y, iox, ioz)
    end
    playSfx(self, "crash", 1.0)
end
-- Restart countdown: 3-2-1 on the tutorial prompt with the jet pinned
-- mid-air and the tube checks held off, then GO hands back cruise speed.
-- Global (stageParkour/gateRespawn call it; the tick lives in advance).
function gateCountdown(self: Game)
    setAny(self, "countT", 3.0)
    ;(self :: any).countH = self.hy
    ;(self :: any).countX = self.tx
    ;(self :: any).countZ = self.tz
    ;(self :: any).countGo = (self :: any).throttle or 700
    ;(self :: any).throttle = 0
    ;(self :: any).fwd = 0
    self.gateGraceT = 4.5
    if self.tutA ~= nil then self.tutA.value = 1 end
end
-- Restart tick: called once per frame from advance while in the tunnel.
-- Pins the jet mid-air, runs 3-2-1 on the prompt, GO hands back cruise.
function countTick(self: Game, dt: number)
    local ct = (self :: any).countT or 0
    if ct <= 0 then return end
    ct = math.max(0, ct - dt)
    ;(self :: any).countT = ct
    self.tx = (self :: any).countX or self.tx
    self.tz = (self :: any).countZ or self.tz
    self.hy = (self :: any).countH or self.hy
    ;(self :: any).throttle = 0
    ;(self :: any).fwd = 0
    if self.tut ~= nil then self.tut.value = ""; setVal(self, "cdNum", tostring(math.ceil(ct))) end
    if self.tutA ~= nil then self.tutA.value = 1 end
    if ct <= 0 then
        local go = (self :: any).countGo or 700
        ;(self :: any).throttle = go
        ;(self :: any).fwd = go
        if self.tut ~= nil then self.tut.value = "SHOOT AND DODGE THROUGH THE TUNNEL!" end
        if self.tutA ~= nil then self.tutA.value = 1; setVal(self, "cdNum", "") end
        ;(self :: any).gateIntroT = 2.0
        if self.msg ~= nil then self.msg.value = "GO! GATE " .. math.min(self.gateIdx or 1, GATE_N) .. "/20" end
    end
end
-- Round-opening cinematic: 9s eased camera sweep (~310 degrees, front /
-- side / rear takes in one rotating movement) under the mission line
-- (levels 2-3; level 1 stays clean: welcome, then straight to tutorial).
-- Global (zero registers, own scope). Staged at every round start (all
-- levels); L2's countdown starts when it ends. The jet is pinned on its
-- mark while the camera orbits it.
function cineStart(self: any)
    if (self :: any).cineSkip == true then
        setAny(self, "cineSkip", false)
        gateCountdown(self)
        return
    end
    setAny(self, "cineT", 9.0)
    setAny(self, "cineX", self.tx)
    setAny(self, "cineY", self.hy)
    setAny(self, "cineZ", self.tz)
    setAny(self, "cineYaw", self.yaw)
    setAny(self, "cineR", self.radius)
    setAny(self, "cineH", self.height)
    setAny(self, "cineL", self.lookH)
    setAny(self, "welcomed", (self :: any).level == 3) -- L1 tutorial waits for the real greeting (it starts when welcomed flips true); L3 keeps the storm welcome
    if self.tut ~= nil and (self :: any).level == 2 then
        self.tut.value = "MISSION 2: BREAK THE WALL - SHOOT AND DODGE THE TUNNEL!"
    end
    if self.tutA ~= nil then self.tutA.value = ((self :: any).level == 2 and 1 or 0) end
end
-- Cinematic tick: called once per frame from advance (all levels). Pins
-- the jet and sweeps the camera while the mission line rides. End hands
-- to the L2 countdown / briefing flow.
function cineTick(self: any, dt: number)
    local ct = (self :: any).cineT or 0
    if ct <= 0 then return end
    if (self.homeTarget or 0) > 0 then
        setAny(self, "cineT", 0)
        if self.tutA ~= nil then self.tutA.value = 0 end
        return
    end
    ct -= dt
    if ct <= 0 then
        setAny(self, "cineT", 0)
        self.camHold = 0
        if (self :: any).level == 2 then gateCountdown(self) end
        if (self :: any).level == 1 and ((self :: any).tutIdx or 0) == -1 then
            if self.tut ~= nil then self.tut.value = "HIT THE PUMPKINS WITH YOUR GUNS!" end
            if self.tutA ~= nil then self.tutA.value = 1 end
        end
        return
    end
    setAny(self, "cineT", ct)
    self.tx = (self :: any).cineX or self.tx
    self.tz = (self :: any).cineZ or self.tz
    self.hy = (self :: any).cineY or self.hy
    self.yaw = (self :: any).cineYaw or self.yaw
    local el = 9.0 - ct
    local u = el / 9.0
    self.camYaw = ((self :: any).cineYaw or 0) + 0.7 + u * u * (3 - 2 * u) * 5.4
    self.camHold = 0.3
    if not self.grounded then
        local k = ct / 9.0
        self.radius = ((self :: any).cineR or 13.0) + 13.0 * k
        self.height = ((self :: any).cineH or 6.0) + 7.0 * k
        self.lookH = ((self :: any).cineL or 3.5) + k
    end
    if self.tutA ~= nil and (self :: any).level == 2 then self.tutA.value = 1 end
end
-- Parkour setup, shared by resets and returning heroes: no tutorial, no
-- foes, no briefings from level 1 - just the circus and its first gate.
function stageParkour(self: Game)
    (self :: any).tutIdx = -1
    ;(self :: any).tutDone = true
    for _, f in ipairs(self.foes) do f.on = false end
    ;(self :: any).r2intro = -1
    stageGates(self)
    self.hp = 100
    if self.health ~= nil then self.health.value = 100 end
    self.crashed = false; self.crashT = 0; self.crashAcc = 0 -- a staged run is never a wreck (heals the 3-wreck + wall-1 early returns in gateRespawn)
    if self.overA ~= nil then self.overA.value = 0 end; setAny(self, "gateWreckT", 0) -- wreck panel off, stale burn timers never refire
    if self.msg ~= nil then self.msg.value = "LEVEL 2: BREAK THE WALL! SHOOT THE RED SLAB TO SMASH IT, THEN DODGE THE HAMMER, FAN, ROCKS AND THREAD THE NEEDLE! 5 PUMPKINS GUARD THE DEEP!" end
    -- Scoreboard intro up top for a few seconds, then the bare n/10 count.
    -- The level-1 tutorial prompt stays dark the whole circus.
    if self.tutA ~= nil then self.tutA.value = 0 end
    if self.gateScore ~= nil then self.gateScore.value = "SHOOT + DODGE 20!" end
    if self.gateScoreA ~= nil then self.gateScoreA.value = 1 end
    ;(self :: any).gateIntroT = 4.5
    -- Level 2 opens mid-air far before gate 1: a ~6000u straight approach
    -- (~6s at cruise) so the wall reads early and there is time to aim
    -- and open fire. The clamp corridor covers 22k behind gate 1, so the
    -- run-up is fenced long before the visual tube mouth. Dead-center.
    self.tx = 0.0
    self.tz = -16000.0
    self.yaw = 0
    self.camYaw = 0
    self.hy = 200.0
    self.vy = 0
    self.grounded = false
    self.roll = 0
    ;(self :: any).throttle = 1000
    ;(self :: any).fwd = 1000
    ;(self :: any).gspd = 0
    ;(self :: any).bank = 0
    setAny(self, "kbx", 0); setAny(self, "kbz", 0); setAny(self, "kby", 0); setAny(self, "tumble", 0); setAny(self, "shakeT", 0); setAny(self, "gateWrecks", 0)
    if (self :: any).level ~= 2 then self.helpT = 12 end -- controls board over the calm run-up (never L2; any input dismisses, C re-pops)
    ;(self :: any).uwx = self.tx
    ;(self :: any).uwz = self.tz
    ;(self :: any).ptx = self.tx
    ;(self :: any).ptz = self.tz
    cineStart(self) -- cinematic orbit first; its finish hands to gateCountdown
end

-- Circus complete: all 10 gates threaded or dodged. Fireworks over
-- the jet, then the same CONGRATULATIONS show as level 1 (winT -> vitT).
function level2Complete(self: Game)
    if ((self :: any).winT or 0) > 0 or ((self :: any).vitT or -1) >= 0 then return end
    self.hp = 100
    if self.health ~= nil then self.health.value = 100 end
    if #self.chunks > 0 then
        local gyF = groundH(self.tx, self.tz) + self.hy
        for _ = 1, 4 do puff(self, 1, 14, 8, 0.7, gyF, 0, 0) end
        for _ = 1, 3 do puff(self, 4, 30, 40, 1.0, gyF + 20, 0, 0) end
        for _ = 1, 2 do puff(self, 6, 8, 0, 0.9, gyF, 0, 0) end
    end
    if self.msg ~= nil then self.msg.value = "TUNNEL COMPLETE - 15 WALLS, 5 HEADS DOWN!" end
    if self.vitCubeA ~= nil then self.vitCubeA.value = "LEVEL 2" end
    if self.vitCubeB ~= nil then self.vitCubeB.value = "LEVEL 3" end
    setVal(self, "vitSub", "- YOUR SECOND VICTORY -")
    if self.tutA ~= nil then self.tutA.value = 0 end
    ;(self :: any).lvl2open = true -- finishing the circus implies level 2 open
    ;(self :: any).lvl3open = true -- the circus falls: level 3 opens
    setAny(self, "nextLevel", 3) -- CONTINUE after an L2 win opens level 3 (never L2 again)
    syncSave(self) -- fresh code covers the unlock
    if self.gateScore ~= nil then self.gateScore.value = "20/20!" end
    playSfx(self, "click")
    ;(self :: any).winT = 2.5
end

-- Parkour wreck: the full crash treatment (fireball volley, boom, burn),
-- then the timer below auto-respawns at the last cleared gate. Mercy
-- with a bang, not a silent teleport.
function gateCrash(self: Game)
    self.hy = 0.6
    self.crashed = true
    self.crashT = 0
    self.crashAcc = 0
    self.grounded = true
    self.roll = 0
    ;(self :: any).throttle = 0
    ;(self :: any).fwd = 0 -- dead stop: no slide past the blast
    if self.health ~= nil then self.health.value = 0 end
    if self.overA ~= nil then self.overA.value = 1 end
    if self.cursorC ~= nil then self.cursorC.value = "arrow" end
    if self.takeoffInst ~= nil then
        pcall(function() (self.takeoffInst :: any):stop() end)
        self.takeoffInst = nil
    end
    if self.jetInst ~= nil then
        pcall(function() (self.jetInst :: any):stop() end)
        self.jetInst = nil
    end
    if #self.chunks > 0 then
        local gyT = groundH(self.tx, self.tz)
        for _ = 1, 3 do puff(self, 1, 14, 8, 0.7, gyT) end -- bloom flashes
        for _ = 1, 26 do puff(self, 0, 60, 42, 2.2, gyT) end -- big layered fireballs
        for _ = 1, 14 do puff(self, 2, 26, 18, 3.2, gyT) end -- smoke
        for _ = 1, 24 do puff(self, 3, 44, 38, 2.2, gyT) end -- airframe parts
        for _ = 1, 16 do puff(self, 4, 52, 46, 1.3, gyT) end -- sparks
        for _ = 1, 11 do puff(self, 5, 40, 10, 2.6, gyT) end -- dust ring
        for _ = 1, 2 do puff(self, 6, 8, 0, 0.9, gyT) end -- shockwave rings
    end
    if self.msg ~= nil then
        self.msg.value = "WRECKED - BACK TO THE GATE..."
    end
    playSfx(self, "crash", 1.0) -- wreck boom at max volume
    ;(self :: any).gateWreckT = 2.5 -- burn, then the mercy respawn fires
    local wc: any = ((self :: any).gateWrecks or 0) + 1
    if (self :: any).fin == true then wc = 0 end -- finale: every head kill already forgives via rejoin; never full-reset mid-finale
    setAny(self, "gateWrecks", wc)
    if wc >= 3 then setAny(self, "gateFullReset", true); if self.msg ~= nil then self.msg.value = "3 WRECKS - BACK TO THE START!" end end
end

-- Parkour mercy: a wreck becomes a flash + airborne respawn at the last
-- cleared gate, heading for the next at cruise with 3s of grace. The
-- count survives; manual retries rejoin at the crash wall, never the start
-- (wall 1 falls back to the beginning), always behind a 3-2-1 countdown.
function gateRespawn(self: Game)
    local gs = self.gates
    local idx = math.clamp(self.gateIdx or 1, 1, GATE_N)
    if (self :: any).gateFullReset then setAny(self, "gateFullReset", false); setAny(self, "cineSkip", true); stageParkour(self); return end -- mercy rejoin skips the cinematic (straight to countdown)
    if idx <= 1 then -- wrecked on the first wall: from the beginning (cine skipped: mercy rejoin goes straight to countdown)
        setAny(self, "cineSkip", true)
        stageParkour(self)
        return
    end
    local tgt = gs[idx]
    if tgt == nil then return end
    local ox, oz, oalt = tgt.x, tgt.z, tgt.alt
    if (self :: any).fin == true and #self.gates >= GATE_N then -- finale wreck: rejoin just before the heads, keep their kill state
        local b20 = self.gates[GATE_N]
        if b20 ~= nil then tgt = b20; ox, oz = b20.x, b20.z - 1500.0; oalt = b20.alt end
    elseif gs[idx - 1] ~= nil then
    -- rejoin AT the last cleared wall and run the full leg again
        ox, oz = gs[idx - 1].x, gs[idx - 1].z
        oalt = gs[idx - 1].alt
    end
    local dx, dz = tgt.x - ox, tgt.z - oz
    local dl = math.sqrt(dx * dx + dz * dz)
    if dl < 0.001 then dl = 0.001 end
    local yaw = math.atan2(dx, dz)
    -- merge onto the lane: offset off dead-center so the run threads the
    -- annulus around the middle shapes instead of into them.
    -- Respawn in unwrapped space (exact across seams), tile for the world.
    -- merge dead-center into the bore (no side lane: walls are tight).
    -- AT the cleared wall: the whole leg ahead is the run-up.
    local ruwx, ruwz = ox, oz
    self.tx = ((ruwx + WRAP) % (WRAP * 2)) - WRAP
    self.tz = ((ruwz + WRAP) % (WRAP * 2)) - WRAP
    ;(self :: any).uwx = ruwx
    ;(self :: any).uwz = ruwz
    ;(self :: any).ptx = self.tx
    ;(self :: any).ptz = self.tz
    setAny(self, "wallPrev", nil) -- fresh plane-cross track (stale signs lie)
    self.yaw = yaw
    self.camYaw = yaw
    self.hy = math.max(oalt, 60.0)
    self.vy = 0; self.grounded = false; self.crashed = false; self.crashT = 0; self.crashAcc = 0; self.roll = 0
    setAny(self, "throttle", 700); setAny(self, "fwd", 700); setAny(self, "gspd", 0); setAny(self, "bank", 0)
    setAny(self, "kbx", 0); setAny(self, "kbz", 0); setAny(self, "kby", 0); setAny(self, "tumble", 0); setAny(self, "shakeT", 0)
    ;(self :: any).gateWreckT = 0
    resetTrail(self)
    self.hp = 100
    if self.health ~= nil then self.health.value = 100 end; if self.overA ~= nil then self.overA.value = 0 end
    if #self.chunks > 0 then
        for _ = 1, 2 do puff(self, 1, 10, 6, 0.6, groundH(self.tx, self.tz) + self.hy, 0, 0) end
    end
    if self.msg ~= nil then self.msg.value = "GATE " .. idx .. "/20 - AGAIN!" end
    playSfx(self, "click")
    -- wrecked on an enemy stage: the guard comes back alive (never mid-finale)
    local gg = self.gates[idx]
    if gg ~= nil and gg.enemy and gg.foeSlot ~= nil and (self.gateIdx or 1) <= GATE_N then
        local f = self.foes[gg.foeSlot]
        if f ~= nil then f.on = true; f.hp = 12; f.atkT = 2.0; f.x, f.y, f.z = gg.x, gg.y, gg.z; f.ax, f.az, f.alt = gg.x, gg.z, gg.y end
    end
    gateCountdown(self) -- 3-2-1 pinned before the run resumes
end

-- Shot down mid-air (round-2 beams): the wreck drops where it flies,
-- same full volley as a dune slam.
-- Global: mslBoom (defined above) calls it for own-blast kills.
-- Tunnel wall obstacles (gates 1-11, resolved by wallExtra below + 13/14/15/17
-- by wallExtra2): gate 1 is a solid rock slab sealing
-- the bore the jet must BREAK by firing (20 HP, bolts splat on it); gate 2
-- has a bottom gap the jet must duck under; gate 3 mirrors it with a top
-- gap to climb through; gate 4 is a slab with a tiny center eye that opens
-- only once its guard is dead; gate 5 leaves the left side open and gate 6
-- the right; gates 7-9 replay the duck/climb/eye layouts with the gap
-- sweeping left <-> right, and gates 10-11 are vertical slots sweeping in
-- opposite phases. Gates 13-15 + 17 are the second set (hammer/fan/rocks/slit).
-- The jet resolves by crossing the gate plane. Global (advance calls it once per frame, far below), so
-- the per-frame cost stays out of advance's own type budget.
-- Seeker blasts crack the rock slab: missiles are fire too. Called by
-- mslBoom at runtime (defined above it). Global: no register cost, and
-- the break staging mirrors wallUpdate so both paths pay out identically.
function damageWall(self: Game, dmg: number)
    local idx = self.gateIdx or 1 -- Seeker blasts crack the LIVE wall, whichever stage is up
    local w: any = self.gates[idx]
    if w == nil or not w.on or w.done or w.wall ~= true then return end
    local whp: any = (w :: any).whp
    if whp == nil then whp = 20.0 end
    if whp <= 0 then return end
    whp -= dmg
    ;(w :: any).whp = whp
    if #self.chunks > 0 then -- white hit-glow cluster on every missile crack, break or not
        local hox: number, hoz: number = w.x - self.tx, w.z - self.tz
        puff(self, 0, 10, 12, 0.6, w.y, hox, hoz)
        puff(self, 1, 14, 10, 0.9, w.y, hox, hoz)
        puff(self, 1, 14, 10, 0.9, w.y, hox, hoz)
    end
    if whp > 0 then return end
    wallBoom(self, w)
    if idx == 1 then wallClear(self, w, 1, "WALL BROKEN 1/20!")
    else wallClear(self, w, idx, "WALL SHATTERED " .. idx .. "/20!") end
end
-- All 11 tunnel walls in one any-typed pass. This absorbed wallUpdate (its
-- ~85 typed lines are gone): same constants, same rewards, same crash paths
-- - only the ~1.5u course-axis tilt (dy from alt bob; every anchor sits at
-- side 0) is folded away, so the gate plane is crossed when uwz passes g.z.
-- Global, own scope; advance calls it once per frame.
function wallExtra(self: any, g: any, idx: any, uwx: any, jetY: any, dt: any)
    if self.crashed then return end
    if g == nil or not g.on or g.done then return end
    local uwz: any = (self :: any).uwz or self.tz
    local jx: any, jy: any = uwx - g.x, jetY - g.y
    local sd: any = uwz - g.z
    if (idx >= 1 and idx <= 11) or (idx >= 13 and idx <= 15) or idx == 17 then -- bolt impacts: EVERY slab takes damage from any gun (bolts chew through, guards stay hittable behind the eyes)
        local whp: any = (g :: any).whp
        if whp == nil then whp = 20.0 end
        if whp > 0 then
            for _, b: any in ipairs(self.beams) do
                if b.on then
                    local s0: any = b.z - b.vz * dt - g.z
                    local s1: any = b.z - g.z
                    local ox: any, oy: any = b.x - g.x, b.y - g.y
                    if ((s0 > 0) ~= (s1 > 0) or math.abs(s1) < 50.0) and ox * ox + oy * oy < 102400.0 then
                        if idx == 1 then b.on = false end -- the rock swallows bolts, cracked slabs let them fly on
                        if idx == 1 then whp -= GUN_DMG[b.gun or 1] end -- only wall 1 breaks: the rest spark but hold (fly the gap)
                        if #self.chunks > 0 then puff(self, 4, 14, 20, 0.5, b.y, b.x - self.tx, b.z - self.tz) end
                        if #self.chunks > 0 then -- white hit-glow cluster: fire head + swelling blooms read at 2-3k
                            local hx, hz = b.x - self.tx, b.z - self.tz
                            puff(self, 0, 8, 10, 0.5, b.y, hx, hz)
                            puff(self, 1, 12, 8, 0.8, b.y, hx, hz)
                            puff(self, 1, 12, 8, 0.8, b.y, hx, hz)
                            puff(self, 1, 12, 8, 0.8, b.y, hx, hz)
                        end
                        if whp <= 0 then break end
                    end
                end
            end
            ;(g :: any).whp = whp
            if whp <= 0 then -- slab shattered: flash, boom, gate opens
                wallBoom(self, g)
                wallClear(self, g, idx, (idx == 1 and "WALL BROKEN " or "WALL SHATTERED ") .. idx .. "/20!")
                return
            end
        end
        if idx == 1 and math.abs(sd) < 60.0 and jx * jx + jy * jy < 102400.0 then
            gateCrash(self) -- flew into the rock: burn + mercy respawn
            return
        end
    end
    local psd: any = (self :: any).wallPrev
    if psd == nil or (self :: any).wallPrevIdx ~= idx then psd = sd end
    ;(self :: any).wallPrev = sd
    ;(self :: any).wallPrevIdx = idx
    if idx == 4 and sd < 0 and psd < 0 then -- crossed before the guard died: proximity recovery, no plane re-cross needed
        local open4r: any = (not g.enemy or g.foeSlot == nil or not (self.foes[g.foeSlot] :: any).on)
        if open4r and math.abs(jx) <= 100.0 and math.abs(jy) <= 80.0 then wallClear(self, g, idx, "THROUGH THE EYE 4/20!"); return end
    end
    if psd >= 0 or sd < 0 or (sd - psd) >= 2000.0 then return end
    if idx >= 13 then wallExtra2(self, g, idx, jx, jy, dt); return end
    local open4: any = idx == 4 and (not g.enemy or g.foeSlot == nil or not (self.foes[g.foeSlot] :: any).on) -- gate 4's eye: open once its guard is dead
    local gap: any = 180.0 * math.sin(self.time * 0.9 + idx * 1.3 + (idx == 11 and math.pi or 0.0)) -- sliders sweep left <-> right (gate 11 opposed)
    local gil: any = math.sin((self.time + idx * 1.7) * 1.745) -- guillotine blade: parked up half the 3.6s cycle, dropped half
    if idx == 1 then
        gateCrash(self) -- splat: the slab still stands, burn + mercy respawn
    elseif idx == 2 and jy <= -80.0 then -- ducked under
        wallClear(self, g, idx, "UNDER THE WALL 2/20!")
    elseif (idx == 3 or idx == 5 or idx == 8) and gil >= 0 and math.abs(jx) <= 230.0 and math.abs(jy) <= 280.0 then -- blade up: timed the guillotine
        wallClear(self, g, idx, "TIMED THE GUILLOTINE " .. idx .. "/20!")
    elseif idx == 4 and open4 and math.abs(jx) <= 100.0 and math.abs(jy) <= 80.0 then -- threaded the eye
        wallClear(self, g, idx, "THROUGH THE EYE 4/20!")
    elseif idx == 6 and jx >= -40.0 then -- round the right
        wallClear(self, g, idx, "RIGHT GAP 6/20!")
    elseif idx == 7 and jy <= -80.0 and math.abs(jx - gap) <= 280.0 then -- ducked the slider
        wallClear(self, g, idx, "UNDER THE SLIDER 7/20!")
    elseif idx == 9 and math.abs(jx - gap) <= 100.0 and math.abs(jy) <= 80.0 then -- moving eye
        wallClear(self, g, idx, "THROUGH THE MOVING EYE 9/20!")
    elseif (idx == 10 or idx == 11) and math.abs(jx - gap) <= 110.0 then -- sweeping slot
        wallClear(self, g, idx, "THREADED THE SLIDER " .. idx .. "/20!")
    else
        gateCrash(self) -- caught rock (or a live guard): burn + mercy respawn
    end
end
-- Wall reward: mark done, advance, heal, score, click. One copy for all
-- 15 walls (wallExtra + damageWall call it) so the type budget stays
-- flat as walls grow. Global (defined later than its callers).
function wallClear(self: Game, g: any, idx: number, msg: string)
    g.done = true
    self.gateIdx = idx + 1
    self.hp = 100
    if self.health ~= nil then self.health.value = 100 end; if self.msg ~= nil then self.msg.value = msg end
    if self.gateScore ~= nil then self.gateScore.value = self.gateIdx .. "/20" end
    playSfx(self, "click"); setAny(self, "gateWrecks", 0) -- cleared wall forgives past wrecks
end
-- Second-ring walls (13/14/15/17, called past the shared preamble).
function wallExtra2(self: any, g: any, idx: any, jx: any, jy: any, dt: any)
    if ((g :: any).whp or 20.0) <= 0 then wallClear(self, g, idx, "WALL SHATTERED " .. idx .. "/20!"); return end -- shot out by any gun (pool chewed in the shared bolt loop above)
    if idx == 13 then -- swinging hammer: dodge the head
        if math.abs(jx - 300.0 * math.sin(self.time * 1.7)) <= 100.0 and math.abs(jy - 40.0) <= 100.0 then gateCrash(self) else wallClear(self, g, idx, "DODGED THE HAMMER 13/20!") end
    elseif idx == 14 then -- spinning fan: hub hole or rim skim, the disc is death
        if jx * jx + jy * jy <= 6400.0 or jx * jx + jy * jy >= 78400.0 then wallClear(self, g, idx, "THREADED THE FAN 14/20!") else gateCrash(self) end
    elseif idx == 15 then -- falling rocks: split the gaps
        local rh: any = ((jx + 180.0) * (jx + 180.0) + (jy - (320.0 - ((self.time * 260.0) % 900.0))) * (jy - (320.0 - ((self.time * 260.0) % 900.0))) < 19600.0) or ((jx - 180.0) * (jx - 180.0) + (jy - (320.0 - ((self.time * 260.0 + 533.0) % 900.0))) * (jy - (320.0 - ((self.time * 260.0 + 533.0) % 900.0))) < 19600.0)
        if rh then gateCrash(self) else wallClear(self, g, idx, "DODGED THE ROCKS 15/20!") end
    elseif idx == 17 then -- needle slit: plane-size hole, center it
        if math.abs(jx) <= 55.0 and math.abs(jy) <= 45.0 then wallClear(self, g, idx, "THREADED THE NEEDLE 17/20!") else gateCrash(self) end
    else gateCrash(self) end
end
-- L2 FINALE: 3 floating bright-green horrors past the last wall. They
-- spit 50-HP missiles (dodge or die); shooting back is optional. Touching
-- the white end wall past them wins the round, kills or not.
function finStage(self: any)
    if (self :: any).fin == true then return end
    if (self.gateIdx or 1) <= GATE_N then return end
    setAny(self, "fin", true)
    local b20x, b20y, b20z = self.gates[GATE_N].x, self.gates[GATE_N].y, self.gates[GATE_N].z
    for fi: any, f: any in ipairs((self :: any).foes) do
        if fi <= 3 then
            f.on = true
            f.x, f.y, f.z = b20x + (fi - 2) * 260.0, b20y + 60.0, b20z + 1400.0 + fi * 300.0
            f.ax, f.az, f.alt = f.x, f.z, f.y
            f.r, f.sp, f.ph = 120.0, 0.5, fi * 2.1
            f.kind, f.hp, f.tchCd, f.atkT = 0, 12, 0, 1.5 + fi * 0.7
        else
            f.on = false
        end
    end
    if self.tut ~= nil then self.tut.value = "3 GREEN HORRORS - DODGE THEIR MISSILES, THEN TOUCH THE WHITE WALL!" end
    if self.tutA ~= nil then self.tutA.value = 1 end
    if self.gateScore ~= nil then self.gateScore.value = "3 HORRORS!" end
end
-- Wall visuals for gates 1-11 (drawWalls owns the loop; draw just calls).
function drawWalls(self: Game, gateCpu: buffer, uwx: number, uwz: number, o: number): number
    for i = 1, 20 do -- walls 1-11 + new 13/14/15/17; 12/16/20 enemy + 18/19 flybys draw nothing
        local w: any = self.gates[i]
        if w ~= nil and w.on and not w.done then
            local wx: any = self.tx + (w.x - uwx)
            local wz: any = self.tz + (w.z - uwz)
            local gx: any = 0.0
            if i >= 7 then
                gx = 180.0 * math.sin(self.time * 0.9 + i * 1.3)
                if i == 11 then gx = 180.0 * math.sin(self.time * 0.9 + 11 * 1.3 + math.pi) end
            end
            if i == 1 then -- solid breakable slab
                o = buildDot(gateCpu, o, wx, w.y, wz, 400, 400, 45, 1.0, 0.12, 0.15, w.ph + 200.0)
            elseif i == 2 or i == 7 then -- duck slab (+slider twin)
                o = buildDot(gateCpu, o, wx + gx, w.y + 100, wz, 350, 250, 30, 0.15, 0.45, 1.0, w.ph + 200.0); o = buildDot(gateCpu, o, wx + gx - 275, w.y - 250, wz, 75, 100, 30, 0.15, 0.45, 1.0, w.ph + 200.0); o = buildDot(gateCpu, o, wx + gx + 275, w.y - 250, wz, 75, 100, 30, 0.15, 0.45, 1.0, w.ph + 200.0)
            elseif i == 3 or i == 5 or i == 8 then -- guillotine: green frame + falling steel blade, red cutting edge
                local gb = math.sin((self.time + i * 1.7) * 1.745) * 260.0
                o = buildDot(gateCpu, o, wx - 275, w.y, wz, 75, 400, 30, 0.15, 1.0, 0.25, w.ph + 200.0); o = buildDot(gateCpu, o, wx + 275, w.y, wz, 75, 400, 30, 0.15, 1.0, 0.25, w.ph + 200.0); o = buildDot(gateCpu, o, wx, w.y + 330, wz, 350, 40, 30, 0.15, 1.0, 0.25, w.ph + 200.0); o = buildDot(gateCpu, o, wx, w.y + gb + 70, wz, 310, 70, 20, 0.75, 0.78, 0.85, w.ph + 200.0); o = buildDot(gateCpu, o, wx, w.y + gb + 8, wz, 310, 8, 22, 1.0, 0.12, 0.15, w.ph + 200.0)
            elseif i == 4 or i == 9 then -- tiny eye (+slider twin)
                o = buildDot(gateCpu, o, wx + gx, w.y + 240, wz, 400, 160, 45, 1.0, 0.12, 0.15, w.ph + 200.0); o = buildDot(gateCpu, o, wx + gx, w.y - 240, wz, 400, 160, 45, 1.0, 0.12, 0.15, w.ph + 200.0); o = buildDot(gateCpu, o, wx + gx - 250, w.y, wz, 150, 80, 45, 1.0, 0.12, 0.15, w.ph + 200.0); o = buildDot(gateCpu, o, wx + gx + 250, w.y, wz, 150, 80, 45, 1.0, 0.12, 0.15, w.ph + 200.0)
            elseif i == 6 then -- right gap
                o = buildDot(gateCpu, o, wx - 200, w.y, wz, 200, 400, 45, 0.15, 0.45, 1.0, w.ph + 200.0)
            elseif i == 10 or i == 11 then -- sweeping vertical slots, opposed phases
                o = buildDot(gateCpu, o, wx + (gx - 520.0) / 2.0, w.y, wz, (gx + 280.0) / 2.0, 400, 45, 1.0, 0.12, 0.15, w.ph + 200.0); o = buildDot(gateCpu, o, wx + (gx + 520.0) / 2.0, w.y, wz, (280.0 - gx) / 2.0, 400, 45, 1.0, 0.12, 0.15, w.ph + 200.0)
            elseif i == 13 then -- swinging hammer: sweeping orange head
                o = buildDot(gateCpu, o, wx + 300.0 * math.sin(self.time * 1.7), w.y + 40, wz, 65, 65, 55, 0.90, 0.45, 0.10, w.ph + 200.0)
            end -- 12/16/20 enemy + 18/19 flybys: no wall, nothing drawn
        end
    end
    return o
end
-- Second-ring visuals (fan/rocks/slit): own scope past drawWalls so the
-- per-function budget holds. Same phases the pass checks use. Global.
function drawWalls2(self: any, gateCpu: buffer, uwx: number, uwz: number, o: number): number
    local w14: any = self.gates[14]
    if w14 ~= nil and w14.on and not w14.done then o = buildDot(gateCpu, o, self.tx + (w14.x - uwx) + 200.0 * math.cos(self.time * 2.4), w14.y + 200.0 * math.sin(self.time * 2.4), self.tz + (w14.z - uwz), 55, 55, 35, 1.0, 0.12, 0.15, w14.ph + 200.0); o = buildDot(gateCpu, o, self.tx + (w14.x - uwx) + 200.0 * math.cos(self.time * 2.4 + 2.0944), w14.y + 200.0 * math.sin(self.time * 2.4 + 2.0944), self.tz + (w14.z - uwz), 55, 55, 35, 1.0, 0.12, 0.15, w14.ph + 200.0); o = buildDot(gateCpu, o, self.tx + (w14.x - uwx) + 200.0 * math.cos(self.time * 2.4 + 4.1888), w14.y + 200.0 * math.sin(self.time * 2.4 + 4.1888), self.tz + (w14.z - uwz), 55, 55, 35, 1.0, 0.12, 0.15, w14.ph + 200.0) end
    local w15: any = self.gates[15]
    if w15 ~= nil and w15.on and not w15.done then o = buildDot(gateCpu, o, self.tx + (w15.x - uwx) - 180, w15.y + 320.0 - ((self.time * 260.0) % 900.0), self.tz + (w15.z - uwz), 55, 55, 50, 0.15, 0.45, 1.0, w15.ph + 200.0); o = buildDot(gateCpu, o, self.tx + (w15.x - uwx) + 180, w15.y + 320.0 - ((self.time * 260.0 + 533.0) % 900.0), self.tz + (w15.z - uwz), 55, 55, 50, 0.15, 0.45, 1.0, w15.ph + 200.0) end
    local w17: any = self.gates[17]
    if w17 ~= nil and w17.on and not w17.done then o = buildDot(gateCpu, o, self.tx + (w17.x - uwx), w17.y + 185, self.tz + (w17.z - uwz), 400, 135, 45, 1.0, 0.85, 0.15, w17.ph + 200.0); o = buildDot(gateCpu, o, self.tx + (w17.x - uwx), w17.y - 185, self.tz + (w17.z - uwz), 400, 135, 45, 1.0, 0.85, 0.15, w17.ph + 200.0); o = buildDot(gateCpu, o, self.tx + (w17.x - uwx) - 190, w17.y, self.tz + (w17.z - uwz), 130, 45, 45, 1.0, 0.85, 0.15, w17.ph + 200.0); o = buildDot(gateCpu, o, self.tx + (w17.x - uwx) + 190, w17.y, self.tz + (w17.z - uwz), 130, 45, 45, 1.0, 0.85, 0.15, w17.ph + 200.0) end
    return o
end
function downJet(self: Game)
    if self.crashed then return end
    self.hy = 0.6
    self.crashed = true
    self.crashT = 0
    self.crashAcc = 0
    self.grounded = true
    self.roll = 0
    setAny(self, "throttle", 0)
    setAny(self, "fwd", 0)
    if self.health ~= nil then self.health.value = 0 end
    if self.overA ~= nil then self.overA.value = 1 end
    if self.cursorC ~= nil then self.cursorC.value = "arrow" end
    if self.takeoffInst ~= nil then
        pcall(function() (self.takeoffInst :: any):stop() end)
        self.takeoffInst = nil
    end
    if self.jetInst ~= nil then
        pcall(function() (self.jetInst :: any):stop() end)
        self.jetInst = nil
    end
    if #self.chunks > 0 then
        local gyT = groundH(self.tx, self.tz)
        for _ = 1, 3 do puff(self, 1, 14, 8, 0.7, gyT) end
        for _ = 1, 26 do puff(self, 0, 60, 42, 2.2, gyT) end
        for _ = 1, 14 do puff(self, 2, 26, 18, 3.2, gyT) end
        for _ = 1, 24 do puff(self, 3, 44, 38, 2.2, gyT) end
        for _ = 1, 16 do puff(self, 4, 52, 46, 1.3, gyT) end
        for _ = 1, 11 do puff(self, 5, 40, 10, 2.6, gyT) end
        for _ = 1, 2 do puff(self, 6, 8, 0, 0.9, gyT) end
    end
    if self.msg ~= nil then
        self.msg.value = "SHOT DOWN - press P to play again"
    end
    playSfx(self, "crash", 1.0)
end

-- Deterministic 0..1 hash for scattering stars.
local function rnd(i: number, s: number): number
    local x = math.sin(i * 12.9898 + s * 78.233) * 43758.5453
    return x - math.floor(x)
end

local RUINS = {
    { x = -30.0, z = -18.0, w = 9.0, h = 4.0, d = 7.0 },
    { x = -18.0, z = -22.0, w = 6.0, h = 3.0, d = 6.0 },
    { x = -38.0, z = -8.0, w = 7.0, h = 5.0, d = 5.0 },
    { x = -25.0, z = -30.0, w = 5.0, h = 2.6, d = 8.0 },
    { x = -12.0, z = -12.0, w = 8.0, h = 3.4, d = 5.0 },
    { x = 22.0, z = 14.0, w = 9.0, h = 4.2, d = 7.0 },
    { x = 32.0, z = 20.0, w = 6.0, h = 3.0, d = 6.0 },
    { x = 16.0, z = 24.0, w = 7.0, h = 3.8, d = 5.0 },
    { x = 28.0, z = 6.0, w = 5.0, h = 2.8, d = 8.0 },
    { x = -5.0, z = 38.0, w = 10.0, h = 4.5, d = 6.0 },
}

-- Halloween decorations scattered around spawn + ruins + graveyard.
local PUMPKINS = {
    { x = 4.0, z = 3.0, s = 1.3 },
    { x = -4.0, z = 2.0, s = 1.0 },
    { x = 2.0, z = -5.0, s = 1.5 },
    { x = -3.0, z = -4.0, s = 0.9 },
    { x = 7.0, z = -2.0, s = 1.1 },
    { x = -7.0, z = 5.0, s = 1.4 },
    { x = -52.0, z = -30.0, s = 1.2 },
    { x = 48.0, z = 32.0, s = 1.6 },
    { x = 36.0, z = 12.0, s = 1.0 },
    { x = -44.0, z = 22.0, s = 1.3 },
    { x = 10.0, z = 70.0, s = 1.2 },
    { x = -14.0, z = -68.0, s = 1.4 },
    -- Pumpkin patch east of spawn.
    { x = 12.0, z = -8.0, s = 1.2 },
    { x = -12.0, z = -14.0, s = 1.0 },
    { x = 20.0, z = 6.0, s = 1.3 },
    { x = -24.0, z = 20.0, s = 1.1 },
    { x = 30.0, z = 40.0, s = 1.4 },
    { x = -8.0, z = 52.0, s = 1.0 },
    { x = 52.0, z = -12.0, s = 1.2 },
    { x = -58.0, z = 2.0, s = 1.3 },
    -- A few more near spawn so the faces read up close.
    { x = 6.0, z = 6.0, s = 1.2 },
    { x = -8.0, z = -3.0, s = 1.0 },
    { x = 3.0, z = 10.0, s = 1.4 },
    { x = -2.0, z = 16.0, s = 1.1 },
    { x = 16.0, z = -6.0, s = 1.0 },
}

-- Broken huts: roofless/collapsed mud huts (7 boxes each, see init).
local HUTS = {
    { x = 14.0, z = -20.0, s = 1.0 },
    { x = -16.0, z = 28.0, s = 1.15 },
}

-- Scattered rocks (1 squashed box each).
local ROCKS = {
    { x = 8.0, z = 6.0, s = 0.9 },
    { x = -6.0, z = -10.0, s = 1.2 },
    { x = 18.0, z = 14.0, s = 0.7 },
    { x = -24.0, z = -2.0, s = 1.4 },
    { x = 30.0, z = -28.0, s = 1.0 },
    { x = -34.0, z = 34.0, s = 1.1 },
    { x = 6.0, z = 40.0, s = 0.8 },
    { x = -8.0, z = -34.0, s = 1.3 },
    { x = 44.0, z = 4.0, s = 1.0 },
    { x = -46.0, z = -14.0, s = 1.2 },
}

-- Graveyard cluster west of spawn.
local GRAVES = {
    { x = -20.0, z = 10.0 },
    { x = -22.5, z = 11.5 },
    { x = -18.0, z = 12.5 },
    { x = -21.0, z = 14.0 },
    { x = -19.0, z = 15.5 },
    { x = -23.0, z = 8.5 },
    { x = -17.0, z = 9.0 },
    { x = -20.5, z = 17.0 },
}

local DEAD_TREES = {
    { x = 10.0, z = 8.0 },
    { x = -10.0, z = -8.0 },
    { x = -28.0, z = 18.0 },
    { x = 40.0, z = 26.0 },
    { x = -56.0, z = -40.0 },
    { x = 14.0, z = -14.0 },
}

local BATS = {
    { x = 6.0, z = -6.0, y = 14.0 },
    { x = -8.0, z = 6.0, y = 16.0 },
    { x = 12.0, z = 4.0, y = 18.0 },
    { x = -14.0, z = -10.0, y = 13.0 },
    { x = 0.0, z = 12.0, y = 20.0 },
}

function init(self: Game, context: Context): boolean
    local vm = context:viewModel()
    if vm ~= nil then
        self.msg = vm:getString("message")
        self.welcome = vm:getString("welcome")
        self.welcomeA = vm:getNumber("welcomeA")
        self.welcomeX = vm:getNumber("welcomeX")
        self.welcomeY = vm:getNumber("welcomeY")
        self.welcomeS = vm:getNumber("welcomeS")
        self.tut = vm:getString("tut")
        self.tutA = vm:getNumber("tutA")
        self.niceA = vm:getNumber("niceA")
        self.tutX = vm:getNumber("tutX")
        self.tutY = vm:getNumber("tutY")
        self.gateScore = vm:getString("gateScore")
        self.gateScoreA = vm:getNumber("gateScoreA")
        self.gateScoreX = vm:getNumber("gateScoreX")
        self.gateScoreY = vm:getNumber("gateScoreY")
        self.niceX = vm:getNumber("niceX")
        self.niceY = vm:getNumber("niceY")
        self.lockMsg = vm:getString("lockMsg")
        self.lockA = vm:getNumber("lockA")
        self.lockX = vm:getNumber("lockX")
        self.lvlLock2 = vm:getNumber("lvlLock2")
        self.lvlLock3 = vm:getNumber("lvlLock3")
        self.loc = vm:getNumber("location")
        self.keyF = vm:getBoolean("keyF")
        self.keyB = vm:getBoolean("keyB")
        self.keyL = vm:getBoolean("keyL")
        self.keyR = vm:getBoolean("keyR")
        self.keyJump = vm:getBoolean("keyJump")
        self.keyBoost = vm:getBoolean("keyBoost")
        self.locked = vm:getBoolean("locked")
        self.health = vm:getNumber("health")
        self.hudBarX = vm:getNumber("hudBarX")
        self.hudBarY = vm:getNumber("hudBarY")
        self.hudHpX = vm:getNumber("hudHpX")
        self.hudNumX = vm:getNumber("hudNumX")
        self.speed = vm:getNumber("speed")
        self.alt = vm:getNumber("alt")
        self.hudSpdLabX = vm:getNumber("hudSpdLabX")
        self.hudSpdNumX = vm:getNumber("hudSpdNumX")
        self.hudAltLabX = vm:getNumber("hudAltLabX")
        self.hudAltNumX = vm:getNumber("hudAltNumX")
        self.hudStatY = vm:getNumber("hudStatY")
        self.hudMapX = vm:getNumber("hudMapX")
        self.hudMapY = vm:getNumber("hudMapY")
        self.overA = vm:getNumber("overA")
        self.overTitle = vm:getString("overTitle")
        self.overRetry = vm:getString("overRetry")
        self.overTitleX = vm:getNumber("overTitleX")
        self.overTitleY = vm:getNumber("overTitleY")
        self.overBtnX = vm:getNumber("overBtnX")
        self.overHomeX = vm:getNumber("overHomeX")
        self.overRetryY = vm:getNumber("overRetryY")
        self.overHomeY = vm:getNumber("overHomeY")
        self.mapPlaneX = vm:getNumber("mapPlaneX")
        self.mapPlaneY = vm:getNumber("mapPlaneY")
        self.aimX = vm:getNumber("aimX")
        self.aimY = vm:getNumber("aimY")
        self.aimA = vm:getNumber("aimA")
        self.aimLX = vm:getNumber("aimLX")
        self.aimRX = vm:getNumber("aimRX")
        self.aimTY = vm:getNumber("aimTY")
        self.aimBY = vm:getNumber("aimBY")
        self.bossHp = vm:getNumber("bossHp")
        self.bossBarX = vm:getNumber("bossBarX")
        self.bossBarY = vm:getNumber("bossBarY")
        self.bossBarA = vm:getNumber("bossBarA")
        self.bossNameY = vm:getNumber("bossNameY")
        self.bossName = vm:getString("bossName")
        self.unlockA = vm:getNumber("unlockA")
        self.unlockX = vm:getNumber("unlockX")
        self.unlockY = vm:getNumber("unlockY")
        self.unlockLit = vm:getNumber("unlockLit")
        self.unlockMsg = vm:getString("unlockMsg")
        self.vitCubeA = vm:getString("vitCubeA")
        self.vitCubeB = vm:getString("vitCubeB")
        self.vitA = vm:getNumber("vitA")
        self.vitTitleA = vm:getNumber("vitTitleA")
        self.vitTitleY = vm:getNumber("vitTitleY")
        self.vitL1X = vm:getNumber("vitL1X")
        self.vitL2X = vm:getNumber("vitL2X")
        self.vitL2A = vm:getNumber("vitL2A")
        self.vitLockA = vm:getNumber("vitLockA")
        self.vitLockX = vm:getNumber("vitLockX")
        self.vitLockY = vm:getNumber("vitLockY")
        self.vitContA = vm:getNumber("vitContA")
        self.vitContX = vm:getNumber("vitContX")
        self.vitContY = vm:getNumber("vitContY")
        self.vicTitleA = vm:getNumber("vicTitleA")
        self.vicTitleY = vm:getNumber("vicTitleY")
        self.vitL1A = vm:getNumber("vitL1A")
        self.vitFlash = vm:getNumber("vitFlash")
        self.vitL2Lit = vm:getNumber("vitL2Lit")
        self.vitSubA = vm:getNumber("vitSubA")
        self.vitRowY = vm:getNumber("vitRowY")
        self.vitTitleX = vm:getNumber("vitTitleX")
        self.vitUnlockY = vm:getNumber("vitUnlockY")
        self.vitEdgeL = vm:getNumber("vitEdgeL")
        self.vitEdgeR = vm:getNumber("vitEdgeR")
        self.vitEdgeT = vm:getNumber("vitEdgeT")
        self.vitEdgeB = vm:getNumber("vitEdgeB")
        self.vitArrowX = vm:getNumber("vitArrowX")
        self.vitSparkA = vm:getNumber("vitSparkA")
        self.vitSparkX = {}
        self.vitSparkY = {}
        for i = 0, 7 do
            local sx = vm:getNumber("vitSpark" .. i .. "X")
            if sx ~= nil then table.insert(self.vitSparkX, sx) end
            local sy = vm:getNumber("vitSpark" .. i .. "Y")
            if sy ~= nil then table.insert(self.vitSparkY, sy) end
        end
        self.vitConfA = vm:getNumber("vitConfA")
        self.vitConfX = {}
        self.vitConfY = {}
        for i = 0, 9 do
            local vcx = vm:getNumber("vitConf" .. i .. "X")
            if vcx ~= nil then table.insert(self.vitConfX, vcx) end
            local vcy = vm:getNumber("vitConf" .. i .. "Y")
            if vcy ~= nil then table.insert(self.vitConfY, vcy) end
        end
        self.vitSubY = vm:getNumber("vitSubY")
        self.vitDotY = vm:getNumber("vitDotY")
        self.vitL2FX = vm:getNumber("vitL2FX")
        self.vitL2FY = vm:getNumber("vitL2FY")
        self.vitDotX = {}
        for i = 0, 4 do
            local dx = vm:getNumber("vitDot" .. i .. "X")
            if dx ~= nil then table.insert(self.vitDotX, dx) end
        end
        self.pumpX = vm:getNumber("pumpX")
        self.pumpY = vm:getNumber("pumpY")
        self.pump2A = vm:getNumber("pump2A")
        self.pk3A = vm:getNumber("pk3A")
        self.pk3X = vm:getNumber("pk3X")
        self.pk3Y = vm:getNumber("pk3Y")
        self.svLvl2 = vm:getBoolean("svLvl2")
        self.svLvl3 = vm:getBoolean("svLvl3")
        self.svTut = vm:getBoolean("svTut")
        self.svSnd = vm:getBoolean("svSnd")
        setAny(self, "svMus", vm:getBoolean("svMus"))
        setAny(self, "svTint", vm:getNumber("svTint"))
        setAny(self, "svDone", vm:getBoolean("svDone"))
        setAny(self, "pk1A", vm:getNumber("pk1A"))
        setAny(self, "pk3DoneA", vm:getNumber("pk3DoneA"))
        setAny(self, "bookA", vm:getNumber("bookA"))
        self.gunX1 = vm:getNumber("gunX1")
        self.gunX2 = vm:getNumber("gunX2")
        self.gunX3 = vm:getNumber("gunX3")
        self.gunX4 = vm:getNumber("gunX4")
        self.gunRowY = vm:getNumber("gunRowY")
        self.gunHLX = vm:getNumber("gunHLX")
        self.gunDim = vm:getNumber("gunDim")
        self.trailX = {}
        self.trailY = {}
        for i = 0, TRAIL_N - 1 do
            local px = vm:getNumber("trail" .. i .. "X")
            if px ~= nil then table.insert(self.trailX, px) end
            local py = vm:getNumber("trail" .. i .. "Y")
            if py ~= nil then table.insert(self.trailY, py) end
        end
        self.trail = {}
        for _ = 1, TRAIL_N do
            table.insert(self.trail, { x = self.tx, z = self.tz })
        end
        self.trailIdx = 1
        self.trailAcc = 0
        self.foeX = {}
        self.foeY = {}
        for i = 0, FOE_N - 1 do
            local px = vm:getNumber("foe" .. i .. "X")
            if px ~= nil then table.insert(self.foeX, px) end
            local py = vm:getNumber("foe" .. i .. "Y")
            if py ~= nil then table.insert(self.foeY, py) end
        end
        self.foes = {}
        self.kills = 0
        self.gates = {} -- level 2 circus: staged by stageParkour, empty until then
        self.gateIdx = 1
        self.gateGraceT = 0
        spawnFoes(self)
        -- Tutorial first: keep every pumpkin hidden until the timeline
        -- completes (tutDone). Foes park off until then.
        for _, f in ipairs(self.foes) do f.on = false end
        ;(self :: any).tutDone = false
        self.round = 1
        self.hp = 100
        ;(self :: any).hitFlash = 0 -- white damage flash, set on orb hits
        ;(self :: any).planeTint = 4 -- settings paint pick (1-5), VIPER green default, never reset
        setAny(self, "musicOn", true) -- settings music toggle, on by default
        setAny(self, "musBX", 0)
        setAny(self, "musBY", 0)
        setAny(self, "swBX0", 0)
        setAny(self, "swBX1", 0)
        setAny(self, "swBX2", 0)
        setAny(self, "swBX3", 0)
        setAny(self, "swBX4", 0)
        setAny(self, "swBY", 0)
    ;(self :: any).gigaGlow = 0 -- hot GIGA-hit burn, set on hand/kick lands
        ;(self :: any).level = 1
        ;(self :: any).lvl2open = false -- MORGATHA opens it, survives resets
        ;(self :: any).lvl3open = false -- the circus opens it, survives resets
        ;(self :: any).lvl3done = false -- PRIME opens it, survives resets
        ;(self :: any).orbs = {}
        for _ = 1, ORB_SLOTS do
            table.insert((self :: any).orbs, { on = false, x = 0, y = 0, z = 0, vx = 0, vy = 0, vz = 0, life = 0 })
        end
        resetBoss(self) -- MORGATHA parked until round 3
        ;(self :: any).roundT = 0
        ;(self :: any).surviveT = 0
        ;(self :: any).orbT = 0
        ;(self :: any).lastTick = -1
        ;(self :: any).levelBlend = 0 -- desert WGSL green/red grade, eased in round 3
        ;(self :: any).wave = 0 -- round-3 phase: 0 pumpkins, 1-3 beam waves, 4 done
        ;(self :: any).waveT = 0
        ;(self :: any).waveGap = 0
        ;(self :: any).orbSpeed = ORB_SPEED
        ;(self :: any).welcomed = false -- greeting fires once per run
        ;(self :: any).hadHelp = false
        ;(self :: any).welcomeT = 0
        self.cursorC = vm:getString("cursor")
        self.gunHL = vm:getString("gunHL")
        setAny(self, "ruleL0", vm:getString("ruleL0"))
        setAny(self, "ruleL1", vm:getString("ruleL1"))
        setAny(self, "ruleL2", vm:getString("ruleL2"))
        setAny(self, "ruleL3", vm:getString("ruleL3"))
        setAny(self, "ruleL4", vm:getString("ruleL4"))
        setAny(self, "ruleL5", vm:getString("ruleL5"))
        setAny(self, "ruleScrY", vm:getNumber("ruleScrY")); self.heroA = vm:getNumber("heroA")
        self.heroX = vm:getNumber("heroX")
        self.heroY = vm:getNumber("heroY")
        self.heroSX = vm:getNumber("heroSX")
        self.heroSY = vm:getNumber("heroSY")
        self.loadW = vm:getNumber("loadW")
        self.loadBarX = vm:getNumber("loadBarX")
        self.loadBarY = vm:getNumber("loadBarY")
        self.loadLabY = vm:getNumber("loadLabY")
        self.homeA = vm:getNumber("homeA")
        self.homeX = vm:getNumber("homeX")
        self.homeY = vm:getNumber("homeY")
        self.homeSX = vm:getNumber("homeSX")
        self.homeSY = vm:getNumber("homeSY")
        self.homeTitleX = vm:getNumber("homeTitleX")
        self.homeTitleY = vm:getNumber("homeTitleY")
        self.startX = vm:getNumber("startX")
        self.startBtnY = vm:getNumber("startBtnY")
        setAny(self, "devL2X", vm:getNumber("devL2X"))
        setAny(self, "devL2Y", vm:getNumber("devL2Y"))
        setAny(self, "devL3X", vm:getNumber("devL3X"))
        setAny(self, "devL3Y", vm:getNumber("devL3Y"))
        setAny(self, "bookX", vm:getNumber("bookX"))
        setAny(self, "bookY", vm:getNumber("bookY"))
        self.startLabY = vm:getNumber("startLabY")
        self.btnA = vm:getNumber("btnA")
        self.setA = vm:getNumber("setA")
        self.rulA = vm:getNumber("rulA")
        self.backA = vm:getNumber("backA")
        self.panelTA = vm:getNumber("panelTA")
        self.mainX = vm:getNumber("mainX")
        self.hovPlay = vm:getNumber("hovPlay")
        self.hovSet = vm:getNumber("hovSet")
        self.hovRul = vm:getNumber("hovRul")
        self.playY = vm:getNumber("playY")
        self.lvlX1 = vm:getNumber("lvlX1")
        self.lvlX2 = vm:getNumber("lvlX2")
        self.lvlX3 = vm:getNumber("lvlX3")
        self.lvlY = vm:getNumber("lvlY")
        self.lvlLineY = vm:getNumber("lvlLineY")
        self.lvlLabX1 = vm:getNumber("lvlLabX1")
        self.lvlLabX2 = vm:getNumber("lvlLabX2")
        self.lvlLabX3 = vm:getNumber("lvlLabX3")
        self.lvlLabY = vm:getNumber("lvlLabY")
        self.lockX2 = vm:getNumber("lockX2")
        self.lockBY2 = vm:getNumber("lockBY2")
        self.lockSY2 = vm:getNumber("lockSY2")
        self.lockX3 = vm:getNumber("lockX3")
        self.lockBY3 = vm:getNumber("lockBY3")
        self.lockSY3 = vm:getNumber("lockSY3")
        self.connX0 = vm:getNumber("connX0")
        self.connX1 = vm:getNumber("connX1")
        self.connY = vm:getNumber("connY")
        self.setY = vm:getNumber("setY")
        self.rulY = vm:getNumber("rulY")
        self.rulX = vm:getNumber("rulX")
        self.sndX = vm:getNumber("sndX")
        self.sndY = vm:getNumber("sndY")
        self.setCtlX = vm:getNumber("setCtlX")
        self.setCtlY = vm:getNumber("setCtlY")
        setAny(self, "setPanelX", vm:getNumber("setPanelX"))
        setAny(self, "setPanelY", vm:getNumber("setPanelY"))
        setAny(self, "musX", vm:getNumber("musX"))
        setAny(self, "musY", vm:getNumber("musY"))
        setAny(self, "swX0", vm:getNumber("swX0"))
        setAny(self, "swX1", vm:getNumber("swX1"))
        setAny(self, "swX2", vm:getNumber("swX2"))
        setAny(self, "swX3", vm:getNumber("swX3"))
        setAny(self, "swX4", vm:getNumber("swX4"))
        setAny(self, "swY", vm:getNumber("swY"))
        setAny(self, "swHlX", vm:getNumber("swHlX"))
        setAny(self, "setHdX", vm:getNumber("setHdX"))
        setAny(self, "setHdY", vm:getNumber("setHdY"))
        setAny(self, "tickX", vm:getNumber("tickX"))
        setAny(self, "tickY", vm:getNumber("tickY"))
        self.backX = vm:getNumber("backX")
        self.backY = vm:getNumber("backY")
        self.rulBodyX = vm:getNumber("rulBodyX")
        self.rulBodyY = vm:getNumber("rulBodyY")
        self.ctlBodyX = vm:getNumber("ctlBodyX")
        self.ctlBodyY = vm:getNumber("ctlBodyY")
        self.ctlBodyRX = vm:getNumber("ctlBodyRX")
        local ctlLY: { Property<number> } = {}
        for i = 0, 4 do
            local p = vm:getNumber("ctlLY" .. i)
            if p then table.insert(ctlLY, p) end
        end
        self.ctlLY = ctlLY
        local ctlRY: { Property<number> } = {}
        for i = 0, 5 do
            local p = vm:getNumber("ctlRY" .. i)
            if p then table.insert(ctlRY, p) end
        end
        self.ctlRY = ctlRY
        self.ctlA = vm:getNumber("ctlA")
        self.ctlPanelX = vm:getNumber("ctlPanelX")
        self.ctlPanelY = vm:getNumber("ctlPanelY")
        self.ctlTitleX = vm:getNumber("ctlTitleX")
        self.ctlTitleY = vm:getNumber("ctlTitleY")
        self.ctlXBtnX = vm:getNumber("ctlXBtnX")
        self.ctlXBtnY = vm:getNumber("ctlXBtnY")
        self.dimX = vm:getNumber("dimX")
        self.dimY = vm:getNumber("dimY")
        self.dimW = vm:getNumber("dimW")
        self.clickX = vm:getNumber("clickX")
        self.clickY = vm:getNumber("clickY")
        self.clickA = vm:getNumber("clickA")
        self.fogX = {}
        local fx: { Property<number> } = {}
        for i = 0, 5 do
            local fp = vm:getNumber("fog" .. i .. "X")
            if fp then table.insert(fx, fp) end
        end
        self.fogX = fx
        self.smokeX = {}
        self.smokeY = {}
        local sx: { Property<number> } = {}
        local sy: { Property<number> } = {}
        for i = 0, 13 do
            local xp = vm:getNumber("smoke" .. i .. "X")
            if xp then table.insert(sx, xp) end
            local yp = vm:getNumber("smoke" .. i .. "Y")
            if yp then table.insert(sy, yp) end
        end
        self.smokeX = sx
        self.smokeY = sy
        self.smokeA = {}
        self.smokeS = {}
        local sa: { Property<number> } = {}
        local ss: { Property<number> } = {}
        for i = 0, 13 do
            local ap = vm:getNumber("smoke" .. i .. "A")
            if ap then table.insert(sa, ap) end
            local sp = vm:getNumber("smoke" .. i .. "S")
            if sp then table.insert(ss, sp) end
        end
        self.smokeA = sa
        self.smokeS = ss
        self.cardA = vm:getNumber("cardA")
        self.cardX = vm:getNumber("cardX")
        self.cardY = vm:getNumber("cardY")
        self.cardBtnX = vm:getNumber("cardBtnX")
        self.cardResY = vm:getNumber("cardResY")
        self.cardHomeY = vm:getNumber("cardHomeY")
        self.cardCtlY = vm:getNumber("cardCtlY")
        self.cardTitleX = vm:getNumber("cardTitleX")
        self.cardTitleY = vm:getNumber("cardTitleY")
        self.smokeBaseY = 460
        self.titleTxt = vm:getString("titleTxt")
        self.sndTxt = vm:getString("sndTxt")
        setAny(self, "musTxt", vm:getString("musTxt"))
        setAny(self, "vitSub", vm:getString("vitSub"))
        setAny(self, "cdNum", vm:getString("cdNum"))
        self.pauseTxt = vm:getString("pauseTxt")
    end
    self.takeoffSnd = context:audio("engine_takeoff")
    self.jetSnd = context:audio("jetloop")
    self.homeBellsSnd = context:audio("homebells")
    -- Sound board: named sources for every UI/game sound. To add a new
    -- sound later: drop the wav, add one RML AudioAsset, one line here,
    -- then playSfx(self, "name") from anywhere.
    self.sfx = {
        click = context:audio("click"),
        takeoff = context:audio("engine_takeoff"),
        smg = context:audio("smg"),
        rifle = context:audio("rifle"),
        crash = context:audio("crash"),
        cannon = context:audio("cannon"),
        -- future: win = context:audio("win"),
    }
    self.moonImg = context:image("moon")
    self.heroImg = context:image("hero")
    self.homeImg = context:image("homebg")
    if self.loc ~= nil then self.loc.value = 0 end
    if self.health ~= nil then self.health.value = 100 end
    if self.locked ~= nil then self.locked.value = false end
    if self.msg ~= nil then self.msg.value = "hold Q to spool up - W rotates at speed, E brakes, Space fires" end

    self.gpuOk = false
    local ok = pcall(function()
        -- Build mesh: core grid + outer skirt + props, pos(3) + color(3).
        -- NOTE: keep midBoxes/outerBoxes in sync with the pushBox calls below.
        local groundVerts = GRID_N * GRID_N * 6
        -- Outer skirt (see loops below): N/S strips 55x22 cells, E/W 23x11.
        -- Minus the one cell cut for the runway, plus its 4 surround quads.
        local skirtVerts = (53 * 25 * 2 + 25 * 2 * 2 - 1) * 6 + 24
        -- Fitted lakebed pad under the runway (see pad loop below).
        local padVerts = PAD_VERTS
        -- ruins(10) + pumpkins(N body+stem+2 eyes+mouth) + graves(8 slab+crossbar)
        -- + trees(6 trunk+2 branches) + huts(2 x 7 boxes) + rocks(10) + moon(1) + bats(5)
        local halloweenBoxes = #PUMPKINS * 5 + #GRAVES * 2 + #DEAD_TREES * 3 + #HUTS * 7 + #ROCKS + 1 + #BATS
        -- mid ring: 6 ruins + 20 pumpkins x5 + 6 trees x3 + 6 graves x2
        local midBoxes = 6 + 20 * 5 + 6 * 3 + 6 * 2
        -- outer zones: 12 mesas x3 + 3 ribcages x13 + 3 skulls x6 + 8 tar x3 + 10 spires x3
        local outerBoxes = 12 * 3 + 3 * 13 + 3 * 6 + 8 * 3 + 10 * 3
        -- corridor pyramids + dune mounds (pushPyr, 18 verts each):
        -- dunes + tall pyramids + dark obelisks, corner to corner.
        local pyrVerts = (220 + 40) * 18 + 25 * 18 -- dunes + pyramids + 25 L3 dune mountains (obelisks removed for them)
        -- runway: 12 slabs + 10 dashes + 28 edge (14 posts + 14 heads) + 2 threshold + 8 PAPI (4 posts + 4 heads)
        local runwayBoxes = 12 + 10 + 28 + 2 + 8
        local skyBoxes = N_STARS -- twinkling stars (moon is the photo overlay)
        local boxVerts = #RUINS * 36 + halloweenBoxes * 36 + midBoxes * 36 + outerBoxes * 36 + runwayBoxes * 36 + skyBoxes * 36
        local totalVerts = groundVerts + skirtVerts + padVerts + boxVerts + pyrVerts
        self.vertCount = totalVerts
        local totalFloats = totalVerts * 6
        local bytes = buffer.create(totalFloats * 4)
        local o = 0
        local function push(x: number, y: number, z: number, r: number, g: number, b: number)
            buffer.writef32(bytes, o, x); o += 4
            buffer.writef32(bytes, o, y); o += 4
            buffer.writef32(bytes, o, z); o += 4
            buffer.writef32(bytes, o, r); o += 4
            buffer.writef32(bytes, o, g); o += 4
            buffer.writef32(bytes, o, b); o += 4
        end
        local function pushBox(x0: number, x1: number, y0: number, y1: number, z0: number, z1: number,
            sr: number, sg: number, sb: number, tr: number, tg: number, tb: number)
            -- top
            push(x0, y1, z0, tr, tg, tb); push(x1, y1, z0, tr, tg, tb); push(x0, y1, z1, tr, tg, tb)
            push(x1, y1, z0, tr, tg, tb); push(x1, y1, z1, tr, tg, tb); push(x0, y1, z1, tr, tg, tb)
            -- front (z1)
            push(x0, y0, z1, sr, sg, sb); push(x1, y0, z1, sr, sg, sb); push(x0, y1, z1, tr, tg, tb)
            push(x1, y0, z1, sr, sg, sb); push(x1, y1, z1, tr, tg, tb); push(x0, y1, z1, tr, tg, tb)
            -- back (z0)
            push(x1, y0, z0, sr, sg, sb); push(x0, y0, z0, sr, sg, sb); push(x0, y1, z0, tr, tg, tb)
            push(x1, y0, z0, sr, sg, sb); push(x0, y1, z0, tr, tg, tb); push(x1, y1, z0, tr, tg, tb)
            -- left (x0)
            push(x0, y0, z0, sr, sg, sb); push(x0, y0, z1, sr, sg, sb); push(x0, y1, z1, tr, tg, tb)
            push(x0, y0, z0, sr, sg, sb); push(x0, y1, z1, tr, tg, tb); push(x0, y1, z0, tr, tg, tb)
            -- right (x1)
            push(x1, y0, z1, sr, sg, sb); push(x1, y0, z0, sr, sg, sb); push(x1, y1, z0, tr, tg, tb)
            push(x1, y0, z1, sr, sg, sb); push(x1, y1, z0, tr, tg, tb); push(x1, y1, z1, tr, tg, tb)
            -- bottom skirt
            push(x0, y0, z0, sr, sg, sb); push(x1, y0, z0, sr, sg, sb); push(x0, y0, z1, sr, sg, sb)
            push(x1, y0, z0, sr, sg, sb); push(x1, y0, z1, sr, sg, sb); push(x0, y0, z1, sr, sg, sb)
        end
        -- Square pyramid (18 verts: 4 sides + base quad). Cull is off,
        -- so winding is free. Faces get sun/shade tints for form.
        local function pushPyr(cx: number, by: number, cz: number, hw: number, h: number,
            sr: number, sg: number, sb: number, tr: number, tg: number, tb: number)
            local ax, ay, az = cx, by + h, cz
            local x0, x1 = cx - hw, cx + hw
            local z0, z1 = cz - hw, cz + hw
            -- south face (sun side, light)
            push(x0, by, z1, tr, tg, tb); push(x1, by, z1, tr, tg, tb); push(ax, ay, az, tr, tg, tb)
            -- north face (shade side, dark)
            push(x1, by, z0, sr, sg, sb); push(x0, by, z0, sr, sg, sb); push(ax, ay, az, sr, sg, sb)
            -- east / west faces (mid)
            local mr, mg, mb = (sr + tr) / 2, (sg + tg) / 2, (sb + tb) / 2
            push(x1, by, z1, mr, mg, mb); push(x1, by, z0, mr, mg, mb); push(ax, ay, az, mr, mg, mb)
            push(x0, by, z0, mr, mg, mb); push(x0, by, z1, mr, mg, mb); push(ax, ay, az, mr, mg, mb)
            -- base quad (dark, mostly buried)
            push(x0, by, z0, sr, sg, sb); push(x1, by, z0, sr, sg, sb); push(x0, by, z1, sr, sg, sb)
            push(x1, by, z0, sr, sg, sb); push(x1, by, z1, sr, sg, sb); push(x0, by, z1, sr, sg, sb)
        end
        local step = LAND / GRID_N
        local half = LAND / 2.0
        for ix = 0, GRID_N - 1 do
            for iz = 0, GRID_N - 1 do
                local x0 = -half + ix * step
                local x1 = x0 + step
                local z0 = -half + iz * step
                local z1 = z0 + step
                local y00 = groundH(x0, z0)
                local y10 = groundH(x1, z0)
                local y01 = groundH(x0, z1)
                local y11 = groundH(x1, z1)
                local function sandC(x: number, z: number, y: number): (number, number, number)
                    local v = 0.5 + 0.5 * math.sin(x * 0.05 + z * 0.043)
                    local t = y * 0.05
                    return 0.76 + v * 0.06 + t, 0.60 + v * 0.04 + t * 0.8, 0.38 + v * 0.03
                end
                local r00, g00, b00 = sandC(x0, z0, y00)
                local r10, g10, b10 = sandC(x1, z0, y10)
                local r01, g01, b01 = sandC(x0, z1, y01)
                local r11, g11, b11 = sandC(x1, z1, y11)
                -- tri 1
                push(x0, y00, z0, r00, g00, b00)
                push(x1, y10, z0, r10, g10, b10)
                push(x0, y01, z1, r01, g01, b01)
                -- tri 2
                push(x1, y10, z0, r10, g10, b10)
                push(x1, y11, z1, r11, g11, b11)
                push(x0, y01, z1, r01, g01, b01)
            end
        end
        -- Outer skirt: coarse red-rock backdrop out to ~1200, tucked 0.25
        -- under the core edge so the seam never cracks or z-fights.
        local function skirtTint(x: number, z: number, y: number): (number, number, number)
            local v = 0.5 + 0.5 * math.sin(x * 0.05 + z * 0.043)
            local t = y * 0.05
            local r, g, b = 0.76 + v * 0.06 + t, 0.60 + v * 0.04 + t * 0.8, 0.38 + v * 0.03
            if x * x + z * z > 550 * 550 then
                r, g, b = 0.70 + v * 0.05, 0.44 + v * 0.03, 0.28 + v * 0.02
            end
            return r, g, b
        end
        local function skirtCell(x0: number, x1: number, z0: number, z1: number)
            local y00 = groundH(x0, z0) - 0.25
            local y10 = groundH(x1, z0) - 0.25
            local y01 = groundH(x0, z1) - 0.25
            local y11 = groundH(x1, z1) - 0.25
            local r00, g00, b00 = skirtTint(x0, z0, y00)
            local r10, g10, b10 = skirtTint(x1, z0, y10)
            local r01, g01, b01 = skirtTint(x0, z1, y01)
            local r11, g11, b11 = skirtTint(x1, z1, y11)
            push(x0, y00, z0, r00, g00, b00)
            push(x1, y10, z0, r10, g10, b10)
            push(x0, y01, z1, r01, g01, b01)
            push(x1, y10, z0, r10, g10, b10)
            push(x1, y11, z1, r11, g11, b11)
            push(x0, y01, z1, r01, g01, b01)
        end
        -- Coarse red-rock backdrop out to the wrap edge, tucked under the
        -- core edge so the seam never cracks or z-fights.
        -- NOTE: keep skirtVerts in sync with these loop bounds.
        local SK = 21000.0
        for ix = 0, 52 do
            local x0 = -556500 + ix * SK
            for iz = 0, 24 do
                skirtCell(x0, x0 + SK, 1160 + iz * SK, 1160 + (iz + 1) * SK)
                -- The strip cell is cut out (a 21km quad can't resolve a
                -- 120u strip: its dune corners float it over the slabs).
                -- Surround quads + fitted pad below replace it exactly.
                if not (ix == HOLE_IX and iz == HOLE_IZ) then
                    skirtCell(x0, x0 + SK, -1160 - (iz + 1) * SK, -1160 - iz * SK)
                end
            end
        end
        -- Runway surround: the cut cell's 4 neighbors around the pad hole,
        -- coarse like the rest of the sheet (the pad owns the detail).
        do
            local gx0, gx1 = -556500 + HOLE_IX * SK, -556500 + (HOLE_IX + 1) * SK
            local gz0, gz1 = -1160 - (HOLE_IZ + 1) * SK, -1160 - HOLE_IZ * SK
            skirtCell(gx0, HOLE_X0, gz0, gz1) -- west
            skirtCell(HOLE_X1, gx1, gz0, gz1) -- east
            skirtCell(HOLE_X0, HOLE_X1, gz0, HOLE_Z0) -- south
            skirtCell(HOLE_X0, HOLE_X1, HOLE_Z1, gz1) -- north
        end
        for ix = 0, 24 do
            for iz = 0, 1 do
                local z0 = -1160 + iz * 1160
                skirtCell(-1160 - (ix + 1) * SK, -1160 - ix * SK, z0, z0 + 1160)
                skirtCell(1160 + ix * SK, 1160 + (ix + 1) * SK, z0, z0 + 1160)
            end
        end
        -- Fitted lakebed pad: 100u cells sampling the true ground over
        -- the buried skirt hole, so the strip sits exact. Same winding
        -- + tints as the skirt, seamless with the intact sheet around it.
        -- NOTE: keep PAD_VERTS in sync with these loop bounds.
        for ix = 0, PAD_NX - 1 do
            local px0 = PAD_X0 + ix * PAD_STEP
            for iz = 0, PAD_NZ - 1 do
                local pz0 = PAD_Z0 + iz * PAD_STEP
                local px1, pz1 = px0 + PAD_STEP, pz0 + PAD_STEP
                local q00 = groundH(px0, pz0)
                local q10 = groundH(px1, pz0)
                local q01 = groundH(px0, pz1)
                local q11 = groundH(px1, pz1)
                local t00r, t00g, t00b = skirtTint(px0, pz0, q00)
                local t10r, t10g, t10b = skirtTint(px1, pz0, q10)
                local t01r, t01g, t01b = skirtTint(px0, pz1, q01)
                local t11r, t11g, t11b = skirtTint(px1, pz1, q11)
                push(px0, q00, pz0, t00r, t00g, t00b)
                push(px1, q10, pz0, t10r, t10g, t10b)
                push(px0, q01, pz1, t01r, t01g, t01b)
                push(px1, q10, pz0, t10r, t10g, t10b)
                push(px1, q11, pz1, t11r, t11g, t11b)
                push(px0, q01, pz1, t01r, t01g, t01b)
            end
        end
        -- Ruin boxes (mud color, sunk into dunes). Spread x2 across the big land.
        for _, r in ipairs(RUINS) do
            local bx = r.x * 2.0
            local bz = r.z * 2.0
            local base = groundH(bx, bz) - 0.6
            local top = base + r.h
            local hx = r.w / 2.0
            local hz = r.d / 2.0
            pushBox(bx - hx, bx + hx, base, top, bz - hz, bz + hz,
                0.45, 0.31, 0.19, 0.55, 0.40, 0.25)
        end
        -- Halloween: jack-o-lanterns. Bases sunk 0.45 so they sit IN the dunes.
        for _, p in ipairs(PUMPKINS) do
            local gy = groundH(p.x, p.z) - 0.45
            local s = p.s
            local bw = 0.7 * s
            local bh = 0.9 * s
            pushBox(p.x - bw, p.x + bw, gy, gy + bh, p.z - bw, p.z + bw,
                0.90, 0.42, 0.08, 0.95, 0.50, 0.10)
            -- stem
            local sw = 0.12 * s
            pushBox(p.x - sw, p.x + sw, gy + bh, gy + bh + 0.45 * s, p.z - sw, p.z + sw,
                0.20, 0.28, 0.10, 0.28, 0.38, 0.12)
            -- glowing jack-o-lantern face: two eyes + grinning mouth, candle-yellow.
            local ew = 0.16 * s
            local ey0, ey1 = gy + 0.58 * s, gy + 0.76 * s
            pushBox(p.x - 0.42 * s - ew, p.x - 0.42 * s + ew, ey0, ey1,
                p.z + bw, p.z + bw + 0.12,
                1.0, 0.85, 0.25, 1.0, 0.85, 0.25)
            pushBox(p.x + 0.42 * s - ew, p.x + 0.42 * s + ew, ey0, ey1,
                p.z + bw, p.z + bw + 0.12,
                1.0, 0.85, 0.25, 1.0, 0.85, 0.25)
            local mw = 0.42 * s
            pushBox(p.x - mw, p.x + mw, gy + 0.22 * s, gy + 0.40 * s,
                p.z + bw, p.z + bw + 0.12,
                1.0, 0.85, 0.25, 1.0, 0.85, 0.25)
        end
        -- Halloween: graveyard slabs + crossbars, sunk 0.5.
        for _, g in ipairs(GRAVES) do
            local gy = groundH(g.x, g.z) - 0.5
            pushBox(g.x - 0.6, g.x + 0.6, gy, gy + 1.8, g.z - 0.2, g.z + 0.2,
                0.45, 0.45, 0.50, 0.60, 0.60, 0.65)
            pushBox(g.x - 0.9, g.x + 0.9, gy + 0.9, gy + 1.3, g.z - 0.2, g.z + 0.2,
                0.40, 0.40, 0.46, 0.55, 0.55, 0.60)
        end
        -- Halloween: dead trees, trunks sunk 0.4.
        for _, t in ipairs(DEAD_TREES) do
            local gy = groundH(t.x, t.z) - 0.4
            pushBox(t.x - 0.4, t.x + 0.4, gy, gy + 4.5, t.z - 0.4, t.z + 0.4,
                0.20, 0.12, 0.08, 0.28, 0.17, 0.11)
            pushBox(t.x - 1.6, t.x + 1.6, gy + 2.8, gy + 3.2, t.z - 0.2, t.z + 0.2,
                0.18, 0.11, 0.07, 0.25, 0.15, 0.10)
            pushBox(t.x - 0.2, t.x + 0.2, gy + 3.4, gy + 3.8, t.z - 1.3, t.z + 1.3,
                0.18, 0.11, 0.07, 0.25, 0.15, 0.10)
        end
        -- Halloween: broken huts. Walls sunk 0.5; each hut is missing its
        -- front-right wall stub top, half its roof, and has a door gap.
        for _, h in ipairs(HUTS) do
            local gy = groundH(h.x, h.z) - 0.5
            local hw = 3.0 * h.s
            local hd = 2.5 * h.s
            local hh = 3.2 * h.s
            local wt = 0.5 * h.s
            local mr, mg, mb = 0.42, 0.29, 0.18
            local tr, tg, tb = 0.52, 0.37, 0.22
            local wr, wg, wb = 0.25, 0.15, 0.09
            -- back wall (full)
            pushBox(h.x - hw, h.x + hw, gy, gy + hh, h.z - hd, h.z - hd + wt, mr, mg, mb, tr, tg, tb)
            -- left wall (full)
            pushBox(h.x - hw, h.x - hw + wt, gy, gy + hh, h.z - hd, h.z + hd, mr, mg, mb, tr, tg, tb)
            -- right wall (broken: half height rubble)
            pushBox(h.x + hw - wt, h.x + hw, gy, gy + hh * 0.45, h.z - hd, h.z + hd, mr, mg, mb, tr, tg, tb)
            -- front-left stub + front-right stub with door gap in the middle
            pushBox(h.x - hw, h.x - hw + 1.6 * h.s, gy, gy + hh, h.z + hd - wt, h.z + hd, mr, mg, mb, tr, tg, tb)
            pushBox(h.x + hw - 1.2 * h.s, h.x + hw, gy, gy + hh * 0.6, h.z + hd - wt, h.z + hd, mr, mg, mb, tr, tg, tb)
            -- roof: back half only, front half caved in (missing)
            pushBox(h.x - hw, h.x + hw, gy + hh, gy + hh + wt, h.z - hd, h.z, 0.35, 0.24, 0.14, tr, tg, tb)
            -- fallen wood beam leaning across the door gap
            pushBox(h.x - 1.4 * h.s, h.x + 1.4 * h.s, gy + 0.3, gy + 0.7, h.z + hd - 0.6, h.z + hd - 0.2, wr, wg, wb, 0.32, 0.20, 0.12)
        end
        -- Scattered rocks, sunk 0.3.
        for _, r in ipairs(ROCKS) do
            local gy = groundH(r.x, r.z) - 0.3
            local rw = 0.8 * r.s
            local rh = 0.6 * r.s
            pushBox(r.x - rw, r.x + rw, gy, gy + rh, r.z - rw * 0.8, r.z + rw * 0.8,
                0.38, 0.35, 0.33, 0.48, 0.45, 0.42)
        end
        -- Night sky: countless stars on a giant celestial dome (R 45000)
        -- so the sky reads round, not flat. Fixed size = pinpricks at range.
        for i = 1, N_STARS do
            local a = rnd(i, 1) * math.pi * 2.0
            local e = 0.06 + rnd(i, 2) * 0.94 -- sin(elevation): horizon to zenith
            local ce = math.sqrt(math.max(0, 1 - e * e))
            local R = 45000.0
            local sx = math.cos(a) * ce * R
            local sz = math.sin(a) * ce * R
            local sy = e * R
            local ss = 30.0 + rnd(i, 4) * 20.0
            local t = rnd(i, 5)
            local sr, sg, sb = 1.0, 1.0, 1.0
            if t < 0.33 then sr, sg, sb = 1.0, 0.95, 0.90
            elseif t < 0.66 then sr, sg, sb = 0.90, 0.95, 1.0 end
            pushBox(sx - ss, sx + ss, sy - ss, sy + ss, sz - ss, sz + ss, sr, sg, sb, sr, sg, sb)
        end
        -- Night sky: twinkling stars ringing the horizon.
        -- Halloween: bat silhouettes high up (near-black boxes).
        for _, b in ipairs(BATS) do
            pushBox(b.x - 0.9, b.x + 0.9, b.y - 0.15, b.y + 0.15, b.z - 0.3, b.z + 0.3,
                0.05, 0.03, 0.08, 0.08, 0.05, 0.12)
        end
        -- Mid ring (exact core mesh): more ruins, pumpkin clusters, trees, graves.
        for i = 1, 6 do
            local a = rnd(i, 111) * math.pi * 2.0
            local rr = 500 + rnd(i, 112) * 1500.0
            local bx, bz = math.cos(a) * rr, math.sin(a) * rr
            local base = groundH(bx, bz) - 0.6
            pushBox(bx - 4, bx + 4, base, base + 3.5, bz - 3, bz + 3,
                0.45, 0.31, 0.19, 0.55, 0.40, 0.25)
        end
        for i = 1, 20 do
            local a = rnd(i, 113) * math.pi * 2.0
            local rr = 500 + rnd(i, 114) * 1500.0
            local px, pz = math.cos(a) * rr, math.sin(a) * rr
            local gy = groundH(px, pz) - 0.45
            local s = 0.9 + rnd(i, 115) * 0.7
            local bw = 0.7 * s
            pushBox(px - bw, px + bw, gy, gy + 0.9 * s, pz - bw, pz + bw,
                0.90, 0.42, 0.08, 0.95, 0.50, 0.10)
            pushBox(px - 0.12 * s, px + 0.12 * s, gy + 0.9 * s, gy + 0.9 * s + 0.45 * s,
                pz - 0.12 * s, pz + 0.12 * s, 0.20, 0.28, 0.10, 0.28, 0.38, 0.12)
            local ew = 0.16 * s
            pushBox(px - 0.42 * s - ew, px - 0.42 * s + ew, gy + 0.58 * s, gy + 0.76 * s,
                pz + bw, pz + bw + 0.12, 1.0, 0.85, 0.25, 1.0, 0.85, 0.25)
            pushBox(px + 0.42 * s - ew, px + 0.42 * s + ew, gy + 0.58 * s, gy + 0.76 * s,
                pz + bw, pz + bw + 0.12, 1.0, 0.85, 0.25, 1.0, 0.85, 0.25)
            pushBox(px - 0.42 * s, px + 0.42 * s, gy + 0.22 * s, gy + 0.40 * s,
                pz + bw, pz + bw + 0.12, 1.0, 0.85, 0.25, 1.0, 0.85, 0.25)
        end
        for i = 1, 6 do
            local a = rnd(i, 116) * math.pi * 2.0
            local rr = 500 + rnd(i, 117) * 1500.0
            local tx2, tz2 = math.cos(a) * rr, math.sin(a) * rr
            local gy = groundH(tx2, tz2) - 0.4
            pushBox(tx2 - 0.4, tx2 + 0.4, gy, gy + 4.5, tz2 - 0.4, tz2 + 0.4,
                0.20, 0.12, 0.08, 0.28, 0.17, 0.11)
            pushBox(tx2 - 1.6, tx2 + 1.6, gy + 2.8, gy + 3.2, tz2 - 0.2, tz2 + 0.2,
                0.18, 0.11, 0.07, 0.25, 0.15, 0.10)
            pushBox(tx2 - 0.2, tx2 + 0.2, gy + 3.4, gy + 3.8, tz2 - 1.3, tz2 + 1.3,
                0.18, 0.11, 0.07, 0.25, 0.15, 0.10)
        end
        for i = 1, 6 do
            local a = rnd(i, 118) * math.pi * 2.0
            local rr = 600 + rnd(i, 119) * 1400.0
            local gx, gz = math.cos(a) * rr, math.sin(a) * rr
            local gy = groundH(gx, gz) - 0.5
            pushBox(gx - 0.6, gx + 0.6, gy, gy + 1.8, gz - 0.2, gz + 0.2,
                0.45, 0.45, 0.50, 0.60, 0.60, 0.65)
            pushBox(gx - 0.9, gx + 0.9, gy + 0.9, gy + 1.3, gz - 0.2, gz + 0.2,
                0.40, 0.40, 0.46, 0.55, 0.55, 0.60)
        end
        -- Outer zones on the skirt (skirtY tucks with the skirt, deep sinks).
        -- Mesa field: layered red-rock buttes.
        for i = 1, 12 do
            local a = rnd(i, 121) * math.pi * 2.0
            local rr = 4000 + rnd(i, 122) * 20000.0
            local mx, mz = math.cos(a) * rr, math.sin(a) * rr
            local sy = groundH(mx, mz) - 0.25
            local w = 60 + rnd(i, 123) * 80.0
            local h = 30 + rnd(i, 124) * 24.0
            pushBox(mx - w, mx + w, sy - 4, sy + h, mz - w * 0.8, mz + w * 0.8,
                0.48, 0.27, 0.16, 0.58, 0.34, 0.20)
            pushBox(mx - w * 0.65, mx + w * 0.65, sy + h, sy + h * 1.6, mz - w * 0.5, mz + w * 0.5,
                0.52, 0.30, 0.18, 0.62, 0.38, 0.24)
            pushBox(mx - w * 0.4, mx + w * 0.4, sy + h * 1.6, sy + h * 2.0, mz - w * 0.3, mz + w * 0.3,
                0.55, 0.33, 0.20, 0.66, 0.42, 0.26)
        end
        -- Bone ribcages: spine beam + 6 rib pairs each.
        for i = 1, 3 do
            local a = rnd(i, 125) * math.pi * 2.0
            local rr = 5000 + rnd(i, 126) * 19000.0
            local mx, mz = math.cos(a) * rr, math.sin(a) * rr
            local sy = groundH(mx, mz) - 0.25
            pushBox(mx - 28, mx + 28, sy + 20, sy + 24, mz - 2, mz + 2,
                0.80, 0.75, 0.65, 0.90, 0.86, 0.76)
            for k = 1, 6 do
                local rx = mx - 28 + k * 9.6
                pushBox(rx - 1.6, rx + 1.6, sy - 10, sy + 20, mz - 13.6, mz - 10.4,
                    0.80, 0.75, 0.65, 0.88, 0.83, 0.72)
                pushBox(rx - 1.6, rx + 1.6, sy - 10, sy + 20, mz + 10.4, mz + 13.6,
                    0.80, 0.75, 0.65, 0.88, 0.83, 0.72)
            end
        end
        -- Giant skulls with glowing-face eye sockets.
        for i = 1, 3 do
            local a = rnd(i, 127) * math.pi * 2.0
            local rr = 6000 + rnd(i, 128) * 18000.0
            local mx, mz = math.cos(a) * rr, math.sin(a) * rr
            local sy = groundH(mx, mz) - 0.25
            pushBox(mx - 14, mx + 14, sy - 6, sy + 14, mz - 16, mz + 16,
                0.78, 0.72, 0.60, 0.88, 0.82, 0.70)
            pushBox(mx - 8, mx + 8, sy - 6, sy + 6, mz + 16, mz + 32,
                0.75, 0.69, 0.57, 0.85, 0.79, 0.67)
            pushBox(mx - 8.8, mx - 4.0, sy + 4.0, sy + 8.8, mz + 15.6, mz + 16.4,
                1.0, 0.85, 0.25, 1.0, 0.85, 0.25)
            pushBox(mx + 4.0, mx + 8.8, sy + 4.0, sy + 8.8, mz + 15.6, mz + 16.4,
                1.0, 0.85, 0.25, 1.0, 0.85, 0.25)
            pushBox(mx - 8, mx + 8, sy - 6, sy - 2.8, mz + 16, mz + 32,
                0.85, 0.79, 0.66, 0.90, 0.84, 0.72)
            pushBox(mx - 1.6, mx + 1.6, sy + 0.8, sy + 4.0, mz + 15.6, mz + 16.4,
                0.05, 0.03, 0.05, 0.08, 0.05, 0.08)
        end
        -- Tar flats: black glass slabs with purple glow vents.
        for i = 1, 8 do
            local a = rnd(i, 129) * math.pi * 2.0
            local rr = 4000 + rnd(i, 130) * 20000.0
            local mx, mz = math.cos(a) * rr, math.sin(a) * rr
            local sy = groundH(mx, mz) - 0.25
            pushBox(mx - 24, mx + 24, sy - 4.4, sy + 1.6, mz - 20, mz + 20,
                0.05, 0.04, 0.06, 0.09, 0.08, 0.11)
            pushBox(mx - 12, mx - 4, sy + 1.6, sy + 4.0, mz - 4, mz + 4,
                0.60, 0.20, 0.80, 0.60, 0.20, 0.80)
            pushBox(mx + 4, mx + 12, sy + 1.6, sy + 4.0, mz - 4, mz + 4,
                0.60, 0.20, 0.80, 0.60, 0.20, 0.80)
        end
        -- Obsidian spires with glowing cracks.
        for i = 1, 10 do
            local a = rnd(i, 131) * math.pi * 2.0
            local rr = 4500 + rnd(i, 132) * 19500.0
            local mx, mz = math.cos(a) * rr, math.sin(a) * rr
            local sy = groundH(mx, mz) - 0.25
            pushBox(mx - 4, mx + 4, sy - 10, sy + 44, mz - 4, mz + 4,
                0.08, 0.07, 0.10, 0.12, 0.11, 0.15)
            pushBox(mx - 1.2, mx + 1.2, sy + 8, sy + 28, mz + 4.0, mz + 5.0,
                0.95, 0.50, 0.10, 0.95, 0.50, 0.10)
            pushBox(mx + 4.0, mx + 5.0, sy + 16, sy + 36, mz - 1.2, mz + 1.2,
                0.95, 0.50, 0.10, 0.95, 0.50, 0.10)
        end
        -- Corridor dunes + pyramids + obelisks: structures corner to
        -- corner across the whole large map. Excluded spots get buried
        -- 6000u deep (still 18 verts — the count stays exact).
        local function buryPyr(px: number, pz: number): boolean
            if math.abs(px) < 600 and pz > -16500 and pz < -13500 then return true end -- runway
            if math.abs(pz + 8000) < 2600 and math.abs(px) < 9000 then return true end -- storm wall
            if px * px + pz * pz < 3000 * 3000 then return true end -- fight arena
            return false
        end
        -- 220 dune mounds: low wide sandstone swells, near and far.
        for i = 1, 220 do
            local px = rnd(i, 141) * 160000.0 - 80000.0
            local pz = rnd(i, 142) * 180000.0 - 100000.0
            local gy = groundH(px, pz) - 1.0
            if buryPyr(px, pz) then gy -= 6000.0 end
            local hw = 150.0 + rnd(i, 143) * 350.0
            local hh = 40.0 + rnd(i, 144) * 90.0
            local v = rnd(i, 145) * 0.08
            pushPyr(px, gy, pz, hw, hh,
                0.62 + v, 0.48 + v, 0.30 + v * 0.6,
                0.78 + v, 0.62 + v, 0.40 + v * 0.6)
        end
        -- 40 pyramids: tall landmarks everywhere, off the center lanes
        -- so they never sit in a gate block.
        for i = 1, 40 do
            local px = rnd(i, 151) * 160000.0 - 80000.0
            if math.abs(px) < 1200 then
                if px >= 0 then px += 2400.0 else px -= 2400.0 end
            end
            local pz = rnd(i, 152) * 180000.0 - 100000.0
            local gy = groundH(px, pz) - 4.0
            if buryPyr(px, pz) then gy -= 6000.0 end
            local hw = 200.0 + rnd(i, 153) * 250.0
            if i % 10 == 0 then hw = 600.0 + rnd(i, 153) * 300.0 end -- a few giants
            local hh = hw * (0.9 + rnd(i, 154) * 0.5)
            pushPyr(px, gy, pz, hw, hh,
                0.50, 0.38, 0.24, 0.68, 0.53, 0.33)
        end
        -- Runway: 120-long graded strip on the flattened pad (RWY_H),
        -- southwest corner of the map. 12 slabs, dashes, edge lights.
        local segLen = (RWY_Z1 - RWY_Z0) / 12
        for i = 0, 11 do
            local z0 = RWY_Z0 + i * segLen
            local z1 = z0 + segLen
            pushBox(RWY_X0, RWY_X1, RWY_H - 0.05, RWY_H + 0.12, z0, z1,
                0.12, 0.11, 0.14, 0.20, 0.19, 0.22)
        end
        -- 10 centerline studs (warm-white lamp band, chase in WGSL).
        local rwyLen = RWY_Z1 - RWY_Z0
        for i = 0, 9 do
            local zc = RWY_Z0 + (i + 0.5) * rwyLen / 10
            pushBox(RWY_CX - 0.25, RWY_CX + 0.25, RWY_H + 0.12, RWY_H + 0.20, zc - 1.0, zc + 1.0,
                1.0, 0.88, 0.55, 1.0, 0.92, 0.62)
        end
        -- 14 edge lights: dark posts + warm-white lamp heads (own WGSL band).
        for i = 0, 6 do
            local zc = RWY_Z0 + i * rwyLen / 6
            pushBox(RWY_X0 - 0.7, RWY_X0 - 0.3, RWY_H, RWY_H + 0.45, zc - 0.2, zc + 0.2,
                0.10, 0.10, 0.12, 0.16, 0.16, 0.18)
            pushBox(RWY_X1 + 0.3, RWY_X1 + 0.7, RWY_H, RWY_H + 0.45, zc - 0.2, zc + 0.2,
                0.10, 0.10, 0.12, 0.16, 0.16, 0.18)
            pushBox(RWY_X0 - 0.67, RWY_X0 - 0.33, RWY_H + 0.45, RWY_H + 0.70, zc - 0.17, zc + 0.17,
                1.0, 0.88, 0.55, 1.0, 0.92, 0.62)
            pushBox(RWY_X1 + 0.33, RWY_X1 + 0.67, RWY_H + 0.45, RWY_H + 0.70, zc - 0.17, zc + 0.17,
                1.0, 0.88, 0.55, 1.0, 0.92, 0.62)
        end
        -- 2 green threshold bars at the south end (steady in WGSL).
        pushBox(RWY_X0 + 0.5, RWY_CX - 1.0, RWY_H + 0.12, RWY_H + 0.20, RWY_Z0 + 0.5, RWY_Z0 + 1.5,
            0.20, 0.90, 0.40, 0.25, 1.0, 0.45)
        pushBox(RWY_CX + 1.0, RWY_X1 - 0.5, RWY_H + 0.12, RWY_H + 0.20, RWY_Z0 + 0.5, RWY_Z0 + 1.5,
            0.20, 0.90, 0.40, 0.25, 1.0, 0.45)
        -- 4 PAPI approach lights west of the threshold: 2 white + 2 red.
        for k = 0, 3 do
            local px0 = RWY_X0 - 3.5 - k * 1.4
            pushBox(px0, px0 + 0.5, RWY_H, RWY_H + 0.5, RWY_Z0 + 7.8, RWY_Z0 + 8.2,
                0.10, 0.10, 0.12, 0.16, 0.16, 0.18)
            local sr, sg, sb, tr, tg, tb = 1.0, 0.95, 0.85, 1.0, 0.97, 0.88
            if k < 2 then sr, sg, sb, tr, tg, tb = 1.0, 0.15, 0.10, 1.0, 0.18, 0.12 end
            pushBox(px0 + 0.05, px0 + 0.45, RWY_H + 0.5, RWY_H + 0.80, RWY_Z0 + 7.85, RWY_Z0 + 8.15,
                sr, sg, sb, tr, tg, tb)
        end
        -- L3 dune mountains: 25 broad curvy swells over the horde's
        -- desert flanks, grid-placed clear of bore, arena and tanks.
        for i = 1, 25 do
            local col = (i - 1) % 5
            local row = math.floor((i - 1) / 5)
            local px = ((row % 2 == 0) and 1.0 or -1.0) * (14000.0 + col * 5500.0)
            local pz = 5000.0 + row * 5000.0
            local gy = groundH(px, pz) - 1.0
            local hw = 600.0 + rnd(i, 173) * 900.0
            local hh = 80.0 + rnd(i, 174) * 140.0
            pushPyr(px, gy, pz, hw, hh, 0.66, 0.52, 0.33, 0.82, 0.66, 0.43)
        end

        self.sampler = ImageSampler("clamp", "clamp", "bilinear")
        self.canvas = context:gpuCanvas({ width = 800, height = 500 })
            local dt = GPUTexture.new({ width = 800, height = 500, format = "depth24plus-stencil8", renderTarget = true });
            self.depthTex = dt;
            self.depthView = dt:view();
        local shader = context:shader("shaders/desert")
        if shader == nil or self.canvas == nil then return end
        local canvas = self.canvas :: GPUCanvas
        self.pipeline = GPUPipeline.new({
            vertex = shader,
            fragment = shader,
            vertexLayout = {
                {
                    stride = 24,
                    attributes = {
                        { format = "float32x3", slot = 0, offset = 0 },
                        { format = "float32x3", slot = 1, offset = 12 },
                    },
                },
            },
            colorTargets = { { format = canvas.format } },
            depthStencil = { format = "depth24plus-stencil8", compare = "less", write = true },
            cullMode = "none",
        })
        local pipe = self.pipeline :: GPUPipeline
        self.vbo = GPUBuffer.new({ size = totalFloats * 4, usage = "vertex", data = bytes, immutable = true })
        self.heroCpu = buffer.create(HERO_VERTS * 12 * 4)
        self.heroVbo = GPUBuffer.new({ size = HERO_VERTS * 12 * 4, usage = "vertex" })
        self.beamCpu = buffer.create((BEAM_VERTS + ORB_SLOTS * BEAM_EACH) * 6 * 4)
        self.beamVbo = GPUBuffer.new({ size = (BEAM_VERTS + ORB_SLOTS * BEAM_EACH) * 6 * 4, usage = "vertex" })
        self.foeCpu = buffer.create(FOE_VERTS * 7 * 4)
        self.foeVbo = GPUBuffer.new({ size = FOE_VERTS * 7 * 4, usage = "vertex" })
        self.gateCpu = buffer.create((GATE_VERTS + DOT_VERTS) * 7 * 4)
        self.gateVbo = GPUBuffer.new({ size = (GATE_VERTS + DOT_VERTS) * 7 * 4, usage = "vertex" })
        -- Level-3 zombie horde: one tall design baked 2000 times at fixed
        -- coords past the storm (20 blocks x 100, packed tight). Drawn only
        -- on its own WGSL zombie pipeline. Rotting-green flesh, dark rags,
        -- burning eyes — the shader does the horror, the mesh is cloned.
        local armyBytes = buffer.create(ARMY_VERTS * 7 * 4)
        do
            local ao = 0
            for i = 1, N_ARMY do
                local sx, gy, sz = zombieBase(i)
                -- per-clone rot variation: same design, sickly different
                local j1 = math.sin(i * 12.9898) * 43758.5453
                j1 -= math.floor(j1)
                -- face the heart: yaw turns the -z face (eyes/maw/gun) onto
                -- the formation center; boxes stay axis-aligned, layout
                -- turns (GIGA precedent: no shear, reads fine at scale)
                local hdx, hdz = L3_ARMY_X - sx, (L3_ARMY_Z + 20000.0) - sz
                local hyw = math.atan2(-hdx, -hdz)
                local cs, sn = math.cos(hyw), math.sin(hyw)
                -- tall horde: ~325 high, ~160 wide, proper body
                -- boots + hands, dark-purple head, glowing red eyes, ember maw.
                -- Wide stance, wings swept back: the flanks trail behind.
                ao = buildBox6(armyBytes, ao, sx - 55.0 * cs, gy + 55.0, sz + 55.0 * sn, 25.0, 55.0, 25.0, 0.95, 0.70, 0.18, j1)
                ao = buildBox6(armyBytes, ao, sx + 55.0 * cs, gy + 55.0, sz - 55.0 * sn, 25.0, 55.0, 25.0, 0.95, 0.70, 0.18, j1)
                ao = buildBox6(armyBytes, ao, sx, gy + 175.0, sz, 60.0, 65.0, 45.0, 0.25, 0.50, 0.15, j1)
                ao = buildBox6(armyBytes, ao, sx, gy + 280.0, sz, 40.0, 45.0, 40.0, 0.25, 0.50, 0.15, j1)
                ao = buildBox6(armyBytes, ao, sx - 60.0 * cs - 50.0 * sn, gy + 195.0, sz + 60.0 * sn - 50.0 * cs, 20.0, 20.0, 50.0, 0.95, 0.70, 0.18, j1)
                ao = buildBox6(armyBytes, ao, sx + 60.0 * cs - 50.0 * sn, gy + 195.0, sz - 60.0 * sn - 50.0 * cs, 20.0, 20.0, 50.0, 0.95, 0.70, 0.18, j1)
                -- gun in the right hand + hot muzzle tip (flash band in WGSL)
                ao = buildBox6(armyBytes, ao, sx + 10.0 * cs - 120.0 * sn, gy + 195.0, sz - 10.0 * sn - 120.0 * cs, 9.0, 9.0, 45.0, 0.15, 0.14, 0.13, j1)
                ao = buildBox6(armyBytes, ao, sx + 10.0 * cs - 170.0 * sn, gy + 195.0, sz - 10.0 * sn - 170.0 * cs, 6.0, 6.0, 6.0, 1.0, 0.5, 0.1, j1)
                ao = buildBox6(armyBytes, ao, sx - 24.0 * cs - 55.0 * sn, gy + 285.0, sz + 24.0 * sn - 55.0 * cs, 11.0, 11.0, 11.0, 0.95, 0.07, 0.03, j1)
                ao = buildBox6(armyBytes, ao, sx + 24.0 * cs - 55.0 * sn, gy + 285.0, sz - 24.0 * sn - 55.0 * cs, 11.0, 11.0, 11.0, 0.95, 0.07, 0.03, j1)
                ao = buildBox6(armyBytes, ao, sx - 40.0 * sn, gy + 255.0, sz - 40.0 * cs, 25.0, 9.0, 6.0, 0.38, 0.04, 0.03, j1)
            end
        end
        self.armyVbo = GPUBuffer.new({ size = ARMY_VERTS * 7 * 4, usage = "vertex" })
        ;(self.armyVbo :: GPUBuffer):write(armyBytes); -- dynamic: kills bury slices
        self.armyCpu = armyBytes -- kept: kills bury slices, batched rewrite
        self.giantCpu = buffer.create(140 * 36 * 7 * 4)
        self.giantVbo = GPUBuffer.new({ size = 140 * 36 * 7 * 4, usage = "vertex" })
        self.stormCpu = buffer.create(STORM_VERTS * 12 * 4)
        self.stormVbo = GPUBuffer.new({ size = STORM_VERTS * 12 * 4, usage = "vertex" })
        self.sandCpu = buffer.create(SAND_VERTS * 12 * 4)
        self.sandVbo = GPUBuffer.new({ size = SAND_VERTS * 12 * 4, usage = "vertex" })
        self.nukeCpu = buffer.create(NUKE_VERTS * 12 * 4)
        self.nukeVbo = GPUBuffer.new({ size = NUKE_VERTS * 12 * 4, usage = "vertex" })
        self.auroraCpu = buffer.create(AUR_VERTS * 7 * 4)
        self.auroraVbo = GPUBuffer.new({ size = AUR_VERTS * 7 * 4, usage = "vertex" })
        self.bossCpu = buffer.create(BOSS_VERTS * 7 * 4)
        self.bossVbo = GPUBuffer.new({ size = BOSS_VERTS * 7 * 4, usage = "vertex" })
        self.beams = {}
        for _ = 1, BEAM_SLOTS do
            table.insert(self.beams, { on = false, x = 0, y = 0, z = 0, vx = 0, vy = 0, vz = 0, life = 0, gun = 1, stretch = 1 })
        end
        self.beamIdx = 1
        self.beamCd = 0
        self.msls = {}
        for _ = 1, MSL_SLOTS do
            table.insert(self.msls, { on = false, x = 0, y = 0, z = 0, vx = 0, vy = 0, vz = 0, spd = 0, life = 0, tkind = 0, tidx = 0, trailT = 0 })
        end
        self.mslBooms = {}
        for _ = 1, MSL_BOOMS do
            table.insert(self.mslBooms, { on = false, x = 0, y = 0, z = 0, kind = 1, size = 0, seed = 0, birth = -99 })
        end
        ;(self :: any).mslIdx = 1
        ;(self :: any).mslBoomIdx = 1
        ;(self :: any).mslSide = 1 -- alternates the wing rails per shot
        self.mslCpu = buffer.create(MSL_VERTS * 12 * 4)
        self.mslVbo = GPUBuffer.new({ size = MSL_VERTS * 12 * 4, usage = "vertex" })
        ;(self :: any).gun = 1
        ;(self :: any).gunShowT = 0
        self.windCpu = buffer.create(WIND_VERTS * 6 * 4)
        self.windVbo = GPUBuffer.new({ size = WIND_VERTS * 6 * 4, usage = "vertex" })
        self.winds = {}
        for _ = 1, WIND_SLOTS do
            table.insert(self.winds, { on = false, x = 0, y = 0, z = 0, vx = 0, vy = 0, vz = 0, life = 0, gun = 1, stretch = 1 })
        end
        self.windIdx = 1
        self.windAcc = 0
        self.chunkCpu = buffer.create(CHUNK_VERTS * 12 * 4)
        self.chunkVbo = GPUBuffer.new({ size = CHUNK_VERTS * 12 * 4, usage = "vertex" })
        self.chunks = {}
        for _ = 1, CHUNK_SLOTS do
            table.insert(self.chunks, { on = false, x = 0, y = 0, z = 0, vx = 0, vy = 0, vz = 0, life = 0, life0 = 1, kind = 0, seed = 0 })
        end
        self.chunkIdx = 1
        self.uboCpu = buffer.create(96)
        self.ubo = GPUBuffer.new({ size = 96, usage = "uniform" })
        local layout = pipe:getBindGroupLayout(0)
        self.bindGroup = GPUBindGroup.new({
            layout = layout,
            ubos = { { slot = 0, buffer = self.ubo :: GPUBuffer } },
        })
        -- Dedicated lit jet pipeline: pos + normal + color + object-space.
        -- First 80 UBO bytes are shared with the world shader; the jet
        -- shader reads the camera eye position appended after them.
        local jetShader = context:shader("shaders/jet")
        if jetShader ~= nil then
            local jetPipe = GPUPipeline.new({
                vertex = jetShader,
                fragment = jetShader,
                vertexLayout = {
                    {
                        stride = 48,
                        attributes = {
                            { format = "float32x3", slot = 0, offset = 0 },
                            { format = "float32x3", slot = 1, offset = 12 },
                            { format = "float32x3", slot = 2, offset = 24 },
                            { format = "float32x3", slot = 3, offset = 36 },
                        },
                    },
                },
                colorTargets = { { format = canvas.format } },
                depthStencil = { format = "depth24plus-stencil8", compare = "less", write = true },
                cullMode = "none",
            })
            self.heroPipe = jetPipe
            local jetLayout = jetPipe:getBindGroupLayout(0)
            self.heroBind = GPUBindGroup.new({
                layout = jetLayout,
                ubos = { { slot = 0, buffer = self.ubo :: GPUBuffer } },
            })
        end
        -- Dedicated blast pipeline: pos + color + (heat, seed, kind) + local.
        -- Same 80-byte UBO prefix as the world shader, so the same uniform
        -- buffer feeds it; chunks switch to it for their draw, last in pass.
        local blastShader = context:shader("shaders/blast")
        if blastShader ~= nil then
            local blastPipe = GPUPipeline.new({
                vertex = blastShader,
                fragment = blastShader,
                vertexLayout = {
                    {
                        stride = 48,
                        attributes = {
                            { format = "float32x3", slot = 0, offset = 0 },
                            { format = "float32x3", slot = 1, offset = 12 },
                            { format = "float32x3", slot = 2, offset = 24 },
                            { format = "float32x3", slot = 3, offset = 36 },
                        },
                    },
                },
                colorTargets = { { format = canvas.format } },
                depthStencil = { format = "depth24plus-stencil8", compare = "less", write = true },
                cullMode = "none",
            })
            self.blastPipe = blastPipe
            local blastLayout = blastPipe:getBindGroupLayout(0)
            self.blastBind = GPUBindGroup.new({
                layout = blastLayout,
                ubos = { { slot = 0, buffer = self.ubo :: GPUBuffer } },
            })
        end
        -- Dedicated storm pipeline: same 12-float box verts as blast
        -- (pos + color + info + local). Same 80-byte UBO prefix, so the
        -- same uniform buffer feeds it; the storm draws on it, then hands
        -- back to the world pipeline.
        local stormShader = context:shader("shaders/storm")
        if stormShader ~= nil then
            local stormPipe = GPUPipeline.new({
                vertex = stormShader,
                fragment = stormShader,
                vertexLayout = {
                    {
                        stride = 48,
                        attributes = {
                            { format = "float32x3", slot = 0, offset = 0 },
                            { format = "float32x3", slot = 1, offset = 12 },
                            { format = "float32x3", slot = 2, offset = 24 },
                            { format = "float32x3", slot = 3, offset = 36 },
                        },
                    },
                },
                colorTargets = { { format = canvas.format } },
                depthStencil = { format = "depth24plus-stencil8", compare = "less", write = true },
                cullMode = "none",
            })
            self.stormPipe = stormPipe
            local stormLayout = stormPipe:getBindGroupLayout(0)
            self.stormBind = GPUBindGroup.new({
                layout = stormLayout,
                ubos = { { slot = 0, buffer = self.ubo :: GPUBuffer } },
            })
        end
        -- Dedicated sand pipeline: same 12-float box verts as storm, full
        -- 96-byte UBO (eye tail for distance softening). Blowing sheets +
        -- whiteout veil, drawn right after the storm, hands back to world.
        local sandShader = context:shader("shaders/sand")
        if sandShader ~= nil then
            local sandPipe = GPUPipeline.new({
                vertex = sandShader,
                fragment = sandShader,
                vertexLayout = {
                    {
                        stride = 48,
                        attributes = {
                            { format = "float32x3", slot = 0, offset = 0 },
                            { format = "float32x3", slot = 1, offset = 12 },
                            { format = "float32x3", slot = 2, offset = 24 },
                            { format = "float32x3", slot = 3, offset = 36 },
                        },
                    },
                },
                colorTargets = { { format = canvas.format } },
                depthStencil = { format = "depth24plus-stencil8", compare = "less", write = true },
                cullMode = "none",
            })
            self.sandPipe = sandPipe
            local sandLayout = sandPipe:getBindGroupLayout(0)
            self.sandBind = GPUBindGroup.new({
                layout = sandLayout,
                ubos = { { slot = 0, buffer = self.ubo :: GPUBuffer } },
            })
        end
        -- Dedicated nuke pipeline: 12-float billboard verts (pos + kind +
        -- birth + corner), full 96-byte UBO (eye tail aims the billboards).
        -- The GIGA atom bomb draws on it right after the chunks.
        local nukeShader = context:shader("shaders/nuke")
        if nukeShader ~= nil then
            local nukePipe = GPUPipeline.new({
                vertex = nukeShader,
                fragment = nukeShader,
                vertexLayout = {
                    {
                        stride = 48,
                        attributes = {
                            { format = "float32x3", slot = 0, offset = 0 },
                            { format = "float32x3", slot = 1, offset = 12 },
                            { format = "float32x3", slot = 2, offset = 24 },
                            { format = "float32x3", slot = 3, offset = 36 },
                        },
                    },
                },
                colorTargets = { { format = canvas.format } },
                depthStencil = { format = "depth24plus-stencil8", compare = "less", write = true },
                cullMode = "none",
            })
            self.nukePipe = nukePipe
            local nukeLayout = nukePipe:getBindGroupLayout(0)
            self.nukeBind = GPUBindGroup.new({
                layout = nukeLayout,
                ubos = { { slot = 0, buffer = self.ubo :: GPUBuffer } },
            })
        end
        -- Dedicated missile pipeline: 12-float verts (pos + kind/size/seed
        -- + birth/hx/hy + corner), full 96-byte UBO (eye tail aims the
        -- explosion billboards). Cruise bodies + fireballs + shock rings.
        local mslShader = context:shader("shaders/missile")
        if mslShader ~= nil then
            local mslPipe = GPUPipeline.new({
                vertex = mslShader,
                fragment = mslShader,
                vertexLayout = {
                    {
                        stride = 48,
                        attributes = {
                            { format = "float32x3", slot = 0, offset = 0 },
                            { format = "float32x3", slot = 1, offset = 12 },
                            { format = "float32x3", slot = 2, offset = 24 },
                            { format = "float32x3", slot = 3, offset = 36 },
                        },
                    },
                },
                colorTargets = { { format = canvas.format } },
                depthStencil = { format = "depth24plus-stencil8", compare = "less", write = true },
                cullMode = "none",
            })
            self.mslPipe = mslPipe
            local mslLayout = mslPipe:getBindGroupLayout(0)
            self.mslBind = GPUBindGroup.new({
                layout = mslLayout,
                ubos = { { slot = 0, buffer = self.ubo :: GPUBuffer } },
            })
        end
        -- Dedicated zombie pipeline: same 6-float verts as the world
        -- (pos + color). Same 80-byte UBO prefix; the horde draws on it,
        -- then hands back to the world pipeline.
        local zombieShader = context:shader("shaders/zombie")
        if zombieShader ~= nil then
            local zombiePipe = GPUPipeline.new({
                vertex = zombieShader,
                fragment = zombieShader,
                vertexLayout = {
                    {
                        stride = 28,
                        attributes = {
                            { format = "float32x3", slot = 0, offset = 0 },
                            { format = "float32x3", slot = 1, offset = 12 },
                            { format = "float32", slot = 2, offset = 24 },
                        },
                    },
                },
                colorTargets = { { format = canvas.format } },
                depthStencil = { format = "depth24plus-stencil8", compare = "less", write = true },
                cullMode = "none",
            })
            self.zombiePipe = zombiePipe
            local zombieLayout = zombiePipe:getBindGroupLayout(0)
            self.zuboCpu = buffer.create(40)
            buffer.writef32(self.zuboCpu :: buffer, 0, -1)
            buffer.writef32(self.zuboCpu :: buffer, 4, 500.0)
            buffer.writef32(self.zuboCpu :: buffer, 8, 400.0)
            buffer.writef32(self.zuboCpu :: buffer, 12, 0)
            buffer.writef32(self.zuboCpu :: buffer, 16, 0)
            buffer.writef32(self.zuboCpu :: buffer, 20, 0)
            buffer.writef32(self.zuboCpu :: buffer, 24, 0)
            buffer.writef32(self.zuboCpu :: buffer, 28, 0)
            buffer.writef32(self.zuboCpu :: buffer, 32, 0) -- doom: GIGA death 0->1
            buffer.writef32(self.zuboCpu :: buffer, 36, 0) -- pad
            self.zubo = GPUBuffer.new({ size = 40, usage = "uniform" })
            self.zombieBind = GPUBindGroup.new({
                layout = zombieLayout,
                ubos = {
                    { slot = 0, buffer = self.ubo :: GPUBuffer },
                    { slot = 1, buffer = self.zubo :: GPUBuffer },
                },
            })
        end
        -- Dedicated foe pipeline: pos + color + phase seed. Same 80-byte
        -- UBO prefix, so the same uniform buffer feeds it; foes switch to
        -- it for their draw, then hand back to the world pipeline.
        local foeShader = context:shader("shaders/foe")
        if foeShader ~= nil then
            local foePipe = GPUPipeline.new({
                vertex = foeShader,
                fragment = foeShader,
                vertexLayout = {
                    {
                        stride = 28,
                        attributes = {
                            { format = "float32x3", slot = 0, offset = 0 },
                            { format = "float32x3", slot = 1, offset = 12 },
                            { format = "float32", slot = 2, offset = 24 },
                        },
                    },
                },
                colorTargets = { { format = canvas.format } },
                depthStencil = { format = "depth24plus-stencil8", compare = "less", write = true },
                cullMode = "none",
            })
            self.foePipe = foePipe
            local foeLayout = foePipe:getBindGroupLayout(0)
            self.foeBind = GPUBindGroup.new({
                layout = foeLayout,
                ubos = { { slot = 0, buffer = self.ubo :: GPUBuffer } },
            })
        end
        -- Dedicated gate pipeline: pos + color + phase seed, same stride
        -- as foes. Same 80-byte UBO prefix, so the same uniform buffer
        -- feeds it; gates draw after the boss, then hand back to world.
        local gateShader = context:shader("shaders/gate")
        if gateShader ~= nil then
            local gatePipe = GPUPipeline.new({
                vertex = gateShader,
                fragment = gateShader,
                vertexLayout = {
                    {
                        stride = 28,
                        attributes = {
                            { format = "float32x3", slot = 0, offset = 0 },
                            { format = "float32x3", slot = 1, offset = 12 },
                            { format = "float32", slot = 2, offset = 24 },
                        },
                    },
                },
                colorTargets = { { format = canvas.format } },
                depthStencil = { format = "depth24plus-stencil8", compare = "less", write = true },
                cullMode = "none",
            })
            self.gatePipe = gatePipe
            local gateLayout = gatePipe:getBindGroupLayout(0)
            self.gateBind = GPUBindGroup.new({
                layout = gateLayout,
                ubos = { { slot = 0, buffer = self.ubo :: GPUBuffer } },
            })
        end
        -- Aurora curtains on the same pos + color + phase layout.
        local auroraShader = context:shader("shaders/aurora")
        if auroraShader ~= nil then
            local auroraPipe = GPUPipeline.new({
                vertex = auroraShader,
                fragment = auroraShader,
                vertexLayout = {
                    {
                        stride = 28,
                        attributes = {
                            { format = "float32x3", slot = 0, offset = 0 },
                            { format = "float32x3", slot = 1, offset = 12 },
                            { format = "float32", slot = 2, offset = 24 },
                        },
                    },
                },
                colorTargets = { { format = canvas.format } },
                depthStencil = { format = "depth24plus-stencil8", compare = "less", write = true },
                cullMode = "none",
            })
            self.auroraPipe = auroraPipe
            local auroraLayout = auroraPipe:getBindGroupLayout(0)
            self.auroraBind = GPUBindGroup.new({
                layout = auroraLayout,
                ubos = { { slot = 0, buffer = self.ubo :: GPUBuffer } },
            })
        end
        self.gpuOk = true
        print(`desert 3d ready: {totalVerts} verts`)
    end)
    if not ok then self.gpuOk = false end
    syncSave(self) -- fresh boot code until progress lands
    -- First-paint layout: a resize landing before init binds no props and
    -- sizes no canvas (both nil then), yet marks laidOut + cw/ch, so no
    -- second resize ever comes and hero/home stay 800x500-small in a
    -- bigger viewport until a window adjust. Re-run layout now that props
    -- + canvas exist; later resizes apply normally. Guarded so init can
    -- never fail on the re-layout (a failed init = "failed to load").
    setAny(self, "laidOut", nil)
    local sz = self.size
    if sz ~= nil then pcall(function() resize(self, sz, 1) end) end
    return true
end

function resize(self: Game, size: Vector, scale: number)
    self.size = size
    local w = math.max(1, math.floor(size.x))
    local h = math.max(1, math.floor(size.y))
    if w == self.cw and h == self.ch and (self :: any).laidOut then return end
    ;(self :: any).laidOut = true
    self.cw = w
    self.ch = h
    self.aspect = w / h
    -- HUD cluster: glued to the bottom edge (never moves vertically),
    -- centered on the window.
    local barX = (w - 220) / 2
    if self.hudBarX ~= nil then self.hudBarX.value = barX end
    if self.hudBarY ~= nil then self.hudBarY.value = h - 38 end
    if self.hudHpX ~= nil then self.hudHpX.value = barX - 72 end
    if self.hudNumX ~= nil then self.hudNumX.value = barX + 230 end
    -- Stat row above the HP bar, split left/right so the jet never covers it.
    -- Left cluster aligns with the HP label, right cluster with the HP number.
    local statY = h - 68
    if self.hudSpdLabX ~= nil then self.hudSpdLabX.value = barX - 72 end
    if self.hudSpdNumX ~= nil then self.hudSpdNumX.value = barX - 14 end
    if self.hudAltLabX ~= nil then self.hudAltLabX.value = barX + 190 end
    if self.hudAltNumX ~= nil then self.hudAltNumX.value = barX + 248 end
    if self.hudStatY ~= nil then self.hudStatY.value = statY end
    -- Minimap panel pinned to the top-right corner (10px margins).
    -- Origin is cached for per-frame dot mapping.
    local mapX = w - MAP_W - 10
    local mapY = 10
    if self.hudMapX ~= nil then self.hudMapX.value = mapX end
    if self.hudMapY ~= nil then self.hudMapY.value = mapY end
    self.mapOX = mapX
    self.mapOY = mapY
    -- Hero splash: cover-scale the image, centered on any window.
    local heroW, heroH = 2752, 1488
    if self.heroImg ~= nil then
        heroW = (self.heroImg :: Image).width
        heroH = (self.heroImg :: Image).height
    end
    if heroW > 0 and heroH > 0 then
        local hsc = math.max(w / heroW, h / heroH)
        if self.heroSX ~= nil then self.heroSX.value = hsc end
        if self.heroSY ~= nil then self.heroSY.value = hsc end
    end
    if self.heroX ~= nil then self.heroX.value = w / 2 end
    if self.heroY ~= nil then self.heroY.value = h / 2 end
    -- Hero loading bar (game-styled), above the bottom edge.
    local lbX = (w - 220) / 2
    local lbY = h - 90
    if self.loadBarX ~= nil then self.loadBarX.value = lbX end
    if self.loadBarY ~= nil then self.loadBarY.value = lbY end
    if self.loadLabY ~= nil then self.loadLabY.value = lbY - 34 end
    if self.loadW ~= nil then self.loadW.value = 220 * math.min(1, self.loadT) end
    -- Home screen: cover-scale the bg image, centered, like the hero.
    local bgW, bgH = 2368, 1760
    if self.homeImg ~= nil then
        bgW = (self.homeImg :: Image).width
        bgH = (self.homeImg :: Image).height
    end
    if bgW > 0 and bgH > 0 then
        local bsc = math.max(w / bgW, h / bgH) * 1.12
        if self.homeSX ~= nil then self.homeSX.value = bsc end
        if self.homeSY ~= nil then self.homeSY.value = bsc end
    end
    if self.homeX ~= nil then self.homeX.value = w / 2 end
    if self.homeY ~= nil then self.homeY.value = h / 2 end
    if self.homeTitleX ~= nil then self.homeTitleX.value = (w - 800) / 2 - 40 end
    if self.homeTitleY ~= nil then self.homeTitleY.value = h / 2 - 180 end
    -- Home bottom dim: dark band over the lower bg so buttons read.
    if self.dimX ~= nil then self.dimX.value = 0 end
    if self.dimY ~= nil then self.dimY.value = h - 220 end
    if self.dimW ~= nil then self.dimW.value = w end
    -- Hero fog: stagger banks across the screen on resize.
    if self.fogX ~= nil then
        for i, fp in ipairs(self.fogX) do
            fp.value = (i - 1) / math.max(1, #self.fogX) * (w + 400) - 200
        end
    end
    -- Home smoke: baseline hugs the bottom edge, puffs spread wide.
    self.smokeBaseY = h - 45
    if self.smokeX ~= nil then
        for i, xp in ipairs(self.smokeX) do
            xp.value = (i - 1) / math.max(1, #self.smokeX) * (w + 600) - 300
        end
    end
    if self.smokeY ~= nil then
        for _, yp in ipairs(self.smokeY) do yp.value = self.smokeBaseY end
    end
    -- Home menu rows: START runs 2x wide (440); SETTINGS + RULES
    -- share one 440 row side by side (210 + 20 gap + 210).
    local sX0 = (w - 440) / 2
    local pY = h - 230
    local srY = h - 160
    local setX0, rulX0 = sX0, sX0 + 230
    if self.mainX ~= nil then self.mainX.value = setX0 end
    if self.playY ~= nil then self.playY.value = pY end
    -- Home level cubes: 3 big boxes along the bottom, labels under each,
    -- locks centered on cubes 2-3. Level 1 lit green.
    local lc = w / 2
    local ly = h / 2 + 35
    local lx1, lx2, lx3 = lc - 166, lc - 26, lc + 114
    if self.lvlX1 ~= nil then self.lvlX1.value = lx1 end
    if self.lvlX2 ~= nil then self.lvlX2.value = lx2 end
    if self.lvlX3 ~= nil then self.lvlX3.value = lx3 end
    if self.lvlY ~= nil then self.lvlY.value = ly end
    -- Book badge: centered in cube 1 (Image is center-anchored, 44x44 art).
    setVal(self, "bookX", lx1 + 30)
    setVal(self, "bookY", ly + 30)
    setAny(self, "bookBX", lx1 + 30 - 22)
    setAny(self, "bookBY", ly + 30 - 22)
    if self.pumpX ~= nil then self.pumpX.value = lx2 + 30 end
    if self.pumpY ~= nil then self.pumpY.value = ly + 28 end
    -- Purple pumpkin trophy: 84px art dead-centered on the 60px cube 3.
    if self.pk3X ~= nil then self.pk3X.value = lx3 + 30 end
    if self.pk3Y ~= nil then self.pk3Y.value = ly + 30 end
    if self.lvlLineY ~= nil then self.lvlLineY.value = ly + 27 end
    -- Static gold connectors bridging the 80px gaps between boxes.
    if self.connX0 ~= nil then self.connX0.value = lx1 + 60 end
    if self.connX1 ~= nil then self.connX1.value = lx2 + 60 end
    if self.connY ~= nil then self.connY.value = ly + 28 end
    if self.lvlLabX1 ~= nil then self.lvlLabX1.value = lx1 - 20 end
    if self.lvlLabX2 ~= nil then self.lvlLabX2.value = lx2 - 20 end
    if self.lvlLabX3 ~= nil then self.lvlLabX3.value = lx3 - 20 end
    if self.lvlLabY ~= nil then self.lvlLabY.value = ly + 64 end
    if self.lockX2 ~= nil then self.lockX2.value = lx2 + 30 end
    if self.lockBY2 ~= nil then self.lockBY2.value = ly + 30 end
    if self.lockX3 ~= nil then self.lockX3.value = lx3 + 30 end
    if self.lockBY3 ~= nil then self.lockBY3.value = ly + 30 end
    self.lvlBX, self.lvlBY = lx1 - 3, ly
    if self.setY ~= nil then self.setY.value = srY end
    if self.rulY ~= nil then self.rulY.value = srY end
    if self.rulX ~= nil then self.rulX.value = rulX0 end
    if self.startX ~= nil then self.startX.value = sX0 end
    if self.startBtnY ~= nil then self.startBtnY.value = pY end
    if self.startLabY ~= nil then self.startLabY.value = pY end
    -- Settings box: 360x300 panel centered; SOUND + MUSIC toggles up
    -- top, PLANE COLOUR swatches below. BACK is per-page (syncMenu).
    local panX, panY = (w - 360) / 2, h / 2 - 210
    setVal(self, "setPanelX", panX)
    setVal(self, "setPanelY", panY)
    local sX, sYY = panX + 50, panY + 32
    if self.sndX ~= nil then self.sndX.value = sX end
    if self.sndY ~= nil then self.sndY.value = sYY end
    local mX, mY = panX + 50, panY + 116
    setVal(self, "musX", mX)
    setVal(self, "musY", mY)
    setVal(self, "setHdX", panX)
    setVal(self, "setHdY", panY + 200)
    local swYv = panY + 260
    setVal(self, "swY", swYv)
    setVal(self, "swX0", panX + 58)
    setVal(self, "swX1", panX + 108)
    setVal(self, "swX2", panX + 158)
    setVal(self, "swX3", panX + 208)
    setVal(self, "swX4", panX + 258)
    -- Selection ring rides the picked swatch.
    do
        local pt = (self :: any).planeTint or 4
        setVal(self, "swHlX", panX + 58 + (pt - 1) * 50)
        setVal(self, "tickX", panX + 58 + (pt - 1) * 50 + 22)
        setVal(self, "tickY", swYv + 22)
    end
    if self.rulBodyX ~= nil then self.rulBodyX.value = (w - 560) / 2 end
    if self.rulBodyY ~= nil then self.rulBodyY.value = h / 2 - 50 end
    -- Runway controls board: 560x360 panel centered, title on top,
    -- single vertical list below it. Rows stack 24px apart.
    local helpPX, helpPY = (w - 560) / 2, h / 2 - 180
    if self.ctlPanelX ~= nil then self.ctlPanelX.value = helpPX end
    if self.ctlPanelY ~= nil then self.ctlPanelY.value = helpPY end
    if self.ctlTitleX ~= nil then self.ctlTitleX.value = helpPX end
    if self.ctlTitleY ~= nil then self.ctlTitleY.value = helpPY + 10 end
    if self.ctlBodyX ~= nil then self.ctlBodyX.value = helpPX + 80 end
    if self.ctlBodyY ~= nil then self.ctlBodyY.value = helpPY + 52 end
    if self.ctlBodyRX ~= nil then self.ctlBodyRX.value = helpPX + 80 end
    local ctlBase = helpPY + 52
    local ctlStep = 24
    if self.ctlLY ~= nil then
        for i, p in ipairs(self.ctlLY) do p.value = ctlBase + (i - 1) * ctlStep end
    end
    if self.ctlRY ~= nil then
        for i, p in ipairs(self.ctlRY) do p.value = ctlBase + (5 + i - 1) * ctlStep end
    end
    -- Board close button: 40x40 at the panel's top-right corner.
    local helpXX, helpXY = helpPX + 560 - 48, helpPY + 8
    if self.ctlXBtnX ~= nil then self.ctlXBtnX.value = helpXX end
    if self.ctlXBtnY ~= nil then self.ctlXBtnY.value = helpXY end
    self.helpXX, self.helpXY = helpXX, helpXY
    self.playBX, self.playBY = sX0, pY
    self.setBX, self.setBY = setX0, srY
    self.rulBX, self.rulBY = rulX0, srY
    -- Dev jumps: bottom-left corner, fixed x, stacked above the bottom edge.
    setVal(self, "devL2X", 16); setVal(self, "devL2Y", h - 100)
    setVal(self, "devL3X", 16); setVal(self, "devL3Y", h - 52)
    setAny(self, "devL2BX", 16); setAny(self, "devL2BY", h - 100)
    setAny(self, "devL3BX", 16); setAny(self, "devL3BY", h - 52)
    self.sndBX, self.sndBY = sX, sYY
    setAny(self, "musBX", mX)
    setAny(self, "musBY", mY)
    setAny(self, "swBX0", panX + 58)
    setAny(self, "swBX1", panX + 108)
    setAny(self, "swBX2", panX + 158)
    setAny(self, "swBX3", panX + 208)
    setAny(self, "swBX4", panX + 258)
    setAny(self, "swBY", swYv)
    syncMenu(self)
    -- Game-over panel: title is full-width so it stays page-centered on
    -- any window; buttons centered below it, whole group centered.
    local titleX = (w - 800) / 2
    local titleY = h / 2 - 118
    local btnX = (w - 130) / 2
    local retryY = h / 2 + 30
    local homeY = h / 2 + 90
    if self.overTitleX ~= nil then self.overTitleX.value = titleX end
    if self.overTitleY ~= nil then self.overTitleY.value = titleY end
    if self.overBtnX ~= nil then self.overBtnX.value = btnX end
    if self.overHomeX ~= nil then self.overHomeX.value = btnX end
    if self.overRetryY ~= nil then self.overRetryY.value = retryY end
    if self.overHomeY ~= nil then self.overHomeY.value = homeY end
    self.overBX = btnX
    self.overRY = retryY
    self.overHY = homeY
    -- Pause card: 320x300 panel centered, Resume/Home/Controls stacked.
    local cardX, cardY = (w - 320) / 2, (h - 300) / 2
    local cardBtnX = (w - 200) / 2
    local cardResY, cardHomeY = cardY + 100, cardY + 162
    local cardCtlY = cardY + 224
    if self.cardX ~= nil then self.cardX.value = cardX end
    if self.cardY ~= nil then self.cardY.value = cardY end
    if self.cardBtnX ~= nil then self.cardBtnX.value = cardBtnX end
    if self.cardResY ~= nil then self.cardResY.value = cardResY end
    if self.cardHomeY ~= nil then self.cardHomeY.value = cardHomeY end
    if self.cardCtlY ~= nil then self.cardCtlY.value = cardCtlY end
    if self.cardTitleX ~= nil then self.cardTitleX.value = (w - 800) / 2 end
    if self.cardTitleY ~= nil then self.cardTitleY.value = cardY + 28 end
    -- Welcome greeting: right-side box, vertically centered.
    if self.welcomeX ~= nil then self.welcomeX.value = w - 920 end
    if self.welcomeY ~= nil then self.welcomeY.value = h / 2 - 200 end
    -- Tutorial prompt centered, NICE popup center-screen.
    if self.tutX ~= nil then self.tutX.value = (w - 560) / 2 end
    if self.tutY ~= nil then self.tutY.value = h / 2 - 180 end
    -- Circus score: top-center (L2 only), clear of the gun bar rows.
    if self.gateScoreX ~= nil then self.gateScoreX.value = (w - 200) / 2 end
    if self.gateScoreY ~= nil then self.gateScoreY.value = 8 end
    -- Steer banner: same centering as the tutorial prompt, parked near top.
    if self.lockX ~= nil then self.lockX.value = (w - 560) / 2 end
    if self.niceX ~= nil then self.niceX.value = (w - 400) / 2 end
    if self.niceY ~= nil then self.niceY.value = h / 2 - 55 end
    self.cardResBX, self.cardResBY = cardBtnX, cardResY
    self.cardHomeBX, self.cardHomeBY = cardBtnX, cardHomeY
    self.cardCtlBX, self.cardCtlBY = cardBtnX, cardCtlY
    if self.canvas ~= nil then
        local ok = pcall(function()
            (self.canvas :: GPUCanvas):resize(w, h);
            local dt = GPUTexture.new({ width = w, height = h, format = "depth24plus-stencil8", renderTarget = true });
            self.depthTex = dt;
            self.depthView = dt:view();
        end)
        if not ok then self.gpuOk = false end
    end
end

-- Home menu visibility: main buttons / settings / rules / back / panel
-- title follow homePanel, all gated by homeA.
-- Rules page content: 18 detailed lines over a 6-line window. Drag scrolls
-- line by line through a Lua slice (no layout participants: native scroll
-- boxes shrink the artboard canvas). Global (syncMenu + drag call it).
local RULE_LINES = {
    "- HOLD Q TO SPOOL, W LIFTS OFF THE STRIP",
    "- W CLIMBS, S DIVES, A/D STRAFE, E BRAKES",
    "- Q PUSHES TOWARD 2000, CEILING IS 2000",
    "- R STEERS WITH MOUSE, CLICK OR SPACE FIRES",
    "- P PAUSES, RETRY RESTARTS THE WHOLE RUN",
    "- G OR 1-4 SWAPS GUNS, 4 = HOMING SEEKER",
    "- GIGA BEAM HITS HARDEST, BOLTS PIERCE 3",
    "- THE CROSSHAIR IS DEAD CENTER, ALWAYS",
    "- L1: TRAIN, HUNT 5 PUMPKINS, FELL MORGATHA",
    "- L2: CLEAR 20 WALLS, TIME THE GUILLOTINES",
    "- HAMMER, FAN, ROCKS, NEEDLE, HEADS, PORTAL",
    "- L3: CRACK THE STORM, ENTER THE HORDE RING",
    "- RING BURNS 5/S INSIDE, 25 MID, 35 EDGE",
    "- 6000 KILLS FEED THE MAGMA, GIGA RISES",
    "- OUTRUN ITS HANDS - 3 FALLS RESTARTS ALL",
    "- FELL GIGA AND THE EARTH REVIVES. YOU WIN",
    "- HP 100: KILLS HEAL +5 PER 50, WALLS HEAL",
    "- HP 0 IS ROUND FAILED, REMATCH RETRIES",
    "- M / N OR SHIFT+2 / SHIFT+3 JUMP TO LV 2 / 3",
}
function renderRules(self: Game)
    local top = math.clamp((self :: any).ruleTop or 0, 0, 13)
    ;(self :: any).ruleTop = top
    for i = 0, 5 do setVal(self, "ruleL" .. i, (RULE_LINES[top + i + 1] or "") .. "\n") end
    setVal(self, "ruleScrY", 200 + top * (107 / 13))
end
function syncMenu(self: Game)
    local p = self.homePanel or 0
    local fade = self.homeFade or 0
    if self.btnA ~= nil then self.btnA.value = (p == 0) and fade or 0 end
    if self.setA ~= nil then self.setA.value = (p == 1) and fade or 0 end
    if self.rulA ~= nil then self.rulA.value = (p == 2) and fade or 0 end
    if self.backA ~= nil then self.backA.value = (p > 0) and fade or 0 end
    if self.panelTA ~= nil then self.panelTA.value = (p > 0) and fade or 0 end
    -- BACK sits inside the settings box, below the rules list otherwise.
    -- Button heights stay 52 on both pages; only the slot moves.
    do
        local w, h = self.cw, self.ch
        local bX, bY = (w - 200) / 2, h / 2 + 150
        if p ~= 2 then
            bX, bY = (w - 360) / 2 + 80, h / 2 - 210 + 336
        end
        if self.backX ~= nil then self.backX.value = bX end
        if self.backY ~= nil then self.backY.value = bY end
        self.backBX, self.backBY = bX, bY
    end
    if self.titleTxt ~= nil then
        -- No header on settings/rules pages (it stamped over the cover art).
        self.titleTxt.value = ""
    end
    if self.sndTxt ~= nil then
        self.sndTxt.value = self.soundOn and "SOUND: ON" or "SOUND: OFF"
    end
    setVal(self, "musTxt", ((self :: any).musicOn ~= false) and "MUSIC: ON" or "MUSIC: OFF")
    if p == 2 then
        renderRules(self) -- rules page refresh (enter paths reset to top)
    end
end

-- Home fade: call sites set the target, advance eases homeFade there
-- (~0.55s) and the whole menu (bg, buttons, titles) follows.
-- Sound board playback: respects the settings toggle, never throws.
function playSfx(self: Game, name: string, vol: number?)
    if not self.soundOn then return end
    local src = self.sfx ~= nil and (self.sfx :: any)[name] or nil
    if src ~= nil then
        local ok, inst = pcall(function() return Audio.play(src) end)
        if ok and inst ~= nil and vol ~= nil then
            pcall(function() (inst :: any).volume = vol end)
        end
    end
end

-- Button tap flash: gold ring pops at the click point, fades fast.
function tapFlash(self: Game, px: number, py: number)
    if self.clickX ~= nil then self.clickX.value = px - 22 end
    if self.clickY ~= nil then self.clickY.value = py - 22 end
    if self.clickA ~= nil then self.clickA.value = 1 end
end

-- Steer banner: top message confirming mouse-lock on/off, auto-parks.
function flashLock(self: Game, on: boolean)
    if self.lockMsg ~= nil then
        self.lockMsg.value = on and "MOUSE STEER ON - NOSE FOLLOWS" or "MOUSE STEER OFF"
    end
    if self.lockA ~= nil then self.lockA.value = 1 end
    self.lockMsgT = 2.5
end

-- Pause toggle: freezes the sim, swaps the button glyph, hushes audio.
function togglePause(self: Game)
    self.paused = not self.paused
    if self.cardA ~= nil then self.cardA.value = self.paused and 1 or 0 end
    if self.pauseTxt ~= nil then
        self.pauseTxt.value = self.paused and ">" or "II"
    end
    if self.paused then
        if self.takeoffInst ~= nil then
            pcall(function() (self.takeoffInst :: any):stop() end)
            self.takeoffInst = nil
        end
        if self.jetInst ~= nil then
            pcall(function() (self.jetInst :: any):stop() end)
            self.jetInst = nil
        end
        if self.msg ~= nil then self.msg.value = "PAUSED - press P to resume" end
    else
        if self.msg ~= nil then
            self.msg.value = "hold Q to spool up, W rotates at speed, E brakes"
        end
    end
end

function setHome(self: Game, v: boolean)
    if v and self.paused then togglePause(self) end
    self.homeTarget = v and 1 or 0
    if not v then self.cursorPeek = false end -- back to the hidden flight cursor
    local lv0 = (self :: any).level or 0
    if not v and lv0 ~= 2 and lv0 ~= 3 then self.helpT = 12 end -- runway opens: pop the controls board (never L2/L3)
    if not v and ((self :: any).tutMaster or false) and ((self :: any).level or 1) == 1 then
        retireTutorial(self, true) -- returning L1 hero skips the lessons (L2/L3 already stage in doReset, never here)
    end
end

-- Menus swallow raw keys but state-machine listeners still set VM
-- booleans, so clear them on every screen exit (else stuck keys).
local function clearKeys(self: Game)
    if self.keyF ~= nil then self.keyF.value = false end
    if self.keyB ~= nil then self.keyB.value = false end
    if self.keyL ~= nil then self.keyL.value = false end
    if self.keyR ~= nil then self.keyR.value = false end
    if self.keyJump ~= nil then self.keyJump.value = false end
    if self.keyBoost ~= nil then self.keyBoost.value = false end
end

-- Victory CONTINUE: fresh run, overlay parked, home opens with the
-- NEXT level staged (L1 win -> 2, L2 win -> 3, L3 win -> 3 replay).
-- The old code always forced level 2, so beating L2 replayed L2's map.
local function closeVitOpenHome(self: Game)
    local nl = (self :: any).nextLevel or 2 -- recorded at win time; default 2 keeps old saves safe
    if nl < 1 or nl > 3 then nl = 2 end
    if nl == 3 then -- any level-3 win ratchets both unlocks (GIGA path never re-saves)
        setAny(self, "lvl2open", true)
        ;(self :: any).lvl3open = true
        syncSave(self)
    end
    ;(self :: any).level = nl -- the next level is the next game, never a redo
    doReset(self) -- fresh run, staged for the next level; also clears vitT + victory leftovers
    if self.msg ~= nil then
        if nl == 3 then self.msg.value = "LEVEL 3: THE STORM AHEAD HIDES THE ROTTEN COURT"
        else self.msg.value = "LEVEL 2: BREAK THE WALL! SHOOT THE RED SLAB TO SMASH IT, THEN DODGE THE HAMMER, FAN, ROCKS AND THREAD THE NEEDLE! 5 PUMPKINS GUARD THE DEEP!" end
    end
    if self.vitA ~= nil then self.vitA.value = 0 end
    if self.vitTitleA ~= nil then self.vitTitleA.value = 0 end
    if self.vitSubA ~= nil then self.vitSubA.value = 0 end
    if self.vitL2A ~= nil then self.vitL2A.value = 0 end
    if self.vitL2Lit ~= nil then self.vitL2Lit.value = 0 end
    if self.vitLockA ~= nil then self.vitLockA.value = 0 end
    if self.vitFlash ~= nil then self.vitFlash.value = 0 end
    if self.vitContA ~= nil then self.vitContA.value = 0 end
    if self.vitConfA ~= nil then self.vitConfA.value = 0 end
    if self.vicTitleA ~= nil then self.vicTitleA.value = 0 end
    if self.vitL1A ~= nil then self.vitL1A.value = 0 end
    setVal(self, "vitSub", "- YOUR FIRST VICTORY -")
    setVal(self, "vitCubeA", "LEVEL 1"); setVal(self, "vitCubeB", "LEVEL 2")
    ;(self :: any).unlockT = -1 -- celebrated on the overlay, no replay
    ;(self :: any).vicT = -1
    setAny(self, "vicBoom", false)
    self.homePanel = 0
    setHome(self, true)
    syncMenu(self)
    clearKeys(self)
end

-- Level entry: the ONLY way PLAY / cubes / Space start a run. Sets the
-- level FIRST, then doReset stages that level's world (circus / storm /
-- tutorial). Global (zero module registers). Locked picks fall back to 1.
function startLevel(self: Game, n: number)
    if n < 1 or n > 3 then n = 1 end
    if n == 2 and not ((self :: any).lvl2open or false) then n = 1 end
    if n == 3 and not ((self :: any).lvl3open or false) then n = 1 end
    ;(self :: any).level = n
    doReset(self) -- stages n's world (parkour / court / tutorial)
    self.homePanel = 0
    setHome(self, false) -- retireTutorial is L1-only now, so no double-stage
    syncMenu(self)
    clearKeys(self)
end

-- Judge shortcut: unlocks everything and starts the picked level
-- straight away (Shift+2 / Shift+3, any screen). Global.
function devJump(self: Game, n: number)
    setAny(self, "lvl2open", true)
    ;(self :: any).lvl3open = true
    syncSave(self)
    if self.paused then togglePause(self) end
    startLevel(self, n)
end

function keyboardEvent(self: Game, event: KeyboardEvent): boolean
    -- Judge shortcuts: Shift+2 = level 2, Shift+3 = level 3, any screen.
    -- Menus return early below before keys[] is recorded, so Shift state
    -- (GLFW 340/341) is tracked here. Digit codes cover ASCII (50/51),
    -- CLI raw (2/3), and US-shifted (64 @ / 35 #).
    if event.key == 340 or event.key == 341 then
        self.keys[event.key] = event.phase ~= "up"
    end
    if event.phase ~= "up" and (self.keys[340] or self.keys[341]) then
        if event.key == 50 or event.key == 2 or event.key == 64 then devJump(self, 2); return true end
        if event.key == 51 or event.key == 3 or event.key == 35 then devJump(self, 3); return true end
    end
    -- Plain M / N jump the same way, no Shift needed (judge build).
    if event.phase ~= "up" and (event.key == 109 or event.key == 77) then devJump(self, 2); return true end
    if event.phase ~= "up" and (event.key == 110 or event.key == 78) then devJump(self, 3); return true end
    -- Hero splash: any key moves to home, never reaches the game.
    if self.heroA ~= nil and self.heroA.value > 0 then
        self.heroA.value = 0
        setHome(self, true)
        clearKeys(self)
        return true
    end
    -- GIGA VICTORY page: Space/Enter once CONTINUE is up opens home.
    do
        local vct = (self :: any).vicT
        if vct ~= nil and vct >= 0 then
            if event.phase ~= "up" and vct >= 1.8 and (event.key == 32 or event.key == 13) then
                playSfx(self, "click")
                closeVitOpenHome(self)
            end
            clearKeys(self)
            return true
        end
    end
    -- Victory overlay: Space/Enter once CONTINUE is up opens home.
    do
        local vt = (self :: any).vitT
        if vt ~= nil and vt >= 0 then
            if event.phase ~= "up" and vt >= 6.4 and (event.key == 32 or event.key == 13) then
                playSfx(self, "click")
                closeVitOpenHome(self)
            end
            clearKeys(self)
            return true
        end
    end
    -- Home screen: Esc backs out of panels, Space/Enter plays from main.
    if (self.homeTarget or 0) > 0 then
        if event.key == 256 or event.key == 257 then
            self.homePanel = 0
            syncMenu(self)
        elseif event.phase ~= "up" and (event.key == 32 or event.key == 13)
            and (self.homePanel or 0) == 0 then
            tapFlash(self, self.playBX + 220, self.playBY + 26)
            playSfx(self, "click")
            startLevel(self, (self :: any).level or 1) -- PLAY restages the picked level, never inherits a stale world
            syncMenu(self)
        end
        clearKeys(self)
        return true
    end
    -- (V now jumps straight to round 2; see above.)
    if event.phase == "up" then
        self.keys[event.key] = false
    else
        self.keys[event.key] = true
    end
    if event.phase ~= "up" and ((self :: any).cineT or 0) > 0 then setAny(self, "cineT", 0.001) end -- any key skips the opening cinematic
    -- ESC releases mouse-lock even if the state-machine listener missed it.
    -- 256 = GLFW-style escape code; also accept Rive 'escape' mapping 257.
    if event.key == 256 or event.key == 257 then
        local was = self.locked ~= nil and self.locked.value
        if self.locked ~= nil then self.locked.value = false end
        if self.cursorC ~= nil and self.cursorC.value ~= "arrow" then
            self.cursorC.value = "arrow"
        end
        self.cursorPeek = true -- ESC reveals the cursor until R/click
        if was then flashLock(self, false) end
    end
    -- R toggles mouse-lock (nose steering) with a banner. Clicks only
    -- ever lock (the runtime cannot tell right button from left).
    if event.phase ~= "up" and (event.key == 114 or event.key == 82)
        and (self.homeTarget or 0) <= 0 and not self.crashed and not self.paused
        and ((self :: any).vitT or -1) < 0 and self.locked ~= nil then
        self.locked.value = not self.locked.value
        self.cursorPeek = false -- R never reveals; flight cursor stays hidden
        flashLock(self, self.locked.value)
    end
    return true
end

local function isLocked(self: Game): boolean
    return self.locked ~= nil and self.locked.value
end

function pointerDown(self: Game, event: PointerEvent)
    -- Hero splash: first click moves to home, never touches the game.
    if self.heroA ~= nil and self.heroA.value > 0 then
        self.heroA.value = 0
        setHome(self, true)
        clearKeys(self)
        event:hit()
        return
    end
    -- GIGA VICTORY page: CONTINUE (once visible) opens home; all
    -- other clicks are swallowed while it plays.
    do
        local vct = (self :: any).vicT
        if vct ~= nil and vct >= 0 then
            local px, py = event.position.x, event.position.y
            if vct >= 1.8 and px >= self.vitContBX and px <= self.vitContBX + 260
                and py >= self.vitContBY and py <= self.vitContBY + 64 then
                tapFlash(self, px, py)
                playSfx(self, "click")
                closeVitOpenHome(self)
            end
            event:hit()
            return
        end
    end
    -- Victory overlay: CONTINUE (once visible) opens home; all other
    -- clicks are swallowed while the show plays.
    do
        local vt = (self :: any).vitT
        if vt ~= nil and vt >= 0 then
            local px, py = event.position.x, event.position.y
            if vt >= 6.4 and px >= self.vitContBX and px <= self.vitContBX + 260
                and py >= self.vitContBY and py <= self.vitContBY + 64 then
                tapFlash(self, px, py)
                playSfx(self, "click")
                closeVitOpenHome(self)
            end
            event:hit()
            return
        end
    end
    -- Home screen: menu buttons, other clicks are swallowed.
    if (self.homeTarget or 0) > 0 then
        local px, py = event.position.x, event.position.y
        local p = self.homePanel or 0
        -- Rules text scroll: drag accumulates lines, taps jump 3 (top/bottom third).
        if p == 2 and px >= 120 and px <= 680 and py >= 180 and py <= 370 then
            setAny(self, "ruleDrag", true)
            setAny(self, "ruleDragY", py)
            local top = (self :: any).ruleTop or 0
            if py < 243 then top = math.max(0, top - 3) elseif py > 307 then top = math.min(13, top + 3) end
            if top ~= ((self :: any).ruleTop or 0) then
                setAny(self, "ruleTop", top)
                renderRules(self)
            end
        end
        local function hit(bx: number, by: number, bw: number, bh: number): boolean
            return px >= bx and px <= bx + bw and py >= by and py <= by + bh
        end
        if p == 0 then
            if hit(self.playBX, self.playBY, 440, 52) then
                tapFlash(self, px, py)
                playSfx(self, "click")
                startLevel(self, (self :: any).level or 1) -- PLAY restages the picked level, never inherits a stale world
            elseif hit(self.setBX, self.setBY, 210, 52) then
                tapFlash(self, px, py)
                playSfx(self, "click")
                self.homePanel = 1
            elseif hit(self.rulBX, self.rulBY, 210, 52) then
                tapFlash(self, px, py)
                playSfx(self, "click")
                self.homePanel = 2
                setAny(self, "ruleTop", 0)
                renderRules(self)
            elseif hit(((self :: any).bookBX or -999), ((self :: any).bookBY or -999), 44, 44) then
                tapFlash(self, px, py)
                playSfx(self, "click")
                self.homePanel = 2 -- book badge opens RULES
                setAny(self, "ruleTop", 0)
                renderRules(self)
            elseif hit(self.lvlBX, self.lvlBY, 66, 72) then
                tapFlash(self, px, py)
                playSfx(self, "click")
                startLevel(self, 1) -- Level 1 restaged from scratch, never on the old world
            elseif ((self :: any).lvl2open or false) and hit(self.lvlBX + 140, self.lvlBY, 66, 72) then
                tapFlash(self, px, py)
                playSfx(self, "click")
                startLevel(self, 2) -- Level 2 open: circus restaged, not inherited
            elseif ((self :: any).lvl3open or false) and hit(self.lvlBX + 280, self.lvlBY, 66, 72) then
                tapFlash(self, px, py)
                playSfx(self, "click")
                startLevel(self, 3) -- Level 3 open: storm restaged, not inherited
            elseif hit(self.lvlBX + 86, self.lvlBY, 280, 92) then
                playSfx(self, "click") -- Levels 2-3 locked
            end
        elseif p == 1 then
            if hit(self.sndBX, self.sndBY, 260, 52) then
                tapFlash(self, px, py)
                self.soundOn = not self.soundOn
                syncSave(self) -- the code remembers the toggle
                playSfx(self, "click")
            elseif hit(((self :: any).musBX or 0), ((self :: any).musBY or 0), 260, 52) then
                tapFlash(self, px, py)
                setAny(self, "musicOn", not (((self :: any).musicOn ~= false)))
                syncSave(self)
                if (self :: any).musicOn == false then
                    if self.homeBellsInst ~= nil then
                        pcall(function() (self.homeBellsInst :: any):stop() end)
                        self.homeBellsInst = nil
                    end
                    self.homeBellsT = 0
                    if self.jetInst ~= nil then
                        pcall(function() (self.jetInst :: any):stop() end)
                        self.jetInst = nil
                    end
                    self.jetT = 0
                end
                playSfx(self, "click")
            elseif hit(((self :: any).swBX0 or 0), ((self :: any).swBY or 0), 44, 44) then
                tapFlash(self, px, py)
                setAny(self, "planeTint", 1)
                setVal(self, "swHlX", (self :: any).swBX0)
                setVal(self, "tickX", ((self :: any).swBX0 or 0) + 22)
                syncSave(self)
                playSfx(self, "click")
            elseif hit(((self :: any).swBX1 or 0), ((self :: any).swBY or 0), 44, 44) then
                tapFlash(self, px, py)
                setAny(self, "planeTint", 2)
                setVal(self, "swHlX", (self :: any).swBX1)
                setVal(self, "tickX", ((self :: any).swBX1 or 0) + 22)
                syncSave(self)
                playSfx(self, "click")
            elseif hit(((self :: any).swBX2 or 0), ((self :: any).swBY or 0), 44, 44) then
                tapFlash(self, px, py)
                setAny(self, "planeTint", 3)
                setVal(self, "swHlX", (self :: any).swBX2)
                setVal(self, "tickX", ((self :: any).swBX2 or 0) + 22)
                syncSave(self)
                playSfx(self, "click")
            elseif hit(((self :: any).swBX3 or 0), ((self :: any).swBY or 0), 44, 44) then
                tapFlash(self, px, py)
                setAny(self, "planeTint", 4)
                setVal(self, "swHlX", (self :: any).swBX3)
                setVal(self, "tickX", ((self :: any).swBX3 or 0) + 22)
                syncSave(self)
                playSfx(self, "click")
            elseif hit(((self :: any).swBX4 or 0), ((self :: any).swBY or 0), 44, 44) then
                tapFlash(self, px, py)
                setAny(self, "planeTint", 5)
                setVal(self, "swHlX", (self :: any).swBX4)
                setVal(self, "tickX", ((self :: any).swBX4 or 0) + 22)
                syncSave(self)
                playSfx(self, "click")
            elseif hit(self.backBX, self.backBY, 200, 52) then
                tapFlash(self, px, py)
                playSfx(self, "click")
                self.homePanel = 0
            end
        else
            if hit(self.backBX, self.backBY, 200, 52) then
                tapFlash(self, px, py)
                playSfx(self, "click")
                self.homePanel = 0
            end
        end
        syncMenu(self)
        clearKeys(self)
        event:hit()
        return
    end
    -- Wrecked: RETRY restarts on the runway, HOME opens the home page.
    -- Fell to the merge/magma/giant: retry FROM THE GIANT, never the start.
    if self.crashed then
        local px, py = event.position.x, event.position.y
        local bx0, bx1 = self.overBX, self.overBX + 130
        if px >= bx0 and px <= bx1 and py >= self.overRY and py <= self.overRY + 46 then
            local phr = (self :: any).l3phase
            if (self :: any).level == 3 and (phr == "merge" or phr == "magma" or phr == "giant" or phr == "dying" or phr == "prime") then
                giantRetry(self)
            elseif (self :: any).level == 2 then
                gateRespawn(self) -- rejoin at the crash wall, never the start
            else
                doReset(self)
            end
        elseif px >= self.overHX and px <= self.overHX + 130 and py >= self.overHY and py <= self.overHY + 46 then
            doReset(self)
            self.homePanel = 0
            setHome(self, true)
            syncMenu(self)
        end
        event:hit()
        return
    end
    -- Pause card: Resume unfreezes, Home quits to the menu.
    -- Swallows all other clicks while up.
    if self.paused then
        local cx0, cy0 = event.position.x, event.position.y
        if cx0 >= 10 and cx0 <= 66 and cy0 >= 10 and cy0 <= 58 then
            tapFlash(self, cx0, cy0)
            playSfx(self, "click")
            togglePause(self) -- pause button resumes too
            event:hit()
            return
        end
        if cx0 >= self.cardResBX and cx0 <= self.cardResBX + 200
            and cy0 >= self.cardResBY and cy0 <= self.cardResBY + 52 then
            tapFlash(self, cx0, cy0)
            playSfx(self, "click")
            togglePause(self)
        elseif cx0 >= self.cardHomeBX and cx0 <= self.cardHomeBX + 200
            and cy0 >= self.cardHomeBY and cy0 <= self.cardHomeBY + 52 then
            tapFlash(self, cx0, cy0)
            playSfx(self, "click")
            togglePause(self)
            self.homePanel = 0
            setHome(self, true)
            syncMenu(self)
            clearKeys(self)
        elseif cx0 >= self.cardCtlBX and cx0 <= self.cardCtlBX + 200
            and cy0 >= self.cardCtlBY and cy0 <= self.cardCtlBY + 52 then
            tapFlash(self, cx0, cy0)
            playSfx(self, "click")
            togglePause(self)
            if (self :: any).level ~= 3 and (self :: any).level ~= 2 then self.helpT = 12 end -- pop the controls board over the runway (never in L2/L3)
        end
        event:hit()
        return
    end
    -- Controls board X button: closes it without firing or locking.
    if self.helpT > 0 and (self.homeTarget or 0) <= 0 and not self.crashed and not self.paused then
        local hx, hy = event.position.x, event.position.y
        if hx >= self.helpXX and hx <= self.helpXX + 40 and hy >= self.helpXY and hy <= self.helpXY + 40 then
            self.helpT = 0
            if self.ctlA ~= nil then self.ctlA.value = 0 end
            playSfx(self, "click")
            event:hit()
            return
        end
    end
    -- Pause button (top left): toggles the freeze, never the camera. In-game only.
    do
        local qx, qy = event.position.x, event.position.y
        if (self.homeTarget or 0) <= 0 and qx >= 10 and qx <= 66 and qy >= 10 and qy <= 58 then
            tapFlash(self, qx, qy)
            playSfx(self, "click")
            togglePause(self)
            event:hit()
            return
        end
    end
    self.dragging = true
    self.lastPX = event.position.x
    self.lastPY = event.position.y
    -- Clicks never lock (R is the only lock switch): press shoots,
    -- holding autofires. Cursor follows the lock state, untouched here.
    self.cursorPeek = false -- any playfield click re-hides after an ESC peek
    self.mouseFire = true
    event:hit()
end

function pointerMove(self: Game, event: PointerEvent)
    -- Camera always follows the mouse, locked or not; the lock only
    -- toggles whether the nose steers with it. Button held freezes
    -- the aim so firing sends one straight stream.
    local dx = event.position.x - self.lastPX
    local dy = event.position.y - self.lastPY
    self.lastPX = event.position.x
    self.lastPY = event.position.y
    -- Rules scroll drag: the slice owns it, never claim or steer.
    if (self :: any).ruleDrag then
        local ny = event.position.y
        local acc = ((self :: any).ruleAcc or 0) + (ny - ((self :: any).ruleDragY or ny))
        ;(self :: any).ruleDragY = ny
        local top = (self :: any).ruleTop or 0
        while acc >= 24 and top < 13 do acc -= 24; top += 1 end
        while acc <= -24 and top > 0 do acc += 24; top -= 1 end
        ;(self :: any).ruleAcc = math.clamp(acc, -48, 48)
        if top ~= ((self :: any).ruleTop or 0) then
            setAny(self, "ruleTop", top)
            renderRules(self)
        end
        event:hit()
        return
    end
    -- Cursor in -1..1 for home-page parallax (tracked even unlocked).
    self.mouseNX = math.clamp(event.position.x / math.max(1, self.cw) * 2 - 1, -1, 1)
    self.mouseNY = math.clamp(event.position.y / math.max(1, self.ch) * 2 - 1, -1, 1)
    -- Crosshair lives at screen center now (shooter model): the mouse only
    -- turns the camera, never the dot. While the trigger is held the aim
    -- freezes, so holding fire always sends one straight stream instead
    -- of spraying with hand jitter; look around between bursts.
    -- Button hover: the gold underline glows under whichever home
    -- button the cursor sits on (props drive the Hl bars).
    do
        local px, py = event.position.x, event.position.y
        local hp, hs, hr = 0, 0, 0
        if (self.homeTarget or 0) > 0 and (self.homePanel or 0) == 0 then
            if px >= self.playBX and px <= self.playBX + 440 and py >= self.playBY and py <= self.playBY + 52 then hp = 1 end
            if px >= self.setBX and px <= self.setBX + 210 and py >= self.setBY and py <= self.setBY + 52 then hs = 1 end
            if px >= self.rulBX and px <= self.rulBX + 210 and py >= self.rulBY and py <= self.rulBY + 52 then hr = 1 end
        end
        if self.hovPlay ~= nil then self.hovPlay.value = hp end
        if self.hovSet ~= nil then self.hovSet.value = hs end
        if self.hovRul ~= nil then self.hovRul.value = hr end
    end
    if self.dragging then return end
    -- Clamp huge jumps (first hover, teleport events) to avoid spin.
    if dx > 80 then dx = 80 elseif dx < -80 then dx = -80 end
    if dy > 80 then dy = 80 elseif dy < -80 then dy = -80 end
    self.camYaw -= dx * 0.008 -- mouse right turns view right (sign was inverted)
    -- Move up/down to look at the sky / feet. X/F keys lower/raise the camera.
    self.lookH = math.clamp(self.lookH - dy * 0.05, -1, 14)
    -- Mouse steers the nose too, but only while locked: unlocked mouse
    -- still turns the camera, it just stops flying the jet.
    if not self.grounded and not self.crashed and isLocked(self) then
        self.mouseClimb = math.clamp((self.mouseClimb or 0) - dy * 0.006, -1, 1)
    end
    self.camHold = 2.5 -- hold free-look, don't snap behind hero
    event:hit()
end

function pointerUp(self: Game, event: PointerEvent)
    setAny(self, "ruleDrag", false)
    setAny(self, "ruleAcc", 0)
    self.dragging = false
    self.mouseFire = false -- letting go stops the guns
    event:hit()
end

function pointerExit(self: Game, event: PointerEvent)
    -- Cursor ownership lives in advance(); nothing to do here.
end

local function held(self: Game, ...: number): boolean
    for _, k in ipairs({ ... }) do
        if self.keys[k] then return true end
    end
    return false
end

function advance(self: Game, seconds: number): boolean
    -- Cursor: hidden for the whole flight (steer on or off), shown in
    -- menus, on crash, over victory, while paused, or after an ESC peek.
    do
        local show = (self.homeTarget or 0) > 0 or self.crashed
            or ((self :: any).vitT or -1) >= 0 or ((self :: any).vicT or -1) >= 0 or self.paused or self.cursorPeek
        if self.cursorC ~= nil then
            local want = show and "arrow" or "hidden"
            if self.cursorC.value ~= want then self.cursorC.value = want end
        end
    end
    -- Hover underlines die the moment the home buttons go away
    -- (touch taps never send pointerMove).
    -- Paused: full freeze (time, physics, loaders, fades).
    do
        local menuUp = (self.homeTarget or 0) > 0 and (self.homePanel or 0) == 0
        if not menuUp then
            if self.hovPlay ~= nil then self.hovPlay.value = 0 end
            if self.hovSet ~= nil then self.hovSet.value = 0 end
            if self.hovRul ~= nil then self.hovRul.value = 0 end
        end
    end
    -- R resumes, H quits to home (edge-detected, same as the card buttons).
    if self.paused then
        local rDown = held(self, 114, 82)
        local hDown = held(self, 104, 72)
        local cDown = held(self, 99, 67)
        local prev = (self :: any).cardPrev or false
        ;(self :: any).cardPrev = rDown or hDown or cDown
        if (rDown or hDown or cDown) and not prev then
            playSfx(self, "click")
            togglePause(self)
            if cDown and (self :: any).level ~= 3 and (self :: any).level ~= 2 then self.helpT = 12 end -- pop the controls board (never in L2/L3)
            if hDown then
                self.homePanel = 0
                setHome(self, true)
                syncMenu(self)
                clearKeys(self)
            end
        end
        return true
    end
    ;(self :: any).cardPrev = false
    self.time += seconds
    -- Click flash decay.
    if self.clickA ~= nil and self.clickA.value > 0 then
        self.clickA.value = math.max(0, self.clickA.value - seconds * 4)
    end
    -- Hero fog: banks drift left to right, wrap around.
    if self.fogX ~= nil and #self.fogX > 0 then
        for i, fp in ipairs(self.fogX) do
            local spd = 16 + ((i * 37) % 23)
            local nx = fp.value + spd * seconds
            if nx > self.cw + 200 then
                nx = -260 - ((i * 97) % 160)
            end
            fp.value = nx
        end
    end
    -- Home bg parallax: cover image breathes against the cursor.
    self.parX += ((self.mouseNX or 0) * 16 - self.parX) * math.min(1, seconds * 3.5)
    self.parY += ((self.mouseNY or 0) * 10 - self.parY) * math.min(1, seconds * 3.5)
    -- Home bg parallax: cover image breathes against the cursor.
    if self.homeX ~= nil then self.homeX.value = self.cw / 2 + self.parX end
    if self.homeY ~= nil then self.homeY.value = self.ch / 2 + self.parY end
    -- Home smoke life-cycle: each puff drifts, rises, swells, and
    -- dissipates on its own staggered loop; alpha follows the menu fade.
    if self.smokeX ~= nil and self.smokeY ~= nil and #self.smokeX > 0 then
        local hf = self.homeFade or 0
        for i, xp in ipairs(self.smokeX) do
            local spd = 44 + ((i * 53) % 68)
            local nx = xp.value + spd * seconds
            if nx > self.cw + 420 then
                nx = -420 - ((i * 131) % 200)
            end
            xp.value = nx + math.sin(self.time * 1.6 + i * 2.3) * seconds * 24
            local cyc = 6 + ((i * 37) % 4)
            local p = (self.time / cyc + i * 0.37) % 1
            local rise = 60 + ((i * 29) % 30)
            local yp = self.smokeY[i]
            if yp ~= nil then yp.value = self.smokeBaseY + 10 - p * rise end
            if self.smokeS ~= nil then
                local sc = self.smokeS[i]
                if sc ~= nil then
                    sc.value = (0.9 + (i % 3) * 0.35) * (1.1 + p * 1.0)
                end
            end
            if self.smokeA ~= nil then
                local ap = self.smokeA[i]
                if ap ~= nil then
                    local a = hf * sstep(0, 0.08, p) * (1 - sstep(0.35, 1, p))
                    if a > 1 then a = 1 end
                    ap.value = math.min(1, a + hf * 0.12)
                end
            end
        end
    end
    -- Home fade driver: ease toward the target, whole menu follows.
    local ht = self.homeTarget or 0
    local hf = self.homeFade or 0
    if hf ~= ht then
        hf += math.clamp(ht - hf, -seconds * 1.8, seconds * 1.8)
        if math.abs(ht - hf) < 0.01 then hf = ht end
        self.homeFade = hf
        if self.homeA ~= nil then self.homeA.value = hf end
        syncMenu(self)
    end
    -- Victory lap: MORGATHA rots, the show plays over the battlefield
    -- aftermath (no reset yet), CONTINUE resets and opens home.
    do
        local wt = (self :: any).winT or 0
        if wt > 0 then
            wt -= seconds
            if wt <= 0 then wt = 0 end
            ;(self :: any).winT = wt
            if wt <= 0 then
                clearKeys(self)
                if (self :: any).vicWin then
                    setAny(self, "vicWin", false)
                    setAny(self, "vicT", 0)
                    setAny(self, "vicBoom", false)
                else
                    setAny(self, "vitT", 0)
                    setAny(self, "vitBroke", false)
                    setAny(self, "vitShake", false)
                end
            end
        end
    end
    -- Hero loading: 3s bar, then the home screen opens.
    if self.heroA ~= nil and self.heroA.value > 0 then
        self.loadT = math.min(1, self.loadT + seconds / 3)
        if self.loadW ~= nil then self.loadW.value = 220 * self.loadT end
        if self.loadT >= 1 then
            self.heroA.value = 0
            setHome(self, true)
            syncMenu(self)
            clearKeys(self)
        end
    end
    -- Flight model: the jet always flies forward along its nose (yaw).
    -- W climbs, S descends, A/D strafe with banking, Q throttles up, E brakes.
    local wDown = (self.keyF ~= nil and self.keyF.value) or held(self, 119, 87, 265)
    local sDown = (self.keyB ~= nil and self.keyB.value) or held(self, 115, 83, 264)
    local lDown = (self.keyL ~= nil and self.keyL.value) or held(self, 97, 65, 263)
    local rDown = (self.keyR ~= nil and self.keyR.value) or held(self, 100, 68, 262)
    local qDown = (self.keyBoost ~= nil and self.keyBoost.value) or held(self, 113, 81)
    local eDown = held(self, 101, 69) -- E brakes, no RML listener needed
    -- Menus up: no throttle, rotate, or fire until PLAY fades out.
    local menuUp = (self.heroA ~= nil and self.heroA.value > 0) or (self.homeTarget or 0) > 0
    -- Double-tap Q latches full throttle: two presses within 0.35s toggle it.
    -- Tapping E (brake) always releases the lock.
    if qDown and not self.qPrev then
        if self.time - self.qTapT < 0.35 then
            self.boostLock = not self.boostLock
            if self.msg ~= nil then
                if self.boostLock then
                    self.msg.value = "THROTTLE LOCKED - charging to 2000, E brakes, double-tap Q to release"
                else
                    self.msg.value = "airborne - hold Q to 2000, E brakes, Space fires"
                end
            end
        end
        self.qTapT = self.time
    end
    self.qPrev = qDown
    if eDown and self.boostLock then
        self.boostLock = false
        if self.msg ~= nil then
            self.msg.value = "airborne - hold Q to 2000, E brakes, Space fires"
        end
    end
    -- Play again: P while wrecked rejoins at the crash wall in level 2,
    -- resets the whole run anywhere else.
    local pDown = held(self, 112, 80)
    local pPrev = (self :: any).pPrev or false
    ;(self :: any).pPrev = pDown
    if self.crashed and pDown and not pPrev then
        if (self :: any).level == 2 then
            gateRespawn(self)
        elseif (self :: any).level == 3 and ((self :: any).l3phase == "merge" or (self :: any).l3phase == "magma" or (self :: any).l3phase == "giant" or (self :: any).l3phase == "dying" or (self :: any).l3phase == "prime") then
            giantRetry(self)
        else
            doReset(self)
        end
    end
    -- P in game (not wrecked) toggles pause.
    if not self.crashed and pDown and not pPrev and (self.homeTarget or 0) <= 0
        and (self.heroA == nil or self.heroA.value <= 0) then
        togglePause(self)
    end
    local boost = qDown or self.boostLock
    -- Throttle memory: holds whatever Q/E leave behind (no auto-decay).
    -- Long Q hold is the only way to the top (2k, 5k past the storm).
    local throttle = (self :: any).throttle or START_SPEED
    local lim = ((self :: any).level == 3) and 5000.0 or 2000.0 -- L3 boost mode: 5k top speed + 5k ceiling
    local slim = ((self :: any).level == 3) and 1500.0 or 600.0 -- L3 boost mode: 1500/s strafe
    if not self.grounded then
        if boost then throttle = math.min(lim, throttle + seconds * Q_RATE * (lim / 2000.0)) end
        if eDown then throttle = math.max(MIN_SPEED, throttle - seconds * E_RATE) end
    end
    ;(self :: any).throttle = throttle
    local spd = 1.0 -- flat climb authority: W/S taps move the same at any speed
    local fwd: number
    if self.grounded then
        if self.crashed then
            fwd = 0 -- wreck stays put, no second takeoff
        else
        -- Manual takeoff: Q works the throttle lever (self.roll 0..1),
        -- ground speed follows thrust-minus-drag physics, W rotates -
        -- but only at or above rotation speed. Rolling fast off the
        -- strip end or sides wrecks the jet.
        -- No rolling before the tutorial starts (tutIdx 0): early Q only
        -- dismisses the help board, so holding it through the welcome
        -- speech can't eat the strip and overrun.
        local tutLive = ((self :: any).tutIdx or 0) ~= 0
        if boost and not menuUp and tutLive then self.roll = math.min(1, self.roll + seconds * 0.45) end
        if eDown then self.roll = math.max(0, self.roll - seconds * 1.5) end
        local gspd = (self :: any).gspd or 0
        gspd += (THRUST * self.roll - DRAGK * gspd * gspd) * seconds
        if gspd > 0 then
            gspd -= ROLL_R * seconds
            if eDown then gspd -= 12 * seconds end -- brakes bite hard
        end
        if gspd < 0.3 and self.roll <= 0 then gspd = 0 end -- static friction holds
        gspd = math.max(0, gspd)
        ;(self :: any).gspd = gspd
        ;(self :: any).wheelSpin = ((self :: any).wheelSpin or 0) + gspd * seconds / 0.28 -- tire roll angle, r ~0.28
        fwd = gspd
        -- Takeoff roar removed per request: the roll stays silent.
        if wDown and gspd >= VR and not menuUp then
            self.grounded = false
            ;(self :: any).throttle = LIFTOFF_THR
            ;(self :: any).gspd = 0
            fwd = gspd -- continuous: no teleport, eases up to LIFTOFF_THR
            if self.msg ~= nil then
                self.msg.value = "airborne - hold Q to 2000, E brakes, Space fires"
            end
        elseif wDown and gspd > 2 and not menuUp and self.msg ~= nil then
            self.msg.value = "TOO SLOW - hold Q to build takeoff speed, then W"
        end
        end
    else
        fwd = throttle -- holds leftover speed; 2000 only after a long Q hold
    end
    -- Smooth spool-up/down so liftoff and Q punches don't jolt.
    local fwdPrev = (self :: any).fwd or fwd
    local fwdS = fwdPrev + (fwd - fwdPrev) * math.min(1, 2.5 * seconds)
    ;(self :: any).fwd = fwdS
    ;(self :: any).boostOn = boost
    local fx = math.sin(self.camYaw)
    local fz = math.cos(self.camYaw)
    -- Nose-forward flight plus camera-relative lateral strafe.
    local nx, nz = math.sin(self.yaw), math.cos(self.yaw)
    local mvx = nx * fwdS
    local mvz = nz * fwdS
    -- Lateral strafe capped so high speed stays precise instead of twitchy.
    local lat = math.min(0.5 * fwdS, slim)
    if lDown then mvx += fz * lat; mvz -= fx * lat; end
    if rDown then mvx -= fz * lat; mvz += fx * lat; end
    local mlen = math.sqrt(mvx * mvx + mvz * mvz)
    self.moving = mlen > 0.01
    local d = 0
    if mlen > 0.01 then
        mvx /= mlen
        mvz /= mlen
        self.tx += mvx * mlen * seconds
        self.tz += mvz * mlen * seconds
        -- GIGA knockback slide: decays fast, never past a wreck.
        if not self.crashed then
            local kbx = (self :: any).kbx or 0
            local kbz = (self :: any).kbz or 0
            if kbx ~= 0 or kbz ~= 0 then
                self.tx += kbx * seconds
                self.tz += kbz * seconds
                local damp = math.max(0, 1 - 2.2 * seconds)
                kbx, kbz = kbx * damp, kbz * damp
                if math.abs(kbx) < 0.5 then kbx = 0 end
                if math.abs(kbz) < 0.5 then kbz = 0 end
                setAny(self, "kbx", kbx)
                setAny(self, "kbz", kbz)
            end
        end
        local want = math.atan2(mvx, mvz)
        d = want - self.yaw
        while d > math.pi do d -= 2 * math.pi end
        while d < -math.pi do d += 2 * math.pi end
        self.yaw += d * math.min(1, 8 * seconds)
    end
    -- Nose follows the camera: while mouse-look is active the jet steers
    -- toward the look direction, so the front tip tracks the camera angle.
    if not self.grounded and not self.crashed and isLocked(self) then
        local yd = self.camYaw - self.yaw
        while yd > math.pi do yd -= 2 * math.pi end
        while yd < -math.pi do yd += 2 * math.pi end
        self.yaw += yd * math.min(1, 2.5 * seconds)
    end
    -- Bank into turns: roll proportional to yaw error, smoothed.
    local wantBank = math.clamp(-d * 1.2, -0.7, 0.7); local bank = (self :: any).bank or 0
    bank += (wantBank - bank) * math.min(1, 6 * seconds)
    -- struck-ball tumble: violent roll oscillation + yaw spin while it
    -- lasts, then control comes back. Gated on un-crashed like the slide.
    if not self.crashed then
        local tumble = (self :: any).tumble or 0
        if tumble > 0 then
            tumble -= seconds
            setAny(self, "tumble", tumble)
            bank += math.sin(self.time * 18.0) * 0.9 * math.min(1, tumble * 2.0)
            self.yaw += ((self :: any).tumbleSpin or 0) * seconds * math.min(1, tumble)
        end
    end
    ;(self :: any).bank = bank
    -- Vertical: W climbs, S descends (0.6 min, 2000 ceiling).
    -- No speed = no lift: below STALL the jet sinks, faster the slower it is.
    -- Touching ALT 1 is a crash, wherever it happens: stalled, or diving
    -- into the dunes. (Skimming level at speed is safe.)
    local climb = 0.0
    local sink = 0.0
    if not self.grounded then
        if wDown then climb += 170 * spd end
        if sDown then climb -= 170 * spd end
        climb += (self.mouseClimb or 0) * 170 * spd -- mouse elevator trim
        self.mouseClimb = (self.mouseClimb or 0) * math.max(0, 1 - 1.5 * seconds)
        self.hy = self.hy + climb * seconds
        -- knockback pop: up fast, then spent — normal lift takes over.
        -- (Never left running: a decaying kby would pin the plane down
        -- and W could never climb again.)
        if not self.grounded and not self.crashed then
            local kby = (self :: any).kby or 0
            if kby > 0 then
                self.hy += kby * seconds
                kby -= 500.0 * seconds
                if kby <= 0 then kby = 0 end
                setAny(self, "kby", kby)
            end
        end
        if throttle < STALL and ((self :: any).l3floatT or 0) <= 0 then
            sink = (1 - throttle / STALL) * SINK
            self.hy -= sink * seconds
        end
        if self.hy <= 1.0 then
            -- Victory flyover: the show owns the sky, no wreck can steal it.
            -- Parkour mercy: grace ticks down below; while it runs, kisses skim.
            if not self.crashed and ((self :: any).vitT or -1) < 0 and ((self :: any).gateGraceT or 0) <= 0 then
                if gateMode(self) then
                    gateCrash(self) -- tunnel: the deck is death, the portal is the exit
                elseif (throttle < STALL or climb < -0.5) then
                -- Wrecked on the spot: the jet breaks apart, HP flatlines.
                self.hy = 0.6
                self.crashed = true
                self.crashT = 0
                self.crashAcc = 0
                self.grounded = true
                self.roll = 0
                ;(self :: any).throttle = 0
                ;(self :: any).fwd = 0 -- dead stop: no slide past the blast
                if self.health ~= nil then self.health.value = 0 end
                if self.overA ~= nil then self.overA.value = 1 end
                if self.cursorC ~= nil then self.cursorC.value = "arrow" end
                if self.takeoffInst ~= nil then
                    pcall(function() (self.takeoffInst :: any):stop() end)
                    self.takeoffInst = nil
                end
                if self.jetInst ~= nil then
                    pcall(function() (self.jetInst :: any):stop() end)
                    self.jetInst = nil
                end
                -- Crash blast: one full volley across all 96 chunk slots.
                -- The dark debris reads as the airframe breaking apart;
                -- fire + flash ride the WGSL pumpkin/candle glow bands.
                if #self.chunks > 0 then
                    local gyT = groundH(self.tx, self.tz)
                    for _ = 1, 3 do puff(self, 1, 14, 8, 0.7, gyT) end -- bloom flashes
                    for _ = 1, 26 do puff(self, 0, 60, 42, 2.2, gyT) end -- big layered fireballs
                    for _ = 1, 14 do puff(self, 2, 26, 18, 3.2, gyT) end -- smoke
                    for _ = 1, 24 do puff(self, 3, 44, 38, 2.2, gyT) end -- airframe parts
                    for _ = 1, 16 do puff(self, 4, 52, 46, 1.3, gyT) end -- sparks
                    for _ = 1, 11 do puff(self, 5, 40, 10, 2.6, gyT) end -- dust ring
                    for _ = 1, 2 do puff(self, 6, 8, 0, 0.9, gyT) end -- shockwave rings
                end
                if self.msg ~= nil then
                    self.msg.value = "YOU CRASHED - press P to play again"
                end
                playSfx(self, "crash", 1.0) -- wreck boom at max volume
            elseif self.hy < 0.6 then
                self.hy = 0.6 -- fast skim along the dunes, no crash
            end
            end
        elseif self.hy > lim then
            -- hard ceiling (2k, 5k in L3 boost mode)
            self.hy = lim
        end
    else
        self.hy += (0.0 - self.hy) * math.min(1, 6 * seconds)
    end
    -- Runway limits: rolling fast off the strip end or sides wrecks the jet.
    if self.grounded and not self.crashed then
        local gspdNow = (self :: any).gspd or 0
        if gspdNow > 6 and (self.tz > RWY_Z1 + 8 or math.abs(self.tx - RWY_CX) > 26) then
            if gateMode(self) then
                gateCrash(self) -- circus: botched takeoff burns, then rejoins
            else
            self.hy = 0.6
            self.crashed = true
            self.crashT = 0
            self.crashAcc = 0
            self.roll = 0
            ;(self :: any).throttle = 0
            ;(self :: any).gspd = 0
            ;(self :: any).fwd = 0 -- dead stop: no slide past the blast
            if self.health ~= nil then self.health.value = 0 end
            if self.overA ~= nil then self.overA.value = 1 end
            if self.cursorC ~= nil then self.cursorC.value = "arrow" end
            if self.takeoffInst ~= nil then
                pcall(function() (self.takeoffInst :: any):stop() end)
                self.takeoffInst = nil
            end
            if self.jetInst ~= nil then
                pcall(function() (self.jetInst :: any):stop() end)
                self.jetInst = nil
            end
            if #self.chunks > 0 then
                local gyT = groundH(self.tx, self.tz)
                for _ = 1, 3 do puff(self, 1, 14, 8, 0.7, gyT) end -- bloom flashes
                for _ = 1, 26 do puff(self, 0, 60, 42, 2.2, gyT) end -- big layered fireballs
                for _ = 1, 14 do puff(self, 2, 26, 18, 3.2, gyT) end -- smoke
                for _ = 1, 24 do puff(self, 3, 44, 38, 2.2, gyT) end -- airframe parts
                for _ = 1, 16 do puff(self, 4, 52, 46, 1.3, gyT) end -- sparks
                for _ = 1, 11 do puff(self, 5, 40, 10, 2.6, gyT) end -- dust ring
                    for _ = 1, 2 do puff(self, 6, 8, 0, 0.9, gyT) end -- shockwave rings
            end
            if self.msg ~= nil then
                self.msg.value = "YOU CRASHED - press P to play again"
            end
            playSfx(self, "crash", 1.0) -- wreck boom at max volume
            end
        end
    end
    self.vy = climb - sink
    -- Space fires twin bolts through the crosshair (hold to autofire).
    local jDown = (self.keyJump ~= nil and self.keyJump.value) or held(self, 32) or self.mouseFire
    -- Runway controls board: pops when the runway opens (PLAY / retry),
    -- hides on any flight input or after 12s.
    local helpOn = (self.homeTarget or 0) <= 0
        and (self.heroA == nil or self.heroA.value <= 0)
        and not self.crashed and not self.paused and self.helpT > 0
        and (self :: any).level ~= 3 and (self :: any).level ~= 2 -- never in L2/L3
    if helpOn and (wDown or sDown or lDown or rDown or qDown or eDown or jDown or self.mouseFire) then
        self.helpT = 0
        helpOn = false
    end
    if helpOn then self.helpT = math.max(0, self.helpT - seconds) end
    if self.ctlA ~= nil then
        self.ctlA.value = helpOn and math.min(1, self.helpT) or 0
    end
    -- Controls card just closed (timeout, X button, or first flight input):
    -- greet the pilot once, then the step-by-step teaching takes over.
    local hadHelp = (self :: any).hadHelp or false
    ;(self :: any).hadHelp = helpOn
    if hadHelp and not helpOn and not ((self :: any).welcomed or false) then
        setAny(self, "welcomed", true)
        if (self :: any).level ~= 2 then -- the circus skips the greeting
            (self :: any).welcomeT = 4.0
            ;(self :: any).welcomeFull = "WELCOME ABOARD, HERO"
            if self.welcome ~= nil then self.welcome.value = "" end
        end
    end
    do
        local wt = (self :: any).welcomeT or 0
        if wt > 0 then
            wt = math.max(0, wt - seconds)
            ;(self :: any).welcomeT = wt
        end
        -- Typewriter: reveal the greeting letter by letter, with a block
        -- cursor while writing. Pop-up: overshoot scale on entry.
        local full = (self :: any).welcomeFull or "WELCOME ABOARD, HERO"
        local el = 4.0 - wt
        if wt > 0 and wt <= 4.0 then
            local n = math.floor(el * 14)
            if n < 0 then n = 0 end
            if n > #full then n = #full end
            if self.welcome ~= nil then
                local shown = string.sub(full, 1, n)
                if n < #full then shown = shown .. "_" end
                self.welcome.value = shown
            end
        end
        if self.welcomeA ~= nil then
            self.welcomeA.value = math.clamp(math.min(el / 0.5, wt / 1.5), 0, 1)
        end
        if self.welcomeS ~= nil then
            local t = math.clamp(el / 0.45, 0, 1)
            local c1, c3 = 1.70158, 2.70158
            local dd = t - 1
            local back = 1 + c3 * dd * dd * dd + c1 * dd * dd
            self.welcomeS.value = 0.5 + 0.5 * back
        end
    end
    -- Level 3 mission line: typewriter reveal after the welcome fades.
    -- Any later prompt clears l3chalFull first and writes instantly.
    do
        local chFull = (self :: any).l3chalFull
        if type(chFull) == "string" and (self :: any).level == 3 and ((self :: any).welcomeT or 0) <= 0 then
            local chN = ((self :: any).l3chalN or 0) + seconds * 28.0
            local chK = math.floor(chN)
            if chK >= #chFull then
                chK = #chFull
                setAny(self, "l3chalFull", false)
            else
                setAny(self, "l3chalN", chN)
            end
            if self.tut ~= nil then
                local shown = string.sub(chFull, 1, chK)
                if chK < #chFull then shown = shown .. "_" end
                self.tut.value = shown
            end
            if self.tutA ~= nil then self.tutA.value = 1 end
        end
    end
    -- Tutorial timeline: ordered button prompts, one per input. Each
    -- completed action pops NICE, then the next prompt. Retires for
    -- the run after the click step.
    local TUT_LABELS = {
        "HOLD Q TO BUILD TAKEOFF SPEED",
        "PRESS W TO LIFT OFF AND CLIMB",
        "PRESS A TO STRAFE LEFT",
        "PRESS D TO STRAFE RIGHT",
        "KEEP HOLDING Q FOR MORE SPEED",
        "KEEP HOLDING W TO CLIMB HIGHER",
        "PRESS S TO DIVE",
        "TAP E TO REDUCE SPEED",
        "TAP MOUSE LEFT-CLICK TO FIRE",
        "PRESS 1-4 TO SWITCH GUNS (4 = SEEKER)",
        "PRESS R - MOVE THE MOUSE TO STEER THE NOSE",        "PRESS R TWICE - STEER OFF, THEN BACK ON",
    }
    do
        if self.crashed then
            -- Wrecked mid-tutorial: kill every prompt, retire the timeline.
            (self :: any).tutIdx = -1
            ;(self :: any).niceT = 0
            setAny(self, "tutH0", nil); setAny(self, "tutCam0", nil); setAny(self, "tutLockPrev", nil); setAny(self, "tutTog", 0); setAny(self, "tutAirT", 0)
            if self.tutA ~= nil then self.tutA.value = 0 end
            if self.niceA ~= nil then self.niceA.value = 0 end
        else
        local idx = (self :: any).tutIdx or 0 -- 0 = waiting, -1 = retired
        local welcomeDone = ((self :: any).welcomed or false) and ((self :: any).welcomeT or 0) <= 0
        if idx == 0 and welcomeDone and not self.crashed and not menuUp then
            idx = 1
            ;(self :: any).tutIdx = idx
            if self.tut ~= nil then self.tut.value = TUT_LABELS[1] end
            if self.tutA ~= nil then self.tutA.value = 1 end
        end
        local niceT = (self :: any).niceT or 0
        if niceT > 0 then
            niceT = math.max(0, niceT - seconds)
            ;(self :: any).niceT = niceT
            if self.niceA ~= nil then
                self.niceA.value = math.clamp(math.min((1.2 - niceT) / 0.2, niceT / 0.5), 0, 1)
            end
            if niceT <= 0 then
                if self.niceA ~= nil then self.niceA.value = 0 end
                idx += 1
                if idx > #TUT_LABELS then
                    idx = -1 -- timeline complete: tutorials done, pumpkins appear
                    ;(self :: any).tutDone = true
                    ;(self :: any).tutMaster = true -- learned once, skipped forever
                    syncSave(self)
                    stageFoes(self)
                    if self.msg ~= nil then self.msg.value = "ROUND 1 DONE - GET READY FOR ROUND 2!" end
                    if self.tut ~= nil then self.tut.value = "HIT THE PUMPKINS WITH YOUR GUNS!" end
                    if self.tutA ~= nil then self.tutA.value = 1 end
                    ;(self :: any).r2intro = 0 -- staged pumpkin-hunt briefing starts
                    ;(self :: any).r2introT = 2.0
                else
                    if self.tut ~= nil then self.tut.value = TUT_LABELS[idx] end
                    if self.tutA ~= nil then self.tutA.value = 1 end
                end
                ;(self :: any).tutIdx = idx
            end
        elseif idx >= 1 and idx <= #TUT_LABELS then
            local ready = true
            if idx == 3 then
                -- Strafe step waits for takeoff, plus a beat after liftoff.
                if self.grounded then
                    ready = false
                    ;(self :: any).tutAirT = 0
                else
                    local at = ((self :: any).tutAirT or 0) + seconds
                    ;(self :: any).tutAirT = at
                    if at < 2.5 then ready = false end
                end
            end
            if self.tutA ~= nil then self.tutA.value = ready and 1 or 0 end
            -- Climb-higher step: gain 80 height from wherever the run is
            -- when the prompt appears, so it always proves a long W hold.
            local hGain = false
            if idx == 6 and not self.grounded then
                if (self :: any).tutH0 == nil then setAny(self, "tutH0", self.hy) end
                hGain = self.hy >= (((self :: any).tutH0) or 0) + 80
            end
            local hit = false
            if ready then
                if idx == 1 and (((self :: any).gspd or 0) >= VR or not self.grounded) then hit = true -- rotation speed: W will work now
                elseif idx == 2 and not self.grounded then hit = true -- only real liftoff counts, early taps stay
                elseif idx == 3 and lDown then hit = true
                elseif idx == 4 and rDown then hit = true
                elseif idx == 5 and ((self :: any).throttle or 0) >= 650 then hit = true -- Q held to 650 speed
                elseif idx == 6 and hGain then hit = true
                elseif idx == 7 and sDown then hit = true
                elseif idx == 8 and eDown then hit = true
                elseif idx == 9 and (self.mouseFire or jDown) then hit = true
                elseif idx == 10 and (held(self, 49, 1) or held(self, 50, 2) or held(self, 51, 3) or held(self, 52, 4)) then hit = true -- any gun key
                elseif idx == 11 and isLocked(self) then
                    -- Steer step: prove the mouse moved while locked (the
                    -- nose follows the camera on its own).
                    if (self :: any).tutCam0 == nil then setAny(self, "tutCam0", self.camYaw) end
                    local dc = self.camYaw - (((self :: any).tutCam0) or 0)
                    while dc > math.pi do dc -= 2 * math.pi end
                    while dc < -math.pi do dc += 2 * math.pi end
                    if math.abs(dc) > 0.12 then hit = true end
                elseif idx == 12 then
                    -- R-toggle step: prove two lock flips (off then on),
                    -- ending locked so the hunt stays steerable.
                    if (self :: any).tutLockPrev == nil then
                        setAny(self, "tutLockPrev", isLocked(self))
                        setAny(self, "tutTog", 0)
                    end
                    local cur = isLocked(self)
                    if cur ~= ((self :: any).tutLockPrev or false) then
                        setAny(self, "tutLockPrev", cur)
                        setAny(self, "tutTog", ((self :: any).tutTog or 0) + 1)
                    end
                    if ((self :: any).tutTog or 0) >= 2 and cur then hit = true end
                end
            end
            if hit and not self.crashed and not menuUp then
                if self.tutA ~= nil then self.tutA.value = 0 end
                if idx == 6 then setAny(self, "tutH0", nil) end
                if idx == 11 then setAny(self, "tutCam0", nil) end
                if idx == 12 then setAny(self, "tutLockPrev", nil); setAny(self, "tutTog", nil) end
                ;(self :: any).niceT = 1.2
            end
        end
        end
    end
    -- Round-2 briefing: staged pumpkin-hunt how-to after the tutorial.
    -- The first kill cancels it (progress takes over), as does a crash.
    do
        local ri = (self :: any).r2intro
        if ri ~= nil and ri >= 0 and ((self :: any).tutDone or false)
            and self.round == 1 and self.kills <= 0 and not self.crashed and not menuUp then
            local rt2 = ((self :: any).r2introT or 0) - seconds
            if rt2 <= 0 then
                local nxt = ri + 1
                if self.msg ~= nil then
                    if nxt == 1 then self.msg.value = "ROUND 2: 5 PUMPKINS DEAD AHEAD - GO GET THEM!"
                    elseif nxt == 2 then self.msg.value = "PUMPKINS ARE GREEN DOTS ON THE MAP - FOLLOW THEM!"
                    elseif nxt == 3 then self.msg.value = "PUT THE CROSS ON A PUMPKIN AND CLICK TO FIRE!"
                    elseif nxt == 4 then self.msg.value = "STEER WITH THE MOUSE - W CLIMBS, S DIVES, A/D STRAFE"
                    else self.msg.value = "DOWN ALL 5 PUMPKINS - CLICK OR SPACE FIRES!" end
                end
                if nxt >= 5 then
                    setAny(self, "r2intro", -1)
                else
                    setAny(self, "r2intro", nxt)
                    ;(self :: any).r2introT = 4.0
                end
            else
                setAny(self, "r2introT", rt2)
            end
        end
    end
    -- Level 3: PRIME stages ahead once the staff breaks (l3phase prime),
    -- the moment the jet is airborne. Staff waves need no staging here:
    -- stageCourt opens on the storm, wave 1 rises at the storm break,
    -- wave 2 on the wave-1 clear.
    do
        local B0 = (self :: any).boss
        if (self :: any).level == 3 and self.round == 3 and (self :: any).l3phase == "prime"
            and ((self :: any).l3gigaDown or false)
            and (B0 == nil or not B0.on)
            and not self.grounded and not self.crashed and not menuUp then
            stageBoss(self)
            setAny(self, "r3intro", 0)
            ;(self :: any).r3introT = 2.5
        end
    end
    -- Level 3 storm opening: no foes until the wall breaks. Distance to
    -- the storm heart drives the suspense: hold-steady reminder, thinning
    -- reveal, then the break over the army + staff wave 1 rises.
    do
        local ph0 = (self :: any).l3phase
        if (self :: any).level == 3 and (ph0 == "storm" or ph0 == "reveal")
            and not self.crashed and (self.homeTarget or 0) <= 0 and not self.paused then
            local sx = (self :: any).l3stormX or L3_STORM_X
            local sz = (self :: any).l3stormZ or L3_STORM_Z
            local dx = self.tx - sx
            local dz = self.tz - sz
            if dx > WRAP then dx -= WRAP * 2 elseif dx < -WRAP then dx += WRAP * 2 end
            if dz > WRAP then dz -= WRAP * 2 elseif dz < -WRAP then dz += WRAP * 2 end
            local dist = math.sqrt(dx * dx + dz * dz)
            -- NOTE: the wall never moves (fixed at L3_STORM_X/Z). The charge
            -- is pure illusion: the WGSL scrolls dust at the lens + surges
            -- the curtains forward/back net-zero, so it FEELS incoming.
            -- Runway sequence: welcome plays at level start, then the
            -- storm-side mission types out once the welcome fades.
            if ((self :: any).welcomeT or 0) <= 0 and not ((self :: any).l3chalShown or false) then
                setAny(self, "l3chalShown", true)
                setAny(self, "l3chalFull", "LAST CHALLENGE WAITS ON THE OTHER SIDE OF THE STORM")
                setAny(self, "l3chalN", 0.0)
                if self.tut ~= nil then self.tut.value = "_" end
                if self.tutA ~= nil then self.tutA.value = 1 end
            end
            -- Roll-off clears the long mission line: 30u of runway roll
            -- hides it (typing cancelled); later prompts show normally.
            if ((self :: any).l3chalShown or false) and not ((self :: any).l3chalHid or false)
                and ((self :: any).l3phase == "storm" or (self :: any).l3phase == "reveal") then
                local rdx = self.tx - ((self :: any).l3runX or self.tx)
                local rdz = self.tz - ((self :: any).l3runZ or self.tz)
                if rdx * rdx + rdz * rdz > 900.0 then
                    setAny(self, "l3chalHid", true)
                    setAny(self, "l3chalFull", false)
                    if self.tutA ~= nil then self.tutA.value = 0 end
                end
            end
            -- Crossing to the far side by any line (flown around, not
            -- through) breaks the wall too: nothing stands behind you.
            if self.tz > sz + 500.0 then courtBreak(self, sx, sz) end
            if ph0 == "storm" then
                if dist <= L3_REVEAL_D then
                    setAny(self, "l3phase", "reveal")
                    setAny(self, "l3chalFull", false)
                    if self.tut ~= nil then self.tut.value = "SOMETHING MOVES INSIDE THE STORM... CLOSER!" end
                    if self.tutA ~= nil then self.tutA.value = 1 end
                elseif dist <= L3_MID_D then
                    if not ((self :: any).l3mid or false) then
                        setAny(self, "l3mid", true)
                        setAny(self, "l3chalFull", false)
                        setAny(self, "l3steadyT", 1.0) -- steady hides a second after showing
                        if self.tut ~= nil then self.tut.value = "HOLD HER STEADY - IT'S COMING FAST!" end
                        if self.tutA ~= nil then self.tutA.value = 1 end
                    end
                else
                    -- turned around or lost: nag back on course every 6s
                    local nag = ((self :: any).l3nagT or 0) - seconds
                    if dist > L3_NAG_D and nag <= 0 then
                        nag = 6.0
                        setAny(self, "l3chalFull", false)
                        if self.tut ~= nil then self.tut.value = "TURN AROUND - THE STORM IS BEHIND YOU!" end
                        if self.tutA ~= nil then self.tutA.value = 1 end
                    end
                    setAny(self, "l3nagT", nag)
                end
            end
            if (self :: any).l3phase == "reveal" then
                -- the wall thins with the approach; push-in breaks it
                local k = math.clamp((dist - L3_BREAK_D) / (L3_REVEAL_D - L3_BREAK_D), 0, 1)
                setAny(self, "l3stormK", k)
                if dist <= L3_BREAK_D then
                    courtBreak(self, sx, sz)
                end
            end
            -- HOLD STEADY hides a second after showing (only itself).
            if ((self :: any).l3steadyT or -1) > 0 then
                local sst = ((self :: any).l3steadyT or 0) - seconds
                setAny(self, "l3steadyT", sst)
                if sst <= 0 and self.tut ~= nil
                    and self.tut.value == "HOLD HER STEADY - IT'S COMING FAST!" then
                    if self.tutA ~= nil then self.tutA.value = 0 end
                end
            end
            -- rolling thunder while the storm stands (5-9s rolls).
            -- louder as you close (ground or air, as long as it is ahead).
            if ((self :: any).l3phase == "storm" or (self :: any).l3phase == "reveal")
                and dist <= 16000 then
                local tt = ((self :: any).l3thunT or 3.0) - seconds
                if tt <= 0 then
                    local h = math.sin(self.time * 12.9898) * 43758.5453
                    tt = 5.0 + (h - math.floor(h)) * 4.0
                    local vol = math.clamp(1.0 - dist / 16000.0, 0.1, 0.6)
                    playSfx(self, "crash", vol)
                end
                setAny(self, "l3thunT", tt)
            end
            -- Whiteout blind: pushing inside the wall (≤2600u while it
            -- stands) ramps 0→1, fully blind by 1500u (the break range).
            -- violent shake. Gone the moment the wall breaks.
            local blind = 0
            if ((self :: any).l3phase == "storm" or (self :: any).l3phase == "reveal") then
                blind = math.clamp((2600.0 - dist) / 1100.0, 0, 1)
            end
            setAny(self, "l3blind", blind)
        end
    end
    -- Level 3 boss arc: merge (run-in) -> magma (grow) -> explosion ->
    -- giga (rise + hunt). Runs once the shootout hits 400 kills.
    do
        local phm = (self :: any).l3phase
        if (self :: any).level == 3 and (phm == "merge" or phm == "magma" or phm == "giant" or phm == "dying")
            and not self.crashed and (self.homeTarget or 0) <= 0 and not self.paused then
            local mx = (self :: any).l3mergeX or L3_ARMY_X
            local mz = (self :: any).l3mergeZ or L3_ARMY_Z
            if phm == "merge" then
                local mt = ((self :: any).l3mergeT or 14.0) - seconds
                setAny(self, "l3mergeT", mt)
                if mt <= 0 then
                    setAny(self, "l3phase", "magma")
                    setAny(self, "l3magmaT", 0)
                    if self.tut ~= nil then self.tut.value = "IT'S DRINKING THEM - THE BALL IS FULL!" end
                    if self.tutA ~= nil then self.tutA.value = 1 end
                    playSfx(self, "crash", 0.7)
                end
            elseif phm == "magma" then
                local gt2 = ((self :: any).l3magmaT or 0) + seconds
                setAny(self, "l3magmaT", gt2)
                if gt2 >= 8.0 then
                    -- detonation: the ball (full of zombies) goes up
                    local gyM = groundH(mx, mz)
                    if #self.chunks > 0 then
                        for _ = 1, 20 do puff(self, 0, 900, 480, 2.2, gyM + 300) end
                        for _ = 1, 10 do puff(self, 1, 600, 240, 0.9, gyM + 600) end
                        for _ = 1, 8 do puff(self, 2, 480, 180, 3.0, gyM + 450) end
                        for _ = 1, 4 do puff(self, 6, 180, 0, 1.2, gyM + 150) end
                    end
                    playSfx(self, "crash", 1.0)
                    setAny(self, "armyHidden", true) -- the horde is inside now
                    setAny(self, "l3giant", { x = mx, z = mz, hp = GIANT_HP, rise = 0, swpT = 0,
                        windT = 0, windKind = "right", windAnim = "windR", side = 1, recT = 0,
                        campT = 0, dustT = 0, enraged = false, roarT = 0, anim = "rise", briefT = 2.0,
                        iconT = 15.0, iconDash = 0, iconSlam = false,
                        deathT = 0, sink = 0 })
                    -- far jet: no teleport, no burrow — it runs you down
                    -- on foot (the hunt flag below does the chasing).
                    setAny(self, "l3phase", "giant")
                    if self.tut ~= nil then self.tut.value = "THE GIGA RISES - IT CAN'T SHOOT, BUT DON'T LET IT TOUCH YOU!" end
                    if self.tutA ~= nil then self.tutA.value = 1 end
                    if self.msg ~= nil then self.msg.value = "GIGA " .. GIANT_HP .. " HP - OUTRUN ITS HANDS, AIM FOR THE TORSO!" end
                end
            elseif phm == "giant" or phm == "dying" then
                local G: any = (self :: any).l3giant
                if G ~= nil then
                    local gyG = groundH(G.x, G.z)
                    -- ammo-hit body glow, decays like the jet's hitFlash
                    G.flashT = math.max(0, (G.flashT or 0) - seconds * 4.0)
                    -- eye blink: lids shut ~0.12s every 2-5s (mesh scales
                    -- the eye boxes flat; the shader keeps them burning).
                    G.blinkCd = (G.blinkCd or 3.0) - seconds
                    if (G.blinkCd or 0) <= 0 then
                        G.blinkCd = 2.0 + ((G.hp or 0) % 300) / 100.0
                        G.blinkT = 0.12
                    end
                    G.blinkT = math.max(0, (G.blinkT or 0) - seconds)
                    -- jaw: hangs open on roar/windup/chase, snaps shut on
                    -- the slam, idles half-open with a slow chew otherwise.
                    local jawWant = 0.25 + 0.10 * math.sin(self.time * 1.3)
                    local gAnim = G.anim or ""
                    if (G.roarT or 0) > 0 or gAnim == "enrage" then jawWant = 1.0
                    elseif (G.windT or 0) > 0 then jawWant = 0.9
                    elseif gAnim == "recover" then jawWant = 0.05
                    elseif gAnim == "rest" then jawWant = 0.85 -- panting breather
                    elseif gAnim == "run" or gAnim == "sprint" then jawWant = 0.55 end
                    G.jaw = (G.jaw or 0) + (jawWant - (G.jaw or 0)) * math.min(1, 6.0 * seconds)
                    -- briefing auto-hides 2s after staging (frees the
                    -- prompt for the hunt callouts)
                    if phm == "giant" and (G.briefT or 0) > 0 then
                        G.briefT = (G.briefT or 0) - seconds
                        if (G.briefT or 0) <= 0 and self.tutA ~= nil then self.tutA.value = 0 end
                    end
                    if phm == "dying" then
                        -- death cinema (3s): cracks split the hide, the body
                        -- throbs magma-red, then massively detonates.
                        G.deathT = (G.deathT or 0) + seconds
                        G.sink = math.min(1, (G.deathT or 0) / 3.0)
                        G.anim = "death"
                        if (G.deathT or 0) >= 3.0 then
                            -- ATOM BOMB: blinding core flash, giant churning
                            -- fireball, rising mushroom stem + rolling cap,
                            -- spark storm, staggered shockwave rings. Long
                            -- lives so the cloud keeps evolving behind the win.
                            local gx2, gz2 = G.x, G.z
                            local gy2 = groundH(gx2, gz2)
                            local ox2, oz2 = gx2 - self.tx, gz2 - self.tz
                            if #self.chunks > 0 then
                                for _ = 1, 6 do puff(self, 1, 1500, 500, 1.4, gy2 + 2000, ox2, oz2) end
                                for _ = 1, 60 do puff(self, 0, 4500, 1750, 3.0, gy2 + 1500, ox2, oz2) end
                                for _ = 1, 40 do puff(self, 2, 1750, 3000, 7.0, gy2 + 1000, ox2, oz2) end
                                for _ = 1, 30 do puff(self, 5, 6000, 1250, 8.0, gy2 + 4000, ox2, oz2) end
                                for _ = 1, 30 do puff(self, 4, 6000, 2000, 2.0, gy2 + 1500, ox2, oz2) end
                                for s = 1, 8 do puff(self, 6, 1000, 0, 0.9 + s * 0.25, gy2 + 300, ox2, oz2) end
                            end
                            playSfx(self, "crash", 1.0)
                            playSfx(self, "crash", 1.0) -- overlapping = heavier blast
                            setAny(self, "l3nukeT", 2.5) -- camera kick, decays in advance
                            -- Stage the shader fireball: 8 billboards around
                            -- the body, animated purely by u.time in nuke.wgsl
                            -- (zero per-frame CPU). Flash + fireball + stem +
                            -- cap + 2 staggered shocks + lingering smoke x2.
                            if self.nukeCpu ~= nil and self.nukeVbo ~= nil then
                                local nb = self.nukeCpu :: buffer
                                local no = 0
                                local bt = self.time
                                no = buildNukeQuad(nb, no, gx2, gy2 + 4000, gz2, 0, 6000, 8000, 8000, 0.13, bt)
                                no = buildNukeQuad(nb, no, gx2, gy2 + 3500, gz2, 1, 7500, 9500, 9500, 0.47, bt)
                                no = buildNukeQuad(nb, no, gx2, gy2 + 1000, gz2, 2, 4500, 4500, 11000, 0.71, bt)
                                no = buildNukeQuad(nb, no, gx2, gy2 + 11000, gz2, 3, 5500, 12000, 5500, 0.29, bt)
                                no = buildNukeQuad(nb, no, gx2, gy2 + 1000, gz2, 4, 15000, 15000, 15000, 0.53, bt)
                                no = buildNukeQuad(nb, no, gx2, gy2 + 1000, gz2, 4, 15000, 15000, 15000, 0.89, bt + 0.35)
                                no = buildNukeQuad(nb, no, gx2, gy2 + 7500, gz2, 5, 11000, 11000, 11000, 0.37, bt)
                                no = buildNukeQuad(nb, no, gx2, gy2 + 13000, gz2, 5, 13000, 13000, 8000, 0.63, bt + 0.8)
                                ;(self.nukeVbo :: GPUBuffer):write(nb);
                                setAny(self, "l3nukeBirth", bt)
                            end
                            setAny(self, "l3phase", "won") -- GIGA falls: YOU WIN, no prime ever rises
                            setAny(self, "l3gigaDown", true)
                            gigaWin(self) -- full LEVEL 3 victory show (cubes, unlocks, win lap)
                        end
                    elseif G.rise < 1 then
                        -- 1 RISE: out of the crater
                        G.rise = math.min(1, G.rise + seconds / 3.0)
                        G.anim = "rise"
                    else
                        -- the brain: read the plane, then pick a move
                        local bdx, bdz = self.tx - G.x, self.tz - G.z
                        local dist = math.sqrt(bdx * bdx + bdz * bdz)
                        local bfwd = (self :: any).fwd or 0
                        local jvx = math.sin(self.yaw) * bfwd
                        local jvz = math.cos(self.yaw) * bfwd
                        local jetAlt = self.hy or 0
                        -- 10 ENRAGE: half health, once — faster, angrier, red eyes
                        if not G.enraged and (G.hp or GIANT_HP) < GIANT_HP * 0.5 then
                            G.enraged = true
                            G.roarT = 1.2
                            if self.msg ~= nil then self.msg.value = "GIGA ENRAGED - ITS EYES BURN RED!" end
                            playSfx(self, "crash", 1.0)
                        end
                        local spdK = 1.0
                        if G.enraged then spdK = 1.4 end
                        local cdMax = 1.0
                        if G.enraged then cdMax = 0.7 end
                        local windMax = 0.75
                        if G.enraged then windMax = 0.6 end
                        G.swpT = math.max(0, (G.swpT or 0) - seconds)
                        if (G.roarT or 0) > 0 then
                            G.roarT = (G.roarT or 0) - seconds
                            G.anim = "enrage"
                        elseif (G.windT or 0) > 0 then
                            -- telegraphed strike: dodge NOW, it lands on release.
                            -- The body tracks the jet through the swing (faster
                            -- on the iconic slam) so fast jets can't just
                            -- outwalk the windup and every slam threatens.
                            G.windT = (G.windT or 0) - seconds
                            G.anim = G.windAnim or "windR"
                            do
                                local tdx, tdz = self.tx - G.x, self.tz - G.z
                                local tl = math.sqrt(tdx * tdx + tdz * tdz)
                                if tl > 1.0 then
                                    local tsp = 3600.0
                                    if G.iconSlam then tsp = 7500.0 end
                                    local tst = math.min(tsp * seconds, tl)
                                    G.x += tdx / tl * tst
                                    G.z += tdz / tl * tst
                                end
                            end
                            if (G.windT or 0) <= 0 then
                                local reach = 2000.0
                                if G.windKind == "kick" then reach = 2120.0 end
                                local exx, ezz = self.tx - G.x, self.tz - G.z
                                -- fist-impact FX: the hand hits the dirt EVERY
                                -- slam (whiff or not) — dust + shock ring at
                                -- the fist + a deep boom. This sells the hit.
                                if #self.chunks > 0 then
                                    local fxx, fzz = G.x, G.z
                                    if G.windKind == "left" or G.windKind == "right" then
                                        local sdd = -1
                                        if G.windKind == "right" then sdd = 1 end
                                        local fvx, fvz = G.faceX or 0, G.faceZ or -1
                                        fxx = G.x + fvx * 1350.0 + (-fvz) * 1350.0 * sdd
                                        fzz = G.z + fvz * 1350.0 + (fvx) * 1350.0 * sdd
                                    end
                                    local fgy = groundH(fxx, fzz)
                                    puff(self, 5, 120, 30, 1.8, fgy + 60, fxx - self.tx, fzz - self.tz)
                                    puff(self, 6, 60, 0, 1.0, fgy + 40, fxx - self.tx, fzz - self.tz)
                                    playSfx(self, "crash", 0.5)
                                end
                                if math.sqrt(exx * exx + ezz * ezz) < reach then
                                    -- hands 40 flat, iconic slam 60 flat (both exempt from L3_ZDMG: this is the boss)
                                    local iconicHit = G.iconSlam or false
                                    if iconicHit then self.hp -= 60 else self.hp -= 40 end
                                    if self.health ~= nil then self.health.value = math.max(0, self.hp) end
                                    setAny(self, "hitFlash", 1.0)
                                    setAny(self, "gigaGlow", 1.0) -- the hull burns where the hand lands
                                    -- struck like a ball: flung away from the
                                    -- fist, popped skyward, tumbling end over
                                    -- end with the camera rattling. Damage up
                                    -- top, physics down here — same punch.
                                    -- The iconic slam hits even harder: longer
                                    -- fling, deeper disbalance, bigger shake.
                                    do
                                        local kl = math.sqrt(exx * exx + ezz * ezz)
                                        if kl < 0.001 then kl = 0.001 end
                                        local fling = 22000.0 -- one hand = one long ride
                                        if iconicHit then fling = 30000.0 end
                                        setAny(self, "kbx", exx / kl * fling)
                                        setAny(self, "kbz", ezz / kl * fling)
                                        if iconicHit then setAny(self, "kby", 1200.0)
                                        else setAny(self, "kby", 900.0) end
                                        if iconicHit then setAny(self, "tumble", 6.0)
                                        else setAny(self, "tumble", 4.5) end
                                        setAny(self, "tumbleSpin", 12.0 * (G.side or 1))
                                        if iconicHit then setAny(self, "shakeT", 5.0)
                                        else setAny(self, "shakeT", 4.0) end
                                    end
                                    if #self.chunks > 0 then
                                        puff(self, 4, 60, 60, 0.7, gyG + 100, 0, 0)
                                        puff(self, 5, 120, 20, 1.6, gyG + 50, 0, 0)
                                        if G.windKind == "kick" then puff(self, 6, 60, 0, 1.0, gyG + 40, 0, 0) end
                                    end
                                    playSfx(self, "crash", 0.8)
                                    if self.hp <= 0 then
                                        downJet(self)
                                    elseif self.msg ~= nil then
                                        if G.windKind == "kick" then
                                            self.msg.value = "KICKED! HP " .. math.max(0, self.hp)
                                        elseif iconicHit then
                                            self.msg.value = "CRUSHED! HP " .. math.max(0, self.hp)
                                        else
                                            self.msg.value = "SMASHED! HP " .. math.max(0, self.hp)
                                        end
                                    end
                                elseif self.msg ~= nil then
                                    self.msg.value = "WHIFFED - KEEP MOVING!"
                                end
                                -- the iconic move is spent once the slam lands
                                G.iconSlam = false
                                G.iconT = 15.0
                                G.swpT = cdMax
                                G.recT = 0.4
                                G.recMax = 0.4
                                G.anim = "recover"
                            end
                        elseif (G.recT or 0) > 0 then
                            G.recT = (G.recT or 0) - seconds
                            G.anim = "recover"
                        elseif dist < 1750.0 and G.swpT <= 0
                            or (G.iconDash or 0) > 0 and dist < 1500.0 and G.swpT <= 0 then
                            -- in reach: low jet eats a KICK, else alternate hands.
                            -- Arriving on an iconic dash: 0.35s telegraph, the
                            -- slam that follows is the crushing one. The dash
                            -- hands off early (1500u) so the swing meets you.
                            local iconic = (G.iconDash or 0) > 0
                            if jetAlt < 150 then
                                G.windKind = "kick"
                                G.windAnim = "windKick"
                            else
                                G.side = -1 * (G.side or 1)
                                if (G.side or 1) < 0 then
                                    G.windKind = "left"
                                    G.windAnim = "windL"
                                else
                                    G.windKind = "right"
                                    G.windAnim = "windR"
                                end
                            end
                            if iconic then
                                G.windT = 0.35
                                G.windMax = 0.35
                                G.iconDash = 0
                                G.iconSlam = true
                            else
                                G.windT = windMax
                                G.windMax = windMax
                            end
                            G.anim = G.windAnim or "windR"
                        else
                            -- locomotion: stamina-capped. 3s of continuous
                            -- hunting winds it — then it plants its feet and
                            -- pants for 1.5s (free hits) before going again.
                            if (G.restT or 0) > 0 and (G.iconDash or 0) <= 0 then
                                G.restT = (G.restT or 0) - seconds
                                G.anim = "rest"
                            else
                            -- ICONIC MOVE: every 15s, no matter how far the
                            -- plane is, it blurs across the gap and crushes.
                            G.iconT = (G.iconT or 15.0) - seconds
                            if (G.iconDash or 0) <= 0 and (G.iconT or 0) <= 0 then
                                G.iconDash = 3.0
                                G.restT = 0
                                G.stam = 0
                                G.iconT = 15.0
                                if self.msg ~= nil then self.msg.value = "ICONIC RAGE - NOWHERE TO HIDE!" end
                                playSfx(self, "crash", 1.0)
                            end
                            -- chase: intercept far, pure pursuit near; camp
                            -- sprint mid-range, HUNT sprint past 6000u.
                            if dist > 4000.0 then
                                G.campT = (G.campT or 0) + seconds
                            else
                                G.campT = 0
                            end
                            if dist > 6000.0 and not (G.hunt or false) then
                                G.hunt = true
                                if self.msg ~= nil then self.msg.value = "IT'S COMING FOR YOU - RUN!" end
                            elseif dist < 1500.0 then
                                G.hunt = false
                            end
                            local chase = 2250.0 -- slow hunter: walks you down
                            G.anim = "walk"
                            if dist > 3000.0 then
                                chase = 3600.0
                                G.anim = "run"
                            end
                            if (G.campT or 0) > 5.0 then
                                chase = 4800.0
                                G.anim = "sprint"
                            end
                            if G.hunt then
                                chase = 7200.0 -- outruns a fleeing jet, on foot
                                G.anim = "sprint"
                            end
                            chase *= spdK
                            -- iconic dash: 50x feet, any distance, sprint pose
                            if (G.iconDash or 0) > 0 then
                                G.iconDash = (G.iconDash or 0) - seconds
                                chase = chase * 50.0
                                G.anim = "sprint"
                            end
                            -- lead fades up close (full intercept far, pure
                            -- pursuit near) so jinks don't swing it wide.
                            local eta = dist / math.max(chase, 1.0)
                            local leadK = math.clamp(dist / 3000.0, 0, 1) * 0.7
                            local px, pz = self.tx + jvx * eta * leadK, self.tz + jvz * eta * leadK
                            local mx2, mz2 = px - G.x, pz - G.z
                            local ml = math.sqrt(mx2 * mx2 + mz2 * mz2)
                            -- cornering: the sharper the turn off its current
                            -- facing, the slower the feet — hard left/right
                            -- jinks get tracked through the corner instead of
                            -- overshot past you at full pace.
                            local turnSlow = 1.0
                            if ml > 0.001 then
                                local ffx, ffz = G.faceX or 0, G.faceZ or -1
                                local cross = math.abs(ffx * (mz2 / ml) - ffz * (mx2 / ml))
                                turnSlow = 1.0 - math.min(cross * 1.2, 0.75)
                            end
                            if ml > 0.001 then
                                if dist > 1620.0 then
                                    local st = math.min(chase * turnSlow * seconds, dist - 1620.0)
                                    G.x += mx2 / ml * st
                                    G.z += mz2 / ml * st
                                else
                                    -- in your face: never plant feet — sidestep
                                    -- to hold ~450 and stay square, so direction
                                    -- changes stay tight and the hands stay on.
                                    local want = 1120.0
                                    local sgn = 1.0
                                    if dist < want then sgn = -1.0 end
                                    local st2 = math.min(4500.0 * turnSlow * seconds, math.abs(dist - want))
                                    G.x += mx2 / ml * st2 * sgn
                                    G.z += mz2 / ml * st2 * sgn
                                end
                            end
                            if G.x > WRAP then G.x -= WRAP * 2 elseif G.x < -WRAP then G.x += WRAP * 2 end
                            if G.z > WRAP then G.z -= WRAP * 2 elseif G.z < -WRAP then G.z += WRAP * 2 end
                            G.dustT = (G.dustT or 0) - seconds
                            if (G.dustT or 0) <= 0 and #self.chunks > 0 then
                                G.dustT = 0.3
                                puff(self, 5, 40, 30, 1.2, gyG + 30, G.x - self.tx, G.z - self.tz)
                            end
                            -- stamina: 3s hunting -> 1.5s panting breather.
                            -- Paused through the iconic dash: nothing
                            -- interrupts the rage once it starts.
                            if (G.iconDash or 0) <= 0 then
                                G.stam = (G.stam or 0) + seconds
                                if (G.stam or 0) >= 3.0 then
                                    G.stam = 0
                                    G.restT = 1.5
                                    G.anim = "rest"
                                    if self.msg ~= nil then self.msg.value = "IT'S WINDED - HIT IT NOW!" end
                                end
                            end
                            end
                        end
                    end
                end
            end
        end
    end
    -- Round-3 story: the patch has a king. MORGATHA hovers harmless
    -- until the briefing runs out, then goes live.
    do
        local r3 = (self :: any).r3intro
        if r3 ~= nil and r3 >= 0 and self.round == 3 and not self.crashed and not menuUp then
            local B = (self :: any).boss
            if B ~= nil and B.on and not B.live then
                local rt3 = ((self :: any).r3introT or 0) - seconds
                if rt3 <= 0 then
                    local nxt = r3 + 1
                    if self.msg ~= nil then
                        if (self :: any).level == 3 then
                            if nxt == 1 then self.msg.value = "THE STAFF IS BROKEN..."
                            elseif nxt == 2 then self.msg.value = "VOIDPUS PRIME - PURPLE PUMPKIN OCTOPUS, 1500 HEALTH!"
                            else self.msg.value = "DODGE HIS CHARGES AND FIREBALLS - AIM FOR THE EYES!" end
                        elseif nxt == 1 then self.msg.value = "ROUND 3: THE PATCH HAS A KING..."
                        elseif nxt == 2 then self.msg.value = "MORGATHA THE ROTTEN ONE - GROWN FROM PILOT BONES, 400 HEALTH!"
                        else self.msg.value = "DODGE HIS CHARGES AND FIREBALLS - SHOOT OUT THE GHOST EYES!" end
                    end
                    if nxt >= 3 then
                        setAny(self, "r3intro", -1)
                        B.live = true
                        B.atkT = 2.0
                        B.chgT = 6.0
                    else
                        setAny(self, "r3intro", nxt)
                        ;(self :: any).r3introT = 4.0
                    end
                else
                    setAny(self, "r3introT", rt3)
                end
            else
                setAny(self, "r3intro", -1)
            end
        end
    end
    -- Game-over panel: level 3 fails as ROUND FAILED along the bottom
    -- with REMATCH; anywhere else it's the centered YOU CRASHED + RETRY.
    -- (Per-frame: the level can change without a resize. Strings ride new
    -- overTitle/overRetry props; the hit test reads overBX/RY/HY below.)
    if self.crashed and self.overA ~= nil and self.overA.value > 0 then
        local w, h = self.cw, self.ch
        if (self :: any).level == 3 then
            if self.overTitle ~= nil then self.overTitle.value = "ROUND FAILED" end
            if self.overRetry ~= nil then self.overRetry.value = "REMATCH" end
            if self.overTitleX ~= nil then self.overTitleX.value = (w - 800) / 2 end
            if self.overTitleY ~= nil then self.overTitleY.value = h - 640 end
            -- side by side: 130-wide buttons, 30px gap, one row with a
            -- clear gap under the text.
            local rX, btnY = (w - 290) / 2, h - 420
            if self.overBtnX ~= nil then self.overBtnX.value = rX end
            if self.overHomeX ~= nil then self.overHomeX.value = rX + 160 end
            if self.overRetryY ~= nil then self.overRetryY.value = btnY end
            if self.overHomeY ~= nil then self.overHomeY.value = btnY end
            self.overBX, self.overHX, self.overRY, self.overHY = rX, rX + 160, btnY, btnY
        else
            if self.overTitle ~= nil then self.overTitle.value = "YOU CRASHED" end
            if self.overRetry ~= nil then self.overRetry.value = "RETRY" end
            if self.overTitleX ~= nil then self.overTitleX.value = (w - 800) / 2 end
            if self.overTitleY ~= nil then self.overTitleY.value = h / 2 - 118 end
            if self.overBtnX ~= nil then self.overBtnX.value = (w - 130) / 2 end
            if self.overHomeX ~= nil then self.overHomeX.value = (w - 130) / 2 end
            if self.overRetryY ~= nil then self.overRetryY.value = h / 2 + 30 end
            if self.overHomeY ~= nil then self.overHomeY.value = h / 2 + 90 end
            self.overBX, self.overHX, self.overRY, self.overHY = (w - 130) / 2, (w - 130) / 2, h / 2 + 30, h / 2 + 90
        end
    end
    -- Victory overlay: staged level-1-complete show on top of everything.
    -- t0-2.6 big CONGRATULATIONS; 2.6-4.4 LEVEL 1 slides left while LEVEL 2
    -- GIGA VICTORY page: nothing but the word. VICTORY drops from
    -- above with an overshoot pop, BOOMS on landing (flash + shake +
    -- boom sfx), floats gently, then CONTINUE fades in. Reuses the
    -- dim / flash / continue props of the cube show (idle over there).
    do
        local vct = (self :: any).vicT
        if vct ~= nil and vct >= 0 then
            vct += seconds
            ;(self :: any).vicT = vct
            local cx = self.cw / 2
            local rowY = self.ch / 2 + 10
            local tx = cx - 400
            local restY = self.ch / 2 - 150
            local pop = easeOutBack(math.min(vct / 0.7, 1))
            local ty = restY - (restY + 220) * (1 - pop)
            ty += math.sin((vct - 0.7) * 2.2) * 4 * sstep(1.0, 1.8, vct)
            if self.vicTitleA ~= nil then self.vicTitleA.value = math.min(1, vct / 0.25) * (0.86 + 0.14 * math.sin(vct * 33.0)) end
            if self.vicTitleY ~= nil then self.vicTitleY.value = ty end
            if self.vitTitleX ~= nil then self.vitTitleX.value = tx end
            if self.vitEdgeL ~= nil then self.vitEdgeL.value = tx - 4 end
            if self.vitEdgeR ~= nil then self.vitEdgeR.value = tx + 4 end
            if self.vitEdgeT ~= nil then self.vitEdgeT.value = ty - 4 end
            if self.vitEdgeB ~= nil then self.vitEdgeB.value = ty + 4 end
            if self.vitA ~= nil then self.vitA.value = math.min(1, vct / 0.5) end
            if self.vitL1A ~= nil then self.vitL1A.value = 0 end -- the old LEVEL box stays buried
            if vct >= 0.7 and not ((self :: any).vicBoom or false) then
                setAny(self, "vicBoom", true)
                playSfx(self, "crash", 1.0)
                if self.vitFlash ~= nil then self.vitFlash.value = 1 end
                setAny(self, "shakeT", 0.8)
            end
            if self.vitFlash ~= nil and ((self :: any).vicBoom or false) then
                self.vitFlash.value = math.max(0, 1 - (vct - 0.7) / 0.6)
            end
            -- CONTINUE only: same button + hit box as the cube show.
            if self.vitContX ~= nil then self.vitContX.value = cx - 130 end
            if self.vitContY ~= nil then self.vitContY.value = rowY + 176 end
            self.vitContBX, self.vitContBY = cx - 130, rowY + 176
            if self.vitContA ~= nil then
                local ca = sstep(1.8, 2.4, vct)
                self.vitContA.value = ca * (0.82 + 0.18 * math.sin(vct * 4.5))
            end
        end
    end
    -- slides in; 4.4-5.6 lock shakes then bursts (flash + boom); 5.6+
    -- CONTINUE fades in and waits (home opens only on click).
    do
        local vt = (self :: any).vitT
        if vt ~= nil and vt >= 0 then
            vt += seconds
            ;(self :: any).vitT = vt
            local cx = self.cw / 2
            local rowY = self.ch / 2 + 10
            local l1Rest, l2Rest = cx - 200, cx + 50
            local l1Start, l2Start = cx - 50, cx + 320
            if self.vitContX ~= nil then self.vitContX.value = cx - 130 end
            if self.vitContY ~= nil then self.vitContY.value = rowY + 176 end
            if self.vitRowY ~= nil then self.vitRowY.value = rowY end
            local tx = cx - 400
            if self.vitTitleX ~= nil then self.vitTitleX.value = tx end
            if self.vitUnlockY ~= nil then self.vitUnlockY.value = rowY + 66 end
            if self.vitEdgeL ~= nil then self.vitEdgeL.value = tx - 3 end
            if self.vitEdgeR ~= nil then self.vitEdgeR.value = tx + 3 end
            self.vitContBX, self.vitContBY = cx - 130, rowY + 176
            if self.vitA ~= nil then self.vitA.value = math.min(1, vt / 0.5) end
            if self.vitL1A ~= nil then self.vitL1A.value = math.min(1, vt / 0.5) end
            if self.vitTitleA ~= nil then self.vitTitleA.value = math.min(1, vt / 0.4) * (0.86 + 0.14 * math.sin(vt * 31.0)) end
            if self.vitSubA ~= nil then self.vitSubA.value = math.min(1, math.max(0, vt - 0.3) / 0.5) end
            do
                -- Title drops in with an overshoot pop, then floats gently.
                local pop = easeOutBack(math.min(vt / 0.55, 1))
                local ty = self.ch / 2 - 210 + 40 * (1 - pop)
                ty += math.sin((vt - 0.55) * 2.4) * 3 * sstep(0.8, 1.6, vt)
                if self.vitTitleY ~= nil then self.vitTitleY.value = ty end
                if self.vitEdgeT ~= nil then self.vitEdgeT.value = ty - 3 end
                if self.vitEdgeB ~= nil then self.vitEdgeB.value = ty + 3 end
                -- Sub rides 44px lower: 2x the old gap below the title.
                if self.vitSubY ~= nil then self.vitSubY.value = ty + 44 end
            end
            -- Cubes: hidden until t2.6, then slam to rest with overshoot.
            local slide = easeOutBack(sstep(2.6, 4.2, vt))
            local l1x = l1Start + (l1Rest - l1Start) * slide
            local l2x = l2Start + (l2Rest - l2Start) * slide
            if self.vitL1X ~= nil then self.vitL1X.value = l1x end
            if self.vitL2X ~= nil then self.vitL2X.value = l2x end
            if self.vitL2A ~= nil then self.vitL2A.value = sstep(5.6, 6.2, vt) end
            -- Outer design frame tracks the LEVEL 2 cube with a 6px margin.
            if self.vitL2FX ~= nil then self.vitL2FX.value = l2x - 6 end
            if self.vitL2FY ~= nil then self.vitL2FY.value = rowY - 6 end
            -- Dot trail: 5 gold dots stream from LEVEL 1 to LEVEL 2 across
            -- the gap on a loop, fading in with the slide.
            if self.vitDotY ~= nil then self.vitDotY.value = rowY + 17 end
            if self.vitDotX ~= nil then
                local gx0, gx1 = l1x + 150, l2x
                for i = 1, 5 do
                    local px = self.vitDotX[i]
                    if px ~= nil then
                        if vt < 2.6 then
                            px.value = -100
                        else
                            local f = ((vt - 2.6) * 0.45 + (i - 1) / 5) % 1
                            px.value = gx0 + f * (gx1 - gx0)
                        end
                    end
                end
            end
            -- Lock flies in FIRST (2.6-3.0) and bursts at 5.6; the LEVEL 2
            -- box + text fade in only after the blast (5.6-6.2 via vitL2A).
            local shaking = vt >= 4.4 and vt < 5.6
            local lockA = sstep(2.6, 3.0, vt)
            if (self :: any).vitBroke then lockA = 0 end
            if self.vitLockA ~= nil then self.vitLockA.value = lockA end
            if self.vitLockX ~= nil then
                local lx = l2x + 65
                if shaking then lx += math.sin(vt * 55) * 7 end
                self.vitLockX.value = lx
            end
            if self.vitLockY ~= nil then
                local ly = rowY + 24
                if shaking then ly += math.cos(vt * 47) * 4 end
                self.vitLockY.value = ly
            end
            if shaking and not ((self :: any).vitShake or false) then
                setAny(self, "vitShake", true)
                playSfx(self, "click")
            end
            if vt >= 5.6 and not ((self :: any).vitBroke or false) then
                setAny(self, "vitBroke", true)
                playSfx(self, "crash", 0.7)
                tapFlash(self, l2Rest + 75, rowY + 29)
                if self.vitFlash ~= nil then self.vitFlash.value = 1 end
            end
            if self.vitFlash ~= nil and ((self :: any).vitBroke or false) then
                self.vitFlash.value = math.max(0, 1 - (vt - 5.6) / 0.6)
            end
            if self.vitL2Lit ~= nil then
                self.vitL2Lit.value = ((self :: any).vitBroke or false) and 1 or 0
            end
            if self.vitContA ~= nil then
                -- Beckoning pulse once visible.
                local ca = sstep(6.4, 7.1, vt)
                self.vitContA.value = ca * (0.82 + 0.18 * math.sin(vt * 4.5))
            end
            -- Burst sparks: 8 embers arc out of the lock burst with gravity,
            -- fading over ~1.4s. Pure function of show time, no storage.
            do
                local st = vt - 5.6
                local sa = 0
                if ((self :: any).vitBroke or false) and st >= 0 then
                    sa = math.max(0, 1 - st / 1.4)
                end
                if self.vitSparkA ~= nil then self.vitSparkA.value = sa end
                if self.vitSparkX ~= nil and self.vitSparkY ~= nil then
                    local ox, oy = l2Rest + 75, rowY + 29
                    for i = 1, 8 do
                        local px, py = self.vitSparkX[i], self.vitSparkY[i]
                        if px ~= nil and py ~= nil then
                            if st < 0 then
                                px.value, py.value = -100, -100
                            else
                                local ang = (i - 1) / 8 * math.pi * 2 + 0.4
                                local spd2 = 150 + ((i * 53) % 70)
                                local vx, vy = math.cos(ang) * spd2, math.sin(ang) * spd2 - 120
                                px.value = ox + vx * st
                                py.value = oy + vy * st + 260 * st * st
                            end
                        end
                    end
                end
            end
            -- Pumpkin confetti: 10 pumpkin faces pop out of the lock
            -- burst and arc outward, fading over ~1.8s. Pure function of
            -- show time, no storage.
            do
                local st = vt - 5.6
                local ca = 0
                if ((self :: any).vitBroke or false) and st >= 0 then
                    ca = math.max(0, 1 - st / 1.8)
                end
                if self.vitConfA ~= nil then self.vitConfA.value = ca end
                if self.vitConfX ~= nil and self.vitConfY ~= nil then
                    local ox, oy = l2Rest + 75, rowY + 29
                    for i = 1, 10 do
                        local px, py = self.vitConfX[i], self.vitConfY[i]
                        if px ~= nil and py ~= nil then
                            if st < 0 then
                                px.value, py.value = -100, -100
                            else
                                local ang = (i - 1) / 10 * math.pi * 2 + 0.2
                                local spd3 = 170 + ((i * 67) % 130)
                                local vx, vy = math.cos(ang) * spd3, math.sin(ang) * spd3 - 160
                                px.value = ox + vx * st
                                py.value = oy + vy * st + 300 * st * st
                            end
                        end
                    end
                end
            end
        end
    end
    -- Level 2 lock: follows the menu fade, shakes + bursts live after the
    -- Morgatha kill, then stays gone once unlocked. Green spills onto
    -- cube 2 and a banner calls out each beat.
    do
        local open2 = (self :: any).lvl2open or false
        local open3 = (self :: any).lvl3open or false
        local ba = (self.btnA ~= nil) and self.btnA.value or 0
        -- NOTE: the unlock banner show (unlockT >= 0) is deleted: nothing
        -- ever arms it, so it only burned type budget. Locks below are live.
        if self.lvlLock2 ~= nil then
            self.lvlLock2.value = open2 and 0 or ba
        end
        -- Level 3 lock: gone once the circus falls, follows the menu fade.
        if self.lvlLock3 ~= nil then
            self.lvlLock3.value = ((self :: any).lvl3open or false) and 0 or ba
        end
        -- Purple pumpkin trophy on cube 3, same fade as its lock.
        if self.pk3A ~= nil then
            self.pk3A.value = ((self :: any).lvl3open or false) and ba or 0
        end
        -- Green light spills onto cube 2 once the lock is gone.
        -- (The overlay rides lvlX2/lvlY via binds; only opacity is driven.)
        if self.unlockLit ~= nil then
            self.unlockLit.value = open2 and ba or 0
        end
        -- Orange pumpkin on cube 2 while level 2 is open (stays: purple lives on cube 3 only).
        if self.pump2A ~= nil then
            self.pump2A.value = open2 and ba or 0
        end
        -- Completion pumpkin: cube 3 purple once level 3 UNLOCKS (L2 beaten).
        -- Cube 1 keeps its book badge always; cube 2 keeps its orange.
        setVal(self, "pk3DoneA", open3 and ba or 0)
        setVal(self, "bookA", ba)
    end
    -- Browser save bridge: adopt flags restored by the embedding page
    -- (progress only ratchets up; sound follows both ways).
    do
        if self.svLvl2 ~= nil and self.svLvl2.value and not ((self :: any).lvl2open or false) then
            (self :: any).lvl2open = true
            syncSave(self)
        end
        if self.svLvl3 ~= nil and self.svLvl3.value and not ((self :: any).lvl3open or false) then
            (self :: any).lvl3open = true
            syncSave(self)
        end
        if (self :: any).svDone ~= nil and (self :: any).svDone.value and not ((self :: any).lvl3done or false) then
            (self :: any).lvl3done = true
            syncSave(self)
        end
        if self.svTut ~= nil and self.svTut.value and not ((self :: any).tutMaster or false) then
            (self :: any).tutMaster = true
            syncSave(self)
        end
        if self.svSnd ~= nil and self.svSnd.value ~= self.soundOn then
            self.soundOn = self.svSnd.value
            syncMenu(self)
            syncSave(self)
        end
    end
    -- Gun select: 1/2/3/4 direct, G cycles (wheel scroll has no hook in
    -- the Rive runtime: no script, listener, or schema type exposes it).
    local gun = (self :: any).gun or 1
    if not self.crashed and not menuUp then
        local gDown = held(self, 71, 103)
        local gPrev = (self :: any).gPrev or false
        if gDown and not gPrev then gun = (gun + 1) % 4 + 1 end -- scroll-up order: Seeker > Giga > Hammer > Inferno
        (self :: any).gPrev = gDown
        if held(self, 49, 1) and gun ~= 1 then gun = 1
        elseif held(self, 50, 2) and gun ~= 2 then gun = 2
        elseif held(self, 51, 3) and gun ~= 3 then gun = 3
        elseif held(self, 52, 4) and gun ~= 4 then gun = 4 end
        if gun ~= ((self :: any).gun or 1) then
            (self :: any).gun = gun
            if self.gunHL ~= nil then self.gunHL.value = "> " .. GUN_NAMES[gun] .. " <" end
            ;(self :: any).gunShowT = 2.5 -- pop the bar up, then hide
            playSfx(self, "click")
        end
    end
    self.beamCd -= seconds
    if jDown and not self.crashed and not menuUp and not self.grounded and self.beamCd <= 0 then
        self.beamCd = GUN_CD[gun]
        -- First shootout shot hides DONT THINK (one ammo is enough).
        if (self :: any).level == 3 and (self :: any).l3phase == "staff"
            and not ((self :: any).l3shotHid or false) then
            setAny(self, "l3shotHid", true)
            if self.tutA ~= nil then self.tutA.value = 0 end
        end
        -- Guns fire from the nose cannon to the crosshair: spawn at the
        -- muzzle brake ring (4.5u ahead along yaw), direction runs
        -- muzzle -> true aim point on the camera ray (raycast to the
        -- dunes, far point for sky). Fast short nails, always from the
        -- plane tip to whatever the pointer covers.
        local gyS = groundH(self.tx, self.tz)
        local sback = self.radius
        local ex = self.tx - math.sin(self.camYaw) * sback
        local ey = gyS + self.hy + self.height
        local ez = self.tz - math.cos(self.camYaw) * sback
        local cx = self.tx + math.sin(self.camYaw) * 4.0
        local cy = gyS + self.hy + self.lookH
        local cz = self.tz + math.cos(self.camYaw) * 4.0
        local nfx, nfz = math.sin(self.yaw), math.cos(self.yaw)
        local spx = self.tx + nfx * 4.5
        local spy = gyS + self.hy - 3.0 -- belly guns: all 4 fire from under the fuselage
        local spz = self.tz + nfz * 4.5
        local sdx, sdy, sdz = cx - ex, cy - ey, cz - ez
        local slen = math.sqrt(sdx * sdx + sdy * sdy + sdz * sdz)
        if slen < 0.001 then slen = 0.001 end
        local rdx, rdy, rdz = sdx / slen, sdy / slen, sdz / slen
        local apx = ex + rdx * 600.0
        local apy = ey + rdy * 600.0
        local apz = ez + rdz * 600.0
        if rdy < -0.001 then -- march the ray to the dunes: exact crosshair hit
            local t = 12.0
            while t < 2500.0 do
                if ey + rdy * t <= groundH(ex + rdx * t, ez + rdz * t) + 2.0 then break end
                t += 12.0
            end
            if t < 2500.0 then
                local t0 = math.max(0.0, t - 12.0)
                t = t0
                while t < t0 + 12.0 do
                    if ey + rdy * t <= groundH(ex + rdx * t, ez + rdz * t) + 2.0 then break end
                    t += 1.0
                end
                apx, apy, apz = ex + rdx * t, ey + rdy * t, ez + rdz * t
            end
        end
        local dirx, diry, dirz = apx - spx, apy - spy, apz - spz
        local dlen = math.sqrt(dirx * dirx + diry * diry + dirz * dirz)
        if dlen < 0.001 then dlen = 0.001 end
        dirx, diry, dirz = dirx / dlen, diry / dlen, dirz / dlen
        local hspd = (BEAM_SPEED + fwdS) * GUN_SPD[gun]
        local rx, rz = math.cos(self.camYaw), -math.sin(self.camYaw)
        -- Bolts inherit jet speed so they always outrun a Q boost.
        local function fire(px: number, py: number, pz: number, dx: number, dy: number, dz: number)
            local b = self.beams[self.beamIdx]
            self.beamIdx = self.beamIdx % BEAM_SLOTS + 1
            b.x, b.y, b.z = px, py, pz
            b.vx, b.vy, b.vz = dx * hspd, dy * hspd, dz * hspd
            b.life = GUN_LIFE[gun]
            b.gun = gun
            b.stretch = ({ 0.08, 0.5, 1.0 })[gun] -- ball ammo: length matches width per gun (giga = full straight laser)
            b.on = true
        end
        if gun == 2 then -- Hammer: 5-pellet fan around the ray
            playSfx(self, "rifle") -- Hammer boom, throttled by its cooldown
            for k = -2, 2 do
                local off = k * 0.045
                fire(spx + rx * k * 0.5, spy, spz + rz * k * 0.5,
                    (dirx + rx * off) / 1.0, diry, (dirz + rz * off) / 1.0)
            end
        elseif gun == 4 then -- Seeker: homing missile off alternating rails
            local side = (self :: any).mslSide or 1
            ;(self :: any).mslSide = -side
            local wx, wz = math.cos(self.yaw), -math.sin(self.yaw)
            local mpx = spx + wx * 1.7 * side
            local mpz = spz + wz * 1.7 * side
            local lk, li = mslAcquire(self, dirx, diry, dirz)
            local m = self.msls[(self :: any).mslIdx or 1]
            ;(self :: any).mslIdx = ((self :: any).mslIdx or 1) % MSL_SLOTS + 1
            m.on = true
            m.x, m.y, m.z = mpx, spy, mpz
            local mspd = MSL_SPD0 + fwdS * 0.5
            m.spd = mspd
            m.vx, m.vy, m.vz = dirx * mspd, diry * mspd, dirz * mspd
            m.tkind, m.tidx = lk, li
            m.life = (lk > 0) and MSL_LIFE or MSL_DUMB_LIFE
            m.trailT = 0
            playSfx(self, "cannon") -- missile launch bark, throttled by its cooldown
            if self.msg ~= nil then
                if lk > 0 then self.msg.value = "SEEKER AWAY - LOCKED!"
                else self.msg.value = "SEEKER AWAY - NO LOCK, DUMB FIRE!" end
            end
        else -- Inferno + Giga Beam: single slug down the ray
            fire(spx, spy, spz, dirx, diry, dirz)
            if gun == 1 then
                playSfx(self, "smg") -- Inferno bark, throttled by its cooldown
                -- No muzzle smoke or fire: only the thin golden tracer leaves
                -- the cannon.
            elseif gun == 3 then
                playSfx(self, "cannon") -- Giga Beam blast, throttled by its cooldown
            end
        end
    end
    for _, b in ipairs(self.beams) do
        if b.on then
            local ppx, ppy, ppz = b.x, b.y, b.z
            b.x += b.vx * seconds
            b.y += b.vy * seconds
            b.z += b.vz * seconds
            b.life -= seconds
            -- Foe hits first (only once tutorials are done and foes are live).
            -- Level 1 pumpkins die on first bolt; level-3 staff takes
            -- GUN_DMG per bolt out of its hp pool, then waves advance.
            if b.on and ((self :: any).tutDone or false) then
                local dx, dy, dz = b.x - ppx, b.y - ppy, b.z - ppz
                local segLen2 = dx * dx + dy * dy + dz * dz
                if segLen2 < 0.001 then segLen2 = 0.001 end
                for tidx, f in ipairs(self.foes) do
                    if f.on then
                        local tt = ((f.x - ppx) * dx + (f.y - ppy) * dy + (f.z - ppz) * dz) / segLen2
                        if tt < 0 then tt = 0 elseif tt > 1 then tt = 1 end
                        local qx, qy, qz = ppx + dx * tt, ppy + dy * tt, ppz + dz * tt
                        local ex, ey, ez = f.x - qx, f.y - qy, f.z - qz
                        if ex * ex + ey * ey + ez * ez <= FOE_R * FOE_R then
                            b.on = false
                            local dead = true
                            if (self :: any).level == 3 and (f.kind or 0) > 0 or gateMode(self) and f.on then
                                f.hp -= GUN_DMG[b.gun or 1]
                                dead = f.hp <= 0
                                if not dead and self.msg ~= nil then
                                    self.msg.value = (FOE_NAMES[(f.kind or 1) + 1] or "MINION") .. " " .. math.max(0, f.hp) .. " HP!"
                                end
                            end
                            if dead then
                            f.on = false
                            self.kills += 1
                            -- Level 2 tunnel enemy: killing the guard opens
                            -- its stage (fly-through alone never passes it).
                            if gateMode(self) then
                                local gi = tunEnemyGate(tidx)
                                if gi ~= nil then tunEnemyDown(self, gi) end
                            end
                            if self.tutA ~= nil then self.tutA.value = 0 end -- hunt label served: first blood drawn
                            if #self.chunks > 0 then -- airburst on the kill
                                local iox, ioz = f.x - self.tx, f.z - self.tz
                                puff(self, 7, 6, 8, 0.6, f.y, iox, ioz)
                                puff(self, 4, 14, 20, 0.5, f.y, iox, ioz)
                                puff(self, 6, 10, 0, 0.9, f.y, iox, ioz)
                                puff(self, 0, 8, 10, 0.8, f.y, iox, ioz)
                            end
                            if (self :: any).level == 3 then
                                -- Rotten Court staff: wave 1 (3) then wave 2
                                -- (3) then PRIME himself stages ahead.
                                courtAdvance(self)
                            elseif gateMode(self) then
                                -- Tunnel guards + heads: tunEnemyDown above owns progress and messages; the L1 round-advance below must never fire here (it staged MORGATHA in the tunnel on the 5th kill, and his death showed LEVEL 1 >> LEVEL 2)
                            elseif self.round == 3 and self.kills >= FOE_N and ((self :: any).wave or 0) == 0 then
                                setAny(self, "wave", 1) -- pumpkins done: wave 1 rolls in
                                ;(self :: any).lvl2open = true -- level 1 clear: level 2 opens
                                ;(self :: any).waveT = WAVE_TIMES[1]
                                ;(self :: any).waveGap = 0
                                ;(self :: any).orbSpeed = WAVE_SPD[1]
                                ;(self :: any).lastTick = -1
                                if self.msg ~= nil then self.msg.value = "LEVEL 1 CLEAR - LEVEL 2 OPEN! Survive wave 1/3!" end
                            elseif self.msg ~= nil then
                                if self.kills >= FOE_N then
                                    self.msg.value = "ROUND 2 CLEAR!"
                                    if self.round == 1 then
                                        self.round = 3 -- the patch has a king: straight to MORGATHA
                                        self.hp = 100
                                        if self.health ~= nil then self.health.value = 100 end
                                        stageBoss(self)
                                        setAny(self, "r3intro", 0)
                                        ;(self :: any).r3introT = 2.5
                                    end
                                else
                                    self.msg.value = "ROUND 2: PUMPKINS " .. self.kills .. "/5 - test your aim!"
                                end
                            end
                            end
                            break
                        end
                    end
                end
            end
            -- Horde hits: bolts mow zombies (1 HP each) in shootout phases.
            -- Rotating 1000-sweep per bolt keeps 2000 clones affordable.
            -- Each bolt pierces up to 3 in a row so the 400-kill merge
            -- takes ~a minute of aimed fire, not several. Marched
            -- positions replicate the WGSL march exactly.
            do
                local phz = (self :: any).l3phase
                if b.on and (self :: any).level == 3 and not ((self :: any).armyHidden or false)
                    and (phz == "staff" or phz == "prime" or phz == "merge") then
                    local dead = (self :: any).armyDead or {}
                    local sw = (self :: any).zsweep or 1
                    local pierce = 0
                    for n = 0, 9999 do
                        local i = ((sw + n - 1) % N_ARMY) + 1
                        if not dead[i] then
                            local px, gy, pz = zombieLivePos(self, i)
                            local ex, ez = b.x - px, b.z - pz
                            if ex > -650.0 and ex < 650.0 and ez > -650.0 and ez < 650.0
                                and b.y > gy - 10.0 and b.y < gy + 325.0
                                and ex * ex + ez * ez <= 422500.0 then
                                dead[i] = true
                                ;(self :: any).armyDead = dead
                                ;(self :: any).l3zdead = ((self :: any).l3zdead or 0) + 1
                                buryZombie(self, i)
                                if #self.chunks > 0 then
                                    -- hit flash + death burst: fire, sparks,
                                    -- and a rotting smoke linger
                                    local iox, ioz = px - self.tx, pz - self.tz
                                    puff(self, 1, 20, 25, 0.4, gy + 185, iox, ioz)
                                    puff(self, 7, 50, 70, 0.6, gy + 150, iox, ioz)
                                    puff(self, 4, 60, 80, 0.5, gy + 185, iox, ioz)
                                    puff(self, 2, 40, 25, 2.2, gy + 165, iox, ioz)
                                end
                                -- kill trickle: every 50 kills patches 5 HP
                                if ((self :: any).l3zdead or 0) % 50 == 0 and self.hp < 100 then
                                    self.hp = math.min(100, self.hp + 5)
                                    if self.health ~= nil then self.health.value = math.max(0, self.hp) end
                                end
                                if ((self :: any).l3zdead or 0) >= L3_MERGE_NEED
                                    and ((self :: any).l3phase == "staff" or (self :: any).l3phase == "prime") then
                                    startMerge(self)
                                end
                                pierce += 1
                                if pierce >= 3 then
                                    b.on = false
                                    break
                                end
                            end
                        end
                    end
                    if pierce > 0 and pierce < 3 then b.on = false end
                    setAny(self, "zsweep", sw + 10000)
                end
            end
            -- Giant hits: torso sphere eats GUN_DMG per bolt.
            do
                if b.on and (self :: any).level == 3 and (self :: any).l3phase == "giant" then
                    local G: any = (self :: any).l3giant
                    if G ~= nil and (G.rise or 0) >= 1 then
                        local gyG = groundH(G.x, G.z)
                        local dx, dy, dz = b.x - ppx, b.y - ppy, b.z - ppz
                        local segLen2 = dx * dx + dy * dy + dz * dz
                        if segLen2 < 0.001 then segLen2 = 0.001 end
                        local tt = (((G.x - ppx) * dx + (gyG + 3560.0 - ppy) * dy + (G.z - ppz) * dz)) / segLen2
                        if tt < 0 then tt = 0 elseif tt > 1 then tt = 1 end
                        local qx, qy, qz = ppx + dx * tt, ppy + dy * tt, ppz + dz * tt
                        local ex, ey, ez = G.x - qx, (gyG + 3560.0) - qy, G.z - qz
                        if ex * ex + ey * ey + ez * ez <= 1500.0 * 1500.0 then
                            b.on = false
                            G.hp -= GUN_DMG[b.gun or 1]
                            G.flashT = 1.0 -- ammo hit: the whole body glows
                            if #self.chunks > 0 then
                                local iox, ioz = G.x - self.tx, G.z - self.tz
                                puff(self, 7, 60, 80, 0.6, gyG + 3500, iox, ioz)
                                puff(self, 4, 80, 100, 0.5, gyG + 3750, iox, ioz)
                            end
                            if G.hp <= 0 then
                                if #self.chunks > 0 then
                                    -- kill flash AT THE BODY (offsets: puff
                                    -- spawns at the jet without them, which
                                    -- read as the player blowing up).
                                    local kox, koz = G.x - self.tx, G.z - self.tz
                                    for _ = 1, 20 do puff(self, 0, 400, 200, 2.2, gyG + 800, kox, koz) end
                                    for _ = 1, 10 do puff(self, 1, 300, 120, 0.9, gyG + 1200, kox, koz) end
                                    for _ = 1, 4 do puff(self, 6, 100, 0, 1.2, gyG + 200, kox, koz) end
                                end
                                playSfx(self, "crash", 1.0)
                                for _, oo in ipairs((self :: any).orbs) do oo.on = false end
                                -- death cinema first: topple 2.5s, then the win show
                                G.deathT = 0
                                G.sink = 0
                                G.windT = 0
                                G.anim = "death"
                                setAny(self, "l3phase", "dying")
                                if self.msg ~= nil then self.msg.value = "GIGA FALLS..." end
                            elseif self.msg ~= nil then
                                self.msg.value = "GIGA " .. math.max(0, G.hp) .. "/" .. GIANT_HP
                            end
                        end
                    end
                end
            end
            -- The Rotten King takes bolt damage whenever he is up
            -- (including the intro briefing, before he goes live).
            local BB = (self :: any).boss
            if b.on and BB ~= nil and BB.on and self.round == 3 then                local dx, dy, dz = b.x - ppx, b.y - ppy, b.z - ppz
                local segLen2 = dx * dx + dy * dy + dz * dz
                if segLen2 < 0.001 then segLen2 = 0.001 end
                local tt = ((BB.x - ppx) * dx + (BB.y - ppy) * dy + (BB.z - ppz) * dz) / segLen2
                if tt < 0 then tt = 0 elseif tt > 1 then tt = 1 end
                local qx, qy, qz = ppx + dx * tt, ppy + dy * tt, ppz + dz * tt
                local ex, ey, ez = BB.x - qx, BB.y - qy, BB.z - qz
                if ex * ex + ey * ey + ez * ez <= BOSS_R * BOSS_R then
                    b.on = false
                    BB.hp -= GUN_DMG[b.gun or 1]
                    if #self.chunks > 0 then
                        local iox, ioz = BB.x - self.tx, BB.z - self.tz
                        puff(self, 7, 4, 6, 0.5, BB.y, iox, ioz)
                        puff(self, 4, 10, 14, 0.4, BB.y, iox, ioz)
                    end
                    if BB.hp <= 0 then
                        bossDie(self)
                    elseif self.msg ~= nil then
                        local bname = (BB.prime == true) and "VOIDPUS " or "MORGATHA "
                        self.msg.value = bname .. math.max(0, BB.hp) .. "/" .. (BB.max or BOSS_HP)
                    end
                end
            end
            -- Desert hit wins over expiry: bolts step ~33u/frame, so any
            -- bolt at or under the dunes (plus a step of grace) bursts.
            local gyB = groundH(b.x, b.z)
            if b.y <= gyB + 2.0 then
                b.on = false
                -- Impact bursts only far from the jet: tracers dying right
                -- off the cannon (low flight, downhill aim) retire silently
                -- so no fire or smoke ever sits on the plane's front.
                local idx, idz = b.x - self.tx, b.z - self.tz
                if idx * idx + idz * idz > 400.0 and #self.chunks > 0 then
                    local iox, ioz = b.x - self.tx, b.z - self.tz
                    puff(self, 7, 3, 6, 0.45, gyB, iox, ioz)
                    puff(self, 4, 10, 15, 0.4, gyB, iox, ioz)
                end
            elseif b.life <= 0 or math.abs(b.x) > WRAP - 100 or math.abs(b.z) > WRAP - 100 or b.y < -2 then
                b.on = false
            end
        end
    end
    -- Seeker missiles: steer toward the lock, fuse on proximity, burst
    -- on the ground or on expiry (dumb fire keeps re-acquiring, so a
    -- wrong-direction shot curves onto a target instead of wasting).
    for _, m in ipairs(self.msls) do
        if m.on then
            local ppx, ppy, ppz = m.x, m.y, m.z
            local vl = math.sqrt(m.vx * m.vx + m.vy * m.vy + m.vz * m.vz)
            if vl < 0.001 then vl = 0.001 end
            local cdx, cdy, cdz = m.vx / vl, m.vy / vl, m.vz / vl
            -- Dumb fire keeps looking: re-acquire off the missile's own
            -- nose every frame, so a shot fired the wrong way still
            -- bends onto the nearest live enemy and goes locked.
            if m.tkind == 0 then
                local nk, ni = mslAcquire(self, cdx, cdy, cdz)
                if nk > 0 then
                    m.tkind, m.tidx = nk, ni
                    m.life = math.max(m.life, MSL_LIFE * 0.8)
                    if self.msg ~= nil then self.msg.value = "SEEKER CURVED - LOCKED!" end
                end
            end
            local tpx, tpy, tpz, fuse, locked = mslTarget(self, m)
            if not locked and m.tkind ~= 0 then
                -- Lock died mid-flight: go dumb with a short fuse.
                m.tkind = 0
                m.life = math.min(m.life, 1.0)
            end
            if locked then
                local wx, wy, wz = tpx - m.x, tpy - m.y, tpz - m.z
                local wl = math.sqrt(wx * wx + wy * wy + wz * wz)
                if wl > 0.001 then
                    wx, wy, wz = wx / wl, wy / wl, wz / wl
                    -- Turn-limited steering: rotate the velocity dir toward
                    -- the target dir, capped at MSL_TURN rad/s, boosted
                    -- when the target sits behind the nose (U-turn mode)
                    -- so wrong-direction shots visibly bend around.
                    local dot = math.clamp(cdx * wx + cdy * wy + cdz * wz, -1, 1)
                    local ang = math.acos(dot)
                    local maxT = MSL_TURN * seconds
                    if dot < 0 then maxT *= MSL_UTURN_BOOST end
                    local ndx, ndy, ndz = wx, wy, wz
                    if ang > maxT and ang > 0.0001 then
                        local k = maxT / ang
                        ndx = cdx + (wx - cdx) * k
                        ndy = cdy + (wy - cdy) * k
                        ndz = cdz + (wz - cdz) * k
                        local nl = math.sqrt(ndx * ndx + ndy * ndy + ndz * ndz)
                        if nl < 0.001 then nl = 0.001 end
                        ndx, ndy, ndz = ndx / nl, ndy / nl, ndz / nl
                    elseif ang <= 0.0001 then
                        ndx, ndy, ndz = cdx, cdy, cdz
                    end
                    cdx, cdy, cdz = ndx, ndy, ndz
                end
            end
            -- Sprint only when roughly pointed at the lock: mid U-turn it
            -- holds launch speed so the bend stays tight instead of
            -- blowing wide open under thrust.
            do
                local want = MSL_SPD1
                if locked then
                    local wx2, wy2, wz2 = tpx - m.x, tpy - m.y, tpz - m.z
                    local wl2 = math.sqrt(wx2 * wx2 + wy2 * wy2 + wz2 * wz2)
                    if wl2 > 0.001 then
                        local dot2 = (cdx * wx2 + cdy * wy2 + cdz * wz2) / wl2
                        if dot2 < 0 then want = math.min(m.spd, MSL_SPD0 + 400.0) end
                    end
                end
                m.spd = math.min(want, m.spd + 3200.0 * seconds)
            end
            m.vx, m.vy, m.vz = cdx * m.spd, cdy * m.spd, cdz * m.spd
            m.x += m.vx * seconds
            m.y += m.vy * seconds
            m.z += m.vz * seconds
            m.life -= seconds
            -- Exhaust smoke trail, throttled so 6 missiles can't flood the pool.
            m.trailT -= seconds
            if m.trailT <= 0 and #self.chunks > 0 then
                m.trailT = 0.09
                local tox, toz = m.x - self.tx, m.z - self.tz
                puff(self, 2, 6, 8, 0.7, m.y, tox, toz)
            end
            -- Proximity fuse: swept segment vs the locked target's sphere
            -- (missiles step ~42u/frame: still sweep, never tunnel).
            local fused = false
            if locked then
                local dx, dy, dz = m.x - ppx, m.y - ppy, m.z - ppz
                local segLen2 = dx * dx + dy * dy + dz * dz
                if segLen2 < 0.001 then segLen2 = 0.001 end
                local tt = ((tpx - ppx) * dx + (tpy - ppy) * dy + (tpz - ppz) * dz) / segLen2
                if tt < 0 then tt = 0 elseif tt > 1 then tt = 1 end
                local qx, qy, qz = ppx + dx * tt, ppy + dy * tt, ppz + dz * tt
                local ex, ey, ez = tpx - qx, tpy - qy, tpz - qz
                if ex * ex + ey * ey + ez * ez <= fuse * fuse then fused = true end
            end
            local gyM = groundH(m.x, m.z)
            if fused then
                mslBoom(self, m)
            elseif m.y <= gyM + 2.0 then
                m.y = gyM + 2.0
                mslBoom(self, m)
            elseif m.life <= 0 or math.abs(m.x) > WRAP - 100 or math.abs(m.z) > WRAP - 100 then
                mslBoom(self, m)
            end
        end
    end
    -- Boss sky: the red/green grade rolls in for MORGATHA in level 1
    -- only. Level 3 burns ember (-0.55) while live: red sky over the
    -- storm run, the horde, and GIGA. (eases back on reset/death).
    do
        local lb = (self :: any).levelBlend or 0
        local tgt = (self.round == 3 and (self :: any).level ~= 3) and 1 or (((self :: any).level == 3 and (self.homeTarget or 0) <= 0) and -0.55 or 0)
        ;(self :: any).levelBlend = math.clamp(lb + math.clamp(tgt - lb, -0.4 * seconds, 0.4 * seconds), 0, 1)
        -- Damage-flash decay runs EVERY frame, un-gated: hitFlash is set
        -- by guns that work in every level (SEEKER own-blast included),
        -- and gating it inside flyingR2 stuck the plane white in level 1.
        ;(self :: any).hitFlash = math.max(0, ((self :: any).hitFlash or 0) - seconds * 1.0)
        ;(self :: any).gigaGlow = math.max(0, ((self :: any).gigaGlow or 0) - seconds * 0.9)
    end
    local flyingR2 = (self.round == 2 or self.round == 3) and not self.crashed and not self.grounded and (self.homeTarget or 0) <= 0
    if flyingR2 then
        local nfx, nfz = math.sin(self.yaw), math.cos(self.yaw)
        local gyJ = groundH(self.tx, self.tz) + self.hy + 1.8
        local ot = (self :: any).orbT - seconds
        local wv = (self :: any).wave or 0
        -- Round 3 fires only while a wave runs (pumpkin hunt + gaps stay quiet).
        local salvoUp = (self.round == 3 and wv >= 1 and wv <= 3 and (self :: any).waveGap <= 0)
            or (self.round == 2 and (self :: any).surviveT > 0)
        if salvoUp and ot <= 0 then -- salvo from ahead of the nose, led + scattered
            local ospd = (self :: any).orbSpeed or ORB_SPEED
            local base = 0.6
            if self.round == 3 then base = ({ 1.0, 0.7, 0.45 })[wv] or 0.45 end -- later waves rain harder
            ot = base + 0.6 * math.clamp((self :: any).surviveT / SURVIVE_TIME, 0, 1)
            local dist = 1400 + math.random() * 600
            local sx = self.tx + nfx * dist + (math.random() - 0.5) * 1000
            local sz = self.tz + nfz * dist + (math.random() - 0.5) * 1000
            local sy = gyJ + (math.random() - 0.5) * 400
            local fwd3 = (self :: any).fwd or 0
            local tti = dist / ospd
            local tx = self.tx + nfx * fwd3 * tti * 0.5 + (math.random() - 0.5) * 160
            local ty = gyJ + self.vy * tti * 0.5 + (math.random() - 0.5) * 120
            local tz = self.tz + nfz * fwd3 * tti * 0.5 + (math.random() - 0.5) * 160
            local dx, dy, dz = tx - sx, ty - sy, tz - sz
            local dl = math.sqrt(dx * dx + dy * dy + dz * dz)
            if dl < 0.001 then dl = 0.001 end
            for _, o in ipairs((self :: any).orbs) do
                if not o.on then
                    o.on = true
                    o.x, o.y, o.z = sx, sy, sz
                    o.vx, o.vy, o.vz = dx / dl * ospd, dy / dl * ospd, dz / dl * ospd
                    o.life = 5.0
                    break
                end
            end
        end
        ;(self :: any).orbT = ot
        for _, o in ipairs((self :: any).orbs) do
            if o.on then
                -- Zombie missiles home: weak proportional chase — speed or a
                -- hard bend outruns the lock and they fall behind dumb.
                if (o :: any).zmsl then local k = math.min(1, 2.0 * seconds); o.vx += ((self.tx - o.x) * 0.6 - o.vx) * k; o.vy += ((gyJ - o.y) * 0.6 - o.vy) * k; o.vz += ((self.tz - o.z) * 0.6 - o.vz) * k end
                local qx, qy, qz = o.x, o.y, o.z
                o.x += o.vx * seconds
                o.y += o.vy * seconds
                o.z += o.vz * seconds
                o.life -= seconds
                -- Swept hit: orb + jet close ~74u a frame, so a point
                -- check tunnels straight past the 5u ball. Test the
                -- whole step segment instead (endpoints included).
                local rx, ry, rz = self.tx - qx, gyJ - qy, self.tz - qz
                local wx, wy, wz = o.x - qx, o.y - qy, o.z - qz
                local ww = wx * wx + wy * wy + wz * wz
                local tseg = 0
                if ww > 0.0001 then
                    tseg = math.clamp((rx * wx + ry * wy + rz * wz) / ww, 0, 1)
                end
                local ex, ey, ez = rx - wx * tseg, ry - wy * tseg, rz - wz * tseg
                if ex * ex + ey * ey + ez * ez <= ORB_R * ORB_R and ((self :: any).countT or 0) <= 0 then
                    o.on = false
                    local dealt = (o.dmg or 20)
                    if (self :: any).level == 3 and not (o :: any).boss then dealt *= l3dmgScale(self) * L3_ZDMG end
                    if dealt >= 0.03 then
                    self.hp -= dealt
                    if self.health ~= nil then self.health.value = math.max(0, self.hp) end
                    setAny(self, "hitFlash", 1.0) -- airframe flashes white
                    if #self.chunks > 0 then -- sparks off the airframe
                        puff(self, 4, 12, 14, 0.5, gyJ, 0, 0)
                        puff(self, 1, 6, 4, 0.4, gyJ, 0, 0)
                    end
                    if self.hp <= 0 then
                        downJet(self)
                    elseif self.msg ~= nil then
                        self.msg.value = "HIT! HP " .. math.max(0, self.hp) .. " - HEIGHT + DISTANCE!"
                    end
                    end
                elseif o.life <= 0 or math.abs(o.x) > WRAP or math.abs(o.z) > WRAP then
                    o.on = false
                end
            end
        end
        -- Zombie volley: past the storm (staff/prime), the horde sneezes
        -- dotted puffs from one front-rank muzzle, 8 dmg each.
        do
            local ph = (self :: any).l3phase
            if (self :: any).level == 3 and (ph == "staff" or ph == "prime") then
                if ((self :: any).l3breakT or -1) > 0 and self.time >= ((self :: any).l3breakT or 0) and self.tut ~= nil and self.tut.value == "THE HORDE WAKES - DODGE THE BARRAGE, SHOOT BACK!" and self.tutA ~= nil then setAny(self, "l3breakT", -1); self.tutA.value = 0 end
                if ((self :: any).l3floatT or 0) > 0 then
                    setAny(self, "l3floatT", ((self :: any).l3floatT or 0) - seconds)
                    setAny(self, "throttle", 25.0)
                    if ((self :: any).l3floatT or 0) <= 0 then setAny(self, "throttle", 700.0) end
                end
                local zt = ((self :: any).l3volT or 1.5) - seconds
                if zt <= 0 then
                    zt = 0.10 -- bullet hell: a 12-dot stream ten times a second
                    local h1 = math.sin(self.time * 12.9898) * 43758.5453
                    h1 -= math.floor(h1)
                    local h2 = math.sin(self.time * 78.233) * 12543.1234
                    h2 -= math.floor(h2)
                    -- muzzle: a random live body, so the puff always
                    -- leaves a real zombie on the arch, never empty air
                    local deadV = (self :: any).armyDead or {}
                    local mi = 1 + (math.floor(h1 * 10000.0) % N_ARMY)
                    for s = 1, 50 do
                        local ii = ((mi + s - 2) % N_ARMY) + 1
                        if not deadV[ii] then mi = ii; break end
                    end
                    local mpx, mgy, mpz = zombieLivePos(self, mi)
                    local sx, sy, sz = mpx, mgy + 285.0, mpz
                    local fwd4 = (self :: any).fwd or 0
                    -- Exact intercept: unit dir to the jet's future spot, one
                    -- aim per puff so all 6 dots fly as a cluster, never a river.
                    local ux, uy, uz, ok = leadAim(self.tx, gyJ, self.tz,
                        nfx * fwd4, self.vy or 0, nfz * fwd4, sx, sy, sz, ORB_SPEED)
                    if ok then
                        local span = math.sqrt((self.tx - sx) * (self.tx - sx) + (self.tz - sz) * (self.tz - sz))
                        if span < 1000.0 then span = 1000.0 end
                        for n = 1, 12 do
                            local j1 = (h1 + n * 0.173) % 1.0
                            local j2 = (h2 + n * 0.311) % 1.0
                            local dx = ux + (j1 - 0.5) * 16.0 / span
                            local dy = uy + (j2 - 0.5) * 16.0 / span
                            local dz = uz + (j1 - j2) * 16.0 / span
                            local dl = math.sqrt(dx * dx + dy * dy + dz * dz)
                            if dl < 0.001 then dl = 0.001 end
                            for _, oo in ipairs((self :: any).orbs) do
                                if not oo.on then
                                    oo.on = true
                                    oo.x, oo.y, oo.z = sx, sy, sz
                                    oo.vx, oo.vy, oo.vz = dx / dl * ORB_SPEED, dy / dl * ORB_SPEED, dz / dl * ORB_SPEED
                                    oo.life = 10.0
                                    oo.dmg = 6
                                    oo.kind = 6 -- dotted white puff
                                    break
                                end
                            end
                        end
                    end
                end
                setAny(self, "l3volT", zt)
            end
            -- Zombie fire: one live clone sneezes a dotted puff of 8 aimed
            -- white dots every 0.5s; each hit burns the hull and flashes
            -- the airframe white.
            if (self :: any).level == 3 and (ph == "staff" or ph == "prime")
                and not ((self :: any).armyHidden or false) then
                local zft = ((self :: any).l3zfireT or 1.0) - seconds
                if zft <= 0 then
                    zft = 0.03 -- bullet hell: a 24-dot stream thirty times a second
                    local dead = (self :: any).armyDead or {}
                    local zc = (self :: any).l3zfire or 1
                    local mi = 0
                    for s = 1, 200 do -- first live clone past the cursor only
                        local i = ((zc + s - 2) % N_ARMY) + 1
                        if not dead[i] then mi = i; break end
                    end
                    setAny(self, "l3zfire", zc + 200)
                    if mi > 0 then
                        local px, pgy, pz = zombieLivePos(self, mi)
                        -- One exact intercept per puff: all 8 dots share the
                        -- aim with a hair of jitter, so they fly clustered.
                        local fwd2 = (self :: any).fwd or 0
                        local my = pgy + 195.0
                        local dl0 = math.sqrt((self.tx - px) * (self.tx - px) + (gyJ - my) * (gyJ - my) + (self.tz - pz) * (self.tz - pz))
                        if dl0 > 0.001 and dl0 < 26000.0 then
                            local ux, uy, uz, ok = leadAim(self.tx, gyJ, self.tz,
                                math.sin(self.yaw) * fwd2, self.vy or 0, math.cos(self.yaw) * fwd2, px, my, pz, ORB_SPEED)
                            if ok then
                                for n = 1, 24 do
                                    local j1 = (zc * 0.618 + n * 0.173) % 1.0
                                    local j2 = (zc * 0.377 + n * 0.311) % 1.0
                                    local dx = ux + (j1 - 0.5) * 0.002
                                    local dy = uy + (j2 - 0.5) * 0.002
                                    local dz = uz + (j1 - j2) * 0.002
                                    local dl = math.sqrt(dx * dx + dy * dy + dz * dz)
                                    if dl < 0.001 then dl = 0.001 end
                                    for _, oo in ipairs((self :: any).orbs) do
                                        if not oo.on then
                                            oo.on = true
                                            oo.x, oo.y, oo.z = px, my, pz
                                            oo.vx, oo.vy, oo.vz = dx / dl * ORB_SPEED, dy / dl * ORB_SPEED, dz / dl * ORB_SPEED
                                            oo.life = 8.0
                                            oo.dmg = 4
                                            oo.kind = 6 -- dotted white puff
                                            if n == 1 and (zc % 8) < 1 then oo.dmg = 30; oo.kind = 4; oo.vx = oo.vx * 0.43; oo.vy = oo.vy * 0.43; oo.vz = oo.vz * 0.43; setAny(oo, "boss", true); setAny(oo, "zmsl", true) end
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                setAny(self, "l3zfireT", zft)
            end
        end
    end
    -- Blast debris physics: integrated on the CPU, flared on the GPU.
    -- Debris and sparks fall, smoke billows up, everything stops at the dunes.
    for _, c in ipairs(self.chunks) do
        if c.on then
            c.life -= seconds
            if c.life <= 0 then
                c.on = false
            else
                c.x += c.vx * seconds
                c.z += c.vz * seconds
                c.y += c.vy * seconds
                if c.kind == 3 or c.kind == 4 then
                    c.vy -= 40 * seconds -- wreck chunks and sparks drop fast
                elseif c.kind == 0 or c.kind == 7 then
                    c.vy += 6 * seconds -- flames lick upward as they burn
                elseif c.kind == 2 then
                    c.vy += 2 * seconds -- smoke keeps billowing up
                elseif c.kind == 5 then
                    c.vx *= 1 - math.min(1, 2 * seconds) -- dust ring drags out flat
                    c.vz *= 1 - math.min(1, 2 * seconds)
                elseif c.kind == 6 then
                    c.vy = 0 -- shockwave hugs the dunes, no fall
                    c.vx *= 1 - math.min(1, 1.5 * seconds)
                    c.vz *= 1 - math.min(1, 1.5 * seconds)
                end
                local gyC = groundH(c.x, c.z)
                if c.y < gyC then
                    c.y = gyC
                    c.vy = 0
                    c.vx *= 0.5
                    c.vz *= 0.5
                end
            end
        end
    end
    -- Foes: circle their anchors and bob, frozen on crash.
    -- Parked until the tutorial completes (tutDone). Level-3 staff adds
    -- kind behavior: cacklers chase, spitters strafe + spit orbs, brutes
    -- stalk slow; all burn the hull on contact.
    if not self.crashed and ((self :: any).tutDone or false) then
        local t = self.time
        local gyJ = groundH(self.tx, self.tz) + self.hy + 1.8
        for i, f in ipairs(self.foes) do
            if f.on then
                local k = f.kind or 0
                if gateMode(self) then -- tunnel guards: hover + spit (shared helper)
                    local egi = tunEnemyGate(i)
                    if egi ~= nil then tunGuard(self, f, egi, gyJ, seconds) end
                end
                if gateMode(self) and (f.kind or 0) == 4 then -- pumpkin touch: 75 hull damage, 2s cooldown each
                    f.tchCd = math.max(0, (f.tchCd or 0) - seconds)
                    local qx, qy, qz = f.x - self.tx, f.y - gyJ, f.z - self.tz
                    if qx * qx + qy * qy + qz * qz <= 6400.0 and f.tchCd <= 0 and ((self :: any).countT or 0) <= 0 then f.tchCd = 2.0; self.hp -= 75; if self.health ~= nil then self.health.value = math.max(0, self.hp) end; setAny(self, "hitFlash", 1.0); setAny(self, "shakeT", 1.0); if self.hp <= 0 then gateCrash(self) end end
                end
                if k == 1 and not gateMode(self) then -- cackler: anchor chases the jet at 120
                    local dx, dz = self.tx - f.ax, self.tz - f.az
                    local dl = math.sqrt(dx * dx + dz * dz)
                    if dl > 1 then
                        f.ax += dx / dl * math.min(120 * seconds, dl)
                        f.az += dz / dl * math.min(120 * seconds, dl)
                    end
                    if f.ax > WRAP then f.ax -= WRAP * 2 elseif f.ax < -WRAP then f.ax += WRAP * 2 end
                    if f.az > WRAP then f.az -= WRAP * 2 elseif f.az < -WRAP then f.az += WRAP * 2 end
                    local dy = gyJ - f.alt
                    f.alt += math.clamp(dy, -100 * seconds, 100 * seconds)
                elseif k == 3 then -- brute: slow stalk at 150, stays on height
                    local dx, dz = self.tx - f.ax, self.tz - f.az
                    local dl = math.sqrt(dx * dx + dz * dz)
                    if dl > 1 then
                        f.ax += dx / dl * math.min(150 * seconds, dl)
                        f.az += dz / dl * math.min(150 * seconds, dl)
                    end
                    if f.ax > WRAP then f.ax -= WRAP * 2 elseif f.ax < -WRAP then f.ax += WRAP * 2 end
                    if f.az > WRAP then f.az -= WRAP * 2 elseif f.az < -WRAP then f.az += WRAP * 2 end
                elseif k == 2 then -- spitter: aimed orb every 3.5s from range
                    f.atkT -= seconds
                    if f.atkT <= 0 and (self.homeTarget or 0) <= 0 then
                        f.atkT = 3.5
                        local ddx, ddy, ddz = self.tx - f.x, gyJ - f.y, self.tz - f.z
                        local ddl = math.sqrt(ddx * ddx + ddy * ddy + ddz * ddz)
                        if ddl < 0.001 then ddl = 0.001 end
                        for _, oo in ipairs((self :: any).orbs) do
                            if not oo.on then
                                oo.on = true
                                oo.x, oo.y, oo.z = f.x, f.y, f.z
                                oo.vx, oo.vy, oo.vz = ddx / ddl * ORB_SPEED, ddy / ddl * ORB_SPEED, ddz / ddl * ORB_SPEED
                                oo.life = 5.0
                                oo.dmg = 8 -- spitters were defaulting to 20: now explicit
                                break
                            end
                        end
                    end
                end
                local a = t * f.sp + f.ph
                f.x = f.ax + math.cos(a) * f.r
                f.z = f.az + math.sin(a) * f.r
                f.y = f.alt + math.sin(t * 0.8 + f.ph) * 12.0
                f.spin = t * (0.6 + 0.2 * ((i - 1) % 2)) + f.ph
                -- Staff contact burns the hull (12, scaled, 1s cooldown per minion).
                if k > 0 then
                    f.tchCd = math.max(0, (f.tchCd or 0) - seconds)
                    local cx, cy, cz = f.x - self.tx, f.y - gyJ, f.z - self.tz
                    if cx * cx + cy * cy + cz * cz <= 80 * 80 and f.tchCd <= 0 then
                        f.tchCd = 1.0
                        self.hp -= 12 * l3dmgScale(self) * L3_ZDMG
                        if self.health ~= nil then self.health.value = math.max(0, self.hp) end
                        setAny(self, "hitFlash", 1.0) -- minion contact flashes the hull
                        if #self.chunks > 0 then
                            puff(self, 4, 12, 14, 0.5, gyJ, 0, 0)
                            puff(self, 1, 6, 4, 0.4, gyJ, 0, 0)
                        end
                        if self.hp <= 0 then
                            downJet(self)
                            if self.msg ~= nil then self.msg.value = "THE COURT GOT YOU - press P to play again" end
                        elseif self.msg ~= nil then
                            self.msg.value = (FOE_NAMES[k + 1] or "MINION") .. " HIT YOU! HP " .. math.max(0, self.hp)
                        end
                    end
                end
            end
        end
    end
    -- Level 2 parkour: sequential gate passes. Threading the live hole
    -- clears it (flash + sound + count); the bore wall bites anywhere else.
    if gateMode(self) then
        -- Unwrapped jet track: over a multi-tile course the tile coords
        -- lose which world copy you are on, so every gate-relative vector
        -- below uses exact unwrapped coords. Frame steps are tiny, so the
        -- modular diff is always the true step, even across wrap teleports.
        local uwx = (self :: any).uwx or self.tx
        local uwz = (self :: any).uwz or self.tz
        do
            local ptx = (self :: any).ptx
            local ptz = (self :: any).ptz
            if ptx ~= nil and ptz ~= nil then
                local udx = self.tx - ptx
                if udx > WRAP then udx -= WRAP * 2 elseif udx < -WRAP then udx += WRAP * 2 end
                local udz = self.tz - ptz
                if udz > WRAP then udz -= WRAP * 2 elseif udz < -WRAP then udz += WRAP * 2 end
                uwx += udx
                uwz += udz
                ;(self :: any).uwx = uwx
                ;(self :: any).uwz = uwz
            end
        end
        -- Tunnel walls: crash on the tube's inside plate. ONE straight axis
        -- through the anchors (same line buildTube draws), so touching the
        -- visible wall = wreck and the middle is always safe. No clamp, no
        -- slide: cross TUBE_R and the run burns, then the mercy respawn
        -- rejoins at the live gate. Grace covers respawns.
        if not self.crashed and (self.homeTarget or 0) <= 0 and not self.paused
            and #self.gates >= GATE_N
            and ((self :: any).vitT or -1) < 0 and ((self :: any).winT or 0) <= 0 then
            local gs = self.gates
            local jetY = groundH(self.tx, self.tz) + self.hy + 1.8
            wallExtra(self, gs[self.gateIdx or 1], self.gateIdx or 1, uwx, jetY, seconds) -- walls resolve the moment the run is live: never grace-ghosted, crossings never missed
            if (self.gateGraceT or 0) <= 0 then
            local A0, B0 = gs[1], gs[GATE_N]
            local dx, dy, dz = B0.ax - A0.ax, B0.ay - A0.ay, B0.az - A0.az
            local dl = math.sqrt(dx * dx + dy * dy + dz * dz)
            if dl < 0.001 then dl = 0.001 end
            dx, dy, dz = dx / dl, dy / dl, dz / dl
            -- straight bore: mouth 22k behind gate 1 (covers the run-up),
            -- exit past the portal (+3500 covers the +3000 portal disc)
            local ax0, ay0, az0 = A0.ax - dx * 22000.0, A0.ay - dy * 22000.0, A0.az - dz * 22000.0
            local bx0, by0, bz0 = B0.ax + dx * 3500.0, B0.ay + dy * 3500.0, B0.az + dz * 3500.0
            local abx, aby, abz = bx0 - ax0, by0 - ay0, bz0 - az0
            local denom = abx * abx + aby * aby + abz * abz
            local tt = ((uwx - ax0) * abx + (jetY - ay0) * aby + (uwz - az0) * abz) / denom
            if tt < 0 then tt = 0 elseif tt > 1 then tt = 1 end
            local px, py, pz = ax0 + abx * tt, ay0 + aby * tt, az0 + abz * tt
            local ox, oy, oz = uwx - px, jetY - py, uwz - pz
            local L = math.sqrt(ox * ox + oy * oy + oz * oz)
            if L > TUBE_R then
                gateCrash(self) -- hit the tunnel side plate: burn + mercy respawn
                uwx = (self :: any).uwx or self.tx
                uwz = (self :: any).uwz or self.tz
            end
            end
        end
        -- Wreck burn-out: 2.5s after a parkour crash the mercy respawn
        -- fires on its own (unless you already retried or quit to home).
        local wt = (self :: any).gateWreckT or 0
        if wt > 0 then
            wt = math.max(0, wt - seconds)
            ;(self :: any).gateWreckT = wt
            if wt <= 0 and self.crashed and (self.homeTarget or 0) <= 0 and not self.paused then
                gateRespawn(self) -- teleports: refresh the scratch track
                uwx = (self :: any).uwx or self.tx
                uwz = (self :: any).uwz or self.tz
            end
        end
        -- Gates hold their anchors (drift removed to fund the second wall ring).
        if (self.gateGraceT or 0) > 0 then self.gateGraceT = math.max(0, (self.gateGraceT or 0) - seconds) end
        -- Restart countdown: the jet hangs pinned mid-air while 3-2-1
        -- runs on the prompt, then GO hands back cruise speed.
        countTick(self, seconds)
        -- Scoreboard: intro line for a few seconds, then the bare n/20
        -- count. Visible only while the run is live, never in menus.
        if self.gateScoreA ~= nil then self.gateScoreA.value = ((self.homeTarget or 0) > 0 or self.crashed or self.paused or (self :: any).level ~= 2) and 0 or 1 end
        if ((self :: any).gateIntroT or 0) > 0 then setAny(self, "gateIntroT", math.max(0, ((self :: any).gateIntroT or 0) - seconds)); if ((self :: any).gateIntroT or 0) <= 0 and self.gateScore ~= nil then self.gateScore.value = math.min(self.gateIdx or 1, GATE_N) .. "/20" end; if ((self :: any).gateIntroT or 0) <= 0 and self.tutA ~= nil then self.tutA.value = 0 end end
        local idx = self.gateIdx or 1
        if idx <= GATE_N and not self.crashed and (self.homeTarget or 0) <= 0 and #self.gates >= GATE_N then
            local g = self.gates[idx]
            if g ~= nil and g.on then
                -- ENEMY stage: the foe must die first. Flying into it does
                -- nothing; the HUD nags to shoot. Kill hook advances below.
                local foeAlive = g.enemy and g.foeSlot ~= nil and (self.foes[g.foeSlot] :: any).on or false
                if g.enemy and foeAlive then if self.msg ~= nil and ((self :: any).tunNag or 0) ~= idx then self.msg.value = "ENEMY " .. idx .. "/20 - SHOOT IT DOWN!"; setAny(self, "tunNag", idx) end
                else
                local near = idx > 11 and (g :: any).wall ~= true and (g.x - uwx) * (g.x - uwx) + (g.y - (groundH(self.tx, self.tz) + self.hy + 1.8)) * (g.y - (groundH(self.tx, self.tz) + self.hy + 1.8)) + (g.z - uwz) * (g.z - uwz) <= GATE_FLY * GATE_FLY
                if near then
                    g.done = true
                    self.gateIdx = idx + 1
                    self.hp = 100
                    if self.health ~= nil then self.health.value = 100 end
                    playSfx(self, "click")
                    if self.gateIdx > GATE_N then
                        if self.gateScore ~= nil then self.gateScore.value = "20/20 - PORTAL!" end
                        ;(self :: any).gateIntroT = 0
                        if self.msg ~= nil then self.msg.value = "ENTER THE PORTAL!" end
                    else
                        if self.msg ~= nil then if (g :: any).enemy then self.msg.value = "ENEMY DOWN " .. idx .. "/20!" else self.msg.value = "GATE " .. idx .. "/20!" end end
                        if ((self :: any).gateIntroT or 0) <= 0 and self.gateScore ~= nil then self.gateScore.value = self.gateIdx .. "/20" end
                    end
                end
                end
            end
        end
        -- FINALE: 5 pumpkin heads past the last wall (own scope, like walls).
        if (self.gateIdx or 1) > GATE_N then finStage(self) end
        -- Exit wall: once all 20 stages are done, touching the white
        -- glow wall sealing the tunnel end finishes the level
        -- (CONGRATULATIONS show). Any touch inside the bore is the win;
        -- the 3 horrors are optional guards, not a requirement.
        if (self.gateIdx or 1) > GATE_N and not self.crashed and (self.homeTarget or 0) <= 0
            and #self.gates >= GATE_N
            and ((self :: any).vitT or -1) < 0 and ((self :: any).winT or 0) <= 0 then
            local bl = self.gates[GATE_N]
            local ppx, ppy, ppz = bl.ax, bl.ay, bl.az + 3000.0
            local gyP = groundH(self.tx, self.tz) + self.hy + 1.8
            local pdx, pdy = ppx - uwx, ppy - gyP
            if uwz >= ppz - 150.0 and pdx * pdx + pdy * pdy <= 420.0 * 420.0 then
                level2Complete(self) -- touched the white end wall inside the bore: victory, never a burn
            end
        end
        -- Jet-eye trailhead for the tube clamp below.
        ;(self :: any).ptx = self.tx
        ;(self :: any).ptz = self.tz
    end
    -- The wreck burns for a while after the crash, then gutters out.
    if self.crashed then
        self.crashT += seconds
        self.crashAcc += seconds
        if self.crashAcc >= 0.25 and self.crashT < 20 and #self.chunks > 0 then
            self.crashAcc = 0
            local gyB = groundH(self.tx, self.tz)
            puff(self, 0, 10, 14, 1.8, gyB)
            puff(self, 0, 6, 8, 1.2, gyB)
            puff(self, 2, 12, 10, 3.5, gyB)
            puff(self, 4, 16, 20, 0.9, gyB)
        end
    end
    -- Round-3 boss: MORGATHA stalks the jet, volleys aimed fireballs,
    -- and telegraphs charges. PRIME (level 3) runs 3 phases by HP frac
    -- plus P3 cackler summons. Touching him burns the hull.
    -- Frozen wreck? He waits.
    do
        local B = (self :: any).boss
        if B ~= nil and B.on and self.round == 3 and not self.crashed and (self.homeTarget or 0) <= 0 then
            local gyJ = groundH(self.tx, self.tz) + self.hy + 1.8
            local dx, dz = self.tx - B.ax, self.tz - B.az
            local dl = math.sqrt(dx * dx + dz * dz)
            if dl < 0.001 then dl = 0.001 end
            -- Face the jet.
            local want = math.atan2(dx, dz)
            local df = want - (B.face or 0)
            while df > math.pi do df -= 2 * math.pi end
            while df < -math.pi do df += 2 * math.pi end
            B.face = (B.face or 0) + df * math.min(1, 4 * seconds)
            local bmax = B.max or BOSS_HP
            local prime = (B.prime == true)
            local frac = (B.hp or bmax) / bmax
            local phase = 1
            if prime and frac <= 0.3 then phase = 3 elseif prime and frac <= 0.6 then phase = 2 end
            local enr = prime and phase == 3 or (not prime and (B.hp or bmax) <= 120)
            local bname = prime and "VOIDPUS " or "MORGATHA "
            if enr and not B.enraged then
                B.enraged = true
                if self.msg ~= nil then self.msg.value = bname .. "ENRAGED - FASTER AND MEANER!" end
            end
            if prime and phase == 2 and not B.p2told then
                B.p2told = true
                if self.msg ~= nil then self.msg.value = "VOIDPUS CRACKS - SPREAD VOLLEYS INCOMING!" end
            end
            if B.live then
                if B.mode == "dash" then
                    B.ax += (B.dvx or 0) * seconds
                    B.az += (B.dvz or 0) * seconds
                    B.modeT = (B.modeT or 0) - seconds
                    if (B.modeT or 0) <= 0 then
                        B.mode = "stalk"
                        B.chgT = prime and (phase == 3 and 4.5 or 6.0) or (enr and 4.5 or 8.0)
                    end
                elseif B.mode == "warn" then
                    B.modeT = (B.modeT or 0) - seconds
                    if (B.modeT or 0) <= 0 then
                        B.mode = "dash"
                        B.modeT = 0.8
                        local ddx, ddz = self.tx - B.ax, self.tz - B.az
                        local ddl = math.sqrt(ddx * ddx + ddz * ddz)
                        if ddl < 0.001 then ddl = 0.001 end
                        B.dvx, B.dvz = ddx / ddl * 1500, ddz / ddl * 1500
                    end
                else -- stalk: drift down onto the jet, match its height
                    local spd4 = prime and (phase == 3 and 520 or phase == 2 and 420 or 360)
                        or (enr and 340 or 260)
                    if dl > 1 then
                        B.ax += dx / dl * math.min(spd4 * seconds, dl)
                        B.az += dz / dl * math.min(spd4 * seconds, dl)
                    end
                    local dy = gyJ - (B.alt or gyJ)
                    B.alt = (B.alt or gyJ) + math.clamp(dy, -150 * seconds, 150 * seconds)
                    local at2 = (B.atkT or 0) - seconds
                    if at2 <= 0 then
                        B.atkT = prime and (phase == 3 and 1.1 or phase == 2 and 2.2 or 1.8)
                            or (enr and 1.5 or 2.6)
                        -- Aimed fireball with a touch of lead, from the maw.
                        -- Prime P2+ fans a 3-way spread around the aim.
                        local fwd5 = (self :: any).fwd or 0
                        local jx = self.tx + math.sin(self.yaw) * fwd5 * 0.4
                        local jz = self.tz + math.cos(self.yaw) * fwd5 * 0.4
                        local jy = gyJ + self.vy * 0.4
                        local shots = (prime and phase >= 2) and 3 or 1
                        for s = 1, shots do
                            local off = (s - 2) * 0.06 -- fan spread radians
                            local ddx, ddy, ddz = jx - B.x, jy - B.y, jz - B.z
                            local ddl = math.sqrt(ddx * ddx + ddy * ddy + ddz * ddz)
                            if ddl < 0.001 then ddl = 0.001 end
                            local ca, sa = math.cos(off), math.sin(off)
                            local rx, rz = (ddx * ca - ddz * sa) / ddl, (ddx * sa + ddz * ca) / ddl
                            for _, oo in ipairs((self :: any).orbs) do
                                if not oo.on then
                                    oo.on = true
                                    oo.x, oo.y, oo.z = B.x, B.y, B.z
                                    oo.vx, oo.vy, oo.vz = rx * ORB_SPEED, ddy / ddl * ORB_SPEED, rz * ORB_SPEED
                                    oo.life = 5.0
                                    oo.dmg = 15
                                    ;(oo :: any).boss = true
                                    break
                                end
                            end
                        end
                    else
                        B.atkT = at2
                    end
                    -- Prime P3 calls a cackler back every 20s (max 2 live).
                    if prime and phase == 3 then
                        B.sumT = (B.sumT or PRIME_SUMMON_CD) - seconds
                        if B.sumT <= 0 then
                            B.sumT = PRIME_SUMMON_CD
                            local live = 0
                            for _, g in ipairs(self.foes) do
                                if g.on then live += 1 end
                            end
                            if live < 2 then
                                for _, g in ipairs(self.foes) do
                                    if not g.on then
                                        local fx2, fz2 = math.sin(self.yaw), math.cos(self.yaw)
                                        g.on = true
                                        g.kind = 1
                                        g.hp = FOE_HP[2]
                                        g.tchCd = 0
                                        g.atkT = 3.0
                                        g.ax = B.ax + fx2 * 600.0
                                        g.az = B.az + fz2 * 600.0
                                        if g.ax > WRAP then g.ax -= WRAP * 2 elseif g.ax < -WRAP then g.ax += WRAP * 2 end
                                        if g.az > WRAP then g.az -= WRAP * 2 elseif g.az < -WRAP then g.az += WRAP * 2 end
                                        g.alt = (B.alt or gyJ)
                                        g.r = 90.0
                                        g.sp = 0.6
                                        g.ph = self.time
                                        g.x, g.z = g.ax + g.r, g.az
                                        g.y = g.alt
                                        g.spin = g.ph
                                        if self.msg ~= nil then self.msg.value = "VOIDPUS CALLS A CACKLER!" end
                                        break
                                    end
                                end
                            end
                        end
                    end
                    local ct = (B.chgT or 0) - seconds
                    B.chgT = ct
                    if ct <= 0 then
                        B.mode = "warn"
                        B.modeT = 1.2
                        if self.msg ~= nil then self.msg.value = bname .. "CHARGES - DODGE!" end
                    end
                end
                if B.ax > WRAP then B.ax -= WRAP * 2 elseif B.ax < -WRAP then B.ax += WRAP * 2 end
                if B.az > WRAP then B.az -= WRAP * 2 elseif B.az < -WRAP then B.az += WRAP * 2 end
                -- Touching the king burns the hull (worse mid-charge).
                local cx, cy, cz = B.x - self.tx, B.y - gyJ, B.z - self.tz
                B.tchCd = (B.tchCd or 0) - seconds
                if cx * cx + cy * cy + cz * cz <= 80 * 80 and (B.tchCd or 0) <= 0 then
                    B.tchCd = 1.0
                    local dmg = (B.mode == "dash") and 35 or 25
                    self.hp -= dmg
                    if self.health ~= nil then self.health.value = math.max(0, self.hp) end
                    setAny(self, "hitFlash", 1.0) -- king contact flashes the hull
                    if #self.chunks > 0 then
                        puff(self, 4, 12, 14, 0.5, gyJ, 0, 0)
                        puff(self, 1, 6, 4, 0.4, gyJ, 0, 0)
                    end
                    if self.hp <= 0 then
                        downJet(self)
                        if self.msg ~= nil then self.msg.value = bname .. "SMASHED YOU - press P to play again" end
                    elseif self.msg ~= nil then
                        self.msg.value = bname .. "HIT YOU! HP " .. math.max(0, self.hp)
                    end
                end
            end
            -- Draw pos rides the anchor: warn shudder + idle bob.
            local jx, jy = 0, 0
            if B.mode == "warn" then
                jx = math.sin(self.time * 40) * 12
                jy = math.cos(self.time * 33) * 8
            end
            B.x = B.ax + jx
            B.z = B.az + jy
            B.y = (B.alt or gyJ) + math.sin(self.time * 1.2 + (B.ph or 0)) * 15
        end
    end
    -- Wind streaks: spawn ahead of the nose, static in the world so the jet
    -- flies past them. Spawn rate grows with speed (dense on Q boost).
    local spdNow = (self :: any).fwd or 18
    if self.grounded then
        -- Runway: parked or rolling, no wind streaks (flight-only effect).
        for _, st in ipairs(self.winds) do st.on = false end
        self.windAcc = 0
    else
    self.windAcc += seconds * (6 + spdNow * 0.02)
    local jfx, jfz = math.sin(self.yaw), math.cos(self.yaw)
    local jrx, jrz = math.cos(self.yaw), -math.sin(self.yaw)
    while self.windAcc >= 1 do
        self.windAcc -= 1
        local st = self.winds[self.windIdx]
        if st == nil then break end -- stale hot-reload state: skip a frame
        self.windIdx = self.windIdx % WIND_SLOTS + 1
        local q = math.floor(self.time * 60)
        local ahead = 10 + rnd(self.windIdx, q) * (10 + spdNow * 0.6)
        local side = (rnd(self.windIdx, q + 7) - 0.5) * 24.0
        local up = (rnd(self.windIdx, q + 13) - 0.5) * 9.0
        -- Keep streaks off the airframe so they never clip through the jet.
        if math.abs(side) < 1.5 and math.abs(up) < 1.2 then
            if side >= 0 then side += 1.5 else side -= 1.5 end
        end
        st.x = self.tx + jfx * ahead + jrx * side
        st.z = self.tz + jfz * ahead + jrz * side
        st.y = groundH(self.tx, self.tz) + self.hy + 1.8 + up
        st.vx = 0.6 + rnd(self.windIdx, q + 29) * 0.8 -- per-streak length variance
        st.life = 0.9
        st.on = true
    end
    end
    local kfx, kfz = math.sin(self.yaw), math.cos(self.yaw)
    for _, st in ipairs(self.winds) do
        if st.on then
            st.life -= seconds
            -- Retire the moment it passes behind the jet: no lingering pop.
            local along = (st.x - self.tx) * kfx + (st.z - self.tz) * kfz
            if st.life <= 0 or along < -3 then st.on = false end
        end
    end
    if held(self, 120, 88) then self.height = math.clamp(self.height - 12 * seconds, 3, 14) end -- X lowers (R is the steer toggle now)
    if held(self, 102, 70) then self.height = math.clamp(self.height + 12 * seconds, 3, 14) end
    -- Wide map: wrap around the 12000-unit tile (mesh covers it all).
    local wrapped = false
    if self.tx > WRAP then self.tx -= WRAP * 2; wrapped = true; elseif self.tx < -WRAP then self.tx += WRAP * 2; wrapped = true; end
    if self.tz > WRAP then self.tz -= WRAP * 2; wrapped = true; elseif self.tz < -WRAP then self.tz += WRAP * 2; wrapped = true; end
    if wrapped then resetTrail(self) end
    -- Minimap trail: breadcrumb every TRAIL_EVERY units, then push the
    -- plane dot + all crumbs to the HUD (cheap: 34 number writes/frame).
    self.trailAcc += mlen * seconds
    if self.trailAcc >= TRAIL_EVERY then
        self.trailAcc = 0
        local cb = self.trail[self.trailIdx]
        cb.x = self.tx
        cb.z = self.tz
        self.trailIdx = self.trailIdx % TRAIL_N + 1
    end
    if self.mapPlaneX ~= nil and self.mapPlaneY ~= nil then
        local ppx, ppy = mapPX(self, self.tx, self.tz)
        self.mapPlaneX.value = ppx
        self.mapPlaneY.value = ppy
    end
    for i, cc in ipairs(self.trail) do
        local txp = self.trailX[i]
        local typ = self.trailY[i]
        if txp ~= nil and typ ~= nil then
            -- crumbs are local (reset on wrap): single-wrap diff is exact
            local ox = cc.x - self.tx
            if ox > WRAP then ox -= WRAP * 2 elseif ox < -WRAP then ox += WRAP * 2 end
            local oz = cc.z - self.tz
            if oz > WRAP then oz -= WRAP * 2 elseif oz < -WRAP then oz += WRAP * 2 end
            local px, py = mapPX(self, self.tx + ox, self.tz + oz)
            txp.value = px
            typ.value = py
        end
    end
    -- Level 1 foe dots: green, live pumpkins only; kills park off-screen.
    -- Hidden until tutorials complete. Level 2 reuses the 5 dots as a
    -- sliding window over the next 5 circus gates (gold one is next).
    if gateMode(self) and #self.gates >= GATE_N then
        for i = 1, FOE_N do
            local fxp = self.foeX[i]
            local fyp = self.foeY[i]
            if fxp ~= nil and fyp ~= nil then
                local g = self.gates[(self.gateIdx or 1) + i - 1]
                if g ~= nil and g.on and not g.done then
                    local uwx = (self :: any).uwx or self.tx
                    local uwz = (self :: any).uwz or self.tz
                    local px, py = mapPX(self, self.tx + (g.x - uwx), self.tz + (g.z - uwz))
                    fxp.value = px
                    fyp.value = py
                else
                    fxp.value = -200
                    fyp.value = -200
                end
            end
        end
    else
    -- Level 3 storm run: no foes up yet, so the first dot tracks the
    -- storm heart itself (a direction hint until the wall breaks).
    local l3storm = (self :: any).level == 3
        and ((self :: any).l3phase == "storm" or (self :: any).l3phase == "reveal")
    -- GIGA hunt: the staff is dead, so the first dot tracks the giant.
    local GG: any = (self :: any).l3giant
    local l3giga = (self :: any).level == 3
        and ((self :: any).l3phase == "giant" or (self :: any).l3phase == "dying")
        and GG ~= nil and (GG.rise or 0) >= 1
    for i, f in ipairs(self.foes) do
        local fxp = self.foeX[i]
        local fyp = self.foeY[i]
        if fxp ~= nil and fyp ~= nil then
            if l3giga and i == 1 then
                local px, py = mapPX(self, GG.x, GG.z)
                fxp.value = px
                fyp.value = py
            elseif l3storm and i == 1 and ((self :: any).tutDone or false) then
                local px, py = mapPX(self, (self :: any).l3stormX or L3_STORM_X, (self :: any).l3stormZ or L3_STORM_Z)
                fxp.value = px
                fyp.value = py
            elseif f.on and ((self :: any).tutDone or false) then
                local px, py = mapPX(self, f.x, f.z)
                fxp.value = px
                fyp.value = py
            else
                fxp.value = -200
                fyp.value = -200
            end
        end
    end
    end
    -- Ease the camera in behind the jet when the player is not looking around.
    if self.camHold > 0 then
        self.camHold -= seconds
    elseif not self.dragging then
        local yd = self.yaw - self.camYaw
        while yd > math.pi do yd -= 2 * math.pi end
        while yd < -math.pi do yd += 2 * math.pi end
        self.camYaw += yd * math.min(1, 3.5 * seconds)
    end
    -- Steer banner countdown: parks the message after ~2.5s.
    if self.lockMsgT > 0 then
        self.lockMsgT -= seconds
        if self.lockMsgT <= 0 then
            self.lockMsgT = 0
            if self.lockA ~= nil then self.lockA.value = 0 end
        end
    end
    -- Flight loop: jet hum replays from the runway on (no loop API, so the
    -- ~10s clip restarts on a 9.4s timer), hushed everywhere else.
    local flying = not self.crashed and (self.homeTarget or 0) <= 0
    if flying and (self :: any).musicOn ~= false and self.jetSnd ~= nil then
        self.jetT -= seconds
        if self.jetT <= 0 then
            if self.jetInst ~= nil then pcall(function() (self.jetInst :: any):stop() end) end
            local ok, inst = pcall(function() return Audio.play(self.jetSnd) end)
            if ok and inst ~= nil then
                self.jetInst = inst
                pcall(function() (inst :: any).volume = 0.55 end)
            end
            self.jetT = 9.4
        end
    elseif self.jetInst ~= nil then
        pcall(function() (self.jetInst :: any):stop() end)
        self.jetInst = nil
        self.jetT = 0
    end
    -- Home bells: creepy loop behind the hero splash + home menu
    -- (no loop API, so the ~20.7s clip restarts on a 20.2s timer),
    -- hushed the moment PLAY fades the menu out.
    local homeUp = (self.heroA ~= nil and self.heroA.value > 0) or (self.homeTarget or 0) > 0
    if homeUp and (self :: any).musicOn ~= false and self.homeBellsSnd ~= nil then
        self.homeBellsT -= seconds
        if self.homeBellsT <= 0 then
            if self.homeBellsInst ~= nil then pcall(function() (self.homeBellsInst :: any):stop() end) end
            local ok, inst = pcall(function() return Audio.play(self.homeBellsSnd) end)
            if ok and inst ~= nil then
                self.homeBellsInst = inst
                pcall(function() (inst :: any).volume = 0.4 end)
            end
            self.homeBellsT = 20.2
        end
    elseif self.homeBellsInst ~= nil then
        pcall(function() (self.homeBellsInst :: any):stop() end)
        self.homeBellsInst = nil
        self.homeBellsT = 0
    end
    -- HUD stats: forward speed + height above the dunes.
    cineTick(self, seconds) -- round-opening cinematic orbit (all levels), no-op once done
    if self.speed ~= nil then self.speed.value = (self :: any).fwd or 0 end
    if self.alt ~= nil then self.alt.value = self.hy end

    if self.gpuOk and self.ubo ~= nil and self.uboCpu ~= nil then
        local ok = pcall(function()
            local gy0 = groundH(self.tx, self.tz)
            local back, camH, camLh = camFrame(self)
            -- runway gust sway: slow heavy wind push while a front slams
            -- the strip (level 3, grounded) — wind push, not earthquake.
            -- Storm rage: violent high-frequency rattle while blind inside
            -- the wall. Both zero otherwise.
            local gsh = (self :: any).l3gustShake or 0
            local rgh = 0
            if not self.crashed then rgh = (self :: any).l3blind or 0 end
            -- atom-bomb kick: the blast rattles the camera ~2.5s, decaying.
            -- Decayed here (runs every frame, every phase) so it can never
            -- stick: the boss block that sets it stops at "won".
            local nuke = math.max(0, ((self :: any).l3nukeT or 0) - seconds)
            setAny(self, "l3nukeT", nuke)
            if not self.crashed then rgh = math.max(rgh, math.min(1, nuke * 0.8)) end
            -- punch shake: GIGA hits rattle the camera ~1.2s alongside nukes.
            local shk = math.max(0, ((self :: any).shakeT or 0) - seconds)
            setAny(self, "shakeT", shk)
            if not self.crashed then rgh = math.max(rgh, math.min(1, shk * 1.5)) end
            local shx = math.sin(self.time * 2.3) * gsh * 0.5 + math.sin(self.time * 39.0) * rgh * 2.4
            local shy = math.sin(self.time * 2.9 + 1.3) * gsh * 0.3 + math.sin(self.time * 44.0 + 0.7) * rgh * 1.7
            local eye = Vector.xyz(
                self.tx - math.sin(self.camYaw) * back + shx,
                gy0 + self.hy + camH + shy,
                self.tz - math.cos(self.camYaw) * back
            )
            local center = Vector.xyz(
                self.tx + math.sin(self.camYaw) * 4.0 + shx * 0.5,
                gy0 + self.hy + camLh + shy * 0.5,
                self.tz + math.cos(self.camYaw) * 4.0
            )
            local up = Vector.xyz(0, 1, 0)
            local view = Mat4.lookAt(eye, center, up)
            local proj = Mat4.perspective(math.rad(60), self.aspect, 0.5, 80000)
            local mvp = proj * view
            local cpu = self.uboCpu :: buffer;
            mvp:writeToBuffer(cpu, 0);
            buffer.writef32(cpu, 64, self.time);
            buffer.writef32(cpu, 68, self.tx);
            buffer.writef32(cpu, 72, 1.0);
            buffer.writef32(cpu, 76, self.tz);
            buffer.writef32(cpu, 80, eye.x);
            buffer.writef32(cpu, 84, eye.y);
            buffer.writef32(cpu, 88, eye.z);
            buffer.writef32(cpu, 92, (self :: any).levelBlend or 0); -- round-3 sky grade
            local ubo = self.ubo :: GPUBuffer;
            ubo:write(cpu);
            -- Crosshair visibility follows game state; its position is
            -- mouse-driven (pointerMove) so it never drifts on its own.
            -- Gun anchor still stashed here for future mounts.
            local showAim = (self.homeTarget or 0) <= 0
                and (self.heroA == nil or self.heroA.value <= 0) and not self.crashed
            if self.aimA ~= nil then
                self.aimA.value = showAim and 1 or 0
            end
            -- Vertical gun bar, hidden until a switch pops it (2.5s).
            -- Prop reuse: gunX1 = column x, gunX2/X3/RowY = row tops,
            -- gunHLX = highlight row top (parked off-screen when hidden).
            local gt = (self :: any).gunShowT or 0
            if gt > 0 then
                gt -= seconds
                ;(self :: any).gunShowT = gt
            end
            local barOn = showAim and gt > 0
            if self.gunX1 ~= nil and self.gunX2 ~= nil and self.gunX3 ~= nil
                and self.gunX4 ~= nil and self.gunRowY ~= nil and self.gunHLX ~= nil and self.gunDim ~= nil then
                if barOn then
                    local colX = self.cw / 2 - 100
                    local topY = 56 -- top-center, under the HP bar
                    self.gunX1.value = colX
                    self.gunX2.value = topY
                    self.gunX3.value = topY + 26
                    self.gunRowY.value = topY + 52
                    self.gunX4.value = topY + 78
                    local gi = (self :: any).gun or 1
                    self.gunHLX.value = topY + (gi - 1) * 26
                    self.gunDim.value = 0.45
                else
                    self.gunHLX.value = -200
                    self.gunDim.value = 0
                end
            end
            if showAim then
                -- Shooter model: crosshair pinned to screen center, camera
                -- aim ray stashed for the bolts + future gun mounts.
                local cdx = center.x - eye.x
                local cdy = center.y - eye.y
                local cdz = center.z - eye.z
                local clen = math.sqrt(cdx * cdx + cdy * cdy + cdz * cdz)
                if clen < 0.001 then clen = 0.001 end
                local gdx, gdy, gdz = cdx / clen, cdy / clen, cdz / clen
                ;(self :: any).gunDx, (self :: any).gunDy, (self :: any).gunDz = gdx, gdy, gdz
                local nfx, nfz = math.sin(self.yaw), math.cos(self.yaw)
                ;(self :: any).gunPx = self.tx + nfx * 3.4 + gdx * GUN_LEAD
                ;(self :: any).gunPy = gy0 + self.hy + 1.8 + gdy * GUN_LEAD
                ;(self :: any).gunPz = self.tz + nfz * 3.4 + gdz * GUN_LEAD
                if self.aimX ~= nil and self.aimY ~= nil then
                    local ax, ay = self.cw / 2, self.ch / 2
                    self.aimX.value = ax
                    self.aimY.value = ay
                    if self.aimLX ~= nil and self.aimRX ~= nil and self.aimTY ~= nil and self.aimBY ~= nil then
                        self.aimLX.value = ax - 14
                        self.aimRX.value = ax + 14
                        self.aimTY.value = ay - 14
                        self.aimBY.value = ay + 14
                    end
                end
            end
            -- Boss health bar: pinned above the boss's head once the
            -- first bolt lands (hp < max), hidden before that and on death.
            -- Level 1 shows MORGATHA; level 3 reuses the same bar for the
            -- GIGA (hp normalized to the bar's 400 scale), name swaps too.
            do
                local B = (self :: any).boss
                local G: any = (self :: any).l3giant
                local gPhase = (self :: any).l3phase
                local gigaLive = (self :: any).level == 3 and (gPhase == "giant" or gPhase == "dying")
                    and G ~= nil and (G.rise or 0) >= 1
                    and not self.crashed and (self.homeTarget or 0) <= 0
                    and (G.hp or 0) > 0
                local show = B ~= nil and B.on and self.round == 3
                    and not self.crashed and (self.homeTarget or 0) <= 0
                    and (B.hp or (B.max or BOSS_HP)) < (B.max or BOSS_HP) and (B.hp or 0) > 0
                if self.bossHp ~= nil then
                    if gigaLive and G ~= nil then
                        self.bossHp.value = math.max(0, (G.hp or 0) / GIANT_HP * 400.0)
                    elseif B ~= nil then
                        local bmax = B.max or BOSS_HP
                        if bmax < 1 then bmax = 1 end
                        self.bossHp.value = math.max(0, (B.hp or bmax) / bmax * 400.0)
                    end
                end
                if self.bossName ~= nil then
                    if gigaLive then self.bossName.value = "GIGA"
                    elseif B ~= nil and (B :: any).prime == true then self.bossName.value = "VOIDPUS PRIME" else self.bossName.value = "MORGATHA" end
                end
                if self.bossBarX ~= nil and self.bossBarY ~= nil and self.bossBarA ~= nil then
                    if show or gigaLive then
                        local hx, hy2, hz = 0, 0, 0
                        if gigaLive and G ~= nil then
                            hx = G.x
                            hy2 = groundH(G.x, G.z) + 6500.0
                            hz = G.z
                        elseif B ~= nil then
                            hx, hy2, hz = B.x, B.y + 110.0, B.z
                        end
                        local cx4, cy4, _, cw4 = mvp:transformVec4(hx, hy2, hz, 1)
                        if cw4 > 0.1 then
                            local nx, ny = cx4 / cw4, cy4 / cw4
                            if nx > -1.2 and nx < 1.2 and ny > -1.2 and ny < 1.2 then
                                local sx = (nx * 0.5 + 0.5) * self.cw - 62
                                local sy = (1 - (ny * 0.5 + 0.5)) * self.ch
                                self.bossBarX.value = sx
                                self.bossBarY.value = sy
                                if self.bossNameY ~= nil then self.bossNameY.value = sy - 22 end
                                self.bossBarA.value = 1
                            else
                                self.bossBarA.value = 0
                            end
                        else
                            self.bossBarA.value = 0
                        end
                    else
                        self.bossBarA.value = 0
                    end
                end
            end
        end)
        if not ok then self.gpuOk = false end
    end
    return true
end

function draw(self: Game, renderer: Renderer)
    if not self.gpuOk then return end
    if self.canvas == nil or self.pipeline == nil or self.vbo == nil
        or self.ubo == nil or self.bindGroup == nil or self.sampler == nil
        or self.depthView == nil then
        return
    end
    local ok = pcall(function()
        local canvas = self.canvas :: GPUCanvas
        -- First-load self-heal: the host can size the drawing surface
        -- without ever firing a layout resize, leaving hero/home stuck
        -- 800x500-small in a big viewport until a window adjust. The
        -- canvas knows the true size, so follow it on any divergence.
        -- Single pcall: any failure just skips the heal, draw continues.
        pcall(function()
            local cv = canvas :: any
            if cv.width ~= nil and cv.height ~= nil then
                local iw = math.max(1, math.floor(cv.width))
                local ih = math.max(1, math.floor(cv.height))
                if (iw ~= self.cw or ih ~= self.ch) and iw <= 8192 and ih <= 8192 then
                    setAny(self, "laidOut", nil)
                    resize(self, Vector.xy(iw, ih), 1)
                end
            end
            -- Cover-scale follow: the 3-4MB covers decode async on web, so
            -- the boot resize runs with 0-size dims and skips scale writes
            -- (0-guard), stranding hero/home at RML defaults while all
            -- pure-math HUD is correct. Re-assert scales every frame once
            -- dims exist; idempotent, ~4 cheap writes.
            do
                local hi = self.heroImg :: any
                if hi ~= nil and type(hi.width) == "number" and type(hi.height) == "number"
                    and hi.width > 0 and hi.height > 0 then
                    local hs = math.max(self.cw / hi.width, self.ch / hi.height)
                    if self.heroSX ~= nil then self.heroSX.value = hs end
                    if self.heroSY ~= nil then self.heroSY.value = hs end
                end
                local gi = self.homeImg :: any
                if gi ~= nil and type(gi.width) == "number" and type(gi.height) == "number"
                    and gi.width > 0 and gi.height > 0 then
                    local gs = math.max(self.cw / gi.width, self.ch / gi.height) * 1.12
                    if self.homeSX ~= nil then self.homeSX.value = gs end
                    if self.homeSY ~= nil then self.homeSY.value = gs end
                end
            end
        end)
        local pass = canvas:beginRenderPass({
            color = { { loadOp = "clear", storeOp = "store", clearColor = { 0.07, 0.04, 0.12, 1 } } },
            depthStencil = { view = self.depthView :: GPUTextureView, depthLoadOp = "clear", depthStoreOp = "discard", depthClearValue = 1 },
        })
        pass:setPipeline(self.pipeline :: GPUPipeline)
        pass:setVertexBuffer(0, self.vbo :: GPUBuffer)
        pass:setBindGroup(0, self.bindGroup :: GPUBindGroup)
        -- Level 2 lives INSIDE the haunted tunnel: desert map hidden,
        -- dark bore only. Every other level keeps the world.
        if not gateMode(self) then
            pass:draw(self.vertCount)
        end
        -- Jet: rigid airframe on CPU, draw in the same pass.
        -- Hidden once wrecked: the debris chunks ARE the broken jet now.
        local heroVbo = self.heroVbo
        local heroCpu = self.heroCpu
        if heroVbo ~= nil and heroCpu ~= nil and not self.crashed
            and self.heroPipe ~= nil and self.heroBind ~= nil then
            local bank = (self :: any).bank or 0
            local pitch = 0
            if self.grounded then
                -- On the gear: throttle squat, full rotate pose on W near Vr.
                local gspdNow = (self :: any).gspd or 0
                local wHeld = (self.keyF ~= nil and self.keyF.value) or held(self, 119, 87, 265)
                if wHeld and gspdNow >= VR - 6 then
                    pitch = -0.35 -- rotating
                else
                    pitch = -0.10 * self.roll
                end
            elseif self.vy > 0.5 then
                pitch = -0.30 -- climbing nose-up
            elseif self.vy < -0.5 then
                pitch = 0.25 -- diving nose-down
            elseif self.moving then
                pitch = -0.14 -- level cruise
            end
            pitch += 0.03 * math.sin(self.time * 2.0)
            -- Exhaust: short stub on the roll, plume length tracks cruising
            -- speed in the air (slow cruise = short flame, full chat = lance).
            local boostOn = (self :: any).boostOn or false
            local spdNow = (self :: any).fwd or 0
            local est: number
            if self.grounded then
                est = 0.7 + 0.5 * self.roll
            else
                est = 0.45 + 1.9 * math.clamp(spdNow / TOP_SPEED, 0, 1)
                if boostOn then est += 0.2 end
            end
            est *= 1 + 0.10 * math.sin(self.time * 37.0) + 0.06 * math.sin(self.time * 61.0 + 1.7)
            local gearDn = (self.grounded and not self.crashed) and 1 or 0
            local swings = { pitch, bank, est, self.time, gearDn, (self :: any).wheelSpin or 0, (self :: any).planeTint or 4 }
            local gy = groundH(self.tx, self.tz)
            buildHero(heroCpu, self.tx, gy + self.hy, self.tz, self.yaw, swings, (self :: any).hitFlash or 0, (self :: any).gigaGlow or 0);
            (heroVbo :: GPUBuffer):write(heroCpu);
            pass:setPipeline(self.heroPipe :: GPUPipeline)
            pass:setBindGroup(0, self.heroBind :: GPUBindGroup)
            pass:setVertexBuffer(0, heroVbo)
            pass:draw(HERO_VERTS)
            -- Back to the world pipeline for beams, wind, and debris.
            pass:setPipeline(self.pipeline :: GPUPipeline)
            pass:setBindGroup(0, self.bindGroup :: GPUBindGroup)
        end
        -- Golden beam projectiles: oriented core + halo each, same pass.
        -- Only live bolts are packed into the buffer; stale slots emit nothing.
        if self.beamVbo ~= nil and self.beamCpu ~= nil then
            local beamVbo = self.beamVbo :: GPUBuffer
            local beamCpu = self.beamCpu :: buffer
            local pulse = 0.35 * math.sin(self.time * 14.0)
            local o = 0
            for _, b in ipairs(self.beams) do
                if b.on then
                    local yaw = math.atan2(b.vx, b.vz)
                    o = buildBeam(beamCpu, o, b.x, b.y, b.z, yaw, pulse, b.gun, b.stretch);
                end
            end
            -- Round-2 mystery orbs ride the same buffer (sized for both).
            for _, e in ipairs((self :: any).orbs) do
                if e.on then
                    local yaw = math.atan2(e.vx, e.vz)
                    o = buildBeam(beamCpu, o, e.x, e.y, e.z, yaw, pulse, e.kind or 4, 1.0);
                end
            end
            local nVerts = o / 24
            if nVerts > 0 then
                (beamVbo):write(beamCpu);
                pass:setVertexBuffer(0, beamVbo)
                pass:draw(nVerts)
            end
        end
        -- Level 1 floating pumpkins on their own WGSL foe pipeline.
        -- Skipped entirely until tutorials complete.
        if self.foeVbo ~= nil and self.foeCpu ~= nil
            and self.foePipe ~= nil and self.foeBind ~= nil
            and ((self :: any).tutDone or false) then
            local foeVbo = self.foeVbo :: GPUBuffer
            local foeCpu = self.foeCpu :: buffer
            local o = 0
            for _, f in ipairs(self.foes) do
                if f.on then
                    o = buildFoe(foeCpu, o, f)
                end
            end
            local nVerts = o / 28
            if nVerts > 0 then
                (foeVbo):write(foeCpu);
                pass:setPipeline(self.foePipe :: GPUPipeline)
                pass:setBindGroup(0, self.foeBind :: GPUBindGroup)
                pass:setVertexBuffer(0, foeVbo)
                pass:draw(nVerts)
                -- Back to the world pipeline for wind and debris.
                pass:setPipeline(self.pipeline :: GPUPipeline)
                pass:setBindGroup(0, self.bindGroup :: GPUBindGroup)
            end
        end
        -- MORGATHA on the same WGSL foe pipeline (ghost-eye band included).
        do
            local B = (self :: any).boss
            if B ~= nil and B.on and self.bossVbo ~= nil and self.bossCpu ~= nil
                and self.foePipe ~= nil and self.foeBind ~= nil
                and ((self :: any).tutDone or false) then
                local bossVbo = self.bossVbo :: GPUBuffer
                local bossCpu = self.bossCpu :: buffer
                local o = buildBoss(bossCpu, 0, B)
                local nVerts = o / 28
                if nVerts > 0 then
                    (bossVbo):write(bossCpu);
                    pass:setPipeline(self.foePipe :: GPUPipeline)
                    pass:setBindGroup(0, self.foeBind :: GPUBindGroup)
                    pass:setVertexBuffer(0, bossVbo)
                    pass:draw(nVerts)
                    pass:setPipeline(self.pipeline :: GPUPipeline)
                    pass:setBindGroup(0, self.bindGroup :: GPUBindGroup)
                end
            end
        end
        -- Level 2 circus gates on their own WGSL gate pipeline.
        -- Rebuilt every frame (movers drift); the live ring burns white,
        -- upcoming rings run dim, cleared ones sink to ember.
        if gateMode(self) and self.gateVbo ~= nil and self.gateCpu ~= nil
            and self.gatePipe ~= nil and self.gateBind ~= nil
            and #self.gates >= GATE_N and (self.homeTarget or 0) <= 0 then
            local gateVbo = self.gateVbo :: GPUBuffer
            local gateCpu = self.gateCpu :: buffer
            local o = 0
            local uwx = (self :: any).uwx or self.tx
            local uwz = (self :: any).uwz or self.tz
            -- 15 wall rings draw in drawWalls; the exit portal draws below.
            -- exit portal: bright-white core + pinkish caps at the tunnel end.
            do
                local bl = self.gates[GATE_N]
                local pph = 100.0 + (self.time % 1.0) -- state 1: white-hot pulse (fract keeps st=1 forever)
                o = buildDot(gateCpu, o, self.tx + (bl.ax - uwx), bl.ay, self.tz + (bl.az + 3000.0 - uwz), 330, 330, 30, 1.0, 1.0, 1.0, pph) -- white-hot end wall (seals the bore: touch it to win)
                o = buildDot(gateCpu, o, self.tx + (bl.ax - uwx), bl.ay + 340, self.tz + (bl.az + 3000.0 - uwz), 420, 60, 30, 1.0, 0.55, 0.75, pph) -- pinkish top
                o = buildDot(gateCpu, o, self.tx + (bl.ax - uwx), bl.ay - 340, self.tz + (bl.az + 3000.0 - uwz), 420, 60, 30, 1.0, 0.55, 0.75, pph) -- pinkish bottom
            end
            -- Wall visuals for gates 1-11 (slabs, gaps, eyes, sliders, slots).
-- One loop in drawWalls below: static pairs share branches, sliders ride
-- the same sine the pass checks use. State 2 keeps the rock color.
            o = drawWalls(self, gateCpu, uwx, uwz, o) -- all 15 walls, own scope
            o = drawWalls2(self, gateCpu, uwx, uwz, o) -- second ring: fan/rocks/slit
            local nVerts = o / 28
            if nVerts > 0 then
                (gateVbo):write(gateCpu);
                pass:setPipeline(self.gatePipe :: GPUPipeline)
                pass:setBindGroup(0, self.gateBind :: GPUBindGroup)
                pass:setVertexBuffer(0, gateVbo)
                pass:draw(nVerts)
                pass:setPipeline(self.pipeline :: GPUPipeline)
                pass:setBindGroup(0, self.bindGroup :: GPUBindGroup)
            end
        end
        -- Haunted tunnel bore: dark Halloween tube around the whole
        -- course, drawn in level 2 only (map is hidden there).
        if gateMode(self) and self.auroraVbo ~= nil and self.auroraCpu ~= nil
            and self.auroraPipe ~= nil and self.auroraBind ~= nil
            and #self.gates >= GATE_N and (self.homeTarget or 0) <= 0 then
            local tubV = self.auroraVbo :: GPUBuffer
            local tubC = self.auroraCpu :: buffer
            local oo = buildTube(tubC, 0, self.gates)
            local tn = oo / 28
            if tn > 0 then
                (tubV):write(tubC);
                pass:setPipeline(self.auroraPipe :: GPUPipeline)
                pass:setBindGroup(0, self.auroraBind :: GPUBindGroup)
                pass:setVertexBuffer(0, tubV)
                pass:draw(tn)
                pass:setPipeline(self.pipeline :: GPUPipeline)
                pass:setBindGroup(0, self.bindGroup :: GPUBindGroup)
            end
        end
        -- Level 3 ground army (baked static, world pipeline) + sandstorm
        -- wall on its own WGSL storm pipeline. Level-gated: the same
        -- dunes stay empty in levels 1 and 2.
        if (self :: any).level == 3 then
            -- march clock into the zombie pipe (break time, or hold).
            -- merge aims the horde at the center instead of the jet.
            if self.zubo ~= nil and self.zuboCpu ~= nil then
                local zc = self.zuboCpu :: buffer
                local phz = (self :: any).l3phase
                local mode, spd, holdR, cx, cz = 0, 0.0, 800.0, 0, 0
                if phz == "merge" or phz == "magma" then
                    mode, spd, holdR = 1, 1500.0, 10.0 -- full sprint into the heart
                    cx = (self :: any).l3mergeX or 0
                    cz = (self :: any).l3mergeZ or 0
                elseif phz == "giant" or phz == "dying" then
                    mode = 2 -- hold: the giant acts on CPU (dying included:
                    -- mode 0 would march the corpse at the jet AND kill the
                    -- creature-lighting/crack path in the shader)
                end
                buffer.writef32(zc, 0, (self :: any).l3marchT or -1)
                buffer.writef32(zc, 4, spd)
                buffer.writef32(zc, 8, holdR)
                buffer.writef32(zc, 12, mode)
                buffer.writef32(zc, 16, cx)
                buffer.writef32(zc, 20, cz)
                -- GIGA rage bus: enrage + strike telegraph ride the pads
                -- into zombie.wgsl (gated on mode 2 there; horde unaffected).
                -- Doom rides pad 3: 0->1 through the dying cinema, driving
                -- the crack-split + magma-glow death in the shader.
                local rage, flash, doom = 0, 0, 0
                local GG: any = (self :: any).l3giant
                if (phz == "giant" or phz == "dying") and GG ~= nil then
                    if GG.enraged then rage = 1 end
                    if (GG.windT or 0) > 0 then flash = 1 end
                    if phz == "dying" then doom = math.clamp((GG.deathT or 0) / 2.4, 0, 1) end
                end
                buffer.writef32(zc, 24, rage)
                buffer.writef32(zc, 28, flash)
                buffer.writef32(zc, 32, doom)
                ;(self.zubo :: GPUBuffer):write(zc);
            end
            pass:setPipeline(self.pipeline :: GPUPipeline)
            pass:setBindGroup(0, self.bindGroup :: GPUBindGroup)
            if self.armyVbo ~= nil and self.zombiePipe ~= nil and self.zombieBind ~= nil
                and not ((self :: any).armyHidden or false) then
                -- batched kill upload: at most one full rewrite per frame
                if ((self :: any).l3armyDirty or false) and self.armyCpu ~= nil then
                    setAny(self, "l3armyDirty", false)
                    ;(self.armyVbo :: GPUBuffer):write(self.armyCpu :: buffer);
                end
                pass:setPipeline(self.zombiePipe :: GPUPipeline)
                pass:setBindGroup(0, self.zombieBind :: GPUBindGroup)
                pass:setVertexBuffer(0, self.armyVbo :: GPUBuffer)
                pass:draw(ARMY_VERTS)
                pass:setPipeline(self.pipeline :: GPUPipeline)
                pass:setBindGroup(0, self.bindGroup :: GPUBindGroup)
            end
            -- Magma ball / giant boss on the zombie pipe: tiny dynamic VBO
            -- rebuilt per frame (432 verts max — nothing next to the horde).
            do
                local phg = (self :: any).l3phase
                if (phg == "merge" or phg == "magma" or phg == "giant" or phg == "dying") and self.giantCpu ~= nil and self.giantVbo ~= nil
                    and self.zombiePipe ~= nil and self.zombieBind ~= nil then
                    local gc = self.giantCpu :: buffer
                    local go = 0
                    local mx = (self :: any).l3mergeX or L3_ARMY_X
                    local mz = (self :: any).l3mergeZ or L3_ARMY_Z
                    local gyM = groundH(mx, mz) - 0.3
                    if phg == "magma" or phg == "merge" then
                        -- 5x magma half-globe: stacked octagon drums sunk halfway
                        -- under the dunes, WGSL-skinned magma-red. Seeds during
                        -- the run-in (marchers see their target), full by detonation.
                        local grow = 0.5 + 0.5 * math.clamp(((self :: any).l3magmaT or 0) / 8.0, 0, 1.0)
                        if phg == "merge" then grow = 0.05 + 0.45 * (1.0 - ((self :: any).l3mergeT or 18.0) / 18.0) end
                        local mv = 1.0
                        go = buildFan(gc, go, mx, gyM + 15.0, mz, 9375.0 * grow,
                            1.0 * mv, 1.0 * mv, 1.0 * mv) -- white globe base (WGSL skins it magma-red)
                        local prof = {
                            { 8750.0, 8000.0, 1750.0 }, { 8000.0, 7000.0, 1750.0 },
                            { 7000.0, 5750.0, 1625.0 }, { 5750.0, 4250.0, 1625.0 },
                            { 4250.0, 2500.0, 1500.0 }, { 2500.0, 750.0, 1375.0 },
                        }
                        local yy = gyM - 4750.0 * grow
                        for s = 1, 6 do
                            local pr = prof[s]
                            local vv = 1.0 + (s % 3) * 0.1
                            go = buildDrum(gc, go, mx, yy, mz,
                                pr[1] * grow, pr[2] * grow, pr[3] * grow,
                                1.0 * vv, 1.0 * vv, 1.0 * vv)
                            yy += pr[3] * grow
                        end
                        go = buildFan(gc, go, mx, yy, mz, 750.0 * grow,
                            1.0, 1.0, 1.0) -- white-hot crown (globe-white: still + haze-proof)
                    else
                        -- the 7x GIGA: melee hunter, no gun — fists, not fire.
                        -- Every move reads from G.anim: legs pump on run,
                        -- arms rise on windup and smash through on recover,
                        -- the kick leg cocks and stomps, eyes track the jet.
                        local G: any = (self :: any).l3giant
                        if G ~= nil then
                            local r = math.max(G.rise or 0, 0.001) * 2.5 -- GIGA 10x: towers over the dunes
                            local sink = G.sink or 0
                            local sway = math.sin(self.time * 0.5) * 100.0 * r
                            if sink > 0 then sway += math.sin(self.time * 9.0) * 400.0 * sink end
                            local gx, gz = (G.x or mx) + sway, G.z or mz
                            -- death slump, not burial: the body sags as it
                            -- cracks (the blast consumes it, no sinking).
                            local drop = sink * 400.0 * r
                            -- facing: the frame turns to the jet (local -z is
                            -- the face). Frozen inside 200u so it never spins
                            -- when the jet is on top of it.
                            local fdx, fdz = self.tx - gx, self.tz - gz
                            local fdl = math.sqrt(fdx * fdx + fdz * fdz)
                            if fdl > 200.0 then
                                G.faceX = fdx / fdl
                                G.faceZ = fdz / fdl
                            end
                            local fx = G.faceX or 0
                            local fz = G.faceZ or -1
                            -- local (right, forward) -> world offset
                            local rx, rz = -fz, fx
                            -- ammo-hit glow: soft pulse, fades out fast
                            local fl = math.min(1, G.flashT or 0) * 0.4
                            local fr, fg, fb = 0.32 + fl, 0.42 + fl, 0.20 + fl
                            local rr, rg, rb = 0.22 + fl, 0.20 + fl, 0.15 + fl
                            local anim = G.anim or ""
                            local run = 0
                            if (G.rise or 0) >= 1 and (anim == "run" or anim == "sprint") then
                                local rate = 9.0
                                if anim == "sprint" then rate = 13.0 end
                                run = math.sin(self.time * rate) * 200.0 * r
                            end
                            local aLy, aRy, aLz, aRz = 0, 0, 0, 0
                            local kickUp = 0
                            -- hand-hit choreography: the striking arm RISES
                            -- progressively through the windup (slow
                            -- anticipation, ease-out) then DRIVES down past
                            -- neutral into follow-through (fast slam,
                            -- ease-in). No teleporting — motion every frame.
                            local wMax = G.windMax or 0.75
                            local rMax = G.recMax or 0.4
                            if anim == "windL" or anim == "windR" then
                                local k = math.clamp(1 - (G.windT or 0) / wMax, 0, 1)
                                local lift = (1 - (1 - k) * (1 - k)) * 750.0 * r
                                if anim == "windL" then
                                    aLy = lift
                                    aRy = -150.0 * r * k -- counter-arm drops
                                else
                                    aRy = lift
                                    aLy = -150.0 * r * k
                                end
                            elseif anim == "windKick" then kickUp = 1.0 end
                            if anim == "recover" then
                                if G.windKind == "left" or G.windKind == "right" then
                                    local k = math.clamp(1 - (G.recT or 0) / rMax, 0, 1)
                                    -- slam: +750 start to -650 follow-through
                                    local slam = 750.0 - (750.0 + 650.0) * k * k
                                    slam *= r
                                    if G.windKind == "left" then
                                        aLy = slam
                                        aRy = 250.0 * r * k -- other fist flings up
                                    else
                                        aRy = slam
                                        aLy = 250.0 * r * k
                                    end
                                elseif G.windKind == "kick" then kickUp = -0.4 end
                            end
                            if anim == "enrage" then
                                aLy = 300.0 * r
                                aRy = 300.0 * r
                            end
                            if anim == "run" or anim == "walk" then
                                aLz = run * 0.6
                                aRz = -run * 0.6
                            end
                            -- charge lean: upper body lunges at the plane.
                            -- Slam lunge: the torso throws itself into every
                            -- hand hit (forward heave on recover).
                            local leanX, leanZ = 0, 0
                            if anim == "run" or anim == "sprint" or anim == "walk" then
                                local ldx, ldz = self.tx - gx, self.tz - gz
                                local ldl = math.sqrt(ldx * ldx + ldz * ldz)
                                if ldl > 0.001 then
                                    local lean = math.min(200.0, ldl * 0.05) * r
                                    leanX = ldx / ldl * lean
                                    leanZ = ldz / ldl * lean
                                end
                            elseif anim == "recover" and (G.windKind == "left" or G.windKind == "right") then
                                local ldx, ldz = self.tx - gx, self.tz - gz
                                local ldl = math.sqrt(ldx * ldx + ldz * ldz)
                                if ldl > 0.001 then
                                    local k = math.clamp(1 - (G.recT or 0) / (G.recMax or 0.4), 0, 1)
                                    local lunge = 350.0 * r * math.sin(k * math.pi)
                                    leanX = ldx / ldl * lunge
                                    leanZ = ldz / ldl * lunge
                                end
                            elseif anim == "windL" or anim == "windR" then
                                -- windup coils BACK slightly (anticipation)
                                local ldx, ldz = self.tx - gx, self.tz - gz
                                local ldl = math.sqrt(ldx * ldx + ldz * ldz)
                                if ldl > 0.001 then
                                    local k = math.clamp(1 - (G.windT or 0) / (G.windMax or 0.75), 0, 1)
                                    leanX = -ldx / ldl * 150.0 * r * k
                                    leanZ = -ldz / ldl * 150.0 * r * k
                                end
                            end
                            -- eyes track the jet; burn states feed the WGSL bands
                            local ex = math.clamp((self.tx - gx) / 800.0, -1, 1) * 60.0 * r
                            local er, eg, eb = 0.55 + fl, 1.0 + fl, 0.35 + fl
                            if G.enraged then er, eg, eb = 1.0 + fl, 0.35 + fl, 0.1 + fl end
                            if (G.windT or 0) > 0 then er, eg, eb = 0.8 + fl, 1.0 + fl, 0.3 + fl end
                            -- eyes burn till the blast: no dimming, the magma
                            -- death takes it at full blaze.
                            -- local (right, fwd) -> world, so the frame walks
                            -- the way it faces (local -z is the face)
                            local function gpos(lx: number, lz: number): (number, number)
                                return gx + rx * lx + fx * -lz, gz + rz * lx + fz * -lz
                            end
                            -- head turn: the skull yaws toward the jet (±0.5
                            -- rad) while the torso twists a third of that —
                            -- body hunts, head locks on, Godzilla-style.
                            local hdx, hdz = self.tx - gx, self.tz - gz
                            local hdl = math.sqrt(hdx * hdx + hdz * hdz)
                            local headYaw = 0
                            if hdl > 0.001 then
                                local want = math.atan2(hdx, hdz)
                                local have = math.atan2(fx, fz)
                                local dd = want - have
                                while dd > math.pi do dd -= 2 * math.pi end
                                while dd < -math.pi do dd += 2 * math.pi end
                                headYaw = math.clamp(dd, -0.5, 0.5) * r
                            end
                            local jaw = G.jaw or 0
                            local blinkK = 1.0
                            if (G.blinkT or 0) > 0 then blinkK = 0.12 end
                            local walk = 0
                            if (G.rise or 0) >= 1 and (anim == "walk" or anim == "run" or anim == "sprint") then
                                local rate = 5.0
                                if anim == "run" then rate = 9.0 end
                                if anim == "sprint" then rate = 13.0 end
                                walk = math.sin(self.time * rate) * r
                            end
                            local bob = math.abs(walk) * 60.0
                            local twist = headYaw * 0.3
                            local tr, tg, tb = 0.86, 0.82, 0.70 -- teeth ivory
                            local mr, mg, mb = 0.16, 0.03, 0.02 -- maw gut
                            local sr, sg, sb = 0.55, 0.62, 0.72 -- bone spikes
                            -- FULL-BODY RIG (70 boxes, 560 corners): segmented
                            -- legs with feet + toes, stacked twisting torso,
                            -- hanging arms with knuckle fingers, plated head
                            -- with snout + drop lids, spike row, tail.
                            local stride = walk * 220.0 -- long bounding leaps at 5x pace
                            local lift = math.abs(walk) * 40.0
                            local tailSw = math.sin(self.time * 1.7) * 60.0 * r
                            local upY = bob * 0.5 - drop -- upper-body lift
                            local blinkDrop = 0
                            if (G.blinkT or 0) > 0 then blinkDrop = 95.0 * r end
                            local jawDrop = jaw * 170.0 * r
                            local jawFwd = jaw * 90.0 * r
                            local hYaw = headYaw * 700.0
                            -- LEGS: drum-built thighs/shins (octagonal muscle
                            -- masses, not square blocks) + box feet/toes.
                            -- Opposite-phase pump; right cocks on kick.
                            for _, sd in ipairs({ -1, 1 }) do
                                local st = stride * sd
                                local ky, kz = 0, st
                                if sd > 0 and kickUp ~= 0 then
                                    ky = kickUp * 250.0 * r
                                    kz = -kickUp * 350.0 * r
                                end
                                local hipX, hipZ = gpos(210.0 * sd * r, st * 0.5)
                                -- thigh: thick top tapering to knee
                                go = buildDrum(gc, go, hipX, gyM + 400.0 * r - drop + ky * 0.5, hipZ + kz * 0.3,
                                    200.0 * r, 145.0 * r, 500.0 * r, rr, rg, rb)
                                -- knee cap: small hard box over the joint
                                go = buildBox6(gc, go, hipX, gyM + 400.0 * r - drop + ky * 0.5, hipZ + kz * 0.3 - 120.0 * r, 130.0 * r, 70.0 * r, 60.0 * r, rr * 1.15, rg * 1.15, rb * 1.15)
                                local shX, shZ = gpos(210.0 * sd * r, -st)
                                -- shin: calf bulge top, narrow ankle
                                go = buildDrum(gc, go, shX, gyM + 60.0 * r - drop - lift + ky * 0.5, shZ + kz * 0.5,
                                    155.0 * r, 105.0 * r, 340.0 * r, rr * 0.92, rg * 0.92, rb * 0.92)
                                -- calf meat: rear bulge box behind the shin
                                go = buildBox6(gc, go, shX, gyM + 270.0 * r - drop + ky * 0.5, shZ + 170.0 * r + kz * 0.5, 100.0 * r, 130.0 * r, 90.0 * r, fr * 0.85, fg * 0.85, fb * 0.85)
                                go = buildBox6(gc, go, shX, gyM + 95.0 * r - drop + ky * 0.5, shZ + kz * 0.5, 100.0 * r, 55.0 * r, 100.0 * r, rr, rg, rb)
                                local ftX, ftZ = gpos(210.0 * sd * r, -160.0 * r - st)
                                go = buildBox6(gc, go, ftX, gyM + 60.0 * r - drop + ky * 0.3, ftZ + kz * 0.5, 130.0 * r, 60.0 * r, 200.0 * r, rr * 1.1, rg * 1.1, rb * 1.1)
                                for ti = -1, 1 do
                                    local toX, toZ = gpos(210.0 * sd * r + ti * 85.0 * r, -330.0 * r - st)
                                    go = buildBox6(gc, go, toX, gyM + 35.0 * r - drop + ky * 0.3, toZ + kz * 0.5, 45.0 * r, 35.0 * r, 90.0 * r, rr * 1.2, rg * 1.2, rb * 1.2)
                                end
                            end
                            -- PELVIS + stacked twisting torso: drums give a
                            -- round gut/chest (boxes read square at 7x).
                            -- Belly rides light (gut), back ridge dark.
                            local pelX, pelZ = gpos(0, 0)
                            go = buildDrum(gc, go, pelX, gyM + 770.0 * r - drop, pelZ,
                                300.0 * r, 340.0 * r, 360.0 * r, rr * 1.05, rg * 1.05, rb * 1.05)
                            local belX, belZ = gpos(twist * 200.0, 60.0 * r)
                            go = buildDrum(gc, go, belX, gyM + 1035.0 * r - drop + bob * 0.2, belZ,
                                330.0 * r, 290.0 * r, 200.0 * r, fr * 1.02, fg * 1.02, fb * 1.02)
                            local lobX, lobZ = gpos(twist * 250.0, 140.0 * r)
                            go = buildBox6(gc, go, lobX, gyM + 1080.0 * r - drop + bob * 0.2, lobZ, 340.0 * r, 150.0 * r, 200.0 * r, rr * 0.9, rg * 0.9, rb * 0.9)
                            local torX, torZ = gpos(twist * 300.0, 0)
                            go = buildDrum(gc, go, torX, gyM + 1140.0 * r - drop + bob * 0.3, torZ,
                                330.0 * r, 390.0 * r, 330.0 * r, fr * 0.98, fg * 0.98, fb * 0.98)
                            local chX, chZ = gpos(twist * 500.0, 0)
                            go = buildDrum(gc, go, chX, gyM + 1520.0 * r - drop + bob * 0.5, chZ,
                                400.0 * r, 330.0 * r, 300.0 * r, fr * 1.06, fg * 1.06, fb * 1.06)
                            for _, sd in ipairs({ -1, 1 }) do
                                local pcX, pcZ = gpos(180.0 * sd * r + twist * 500.0, -200.0 * r)
                                go = buildBox6(gc, go, pcX, gyM + 1650.0 * r - drop + bob * 0.5, pcZ, 170.0 * r, 120.0 * r, 100.0 * r, fr * 1.1, fg * 1.1, fb * 1.1)
                            end
                            local ubX, ubZ = gpos(twist * 550.0, 180.0 * r)
                            go = buildDrum(gc, go, ubX, gyM + 1510.0 * r - drop + bob * 0.5, ubZ,
                                340.0 * r, 300.0 * r, 270.0 * r, rr, rg, rb)
                            -- ARMS: drum-built upper/fore (round muscle) +
                            -- delt cap, elbow, wrist, fist, fingers.
                            -- Swinging against the legs, raised by windup.
                            for _, sd in ipairs({ -1, 1 }) do
                                local aY = aLy
                                if sd > 0 then aY = aRy end
                                local swz = -sd * walk * 90.0
                                if sd < 0 then swz += aLz else swz += aRz end
                                local shx = 560.0 * sd * r + twist * 500.0
                                local dlX, dlZ = gpos(shx, -100.0 * r + swz)
                                go = buildBox6(gc, go, dlX + leanX, gyM + 1640.0 * r + upY + aY * 0.3, dlZ + leanZ, 150.0 * r, 140.0 * r, 150.0 * r, rr * 1.1, rg * 1.1, rb * 1.1)
                                local uaX, uaZ = gpos(540.0 * sd * r + twist * 500.0, -300.0 * r + swz)
                                go = buildDrum(gc, go, uaX + leanX, gyM + 1230.0 * r + upY + aY * 0.6, uaZ + leanZ,
                                    125.0 * r, 100.0 * r, 300.0 * r, rr * 0.95, rg * 0.95, rb * 0.95)
                                local elX, elZ = gpos(540.0 * sd * r + twist * 500.0, -360.0 * r + swz)
                                go = buildBox6(gc, go, elX + leanX, gyM + 1130.0 * r + upY + aY * 0.7, elZ + leanZ, 100.0 * r, 70.0 * r, 100.0 * r, fr * 0.9, fg * 0.9, fb * 0.9)
                                local foX, foZ = gpos(540.0 * sd * r + twist * 500.0, -430.0 * r + swz)
                                go = buildDrum(gc, go, foX + leanX, gyM + 865.0 * r + upY + aY * 0.85, foZ + leanZ,
                                    115.0 * r, 90.0 * r, 260.0 * r, rr * 1.05, rg * 1.05, rb * 1.05)
                                local wrX, wrZ = gpos(540.0 * sd * r + twist * 500.0, -480.0 * r + swz)
                                go = buildBox6(gc, go, wrX + leanX, gyM + 790.0 * r + upY + aY, wrZ + leanZ, 85.0 * r, 55.0 * r, 85.0 * r, fr, fg, fb)
                                local fiX, fiZ = gpos(540.0 * sd * r + twist * 500.0, -540.0 * r + swz)
                                go = buildBox6(gc, go, fiX + leanX, gyM + 660.0 * r + upY + aY, fiZ + leanZ, 150.0 * r, 135.0 * r, 150.0 * r, rr * 1.2, rg * 1.2, rb * 1.2)
                                -- knuckle ridge: bony bar across the fist top
                                go = buildBox6(gc, go, fiX + leanX, gyM + 760.0 * r + upY + aY, fiZ + leanZ - 40.0 * r, 150.0 * r, 35.0 * r, 60.0 * r, sr + fl, sg + fl, sb + fl)
                                for fi = -1, 1 do
                                    local fgX, fgZ = gpos(540.0 * sd * r + fi * 95.0 * r + twist * 500.0, -700.0 * r + swz)
                                    go = buildBox6(gc, go, fgX + leanX, gyM + 640.0 * r + upY + aY, fgZ + leanZ, 45.0 * r, 45.0 * r, 110.0 * r, rr * 1.3, rg * 1.3, rb * 1.3)
                                end
                            end
                            -- DORSAL SPIKES: five bone fins down the back.
                            for si = 1, 5 do
                                local spX, spZ = gpos(twist * (400.0 + si * 40.0), 280.0 * r + si * 70.0 * r)
                                go = buildBox6(gc, go, spX, gyM + (1780.0 - si * 190.0) * r - drop + bob * 0.5, spZ, 90.0 * r, (180.0 - si * 22.0) * r, 90.0 * r, sr + fl, sg + fl, sb + fl)
                            end
                            -- TAIL: four counter-swaying tapering drums behind.
                            for ti = 1, 4 do
                                local tsw = math.sin(self.time * 1.7 + ti * 0.8) * 60.0 * r * ti / 4.0 + tailSw * ti / 4.0
                                local taX, taZ = gpos(tsw, 420.0 * r + ti * 260.0 * r)
                                local tr0 = (210.0 - ti * 32.0) * r
                                go = buildDrum(gc, go, taX, gyM + (820.0 - ti * 120.0) * r - drop, taZ,
                                    tr0, tr0 * 0.78, 260.0 * r, rr * (0.95 + ti * 0.05), rg * (0.95 + ti * 0.05), rb * (0.95 + ti * 0.05))
                            end
                            -- NECK + plated HEAD: drum skull (round cranium,
                            -- tapered snout boxes), brow overhang, all on hYaw.
                            local neckX, neckZ = gpos(twist * 550.0, 0)
                            go = buildDrum(gc, go, neckX, gyM + 1800.0 * r + upY, neckZ,
                                190.0 * r, 150.0 * r, 300.0 * r, rr * 1.05, rg * 1.05, rb * 1.05)
                            local napeX, napeZ = gpos(twist * 550.0, 150.0 * r)
                            go = buildBox6(gc, go, napeX, gyM + 2000.0 * r + upY, napeZ, 160.0 * r, 140.0 * r, 160.0 * r, rr * 0.9, rg * 0.9, rb * 0.9)
                            local headX, headZ = gpos(hYaw, -40.0 * r)
                            go = buildDrum(gc, go, headX + leanX, gyM + 2170.0 * r + upY, headZ + leanZ,
                                270.0 * r, 220.0 * r, 330.0 * r, fr * 1.08, fg * 1.08, fb * 1.08)
                            local snX, snZ = gpos(hYaw, -250.0 * r)
                            go = buildBox6(gc, go, snX + leanX, gyM + 2180.0 * r + upY, snZ + leanZ, 200.0 * r, 130.0 * r, 180.0 * r, fr, fg, fb)
                            local nbX, nbZ = gpos(hYaw, -280.0 * r)
                            go = buildBox6(gc, go, nbX + leanX, gyM + 2300.0 * r + upY, nbZ + leanZ, 120.0 * r, 80.0 * r, 120.0 * r, fr * 1.05, fg * 1.05, fb * 1.05)
                            local browX, browZ = gpos(headYaw * 750.0, -220.0 * r)
                            go = buildBox6(gc, go, browX + leanX, gyM + 2400.0 * r + upY, browZ + leanZ, 240.0 * r, 70.0 * r, 90.0 * r, fr * 1.15, fg * 1.15, fb * 1.15)
                            for _, sd in ipairs({ -1, 1 }) do
                                local chX2, chZ2 = gpos(200.0 * sd * r + hYaw, -150.0 * r)
                                go = buildBox6(gc, go, chX2 + leanX, gyM + 2200.0 * r + upY, chZ2 + leanZ, 90.0 * r, 120.0 * r, 140.0 * r, fr, fg, fb)
                            end
                            local mtX, mtZ = gpos(hYaw, -300.0 * r)
                            go = buildBox6(gc, go, mtX + leanX, gyM + 2070.0 * r + upY - jaw * 40.0 * r, mtZ + leanZ, 170.0 * r, 40.0 * r, 60.0 * r, tr, tg, tb)
                            local jawX, jawZ = gpos(hYaw, -160.0 * r + jawFwd)
                            go = buildBox6(gc, go, jawX + leanX, gyM + 2050.0 * r + upY - jawDrop, jawZ + leanZ, 220.0 * r, 90.0 * r, 220.0 * r, rr * 1.15, rg * 1.15, rb * 1.15)
                            local chinX, chinZ = gpos(hYaw, -260.0 * r + jawFwd)
                            go = buildBox6(gc, go, chinX + leanX, gyM + 1990.0 * r + upY - jawDrop, chinZ + leanZ, 140.0 * r, 60.0 * r, 100.0 * r, rr * 1.2, rg * 1.2, rb * 1.2)
                            local mbX, mbZ = gpos(hYaw, -290.0 * r + jawFwd)
                            go = buildBox6(gc, go, mbX + leanX, gyM + 2110.0 * r + upY - jawDrop, mbZ + leanZ, 140.0 * r, 35.0 * r, 50.0 * r, tr * 0.95, tg * 0.95, tb * 0.95)
                            -- MOUTH GUT: dark throat slab visible when open
                            if jaw > 0.15 then
                                local moX, moZ = gpos(hYaw, -200.0 * r + jawFwd * 0.5)
                                go = buildBox6(gc, go, moX + leanX, gyM + 2100.0 * r + upY - jawDrop * 0.4, moZ + leanZ, 160.0 * r, (30.0 + jaw * 60.0) * r, 100.0 * r, mr, mg, mb)
                            end
                            -- EYES + drop lids: track the jet, slits on blink
                            for _, sd in ipairs({ -1, 1 }) do
                                local eyX, eyZ = gpos(120.0 * sd * r + ex + hYaw, -270.0 * r)
                                go = buildBox6(gc, go, eyX + leanX, gyM + 2330.0 * r + upY, eyZ + leanZ, 90.0 * r, 90.0 * r * blinkK, 90.0 * r, er, eg, eb)
                                go = buildBox6(gc, go, eyX + leanX, gyM + 2415.0 * r + upY - blinkDrop, eyZ + leanZ, 100.0 * r, 55.0 * r, 100.0 * r, fr * 1.1, fg * 1.1, fb * 1.1)
                            end
                        end
                    end
                    local gVerts = go / 28
                    if gVerts > 0 then
                        (self.giantVbo :: GPUBuffer):write(gc);
                        pass:setPipeline(self.zombiePipe :: GPUPipeline)
                        pass:setBindGroup(0, self.zombieBind :: GPUBindGroup)
                        pass:setVertexBuffer(0, self.giantVbo :: GPUBuffer)
                        pass:draw(gVerts)
                        pass:setPipeline(self.pipeline :: GPUPipeline)
                        pass:setBindGroup(0, self.bindGroup :: GPUBindGroup)
                    end
                end
            end
            local sk = (self :: any).l3stormK or 0
            local cells = (self :: any).stormCells
            if sk > 0.01 and cells ~= nil and self.stormVbo ~= nil and self.stormCpu ~= nil
                and self.stormPipe ~= nil and self.stormBind ~= nil then
                -- Curtains repack once per density step (wall is fixed; the
                -- WGSL boils + erodes them, rushes dust at the lens, and
                -- surges the faces net-zero). Back face thins out first.
                if sk ~= ((self :: any).l3stormKw or -1) then
                    setAny(self, "l3stormKw", sk)
                    local stormCpu = self.stormCpu :: buffer
                    local hx0 = (self :: any).l3stormX or L3_STORM_X
                    local hz0 = (self :: any).l3stormZ or L3_STORM_Z
                    local o = 0
                    for _, c in ipairs(cells) do
                        local cc: any = c
                        local dd = math.clamp(sk * (1.05 - cc.layer * 0.15), 0, 1)
                        if dd > 0.02 then
                            -- one thick wall: front + back face 6000 apart.
                            -- Back face goes first as sk falls (depth reveal).
                            o = buildStormCurtain(stormCpu, o, hx0, cc.yb,
                                hz0 + cc.zoff - STORM_DEPTH / 2,
                                275000.0, cc.h, 800.0, dd, cc.seed, 0)
                            local ddb = math.clamp(sk * 0.9, 0, 1)
                            if ddb > 0.02 then
                                o = buildStormCurtain(stormCpu, o, hx0, cc.yb,
                                    hz0 + cc.zoff + STORM_DEPTH / 2,
                                    275000.0, cc.h, 800.0, ddb, cc.seed + 0.5, 1)
                            end
                        end
                    end
                    local nVerts = o / 48
                    setAny(self, "l3stormNv", nVerts)
                    if nVerts > 0 then
                        (self.stormVbo :: GPUBuffer):write(stormCpu);
                    end
                end
                local nVerts = (self :: any).l3stormNv or 0
                if nVerts > 0 then
                    pass:setPipeline(self.stormPipe :: GPUPipeline)
                    pass:setBindGroup(0, self.stormBind :: GPUBindGroup)
                    pass:setVertexBuffer(0, self.stormVbo :: GPUBuffer)
                    pass:draw(nVerts)
                    pass:setPipeline(self.pipeline :: GPUPipeline)
                    pass:setBindGroup(0, self.bindGroup :: GPUBindGroup)
                end
            end
        end
        -- Blowing sand on its own WGSL pipeline (level 3 only): streaming
        -- sheets around the jet + camera whiteout veil when blind inside
        -- the wall. Sheet slots stream past deterministically (no state).
        if (self :: any).level == 3 and self.sandVbo ~= nil and self.sandCpu ~= nil
            and self.sandPipe ~= nil and self.sandBind ~= nil then
            local sandCpu = self.sandCpu :: buffer
            local so = 0
            -- far side is dead calm: past the wall (army side) there is no
            -- wind at all. Sheets only blow on the near side + runway.
            local szw = (self :: any).l3stormZ or L3_STORM_Z
            local nearSide = self.tz <= szw + 500.0 and (self :: any).l3stormK > 0
            if nearSide then
            local flowDens = 0.4
            if not self.grounded then flowDens = 0.6 end -- lots after liftoff
            local R = 2000.0
            for i = 1, SAND_N do
                local h1 = math.sin(i * 12.9898 + 4.2) * 43758.5453
                h1 -= math.floor(h1)
                local h2 = math.sin(i * 78.233 + 1.1) * 12543.1234
                h2 -= math.floor(h2)
                local h3 = math.sin(i * 37.719 + 8.8) * 14870.4445
                h3 -= math.floor(h3)
                -- stream toward -z past the jet, wrapping around it
                local span = R * 2
                local zo = (h2 * span - self.time * 260.0) % span - R
                -- giant gust volumes: max width, full height, everywhere
                -- around the plane — wherever it goes, it sits inside
                -- the wind. First 10 pinned onto the runway strip itself.
                local wx, wz
                if i <= 10 then
                    wx = RWY_CX + (h1 - 0.5) * 240.0
                    wz = RWY_CZ + ((h2 * 4000.0 - self.time * 260.0) % 4000.0) - 2000.0
                else
                    wx = self.tx + (h1 - 0.5) * 4000.0
                    wz = self.tz + zo
                end
                if wx > WRAP then wx -= WRAP * 2 elseif wx < -WRAP then wx += WRAP * 2 end
                if wz > WRAP then wz -= WRAP * 2 elseif wz < -WRAP then wz += WRAP * 2 end
                local wy = groundH(wx, wz) + 4.0 + h3 * 4600.0
                so = buildStormBox(sandCpu, so, wx, wy, wz,
                    150.0 + h1 * 250.0, 200.0 + h3 * 400.0, 300.0 + h2 * 450.0,
                    0.50, 0.33, 0.18, flowDens, i / SAND_N)
            end
            end -- nearSide: far side stays dead calm
            local sVerts = so / 48
            -- storm interior: sand dots packed huge inside the slab volume
            -- (front-to-back, dunes to crown), density follows the wall —
            -- this fill is what makes the wall read solid and real
            local skd = (self :: any).l3stormK or 0
            if skd > 0.02 then
                local hx0 = (self :: any).l3stormX or L3_STORM_X
                local hz0 = (self :: any).l3stormZ or L3_STORM_Z
                for i = 1, SAND_DOTS do
                    local q1 = math.sin(i * 12.9898 + 40.2) * 43758.5453
                    q1 -= math.floor(q1)
                    local q2 = math.sin(i * 78.233 + 10.1) * 12543.1234
                    q2 -= math.floor(q2)
                    local q3 = math.sin(i * 37.719 + 80.8) * 14870.4445
                    q3 -= math.floor(q3)
                    local qx = hx0 + (q1 - 0.5) * 60000.0
                    local qz = hz0 + (q2 - 0.5) * 4600.0
                    local qy = groundH(qx, qz) + 4.0 + q3 * 5200.0
                    local qs = 40.0 + q1 * 100.0
                    so = buildStormBox(sandCpu, so, qx, qy, qz,
                        qs, qs * 0.8, qs, 0.50, 0.33, 0.18,
                        math.clamp(skd * 1.5, 0, 0.95), i / SAND_DOTS)
                end
                sVerts = so / 48
            end
            so = buildStormBox(sandCpu, so, self.tx, self.hy, self.tz, 40.0, 200.0, 40.0, 0.50, 0.33, 0.18, (self :: any).l3blind or 0, 0.5)
            sVerts = so / 48
            if sVerts > 0 then
                (self.sandVbo :: GPUBuffer):write(sandCpu);
                pass:setPipeline(self.sandPipe :: GPUPipeline)
                pass:setBindGroup(0, self.sandBind :: GPUBindGroup)
                pass:setVertexBuffer(0, self.sandVbo :: GPUBuffer)
                pass:draw(sVerts)
                pass:setPipeline(self.pipeline :: GPUPipeline)
                pass:setBindGroup(0, self.bindGroup :: GPUBindGroup)
            end
        end
        -- Wind streaks: thin pale speed lines streaming past, same pass.
        if self.windVbo ~= nil and self.windCpu ~= nil then
            local windVbo = self.windVbo :: GPUBuffer
            local windCpu = self.windCpu :: buffer
            local fwdW = (self :: any).fwd or 18
            local wlen = math.min(120, 3.0 + fwdW * 0.05)
            -- Tilt streaks along the true flight path (climb/dive included).
            local wpitch = math.clamp(-self.vy / math.max(fwdW, 1), -0.5, 0.5)
            local o = 0
            for _, st in ipairs(self.winds) do
                if st.on then
                    o = buildWind(windCpu, o, st.x, st.y, st.z, self.yaw, wpitch, wlen * st.vx);
                end
            end
            local nVerts = o / 24
            if nVerts > 0 then
                (windVbo):write(windCpu);
                pass:setVertexBuffer(0, windVbo)
                pass:draw(nVerts)
            end
        end
        -- Crash blast chunks on their own WGSL pipeline: fire, flash,
        -- smoke, debris, sparks, dust, shockwave. Last draw in the pass.
        if self.chunkVbo ~= nil and self.chunkCpu ~= nil
            and self.blastPipe ~= nil and self.blastBind ~= nil then
            local chunkVbo = self.chunkVbo :: GPUBuffer
            local chunkCpu = self.chunkCpu :: buffer
            local o = 0
            for _, c in ipairs(self.chunks) do
                if c.on then
                    o = buildChunk(chunkCpu, o, c);
                end
            end
            local nVerts = o / 48
            if nVerts > 0 then
                (chunkVbo):write(chunkCpu);
                pass:setPipeline(self.blastPipe :: GPUPipeline)
                pass:setBindGroup(0, self.blastBind :: GPUBindGroup)
                pass:setVertexBuffer(0, chunkVbo)
                pass:draw(nVerts)
                -- Back to the world pipeline for the nuke billboards.
                pass:setPipeline(self.pipeline :: GPUPipeline)
                pass:setBindGroup(0, self.bindGroup :: GPUBindGroup)
            end
        end
        -- Atom bomb on its own WGSL pipeline: staged once at detonation,
        -- animated purely by shader time. Drawn ~12s, then retired.
        do
            local birth = (self :: any).l3nukeBirth or 0
            if birth > 0 and self.time - birth < 12.0
                and self.nukeVbo ~= nil and self.nukePipe ~= nil and self.nukeBind ~= nil then
                pass:setPipeline(self.nukePipe :: GPUPipeline)
                pass:setBindGroup(0, self.nukeBind :: GPUBindGroup)
                pass:setVertexBuffer(0, self.nukeVbo :: GPUBuffer)
                pass:draw(NUKE_VERTS)
                pass:setPipeline(self.pipeline :: GPUPipeline)
                pass:setBindGroup(0, self.bindGroup :: GPUBindGroup)
            end
        end
        -- Seeker missiles on their own WGSL pipeline: cruise bodies in
        -- flight + staged explosion billboards (fireball + shock ring).
        if self.mslVbo ~= nil and self.mslCpu ~= nil
            and self.mslPipe ~= nil and self.mslBind ~= nil then
            local mslVbo = self.mslVbo :: GPUBuffer
            local mslCpu = self.mslCpu :: buffer
            local o = 0
            local mi = 0
            for _, m in ipairs(self.msls) do
                if m.on then
                    mi += 1
                    o = buildMsl(mslCpu, o, m, (mi * 0.37) % 1.0);
                end
            end
            for _, mb in ipairs(self.mslBooms) do
                if mb.on and self.time - mb.birth < 1.5 then
                    o = buildNukeQuad(mslCpu, o, mb.x, mb.y, mb.z, mb.kind, mb.size, mb.size, mb.size, mb.seed, mb.birth);
                elseif mb.on then
                    mb.on = false
                end
            end
            local nVerts = o / 48
            if nVerts > 0 then
                (mslVbo):write(mslCpu);
                pass:setPipeline(self.mslPipe :: GPUPipeline)
                pass:setBindGroup(0, self.mslBind :: GPUBindGroup)
                pass:setVertexBuffer(0, mslVbo)
                pass:draw(nVerts)
                pass:setPipeline(self.pipeline :: GPUPipeline)
                pass:setBindGroup(0, self.bindGroup :: GPUBindGroup)
            end
        end
        pass:finish()
        renderer:drawImage(canvas.image, self.sampler :: ImageSampler, "srcOver", 1)
        -- Moon: locked to a fixed sky direction, carried with the jet so
        -- there is no parallax slide (like a real moon at infinity).
        -- High in the northern sky; turning away hides it, like it should.
        -- Hidden in level 2 + 3: circus / storm own that sky.
        local moon = self.moonImg
        if moon ~= nil and (self :: any).level ~= 3 and (self :: any).level ~= 2 then
            local mx = self.tx + 0.22 * 30000.0
            local my = groundH(self.tx, self.tz) + self.hy + 0.38 * 30000.0
            local mz = self.tz + 0.90 * 30000.0
            local gy0 = groundH(self.tx, self.tz)
            local back, camH, camLh = camFrame(self)
            local eye = Vector.xyz(
                self.tx - math.sin(self.camYaw) * back,
                gy0 + self.hy + camH,
                self.tz - math.cos(self.camYaw) * back
            )
            local center = Vector.xyz(
                self.tx + math.sin(self.camYaw) * 4.0,
                gy0 + self.hy + camLh,
                self.tz + math.cos(self.camYaw) * 4.0
            )
            local view = Mat4.lookAt(eye, center, Vector.xyz(0, 1, 0))
            local proj = Mat4.perspective(math.rad(60), self.aspect, 0.5, 80000)
            local mvp = proj * view
            local cx, cy, _, cw4 = mvp:transformVec4(mx, my, mz, 1)
            if cw4 > 0.1 then
                local nx = cx / cw4
                local ny = cy / cw4
                if nx > -1.5 and nx < 1.5 and ny > -1.5 and ny < 1.5 then
                    local sx = (nx * 0.5 + 0.5) * self.cw
                    local sy = (1 - (ny * 0.5 + 0.5)) * self.ch
                    local size = 40 * (self.cw / 800)
                    local sc = size / moon.width
                    local m = Mat2D.identity()
                    m.xx = sc
                    m.yy = sc
                    m.tx = sx - (moon.width * sc) / 2
                    m.ty = sy - (moon.height * sc) / 2
                    renderer:save()
                    renderer:transform(m)
                    renderer:drawImage(moon, self.sampler :: ImageSampler, "srcOver", 1)
                    renderer:restore()
                end
            end
        end
    end)
    if not ok then self.gpuOk = false end
end

return function(context: Context): Layout<Game>
    return {
        size = Vector.xy(800, 500),
        msg = nil, loc = nil, welcome = nil, welcomeA = nil,
        welcomeX = nil, welcomeY = nil, welcomeS = nil,
        tut = nil, tutA = nil, niceA = nil,
        tutX = nil, tutY = nil, gateScore = nil, gateScoreA = nil, gateScoreX = nil, gateScoreY = nil, niceX = nil, niceY = nil,
        lvlLock2 = nil,
        lvlLock3 = nil,
        keyF = nil, keyB = nil, keyL = nil, keyR = nil, keyJump = nil, keyBoost = nil,
        locked = nil,
        health = nil,
        hudBarX = nil, hudBarY = nil, hudHpX = nil, hudNumX = nil,
        speed = nil, alt = nil,
        hudSpdLabX = nil, hudSpdNumX = nil, hudAltLabX = nil, hudAltNumX = nil,
        hudStatY = nil,
        hudMapX = nil, hudMapY = nil, mapPlaneX = nil, mapPlaneY = nil,
        overA = nil,
        overTitle = nil, overRetry = nil,
        overTitleX = nil, overTitleY = nil, overBtnX = nil,
        overRetryY = nil, overHomeY = nil,
        overBX = 335, overHX = 335, overRY = 280, overHY = 340,
        trailX = {}, trailY = {}, trail = {},
        trailIdx = 1, trailAcc = 0, mapOX = 700, mapOY = 10,
        foeX = {}, foeY = {}, foes = {}, kills = 0,
        round = 1, hp = 100,
        bossHp = nil, bossBarX = nil, bossBarY = nil, bossBarA = nil, bossNameY = nil, bossName = nil,
        unlockA = nil, unlockX = nil, unlockY = nil, unlockLit = nil, unlockMsg = nil,
        vitCubeA = nil, vitCubeB = nil,
        vicTitleA = nil, vicTitleY = nil, vitL1A = nil,
        pumpX = nil, pumpY = nil, pump2A = nil, pk3A = nil, pk3X = nil, pk3Y = nil,
        svLvl2 = nil, svLvl3 = nil, svTut = nil, svSnd = nil,
        cursorC = nil,
        time = 0, angle = 0.7, camYaw = 0, radius = 13, height = 6, lookH = 3.5,
        tx = 0, tz = -15000,
        keys = {},
        lastPX = 400, lastPY = 250, dragging = false, camHold = 0, mouseFire = false, mouseClimb = 0, lockMsgT = 0, cursorPeek = false,
        hy = 0.0, vy = 0, yaw = 0, phase = 0, moving = false,
        grounded = true, roll = 0,
        takeoffSnd = nil, takeoffInst = nil, takeoffPlayed = false,
        jetSnd = nil, jetInst = nil, jetT = 0,
        homeBellsSnd = nil, homeBellsInst = nil, homeBellsT = 0,
        heroA = nil, heroX = nil, heroY = nil, heroSX = nil, heroSY = nil,
        loadW = nil, loadBarX = nil, loadBarY = nil, loadLabY = nil,
        homeA = nil, homeX = nil, homeY = nil, homeSX = nil, homeSY = nil,
        homeTitleX = nil, homeTitleY = nil, startX = nil, startBtnY = nil, startLabY = nil,
        btnA = nil, setA = nil, rulA = nil, backA = nil, panelTA = nil,
        mainX = nil, hovPlay = nil, hovSet = nil, hovRul = nil, playY = nil, setY = nil, rulY = nil, rulX = nil,
        lvlX1 = nil, lvlX2 = nil, lvlX3 = nil, lvlY = nil, lvlLineY = nil, lvlLabX1 = nil, lvlLabX2 = nil, lvlLabX3 = nil, lvlLabY = nil, lockX2 = nil, lockBY2 = nil, lockSY2 = nil, lockX3 = nil, lockBY3 = nil, lockSY3 = nil, connX0 = nil, connX1 = nil, connY = nil, lvlBX = 0, lvlBY = 0, saveBX = 0, saveBY = 0, enterBX = 0, enterBY = 0,
        sndX = nil, sndY = nil, backX = nil, backY = nil, setCtlX = nil, setCtlY = nil,
        rulBodyX = nil, rulBodyY = nil, ctlBodyX = nil, ctlBodyY = nil, ctlBodyRX = nil, ctlLY = nil, ctlRY = nil, ctlA = nil, ctlPanelX = nil, ctlPanelY = nil, ctlTitleX = nil, ctlTitleY = nil, ctlXBtnX = nil, ctlXBtnY = nil, titleTxt = nil, sndTxt = nil, pauseTxt = nil,
        paused = false,
        dimX = nil, dimY = nil, dimW = nil,
        clickX = nil, clickY = nil, clickA = nil, fogX = nil, sfx = nil,
        smokeX = nil, smokeY = nil, smokeBaseY = 460,
        smokeA = nil, smokeS = nil,
        mouseNX = 0, mouseNY = 0, parX = 0, parY = 0,
        cardA = nil, cardX = nil, cardY = nil, cardBtnX = nil,
        cardResY = nil, cardHomeY = nil, cardCtlY = nil, cardTitleX = nil, cardTitleY = nil,
        cardResBX = 0, cardResBY = 0, cardHomeBX = 0, cardHomeBY = 0, cardCtlBX = 0, cardCtlBY = 0,
        homePanel = 0, soundOn = true, homeTarget = 0, homeFade = 0,
        winT = 0, unlockT = -1, vitT = -1, vitContBX = 0, vitContBY = 0, tutMaster = false,
        gates = {}, gateIdx = 1, gateGraceT = 0,
        vitSparkX = {}, vitSparkY = {},
        vitConfX = {}, vitConfY = {},
        vitDotX = {},
        playBX = 0, playBY = 0, setBX = 0, setBY = 0, setCtlBX = 0, setCtlBY = 0,
        rulBX = 0, rulBY = 0, sndBX = 0, sndBY = 0, backBX = 0, backBY = 0,
        loadT = 0, startBX = 300, startBY = 280,
        boostLock = false, qPrev = false, qTapT = -9, helpT = 0, helpXX = 0, helpXY = 0,
        running = false, sitting = false,
        dust = {}, dustIdx = 1, dustTimer = 0, wasAir = false,
        heroVbo = nil, heroCpu = nil,
        beamVbo = nil, beamCpu = nil,
        beams = {}, beamIdx = 1, beamCd = 0,
        windVbo = nil, windCpu = nil,
        winds = {}, windIdx = 1, windAcc = 0,
        chunkVbo = nil, chunkCpu = nil,
        chunks = {}, chunkIdx = 1, crashAcc = 0, crashed = false, crashT = 0,
        nukeVbo = nil, nukeCpu = nil,
        mslVbo = nil, mslCpu = nil, mslPipe = nil, mslBind = nil,
        msls = {}, mslBooms = {},
        canvas = nil, pipeline = nil, heroPipe = nil, heroBind = nil, vbo = nil, ubo = nil,
        bindGroup = nil, uboCpu = nil, sampler = nil, moonImg = nil, heroImg = nil, homeImg = nil, depthTex = nil, depthView = nil,
        aspect = 1.6, cw = 800, ch = 500,
        vertCount = 0, gpuOk = false,
        init = init, resize = resize,
        keyboardEvent = keyboardEvent,
        pointerDown = pointerDown, pointerMove = pointerMove, pointerUp = pointerUp,
        pointerExit = pointerExit,
        advance = advance, draw = draw,
    }
end
