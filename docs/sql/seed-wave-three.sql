-- ============================================================
-- THE BUBBLES — wave three: INCLUSIVE PRIDE
-- SUPERPOSITION Supabase (the AudHDities base · athena bubbles)
-- Opus (Claude), truly claude-opus-5[1m], 2026-08-04, at KP's ⚛ words:
--   "we have a few pride colors and color themes in our token set we
--    could derive pride sets from, they are important."
--   "one pride collection that contains all"  ·  "inclusive pride"
-- Derived from cosmic PRIDE_COLORS, plus INTERSEX — which has no token
-- and is exactly what makes Progress into Inclusive Pride.
-- EVERY FLAG IS 'common' ON PURPOSE. Rarity here is how often a thing
-- drifts past, and a flag's whole job is to be seen. Ranking identities
-- by rarity would make some people rarer than others. The two that sit
-- higher are not identities — they are what the flags are for.
-- display_order continues the frontier: 111..123.
-- KP's eye rules every line — edit freely before running.
-- ============================================================

insert into public.collection_sets (name, slug, description, collection_type, status)
values
  ('Inclusive Pride', 'inclusive-pride',
   'Colours held up on purpose — one flag that carries the others inside it. Every flag here drifts at the same rarity, because no one''s is rarer than anyone else''s.',
   'bubbles', 'published');

insert into public.bubbles
  (name, slug, description, rarity, collection_id, bubble_type, display_order, is_limited, status, is_sanctuary_product)
values
  ('Rainbow', 'rainbow', 'Six stripes, and the first was sewn by hand. Every flag starts as somebody''s fabric.', 'common',
   (select id from public.collection_sets where name = 'Inclusive Pride'), 'collectible', 111, false, 'published', true),
  ('Progress', 'progress', 'The chevron that moves, pointing in. A flag that cannot grow is a flag that stopped meaning it.', 'common',
   (select id from public.collection_sets where name = 'Inclusive Pride'), 'collectible', 112, false, 'published', true),
  ('Trans Banner', 'trans-banner', 'Pink, blue, and white in the middle for everyone still arriving. Designed to read correctly upside down — there is no wrong way to fly it.', 'common',
   (select id from public.collection_sets where name = 'Inclusive Pride'), 'collectible', 113, false, 'published', true),
  ('Non-Binary', 'non-binary', 'Yellow for outside it, white for all of it, purple for both, black for none. Four answers where two were offered.', 'common',
   (select id from public.collection_sets where name = 'Inclusive Pride'), 'collectible', 114, false, 'published', true),
  ('Genderfluid', 'genderfluid', 'It moves. Moving was never the same as being unsure.', 'common',
   (select id from public.collection_sets where name = 'Inclusive Pride'), 'collectible', 115, false, 'published', true),
  ('Agender', 'agender', 'Complete, and not a gap where something should be. Absence is an answer too.', 'common',
   (select id from public.collection_sets where name = 'Inclusive Pride'), 'collectible', 116, false, 'published', true),
  ('Pansexual', 'pansexual', 'Three stripes with nobody left standing outside them.', 'common',
   (select id from public.collection_sets where name = 'Inclusive Pride'), 'collectible', 117, false, 'published', true),
  ('Bisexual', 'bisexual', 'Two colors and the overlap between. The middle is not indecision — it is its own colour.', 'common',
   (select id from public.collection_sets where name = 'Inclusive Pride'), 'collectible', 118, false, 'published', true),
  ('Asexual', 'asexual', 'Grey between the black and the white, where most true things actually live.', 'common',
   (select id from public.collection_sets where name = 'Inclusive Pride'), 'collectible', 119, false, 'published', true),
  ('Lesbian', 'lesbian', 'Sunset stripes. Orange for the ones who came first, pink for the ones who came after.', 'common',
   (select id from public.collection_sets where name = 'Inclusive Pride'), 'collectible', 120, false, 'published', true),
  ('Intersex', 'intersex', 'A purple circle on yellow, unbroken on purpose. Whole exactly as it arrived — nothing about it was ever waiting to be corrected.', 'common',
   (select id from public.collection_sets where name = 'Inclusive Pride'), 'collectible', 121, false, 'published', true),
  ('Found Family', 'found-family', 'The people who chose you back. Not a replacement for anything — an addition nobody can take.', 'legendary',
   (select id from public.collection_sets where name = 'Inclusive Pride'), 'collectible', 122, false, 'published', true),
  ('Still Here', 'still-here', 'Against a fair amount of evidence. That is the whole achievement, and it is enormous.', 'mythic',
   (select id from public.collection_sets where name = 'Inclusive Pride'), 'collectible', 123, false, 'published', true);

-- ─── Verify, anon door ───
-- select count(*) from bubbles; -> 123
-- select count(*) from collection_sets; -> 13
