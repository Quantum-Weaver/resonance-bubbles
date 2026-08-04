# CLAUDE.md — resonance-bubbles

**Stack:** SvelteKit (static adapter, SPA) over **Tauri v2**, built on the
Resonance Echoes base whose features are kept, not stripped. Desktop and mobile
from one codebase. The star set is data (`src/lib/data/bubbles-set.json`), never
code.

**Authors:** see [HANDS.md](HANDS.md) — the voices are named there, each in
their own words, per the Hands Standard.

---

## SESSION PROTOCOL

1. Read `docs/CHECKLIST.md` for current state.
2. One phase at a time — complete, verify, update the checklist, move on.
3. **The checklist updates in the same sitting as the work it records.**
4. Zero errors before commit.

## Essential rules — the anti-compulsion identity

These are this game's **identity, not its settings.** They came whole from the
origin game and they are not tunable by anyone building here. If a change would
make the game stickier, it is the wrong change.

- **The limit slider is the point, not a feature.** Daily cap 500 by default,
  50–2000, adjustable **by the player alone**, saved in their own browser.
  *"The boundary is yours."*
- **It stops kindly.** "Take a breath" after 50 pops; cooldown after 15 minutes
  of continuous play. The overlay never shames, never counts down, and offers
  "enough for now" — which leads to Sattva, not back to the sky.
- **Every rarity drifts for everyone.** Common → mythic at 60/25/10/4/1. Rare
  is rare, never locked.
- **The reward is the words.** A popped star shows its name and its sentence.
  No streaks, no combos, no timers shown, **no red anywhere.**
- **Local-first absolutely.** Collection, boundary and sound preference live in
  `localStorage` under `the-bubbles`. No account, no network, no telemetry.
- **The voice.** Seven bubble-wrap pops in `static/sounds/`. No two pops in a
  row are ever the same. Sound is a toggle and silence plays just as well.
- **Reduced motion is respected**, always.
- **Inclusive Pride's flags all share one rarity.** Rarity is how often a thing
  drifts past; ranking identities by it would make some people rarer than
  others. This is not a style choice and does not get "balanced."

## The rooms

| Route | What it is |
|---|---|
| `/` | Echoes' home — the journal, inherited whole |
| `/bubbles` | The game — sky, collections, boundary, breath door |
| `/sattva` | The regulation door — the breathing pacer |
| `/insights` `/timer` `/settings` `/add` `/onboarding` | Echoes' suite, kept intact |

**The `echo` domain is not the brand.** `echo.svelte.ts`, the `echoes` table and
the word "echo" throughout are the journal's own data model. They stay. Only the
app's *identity* was rebranded — product name, bundle id, window title, crate.

## Build

```bash
npm run dev          # browser, http://localhost:1420
npm run tauri dev    # its own window
npm run tauri build  # desktop binaries
```

**Growing the sky is data.** Add entries to `src/lib/data/bubbles-set.json` —
new stars, new collections, seasonal sets. No code changes. Two things it does
not yet have, if seasons become real: a time window on a bubble, and a version
on the set for migrating a renamed slug.

**Icons:** `npx tauri icon src-tauri/icons/icon.png` — note that it **overwrites
its own input**; keep the master elsewhere.

## The gates that are KP's alone

- **Whether this repo goes public.** The 30 original stars are carried verbatim
  from the AudHDities base, so publishing here publishes AudHDities content.
- **Store distribution**, and the accounts it costs.
- **Whether the standalone one-file build (`build.py`, `game-template.html`)
  stays alive** as the free web-playable version, or retires now that the app
  is the target.

## Standards

This repo follows the
[Sanctuary Standards](https://github.com/Quantum-Weaver/resonance-standards).
`.gitignore`, this file, and `docs/CHECKLIST.md` are **SEED-class** — planted
once from the standards and this repo's own from then on. No agent overwrites
them.
