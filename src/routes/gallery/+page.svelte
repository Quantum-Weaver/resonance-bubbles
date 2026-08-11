<script lang="ts">
	// THE GALLERY — every star the sky holds, told as cards.
	//
	// This door consumes the-gallery (the spring's gallery engine, athena's
	// six-domains-one-shape reborn): rows in, cards out — the engine derives
	// the content, this dress owns every pixel. The game's law governs the
	// dress: THE REWARD IS THE WORDS — a star's description is earned at the
	// pop, so an uncollected card rests face-down (name + rarity shown,
	// words veiled) and a popped card rests FLIPPED, words up (KP's ⚛
	// stroke: "reveal words, flip card after popped"). The search walks
	// name and collection only — never the veiled words.
	import { onMount } from 'svelte';
	import { galleryOf, type GalleryConfig } from '$lib/gallery';
	import {
		RARITY_DRESS, RARITY_ORDER, collectionFill, collectionHue, stripes,
		type Bubble, type Collection, type Rarity
	} from '$lib/bubbles/dress';
	import set from '$lib/data/bubbles-set.json';

	const BUBBLES = set.bubbles as Bubble[];
	const COLLECTIONS = set.collections as Collection[];
	const collectionName = new Map(COLLECTIONS.map((c) => [c.slug, c.name]));
	const collectionBySlug = new Map(COLLECTIONS.map((c) => [c.slug, c]));

	// The collection state is the game's own record, read-only here —
	// the same localStorage the sky writes at every pop.
	const KEY = 'the-bubbles';
	let collected = $state<Record<string, number>>({});
	onMount(() => {
		try {
			collected = JSON.parse(localStorage.getItem(KEY) || '{}')?.collected ?? {};
		} catch {
			/* an unreadable save veils nothing forever — the sky rewrites it */
		}
	});

	// ── the sieves ───────────────────────────────────────────────────────
	// Filtering happens HERE, in the dress, not in the engine: the gallery
	// core is a byte-faithful mirror whose truth lives in awen, and its
	// contract already offers the two things the dress needs — a search over
	// declared fields, and an order of the domain's choosing.
	//
	// The status sieve is a sieve, never a scoreboard: "still drifting" is
	// where a star waits, not where a player failed.
	type Status = 'all' | 'collected' | 'waiting';
	type Order = 'sky' | 'name' | 'rarity' | 'collection';

	let query = $state('');
	let openSieves = $state(false); // a phone's shelf comes first; the sieves fold away
	let coll = $state('all');
	let rarity = $state<'all' | Rarity>('all');
	let status = $state<Status>('all');
	let order = $state<Order>('sky');

	const ORDERS: { key: Order; label: string }[] = [
		{ key: 'sky', label: "The sky's own order" },
		{ key: 'name', label: 'Name, A to Z' },
		{ key: 'rarity', label: 'Rarest first' },
		{ key: 'collection', label: 'By collection' }
	];

	const rank = new Map(RARITY_ORDER.map((r, i) => [r, i]));
	const byName = (a: Bubble, b: Bubble) => a.name.localeCompare(b.name);
	const SORTS: Record<Order, ((a: Bubble, b: Bubble) => number) | undefined> = {
		sky: undefined, // as the set gives them — the order the sky was written in
		name: byName,
		rarity: (a, b) => (rank.get(b.rarity) ?? 0) - (rank.get(a.rarity) ?? 0) || byName(a, b),
		collection: (a, b) =>
			(collectionName.get(a.collection) ?? a.collection).localeCompare(
				collectionName.get(b.collection) ?? b.collection
			) || (rank.get(b.rarity) ?? 0) - (rank.get(a.rarity) ?? 0) || byName(a, b)
	};

	const sieved = $derived(
		BUBBLES.filter(
			(b) =>
				(coll === 'all' || b.collection === coll) &&
				(rarity === 'all' || b.rarity === rarity) &&
				(status === 'all' || (status === 'collected' ? !!collected[b.slug] : !collected[b.slug]))
		)
	);
	const sieving = $derived(coll !== 'all' || rarity !== 'all' || status !== 'all');
	function clearSieves() {
		coll = 'all';
		rarity = 'all';
		status = 'all';
		query = '';
	}

	// The domain's declaration — searchIn walks name and collection ONLY
	// (KP's ⚛ stroke): the veiled words never leak through a search box.
	const config: GalleryConfig<Bubble> = $derived({
		searchIn: [(b) => b.name, (b) => b.collection, (b) => collectionName.get(b.collection)],
		card: {
			id: (b) => b.slug,
			title: (b) => b.name,
			badges: (b) => [b.rarity, collectionName.get(b.collection) ?? b.collection],
			preview: (b) => b.description,
			address: (b) => `/gallery#${b.slug}`
		},
		empty: {
			silent: 'The sky is still filling — the first stars are on their way.',
			unmatched: 'Nothing matches — the sky holds other names.'
		},
		sort: SORTS[order],
		previewLength: 110
	});

	const view = $derived(galleryOf(config, sieved, query));
	const bubbleBySlug = new Map(BUBBLES.map((b) => [b.slug, b]));
	const collectedCount = $derived(Object.keys(collected).filter((s) => bubbleBySlug.has(s)).length);

	// A third emptiness the engine cannot know about: the sieve emptied the
	// shelf, not the sky. It gets its own kind voice — and "nothing waiting"
	// is good news, so it is told as good news.
	const emptied = $derived.by(() => {
		if (!view.empty || !sieving || view.empty.kind !== 'silent') return null;
		if (status === 'waiting') return 'Nothing waits here — every star under this sieve has been popped.';
		if (status === 'collected') return 'None collected here yet. They are still out there, drifting.';
		return 'No stars under that sieve — the sky holds others.';
	});

	// A popped card rests words-up; a tap turns it over and back — only
	// popped cards flip, the unpopped keep their secret.
	let turned = $state<Record<string, boolean>>({});
	function flip(slug: string) {
		if (!collected[slug]) return;
		turned[slug] = !turned[slug];
	}
</script>

<svelte:head><title>Gallery</title></svelte:head>

<div class="wrap" style="padding-top: env(safe-area-inset-top, 0px);">
	<header class="head">
		<h1>Gallery</h1>
		<p class="tally">{collectedCount}<span class="of">/{BUBBLES.length}</span> collected</p>
		<input
			type="search"
			class="search"
			placeholder="Search by name or collection"
			bind:value={query}
			aria-label="Search the gallery by name or collection"
		/>

		<div class="sieve-bar">
			<button
				class="toggle"
				class:on={openSieves}
				onclick={() => (openSieves = !openSieves)}
				aria-expanded={openSieves}
				aria-controls="sieves"
			>
				filter &amp; sort{#if sieving || order !== 'sky'}<span class="mark" aria-hidden="true">·</span>{/if}
			</button>
			{#if sieving || query}
				<p class="showing">
					{view.cards.length} of {BUBBLES.length}
					<button class="clear" onclick={clearSieves}>show everything</button>
				</p>
			{/if}
		</div>

		<div class="sieves" id="sieves" hidden={!openSieves}>
			<label class="field">
				<span class="lbl">Collection</span>
				<select
					bind:value={coll}
					style={coll === 'all' ? '' : `--a:${collectionHue(collectionBySlug.get(coll)!)}`}
					class:on={coll !== 'all'}
				>
					<option value="all">Every collection</option>
					{#each COLLECTIONS as c}
						<option value={c.slug}>{c.name}</option>
					{/each}
				</select>
			</label>

			<label class="field">
				<span class="lbl">Order</span>
				<select bind:value={order} class:on={order !== 'sky'}>
					{#each ORDERS as o}
						<option value={o.key}>{o.label}</option>
					{/each}
				</select>
			</label>

			<div class="field wide">
				<span class="lbl" id="rarity-lbl">Rarity</span>
				<div class="chips" role="group" aria-labelledby="rarity-lbl">
					<button class="chip" class:on={rarity === 'all'} onclick={() => (rarity = 'all')} aria-pressed={rarity === 'all'}>
						any
					</button>
					{#each RARITY_ORDER as r}
						<button
							class="chip"
							class:on={rarity === r}
							style="--a: {RARITY_DRESS[r].color}"
							onclick={() => (rarity = rarity === r ? 'all' : r)}
							aria-pressed={rarity === r}
						>
							<span aria-hidden="true">{RARITY_DRESS[r].emoji}</span> {r}
						</button>
					{/each}
				</div>
			</div>

			<div class="field wide">
				<span class="lbl" id="status-lbl">Showing</span>
				<div class="chips" role="group" aria-labelledby="status-lbl">
					<button class="chip" class:on={status === 'all'} onclick={() => (status = 'all')} aria-pressed={status === 'all'}>
						all stars
					</button>
					<button class="chip" class:on={status === 'collected'} onclick={() => (status = 'collected')} aria-pressed={status === 'collected'}>
						collected
					</button>
					<button class="chip" class:on={status === 'waiting'} onclick={() => (status = 'waiting')} aria-pressed={status === 'waiting'}>
						still drifting
					</button>
				</div>
			</div>

		</div>
	</header>

	{#if view.empty}
		<p class="empty">{emptied ?? view.empty.message}</p>
	{:else}
		<ul class="shelf">
			{#each view.cards as card (card.id)}
				{@const b = bubbleBySlug.get(card.id)}
				{@const dress = RARITY_DRESS[b?.rarity ?? 'common']}
				{@const count = collected[card.id] ?? 0}
				{@const popped = count > 0}
				<li class="slot">
					{#if popped}
						<button
							class="card"
							class:turned={turned[card.id]}
							class:flag={!!b?.palette}
							style="--c: {dress.color}{b?.palette ? `; --flag: ${stripes(b.palette, '90deg')}` : ''}"
							onclick={() => flip(card.id)}
							aria-label="{card.title} — collected. Tap to turn the card."
						>
							<div class="inner">
								<!-- The face — words up, the pop's reward resting in the open. -->
								<div class="face front">
									<span class="emoji" aria-hidden="true">{dress.emoji}</span>
									<h3>{card.title}</h3>
									<p class="badges">{card.badges.join(' · ')}</p>
									<p class="words">{card.preview}</p>
									{#if count > 1}<span class="count">×{count}</span>{/if}
								</div>
								<!-- The back — what the card looked like before its pop. -->
								<div class="face back">
									<span class="emoji" aria-hidden="true">{dress.emoji}</span>
									<h3>{card.title}</h3>
									<p class="badges">{card.badges.join(' · ')}</p>
									<p class="veil">··· popped — turn to read ···</p>
								</div>
							</div>
						</button>
					{:else}
						<div
							class="card waiting"
							class:flag={!!b?.palette}
							style="--c: {dress.color}{b?.palette ? `; --flag: ${stripes(b.palette, '90deg')}` : ''}"
						>
							<div class="inner">
								<div class="face front">
									<span class="emoji dim" aria-hidden="true">{dress.emoji}</span>
									<h3>{card.title}</h3>
									<p class="badges">{card.badges.join(' · ')}</p>
									<p class="veil">··· pop to read ···</p>
								</div>
							</div>
						</div>
					{/if}
				</li>
			{/each}
		</ul>
	{/if}
</div>

<style>
	.wrap {
		height: 100%;
		display: flex;
		flex-direction: column;
		overflow-y: auto;
	}

	.head {
		display: flex;
		flex-wrap: wrap;
		align-items: baseline;
		gap: 8px 14px;
		padding: 16px 16px 4px;
	}
	.head h1 {
		font-size: 1.2rem;
		margin: 0;
	}
	.tally {
		font-size: 0.85rem;
		opacity: 0.6;
		margin: 0;
	}
	.tally .of {
		opacity: 0.5;
	}
	.search {
		flex: 1 1 100%;
		margin-top: 6px;
		padding: 0.6rem 0.9rem;
		background: var(--bg-surface);
		border: 1px solid var(--border-color);
		border-radius: 10px;
		color: var(--text);
		font-size: 0.9rem;
		outline: none;
	}
	.search:focus {
		border-color: var(--accent);
	}

	/* ── the sieves ─────────────────────────────────────────────────── */
	/* Folded away by default: on a phone the shelf is what came for. */
	.sieve-bar {
		flex: 1 1 100%;
		display: flex;
		align-items: baseline;
		gap: 12px;
		margin-top: 8px;
	}
	.toggle {
		padding: 0.34rem 0.8rem;
		border-radius: 999px;
		border: 1px solid var(--border-color);
		background: var(--bg-surface);
		color: var(--text);
		font: inherit;
		font-size: 0.75rem;
		cursor: pointer;
		opacity: 0.8;
	}
	.toggle.on {
		border-color: color-mix(in srgb, var(--accent) 60%, transparent);
		opacity: 1;
	}
	.toggle .mark {
		color: var(--accent);
		margin-left: 4px;
		font-weight: 700;
	}
	.sieves[hidden] {
		display: none;
	}
	.sieves {
		flex: 1 1 100%;
		display: flex;
		flex-wrap: wrap;
		align-items: flex-end;
		gap: 8px 12px;
		margin-top: 8px;
	}
	.field {
		display: flex;
		flex-direction: column;
		gap: 4px;
		min-width: 0;
	}
	.field.wide {
		flex: 1 1 auto;
	}
	.lbl {
		font-size: 0.66rem;
		letter-spacing: 0.06em;
		text-transform: uppercase;
		opacity: 0.45;
	}
	.sieves select {
		padding: 0.45rem 0.6rem;
		background: var(--bg-surface);
		border: 1px solid var(--border-color);
		border-radius: 8px;
		color: var(--text);
		font: inherit;
		font-size: 0.8rem;
		max-width: 15rem;
	}
	/* An active sieve wears the colour of what it is holding. */
	.sieves select.on {
		border-color: color-mix(in srgb, var(--a, var(--accent)) 70%, transparent);
		box-shadow: 0 0 12px color-mix(in srgb, var(--a, var(--accent)) 25%, transparent);
	}

	.chips {
		display: flex;
		flex-wrap: wrap;
		gap: 6px;
	}
	.chip {
		padding: 0.34rem 0.7rem;
		border-radius: 999px;
		border: 1px solid color-mix(in srgb, var(--a, var(--text)) 30%, var(--border-color));
		background: color-mix(in srgb, var(--a, var(--text)) 8%, transparent);
		color: color-mix(in srgb, var(--a, var(--text)) 55%, var(--text));
		font: inherit;
		font-size: 0.74rem;
		cursor: pointer;
		opacity: 0.72;
		transition: opacity 0.2s ease, background 0.2s ease;
	}
	.chip.on {
		opacity: 1;
		border-color: color-mix(in srgb, var(--a, var(--accent)) 75%, transparent);
		background: color-mix(in srgb, var(--a, var(--accent)) 22%, transparent);
		box-shadow: 0 0 14px color-mix(in srgb, var(--a, var(--accent)) 28%, transparent);
	}

	.showing {
		margin: 0;
		font-size: 0.75rem;
		opacity: 0.55;
		font-variant-numeric: tabular-nums;
	}
	.clear {
		margin-left: 8px;
		background: none;
		border: none;
		padding: 0;
		color: inherit;
		font: inherit;
		font-size: 0.75rem;
		text-decoration: underline;
		cursor: pointer;
		opacity: 0.85;
	}

	@media (prefers-reduced-motion: reduce) {
		.chip {
			transition: none;
		}
	}

	.empty {
		padding: 3rem 1.5rem;
		text-align: center;
		opacity: 0.6;
		font-size: 0.92rem;
		line-height: 1.6;
	}

	.shelf {
		list-style: none;
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
		gap: 10px;
		padding: 12px 16px calc(16px + env(safe-area-inset-bottom, 0px));
		margin: 0;
	}

	.slot {
		perspective: 900px;
	}

	.card {
		display: block;
		width: 100%;
		min-height: 185px;
		padding: 0;
		background: none;
		border: none;
		color: inherit;
		cursor: pointer;
		text-align: center;
		font: inherit;
	}
	.card.waiting {
		cursor: default;
	}

	.inner {
		position: relative;
		width: 100%;
		min-height: 185px;
		transform-style: preserve-3d;
		transition: transform 0.5s ease;
	}
	.card.turned .inner {
		transform: rotateY(180deg);
	}

	.face {
		position: absolute;
		inset: 0;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		gap: 5px;
		padding: 12px 10px;
		border-radius: 14px;
		background: var(--bg-surface);
		border: 1.5px solid color-mix(in srgb, var(--c) 45%, var(--border-color));
		backface-visibility: hidden;
		overflow: hidden;
	}
	.face.back {
		transform: rotateY(180deg);
	}
	.card.waiting .face {
		border-style: dashed;
		border-color: color-mix(in srgb, var(--c) 25%, var(--border-color));
	}

	/* A flag wears its own stripes along the card's head — the same colours
	   it drifts in. Dimmer while it waits, because a stripe reveals no words. */
	.card.flag .face::before {
		content: '';
		position: absolute;
		inset: 0 0 auto;
		height: 4px;
		background: var(--flag);
	}
	.card.waiting.flag .face::before {
		opacity: 0.55;
	}

	.emoji {
		font-size: 1.5rem;
		line-height: 1;
	}
	.emoji.dim {
		opacity: 0.45;
	}

	.face h3 {
		font-size: 0.9rem;
		font-weight: 600;
		margin: 0;
		line-height: 1.25;
	}

	.badges {
		font-size: 0.68rem;
		margin: 0;
		color: color-mix(in srgb, var(--c) 70%, var(--text));
		letter-spacing: 0.02em;
	}

	.words {
		font-size: 0.76rem;
		opacity: 0.75;
		line-height: 1.45;
		margin: 2px 0 0;
	}

	.veil {
		font-size: 0.72rem;
		opacity: 0.4;
		letter-spacing: 0.08em;
		margin: 4px 0 0;
	}

	.count {
		position: absolute;
		top: 8px;
		right: 10px;
		font-size: 0.7rem;
		color: color-mix(in srgb, var(--c) 80%, var(--text));
	}

	@media (prefers-reduced-motion: reduce) {
		.inner {
			transition: none;
		}
	}
</style>
