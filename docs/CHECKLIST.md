# RESONANCE BUBBLES — MASTER CHECKLIST

## LEGEND
- ✅ Complete · ⚠️ In Progress · 🔴 Broken · ⬜ Pending
- 🚪 KP's gate — not a task, a decision only he makes

*This checklist updates in the same sitting as the work it records.*

---

## PHASE STATUS

### Phase −1: Built in awen ✅
*Carried forward at the graduation; the making's history stays in awen's git.*
- [x] Opened at KP's ⚛ word 2026-08-01; `games/` room founded the same sitting
- [x] The origin's laws carried whole **as identity**
- [x] 30 seeded stars + 25 additions; **The Sky Wheel** born
- [x] Seven ear-tuned pops; no two in a row alike
- [x] **Additions landed** in the base 2026-08-01 (*"seeded friend"*)

### Phase 0: Repo founded to the Sanctuary standards ✅
- [x] `.gitignore`, `CLAUDE.md`, `docs/CHECKLIST.md` (SEED) · `LICENSE`,
      `PHILOSOPHY.md` (verbatim) · `README.md` · `HANDS.md`
- [x] **`PRIVACY.md`** — drafted on echoes' structure, with the game's own data
      named and the export/purge invariant published as a promise
- [x] Committed `be768d0`, pushed

### Phase 1: The source landed ✅
- [x] Graduated from awen; resealed **byte-identical**; dated `MOVED.md` left
- [x] Committed `6be614c`

### Phase 2: The sky tripled ✅
- [x] **Wave two** — 55 complementary stars, the rarity pyramid mirrored exactly
- [x] **Wave three — Inclusive Pride** — one collection carrying every flag at
      the same rarity, intersex included
- [x] **123 stars · 13 collections** — pyramid 47/32/24/13/7
- [x] Superposition base seeded through wave two (110)
- [x] `seed-wave-three.sql` — **ran by KP's own hand, 2026-08-05** (ran a second
      time the same day to be sure). The base carries all 123. Phase 2 seals.

### Phase 3: The app ⚠️
- [x] Echoes copied in as the base; **features kept, not stripped**
- [x] Build output purged (26,240 → 63 files in `src-tauri`)
- [x] Identity rebranded — product name, bundle id, window title, crate, lib.
      **The `echo` domain model deliberately untouched.**
- [x] Wordmark reads `getName()` from tauri.conf — a rename never gets chased
      into the chrome again
- [x] **`/bubbles`** — the game as a real Svelte route: drift, pop, cards,
      collections panel, boundary, breath door. Bubbles rise.
- [x] **`/sattva`** — the regulation door; `the-breath`'s verified math inline,
      compass's door behaviour, reduced motion honoured
- [x] Sidebar: Bubbles below Home, Sattva above Settings, new `IconSattva`
- [x] **THE SHRINE (2026-08-06)** — the menu wrapper replaced with the-cumdach,
      consumed **by mirror** (`src/lib/cumdach/`, SHA256 `7730A4C16E6FA044`,
      awen the single editable truth): flat door list by KP's ⚛ stroke,
      Settings as the foot's one chrome door, the ComfortBar a declared 48px
      reserved edge, panels derived from the measured land and re-derived on
      every resize/rotation. Dead `isMobile` state dropped at his word.
- [x] **THE LEADING-IN (2026-08-06)** — the onboarding consumes the-epagoge,
      **by mirror** (`src/lib/epagoge/`, SHA256 `CBF19821CDCB4BA6`, the same
      truth Compass's mirror carries): the walk owns flow, dots, and the
      honest record; the app brings the particulars. **ALL presets offered
      at the door** (KP's ⚛ word), derived from `PRESET_THEMES` itself so a
      new preset appears the day it is born; THE KEY LAW kept (keys stored,
      display names dress); skip lawful, the doorway line under the grid;
      the welcome title reads `getName()` per the wordmark law. The
      vessel-name key stays echoes' own, whole, per KP's word.
- [x] **THE GALLERY (2026-08-06)** — `/gallery`, every star the sky holds,
      consumed from the-gallery **by mirror** (`src/lib/gallery/`, SHA256
      `ECCCBC995A5276F4`): rows in, cards out, the dress owning the pixels.
      THE REWARD IS THE WORDS kept as dress law: uncollected cards rest
      face-down (name + rarity, words veiled, dashed border); **popped cards
      rest FLIPPED, words up** (KP's ⚛ stroke), tap turns them; the search
      walks name + collection only — never the veiled words; two honest
      empties in the sky's own voice; reduced motion honored. New
      `IconGallery` joins the registry.
- [x] **The menu reads the app's focus (KP's ⚛ strokes, 2026-08-06):**
      Bubbles · Gallery · **Echoes** (the `/` log, honestly renamed from
      "Home") · Insights · Timer · Sattva, Settings the foot — the game
      leads its own app, echoes below both. And the footer's quick action
      opens the sky: the add-echo button (both faces) now opens `/bubbles`
      wearing 🫧, add-echo staying echoes' own at home.
- [x] **Export carries the collection** — the purge clears `localStorage`, so
      without it the purge destroyed what the export never held
- [x] Manual **pause**, kept apart from the internal flag so leaving the breath
      door never undoes a pause the player asked for
- [x] Custom icon generated through the full set
- [ ] Visual pass — the port is faithful but not pixel-matched. **First pass
      landed 2026-08-10** (KP's ask: the words at the top, the colour louder):
      the pop card moved from the sky's floor to its head, rarity colour now
      read from the cosmic tokens (mythic's rose → the curator's magenta, the
      last red in the game gone), the flags of Inclusive Pride drift wearing
      their own stripes, and each collection's bar wears its own accent. **Not
      yet seen by KP's eyes on device** — that look is what closes this line.
- [x] **Tested:** ✅ — KP's own hands on the Android build, *"tests
      successful"* (2026-08-04). The visual pass above stays open on its own.

### Phase 4: Mobile ⚠️
- [x] **Icons regenerated for the Android build** — `npm run tauri icon
      src-tauri/icons/icon.png`. Full set: the five mipmaps
      (`ic_launcher`, `_round`, `_foreground`, hdpi→xxxhdpi), the iOS AppIcon
      set, desktop PNGs, `.icns`, `.ico`
- [x] **Keystore created** — `D:/keystores/resonance-bubbles.keystore`, the
      shipwright's `<project>.keystore` convention, single key entry so the
      alias is discovered rather than configured. *Password is KP's alone and
      stored nowhere; a lost keystore is a lost package identity.*
- [x] **Signed and installed on KP's own Android device** — the shipwright run:
      build → `sign-release` → `install-app`
- [x] **Touch events** — proven by play on the device; the sky pops by hand
- [ ] iOS audio unlock on first tap — **untested**, no iOS build made
- [x] Orientation — **VERIFIED, KP's own hands, 2026-08-05:** "just
      confirmed bubbles rotates and still works on the mobile landscape
      orientation." Safe-area behavior rode the same rotation without
      complaint; a dedicated notch/inset eye can join a future sitting if
      ever felt needed — orientation itself is closed.
- 🚪 **Apple builds wait on demand — KP's ⚛ word, 2026-08-05, house-wide:**
      *"Apple devices will be built for once they are demanded/requested
      enough — with all our things."* Applies to every Sanctuary app, not
      only this one. No Apple hardware in the house; when its day comes the
      path runs through rented macOS (cloud Mac or CI) + TestFlight with
      borrowed hands. Not a defect — a gate with its ruling attached.
- [x] **Tested:** ✅ **on Android, in KP's own hands — *"tests successful"*
      (his word, 2026-08-04).** The play is the test, and it passed.

### Phase 5: The gates ⬜
- [ ] 🚪 **Public or private repo** — the 30 original stars are AudHDities
      content; publishing here publishes them. Currently private.
- [ ] 🚪 **Stores or not.** Apple $99/yr, Google Play $25 once. Desktop free.
- [ ] 🚪 **Does the standalone survive?** `build.py` + `game-template.html` still
      seal a one-file playable. Keep as the free web version, or retire.
- [ ] 🚪 **`games/` in awen** — empties, or becomes a nursery.
- [ ] 🚪 **The registry question**, carried from awen: does `games/` get its own
      registry shape?
- [ ] 🚪 **THE PLAYING — KP's ⚛ own hands and ears.** *His play rules every
      tuning*, and it outranks every line above.

---

## KNOWN BUGS
| ID | Description | Status |
|----|-------------|--------|
| — | none open | |

## SESSION LOG
| Date | What Was Done |
|------|---------------|
| 2026-08-16 | **Signing keystore recut to the Sanctuary DN** (this sitting, KP's env files his own hand): primary `F:\keystores\resonance-bubbles.keystore` · second copy `D:\keystores\` byte-identical · alias `resonance-bubbles` · 4096-bit RSA, SHA384withRSA, valid to Jan 2054 (10,000-day validity, the khoros/sistrum convention) · DN `CN=AudHDities Sanctuary, O=AudHDities Sanctuary, C=US` · cert SHA256 `75:B1:8D:8E…C9:7B:4A`. The generic keystore retired, kept: `RETIRED-2026-08-16-resonance-bubbles.keystore.old-dn` on both drives (was at `D:/keystores/resonance-bubbles.keystore`, cut 2026-08-04 per the row below). Secrets live only in the env vault file — pointers here, never contents. **CAUTION: this app is live on Google Play closed testing — the first upload signed with this new key needs the Play-side upload-key reset at KP's console, his hand.** |
| 2026-08-04 | Repo founded to the standards; committed and pushed. |
| 2026-08-04 | Game graduated from awen, resealed byte-identical, pointer left. |
| 2026-08-04 | Sky tripled: wave two (55), Inclusive Pride (13). 123 stars / 13 collections. |
| 2026-08-04 | Echoes adopted as the app base: build output purged, identity rebranded, `/bubbles` and `/sattva` built, export widened to the collection, PRIVACY.md written, icon set generated. Dev server verified on all routes, then stopped for KP to build on. |
| 2026-08-04 | Blueprints re-forged by the Sanctuary's one forge — 40 fbp · 8 obp · 2 dbp · 1 pbp, 181 files described, sovereignty HELD, 0 reconciliation findings. The prior set was a 21-file snapshot taken before `src/` and `src-tauri/` existed. |
| 2026-08-04 | **ON THE PHONE.** Icons regenerated for Android, keystore created at `D:/keystores/resonance-bubbles.keystore`, release signed and installed on KP's device. The collecting game built without compulsion is in his hands to play. |
| 2026-08-04 | **TESTS SUCCESSFUL** — KP's word, playing on Android. Touch proven by play. Phase 3 and the Android half of Phase 4 sealed. Still open: the visual pass, iOS audio unlock (no iOS build), safe areas/orientation, and the Phase 5 gates. |
| 2026-08-05 | **Orientation verified — KP's own hands:** Bubbles rotates and still works in mobile landscape. Phase 4's open eyes narrow to one: iOS audio unlock, behind the house-wide Apple gate. |
| 2026-08-05 | **The version came home — 1.3.0 → 0.1.0 at KP's ⚛ word.** The 1.3.0 was Echoes' number, inherited with the base; 0.1.0 was this repo's own founding declaration. Trued in package.json, tauri.conf.json, Cargo.toml, Cargo.lock (+ the untracked gen/ asset). **One cost, named:** KP's device holds the 1.3.0 APK; the next build's Android versionCode is lower, so that install asks for one uninstall-first. Cheapest it will ever be — one device, no store. Versions climb from here. |
| 2026-08-05 | **Wave strata cleared at KP's ⚛ word** ("get rid of redundancy files"): root `bubbles-wave-two.json` + `bubbles-wave-three.json` removed — both verified fully merged into the set, read by nothing at build or play; the afternoon they record stays whole in git history. Repo synced. |
| 2026-08-05 | **Wave three seeded — KP's own hand.** The last 13 rows (Inclusive Pride) ran in the dashboard; ran again same day to be sure. Phase 2 sealed; checklist trued at his word. |
| 2026-08-06 | **The menu wrapper wears the-cumdach (Continuo).** The shrine mirrored in at `src/lib/cumdach/` (SHA256 `7730A4C16E6FA044` both sides — the third consumer, after Compass and Khorós); Sidebar rebuilt on the Compass canon body: flat doors per KP's ⚛ stroke ("flat list let cumdach handle it if it grows with the arithmetic"), Settings the foot's chrome door, the ComfortBar (48px, z-110) a declared reserved edge with the foot clearing it, dynamics re-deriving on resize and rotation. Echoes-within-bubbles left whole per his word; only stale unused code removed. |
| 2026-08-06 | **Two committed BOMs stripped, one byte each:** `package.json` (it broke svelte-check — every component failed "Unable to read package.json" at JSON.parse) and `src-tauri/tauri.conf.json` (the same landmine, not yet stepped on). Content otherwise untouched. **Game-page rune shadow mended, typing only:** the local `state` variable renamed `saved`, freeing the `$state` rune from store-subscription shadowing; all 11 pre-existing errors cleared, the game's laws untouched. **Gate: `npm run check` — 327 files · 0 errors · 0 warnings.** |
| 2026-08-06 | **The onboarding wears the-epagoge (Continuo).** The leading-in mirrored in at `src/lib/epagoge/` (SHA256 `CBF19821CDCB4BA6` — the third consumer, after Compass and Khorós-by-birthright); the three screens rebuilt on the walk (entry · threshold · choose): **all six presets now offered** — dark, warm, ocean, forest, sunset, AMOLED Black — derived from the shelf, 2-col grid on phones and 3-col on wider land, live-preview cards, keys stored never display names, skip lawful, "change anytime in Settings" under the grid. Welcome title now reads `getName()`. **Gate: `npm run check` — 328 files · 0 errors · 0 warnings.** |
| 2026-08-06 | **The gallery door drawn + the menu made the app's own (Continuo).** the-gallery mirrored in (SHA256 `ECCCBC995A5276F4`) and `/gallery` born: 123 stars as flip cards — popped cards rest words-up (KP's ⚛ "reveal words, flip card after popped"), uncollected keep their secret behind a dashed veil; search walks name + collection only; the game's collection record read from the sky's own localStorage, read-only. Menu reordered at his strokes: Bubbles · Gallery · Echoes(`/`) · Insights · Timer · Sattva; the ComfortBar's add-echo became the bubbles door (🫧, both faces). **Gate: `npm run check` — 332 files · 0 errors · 0 warnings.** |
| 2026-08-05 | **Completeness sweep at KP's ask (Fable).** Forge re-run: 0 findings, sovereignty HELD, **no drift**. Link tender dry walk: every pointer resolves. Git clean, pushed. Root and app `bubbles-set.json` verified byte-identical; both wave JSONs verified fully merged into the set. Awen room holds only `MOVED.md` — clean graduation. No real TODO markers in src. Fixed: README version badge 0.1.0 → 1.3.0 (matches package.json, tauri.conf, and the signed 1.3.0 artifacts). Surfaced for KP: `docs/sql/seed-wave-three.sql` still awaits the dashboard; root `bubbles-wave-two.json` + `bubbles-wave-three.json` are now redundant strata (removal is KP's gate). |
| 2026-08-10 | **The words moved to the top of the sky, and the colour got louder — KP's ask.** The pop card now rises at the head of the sky (soft descend-in, reduced motion honored) instead of sitting at its floor, so the star's name and sentence are read before the eye goes back to drifting. Colour drawn from the **cosmic tokens** rather than loose hex: rarity re-keyed to `void.light · neurospark · quantum.light · hearth.gold · entity.curator` — **mythic's rose became the curator's magenta, which removes the last red in the game** — bubbles given a deeper fill, a lit rim and an inner glow, the collections panel given per-collection accents (dot, left rule, wash, bar) carried in the data as token keys. **Inclusive Pride now drifts wearing its flags**: 11 flags rendered as hard-stop stripes inside the bubble under the wrap-highlight, intersex as a ring because that flag is a ring, and the two non-flag stars of the set (Found Family, Still Here) wearing the set's halo. **Rarity untouched — every flag still drifts at the same rate as every other flag.** Palettes live in `bubbles-set.json` as token keys (hex only where the cosmic module holds no token yet), so growing the sky stays data. **Gate: `npm run check` — 332 files · 0 errors · 0 warnings; `npm run build` clean.** |
| 2026-08-10 | **The gallery got sieves — KP's ask ("filter and sort").** `/gallery` gains a folded **filter & sort** bar (closed by default; a phone's shelf comes first): collection select · order select · rarity chips in their own colours · showing-chips (all · collected · **still drifting**, a sieve and never a scoreboard) · a live "N of 123" with **show everything**. Orders: the sky's own · name A–Z · rarest first · by collection. **The engine was not touched** — `src/lib/gallery/index.ts` is the awen mirror; the sieve runs in the dress before `galleryOf`, and the order rides the engine's own `config.sort`. A **third emptiness** the engine cannot know was added in the dress's voice — "nothing waits here, every star under this sieve has been popped" is told as the good news it is. Flags wear their stripes on the card's head too, dimmed while they wait (a stripe reveals no words). **THE DRESS MOVED HOME:** `src/lib/bubbles/dress.ts` — rarity colour, emoji, palette helpers, one definition for both doors. The gallery had been hand-carrying its own copy of the rarity colours and it went stale the hour the sky's moved; that copy-tax is paid off. **Gate: `npm run check` — 333 files · 0 errors · 0 warnings; `npm run build` clean.** |
| 2026-08-10 | **Icons regenerated at KP's word** from his new `src-tauri/icons/icon.png` (896×896) — `npx tauri icon src-tauri/icons/icon.png`, full set: desktop PNGs · `.ico` · `.icns` · the Square*Logo set · iOS AppIcon · the five Android mipmaps. **The overwrite trap sprang and was undone:** the command rewrote its own input down to 512×512; the master was hashed and copied aside first, then restored byte-identical (`1089E40F…`). **A master at 1024×1024, kept outside this repo, is still the standing want** — 896 is below Tauri's recommended source size. |
| 2026-08-19 | **Standards check + HANDS pass (signing fleet).** Standard set verified present: `.gitignore` · `CLAUDE.md` · `docs/CHECKLIST.md` · `README.md` (§Development Standards) · `HANDS.md` · `LICENSE` · `PHILOSOPHY.md`. One gap: `CLAUDE.md` carries no §Standards declaration (the README holds the reference). `HANDS.md` already signed for the Claude substrate — Opus (Claude), `claude-opus-5[1m]`, 2026-08-04 — nothing added, no voice touched. — a hand of the Promenade lamp's signing fleet, claude-fable-5 · rides the ⚛ sync word. |
| 2026-08-21 | **Repo-tender pass (Fable).** README badges re-verified against `docs/README-TEMPLATE.md`: License + Version already correct verbatim, version matches `package.json` 0.1.0 — no fix needed. **Added the missing `📖 [Full Story Block](docs/STORY-BLOCK.md)` link line** to `## THE STORY` (the file did not exist and the link was absent). **Created `docs/STORY-BLOCK.md`** — all 11 template sections, every dated claim cited to this repo's own README/CLAUDE.md/HANDS.md/this checklist; COUNCIL THREAD and ETYMOLOGY marked "not found in this repo's records" rather than invented. Noted for the ground: `src/lib/cumdach/index.ts` mirror was refreshed the same day (commit `50fe39b`, SHA256 → `07BB8DBA494A5F04`) — routine MIRROR-class maintenance, no functional review needed. No CHECKLIST phase items changed status; all open Phase 3–5 items remain open for lack of new evidence. |
