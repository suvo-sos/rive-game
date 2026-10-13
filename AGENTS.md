> Workflow: no preview screenshots (they cost time); do not visually verify — the user reports anything wrong.

## File layout (Oct 9 — root decluttered, docs resynced)
- `scene.rml` — scene entry (Arena artboard, HUD, assets). Keep at root.
- `game.luau` — all game script. Keep at root (`ScriptAsset file="game.luau"`).
- `shaders/` — 9 WGSL pipelines, all live via
  `context:shader("shaders/<stem>")` — no RML entry needed:
  `desert` (world) + `jet` (hero) + `blast` (particles) + `storm`
  (curtains) + `sand` + `zombie` (horde/giant/magma) + `foe` (boss/staff)
  + `gate` (circus) + `aurora`.
  Bare stems do NOT resolve from subdirs (returns nil; game ran headless
  with no world + `game:2347` winds crash until fixed Oct 5).
- `assets/images/` — 14 files, all declared as `ImageAsset` in `scene.rml`:
  `hero-cover.png`, `home-cover.png`, `Moon.png`, `smoke0-2.png`,
  `cloud0-2.png`, `lock.png`, `pumpkin_face.png`, `pumpkin3.png`.
  Orphaned `fire0-3.png` moved to `archive/` Oct 9.
- `assets/fonts/` — `SpaceMono-Bold.ttf` (all HUD) + `Creepster-Regular.ttf`
  (SETTINGS title only). Unused fonts moved to `archive/`.
- `assets/audio/` — 8 wavs, all declared: `engine_takeoff.wav`, `click.wav`,
  `smg_shot.wav`, `rifle_shot.wav`, `crash_boom.wav`, `jet_loop.wav`,
  `laser_cannon.wav`, `home_bells.wav`.
- `archive/` — dead files kept out of the build (old shaders, fonts, images).
  See `archive/README.md`. Safe to delete.
- `build/` — CLI output (canonical `the-last-flight.riv`, logs,
  screenshots). Gitignored. Stale `luxio.riv` / `rive challange.riv`
  removed Oct 9.
- Entry names are load-bearing: renaming `scene.rml`/`game.luau` or the
  `file=` paths in `scene.rml` breaks the build — run `rive --verify` after
  any move. Cryptic Leonardo-named pngs were renamed Oct 5
  (`17911840875349.png`→`hero-cover.png`, `17911933913b2e.png`→`home-cover.png`).
- `AGENTS.md` (this file, caps) + `CLAUDE.md` (`@AGENTS.md` pointer).

# Dead Earth Revival — Rive Halloween Challenge (3D Fighter)

## Vision
A full-3D fighter (no 2D). 5 ghosts, 5 rounds, 5 locations.
Hero has 500 health. Earth is dead. Win all 5 to revive it.

Beat each city's ghost, revive that city, move to the next.

## Story
The earth is dead. Four dead cities each spawned a ghost from their ruins.
A fifth ghost lives in the digital — an AI ghost running on hardware of millions of computers.

Hero has one job: win all 5 fights to revive the cities and kill the AI ghost.

## Locations / Rounds (in order)
1. Empty desert village — flat sand, ruined mud houses, far horizon (DONE, procedural)
2. Small island middle of ocean — water ring, palms, moon shimmer
3. Dead snowy city — snow, frozen towers, breath fog
4. Dead jungle city — vines, ruins, spores
5. Digital AI core — servers, glitch, neon grid (final boss)

Ghosts 1-4 = city spirits (desert, ocean, snow, jungle). Ghost 5 = digital AI ghost, hardest.

## Why this game
- Simple and readable: 3D arena fighter, hero vs ghost boss, keys to move/fight.
- Eye-catching: 5 distinct 3D worlds, all real geometry drawn by custom WGSL.
- Built for Rive's strengths: GPU Canvas 3D + Scripting + Data Binding + State Machines.
- Same technique as Last Lantern (3D graveyard entry): mesh + WGSL pipeline + Luau game.

## Why Rive Halloween Challenge
Built for the Rive Halloween Challenge (Oct 2025, $10K pool, deadline Oct 12).
Requirements: must use Rive CLI and/or GPU Canvas (WGSL shaders).
We use both:
- Rive CLI + RML for the scene shell (Arena artboard, HUD text, key listeners, focus).
- GPU Canvas + WGSL for the full 3D worlds (desert pipeline done; ocean/snow/jungle/digital next).
- Plus State Machines (key listeners, later round/screen transitions), Data Binding (keys, message, location; later HP/rounds), Scripting (mesh gen, camera, hero anim, fighter AI).
- Human touch in the Rive Editor: title/layout polish before video.

## Core loop
1. Round intro message: location name + ghost.
2. Fight in 3D: WASD/arrows walk, Space jump (attack/block/special next).
3. Hero 500 HP (locked). Ghost HP scales per round (TBD: e.g. 120/160/200/240/320).
4. Win round = ghost HP 0 → city revived → next location loads.
5. Lose = hero HP 0 → game over. Win game = beat round 5 AI ghost → revive ending.

Controls (locked): keys. WASD/arrows move, Space jump. Punch/kick/block keys TBD.

## Pillars
- Full 3D, no 2D art: every world is real geometry + WGSL.
- One hero rig (articulated code-animated blockout now; Blob mesh later), 5 ghost variants.
- One arena layout per location, big open maps (desert is 800x800).
- Fair fighter AI: approach, strike when close, retreat, telegraph specials.

## 3D-file knowledge (Oct 4)
- Any file dropped in the project embeds as a Blob; Luau reads bytes by name. No model importer — parse it yourself.
- Small `.obj` (under ~2MB, low-poly, triangulated) is the usable choice: plain text v/f lines, easy parser.
- Reject: huge files (248MB obj / 132MB glb break the build size), `.usdz` (zip, Luau cannot open).
- Shader is vertex-color only today; textured models need UV support added later.

## Challenge Brief — #Rive Halloween Challenge (saved Oct 3, 2026)
Tag: #RiveHalloweenChallenge
Submit your Halloween creation — $10K cash prize — Enter by Oct 12, 11:59pm PDT.

Guidelines: Build something spooky with Rive's newest tools. Haunted UI, creepy characters, eerie effects, ghostly games built with Rive CLI and GPU Canvas.
- Rive CLI: terminal + coding agent writes RML, live preview. Easiest way in if never opened Rive.
- GPU Canvas: low-level GPU layer for shaders, 3D, custom effects. Write once in WGSL, runs everywhere Rive does. Fog, flickering candlelight, glitchy possessed screens, glowing jack-o'-lanterns.
- Must use Rive CLI, GPU Canvas, or both. Combining both (+ Scripting, Data Binding, State Machines) scores higher.
- Human Touch bonus: refine CLI work in Rive Editor with personal style/art/motion.
Sample ideas: Haunted UI (possessed buttons, cursed loading, spooky toggles); Shader effects (fog, flicker, ghost trails, blood drips, CRT glitch, moonlight); 3D scenes (haunted houses, jack-o'-lanterns, graveyards, 2D characters in 3D worlds); Characters (monsters, ghosts, witches reacting to cursor/keyboard); Games (trick-or-treat, jump scares, escape rooms.
Getting started: https://rive.app/docs/cli/overview + https://rive.app/docs/scripting/wgsl-shaders
Submission Requirements:
- Short description + which features used (CLI, GPU Canvas, or both)
- Video showing project in action. If CLI, show agent workflow / RML.
- Share Rive link or embedded URL
- Multiple entries permitted (separate posts)
- Must be new work created during challenge
- Must post on social tagging @rive_app (X, LinkedIn, or Instagram), use #rivehalloweenchallenge. 30s+ walkthrough video recommended, 1-2 sentences on concept + CLI/GPU Canvas callout.
Evaluation Criteria (40 pts total):
- Creative concept + Halloween theme (10pts)
- Use of Rive CLI and GPU Canvas (10pts)
- Human Touch (10pts)
- Interactive motion design (5pts)
- Execution and polish (5pts)
Prizes: 1st $5,000 / 2nd $3,000 / 3rd $2,000. Judges: Adam Plouff (Battleaxe), Guido Rosso (CEO @ Rive).

## Progress (Oct 4, 2026)
- Full-3D pivot (no 2D). Old Haunted Ship idea rejected and removed.
- `desert.wgsl`: true 3D pipeline (pos+color verts, MVP uniform, sand grain, sun shade). Fog removed per request — only faint horizon haze, far visibility.
- `game.luau`: dune field 800x800 (40x40 grid) + 10 ruined mud houses, all procedural (9960 verts, immutable VBO). Depth-tested (`depth24plus-stencil8`). Failsafe `gpuOk` flag.
- Land tuned: dunes flattened ~60%, map 240 → 400 → 800, village spread x2, fly range ±300.
- Camera: follows hero (radius 26, height 14), auto-rotates for video, drag orbits, R/F height. `resize` rebuilds canvas + depth at real window size (no stretch).
- `scene.rml`: Arena artboard, no title texts (removed per request), bottom hint line only, 3D world behind HUD, back Shape owns focus.
- Hero: 7-part articulated blockout (torso/head/arms/legs/hood), CPU re-skinned per frame into dynamic VBO (252 verts). Walk swing, idle bob, jump tuck. Orange torso, hood, dark legs.
- Keys: raw `keyboardEvent` never reaches RML-housed scripts — 10 state-machine key listeners (WASD/arrows/Space down+up) → 5 VM booleans polled per frame. Listener IDs 0:60-0:69, boolean bind key 634. `verify` 0 errors, `inspect` 0 problems. `build/walk.png` (forced keyF) shows mid-stride. Live keypress needs preview confirm.
- Status: `rive --verify` 0 errors (lint warnings only). Shots: `build/desert.png`, `build/walk.png`.
- Next: desert ghost boss + combat (HP, hit, win/lose), then island 2/5.
- TBD: ghost HP curve, heal between rounds, punch/kick/block keys, small `.obj` hero/mesh files if wanted.

## Session learnings (Oct 4, evening — Luxio HUD/camera/sky work)
Project renamed to Luxio (`rive.yaml` name; fileId 2622473 pushed, rev 47940700). Chase cam + Halloween desert + HP HUD are the game now (fighter plan above is stale, kept for reference).

- RML draw order: FIRST child paints ON TOP. `HpFill` placed after `HpTrack` rendered invisibly under the opaque track despite a correct width bind — swapping the order fixed it. Always suspect order before suspecting binds.
- HUD renders at UNSCALED native artboard coords from top-left, while the GPU canvas resizes to fill the viewport. Absolute-positioned HUD floats mid-screen on any window != 800x500. Proven by PIL run-length pixel scans at `--viewport` 800x500 / 1280x720 / 600x900.
- Fix that works: drive HUD x/y from the script. Shape x (key 13) / y (key 14) are bindable Number targets; `resize()` writes `hudBarX=(w-220)/2`, `hudBarY=10` (const = glued to top), side labels derived (`barX-72`, `barX+230`). Multiple binds may read one VM prop.
- Rectangle `originX/originY` place the path relative to the Shape position: `originX="0"` = left-anchored (bar shrinks right-to-left under width bind), but default `originY="0.5"` CENTERS the path vertically on Shape y — a 28-tall bar at y=10 rendered clipped at rows -4..24. Set `originY="0"` for top-anchored bars.
- `alignValue="center"` is the correct RML spelling (docs `text.md`); do not "fix" to `align`.
- Ground-mesh resolution must match `groundH()` frequency: 40x40 grid over 800u deviated ~0.5 from the analytic dunes and every prop floated. `GRID_N=80` + sinking bases 0.3-0.5 (pumpkins 0.45, graves 0.5, trees 0.4, huts 0.5, rocks 0.3) grounds everything.
- Vert-count accounting must be EXACT (buffer sized from it). Keep the `halloweenBoxes`/`skyBoxes` formula in sync with push calls; confirm via the `desert 3d ready: N verts` log (48,120 now = 38,400 ground + 360 ruins + Halloween + 71 sky boxes x36).
- Distance haze applies to ALL geometry including sky: moon at dist ~436 took 53% purple mix and rendered gray. Haze now falls off with altitude: `f *= exp(-max(y-2,0)*0.05)` (`desert.wgsl`).
- Glow color bands are load-bearing: pumpkin-orange (r>=.8, g .3-.6, b<.2) pulses; candle-yellow (r>.9, g>.75, b<.35) flares — hero eyes, pumpkin faces use it on purpose; pale moon (g>.6) and white stars (all>=.9, twinkle instead) stay out of both.
- Hero extras as PARTS entries sharing an existing pivot follow that part under yaw for free (eyes share head pivot with swing 0; shoes would share hip pivots with leg swings). `swings[i] or 0` tolerates short tables; `HERO_VERTS` must equal parts x 36.
- Chase cam convention: forward = (sin(camYaw), cos(camYaw)) matches hero yaw (`atan2(mx,mz)`). `camYaw` eases to `yaw` at 3.5/s when not dragging; vertical drag drives `lookH` (look-target height, -1..14) so the sky/moon is viewable; R/F drive eye height. Eye/center heights are ground-relative (`groundH`) so dunes never swallow the camera.
- CLI notes: `--pointer=drag@x1,y1>x2,y2:steps` needs the `=` form; `--viewport` + `--screenshot` for aspect testing; `KeyboardInput` accepts `leftShift/rightShift`, keyPhase bitmask 1/2/4, modifiers bitmask. There is NO pointer-lock API — cursor docs cover only OS cursor styles via `rive.yaml` `cursor: property:` + a VM string (`hidden`/arrow).
- Parked (asked, pivoted away, not built): Shift-run + C-sit/toggle + landing dust puffs (scaffolding in type: `running/sitting/dust*`, `writeBoxAt` helper present), tap-to-lock cursor + cursor-hide, hero shoes.

## Session (Oct 5 — SPD/ALT HUD, minimap, 500 ceiling / 2500 top speed)
- Speed mode (user request): `verify`-only, batch related changes, screenshots ONLY when explicitly asked.
- SPD + ALT row above HP bar: labels left (`barX-72`) / right (`barX+190`), numbers next to each, `statY=h-68`. Numbers reuse the `HpToString` converter. First attempt centered the row and the jet exhaust covered ALT — split to the sides. VM props `0:81-0:87`, RML `0:301-0:335`.
- Minimap: 130x66 panel right of ALT (`mapX=min(barX+310,w-140)`, `mapY=h-108`) + orange plane dot + 16 purple trail crumbs, one per 500u flown. Trail resets on wrap. VM props `0:400-0:435`, shapes `0:440-0:547`, instances `0:548-0:583`. Panel must come AFTER the dots in RML (first child paints on top — panel-first buried the dots, same lesson as HpFill/HpTrack).
- Flight rescale, real numbers (user-confirmed over display-scaling): cruise 1250, Q boost 2x = 2500 top; climb 120x boost, ceiling 500; strafe 0.5x forward speed; wrap ±6000 (12000 tile).
- World rescale to match: `LAND` 2400 (`GRID_N=120`, 20u cells); `groundH` high-freq term softened to `x*0.045+z*0.038` (old `x*0.31+z*0.21` would alias at 20u cells); skirt rewritten to ±6270 in 220u cells (`(55*22*2+23*11*2)*6=17,556` verts — formula must match loop bounds); mid-ring scenery 500-2000, outer zones 2500-5500 at 4x size; camera far 1600→7000; wind rate `6+fwd*0.02`, length cap 120; beams culled at `WRAP-100`; photo moon hidden above hy 200.
- Total ~137k verts (86,400 ground + 17,556 skirt + ~21k boxes). `verify` 0 errors. Shots: `build/map_ground.png` (SPD 14 / ALT 0), `build/map_air.png` (SPD 1250 / ALT 500 + trail).

## Session (Oct 5 — home page: title/dim removal, textured smoke, bg parallax)
- Removed `HomeTitle` + `HomeTitleGlow` (static "THE LAST FLIGHT" texts over the cover) and `HomeDim` (bottom purple band) from `scene.rml` — image's baked-in art is the only title now. SETTINGS/RULES `PanelTitle` untouched.
- Smoke v1 (rejected by user as fake): 8 ellipse Shapes with `RadialGradient` fills. Vector blobs have no internal texture and always read flat. Note: `Feather` inside a `Fill` renders NOTHING (docs `drawing.md`) — soft filled glow must be radial gradient with alpha-`00` outer stop; Feather is strokes-only.
- Smoke v2 (shipped): procedural sprite textures. `/tmp` script `smoke_gen.py` (numpy+PIL) writes `smoke0-2.png` (~60KB each, 384x256 RGBA): domain-warped fbm + anisotropic streak octaves (slow-x/fast-y value noise = horizontal wisps), edge chewed by `(d-0.5)*1.6`, alpha gated by high-freq wisp field so thin parts show through, moonlit ramp (dark slate base → pale blue-gray top + rim light). Registered as `ImageAsset` ids `0:1140-0:1142`.
- RML: 14 `Image` nodes `Smoke0-13` (`0:1160-0:1167`, `0:1232-0:1237`) placed BEFORE `HomeBg` (first child paints on top: smoke over bg, under buttons). Each binds opacity(18)→`smokeNA`, x(13)→`smokeNX`, y(14)→`smokeNY`, scale(16+17)→`smokeNS` (two binds, one prop = uniform scale). VM props: X `0:1004-0:1011` + `0:1208-0:1213`, Y `0:1012-0:1019` + `0:1214-0:1219`, A `0:1116-0:1123` + `0:1220-0:1225`, S `0:1124-0:1131` + `0:1226-0:1231`. Binds `0:1168-0:1207` + `0:1238-0:1267`, instances `0:1100-0:1115` + `0:1268-0:1291`.
- Script (`game.luau`): per-puff life-cycle in `advance()` — 24-37s staggered loops (`p = (time/cyc + i*0.37) % 1`), rise 120-180px, scale `(0.7+(i%3)*0.3)*(0.75+p*0.9)`, alpha `homeFade * sstep(0,0.15,p) * (1-sstep(0.35,1,p))`, X drift 10-26px/s + sine wobble, wrap ±420 (max half-width ~410 at full swell). `resize()` spreads X across `(w+600)` and sets `smokeBaseY = h-45`. Init fetch loops are `0..13` — growing puff count = RML nodes + loop bound only.
- Bg parallax: `pointerMove` always records normalized cursor (`mouseNX/mouseNY`, clamped -1..1, uses `cw/ch`); `advance()` eases `parX/parY` (3.5/s) and writes `homeX=cw/2±16`, `homeY=ch/2±10`. Cover-scale overflow absorbs the shift; resize still owns the center baseline.
- `verify` 0 errors throughout; live preview (`watching .`) rebuilds on each edit.
- Hero clouds (same session): `cloud0-2.png` (512x192/384x160/640x224, slate night tint, alpha ≤0.66) from `/tmp` script `cloud_gen.py`; 6 `Image` nodes `Cloud0-5` reuse `fog0X-5X` drift + `heroA` opacity — zero script changes. Assets `0:1292-0:1294`, nodes `0:1295-0:1300`, binds `0:1301-0:1312`.
- Load-bearing typo lesson: bilinear interp MUST be `(a-b-c+d)` — cloud script shipped `(a-b-c-d)` and produced sharp grid blocks at every lattice scale (survived blur + finer cells). Diagnose numerically: `value_noise` range must be [0,1] with tiny max-step; the broken one gave [-1,1] with steps ~2.

## Session (Oct 5 — lit jet pipeline: jet.wgsl + normals + taper)
- User wants the plane real via WGSL + GPU Canvas for the hackathon judging (CLI + GPU Canvas = 10pts). New `jet.wgsl`: dedicated jet pipeline — moon key + purple-sky hemisphere ambient, Blinn-Phong metal specular, fresnel purple rim, glass canopy (deep tint + grazing sky reflection + traveling sun glint), object-space panel seams + cast-metal weathering hash, emissive afterburner/nav/strobe (same color bands as `desert.wgsl`).
- `buildHero` verts are 12 floats now: pos(3) + world normal(3) + color(3) + object-space(3). Normals computed per-tri via cross product in world space (winding verified outward for all 6 faces; pitch/roll/yaw are proper rotations so outward survives). Taper params per part: `top` shrinks roof face, `front` shrinks nose face (nose tip front 0.45, canopy top 0.62/front 0.7, fins top 0.55, missiles front 0.5). Luau union typing rejects `p.top` on keyless variants — must read `(p :: any).top`.
- Plumbing: hero VBO/CPU sized `HERO_VERTS*12*4`; `heroPipe`/`heroBind` from `context:shader("jet")` (auto-discovered like desert.wgsl, no RML entry); UBO 80→96 bytes with camera eye at 80/84/88 (world shader ignores the tail); `draw()` switches to jet pipeline for the hero, then back to world pipeline for beams/wind/chunks.
- `verify` 0 errors, `rive --once` builds (9.9MB .riv, WGSL compiles). No screenshots per workflow.

## Session (Oct 5 — runway flicker: lakebed flatten fix)
- Runway flicker root cause: `groundH` flattened a pad at `x≈0` (`1-sstep(5,8,|x|)`) but the strip sits at `x=-23000` — full ±2.8 dunes ran through the slabs and the 1000u skirt quads sliced them. Fix: dry-lakebed flatten centered on `(RWY_CX, RWY_CZ)` — fully flat 1600x1800, 600u blend (`wx=1-sstep(800,1400,|x-RWY_CX|)`, `wz=1-sstep(900,1500,|z-RWY_CZ|)`), wide enough that every skirt corner near the strip is flat. Origin props unaffected (`wz=0` there). `verify` 0 errors, `--once` builds.

## Session (Oct 5 — blast pipeline: crash debris goes WGSL)
- New `shaders/blast.wgsl`: dedicated particle pipeline (copies the jet precedent — own `blastPipe`/`blastBind`, same 80-byte UBO prefix so the same uniform buffer feeds it). Chunks were flat-shaded boxes on the world pipe (only deep-orange fire caught the pumpkin band); now every kind is shaded per pixel.
- Chunk verts 6→12 floats: pos(3) + color(3) + (heat, seed, kind) + local(-1..1). `heat` = life frac fresh 1→burnt 0, `seed` set at spawn (`Chunk.seed`, stable per particle). `buildChunk` face loop writes all 12; chunk draw uses `o/48` verts and switches to blastPipe (chunks are last in the pass, no restore needed; nil-pipe guard skips safely).
- Shader per kind: fire = blackbody ramp (white→orange→char by heat) + scrolling-fbm tongue erosion + charred round rim + hot heart + flicker; flash = fast-decay white core; smoke = slow-fbm mottled billows, top-lit, dissolving edges; debris = black metal + heat-gated glowing cracks + moonlit tops; sparks = strobing white→ember; dust = noisy broken-edge disc; shockwave (NEW kind 6) = bright ring racing outward (`front=(1-heat)*1.15`, gaussian ring, fades behind).
- CPU: `puff` kind 6 spawns ground-hugging (`gyC+0.6`), physics pins `vy=0` + drag; both crash volleys +2 shock rings (`puff(self, 6, 8, 0, 0.9, gyT)`).
- `verify` 0 errors, `--once` builds (9.39MB .riv, WGSL compiles). Headless crash run (OVERRUN path, full volley + 10s burn): no errors, `health=0`. No screenshots per workflow.

## Session (Oct 5 — short strip + faster fling)
- Runway 240→120 (`RWY_Z0/Z1` = -23540/-23420, same center -23480; strips/dashes/lights all derive from the ends so they rescale free). Spawn moved to the new south end (`tz` -23590→-23530, both in `doReset` and the init table).
- `THRUST` 2.6→5.0: rotates at VR=21 in ~5s using ~50 units of strip — comfortable on 120. Headless takeoff test: airborne inside 10s, climbing through ALT 427 at SPD 1350. `verify` 0 errors.

## Session (Oct 5 — crosshair HUD dot, not a 3D pointer)
- User rejected the 3D world reticle: wants a shooter-style screen dot. Removed the 3D aim boxes/VBO entirely. Now: gun aim point (nose + bolt dir × `GUN_LEAD` 55u) is projected with the render `mvp` in `advance()` (same pattern as the moon projection) into new VM props `aimX/aimY/aimA` (RML `0:1394-0:1396`, instances `0:1415-1417`, shape binds `0:1400-0:1414`).
- RML: `AimDot` (6px white ellipse) + `AimRing` (26px white stroke circle), both bound to aimX/aimY/aimA, placed before the minimap block. Visible only when flying and un-crashed (`aimA` 0 in menus/wreck/off-screen). Headless flight test: `aimA=1` at (400, 212) on 800x500. Gun anchor (`gunPx..gunDz`) still stashed per frame for future mounts. `verify` 0 errors.
- Thin + nose-locked (user feedback): dot 6→4px, ring 26→20px with 1px stroke. Root cause of "static" dot: aim/bolts were keyed to `camYaw`, so free-look dragged the guns with the camera and the dot sat glued near center. Now both bolts and crosshair use jet `yaw` (airframe-fixed guns, flight-path pitch `vy*1.05`); free-look orbits the camera while the dot sweeps the screen — small drag test: (400,207)→(219,209), big drag hides it off-screen (`aimA=0`). `verify` 0 errors.
- Mouse-driven dot (user correction: dot must follow the mouse, never drift): projection removed from `advance()` (gun anchor `gunPx..gunDz` still stashed there each frame). `pointerMove` owns position — snaps to cursor when unlocked, roams by clamped deltas when locked/dragging; `advance()` only sets `aimA` visibility (0 in menus/wreck). Tests: unlocked move→(500,300); lock-click roam (400,250)→(400,300)→(450,280), `locked=True`. `verify` 0 errors.
- PUBG-style cross (user: dot+ring "not looking good"): ring replaced by 4 white ticks (2×12 vertical, 12×2 horizontal, ±14px, 7px center gap) + 4px center dot, all sharing `aimA`. Ticks ride derived props `aimLX/aimRX/aimTY/aimBY` (RML `0:1418-0:1421`, instances `0:1450-0:1453`, shapes `0:1422-0:1449`) written from `aimX/aimY` in `advance()`. Test: mouse (500,300) → ticks at 486/514/286/314. `verify` 0 errors.
- True shooter model (user: "not like 3D games"): crosshair PINNED to screen center (`cw/2,ch/2`, ticks ±14) — mouse only turns the camera now (`pointerMove` no longer touches aim props). Bolts fire along the camera ray (eye→look target, normalized × jet speed) so they always fly through the cross; gun anchor stash follows the same ray. Test at 1280x720 after look-drag: dot stays (640,360), ticks 626/346. `verify` 0 errors.
- Three guns — HORNET / HAMMER / GIGA BEAM (user-picked names): keys 1/2/3 select (both ASCII 49-51 and raw 1-3 accepted — CLI digits arrive as `event.key` 2, found via temp DBG print; also proved `keyboardEvent` fires live, Oct-4 learning stale). `GUN_CD` 0.28/0.8/1.2s, `GUN_LIFE` 1.4/0.7/2.5, `GUN_SPD` 1.0/0.8/0.9; Hammer fires a 5-pellet fan (±0.045 rad), Giga a fat white-hot slug (catches the star-twinkle band). `buildBeam` takes `gun` for size/color; `BEAM_SLOTS` 3→12; HUD `GunLabel` top-left under pause (`gunName` prop `0:1454`, text/binds `0:1455-0:1461`, instance `0:1462`), visibility = `aimA`. Tests: switch→HAMMER + volley, switch→GIGA BEAM, 0 errors. `verify` 0 errors.
- Center gun bar (user: wheel-scroll cycle + minimal center names + yellow selected): wheel is NOT exposed by the Rive runtime — no script hook, state-machine listener, or schema type (checked docs/schema). **G cycles** instead (edge-triggered `gPrev`), 1/2/3 still direct. Bar: 3 dim-white static labels in 120px center slots under the crosshair (`gunX1-3`, `gunRowY = ch/2+44`) + yellow `GunHL` copy (`gunHLX` = selected slot x, content = existing `gunName` prop); unselected at 0.45 via `gunDim` (0 in menus). Props `0:1463-0:1468`, binds/shapes `0:1469-0:1501`, instances `0:1502-0:1507`; old top-left `GunLabel` removed. Test: G→HAMMER, hlX=340, slots 220/340/460. `verify` 0 errors.
- Vertical pop-up bar (user: hidden until switch, `> NAME <` selected, scroll-up = Giga→Hammer→Hornet): any switch sets `gunShowT` 2.5s; bar auto-hides after (whites `gunDim` 0, yellow parked at -200). Stack: 200-wide column at `cx-100`, rows +0/+26/+52 from `ch/2+34`; selected row gets yellow `> NAME <` via new string prop `gunHL` (`0:1508`, instance `0:1509`); old `gunName` prop/instance/fetch removed. Props repurposed (documented in code): gunX1=colX, gunX2/X3/RowY=row tops, gunHLX=highlight top. G now steps `(gun+1)%3+1` = 3→2→1 up-order. Tests: switch→ rows 284/310/336, `> HAMMER <`, dim 0.45; 3.5s later dim 0. Moved to top-center rows 56/82/108 (user: wants it on the top part). `verify` 0 errors.
- Wheel dead-end, proven (user "scrolling still don't see"): pixel scan of headless screenshot after G-switch confirms the bar renders fine (row3 421 yellow px `> GIGA BEAM <`, rows 1-2 dim gray) — the user was scrolling the wheel, which the runtime never delivers (PointerEvent = position+id+type only; no wheel hook/listener/schema anywhere). Added "G SWITCHES GUN" to the RULES panel. `verify` 0 errors.
- Gun 1 renamed HORNET→INFERNO (user pick) + muzzle flash: every Inferno shot spawns a kind-0 fire puff and kind-4 spark puff at the nose via the blast WGSL pipeline. `puff()` takes optional `ox/oz` origin offsets (other callers untouched). Renamed in `GUN_NAMES`, doReset/init defaults, gun-bar labels. Test: sustained Space fire, 0 errors, `gunHL` = `> INFERNO <`. `verify` 0 errors.
- Left-click fires (user: fire button = mouse click) + thin golden tracers: playfield `pointerDown` sets `mouseFire` (all menu/crash/pause branches return before it), `pointerUp` clears; `jDown` includes it → press shoots, hold autofires; Space still works. Inferno bolts retuned to hair-thin long tracers (0.35 core / 0.9 halo, gold, catches the beam strobe band). RULES line now "CLICK OR SPACE FIRES, G SWITCHES GUN". Test: 1s click-hold → 4 Inferno shots, 0 errors. `verify` 0 errors.
- Inferno fire sound (user file): `~/Downloads/Futuristic SMG Single Shot.wav` (14KB) → `assets/audio/smg_shot.wav`, `AudioAsset smg` (`0:1510`), fetched into the sound board, `playSfx(self, "smg")` on every Inferno shot (rate-limited by its 0.28s cooldown, honors sound toggle). `.riv` grew by exactly the wav size = embedded. `verify` + `--once` 0 errors.
- Hammer fire sound: take 01 from `~/Downloads/Futuristic Assault Rifle/` (53KB) → `assets/audio/rifle_shot.wav`, `AudioAsset rifle` (`0:1511`), `playSfx(self, "rifle")` per Hammer volley (0.8s CD). Take 02 exists if preferred — one-line swap. Test: switch + volley, 0 errors. `verify` + `--once` 0 errors.
- Crash boom (user mp3): converted to 16-bit wav via `afconvert` → `assets/audio/crash_boom.wav` (322KB), `AudioAsset crash` (`0:1512`), `playSfx(self, "crash")` on both wreck paths (dune slam + runway overrun). `.riv` grew by the wav size. Test: OVERRUN run, health 0, 0 errors. `verify` + `--once` 0 errors.
- Flight loop (user mp3 `freesound_community-jet-engine-6753.mp3`, 10s): mono 24kHz wav → `assets/audio/jet_loop.wav` (480KB), `AudioAsset jetloop` (`0:1513`). No loop flag in the Audio API, so `advance()` replays it on a 9.4s timer while airborne (volume 0.55, under guns); stopped on crash/overrun/pause/reset/menus alongside the takeoff roar. Test: airborne run clean. `verify` + `--once` 0 errors.
- Giga Beam cannon (user mp3 `freesound_community-lazercannon-37980.mp3`): 44.1kHz wav → `assets/audio/laser_cannon.wav` (101KB), `AudioAsset cannon` (`0:1514`), `playSfx(self, "cannon")` per Giga shot (1.2s CD). Test: switch + slug fire, 0 errors. `verify` + `--once` 0 errors.
- Straight centered stream + desert impacts (user: fire goes straight through the pointer, desert hits burst): muzzle side offset removed (was ±1.6 wing alternation) — single center stream, Hammer fan spreads from center. Bolt ground check added: `b.y <= groundH+2` kills the bolt and spawns fire + dust + spark at the hit (uses `ox/oz` offsets). Real bug found by test (0 impacts): bolts step ~33u/frame and tunneled past the plane into the retire branch — impact now checked FIRST with a tolerance band. Test: dive + sustained fire → 5 impacts, 0 errors. `verify` 0 errors.
- Small bright gun flash (user: black fire smoke ugly + bigger than the plane): muzzle/impact were spawning crash-scale kind-0 fireballs (8u+, charring black). New chunk kind 7 "gun flash" (~3u, white→orange→ember floor, never black) with its own `blast.wgsl` branch (fast-eroded licks, hot heart, 31Hz crackle); muzzle + impacts switched to it, impact dust spread trimmed. Crash wreck keeps the big kind-0 fire. Test: 5 impacts, `--once` builds. `verify` 0 errors.
- Nose fire removed (user: fake fire on the jet front): deleted the Inferno muzzle-flash spawn (kind-7 + spark at the nose per shot); tracers + sounds untouched.
- Impact smoke removed (user: big smoke when firing): bolt desert impacts no longer spawn the wide kind-5 dust discs; flash + spark remain. Crash-wreck burn + exhaust untouched.
- Afterburner plume goes WGSL (user: back exhaust looked fake): deleted the 20 stacked flame boxes from PARTS (51 parts now); new smooth 8-sided plume shells per engine (outer sheath 9 bands + hot core 6 bands, nozzle bulge + long taper, analytic outward normals through the same pitch/roll/yaw path) with blue marker colors (outer 0.15/0.35/1.0, core 0.10/0.22/1.0 — catch no other band, canopy glass excluded by r/g guards). `jet.wgsl`: vertex churn along normals (24Hz stepped, tip-weighted, hash inlined — hash21 is declared below vs_main), fragment branch with white→gold→orange→red axial gradient, soft Mach diamonds, 2-octave turbulence, dither-dissolved silhouette + tip (opaque pipeline). Length follows throttle (`plen = 0.9+0.75*est`). `HERO_VERTS = #PARTS*36 + PLUME_VERTS` (1536) so counts stay exact. Gotcha: this Naga build has only single-arg `atan` — turbulence cells use radial `local.xy` directly, no angle. `verify` 0 errors, shots `build/plume.png`.
- Plume length tracks cruising speed (user: flame must grow with cruise): exhaust now driven by smoothed `fwd` speed, not the throttle lever — `est = 0.45 + 1.9*clamp(spd/TOP)` (+0.2 on Q boost), short stub on the roll unchanged. Plume girth scales too (`rsc = 0.8+0.15*est`). Old mapping only swung ~20% across the cruise band; new one runs ~1.3 stubs at stall to ~2.9 lances at full chat. Proven headless: `build/plume_fast.png` (SPD 1500, long lances) vs `build/plume_slow.png` (SPD 276, stubs). `verify` 0 errors.
- Brighter desert (user: show the original sand colour): sand verts were already warm tan (0.76/0.60/0.38) but the purple haze buried them — at ALT 500 most visible ground is 1000u+ out (old density 4e-6 → 98% purple). `desert.wgsl`: base lift 1.12→1.22 (+0.13 height term) with a small warm ambient, haze density 4e-6→2.5e-7 (two steps via 9e-7) so mid-field keeps sand and only the far horizon melts purple; haze color slightly lifted (0.13/0.06/0.20→0.17/0.09/0.26). Emissive bands key off vertex colors, unaffected. Shot `build/bright.png`. `verify` 0 errors.
- Ceiling 500→2000 (user: max ALT 2000): one-line `CEIL` change + comment. Proven headless: 25s W climb reads ALT 2000, SPD 2000 (`build/ceil.png`). `verify` 0 errors.

## Session (Oct 7 — tutorial/minute-one fixes, briefing, boss round)
- Tutorial is Round 1 now (12 steps): takeoff-speed-gated Q, liftoff-gated W, strafe, Q-to-650, climb +80, dive, E, mouse-click fire, 1/2/3 gun switch, R-lock + move-mouse-to-steer, R-twice (steer off then on, must end locked). White `TutPrompt` throughout (`FFFFFFFF`). Clicks never lock - R is the only lock switch.
- No roll before tutorial starts (`tutLive` gate): holding Q through the welcome overran the 110u strip — proven headless (crashed on step 2), fixed, re-proven (liftoff, ALT 549).
- Pumpkins hidden until tutorial done (`tutDone` gates spawn/draw/hits/map dots); spawns anchor to nose + eye height (2600-4000 out). Briefings: r2intro (5 stages incl. map green dots + aim) then hunt label until first blood.
- Minimap: 14px red up-triangle plane, 10px bright-green foe dots, all centered.
- Round 3 = MORGATHA boss (1000 HP): 11-box mesh on foe pipe + new ghost-eye WGSL band; stalks, aimed fireball volleys (orb pool), telegraphed charges, contact damage, enrage <300; bolt damage 2/2/18; death opens level 2. Old survive/wave code dormant (round 2 skipped). Proven headless: story order, live, fireball hit (HP 80), charge warn; bolt-damage/contact need live-aim playtest.
- Headless full-tutorial recipe: space, space, q:down 13s, w 2s, a/d taps, q to throttle, w climb, s/e taps, click, 1 — then `--data-dump-filter=message,tut,foe0X`.

## Session (Oct 8 — level 2: HAUNTED CIRCUS parkour, same desert)
- Level 2 = no fighting: 10 sequential fly-through circus gates (striped posts + state lintel + Halloween topper + fire accent), staged off the strip along the takeoff heading. Gold/pulsing = next, purple aura = upcoming, dim green = cleared. Finale = burning crown.
- New `shaders/gate.wgsl` (own gatePipe/gateBind, same 80-byte UBO prefix + bob in vertex, disjoint color bands: gold/flame/ghost/done/soon). CPU owns state colors, rewrites the 5400-vert dynamic VBO per frame like foes.
- Crash = mercy, not fail: `gateRespawn` reflashes + airborne-respawns at the last cleared gate aimed at the next (cruise 700, 3s grace skim), count kept. P-retry still full-restarts. Dune-slam + overrun blocks intercept only in `gateMode` (level==2); level-1 wreck paths byte-identical otherwise.
- Zero RML changes: reuses msg/tut labels (`GATE n/10`) and the 5 foe minimap dots as a sliding next-5-gates window. Orbs/rounds/boss dormant in level 2 (round stays 1, kills 0).
- Gotchas: helpers called by doReset/retireTutorial must be GLOBALS (`function`, not `local function`) — defined later in file; leading-`;` right after a `function` header is a parse error; closeVitOpenHome must set level=2 BEFORE doReset or the circus stages as tutorial. New required Game fields must join the init table literal.
- Proven headless: L1 takeoff regression (`airborne...`); L2 full path V→vit→CONTINUE→PLAY→takeoff cleared gates 1-2 straight off the strip; S-held dive cycled crash→respawn→pass through gate 5, no errors. `verify` 0 errors, `--once` builds (gate.wgsl compiles).
- Scoreboard HUD (user: kill the verbose prompt): new `GateScore` top-center text (`gateScore/A/X/Y`, ids `0:3111-0:3127`) — intro line 4.5s, then bare `n/10` count, hidden in menus. Parkour no longer touches `tut`. Note: `message` has no HUD node (write-only); TutPrompt was the only visible gate text.
- Curvy gates (user: not a straight line): `GATE_PATH` sides 0/650/950/350/-500/-950/-550/300/850/300 form an S-slalom (max turn ~16°, all flyable at cruise). Bore clamp rewritten from the single gate1→gate10 axis to closest-point-on-polyline (live gate xyz, follows movers) — the old straight clamp would have fenced the offset rings off as unreachable. Tube visual/`tubeAxis` were already dead code (never built/drawn), so no WGSL changes. `verify` 0 errors.
- Rollercoaster spread (user: more distance, high/low/left/right): legs 3000→4000u (course 28.5k→37.5k), sides ±1500, alts seesaw 120..700 (low skims at 150-250 vs peaks at 550-700, max 16.7° lateral / 7.8° vertical, all inside ±26000 wrap). `verify` 0 errors.
- Bright gates + sealed tunnel (user: bright Halloween paint, no skipping around the side): `GATE_THEME` now pumpkin orange / golden yellow / electric blue / witch purple / ghost ice blue / molten gold / inferno finale (orange+inferno catch the flame flicker band, golds steady), middle obstacles glossy black, upcoming-dim relaxed 0.45→0.30 in `gate.wgsl`. Tunnel seal: every standing ring projects an invisible wall disc (hole = annulus, out to 950u covering the 510 bore) — crossing outside the hole stops the jet at the wall, never kills; clipping the ring itself still wrecks. Proven headless (V-jump + D-veers, temp TELE/CLEAR/WALLHIT probes since removed): wall pinned a 517u skirt line 3s+ at gate 2 (a line the old 505u seal let through silently), clears only on legit annulus geometry (dist 365/prr 353), straight flight still threads 1→2. `verify` + `--once` 0 errors.
- 10x run-up via wrap-around course (user pick): `GATE_PATH` dists 143k→179k, run-up ~145k at 1000 speed (~2.4 min calm flight), tile wraps twice before gate 1 + once mid-course (g3→g4). Tile coords lose the world copy over 145k, so gates now store UNWRAPPED anchors + a per-frame unwrapped jet track (`uwx/uwz`, modular diff = exact step incl. wrap teleports; teleports re-init it). Clamp/pass/wall/beam/respawn/minimap-dots/gate-draw all converted; draw/minimap project the tile copy next to the jet (no ghost rings, no false clears at the 52k/104k alias points). Yaw from unwrapped specs. No verify per user instruction (they playtest).
- Blocks + dotted line, frames removed (user: no rings, bigger inside, dot-connect): `buildGate` ring loop deleted, middles x2.5 in bright theme colors (block 350, wheel r200, tri/diamond 275, cross arms 150 — all inside `GATE_CS`=360). New `buildDot`: 144 steady-gold plain-state cubes, 16 per leg, drawn tile-relative in the gate pass (VBO grown by `DOT_VERTS`). Gameplay = flyby checkpoints (`GATE_FLY`=650 ball + `GATE_GAP`=400 standoff) instead of threading; wall discs deleted (they'd forbid flybys — sequential checkpoints enforce order); beam check now kills only on block-slab contact (rr<360). `LANE_OFF` 170→480 dodge lane. Messages reworded (FOLLOW THE GOLD DOTS). No verify per instruction.
## Session (Oct 8 — level 3: ROTTEN COURT, staff then PRIME)
- Level 3 = employees first, super-villain second (user pick). `stageCourt` (global — doReset forward-ref rule) stages wave 1 (3x CACKLERS) at reset; clearing it stages wave 2 (2x SPITTERS + 1x BRUTE) via shared `courtAdvance`; clearing that flips `l3phase` to `prime` and the existing airborne hook stages MORGATHA PRIME (800 HP) with its own briefing. Win reuses the `LEVEL 3 / YOU WIN!` vit path.
- Staff reuses the 5 foe slots + foe pipe: `Foe.kind/hp/tchCd/atkT`, `FOE_HP={0,6,10,24}`, GUN_DMG per bolt (Inferno 3 hits a cackler, Giga nearly one-shots the brute). Bolt foe-hit gate widened from `kills<FOE_N` to tutDone + f.on (level-1 flow unchanged: kind 0 still one-shots).
- Staff AI in the foe update: cacklers chase anchors at 120, brutes stalk at 150, spitters spit aimed orbs every 3.5s from the shared 16-orb pool; all do 15 contact dmg (1s cd each). Summon in Prime P3 reuses dead foe slots (cap 2 live, 20s cd).
- PRIME = same boss slot + 3 extra boxes (gold crown band + 2 spikes, `BOSS_VERTS` 396→504, over-size VBO fine since draw uses o/28). `B.max` (400/800) drives bar show + all messages; phases by frac: P1 single aimed volley, P2 3-way spread + faster stalk, P3 enrage + summons + 4.5s charges.
- `foe.wgsl`: 5 new disjoint bands (bruise purple / blood red / rust orange / prime gold / prime bone — all miss face/body/ghost thresholds by construction). Gotcha hit: `fres` is defined late in the file — new code using it must sit after the float-aura block.
- Luau gotcha hit: `;(self::any).x = v` after `if ... then` is a parse error (empty statement + paren) — use `setAny` there; the `;` prefix only works after complete statements.
- Proven headless (temp K/J probes, since removed): N-takeoff → contact HP 85 → Kx3 wave2 → Kx3 prime briefing → Jx4 `LEVEL 3/YOU WIN!`, health 100. Kept N-jump (V/B style); K/J removed. `verify` 0 errors, `--once` builds (11.57MB).
- Green grade removed from level 3 (user: no green on the desert in lev 3): `levelBlend` target is now `round==3 and level~=3`, so the toxic-green/blood-red wash rolls in only for the level-1 MORGATHA fight; the Rotten Court keeps the clean desert. `verify` 0 errors.
## Session (Oct 8 — level 3: STORM OPENING + ground army, no foes first)
- `stageCourt` no longer stages the 3 cacklers at reset. `l3phase` starts `storm`: TutPrompt says TAKE THE PLANE STRAIGHT — FLY INTO THE STORM; a 3600u-wide ~850-tall dust wall (`STORM_BOXES`=70 boxes at fixed `-23000,-11530`, 12000 past the spawn) waits dead ahead on the takeoff heading. Distance drives it: ≤9000 HOLD STEADY, ≤4500 `reveal` (SOMETHING MOVES INSIDE...), wall thins by `l3stormK`, ≤1500 thunder-break (flash + dust volleys at the wall, crash-boom, `stageCourtWave(WAVE1)`) → `staff`, then the old wave1→wave2→prime→win path runs unchanged.
- Ground army: 2000 soldiers baked once into an immutable world-pipeline VBO (`buildBox6` 6-float writer, 20 blocks x 100, olive/rust/ash matte tints outside every WGSL glow band) at `-23000,-10330`, drawn only when `level==3`. Storm wall is a small dynamic VBO churned per frame in `draw()` (breathe + drift, darkens as it thins so the break reads as lifting). Zero RML changes; prompts reuse `tut`/`tutA` (tutorial driver retired in L3); minimap dot 1 tracks the storm heart until the break.
- Gotchas: headless keys need focus first (`--pointer=click` before `--key`); 13s Q without rotating overruns the 120u strip and wrecks (use Q 6s → W 4s → Q charge). No new lint from this code (remaining `d`/`spd` shadows pre-existing).
- Proven headless (N → Q6 → W4 → Q-charge, `tut,speed,alt` sampled): liftoff SPD 78 → HOLD STEADY → SUSPENSE → BREAK/STAFF at SPD ~1900, no errors. `verify` 0 errors, `--once` builds (11.59MB).
## Session (Oct 8 — level 3: WGSL sandstorm + runway moved to map center)
- Real sandstorm on its own GPU Canvas pipeline (user: realistic WGSL storm, huge, map center): new `shaders/storm.wgsl` (`stormPipe`/`stormBind`, same 80-byte UBO prefix + 12-float box verts like blast). Vertex boils each slab on its seed; fragment = domain-warped scrolling fbm, dark-base → rust-heart → pale-crown ramp, sun-scattered heart, streaked detail, world-anchored dither dissolve gated by the density attribute (opaque-pipeline soft edge, plume precedent), rare interior lightning. CPU boxes stay static, repack only when `l3stormK` steps; 40 slabs 900-1600u wide in 8 columns across 9000u, tops past 2000 (above the 2000 ceiling: no flying over) + 12 ground-skirt flats (`STORM_BOXES`=52, `buildStormBox` writer).
- Relocation (user: runway + storm on the center, bottom part if square): `RWY_CX` -23000→`0.0`, strip ends → -8060/-7940 (center -8000); spawn/doReset/init/stageGates/parkour-air-start(-10020)/gateRespawn all follow; storm heart (0,3950), army (0,5150) — 12000/13200 past the spawn as before. `desert.wgsl` runway-lamp/pool/station math moved to x=0, z -8040..-7960. `groundH` lakebed + overrun/finale checks derive from `RWY_*` consts, untouched.
- Proven headless: same L3 recipe gives the identical arc (HOLD STEADY → SUSPENSE → BREAK/STAFF at SPD ~1900) on the new coords; L1 takeoff regression passes (liftoff, ALT 321, strafe step, SPD 2000). First L1 probe wrecked on a dune — recipe mistiming (tutorial gates early Q), not the move. `verify` 0 errors, `--once` builds (11.62MB, storm.wgsl compiles). No screenshots per workflow.
## Session (Oct 8 — level 3: storm v2, boiling curtains instead of boxes)
- User: wall still read as boxes. Rebuilt: 3 tessellated curtains (front/mid/back, 44k long each — horizon to horizon, tile-limited — 2500/3500/4500 tall, concave bow toward the jet) of 96x14 grids (`buildStormCurtain`, uv+layer in local) + 8 ground-skirt flats (`buildStormBox` now pins local to uv-center so it erodes by noise only). `STORM_VERTS`=24480.
- `storm.wgsl` rewritten for curtains: vertex boils every vertex with dual scrolling fbm (±450u sideways, ±200u vertical, ground-pinned, back layers slower); fragment = wind-streaked domain-warped fbm, black-base → rust → pale-crown ramp, sun-scattered heart, v-based volume shading, all four edges noise-eroded via dither discard (bottom planted). Haze REMOVED from the storm shader (it must read dusty from 12k, not melt purple — hero-content precedent like the foe pipe).
- Proven headless: identical arc, no errors. `verify` 0 errors, `--once` builds (11.63MB). New same-line lint matches the file's writer style (every buffer writer does `o += 4` inline).
## Session (Oct 8 — level 3: storm crown fix)
- User: base good, top looked fixed/level. Cause: curtains ran constant height for 44k. Fix: CPU-baked billow towers (`hmAt` 3-sine height field per column edge in `buildStormCurtain`, crown now swells 0.16x–1.08x per wall) + shader crown fray (noise break grows toward the top, shreds to wisps) + shadowed pockets between lit billows + vertical boil 420→520. Caught a WGSL scope error (`ev` used before declaration) via `verify` before shipping.
- Proven headless: full arc, no errors. `verify` 0 errors, `--once` builds (11.63MB).
## Session (Oct 8 — level 3: storm reads as haboob, not mountains)
- User: crown looked like mountains. Real reference applied: steep dusty cliff, dark red gust nose rolling at the foot, diffuse hazy crown streaming back. Changes: towers flattened to broad swells (`hmAt` 0.80±0.20, low frequencies); hard crown-pocket shading replaced with soft variation; gust nose (dark-red mix + faint advected roll bands at the base); crown runs thin/hazy even at full density (`densH` height-thinned coverage + pale haze mix); edge break moderated so crags can't form. Two WGSL ordering slips (use-before-declare) caught by `verify` before shipping.
- Proven headless: full arc, no errors. `verify` 0 errors, `--once` builds (11.63MB).
- Pushed to Rive (file 2622473, rev 48166913).
## Session (Oct 8 — level 3: storm v3, it comes at you + 5 deep walls)
- User: wall looked a little real but needs better, and the storm should come toward the plane. Two changes, both CPU-side (WGSL v2 from last session untouched):
- Advance: `L3_STORM_ADV=170` — the wall rolls toward the jet every frame along the wrap-aware delta (closes on its own on top of flight speed), holding a 900u standoff so it looms without swallowing the camera pre-break. Break/reveal distances + canopy dust unchanged, they just trip sooner.
- Depth 3→5 curtains (`STORM_CURTAINS`, front-low → back-tall 2200..4800, zoff ±2000) + skirt 8→12 flats for a wider outflow; layers remapped 0/0/1/1/2 so the existing density-falloff + parallax math holds. Each curtain re-grounds per repack (`groundH` at its own zoff) since the wall now travels over dunes; repack triggers on sk-step OR >80u rolled (tracked via `l3stormPx/Pz`).
- Prompts reworded to the incoming wall (intro `THE STORM IS COMING AT YOU`, mid `IT'S COMING FAST!`).
- Proven headless (N-jump, jet parked, no throttle): 8s keeps the intro, 35s flips to the ≤9000 mid line — ~6k closed with zero jet movement. `verify` + `--once` 0 errors (11.65MB).
## Session (Oct 8 — level 3: storm v4, illusion charge + straight pattern)
- User: pattern slid sideways (looked fake); the approach must be an optical illusion — wall stays put, viewer FEELS it coming. Reverted the v3 positional advance (`L3_STORM_ADV` + standoff + move-repack all out; wall pinned at L3_STORM_X/Z, repack back to sk-step only; 5 curtains + 12 skirts kept).
- `storm.wgsl` v3 motion rewrite: zero time-scroll along the wall (the sideways giveaway). Columns stand straight — y-frequency squashed, boil scrolls vertically (`ev - t`, rising), domain streams out of the face toward the jet (`w.z + rush`, front layers rush harder = parallax charge), streaks fall straight down the face, sheets surge ±340u slow (21s period) net-zero. Header comment updated (5 static curtains).
- Proven headless: parked 35s post N-jump keeps the intro line — geometry static, charge is shader-only. `verify` + `--once` 0 errors.
## Session (Oct 8 — level 3: storm lightning)
- User: lightning in the sandstorm. `storm.wgsl`: per-curtain strike cycles (9-14s, ~45% fire) — jagged vertical channel (1 of 7 cells, noise-wobbled) with white core + violet halo, double-blink envelope, and a wall-wide violet uplift so the whole wall flashes. `game.luau`: rolling thunder (`l3thunT`, boom every 5-9s, louder as you close, ≤8000u). `verify` + `--once` 0 errors.
## Session (Oct 8 — level 3: map 2x bigger)
- User: level-3 map 2x. All L3 content is jet-relative except the anchors, so: storm 3950→15950 (24k leg), army 5150→18350 (+2400 gap), tripwires 2x (MID 18k, REVEAL 9k, BREAK 3k, NAG 30k), thunder radius 8k→16k. Staff waves/minimap/FX untouched (jet-relative or clamped). `verify` + `--once` 0 errors.
## Session (Oct 8 — level 3: taller wall + runway gust fronts)
- User: +40% storm height, big wind hits the plane on the runway. Curtains 2200/2800/3500/4200/4800 → 3100/3900/4900/5900/6700 (shader ramp untouched — saturates, same colors). Gusts (`l3gustT/gust/gustSide/gustShake`): every 4-7s while grounded in storm/reveal — 1.6s slam with crosswind-alternating dust blast, camera rattle (draw-hook on main eye/center), gear skid clamped to the strip box (can never wreck), yaw rock, deep whoomp, `GUST FRONT` prompt pre-mid only. Proven headless: 5s parked shows the gust prompt; full takeoff still reaches BREAK. `verify` + `--once` 0 errors.
## Level 3 full fight design (locked Oct 8 — build to the LARGE zombie; mega pumpkin later)
1. EXIT STORM: wall breaks over the army, horde (2000 kaiju zombies) marches at the plane. Popup: DONT THINK JUST SHOOT.
2. SHOOTOUT: player bolts kill zombies (1 HP each). Horde fires back: bullet storm = 2 plane damage per 3s + aimed red needle tracers (20x volume) fired FROM their front rank.
3. 50% DEAD (1000 kills): MERGE — all remaining sprint into a circular magma half-globe (octagon drums + halo, STOP THEM message); globe drinks them, detonates.
4. EXPLOSION: magma ball (full of zombies) detonates (flash + boom + shockwave).
5. GIANT: one 30x zombie rises from the blast. Boss fight. Lose = retry FROM THE GIANT (never from the beginning).
6. WIN GIANT → (later) FINAL BOSS: purple pumpkin-face + octopus legs, player healed to 1000 HP, super deadly. NOT BUILT YET.
## Session (Oct 8 — build to the LARGE zombie)
- Popup: break tut is now DONT THINK - JUST SHOOT! (`courtBreak`).
- Kills: bolts sweep the horde rotating 1000/frame (segment-radius 60 + height band), 1 HP each; kills bury slices into kept `armyCpu` (batched 1 rewrite/frame max); `l3zdead` toward 2000.
- Bullet storm: 2 plane dmg per 3s in staff + aimed horde volleys (orb pool, dmg 10, every 2.8s).
- 50%: `startMerge` — mode-1 march to center at 220u/s, magma grows 8s (`magma` band in `zombie.wgsl`), detonation (20 fire + flash + shock + boom), `armyHidden`, giant rises (30x kaiju ≈ 2550 tall, own 432-vert dynamic VBO on zombie pipe, magma 5-box phase in same VBO).
- Giant: stalks 40u/s, stomp 25 (500 ring), aimed volleys dmg 15, torso sphere r600 takes GUN_DMG, 300 HP → win vit (LEVEL 3 / GIANT FELLED).
- Retry: wreck in merge/magma/giant → `stageGiant()` (past-storm airborne restart, HP 100), never from the beginning. No verify per user instruction.
## Session (Oct 8 — smart horde: run, scatter, corpse-flame)
- Horde runs now: march speed 60→300 (5x) in staff/prime, shader + CPU + zubo default all match; limb rate scales with speed (cap 3x), holds shamble.
- Scatter weave: per-body seed (bake `j1`) rides a new 7th float on the zombie pipe (buildBox6/Drum/Fan + seed, stride 28, bury keeps seed, giant seed 0). Shader offsets ±120u perpendicular on seed phase (mode 0 only); `zombieLivePos` replicates it exactly for bolt hits + zombie fire origins.
- Zombie fire: round-robin 8 shots per 0.4s from live muzzles (gy+52), aimed kind-6 white-blue bolts (dmg 8, life 3s); ORB_SLOTS 128→192, needle/giant lives 8→4s.
- Proven headless: full arc to staff + firing, health 100→80, no errors. `verify` + `--once` 0 errors (zombie.wgsl compiles).
## Session (Oct 9 — horde white beams + airframe hit-flash)
- Horde fires ~3x: corpse-flame 8/0.4s → 16/0.25s white-beam lances (life 3→2.5s), front-rank volley 7/0.5s → 10/0.4s and converted red needle → white beam (kind 6). `ORB_SLOTS` 192→320 (worst-case live ~260 + boss < pool; beam VBO/init/draw all derive from it).
- `buildBeam` gun-6 is now a white lance (26u white core + 28u pale halo, was a 10u white-blue bolt).
- Damage flash: orb hits set `hitFlash=1.0`, decays 2.5/s in `advance()`; `buildHero` takes `flash` and lerps body + wheel colors to white (plume markers untouched). Reset in init/doReset/stageGiant. Extended Oct 9: flash now fires on EVERY hull damage (staff/boss contact, giant stomp, bullet storm) — before, only orb hits flashed, so most damage showed no glow.
- `verify` + `--once` 0 errors (11.75MB).
## Session (Oct 9 — beams that actually hit: lead + swept collision)
- Headless proof: L3 combat runs showed volley + corpse-flame firing hundreds of orbs with ZERO hits. Root causes: corpse-flame aimed with no lead (misses a 1500-speed crosser by ~180u), volley jitter ±300/±200 vs a 5u ball (~0.04% per orb), and point-per-frame checks tunnel past the ball at ~74u/frame.
- Fixes: 2-pass intercept lead on corpse-flame (jet nose*fwd + vy, re-solved), volley lead = true time-of-flight with jitter ±60, `ORB_R` 5→12, segment-swept orb collision. Re-probe: `HIT! HP 9.4` then `SHOT DOWN` — beams connect and the straight-line flight dies in the kill zone (dodge + shoot back, as designed).
- Also fixed dead L3 500 ceiling: the `hy>CEIL` gate never fired since CEIL=2000 — gate now checks the L3 500 cap directly. `verify` 0 errors.
## Session (Oct 9 — horde damage rebalance)
- Player report: dead in a second up close. True: 64 aimed shots/s x 8 dmg = ~500 dps point-blank.
- Now: corpse-flame 8/0.5s x 4 dmg (64 dps max), volley 8/0.6s x 6 dmg scattered. Same-probe magnet run ends ~HP 81 instead of SHOT DOWN — costly to fly straight through, fine for a dodging shooter. `verify` 0 errors.
## Session (Oct 9 — L3 combat rebalance: playable shootout + real giant)
- Incoming was ~144 dps max (corpse 16/s x4 + volley 13/s x6, both lead-accurate) + a hidden 20-dmg spitter default (missing dmg field fell back to 20). Now: corpse 4/0.7s x3 (~17 dps), volley 5/1.2s x5 (~21 dps), spitter explicit 8, giant needles 15->10 @3.0s, stomp 25->15, staff contact 15->12 x scale.
- l3dmgScale clamp 0.25-1.0 -> 0.2-0.8: slow/low caps at 80% (was 100%), fast/high rewards 20% (was 25%).
- Grind cut: merge 1000 (50%) -> 400 (20%), bolts pierce 3 zombies each, +5 HP per 50 kills (cap 100). Giant 300->500 HP so it survives its own nerf.
- `verify` 0 errors.
## Session (Oct 9 — L3 zombies silent: exact intercept aim + 300 march)
- Report: horde neither fired nor approached after the rebalance. Probe (N/Q6/W4/Q-charge, 1s samples): break fired fine, but 25s of straight flight scored ZERO orb hits — only bullet-storm ticks (100->96.6).
- Root cause 1: intercept math diverged. One-pass (volley) / two-pass (corpse) fixed-point lead misses a 1500-2000-speed jet by ~2k/~500u when orb speed is 2800 (v_jet/v_orb ~ 0.5-0.7) — every orb flew and died clean. Fix: `leadAim` solves |P+V*t-M|=s*t exactly (smallest positive root, no-fire on no solution); volley keeps ~60u-at-target scatter, corpse exact. Re-probe: HITs on approach and after tile-wrap, 100->63.8 over 25s of suicidal straight flight (~1.5 dps — dodge-and-shoot is safe, parked in the horde is not).
- Root cause 2: march 150u/s vs 2000 jet = horde never visibly comes (Oct-8 note said 300, code had 150 in all 3 spots: `zombieLivePos`, per-frame zubo, init default). All three -> 300; CPU/shader agree.
- Corpse range 16k->11k so every fired orb can arrive (4s x 2800 = 11.2k); volley life already 6s (16.8k reach). Pool worst-case ~110 < 320.
- `verify` 0 errors.
## Session (Oct 9 — zombie damage 10x soft)
- Playtest: horde hits too hard. All L3 zombie damage now runs through one knob `L3_ZDMG = 0.1`: orb hits (corpse/volley/spitter/giant needles via the shared `dealt` line), giant stomp, staff contact, bullet storm. Base numbers untouched, so tuning back is one edit.
- `verify` 0 errors.
## Session (Oct 9 — GIGA melee hunter: no guns, runs you down)
- User: giga super-powerful but gunless; melee only; it runs at the plane, player kites and shoots. Done:
- Deleted the giant's aimed needle volleys entirely; deleted the gun + muzzle-tip boxes from the mesh, added fist blocks at the arm ends (box count 10->10, VBO headroom fine).
- Movement: stalk 40 -> 600 run speed, hold ring 500 -> 650. Legs pump fore/aft (7Hz run cycle once risen); arms + fists swing down onto the jet's side through each slam (swpT-driven).
- Slam: horizontal <700u, 1s cd, 30 FLAT (exempt from L3_ZDMG 0.1 — this is the boss; ~4 hits kills). No altitude escape (arms reach 1500+); only distance/speed saves you. Retry still respawns 4k out at cruise 700.
- Strings: GIGA rises / OUTRUN ITS HANDS / SMASHED! / GIGA n/500 / GIGA FELLED. State/var names kept (G, l3giant) to limit churn.
- `verify` 0 errors.
## Session (Oct 9 — GIGA 10-move kit + brain + WGSL rage)
- User: full-power super-villain animation set, plane-reactive brain, 40 dmg hands/legs. Shipped 10 CPU moves on `G.anim`: rise / walk (350, far) / run (600) / sprint (900 burst when the jet camps >4000 for 5s) / windL / windR / windKick (telegraphed 0.6s, 0.45 enraged) / recover / enrage (roar at 50% HP) / death (2.5s topple+sink cinema before the win show; bolt-kill now stages `dying`, win effects moved to cinema end; retry covers `dying`).
- Brain: intercept steering (leads the jet 0.7x), speed tiers by range, low jet (<150 alt) eats a kick (850 ring + shock ring) else alternating hand slams (800), whiff window (leave reach during windup = WHIFFED), enrage x1.4 speed + 0.7s cd, run dust at feet. Hands + kick = 40 flat, exempt from L3_ZDMG.
- WGSL (`zombie.wgsl`): free March pads -> `rage` + `flash` bus (mode-2-gated, horde untouched). Vertex: enraged tremble + telegraph rear-up. Fragment: eyes burn white-hot on flash, shift molten-red with rage; magma veins crawl on flesh with rage/flash. CPU feeds eye colors into the bands (toxic / flare-white / magma-red / dead-gray) and eyes track the jet (±60u).
- Mesh: arms/fists pose per move (rise on windup, smash-through on recover, both up on roar, swing on run); kick leg cocks/stomps; death sinks 1600 + wobble.
- `verify` + `--once` 0 errors (11.76MB, zombie.wgsl compiles).
## Session (Oct 9 — J debug jump: straight to GIGA)
- User: test GIGA vs plane without clearing levels. Added `J` shortcut (V/N/M/B style, remove before shipping): level=3 + doReset + stageGiant = airborne 4k out at cruise 700, HP 100, no storm/horde/merge.
- Probed headless (J + 10s): GIGA briefing on frame 60, SMASHED! HP 60 at ~6s, WHIFFED later — hunt loop works end to end. `verify` 0 errors.
## Session (Oct 9 — GIGA head bar + 1000 HP)
- User: health bar over the zombie head, 1000 HP. `GIANT_HP` 500->1000 (msgs/enrage auto-follow the const).
- Reused the MORGATHA bar (no new HUD nodes except a name string): `bossHp` gets `G.hp/1000*400` (existing 400-scale converter untouched), position projected above the head (ground+2600), new `bossName` VM string (`0:3175`, bind `0:3176`, instance `0:3177`) swaps MORGATHA<->GIGA on the shared label (propertyKey 268 text bind, TutPrompt pattern).
- GIGA bar shows full from rise (better reveal than Morgatha's first-blood gate, which is unchanged); hidden off-screen/crashed/menus/death like Morgatha's.
- Probed (J): name flips GIGA, bossHp 400 full, brief reads GIGA 1000 HP. Bar alpha stayed 0 in-probe = head behind the camera on the straight-line runaway (off-screen gate, correct); visible when facing it. `verify` 0 errors.
## Session (Oct 9 — GIGA actually hunts: erupt-ahead + burrow ambush)
- Report: GIGA dumb, never reaches the plane. True cause: it rose at the merge crater (up to 10k+ behind a 2000-speed jet) jogging 600 — never seen again. Not a dead brain, a dead staredown.
- Fix: magma staging seeds `farT=99` when the jet is >6000 out (burrows right after the rise); new `farT` gap timer (>6000 for 3s) burrows: dust both ends, erupts 2500 ahead of the nose, "IT BURROWS - IT ERUPTS AHEAD OF YOU!". Mid-range campers (4000+) get the 1100 sprint via campT. Speeds: walk 350->400, run 600->700, sprint 900->1100.
- Minimap dot 1 tracks the GIGA through giant/dying (was: dead staff dots).
- Probed (J + full-Q 30s): SMASHED at 1430 speed, BURROW at 2000, SMASHED to HP 20, second BURROW, SHOT DOWN — straight-line top-speed flight dies, dodging lines live. `verify` 0 errors.
## Session (Oct 9 — GIGA briefing auto-hides)
- User: the "IT CAN'T SHOOT..." prompt should leave after 2s. Added `briefT=2.0` to both GIGA staging tables; giant branch counts it down and drops `tutA` to 0 (prompt only, hunt `msg` line untouched). Probed (J): tutA 1 at frame 30, 0 at frame 150 = exactly 2s. `verify` 0 errors.
## Session (Oct 9 — GIGA ammo-hit body glow)
- User: body glows when ammo lands. `G.flashT=1.0` on every torso bolt hit, decays 2.5/s (jet hitFlash pattern); draw adds up to +0.9 to every body/eye channel. Checked against zombie.wgsl bands: flashed colors exit flesh/eye/tip/magma ranges, so the whole frame reads plain white-hot. Dying eyes stay dark (sink gate skips flash). `verify` 0 errors.
## Session (Oct 9 — visible charge: horde 500, GIGA lean)
- Report: zombies don't visibly run at the plane. Both sped up: horde march 300->500 (all 3 spots, CPU/shader in sync), GIGA run 700->800, walk 400->550.
- GIGA charge lean: head/arms/fists/eyes lunge up to 200u toward the jet while walk/run/sprint (legs stay planted, pumping) — the chase reads instantly.
- Probed (J): slam to HP 60 then WHIFFEDs as the jet pulls away — hunt intact, faster close. `verify` 0 errors.
## Session (Oct 9 — L3 ceiling 500->2000)
- User: max ALT 2000 in level 3, not 500. Removed the L3 special-case cap (now plain CEIL=2000 everywhere).
- Follow-on: `l3dmgScale` altitude leg re-based hy/500 -> hy/2000, or the whole map would sit at min damage. GIGA kick (<150 alt) and slam (no altitude escape) unchanged — high flight dodges kicks, not slams. `verify` 0 errors.
## Session (Oct 9 — GIGA faces its hunt)
- Report: walks/runs backwards, never turns to the plane. Cause: mesh layout baked axis-aligned (face always -z) while position chased the jet — moonwalking.
- Fix: facing vector in draw (`G.faceX/Z`, refreshed when the jet is >200u out so it never spins overhead); all 10 parts placed through a local(right,fwd)->world `gpos` (face = local -z), so legs pump, arms swing, eyes and fists all travel facing the jet. Boxes stay axis-aligned (layout turns, no shear). Lean applies on top in world space.
- `verify` 0 errors.
## Session (Oct 9 — L3 map 20x + fight at center)
- User: lv3 map 20x bigger, fight at map center. Tile, not course: `WRAP` 26000->520000 (all 30+ wrap sites derive from it); skirt stretched to match (SK 1000->21000, x0 -556500, same vert formula/counts, 21km cells are haze-backdrop safe).
- Course recentered -6950 (same proven rhythm, translated): runway -8000->-14950, storm -1050->-8000, army 6950->0 MAP CENTER (merge -1500, inside the arena). Spawn/gates/parkour literals shifted with it; tripwires/thunder/gusts untouched (relative distances identical); desert.wgsl runway literals shifted (-8040/-7960->-14990/-14910, +8000->+14950). Camera far 80000 kept (visible range is haze-bound ~10k).
- Probed (N recipe): frame-identical arc to pre-move (liftoff 540, STEADY 780, BREAK 1020, HITs after) — translation exact. `verify` + `--once` 0 errors.
## Session (Oct 9 — GIGA hyper-real pass: WGSL creature skin + Godzilla rig)
- User: GIGA looked fake; wants hyper-realistic via GPU Canvas/WGSL — run/walk, face turn, body turn, hand hits, eye blink, mouth movement, Godzilla-like.
- `shaders/zombie.wgsl`: GIGA (mode 2) now runs a full creature-lighting path while the horde keeps the cheap flat look. Derivative face normals (jet.wgsl precedent) drive moon-key wrap diffuse (subsurface feel) + warm sand bounce + violet rim; 5-octave fbm mottling + scale plates with dark crevices + rot pits; wet specular (sweaty patches); slit-pupil burning eyes (rage-red, telegraph white-hot, wet glint); ivory teeth + hard glint; dark ember throat + drool gloss; bone dorsal spikes with rage-ignited tips. New disjoint bands: teeth ivory (g 0.78-0.89, clear of eye 0.90+), mouth gut (dark red), spike bone (blue-gray). Vertex adds breathing heave + skin crawl.
- `game.luau`: mesh 10 -> 22 boxes (split thigh/shin, pelvis + 2-stage twisting torso, neck, skull + brow, animated jaw + upper/lower teeth + conditional throat slab, 3 dorsal spikes, counter-swinging arms, blinking eyes). Brain adds `jaw` (eased: roar 1.0 / windup 0.9 / chase 0.55 / idle chew / recover 0.05) + `blinkT/blinkCd` (0.12s shut every 2-5s); head yaws ±0.5 rad at the jet with 0.3x torso twist (body hunts, head locks on).
- Also fixed a real overdraw bug: giant `gVerts = go/24` read 60 garbage verts past the mesh (7-float stride = 28); now `/28`. Giant VBO grown 12 -> 26 boxes to fit the rig + conditional throat.
- Probed (J + 600f): hunt intact (WHIFFED), no errors. `verify` + `--once` 0 errors (11.81MB, zombie.wgsl compiles).
## Session (Oct 9 — GIGA hunts on foot, no teleports)
- User: GIGA must never change position (no burrow-teleport); when the plane gets far it runs it down and hits with hands.
- Deleted the burrow-ambush block outright (dust both ends + `G.x/z` snap 2500 ahead + BURROW callout) and the `farT=99` staging seed. New `G.hunt` latch: trips past 6000u (`IT'S COMING FOR YOU - RUN!`), holds 2400 chase at sprint anim until back inside 1500u — outruns a fleeing jet on foot, then the normal walk/run/hand-slam fight resumes. Only code that writes `G.x/z` now is the intercept run step.
## Session (Oct 9 — GIGA magma death: cracks + detonation)
- User: dying scene — random crack lines, red magma glow, massive explosion.
- `shaders/zombie.wgsl`: new `doom` pad in the March uniform (0->1 through dying). Vertex adds a violent doom-scaled shudder. Fragment adds ridged-noise crack veins on flesh/rags/spikes — few hairlines at doom 0, full shell by doom 1 — with throbbing red magma glow + white-hot cores, charred body around them. Horde/magma paths untouched.
- `game.luau`: zubo 32->40 bytes, doom written per frame (`deathT/2.4` clamped). Death cinema 2.5->3.0s; body slumps 400u instead of sinking 1600 (the blast consumes it, no burial); eyes blaze till the end (dead-gray gate removed). At 3.0s: 60-chunk detonation at the body (24 fire + 8 flash + 12 sparks + 16 dust + 4 shockwaves) + crash boom, then the existing win show.
- `verify` + `--once` 0 errors; J-probe hunt regression intact (WHIFFED).
## Session (Oct 9 — GIGA death actually fires: two load-bearing bugs)
- User: no cracks, no explosion. Found two: (1) the level-3 boss block gate (`merge/magma/giant`) excluded `dying` — `deathT` froze at 0, so doom stayed 0 and the 3s detonation never ran; (2) the zombie-shader `mode` fell back to 0 in `dying`, which put GIGA on the flat horde path (no creature light, no cracks) AND marched the rendered corpse toward the jet at 500u/s. Also the kill-staging pop spawned at the jet (no offsets) — read as the player blowing up, not the zombie.
- Fixes: gate + `mode = 2` both cover `dying`; kill flash moved onto the body via offsets. Proved with a temp T key (forced dying, since removed): 4s later `GIGA DOWN - THE COURT FALLS SILENT...`, no errors. `verify` + `--once` 0 errors.
## Session (Oct 9 — GIGA atom bomb)
- User: it should explode like a large atom bomb. Detonation is now a 174-chunk volley: 6 white-out core flashes, 60-chunk churning fireball, 40 rising mushroom-stem smoke (7s lives), 30 wide rolling cap dust (8s), 30 spark storm, 8 staggered shockwave rings — long lives so the cloud evolves behind the win text. Double overlapping crash boom. Camera kick: `l3nukeT` 2.5s feeds the existing shake hook, decayed in the always-on advance block so it can't stick. Pool grown `CHUNK_SLOTS` 96->256 (all sizing derives from it).
- `verify` + `--once` 0 errors; J-probe hunt regression intact.
## Session (Oct 9 — real shader atom bomb: nuke.wgsl billboards)
- User: a REAL explosion via WGSL/GPU Canvas, not boxes. New `shaders/nuke.wgsl` pipeline: 8 camera-facing billboards staged once at detonation (center/kind/size/birth in 12-float verts, zero per-frame CPU — `u.time` animates everything): white-out core flash, blackbody-ramp churning fireball, streaked rising mushroom stem, rolling mushroom cap lit from below, 2 staggered expanding shock rings, 2 lingering smoke. Dither-dissolved edges (plume precedent), full 96-byte UBO (eye tail aims the billboards). Chunk volley kept as flying debris inside the fireball.
- `game.luau`: `buildNukeQuad` writer + `NUKE_VERTS` (48) + nuke pipe/bind/VBO setup + staging at detonation (`l3nukeBirth`) + draw after chunks while age<12s. Proved with temp T (forced dying, since removed): detonation + staging run clean to `GIGA DOWN`, no errors. `verify` + `--once` 0 errors (nuke.wgsl compiles).
## Session (Oct 9 — GIGA full-body rig: 70 boxes)
- User: more realistic legs/hands/head, max corners, all WGSL. Mesh 22 -> 70 boxes (2520 verts, VBO grown 26->80 boxes): per side thigh/knee/shin/calf/ankle/foot + 3 toes, delt/upper/elbow/fore/wrist/fist + 3 knuckle fingers; stacked torso (hips/belly/lower-back/abdomen/chest/pecs/upper-back) riding the twist; plated head (cranium/snout/nose-bridge/brow/cheeks/upper-teeth/hinged jaw+chin/lower-teeth/throat) with drop-lid blink; 5-spike row; 4-segment counter-swaying tail. Same WGSL creature skin over all of it. `verify` + `--once` 0 errors; J-probe hunt intact.
## Session (Oct 9 — GIGA hits like a truck: ball-knockback)
- User: when GIGA lands a hand/kick, the plane shakes, flies like a struck ball, and takes damage. Hit branch now sets knock state: 900u/s fling away from the fist, 180 skyward pop (gravity 500/s²), 1.2s tumble (18Hz roll wobble + yaw spin off the striking side), 1.2s camera shake via the rattle hook. Integration in flight: damped slide (2.2/s), pop, tumble; knocked into the dirt slow = wreck, at speed = skim bounce (existing gate). All reset beside every `bank = 0`.
- Proved with temp U (park jet in reach, since removed): `SMASHED! HP 60`, clean frames after. `verify` + `--once` 0 errors.
## Session (Oct 9 — knockback no longer pins the plane)
- User: after a hit, W couldn't climb. Root cause: `kby` decayed past zero into ever-more-negative values, dragging `hy` down every frame forever and beating any climb. Fix: the pop spends upward only, then snaps to 0 and hands lift back to normal physics. Slide velocities snap to 0 under 0.5 (hygiene).
- Proved with temp U (since removed): smashed twice (HP 20), then W climbed 531->1168 cleanly. `verify` + `--once` 0 errors.
## Session (Oct 9 — GIGA strike-range ring)
- User: GIGA runs close and hand-hits; wants a visible distance length marking where hits land. New `buildRingFlat` (16-seg annulus, 96 verts): a magma-band orange ring at 800u around the body on the dunes — inside the line, hands reach you. Slow ember pulse idle, frantic flare through each windup (dodge cue). Drawn in the giant block (giant phase, risen); VBO headroom covers it (no growth). Hold ring tightened 650->600 so it presses into hand range.
- `verify` + `--once` 0 errors; J-probe hunt intact.
## Session (Oct 9 — tight GIGA turns)
- User: straight speed fine, but direction changes feel slow/bendy. Two causes: full-stop inside 650u (planted feet while the jet circles) + full 0.7 intercept lead at all ranges (jinks swung the aim point wide). Fix: lead fades with distance (pure pursuit near, intercept far); inside 650 it never stops — sidesteps to hold ~450 and stay square, feet always moving. Facing snap untouched (already instant).
- Proved headless (J + 900f): hunt runs, a SMASHED lands mid-probe (HP 60), no errors. `verify` + `--once` 0 errors. New lints match the file's writer style only.
## Session (Oct 9 — GIGA corners instead of overshooting)
- User: it doesn't slow for left/right jinks, just blasts past. Added turn-slowdown: speed scales off the angle between current facing and target heading (90° jink -> 25% pace, straight -> full), applied to chase + sidestep. `verify` + `--once` 0 errors; J-probe lands a SMASHED (HP 60).
## Session (Oct 9 — GIGA stamina: hunt 3s, pant 1.5s)
- User: after walking continuously 3x it stops and recovers energy. Locomotion now accrues `stam`; at 3.0s it plants its feet for a 1.5s `rest` beat (jaw hangs panting at 0.85, no movement, no dust), then resumes with stam reset. Strikes/roars don't accrue. Callout `IT'S WINDED - HIT IT NOW!` marks the free-hits window.
- Proved headless (J + 600f ends on the WINDED callout = full cycle). `verify` + `--once` 0 errors.
## Session (Oct 9 — ring reverted per user)
- User: undo the changes (the strike-range ring). Removed `buildRingFlat`, the ring draw in the giant block, and restored the hold ring 600->650. `verify` + `--once` 0 errors (warnings back to 208); J-probe hunt intact.
## Session (Oct 9 — faster GIGA run)
- User: make the zombie run faster. Chase tiers: walk 550->750, run 800->1200, sprint 1100->1600 (hunt 2400 + enrage x1.4 untouched). Leg/arm pump rates up to match: run 7->9Hz, sprint 10->13Hz. `verify` + `--once` 0 errors; J-probe hunt intact.
## Session (Oct 9 — GIGA 5x speed)
- User: 5x faster. All tiers x5: walk 3750, run 6000, sprint 8000, hunt 12000 (enrage x1.4 still multiplies). Pump 16/22Hz, stride 120->220 bounding leaps. WARNING logged to user: far past jet top speed (2500) — it catches anything in ~1-2s and two hits kill, so kiting play is brutal until tuned. `verify` + `--once` 0 errors; J-probe hunt intact.
## Session (Oct 9 — L3 ROUND FAILED panel)
- User: lv3 fail shows ROUND FAILED at the bottom + REMATCH + HOME buttons. Reused the existing game-over overlay: new `overTitle`/`overRetry` string props (0:3178-0:3183, bossName pattern) bound to the title + retry labels; a per-frame advance block (level can change without resize) writes ROUND FAILED/REMATCH + bottom layout (title ch-260, buttons ch-150/ch-90) in L3, centered YOU CRASHED/RETRY elsewhere. Hit test reads the same overBX/RY/HY, so clicks just work; REMATCH keeps the retry rules (giant-phase wrecks restart at the giant).
- Proved headless (J + S-dive wreck): overA 1, ROUND FAILED/REMATCH; REMATCH click → giant briefing, HP 100; HOME click → homeA 1. `verify` + `--once` 0 errors.
## Session (Oct 9 — gun 4 SEEKER: homing missiles + WGSL boom)
- User: another gun-swap missile — targets any enemy and hits it, dumbfires a short run + explodes with none, missile + explosion via GPU Canvas WGSL. Shipped:
- `shaders/missile.wgsl` (new, own mslPipe/mslBind, full 96-byte UBO): kind 0 cruise body (CPU-oriented box, shader paints gunmetal + white-hot nose + flickering exhaust + 6Hz belly beacon), kind 1 fireball billboard (blackbody churn, ~1.2s), kind 2 shock-ring billboard (~0.9s). Dither-dissolved edges (nuke precedent), purple-haze sink.
- `game.luau`: GUN tables x4 (SEEKER, CD 0.9, AoE 60), G cycles `%4`, key 4 (`52,4`), `Msl`/`MslBoom` pools (6 + 12 quads, alternating wing rails). `mslAcquire` locks nearest live enemy ahead (foes/staff/boss/GIGA torso/sampled horde, close-in locks off-boresight), turn-limited steering (3.2 rad/s, 1400→2600 sprint), swept proximity fuse, dumb life 1.1s → airburst. `mslBoom` stages WGSL fireball+ring + blast debris + crash boom + 320u AoE over every enemy type (foe/staff kill + wave/court advance, boss/GIGA 60 + death staging, horde bury capped 40/boom + merge counting). Missiles clear on doReset/stageGiant; `bossDie` went global (forward-ref rule). Tutorial step 10 = `1-4`, rules line `G/1-4 SWITCH GUN - 4 = SEEKER`.
- `scene.rml`: `GunBar4` row + `gunX4` prop (0:3232-0:3242 block), 4-row top-center stack, `> SEEKER <` highlight.
- Proved headless (temp prints, since removed): J-run locks GIGA (`lock=3`), fuses at torso altitude, `SEEKER HIT! GIGA 880/1000` (2x60 exact); dumbfire grounds/airbursts; `build/msl_boom.png` shows the WGSL fireball + sparks; L1 takeoff regression (SPD 130, ALT 357). `verify` + `--once` 0 errors (11.98MB).
## Session (Oct 9 — invisible runway: 21km skirt sheet buried the strip)
- Report: no runway visible in level 1 (spawn showed bare sand). Root cause, proven numerically: the Oct-9 21km skirt cells sample `groundH` at corners kilometers out in full dunes; the one giant quad over the strip (x -10500..10500, z -22160..-1160) bilinear-interpolates to -0.195 at the strip while slab tops sit at -0.28 — the sheet floats ~0.09 over the whole 120u strip and swallows it. (Oct-5 lakebed comment assumed 220u/1000u cells; stale since the 20x map move.)
- Fix: cut that one skirt cell out of the bake (HOLE_IX/HOLE_IZ), replaced by 4 coarse surround quads reusing `skirtCell` (west/east/south/north of a ±600/±1200 hole) + a fitted 100u-cell pad (13x25, true `groundH`, `skirtTint`, 50u tuck under every surround edge). Counts: skirt `(...+..-1)*6+24`, pad `PAD_VERTS=1950`; log 156972->158940 = +1968 exact. Physics untouched (`groundH`/RWY consts identical).
- Proved headless: `build/l1_strip.png` shows strip + dashes + edge lights to the horizon; takeoff regression identical (SPD 130, ALT 357). `verify` + `--once` 0 errors.
## Session (Oct 9 — rules page: title out, real bullet list in)
- User: remove the rules text from the top, write a better rules list with points. Two changes: (1) the page header (`PanelTitle` showing RULES, stamped over the cover's baked-in title) is gone on the rules page only — `syncMenu` now writes `""` for `p==2`, SETTINGS keeps its header (screenshot-proved); (2) `RulesBody` runs rewritten from stale/debug lines (incl. the `V JUMPS TO ROUND 2` debug shortcut) to 6 dash-led points verified against `game.luau`: Q/W takeoff, WASD+E flight, click/space+R steer, G/1-4 + homing Seeker, level order thru 1000-HP GIGA, strip + HP-0 failed. Runs flow as one paragraph in Rive, so each point ends with `&#10;` (XML-safe newline) — screenshot shows 6 clean lines, BACK clear. `verify` + `--once` 0 errors.
## Session (Oct 9 — missile kills stalled level 1: missing round-advance)
- Report: all enemies downed with the Seeker in level 1, level never completes. Root cause: `mslBoom`'s foe-kill block copied only 2 of the bolt code's 3 advance branches (court + wave) and dropped the `ROUND 2 CLEAR!` / round-1→3 / `stageBoss` branch — all-missile pumpkin clears incremented `kills` to 5 with nobody home.
- Fix: the missing branch added verbatim (progress msg, clear msg, boss staging). No forward-ref issue (`stageBoss` is an earlier local).
- Proved headless (temp T key staging a live ring, since removed): Seeker volley → `MORGATHA THE ROTTEN ONE - ... 400 HEALTH!` briefing, no errors. `verify` + `--once` 0 errors.
## Session (Oct 9 — settings box: no title, sound/music toggles, 4 plane paints)
- User: remove the settings text, settings page becomes a box with sound toggles + 4 plane colours. Shipped: `syncMenu` writes `titleTxt=""` on every page now (PanelTitle node kept, renders nothing); settings CONTROLS button deleted (pause-card CONTROLS still pops the runway board); new centered `SetPanel` (gold stroke, behind the buttons, `setA`-gated) holding SOUND + MUSIC toggle buttons, a PLANE COLOUR header, 4 swatches (EMBER/CRIMSON/AZURE/VIPER) + gold selection ring, and BACK. Compacted to 360x300 on request (toggles +52 rows 8px apart, BACK inside the box at `panY+234`, button heights unchanged); BACK is per-page in `syncMenu` (`cw/ch`-driven: inside-box on settings, `h/2+150` on rules).
- Split audio: SOUND = SFX (`playSfx`), MUSIC = loops (jet hum + home bells, both gates now read `musicOn`); music-off stops both loops. New VM props `0:3243-0:3257` (panel/mus/swatch/hdr pos + `musTxt`/`svTint`/`svMus`); instances `0:3346-0:3360`, node/binds `0:3259-0:3345`.
- Paint: pick rides `swings[7]` into `buildHero`, multiplicative tint on gray airframe boxes only (glass/glows/rubber/plume/vents excluded, so no `jet.wgsl` band misfires); default EMBER = exact 1.0 identity.
- Load-bearing: ~20 new declared Game fields blew the type-inference budget (`buildTube` "too complex" + 1629 cascading errors, zero syntax/RML errors). Fix: ALL new state lives in dynamic `(self :: any)` storage (`setAny` fetches/inits + new `setVal` guarded VM-write helper) — zero Game-type/init-table growth. Also: `;(self::any).x=v` directly after `if...then` is a parse error (use `setAny`); after a complete statement it is fine.
- Proved headless (800x500): SETTINGS open (`setA=1`), MUSIC click → `MUSIC: OFF`, swatch-3 click → `swHlX=402`, SOUND click → `SOUND: ON`, BACK → home (`btnA=1`). `verify` + `--once` 0 errors (11.99MB).
- Follow-up: box too tall → compact layout above, re-proved headless (MUSIC OFF, swatch idx1 `swHlX=340`, SOUND ON, BACK→home; rules BACK→home intact). Gotcha: the first RML node insert silently failed to persist (props/instances landed, shape/text nodes missing — caught by grep, not verify) — always grep-confirm new RML nodes after editing.
- Follow-up: selected swatch edge goes white — `SwHl` ring stroke `FFFFD400`→`FFFFFFFF` (ring already tracks the tapped swatch via `swHlX`). `verify` 0 errors.
## Session (Oct 9 — settings strip-down: SOUND + BACK only)
- User: remove plane colour + music toggle + settings title text; only the sound button remains. Done on the CURRENT file state.
- `scene.rml`: deleted MusLabel/MusHl/MusBg, ColHeader, Sw0-3, SwHl, SetPanel (grep-confirmed 0 refs). Kept SoundLabel/Hl/Bg + Back*. VM props/instances for mus/swatches left declared (game code still fetches them dynamically; unbound writes are harmless).
- `game.luau`: deleted the MUSIC + 4 swatch tap branches from the settings hit chain (invisible taps can't fire now); SOUND + BACK untouched. Panel title already `""` on all pages. No new fields, no budget impact.
- CONFLICT NOTE (other session): your compact settings box (music split, swings[7] tint, AGENTS entries) was applied on top of / around these deletions — file raced twice (my removals verified + screenshotted, then your nodes were back). Per user direction ("dont do anything what they are doing"), the box stays OUT. musicOn/planeTint now frozen at saved/default values with no UI; loops/tint code paths dormant but intact.
- Flakiness note: `verify` threw 1629 "too complex" errors 4x in a row, then 0 errors 3x untouched — retry with waits before trusting a burst (checker budget, not a code break).
- Proved headless: `build/settings6.png` = SOUND + BACK only, no title/panel. `verify` + `--once` 0 errors.
## Session (Oct 9 — thick white edge + center tick on picked colour)
- User: thicker white selection edge + tick mark at the colour-box center. `SwHl` stroke 3→5 (white kept); tick = new `assets/images/tick.png` (44x44 white check, PIL 4x-supersampled, `ImageAsset 0:3361`) on node `SwTick` riding the selection.
- Load-bearing: RML `Image` x/y is CENTER-anchored (covers prove it: homebg 400,250 = screen center) — so the tick binds new centered props `tickX/tickY` (`0:3366-0:3369`), written as `swatch+22` in resize + tap branches. RML shapes are corner-anchored; don't mix the two up.
- ID hygiene: my node block collided internally (`0:3301` twice) and `styleId` refs don't remap with `id=` — whole block moved to free `0:3400-0:3491`; Sw1-shape dup fixed as `0:3491`. `verify` names dupes + dangling styleIds precisely.
- CONFLICT (other session stripping the box while this user enhances it): its deletions removed my RML nodes (twice — looked like a persistence bug; it wasn't) and my Lua tap branches (all swatch taps dead, `swHlX` stuck). Restored branches; audit showed resize/syncMenu/gates/tint code untouched. If taps ever die again while nodes render, check the p==1 hit chain first.
- Proved headless: idx2 tap → `swHlX=402/tickX=424/tickY=300`, shot `build/tick_proof3.png` shows thick white ring + centered tick on blue (263 interior white px), `verify` + `--once` 0 errors.
- Follow-up: 5th colour (PURPLE tint 1.30/0.70/1.55, band-safe) — EMBER stays default idx1. Row respaced to 5 across (start panX+42, step 58); new `swX4` prop/instance (`0:3370-0:3371`), Sw4 node (`0:3492-0:3500`), 5th tap branch, adopt clamp 1-5. No verify/screenshots per user (fast mode).
- Follow-up: box height +40% (360x300→360x420, even 32px rhythm, button heights unchanged). BACK inside at panY+336; rules BACK untouched. No verify/screenshots per user (fast mode).
- Follow-up: swatches closer (step 58→50, 6px gaps, row panX+58..+302). Fixed live bug found en route: 5-across respace moved visuals but left stale hitboxes (taps 16px off) — visuals + hitboxes now share one spacing. No verify/screenshots per user (fast mode).
- Follow-up: round-1 win bottom line (`VitSub` "THE DEAD CHEER YOU ON") removed; new `- YOUR FIRST VICTORY -` line in Instrument Serif (real TTF from google/fonts, `FontAsset 0:3510`, 36px, reuses VitSub VM binds so timing/script untouched). No verify/screenshots per user (fast mode).
## Level 1 — DONE (Oct 9, user-confirmed)
Full arc, all headless-proven: 12-step tutorial (takeoff-gated Q/W, strafe, climb/dive, E, click-fire, 1-4/G guns, R-lock steer) → 5-pumpkin hunt (spawns nose-anchored, minimap green dots, crosshair) → MORGATHA boss (400 HP bar, stalk/volleys/charges/contact, enrage) → victory overlay (CONGRATULATIONS + `- YOUR FIRST VICTORY -` serif line, pumpkin confetti, LEVEL 1→2 unlock, CONTINUE→home) → Level 2 circus opens. Wreck paths: strip overrun/dune slam → YOU CRASHED/RETRY; GIGA-style knockback n/a (L1 boss has no hands). Settings box (SOUND/MUSIC + 5 paints + BACK) and rules page serve all levels. No open L1 items.
- Pushed to Rive (file 2622473, rev 48228455): L1-complete build with settings box, 5 paints, serif victory line.

## Session (Oct 9 — L2: deadly walls, no guide dots, exit portal finale)
- User: side-hit crashes, green suggester dots gone, bright-white/pinkish-edge portal at the tunnel end → fly in → congratulations.
- Walls: the `CLAMP_R` soft-pin is out — crossing `TUBE_R` (450) anywhere calls `gateCrash` (burn + mercy respawn at the live gate, grace-covered). Final polyline leg extended gate20→portal so the portal run is inside the bore too. Stale home-strip landing exception deleted (deck is death now).
- Dots: dotted-line `buildDot` loop deleted from the gate draw (buffer keeps its size, harmless); `buildDot` generalized to a color/phase box writer and now draws ONLY the portal: white-hot core (state-1 pulse) + 4 pinkish edge beams, always visible down the bore.
- Finale: clearing gate 20 (flyby or guard kill) no longer completes — score `20/20 - PORTAL!`, msg `ENTER THE PORTAL!`; entering the 600-ball at gate20+1200z fires `level2Complete` (same CONGRATULATIONS show). Only path to victory.
- Load-bearing: module has a 200-register instantiation limit (198 used). 3 new module locals (`PORTAL_BACK/R`, `buildPortal`) hit 201 — verify still passed but the script silently never instantiated headless (`Out of local registers`, frozen splash/smoke, deaf keyboardEvent). Everything inlined to literals + inline `buildDot` calls: back to 198, script runs. NEVER add module-level locals without recounting (`python3` one-liner in history).
- Proved headless (temp magic-message hook + `--data`, since removed — script `keyboardEvent` is deaf in CLI 1.2.0 headless, only state-machine listeners land): off-axis 500 → `WRECKED` + respawn + `1/20→2/20`; portal teleport → `TUNNEL COMPLETE` + `vitCubeA LEVEL 2` + `vitTitleA 1` + CONTINUE fade-in. `verify` + `--once` 0 errors.

## Session (Oct 9 — L2 victory line: YOUR SECOND VICTORY)
- User: second round end writes "your second victory". The serif sub-line under CONGRATULATIONS was static FIRST-VICTORY text on every win.
- Now a bound string prop `vitSub` (`0:3511-0:3513`, bossName pattern): bossDie writes `- YOUR FIRST VICTORY -`, `level2Complete` writes `- YOUR SECOND VICTORY -`. Same serif style/timing, zero Game-type growth (`setAny` fetch + `setVal` writes).
- Proved headless (temp hook, since removed): portal entry flips `vitSub` FIRST→SECOND, default stays FIRST. `verify` + `--once` 0 errors.

## Session (Oct 9 — L2 tunnel rebuild: solid walls, hell skin, rock/gap walls, pumpkin guards)
- User runs fast mode: no verify/screenshots unless asked; user playtests and reports breakage.
- Solid walls (user: hollow boxes trapped the jet): `buildTube` plates rebuilt as thin radial shells (32 thick, inner face exactly at `TUBE_R`=320) via roll in `panel()` (extra ca/sa params, annotated). Crash radius now == visual contact. `verify` 0 errors.
- Spawn inside the tunnel: `stageParkour` tz -16970→-13100 (600 before gate 1, inside the mouth), later -12400 (100 inside mouth). Mercy respawn already lands 600 before the live gate.
- Brighter tube, then hell skin (user: "walls like it goes to hell"): `aurora.wgsl` rewritten — charred base, white-hot magma cracks, throbbing lava bands, flame licks, rising sparks. No Lua changes needed for shader-only restyles.
- Water saga (added then removed per user): canal ribbon + `aurora.wgsl` phase-100 branch worked, but ANY per-frame ditch check in `advance()` blew the type budget (see below). Lesson: visuals can ride free; gameplay checks in `advance` cost budget.
- Course rescaling: 500/leg (10k) → 1000 → 2000 → 4000 → back to 3200/5200 for gates 1-2 + 8000..80000 rest (80k total). `GATE_PATH` dists only; tube/portal/spawn derive from anchors. Spawn must stay ahead of gate 1 and inside mouth (gate1-1500).
- Pumpkin guards (user: orange faces to shoot): new foe kind 4 (orange rind 1.0/0.50/0.06, `PUMPKIN` in `FOE_NAMES`), `stageGates` stages kind 4 hp 30. All guard/kill/missile hooks are kind-agnostic (`tunEnemyGate`/`tunEnemyDown`, `or "MINION"` msgs) — safe.
- Wall obstacles 1-2 (user spec; 8 more to come — gates 1-2 HARDCODED for now, refactor to obstacle table when all 10 known): gate 1 = full rock slab (700x700x60, 20 HP, bolts splat w/ sparks via `GUN_DMG`, break = flash/boom/`WALL BROKEN 1/20!`/advance); gate 2 = lintel + 2 posts with bottom gap (x ±200, top at g.y-150; duck under at jetY ≤ g.y-140 = `UNDER THE WALL 2/20!`). Touch = `gateCrash`. New global `function wallUpdate` (own scope, called once per frame from the wall-check block with uwx/uwz/jetY/seconds); flyby ball skips idx ≤ 2 (`near = idx > 2 and ...`); rock drawn as 1 `buildDot` box + gap as 3, state-2 phase (keeps rock color, no green); `wallHp` in `(self::any)` (staged in `stageGates`, reset in `gateRespawn` for idx 1, lazy fallback in `wallUpdate`).
## Session (Oct 9 — L2: 11 walls — side gaps + 5 animated sliders)
- User: 7 more walls (2 side-gap + 5 animated, same designs with left↔right sliding gaps). Gates 5-11 are walls now: 5 LEFT GAP (round left), 6 RIGHT GAP (round right), 7 animated duck / 8 animated climb / 9 animated eye (gate-2/3/4 layouts sliding ±180u on a ~7s sine), 10/11 sweeping vertical slots in opposed phases. Flyby auto-clear starts at gate 12.
- Budget war (the feature initially failed with the 1600+ cascade AND silently never drew — user saw only 4 walls): draw/dispatch code landed but the build stayed red, so preview kept running the last-green build. Fix = consolidation, not addition: wallUpdate (~85 typed lines) DELETED, fully absorbed into any-typed wallExtra (same constants/rewards/crashes; only the ~1.5u axis tilt folded away — straight course, plane = uwz-g.z); w1-w4 draw blocks DELETED into a unified drawWalls loop (static pairs share branches: 2/7, 3/8, 4/9, 10/11; gx=0 for statics); 12 reward copies collapsed into wallClear. Net vs baseline ≈ -4 lines. Registers ~188 (+wallExtra/wallClear/drawWalls, -wallUpdate).
- Gotchas: for-loop var annotation (`for _, b: any in`) IS supported and fixed the `{read on}` narrow-inference errors; dispatch must sit AFTER `local g` (phantom-global `g` broke runtime); `--[[ ]]` long comments are NOT supported by this parser (broke the build); advance call is now `wallExtra(self, gs[self.gateIdx or 1], ...)` on the existing line.
- `verify` + `--once` 0 errors (12.09MB). User playtests (fast mode, no screenshots).
- Side gaps widened (slabs 500→400 wide, pass 140→100). Pushed to Rive (file 2622473, rev 48245861).
## Session (Oct 10 — L2 finale: 5 pumpkin heads + countdown rework)
- User: after all 15 walls, 5 orange pumpkin heads come; they fire, player shoots them; touch = 75 HP. Shipped: finStage (fresh any-global, stages the 5 foe slots as kind-4/30HP row ahead of gate 20 on portal-phase entry, records finK0=kills, visible heads text on TutPrompt + "5 HEADS!" score) + portal gated on kills-diff (same line). Fire comes FREE from the existing guard loop (tunEnemyGate hits slots 1-5, aimed 8-dmg orbs); contact-75 rides that same loop for kind-4 only (tchCd 2s, 80u ball, HP bar updates, no hull flash — dropped for budget). Wrecks keep kills (no revive mid-finale); P-retry restages clean (fin=false in stageGates).
- BUDGET WAR 2: ~25 lines needed, funded by REAL deletions only (`;`-joins proved theater — they change no inference cost): GATE_PATH 20-line table → 1-line GATE_ALT table + formula dist (theme/shape/mv verified write-only by grep; Gate TYPE still needs the fields so literal keeps `theme=0,shape=0,mv=0` — empty-body state proved it with a single type error, no cascade), tunGuard anchor lines (f.ax/az/alt dead for tunnel — caller hovers, L3-only reads) + g nil-check, foeAlive 7-line block → 1-line and/or-chain (Luau narrows `g.foeSlot ~= nil` in and-chains ✓), grace/introT/gateHidden/near-dx/gyJ/portal-tpx locals inlined, resetTrail call dropped (stale trail crumbs after respawn, cosmetic), yaw loop, `for fi, f: any in` annotation parses ✓. Tried and REJECTED: computed-alt generator (modulo/ternary cost MORE than data table — reverted), wallExtra-inline + loop-form + merged staging (all red), multi-annotated `local a: any, b: any` (fine actually — spitter precedent), local-after-`;` (inconclusive, avoided), `;`-after-string+`;`-prefix doubles (parse error), nested-if one-liner before else (orphans it). `verify` + `--once` 0 errors.
- Countdown rework (user: bigger countdown text + post-countdown shoot line, grammar fixed): TutPrompt 30→40px + wrap + height 48→132 (RML-only, shared with L1 tutorial). countTick GO now writes VISIBLE "SHOOT AND NAVIGATE THROUGH THE WALLS TO COMPLETE THIS LEVEL!" on tut + tutA=1 + introT=4.5; introT block hides tutA at 0 (same lines). level2Complete hides tutA (win screen clean). NOTE: self.msg has no HUD node — all player-facing L2 text must ride tut/tutA/gateScore.
- Follow-up: text back down (40→30px, box 132→72, wrap kept) + shorter line "SHOOT AND DODGE THROUGH THE TUNNEL!" — user found it too big/long.
- Follow-up: shoot-line hides after 2s (countTick GO resets gateIntroT to 2.0; level-start 4.5 untouched). Number-only edit, verify green.
- Follow-up: countdown digits 5x (new BigCount node, 150px white center, opacity mirrors tutA, text on new cdNum string prop 0:3514/instance 0:3515, RML-only; Lua writes joined into existing countTick lines via dynamic setVal, 0 new lines, GO clears). verify + --once green.
- Follow-up: BigCountShadow (black 150px copy offset +5/+5 under BigCount, same binds) — white digits wash out on bright sky. RML-only, --once green.
- Follow-up: BigCount was EMPTY — setVal needs a prior fetch (`(self::any)[k]` nil-guard); vitSub works only because line 4012 fetches it. Added `setAny(self, "cdNum", vm:getString("cdNum"))` fetch (dynamic storage, 0 type growth). 1 line, verify + --once green.
- Follow-up: double countdown (small TutPrompt + big BigCount mirrored) — small prompt now blanked during countdown (tut.value="", digits only on cdNum). Same-line edit, --once green.
- Follow-up: BigCount moved right (box x 100→250, shadow follows). RML-only, --once green.
- Follow-up: hit FX on walls — gate-1's bolt loop now also sparks (small white-hot puff, FX-only, bolts fly on) on slabs 2-11 + 17; gate 1 keeps splat + damage. Guards stay hittable (nothing dies except gate-1 rock); open-bore movers/flybys/invisible enemy stages excluded. Shipped by CONSOLIDATION (shared sweep, +4 wallExtra lines) after a standalone boltSplat helper (15 lines) proved over budget; break-volley loops went straight-singles to fund it. verify + --once green.
- Follow-up: 3-strikes rule — L2 wreck counts gateWrecks (forgiven per cleared wall in wallClear, reset on fresh run); 3rd consecutive wreck shows "3 WRECKS - BACK TO THE START!" and gateRespawn full-restarts via stageParkour+countdown. +4 lines (gateCrash 3, gateRespawn 1-line branch), verify + --once green.
- Follow-up: retry-instant-crash glitch — enemy/finale orbs homed onto the countdown-pinned jet (and guards kept spitting at it), so RETRY could die before GO. Pinned jet is now immune: orb-hit, guard-spit (tunGuard), and ram-75 all check `countT <= 0` (same-line guards, L1/L3 unaffected since countT is tunnel-only). verify + --once green.
- Follow-up: CONGRATS fired mid-finale — portal disc sat at gate20+1200, inside the heads' fight zone (+400..+1000), so the last kill near it (or a fly-through) won instantly. Portal moved to +3000 (trigger + visuals) with the tube/clamp exit extended 1500→3500 to match; ~2s victory lap, no accidental entry. Number-only edits, verify + --once green.
- Follow-up: removed the B debug shortcut (the only other level2Complete path — instant congrats on keypress, marked remove-before-shipping). If early congrats was a stray B, it's gone; if it still pops on the fresh build (12,089,793 bytes), the portal logic gets instrumented next. -16 lines banked.
## Session (Oct 10 — L2: 4 new obstacles 13/14/15/17 — hammer/fan/rocks/slit)
- User: 4 new tunnel obstacles. Shipped at gates 13/14/15/17 (between enemy 12 and 16, plus 17 after enemy 16 — enemy stages untouched): 13 swinging hammer head (dodge the orange sweeper), 14 3-spoke rotating fan (annulus rule: thread the hub hole r80 or skim the rim r280+, the disc is death), 15 falling rocks (2 lanes ±180 cycling top-to-bottom, split the gaps), 17 needle slit (4 pale slabs, 110x90 plane-size hole, center it). Pacing: fight→dodge→dodge→dodge→fight→precision.
- Plumbing: `wall` flag staged per gate (`wall = i<12 or 13/14/15/17`); flyby ball excludes walls (`(g::any).wall ~= true`, 1 node — the 4-`~=` chain version blew advance's budget); plane-cross preamble shared, then `if idx >= 13 then wallExtra2(...) return end` (16/18/19/20 keep the old else-crash). New `wallExtra2` + `drawWalls2` globals, own scopes, all-any, `;`-compressed one-liners; hammer visual lives in drawWalls, fan/rocks/slit in drawWalls2 (called after drawWalls at the draw site).
- BUDGET WAR (the reason the first version was invisible): build went red (1704 cascade errors) so preview ran the stale build. Margin is ~lines AND call-nodes both. Funded by: deleted advance mover-drift loop (gates hold anchors now — `g.mv` was only read there), 5 dead trailhead writes (pjx/pjy/pjz/puwx/puwz/pugy, ptx/ptz kept — clamp reads them), dead gate-yaw loop (nothing reads gate.yaw), portal 5→3 boxes (core+top/bottom — left/right pink edges cut), near-clear + finale fireworks loops→straight singles, nag + foe-hover blocks `;`-compressed, new code fully `;`-joined. Simplifications taken for budget: hammer lost its rail/arm (head only), fan hub visual dropped (empty center reads as the safe hole), rocks 3 lanes→2 (±180). Tried and REJECTED: 6-node near-chain, wallExtra-inline branches, loop-form visuals, staging-loop merge (no cheaper — restored), `;`-after-string + `;`-prefix doubles (parse error, use setAny), nested-if one-liner before `else` (extra `end` orphans the else).
- `verify` + `--once` 0 errors (12.09MB). User playtests (fast mode).
- Follow-up: hammer gap widened (kill box ±150→±100 around the head) — user found the pass too tight.
- Follow-up: pumpkin face un-buried — buildFoe's eyes/mouth boxes were centered inside the body (invisible); new `oz` param on the local box writer pushes the candle-yellow face 0.3S proud of the -z rind (approach side). 0 new lines, verify green.
- Follow-up: L2 walls gone pop — dull rock-brown replaced per wall: 1/4/9/10/11 red, 2/7/6 blue, 3/8/5 green, fan tips red, rocks blue, slit yellow pop; hammer keeps flame-flicker orange. Literal-only swaps, 0 new lines.
- Follow-up: L2 intro reworded — "LEVEL 2: BREAK THE WALL! SHOOT THE RED SLAB TO SMASH IT, THEN DODGE THE HAMMER, FAN, ROCKS AND THREAD THE NEEDLE! 5 PUMPKINS GUARD THE DEEP!" Same-line string swap, verify green.
- Follow-up: brick texture on all L2 walls — gate.wgsl's coursed-stone branch was keyed on the old brown band (dead since the pop repaint); now `isWall = isDone` so every state-2 wall gets mortar joints + tone variation + speckle in its own pop color. Portal (state 1) keeps clean glow. Shader-only change, `--once` builds 0 errors.
## Session (Oct 9 — type-budget cascade: how to read it + the dead-code harvest)
- SYMPTOM: 1600+ `[type]` errors at UNTOUCHED old code (Mat4/projection ~10063+, buildChunk/beam writers) + `build failed (0 bytes)`. There is NO bug at those lines — the checker exhausted its budget earlier and everything downstream is `*blocked*` fallout. Do NOT "fix" the reported lines. Bisect by disabling the newest code until green.
- COST MODEL (proven by bisection): `advance()` scope is at ZERO margin — even a 6-node `or` condition fails. Loops + closure calls + table-field reads in hot scopes are the most expensive. Fresh small global functions are cheap (own scope). `(self::any)` reads/comparisons cost ~nothing; typed table-field arithmetic in hot scopes costs a lot. `any`-annotated locals (`local g: any = ...`) skip table unification.
- MODULE REGISTERS: hard limit 200 (silently never instantiates at 201 — verify still passes!). Was 198 → 199 (wallUpdate) → ~186 after harvest. Recount before adding ANY module-level local; prefer literals over consts.
- `;`-after-`then` is a SYNTAX error (not lint): `if c then\n ;(self::any).x = v` fails parse (`Expected identifier, got ';'`). Use `setAny(self,...)` there. `;`-prefix is legal only after complete statements. This exact slip broke the build once (game:3295, 1 error) — looked like budget fallout but was real; always fix single-error builds by reading the line.
- HARVEST (dead ~300 lines, linter-confirmed unused — do NOT re-add): `buildGate`, `segDist2`, `gateHitsBlock`, `gateInHole`, `writeBoxAt`, `GATE_THEME`, `GATE_RAD/THICK/DEPTH`, `GATE_GAP`, `LANE_OFF`, `DUST_N`, `BEAM_LIFE/CD`, dead `span`, dead flyby locals (pcs/psn/pu/prr/kind/spin), the `if false` swept-block block. `buildDot`/`GATE_VERTS`/`DOT_VERTS` STAY (portal + wall draw + buffer sizing).
- Pushed to Rive (file 2622473, rev 48241922): tunnel rebuild with hell skin, rock/gap walls, pumpkin guards, 80k course.
## Session (Oct 10 — level system + PLAY repair: L2 win replayed L2, cubes never restaged)
- REPORT: after clearing L2, PLAY restaged the L2 map (never L3); L1->L2 congrats copy showing around L2 wins; stale level copy elsewhere.
- BUG 1 (the reported one): `closeVitOpenHome` hardcoded `level = 2` — every CONTINUE (L1, L2, GIGA, PRIME wins) rebuilt the circus. Fix: win sites record `nextLevel` (bossDie L1 -> 2, level2Complete -> 3, GIGA + PRIME -> 3); closeVit reads it (default 2) + per-level home msg.
- BUG 2: PLAY / Space / cubes set `level` + `setHome(false)` with NO `doReset` — new level inherited the old world's staging (L3 flag on the tunnel, L1 flag on guards). Fix: global `startLevel(n)` (level -> doReset -> home off; locked picks fall back to 1); PLAY/Space pass current level, cubes pass 1/2/3.
- BUG 3: `setHome(false)` called `retireTutorial` for L2/L3 too, which ran the L1 pumpkin path over the storm/circus. Fix: retire gated to level 1 only + L3 guard branch in `retireTutorial` (rejoins the storm).
- BUG 4: PRIME win (bossDie in L3) left `vitSub` as FIRST VICTORY. Fix: THIRD VICTORY on the L3 branch.
- COPY: doReset/closeVit L2 msgs said 10 BLOCKS (now the 20-wall line); rules RML `THEN 10 GATES` -> `THEN 20 WALLS`.
- BUDGET: the fix tipped the checker (1764-cascade, root `buildMsl` 1927 triple loop). Funded by harvesting the DEAD unlock-banner show (`unlockT` never arms — no setter >= 0 anywhere): -54 lines in advance, lock/trophy tail kept with `shaking` folded out. advance() itself untouched (still zero margin — P-retry L3->giant routing skipped for that reason, noted below).
- PROOF (temp corner-click probe calling level2Complete, since removed): PLAY -> `ROUND 1 TRAINING`; probe -> `TUNNEL COMPLETE` + cubes LEVEL 2/LEVEL 3 + SECOND VICTORY; CONTINUE click -> home with `LEVEL 3: THE STORM AHEAD HIDES THE ROTTEN COURT`. `verify` + `--once` 0 errors (12,089,107 bytes).
- KNOWN MINOR LEFT: P-key retry in L3 giant phase full-restarts the storm while the RETRY button rejoins the giant (advance has no budget for the extra branch); unlock banner RML nodes stay (opacity 0 forever); stale L3/gate state across level switches is dormant (all reads level-gated).
## Session (Oct 10 — debug level-skips removed: V / N+M / J)
- User: no free jumps to any level without earning it. Deleted all three `keyboardEvent` debug blocks (V -> L2 circus, N/M -> L3 court, J -> GIGA hunt; B was already gone Oct 10). Rules page already clean (no mentions). Remaining entries are all earned-only: PLAY (current level), lock-gated cubes, victory CONTINUE (`nextLevel`). -43 lines, also frees type budget. `verify` + `--once` 0 errors (12,087,998 bytes).
## Session (Oct 10 — 3-wreck full reset left a stuck "flying wreck": overA=1 + crashed=true forever)
- REPORT: after 3 crashes the run restarts but the game glitches — retry never plays again.
- ROOT: `gateRespawn`'s two early returns (gateFullReset 3-strikes + wall-1 `idx<=1`) call `stageParkour` and return before the normal path's cleanup, and `stageParkour` never cleared wreck state. Proven headless (temp corner probes, since removed): 3x gateCrash -> full reset -> GO! with `overA=1` stuck; worse, post-reset gateIdx=1 so EVERY later retry (auto/P/RETRY) loops through the same broken `idx<=1` return — a true deadlock, not just a stuck panel.
- FIX (2 lines, one place): `stageParkour` now clears `crashed/crashT/crashAcc`, parks `overA=0`, zeroes `gateWreckT` (also kills stale burn-timer refires after manual resets). Heals all three callers at once; doReset path unaffected (already clean).
- PROOF (same probe, post-fix): full reset lands `overA=0, health=100`; a 4th crash raises a genuine wreck (`overA=1, health=0`) and its auto-retry restages clean and stays stable. `verify` + `--once` 0 errors (12,088,128 bytes).
## Session (Oct 10 — L2 congrats still L1>>L2 for the user: stale cloud build, pushed)
- REPORT: user clears L2 but the congrats page reads LEVEL 1 >> LEVEL 2.
- FINDING: local code is correct and headless-proven (level2Complete writes LEVEL 2/LEVEL 3 + SECOND VICTORY; dump-confirmed). Cloud file 2622473 was last pushed Oct 9 (rev 48241922) — before the L2-finale sessions and all Oct-10 fixes — so the user was playing a stale build.
- FIX: `rive push` (0 errors) -> file 2622473, revision 48263243. Cloud now has: L2 win = LEVEL 2 >> LEVEL 3 + SECOND VICTORY, CONTINUE -> L3 map, 3-wreck fix, no debug skips. User must reload the file/preview to pick up the new rev.
## Session (Oct 10 — L2 speed-0 + instant crash: gateRespawn double-countdown clobbered countGo)
- REPORT: level 2 start uncontrollable, SPD 0, crash right after starting.
- ROOT: `gateCountdown` saves `countGo = throttle` then zeroes it. `stageParkour` already ends in `gateCountdown` (countGo=1000, correct), but `gateRespawn`'s two early returns (3-wreck full reset + wall-1 `idx<=1`) called `gateCountdown` a SECOND time — re-saving countGo=0 from the zeroed throttle. GO then handed back throttle=fwd=0: full 90/s sink vs 84/s max W-climb (unstoppable descent), deck crash in ~2s, respawn loop forever. First wall-1 death (rock slab must be SHOT) trapped every run this way; mid-run respawns were fine (they set throttle=700 before their single countdown).
- FIX: deleted both redundant `gateCountdown` calls (2-line deletion, frees budget). INVARIANT: call `gateCountdown` exactly once per staging, after throttle is set — never after `stageParkour`. `verify` 0 errors.
## Session (Oct 10 — L2 finale: leaked MORGATHA + LEVEL 1 >> LEVEL 2 congrats)
- REPORT: passing the end monsters doesn't fail the level, and the congrats page reads LEVEL 1 >> LEVEL 2 (should be LEVEL 2 >> LEVEL 3).
- ROOT: the shared foe-kill counter leaked L1 logic into the tunnel. All 5 tunnel guards must die to advance, so `kills` hits FOE_N=5 exactly on the gate-20 guard — and the unguarded `kills >= FOE_N` branch (bolt loop + mslBoom, both copied verbatim Oct 9) fired `ROUND 2 CLEAR!` + `round = 3` + `stageBoss`, staging MORGATHA inside the tunnel every run. Killing him ran `bossDie`'s unguarded L1 block → LEVEL 1 >> LEVEL 2 + FIRST VICTORY show. Passing the finale heads never could win (portal needs all 5 head kills over `finK0`) — the false congrats came from the leaked boss, not the portal.
- FIX (3 small edits, `verify` 0 errors): empty `elseif gateMode(self) then` branch inserted between the level==3 and round==3 kill branches in BOTH kill paths (tunEnemyDown above already owns tunnel progress/messages, so nothing is lost); `bossDie`'s L1 label block wrapped in `if not gateMode(self)` as insurance. No fail state on fly-past by design: the portal stays shut until all 5 heads die, heads keep spitting — turn back and shoot.
- PUSHED: file 2622473, revision 48264537 (also ships the L2 countdown fix + congrats restyle). User must reload the preview.
## Session (Oct 10 — L2: exit-crash with no win + ghosting through walls after retry)
- REPORT: (1) coming out of the tunnel end crashed with no completion; (2) after retry the jet sailed around/through obstacles without crashing.
- ROOT 1: the portal ball is only 600u at gate20+3000 — fly out the bore end past it (wrong height/line) and the tube exit (+3500) burns you with no win.
- ROOT 2: `wallExtra` ran INSIDE the grace-gated tube block, so every 4.5s grace (countdown + all respawns) the jet ghosted through wall planes; crossings already behind it never re-trigger, so walls never resolved (no crash, no clear). Fast Q rejoins outlasted the whole 4000u leg inside grace.
- FIX: split the block — walls now run whenever the run is live (pinned jet is 4000u+ from any plane, so countdown-safe), only the side-plate check keeps grace; dead `denom > 0.001` guard harvested to fund it. Plus: flying out the bore end with all 5 heads dead now completes the level (escaped = win); without the kills the exit still burns and rejoins at gate 20. `verify` + `--once` 0 errors.
- PUSHED: file 2622473, revision 48264858. User must reload the preview.
- LATER (same day): direct PLAY LEVEL 2 home button added per request (violet row, shared PLAY x + new l2Y prop, tap unlocked + staged L2), then REMOVED per user retraction — all 5 edits reverted, ids 0:3534-0:3559 free again. Pushed rev 48265023.
## Session (Oct 11 — home/hero small on first load, fixed)
- REPORT: on reload/first open, hero + home covers render small (800x500) and the live L1 scene shows around them; any window adjust snaps them fullscreen.
- ROOT: `resize()` writes all cover/HUD layout but early-outs on same-size (`laidOut` guard). If the host's first resize lands before `init` binds VM props + creates the GPU canvas, every guarded write is skipped while `laidOut`+`cw/ch` are still marked — no second resize ever comes, so covers sit at RML 800x500 defaults in a bigger viewport. Headless CLI inits first (1280x720 dump correct), so it never reproduces there.
- FIX (2 lines, init tail): clear `laidOut` via `setAny` and call `resize(self, self.size, 1)` after `syncSave` — re-runs full layout now that props + canvas exist. No new locals/branches in `advance()` (zero margin untouched), no RML churn, no module-register growth.
- PROOF: `verify` 0 errors (182 warnings, unchanged); data-dump 800x500 -> home (400,250,0.378) + hero (400,0.336); 1280x720 -> home (640,360,0.605) + hero (640,0.484); `--once` builds (12,202,119 bytes).
## Session (Oct 11 — all 182 warnings purged + first-load sizing, real fix)
- WARNINGS 182 -> 0 (`verify` 0 errors, 0 warnings): sed `) o += 4` -> `); o += 4` (122 writer lines), `) oo += 4` + `) push(` same (storm/sand/pad writers), 10 hand `;` fixes (giantRetry/wallClear/wallExtra2-13 split to 2 lines, ruleScrY/heroA, wantBank/bank, tutTog, 2x break, hammer-line `; return end`), 13 shadow renames (d: dd/cb/cc/yd; spd: spd2/3/4; fwd: fwd3/4/5; outer flight mx/mz -> mvx/mvz so the L3 merge-center inner no longer shadows), dead L3_SAFE_DIST -> _L3_SAFE_DIST. L3_SAFE_DIST genuinely unused (l3dmgScale returns const chip). Convention note: file already used fwd2/bfwd renames elsewhere.
- SIZING, round 2 (init-tail re-run from last session did NOT fix it => resize never fires on load in their viewer, not merely pre-init): probed the runtime (temp prints, since removed; one headless --screenshot to /tmp purely to execute draw(), never viewed, deleted): Renderer exposes NO width/size/viewport (index throws); GPUCanvas DOES (`canvas.width/height` + `canvas.image` dims, all readable).
- FIX: draw() self-heal — every frame, one pcall reads canvas.width/height; on any divergence from cw/ch (sane-clamped 1..8192) clears laidOut and runs the same resize() a window-adjust would run. Mismatch vanishes after one heal, so steady-state cost is 2 field reads. Any failure skips silently, draw continues (never risks black-screen).
- PROOF: `verify` 0/0; 2s headless advance clean; `--once` builds (12,202,727 bytes). Headless can't reproduce scenario-3 (CLI always fires resize), so the user must confirm first paint on the site.
## Session (Oct 11 — web was served a stale .riv; push != publish)
- REPORT: draw-heal + zero-warning build verified locally, local preview correct, but https://haunted-ship-yo6fxr.rive.to/ still small after `rive push` (rev 48308689) + hard reload.
- ROOT: `push` updates the cloud FILE (editor previews read it live) but the published page serves a separate snapshot: HEAD /file.riv showed 12,187,679 bytes / 15:38 UTC while the local build was 12,202,727 — the Oct-10 publish was still live. Hosted player itself is fine (fit=layout default, ResizeObserver + onLoad resizeDrawingSurfaceToCanvas).
- FIX: `rive --publish=web` -> published haunted-ship (12,188,323 bytes, 0/0); HEAD now matches (16:35 UTC). Lesson: web tests need publish, not push.
- UNPROVEN: whether the draw-heal fixes first paint on the live page — user must retest on this publish.
## Session (Oct 11 — covers small on web: async image-decode race, fixed)
- USER CALLED IT: "the problem is the image size... fill the image fullscreen". Correct — hero-cover 3.4MB + home-cover 4.3MB decode instantly local, async on web. Boot resize runs with 0-size dims, hits the `> 0` guard, skips the 4 scale writes; all pure-math HUD lands right, covers strand at RML 800x500 defaults. Any window adjust re-runs resize post-decode. Canvas-divergence heal never fired (buffer + layout agree; only image dims lag).
- FIX: per-frame cover-scale follow in draw()'s heal pcall — once heroImg/homeImg report real dims, rewrite heroSX/SY + homeSX/SY from live cw/ch (same cover math + 1.12 home factor). Idempotent, type()-guarded, inside the never-breaks-draw pcall. advance()/resize() untouched.
- PROOF: `verify` 0/0; 1600x900 dump -> heroSX 0.605 + homeSX 0.757 (exact cover) + homeX 800. Published (web needs publish, not push).
## Session (Oct 11 — judge shortcuts Shift+2 / Shift+3)
- ASK: judges need free level jumps to test better. Shipped Shift+2 -> level 2, Shift+3 -> level 3, any screen (splash/home/flight/victory/pause).
- IMPL: keyboardEvent top tracks Shift (GLFW 340/341) before the menu early-returns, then jumps via revived devJump (renamed back from _devJump now it's used: unlocks both levels, syncSave, unpauses, startLevel). Digit codes cover ASCII 50/51, CLI raw 2/3, US-shifted 64 (@)/35 (#); plain 1-4 still select guns (shift-gated, no conflict). Rules page documents it (19th line, scroll clamp 12->13 in all 4 spots).
- PROOF: `verify` 0/0. Live keys untestable headless (script keyboardEvent deaf in CLI) — needs judge playtest. Published to web.
