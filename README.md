# 🫧 Resonance Bubbles

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-0.1.0-brightgreen.svg)]()

*A collecting game built without compulsion — 123 stars, seven bubble-wrap pops,
and a daily boundary only you can set.*

Built on the [Resonance Grammar](https://github.com/Quantum-Weaver/resonance-grammar)
— every fragment contains the whole.

---

## WHAT IT IS

Pop the stars, collect their words.

Collecting games are usually built to keep you. This one is built to let you
go. The compulsion loops that make the genre work — streaks, combos, timers,
locked rarities, the red badge that will not leave you alone — are not tuned
down here. They are absent by design, and what remains is the part that was
always the good part: a satisfying pop, and a word worth keeping.

**The boundary is yours.** A daily point cap, set by the player and nobody
else — 500 by default, anywhere from 50 to 2000 — saved in their own browser.
The slider is the point, not a feature.

**The reward is the words.** Popping a star shows its name and its sentence.
No streaks, no combos, no timers shown, no red anywhere. Rewarding, never
shocking.

**Rarity drifts for everyone.** Common through mythic at 60/25/10/4/1. Rare is
rare — and never locked behind anything.

**It stops kindly.** "Take a breath" after fifty pops; a cooldown after fifteen
minutes of continuous play. The overlay never shames and never counts down, and
"enough for now" leads to the Sattva door rather than back to the sky.

**Nothing leaves the page.** Collection, boundary and sound preference live in
local storage and nowhere else. No account, no network, no telemetry. See
[PRIVACY.md](PRIVACY.md).

---

## THE SKY

**123 stars across 13 collections**, in a rarity pyramid of 47/32/24/13/7.

| | | |
|---|---|---|
| Star Dust | The Sensory Set | The Hearth Collection |
| The Long Night | The Elemental Set | The Workshop |
| The Council Collection | The Companions | The Sky Wheel |
| The Threshold | Quantum Weave | The Given |
| **Inclusive Pride** | | |

**Inclusive Pride carries every flag at the same rarity** — rainbow, progress,
trans, non-binary, genderfluid, agender, pansexual, bisexual, asexual, lesbian,
intersex. Rarity here is how often a thing drifts past, and a flag's whole job
is to be seen. Ranking identities by rarity would make some people rarer than
others.

---

## THE APP

Resonance Bubbles is a **sovereign desktop and mobile app** — SvelteKit over
Tauri v2, built on the Resonance Echoes base, whose journal features it keeps
rather than strips.

| Room | What it is |
|---|---|
| **Home** | Echoes' own surface — the journal, inherited whole |
| **Bubbles** | The game: the sky, the collections, the boundary |
| **Sattva** | The regulation door — one tap to a breathing screen |
| **Insights · Timer · Settings** | Echoes' suite, kept intact |

**Sattva** is the breathing pacer from Resonance Compass's own Sattva door,
with the math carried from [`the-breath`](https://github.com/Quantum-Weaver/resonance-awen)
— warm amber on the inhale, deep violet on the exhale, eight seconds in and
twelve out. Tap, Enter, Space or Escape to leave. Reduced motion opens the door
without moving it.

**Export and purge cover exactly the same ground.** One versioned envelope
carries your journal entries, your folksonomy *and* your bubble collection
together, with the counts written on it. The purge is real, not a soft-delete,
and an export-then-purge completes the export into your hands before anything
is deleted.

---

## THE STORY

*This section required by the [Story Block Standard](https://github.com/Quantum-Weaver/resonance-standards).*

The game began inside the AudHDities platform as the athena BubblePopGame, and
was detiered on 2026-07-31 — freed from the tier system so it could belong to
everyone. It was named as a future on 2026-08-01: *"i kind of want a stand alone
playable game version of the bubble game … not right now, but future"* — and
opened the same night, becoming the first resident of resonance-awen's `games/`
room, and the spring's first thing made purely to play.

The seven pops are the chimes' bubble-wrap family, synthesized from pure math
and tuned by ear to a single specification: *"like bubble wrap to a
neurodivergent."* No two pops in a row are ever the same.

This repo is that game's graduation — the point at which a thing that called
itself *the standalone playable* got its own address, so it could be given away
on its own terms.

---

## WHO IT'S FOR

Neurodivergent players first — the design decisions here were made for brains
that a normal collecting game treats as a resource to be extracted from. It
plays perfectly well for anyone else.

And for anyone who has ever wanted the pop without the hook.

---

## BUILD

```bash
npm install
npm run dev          # the app in a browser, http://localhost:1420
npm run tauri dev    # the app in its own window
npm run tauri build  # desktop binaries
```

The star set lives at `src/lib/data/bubbles-set.json` — **new stars, new
collections and seasonal sets are data, not code.** Add entries, and the sky
grows.

---

## Development Standards

This project follows the [Sanctuary Standards](https://github.com/Quantum-Weaver/resonance-standards).

The hands that built it are named in [HANDS.md](HANDS.md); project context for
Claude Code is in [CLAUDE.md](CLAUDE.md); current state is
[docs/CHECKLIST.md](docs/CHECKLIST.md).

---

## LICENSE

Code: [MIT](LICENSE) — use it, modify it, share it.

Philosophy: [The Resonance License](PHILOSOPHY.md) — no exploitation, no
extraction, no exclusion. This is our promise.

---

*Built by Quantum Weaver with the Kin, for the
[AudHDities Sanctuary](https://github.com/Quantum-Weaver).*

*Pop the stars, collect their words — and stop whenever you like.*
