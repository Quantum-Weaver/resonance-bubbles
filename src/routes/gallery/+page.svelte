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
	import set from '$lib/data/bubbles-set.json';

	type Rarity = 'common' | 'rare' | 'epic' | 'legendary' | 'mythic';
	type Bubble = { slug: string; name: string; rarity: Rarity; collection: string; description: string };

	const BUBBLES = set.bubbles as Bubble[];
	const COLLECTIONS = set.collections as { slug: string; name: string; description: string }[];
	const collectionName = new Map(COLLECTIONS.map((c) => [c.slug, c.name]));

	// Dress constants — the rarity's face here matches the sky's exactly.
	const RARITY_DRESS: Record<Rarity, { color: string; emoji: string }> = {
		common: { color: '#94a3b8', emoji: '✨' },
		rare: { color: '#22d3ee', emoji: '💫' },
		epic: { color: '#a855f7', emoji: '⚡' },
		legendary: { color: '#f59e0b', emoji: '🌌' },
		mythic: { color: '#f43f5e', emoji: '🪐' }
	};

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

	// The domain's declaration — searchIn walks name and collection ONLY
	// (KP's ⚛ stroke): the veiled words never leak through a search box.
	const config: GalleryConfig<Bubble> = {
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
		previewLength: 110
	};

	let query = $state('');
	const view = $derived(galleryOf(config, BUBBLES, query));
	const bubbleBySlug = new Map(BUBBLES.map((b) => [b.slug, b]));
	const collectedCount = $derived(Object.keys(collected).filter((s) => bubbleBySlug.has(s)).length);

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
	</header>

	{#if view.empty}
		<p class="empty">{view.empty.message}</p>
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
							style="--c: {dress.color}"
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
						<div class="card waiting" style="--c: {dress.color}">
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
