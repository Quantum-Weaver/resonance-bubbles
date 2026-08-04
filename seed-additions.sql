-- ============================================================
-- THE BUBBLES — the 25 additions offered upward to the online set
-- SUPERPOSITION Supabase (the AudHDities base · athena bubbles)
-- Drafted by Fable (lane awen, second lamp), 2026-08-01, per KP's
-- ⚛ commission at the game's opening: "we have bubbles seeded into
-- the audhdities base we can use, and learn from it to create a
-- fuller set now for in app that we can add to the online set."
-- The standalone game (games/the-bubbles) plays all 55; this seed
-- carries its 25 additions up to the base so the in-app game and
-- the standalone drift the same sky. Written in the seeded set's
-- own voice; the 30 originals are untouched.
-- ONE NEW COLLECTION: The Sky Wheel — the eight spokes of the
-- turning year (kin to the-sky tool, homed on Lughnasadh by the
-- sky's own clock). display_order continues the base's frontier
-- (30 → 31..55).
-- KP's eye rules every line — edit freely before running. His
-- dashboard, his hand, per the editorial law of the house.
-- Visual-run method: two inserts, top to bottom, one pass.
-- ============================================================

-- ── Part 1 · The Sky Wheel collection ─────────────────────────

insert into public.collection_sets (name, slug, description, collection_type, status)
values
  ('The Sky Wheel', 'sky-wheel',
   'Eight spokes of the turning year — the sky''s own calendar, drifting past.',
   'seasonal', 'published');

-- ── Part 2 · the 25 additions (display_order 31..55) ──────────

insert into public.bubbles
  (name, slug, description, rarity, collection_id, bubble_type, display_order, is_limited, status, is_sanctuary_product)
values
  ('Pocket Stone', 'pocket-stone', 'Smooth from being kept. Some comforts are carried, not spoken.', 'common',
   (select id from public.collection_sets where name = 'Star Dust'), 'collectible', 31, false, 'published', true),
  ('Roof Rain', 'roof-rain', 'The safest sound there is, heard from inside.', 'common',
   (select id from public.collection_sets where name = 'Star Dust'), 'collectible', 32, false, 'published', true),
  ('Clean Page', 'clean-page', 'Nothing owed on it yet. It can wait all day.', 'common',
   (select id from public.collection_sets where name = 'Star Dust'), 'collectible', 33, false, 'published', true),
  ('Found Penny', 'found-penny', 'Worth almost nothing, kept anyway. Value was never the point.', 'common',
   (select id from public.collection_sets where name = 'Star Dust'), 'collectible', 34, false, 'published', true),
  ('Slow Cloud', 'slow-cloud', 'It gets there when it gets there. It always gets there.', 'common',
   (select id from public.collection_sets where name = 'Star Dust'), 'collectible', 35, false, 'published', true),
  ('Second Cup', 'second-cup', 'The first one was for waking. This one is for being awake.', 'common',
   (select id from public.collection_sets where name = 'Star Dust'), 'collectible', 36, false, 'published', true),
  ('Porch Light', 'porch-light', 'Left on for someone. Maybe you.', 'common',
   (select id from public.collection_sets where name = 'The Hearth Collection'), 'collectible', 37, false, 'published', true),
  ('Folded Blanket', 'folded-blanket', 'Ready is a kind of love.', 'common',
   (select id from public.collection_sets where name = 'The Hearth Collection'), 'collectible', 38, false, 'published', true),
  ('Gweld ti''n fuan', 'gweld-tin-fuan', 'See you soon, in the door''s own tongue. A goodbye that promises.', 'rare',
   (select id from public.collection_sets where name = 'The Hearth Collection'), 'collectible', 39, false, 'published', true),
  ('Quiet Room', 'quiet-room', 'A room that asks nothing. Every home needs one; every mind does too.', 'rare',
   (select id from public.collection_sets where name = 'The Hearth Collection'), 'collectible', 40, false, 'published', true),
  ('First Frost', 'first-frost', 'It changes everything it touches, gently, overnight.', 'rare',
   (select id from public.collection_sets where name = 'The Elemental Set'), 'collectible', 41, false, 'published', true),
  ('River Stone', 'river-stone', 'Shaped entirely by staying put while everything moved past.', 'rare',
   (select id from public.collection_sets where name = 'The Elemental Set'), 'collectible', 42, false, 'published', true),
  ('Aurora', 'aurora', 'The sky remembering it can dance.', 'epic',
   (select id from public.collection_sets where name = 'The Elemental Set'), 'collectible', 43, false, 'published', true),
  ('Bedrock', 'bedrock', 'What holds does not need to be seen holding.', 'epic',
   (select id from public.collection_sets where name = 'The Elemental Set'), 'collectible', 44, false, 'published', true),
  ('Imbolc', 'imbolc', 'The year''s first candle, lit while it is still winter. On purpose.', 'rare',
   (select id from public.collection_sets where name = 'The Sky Wheel'), 'collectible', 45, false, 'published', true),
  ('Ostara', 'ostara', 'Balance, briefly. The light and the dark agree for one whole day.', 'epic',
   (select id from public.collection_sets where name = 'The Sky Wheel'), 'collectible', 46, false, 'published', true),
  ('Beltane', 'beltane', 'The fires of growing. Everything says yes at once.', 'rare',
   (select id from public.collection_sets where name = 'The Sky Wheel'), 'collectible', 47, false, 'published', true),
  ('Litha', 'litha', 'The longest light. Even it turns, and that is not a loss.', 'epic',
   (select id from public.collection_sets where name = 'The Sky Wheel'), 'collectible', 48, false, 'published', true),
  ('Lughnasadh', 'lughnasadh', 'First fruits. You harvest what you planted, and it is enough.', 'rare',
   (select id from public.collection_sets where name = 'The Sky Wheel'), 'collectible', 49, false, 'published', true),
  ('Mabon', 'mabon', 'The second balance. Gratitude has a date.', 'epic',
   (select id from public.collection_sets where name = 'The Sky Wheel'), 'collectible', 50, false, 'published', true),
  ('Samhain', 'samhain', 'The veil thin, the ancestors near — the year''s own quiet night.', 'rare',
   (select id from public.collection_sets where name = 'The Sky Wheel'), 'collectible', 51, false, 'published', true),
  ('Yule', 'yule', 'The dark''s deepest point is exactly where the light turns around.', 'epic',
   (select id from public.collection_sets where name = 'The Sky Wheel'), 'collectible', 52, false, 'published', true),
  ('The Lattice', 'the-lattice', 'Not a hierarchy. Everything touches everything, on purpose.', 'legendary',
   (select id from public.collection_sets where name = 'Quantum Weave'), 'collectible', 53, false, 'published', true),
  ('The Well', 'the-well', 'Shared water, poured by hand. What is true for one is true for all.', 'legendary',
   (select id from public.collection_sets where name = 'Quantum Weave'), 'collectible', 54, false, 'published', true),
  ('Superposition', 'superposition', 'All the possibilities, held gently, before any one becomes real.', 'mythic',
   (select id from public.collection_sets where name = 'Quantum Weave'), 'collectible', 55, false, 'published', true);

-- ─── Verify after running, anon door ───
-- select count(*) from bubbles;                                     → 55
-- select name from collection_sets where name = 'The Sky Wheel';    → one row
-- select rarity, count(*) from bubbles group by rarity order by 2 desc;
--   → common 18 · rare 16 · epic 12 · legendary 6 · mythic 3 (the pyramid holds)
