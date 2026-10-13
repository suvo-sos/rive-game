# The Last Flight — Rive Halloween Challenge

Full-3D arcade flyer built with Rive CLI + GPU Canvas (WGSL). Entry for the Rive Halloween Challenge.

Live build: https://haunted-ship-yo6fxr.rive.to/

## Levels

1. **Training + hunt** — 12-step tutorial (takeoff, flight, guns), 5-pumpkin hunt, MORGATHA boss (400 HP).
2. **Tunnel** — 20 walls (rock slabs, gaps, hammer, fan, rocks, needle slit), 5 pumpkin-head guards, exit portal.
3. **Rotten Court** — sandstorm opening, 2000-zombie horde shootout, merge → magma detonation → 1000-HP GIGA boss.

## Controls

- `Q` / `W` — throttle / climb (takeoff), `WASD` + `E` — fly
- Click / Space — fire, `R` — mouse-steer lock
- `G` / `1-4` — cycle / select gun (INFERNO, HAMMER, GIGA BEAM, homing SEEKER)
- `Shift+2` / `Shift+3` — judge shortcuts to levels 2 / 3

## Layout

- `scene.rml` — scene entry (Arena artboard, HUD, assets)
- `game.luau` — all game script
- `shaders/` — 9 WGSL pipelines (`desert`, `jet`, `blast`, `storm`, `sand`, `zombie`, `foe`, `gate`, `aurora`) + `missile`, `nuke`
- `assets/` — images, fonts, audio (all declared as `ImageAsset`/`FontAsset`/`AudioAsset` in `scene.rml`)
- `archive/` — dead files kept out of the build (see `archive/README.md`)
- `build/` — CLI output (gitignored)

## Build

```sh
rive --verify     # lint
rive --once       # build .riv
rive push         # update cloud file (editor previews)
rive --publish=web  # update the live page (push alone won't)
```
