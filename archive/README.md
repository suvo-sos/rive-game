# archive/ — unused files, kept out of the build

Rive only embeds assets declared in `scene.rml`. Nothing here is referenced,
so nothing here ships in the `.riv`. Delete freely.

- `arena.wgsl` — Dead Earth fighter-era fullscreen shader, superseded by
  `shaders/desert.wgsl` + `shaders/jet.wgsl`.
- `fog.wgsl` — Haunted Ship-era fullscreen shader, idea rejected.
- `Montserrat.ttf`, `SpaceMono-Regular.ttf`, `Goldman-Regular.ttf` — declared
  as FontAssets but never used by any TextStylePaint (only SpaceMono-Bold +
  Creepster are). Declarations removed from `scene.rml` Oct 5.
- `17911813608c43.png`, `17911824763237.png` — old unreferenced cover drafts.
- `homebg.png` — older home background, replaced by
  `assets/images/home-cover.png`.
- `fire0-3.png` — orphaned Oct 9: never declared in `scene.rml`, unreferenced
  by `game.luau`. Moved out of `assets/images/` to keep the dir 1:1 with
  declared `ImageAsset`s.
