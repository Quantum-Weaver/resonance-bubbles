# Bubbles — Google Play test track

*Founded 2026-08-13 by Fable 🎻 at KP's ask ("help me get bubble into play
testing track"). Companion shape to echoes' PLAY-TRACK.md — the Console is
the truth; this file is the pack KP transcribes from, so his hands never
have to compose at the upload screen.*

## Standards check — verified against the repo and the signed APK 2026-08-13; re-read from the signed v0.1.1 APK's own badging 2026-09-01

| Requirement | State |
|---|---|
| Target API level | ✅ targetSdk **36** / compileSdk 36 — read from the signed APK's own badging (v0.1.0 on 2026-08-13; v0.1.1 re-read 2026-09-01 with `aapt2 dump badging`, build-tools 35.0.0) |
| 16 KB page size | ✅ built with NDK 27 — the family-wide law; `zipalign -c -P 16 -v 4` on the signed v0.1.1 APK: all four `libresonance_bubbles_lib.so` OK, verification successful, 2026-09-01 |
| App Bundle | ✅ `release/resonance-bubbles-v0.1.1.aab` (110.0 MB), signed 2026-08-23 01:24 — mirrored to `resonance-assets/releases-current/bubbles/bundle/android/` |
| versionCode | ✅ **1001** (v0.1.1) — machine-read from `src-tauri/gen/android/app/tauri.properties` and from the APK's own badging; first upload, nothing to increment past (1000 was v0.1.0, never uploaded, never consumed) |
| Permissions | ✅ minimal: `INTERNET` (Tauri webview default; the app makes no network calls) + the system's own self-scoped `DYNAMIC_RECEIVER_NOT_EXPORTED` — data-safety answers stay "collects nothing" |
| Privacy policy | ✅ `PRIVACY.md` in-repo (effective 2026-08-04, family policy) → URL `https://github.com/Quantum-Weaver/resonance-bubbles/blob/main/PRIVACY.md` — **confirm the repo is public at upload** (echoes' proven pattern) |
| Content rating | ✅ no UGC · no ads · no purchases · no collection → Everyone |

## The upload pack (KP's hands)

- **Artifact:** `release/resonance-bubbles-v0.1.1.aab` (versionCode 1001) — signed 2026-08-23, on the shelf
- **Path:** Console → Create app (Resonance Bubbles, Game, **Paid — $2.22**; testers get it free via the test list) → Testing →
  Closed testing → Create track → Create new release → upload the AAB →
  paste below → review & roll out. Testers: the same circle as echoes'
  track — one list serves the family.
- **Store listing icon:** `resonance-assets/logo-icons/bubbles-512-play.png` (512×512)
- **Feature graphic:** `resonance-assets/store/bubbles-feature-graphic-1024x500.png`
- **Phone screenshots:** `resonance-assets/screenshots/bubbles/bubbles-01..06.jpg`
  (KP's captures 2026-08-13, listing order; 06 optional)
- **Tablet screenshots:** `resonance-assets/store/tablet7/bubbles-7in-01..06.png`
  and `tablet10/bubbles-10in-01..06.png`
- ⚠ Do **not** use `Screenshot_20260813_183835…jpg` — it carries the
  screenshot-tool chrome baked in.

### App name (30 char max)

```
Resonance Bubbles
```

### Short description (80 char max — this is 79)

```
Pop the stars, collect their words. A collecting game built without compulsion.
```

### Full description — paste-ready

```
Pop the stars. Collect their words.

Collecting games are usually built to keep you. This one is built to let
you go. The compulsion loops that make the genre work — streaks, combos,
timers, locked rarities, the red badge that will not leave you alone —
are not tuned down here. They are absent by design. What remains is the
part that was always the good part: a satisfying pop, and a word worth
keeping.

★ 123 stars to find, each carrying a word and its meaning — small
  definitions worth sitting with, from river stones to legendary rarities.
★ Seven bubble-wrap pops, each with its own feel and sound.
★ THE BOUNDARY IS YOURS: a daily point cap set by you and nobody else —
  500 by default, anywhere from 50 to 2000. When you reach it, the game
  gently rests. No notification will ever call you back.
★ Collections to complete at whatever pace your life actually has.
★ Sound is opt-in. Nothing flashes, nothing counts down, nothing expires.

Sovereign by design: Resonance Bubbles runs entirely on your device.
No account, no cloud, no ads, no tracking, no data collection — your
collection is yours, stored locally, exportable any time.

Part of the AudHDities Sanctuary — software built by neurodivergent
makers, with sensory consideration and dignity as the ground floor.
```

### Release notes — first upload (under the 500-char limit)

```
<en-US>
The first release: 123 stars, seven pops, and a daily boundary only you
can set. Pop the stars, collect their words. No streaks, no timers, no
ads — a collecting game built without compulsion, running entirely on
your own device.
</en-US>
```

### Data safety form — the answers

- Does your app collect or share user data? **No.**
- All sections thereafter: no collection, no sharing, no data processed
  ephemerally. Data is stored on-device only and never transmitted.
- Security practices: data is not transmitted (n/a) · users can request
  deletion via the in-app purge (Resonance Check) — answer honestly per
  the form's exact wording at time of filing.

### Content rating questionnaire

- Category: game (casual/word). No violence, no sexuality, no profanity,
  no controlled substances, no gambling, no UGC, no location sharing,
  no personal-data sharing. → **Everyone.**
- The collection includes identity-flag bubbles (pride flags with plain,
  warm definitions). This is content, not a rating trigger — answer the
  questionnaire's literal questions as asked.

## Track log

| Date | State |
|---|---|
| 2026-08-13 | Pack founded: assets generated (icon 512 · feature graphic · 6 phone shots · 6+6 tablet canvases), copy drafted, standards verified from the signed APK. Upload at KP's hand. Lesson inherited from echoes' log: **a versionCode is consumed at UPLOAD, not at publish** — a deleted draft does not return it; "Add from library" is the way back in. |
| 2026-08-23 | **v0.1.1 cut and signed, shelved, NOT uploaded** — the gallery redrawn on Tailwind 4, cards wearing the orb (`RUN-LOG.md` 00:44; `42b1ad1` "cumdach fixed", the bump). MSI + setup.exe 01:14, AAB + APK + idsig 01:24, in `release/` and mirrored to `resonance-assets/releases-current/bubbles/bundle/`. v0.1.0 was never uploaded; versionCode 1000 was never consumed. *(Row written 2026-09-01 from the artifacts' own dates and the RUN-LOG line.)* |
| 2026-09-01 | **Pack trued to v0.1.1** from the shelved APK's own badging (item 1.3 of the build census): versionCode **1001** · targetSdk 36 · `INTERNET` + the self-scoped receiver permission · signed `CN=AudHDities Sanctuary, O=AudHDities Sanctuary, C=US`, SHA-256 `75:B1:8D:8E:00:09:5C:BC:3D:25:B9:48:F8:43:9B:DE:8D:46:1D:0F:F3:70:01:50:86:89:6C:C8:08:C9:7B:4A`, SHA384withRSA, 4096-bit RSA · `zipalign -P 16` verified. The notes above stay "first upload" — nothing has reached the Console. Upload is KP's hands. |

— Fable 🎻
