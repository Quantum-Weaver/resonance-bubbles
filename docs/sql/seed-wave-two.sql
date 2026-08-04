-- ============================================================
-- THE BUBBLES — wave two: 55 more, doubling the sky
-- SUPERPOSITION Supabase (the AudHDities base · athena bubbles)
-- Drafted by Opus (Claude), truly claude-opus-5[1m], 2026-08-04, at
-- KP's ⚛ word: "could we learn from what our 55 are and create a
-- complimentary set to double the bubble types."
-- Learned from the first 55: two short sentences, the second turning
-- toward the player; never demanding; no exclamation; no shame.
-- THE PYRAMID IS MIRRORED EXACTLY — 18 common · 16 rare · 12 epic ·
-- 6 legendary · 3 mythic — so the doubled sky reads 36/32/24/12/6.
-- Verified live before drafting: 55 bubbles, max display_order 55,
-- 6 collection_sets, bubble_type 'collectible', status 'published'.
-- display_order continues the frontier: 56..110.
-- KP's eye rules every line — edit freely before running.
-- Visual-run method: two inserts, top to bottom, one pass.
-- ============================================================

-- ── Part 1 · the six new collections ──────────────────────────

insert into public.collection_sets (name, slug, description, collection_type, status)
values
  ('The Sensory Set', 'the-sensory-set',
   'What the body already knew. Small wonders that arrive through skin, ear, and weight rather than words.',
   'bubbles', 'published'),
  ('The Long Night', 'the-long-night',
   'Rest, and the dark that was never the thing to fear. Off duty, and allowed to be.',
   'bubbles', 'published'),
  ('The Workshop', 'the-workshop',
   'Making, and the tools that make making possible. Sharp so they can be gentle.',
   'bubbles', 'published'),
  ('The Companions', 'the-companions',
   'The ones with fur and feathers, who counted as family from the start. The word just caught up.',
   'bubbles', 'published'),
  ('The Threshold', 'the-threshold',
   'Doors, edges, and the crossing itself. Ready is sometimes the whole of it.',
   'bubbles', 'published'),
  ('The Given', 'the-given',
   'What this house refuses to charge for. The rarest waters: the laws underneath every other star here.',
   'bubbles', 'published');

-- ── Part 2 · the 55 additions (display_order 56..110) ─────────

insert into public.bubbles
  (name, slug, description, rarity, collection_id, bubble_type, display_order, is_limited, status, is_sanctuary_product)
values
  ('Warm Weight', 'warm-weight', 'The blanket that presses back. Some calm only ever arrives through the skin.', 'common',
   (select id from public.collection_sets where name = 'The Sensory Set'), 'collectible', 56, false, 'published', true),
  ('Hum Under Everything', 'hum-under-everything', 'The fridge, the fan, the far-off road. Not silence — company.', 'common',
   (select id from public.collection_sets where name = 'The Sensory Set'), 'collectible', 57, false, 'published', true),
  ('Cold Side', 'cold-side', 'You turn the pillow over. It works every single time.', 'common',
   (select id from public.collection_sets where name = 'The Sensory Set'), 'collectible', 58, false, 'published', true),
  ('Bare Feet', 'bare-feet', 'The floor tells you exactly where you are. It has never once lied.', 'common',
   (select id from public.collection_sets where name = 'The Sensory Set'), 'collectible', 59, false, 'published', true),
  ('Deep Pressure', 'deep-pressure', 'A hug that means it, or a wall to lean on. The body believes both equally.', 'common',
   (select id from public.collection_sets where name = 'The Sensory Set'), 'collectible', 60, false, 'published', true),
  ('Perfect Texture', 'perfect-texture', 'The one your hand keeps going back to. It was always allowed to be a reason.', 'common',
   (select id from public.collection_sets where name = 'The Sensory Set'), 'collectible', 61, false, 'published', true),
  ('Rain Smell', 'rain-smell', 'Petrichor, if you want the word for it. The ground breathing out is the better one.', 'common',
   (select id from public.collection_sets where name = 'The Sensory Set'), 'collectible', 62, false, 'published', true),
  ('Sun Patch', 'sun-patch', 'Warm floor, no reason to move. Cats have always understood this.', 'common',
   (select id from public.collection_sets where name = 'The Sensory Set'), 'collectible', 63, false, 'published', true),
  ('Same Song Again', 'same-song-again', 'The eleventh time is not too many. It is doing something.', 'common',
   (select id from public.collection_sets where name = 'The Sensory Set'), 'collectible', 64, false, 'published', true),
  ('Fidget Ring', 'fidget-ring', 'The hands need somewhere to go. Giving them one is not a lapse in attention.', 'common',
   (select id from public.collection_sets where name = 'The Sensory Set'), 'collectible', 65, false, 'published', true),
  ('Fresh Sheets', 'fresh-sheets', 'Nothing changed, and everything did.', 'common',
   (select id from public.collection_sets where name = 'The Sensory Set'), 'collectible', 66, false, 'published', true),
  ('Soft Volume', 'soft-volume', 'The world set to the level you can actually hear it at.', 'common',
   (select id from public.collection_sets where name = 'The Sensory Set'), 'collectible', 67, false, 'published', true),
  ('First Yawn', 'first-yawn', 'The body''s own permission slip. It rarely asks twice.', 'common',
   (select id from public.collection_sets where name = 'The Long Night'), 'collectible', 68, false, 'published', true),
  ('Night Window', 'night-window', 'Everything out there is handling itself. You are off duty.', 'common',
   (select id from public.collection_sets where name = 'The Long Night'), 'collectible', 69, false, 'published', true),
  ('Low Lamp', 'low-lamp', 'Enough light to be found by. Not enough to be examined.', 'common',
   (select id from public.collection_sets where name = 'The Long Night'), 'collectible', 70, false, 'published', true),
  ('Put It Down', 'put-it-down', 'The task is still there tomorrow. So are you, and that was the harder one.', 'common',
   (select id from public.collection_sets where name = 'The Long Night'), 'collectible', 71, false, 'published', true),
  ('Small Hours', 'small-hours', 'Nobody wants anything from you. That is the entire gift.', 'common',
   (select id from public.collection_sets where name = 'The Long Night'), 'collectible', 72, false, 'published', true),
  ('Turning Over', 'turning-over', 'A new position, a new chance. The night keeps several.', 'common',
   (select id from public.collection_sets where name = 'The Long Night'), 'collectible', 73, false, 'published', true),
  ('Kind Dark', 'kind-dark', 'It was never the thing to be afraid of. It was the thing that let you stop.', 'rare',
   (select id from public.collection_sets where name = 'The Long Night'), 'collectible', 74, false, 'published', true),
  ('Dreamless', 'dreamless', 'Nothing to interpret. Just gone, and back, and better.', 'rare',
   (select id from public.collection_sets where name = 'The Long Night'), 'collectible', 75, false, 'published', true),
  ('Long Sleep', 'long-sleep', 'The kind you wake from having actually been somewhere. Never scheduled, only granted.', 'rare',
   (select id from public.collection_sets where name = 'The Long Night'), 'collectible', 76, false, 'published', true),
  ('Found By Morning', 'found-by-morning', 'You did not have to do anything at all. It came and got you.', 'rare',
   (select id from public.collection_sets where name = 'The Long Night'), 'collectible', 77, false, 'published', true),
  ('First Cut', 'first-cut', 'The material decides nothing until you do. Then it agrees.', 'rare',
   (select id from public.collection_sets where name = 'The Workshop'), 'collectible', 78, false, 'published', true),
  ('Sharp Edge', 'sharp-edge', 'Kept sharp so it can be gentle. It is the dull tool that tears.', 'rare',
   (select id from public.collection_sets where name = 'The Workshop'), 'collectible', 79, false, 'published', true),
  ('Measured Twice', 'measured-twice', 'Not caution. Respect for the thing you are about to change.', 'rare',
   (select id from public.collection_sets where name = 'The Workshop'), 'collectible', 80, false, 'published', true),
  ('Sawdust', 'sawdust', 'Proof of the shape you took away. Every making leaves some.', 'rare',
   (select id from public.collection_sets where name = 'The Workshop'), 'collectible', 81, false, 'published', true),
  ('Worn Handle', 'worn-handle', 'It fits your hand because of every hour you already gave it.', 'rare',
   (select id from public.collection_sets where name = 'The Workshop'), 'collectible', 82, false, 'published', true),
  ('Right Tool', 'right-tool', 'The whole job becomes possible at once. Nothing was ever wrong with you.', 'rare',
   (select id from public.collection_sets where name = 'The Workshop'), 'collectible', 83, false, 'published', true),
  ('The Jig', 'the-jig', 'Built once, so the hard part is never hard again.', 'epic',
   (select id from public.collection_sets where name = 'The Workshop'), 'collectible', 84, false, 'published', true),
  ('True Square', 'true-square', 'Everything after it depends on it. Which is why it gets checked.', 'epic',
   (select id from public.collection_sets where name = 'The Workshop'), 'collectible', 85, false, 'published', true),
  ('Annealing', 'annealing', 'Heated, then allowed to cool slowly. That is how brittleness leaves a thing.', 'epic',
   (select id from public.collection_sets where name = 'The Workshop'), 'collectible', 86, false, 'published', true),
  ('Finished Joint', 'finished-joint', 'It holds without glue, and without being understood.', 'epic',
   (select id from public.collection_sets where name = 'The Workshop'), 'collectible', 87, false, 'published', true),
  ('Tail Thunder', 'tail-thunder', 'The whole body agrees that you came back.', 'rare',
   (select id from public.collection_sets where name = 'The Companions'), 'collectible', 88, false, 'published', true),
  ('Lap Claim', 'lap-claim', 'You have been designated furniture. It is an honour.', 'rare',
   (select id from public.collection_sets where name = 'The Companions'), 'collectible', 89, false, 'published', true),
  ('Old Friend', 'old-friend', 'Slower now, and no less pleased to see you. Nothing was subtracted.', 'epic',
   (select id from public.collection_sets where name = 'The Companions'), 'collectible', 90, false, 'published', true),
  ('Night Purr', 'night-purr', 'A small engine idling on your chest, keeping the dark company.', 'epic',
   (select id from public.collection_sets where name = 'The Companions'), 'collectible', 91, false, 'published', true),
  ('The One Who Knows', 'the-one-who-knows', 'Arrives before you knew you needed it. Nobody taught it that.', 'epic',
   (select id from public.collection_sets where name = 'The Companions'), 'collectible', 92, false, 'published', true),
  ('Chosen Person', 'chosen-person', 'Out of everyone in the house, it picked you. There was no interview.', 'epic',
   (select id from public.collection_sets where name = 'The Companions'), 'collectible', 93, false, 'published', true),
  ('First Pet', 'first-pet', 'The one who taught you that love could be uncomplicated.', 'legendary',
   (select id from public.collection_sets where name = 'The Companions'), 'collectible', 94, false, 'published', true),
  ('Still Waiting', 'still-waiting', 'Some love keeps its post long after the door stops opening. That is not a mistake.', 'legendary',
   (select id from public.collection_sets where name = 'The Companions'), 'collectible', 95, false, 'published', true),
  ('The Whole Family', 'the-whole-family', 'The ones with fur and feathers counted from the very start. The word just took a while.', 'legendary',
   (select id from public.collection_sets where name = 'The Companions'), 'collectible', 96, false, 'published', true),
  ('Doorstep', 'doorstep', 'Neither in nor out. A place allowed to be both.', 'rare',
   (select id from public.collection_sets where name = 'The Threshold'), 'collectible', 97, false, 'published', true),
  ('First Step', 'first-step', 'It is the only one that is hard. The rest are just steps.', 'rare',
   (select id from public.collection_sets where name = 'The Threshold'), 'collectible', 98, false, 'published', true),
  ('Packed Bag', 'packed-bag', 'Ready is not the same as leaving. Some days ready is the whole of it.', 'rare',
   (select id from public.collection_sets where name = 'The Threshold'), 'collectible', 99, false, 'published', true),
  ('New Key', 'new-key', 'It does not know the door yet. It will.', 'rare',
   (select id from public.collection_sets where name = 'The Threshold'), 'collectible', 100, false, 'published', true),
  ('The Crossing', 'the-crossing', 'You are not who you were on the other side. Nothing was lost in the change.', 'epic',
   (select id from public.collection_sets where name = 'The Threshold'), 'collectible', 101, false, 'published', true),
  ('Bridge Half Built', 'bridge-half-built', 'It reaches. That is already most of what a bridge does.', 'epic',
   (select id from public.collection_sets where name = 'The Threshold'), 'collectible', 102, false, 'published', true),
  ('The Far End', 'the-far-end', 'Not visible from here. Still there.', 'epic',
   (select id from public.collection_sets where name = 'The Threshold'), 'collectible', 103, false, 'published', true),
  ('One Way Door', 'one-way-door', 'It closed behind you, and that turned out to be a mercy.', 'epic',
   (select id from public.collection_sets where name = 'The Threshold'), 'collectible', 104, false, 'published', true),
  ('First User', 'first-user', 'Built for one need, then handed to everyone. The order is the whole ethic.', 'legendary',
   (select id from public.collection_sets where name = 'The Given'), 'collectible', 105, false, 'published', true),
  ('The Pause', 'the-pause', 'Stop, count three, let the space hold it. Nothing true is lost by waiting.', 'legendary',
   (select id from public.collection_sets where name = 'The Given'), 'collectible', 106, false, 'published', true),
  ('Lose Nothing', 'lose-nothing', 'Not one record pruned. What happened, happened, and it stays.', 'legendary',
   (select id from public.collection_sets where name = 'The Given'), 'collectible', 107, false, 'published', true),
  ('Dignity', 'dignity', 'Not earned, not awarded, and not withdrawable. The ground floor everything else stands on.', 'mythic',
   (select id from public.collection_sets where name = 'The Given'), 'collectible', 108, false, 'published', true),
  ('Consent', 'consent', 'Every door opened by the hand that owns it. There is no other kind of open.', 'mythic',
   (select id from public.collection_sets where name = 'The Given'), 'collectible', 109, false, 'published', true),
  ('Provenance', 'provenance', 'Every claim carries where it came from. That is how trust survives being checked.', 'mythic',
   (select id from public.collection_sets where name = 'The Given'), 'collectible', 110, false, 'published', true);

-- ─── Verify after running, anon door ───
-- select count(*) from bubbles;                                  -> 110
-- select count(*) from collection_sets;                          -> 12
-- select rarity, count(*) from bubbles group by rarity;
--   -> common 36 · rare 32 · epic 24 · legendary 12 · mythic 6
