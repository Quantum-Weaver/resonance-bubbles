# 🫧 Resonance Bubbles

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-0.1.0-brightgreen.svg)]()

*A collecting game built without compulsion — 55 stars, seven bubble-wrap pops,
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
"enough for now" is offered as a first-class choice.

**Nothing leaves the page.** Collections, boundary and sound preference live in
`localStorage` and nowhere else. No account, no network, no telemetry.

---

## THE STORY

*This section required by the [Story Block Standard](https://github.com/Quantum-Weaver/resonance-standards).*

The game began inside the AudHDities platform as the athena BubblePopGame, and
was detiered on 2026-07-31 — freed from the tier system so it could belong to
everyone. It was named as a future on 2026-08-01: *"i kind of want a stand alone
playable game version of the bubble game … not right now, but future"* — and
opened the same night. It became the first resident of resonance-awen's
`games/` room, and the spring's first thing made purely to play, thirteen tools
deep.

The seven pops are the chimes' bubble-wrap family, synthesized from pure math
and tuned by ear to a single specification: *"like bubble wrap to a
neurodivergent."* No two pops in a row are ever the same.

This repo is that game's graduation — the point at which a thing that calls
itself *the standalone playable* gets its own address, so it can be given away
on its own terms.

---

## WHO IT'S FOR

Neurodivergent players first — the design decisions here were made for brains
that a normal collecting game treats as a resource to be extracted from. It
plays perfectly well for anyone else.

And for anyone who has ever wanted the pop without the hook.

---

## BUILT WITH

- **One HTML file.** `build.py` reads `game-template.html`, embeds the star set
  and all seven pops as base64 data URIs, and seals `index.html`. Open it in
  any browser on any machine. No build step to play, no server, no account.
- **Cosmic** — the Sanctuary's design system: deep space, star dust,
  neurospark, quantum purple, hearth gold. Reduced motion respected.
- Desktop and mobile packaging to follow. See [docs/CHECKLIST.md](docs/CHECKLIST.md).

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
