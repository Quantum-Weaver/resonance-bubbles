<script lang="ts">
	import { onMount } from 'svelte';
	import { galleryOf, type GalleryConfig } from '$lib/gallery';
	import {
		RARITY_DRESS, RARITY_ORDER, collectionFill, collectionHue, edge, hue, stripes,
		type Bubble, type Collection, type Rarity
	} from '$lib/bubbles/dress';
	import '$lib/bubbles/orb.css';
	import set from '$lib/data/bubbles-set.json';

	const BUBBLES = set.bubbles as Bubble[];
	const COLLECTIONS = set.collections as Collection[];
	const collectionName = new Map(COLLECTIONS.map((c) => [c.slug, c.name]));
	const collectionBySlug = new Map(COLLECTIONS.map((c) => [c.slug, c]));

	// The game's own record, read-only here — the same localStorage the sky writes at every pop.
	const KEY = 'the-bubbles';
	let collected = $state<Record<string, number>>({});
	onMount(() => {
		try {
			collected = JSON.parse(localStorage.getItem(KEY) || '{}')?.collected ?? {};
		} catch {
			/* an unreadable save veils nothing forever — the sky rewrites it */
		}
	});

	// the sieves
	type Status = 'all' | 'collected' | 'waiting';
	type Order = 'sky' | 'name' | 'rarity' | 'collection';

	let query = $state('');
	let openSieves = $state(false);
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
		sky: undefined, // as the set gives them
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

	// The domain's declaration — searchIn walks name and collection only.
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
		previewLength: 200
	});

	const view = $derived(galleryOf(config, sieved, query));
	const bubbleBySlug = new Map(BUBBLES.map((b) => [b.slug, b]));
	const collectedCount = $derived(Object.keys(collected).filter((s) => bubbleBySlug.has(s)).length);

	// The chosen collection, told whole above its stars.
	const chosen = $derived(coll === 'all' ? null : (collectionBySlug.get(coll) ?? null));
	const chosenHave = $derived(
		chosen ? BUBBLES.filter((b) => b.collection === chosen.slug && collected[b.slug]).length : 0
	);
	const chosenTotal = $derived(chosen ? BUBBLES.filter((b) => b.collection === chosen.slug).length : 0);

	// A third emptiness the engine cannot know about: the sieve emptied the shelf, not the sky.
	const emptied = $derived.by(() => {
		if (!view.empty || !sieving || view.empty.kind !== 'silent') return null;
		if (status === 'waiting') return 'Nothing waits here — every star under this sieve has been popped.';
		if (status === 'collected') return 'None collected here yet. They are still out there, drifting.';
		return 'No stars under that sieve — the sky holds others.';
	});

	// A popped card rests words-up; a tap turns it over and back — only popped cards flip.
	let turned = $state<Record<string, boolean>>({});
	function flip(slug: string) {
		if (!collected[slug]) return;
		turned[slug] = !turned[slug];
	}

	// The orb on a card, sized by rarity — rarer is larger.
	const ORB: Record<Rarity, number> = { common: 44, rare: 48, epic: 52, legendary: 58, mythic: 66 };

	/** Every variable a card's paint reads, in one string.
	 *    --c   the orb's colour — `edge(b)`: a flag's first stripe, else the rarity
	 *    --rc  the rarity's colour (the pride halo reads it, as in the sky)
	 *    --t   the CHROME's tint — always the rarity's colour
	 *    --flag · --ring · --s  the stripes, the ring, the orb's size */
	function paint(b: Bubble): string {
		const parts = [
			`--c:${edge(b)}`,
			`--rc:${RARITY_DRESS[b.rarity].color}`,
			`--t:${RARITY_DRESS[b.rarity].color}`,
			`--flag:${b.palette ? stripes(b.palette, '90deg') : RARITY_DRESS[b.rarity].color}`,
			`--s:${ORB[b.rarity]}px`
		];
		if (b.ring) parts.push(`--ring:${hue(b.ring)}`);
		return parts.join(';');
	}
</script>

<svelte:head><title>Gallery</title></svelte:head>

<div class="flex h-full flex-col overflow-y-auto" style="padding-top: env(safe-area-inset-top, 0px);">
	<header class="flex flex-col gap-3 px-4 pt-4 pb-1">
		<!-- the title and the tally -->
		<div class="flex items-end justify-between gap-4">
			<div class="min-w-0">
				<h1 class="text-xl font-semibold tracking-tight">Gallery</h1>
				<p class="mt-0.5 text-xs text-ink-3">Every star the sky holds.</p>
			</div>
			<p class="shrink-0 text-right leading-none tabular-nums">
				<span class="text-2xl font-medium">{collectedCount}</span>
				<span class="text-sm text-ink-3">/ {BUBBLES.length}</span>
				<span class="mt-1 block text-[0.66rem] tracking-[0.08em] text-ink-3 uppercase">collected</span>
			</p>
		</div>

		<!-- the search -->
		<label class="relative block">
			<svg
				class="pointer-events-none absolute top-1/2 left-3 size-4 -translate-y-1/2 text-ink-3"
				viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"
			>
				<circle cx="11" cy="11" r="7" /><path d="m20 20-3.5-3.5" />
			</svg>
			<input
				type="search"
				class="w-full rounded-xl border border-line bg-surface py-2.5 pr-3 pl-9 text-[0.9rem] text-ink outline-none transition placeholder:text-ink-3 focus:border-accent focus:ring-2 focus:ring-accent/30"
				placeholder="Search by name or collection"
				bind:value={query}
				aria-label="Search the gallery by name or collection"
			/>
		</label>

		<!-- filter & sort -->
		<div class="flex items-center gap-3">
			<button
				class="rounded-full border border-line bg-surface px-3 py-1.5 text-xs text-ink-2 transition hover:text-ink aria-expanded:border-accent/60 aria-expanded:text-ink"
				onclick={() => (openSieves = !openSieves)}
				aria-expanded={openSieves}
				aria-controls="sieves"
			>
				filter &amp; sort{#if sieving || order !== 'sky'}<span class="ml-1 font-bold text-accent" aria-hidden="true">·</span>{/if}
			</button>
			{#if sieving || query}
				<p class="text-xs text-ink-3 tabular-nums">
					{view.cards.length} of {BUBBLES.length}
					<button class="ml-2 text-ink-2 underline underline-offset-2 hover:text-ink" onclick={clearSieves}>show everything</button>
				</p>
			{/if}
		</div>

		{#if openSieves}
			<div id="sieves" class="grid grid-cols-2 gap-x-4 gap-y-3 rounded-xl border border-line/60 bg-surface/50 p-3 sm:grid-cols-[auto_auto_1fr]">
				<label class="flex min-w-0 flex-col gap-1">
					<span class="text-[0.64rem] tracking-[0.08em] text-ink-3 uppercase">Collection</span>
					<select
						class="sieve-select max-w-60 rounded-lg border border-line bg-surface px-2.5 py-2 text-xs text-ink"
						bind:value={coll}
						style={chosen && !chosen.palette ? `--a:${collectionHue(chosen)}` : ''}
						class:on={coll !== 'all'}
					>
						<option value="all">Every collection</option>
						{#each COLLECTIONS as c}
							<option value={c.slug}>{c.name}</option>
						{/each}
					</select>
				</label>

				<label class="flex min-w-0 flex-col gap-1">
					<span class="text-[0.64rem] tracking-[0.08em] text-ink-3 uppercase">Order</span>
					<select class="sieve-select max-w-60 rounded-lg border border-line bg-surface px-2.5 py-2 text-xs text-ink" bind:value={order} class:on={order !== 'sky'}>
						{#each ORDERS as o}
							<option value={o.key}>{o.label}</option>
						{/each}
					</select>
				</label>

				<div class="col-span-2 flex flex-col gap-1 sm:col-span-1">
					<span class="text-[0.64rem] tracking-[0.08em] text-ink-3 uppercase" id="rarity-lbl">Rarity</span>
					<div class="flex flex-wrap gap-1.5" role="group" aria-labelledby="rarity-lbl">
						<button class="chip rounded-full border px-2.5 py-1 text-[0.72rem] transition" class:on={rarity === 'all'} onclick={() => (rarity = 'all')} aria-pressed={rarity === 'all'}>
							any
						</button>
						{#each RARITY_ORDER as r}
							<button
								class="chip rounded-full border px-2.5 py-1 text-[0.72rem] transition"
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

				<div class="col-span-2 flex flex-col gap-1 sm:col-span-3">
					<span class="text-[0.64rem] tracking-[0.08em] text-ink-3 uppercase" id="status-lbl">Showing</span>
					<div class="flex flex-wrap gap-1.5" role="group" aria-labelledby="status-lbl">
						<button class="chip rounded-full border px-2.5 py-1 text-[0.72rem] transition" class:on={status === 'all'} onclick={() => (status = 'all')} aria-pressed={status === 'all'}>
							all stars
						</button>
						<button class="chip rounded-full border px-2.5 py-1 text-[0.72rem] transition" class:on={status === 'collected'} onclick={() => (status = 'collected')} aria-pressed={status === 'collected'}>
							collected
						</button>
						<button class="chip rounded-full border px-2.5 py-1 text-[0.72rem] transition" class:on={status === 'waiting'} onclick={() => (status = 'waiting')} aria-pressed={status === 'waiting'}>
							still drifting
						</button>
					</div>
				</div>
			</div>
		{/if}

		<!-- the chosen collection, told whole above its stars -->
		{#if chosen}
			{@const fill = collectionFill(chosen)}
			<!-- A one-colour collection tints its banner with that colour; a many-coloured one leans on the theme's accent. -->
			<section
				class="coll-banner relative flex items-start gap-3 overflow-hidden rounded-xl border border-line/60 p-3 pl-4"
				style={chosen.palette ? '' : `--a:${collectionHue(chosen)}`}
				aria-label="{chosen.name}, {chosenHave} of {chosenTotal} collected"
			>
				<i class="absolute inset-y-0 left-0 w-[3px]" style="background:{collectionFill(chosen, '180deg')}" aria-hidden="true"></i>
				<span class="mt-1 size-2.5 shrink-0 rounded-full shadow-[0_0_10px_color-mix(in_srgb,var(--a)_70%,transparent)]" style="background:{fill}" aria-hidden="true"></span>
				<div class="min-w-0 flex-1">
					<div class="flex items-baseline gap-2">
						<strong class="truncate text-sm font-medium">{chosen.name}</strong>
						<span class="ml-auto shrink-0 text-xs text-ink-3 tabular-nums">{chosenHave}/{chosenTotal}</span>
					</div>
					<p class="mt-0.5 text-xs leading-relaxed text-ink-2">{chosen.description}</p>
					<div class="mt-2 h-1.5 overflow-hidden rounded-full bg-ink/10">
						<i
							class="block h-full w-full rounded-full transition-[clip-path] duration-500 motion-reduce:transition-none"
							style="background:{fill}; clip-path: inset(0 {100 - (chosenTotal ? (chosenHave / chosenTotal) * 100 : 0)}% 0 0)"
						></i>
					</div>
				</div>
			</section>
		{/if}
	</header>

	{#if view.empty}
		<p class="px-6 py-12 text-center text-[0.92rem] leading-relaxed text-ink-2">{emptied ?? view.empty.message}</p>
	{:else}
		<ul class="m-0 grid list-none grid-cols-[repeat(auto-fill,minmax(9.75rem,1fr))] gap-2.5 px-4 pt-3 pb-[calc(1rem+env(safe-area-inset-bottom,0px))] sm:gap-3 lg:grid-cols-[repeat(auto-fill,minmax(10.5rem,1fr))]">
			{#each view.cards as card (card.id)}
				{@const b = bubbleBySlug.get(card.id)}
				{@const dress = RARITY_DRESS[b?.rarity ?? 'common']}
				{@const count = collected[card.id] ?? 0}
				{@const popped = count > 0}
				{@const isFlag = !!b?.palette}
				{@const isPride = b?.collection === 'inclusive-pride'}
				<li class="perspective-[900px]">
					{#if popped && b}
						<button
							class="group block h-full w-full cursor-pointer rounded-2xl border-0 bg-transparent p-0 text-center font-[inherit] text-inherit"
							style={paint(b)}
							onclick={() => flip(card.id)}
							aria-label="{card.title} — collected. Tap to turn the card."
							aria-pressed={!!turned[card.id]}
						>
							<div
								class="relative h-full transform-3d transition-transform duration-500 ease-out motion-reduce:transition-none group-hover:-translate-y-0.5"
								class:rotate-y-180={turned[card.id]}
							>
								<!-- The face -->
								<div class="face face-on relative flex h-full flex-col items-center gap-1.5 overflow-hidden rounded-2xl border px-3 pt-6 pb-3 backface-hidden">
									<i class="absolute inset-x-0 top-0 h-[3px]" style="background:var(--flag)" aria-hidden="true"></i>
									{#if count > 1}
										<span class="pill absolute top-2.5 right-2.5 rounded-full border px-1.5 py-px text-[0.62rem] tabular-nums">×{count}</span>
									{/if}
									<span class="orb block h-(--s) w-(--s) shrink-0" class:flag={isFlag} class:pride={isPride} aria-hidden="true"></span>
									<h3 class="name mt-1.5 text-[0.92rem] leading-tight font-semibold">{card.title}</h3>
									<p class="pill rounded-full border px-2 py-0.5 text-[0.62rem] tracking-[0.06em]">
										<span aria-hidden="true">{dress.emoji}</span> {b.rarity}
									</p>
									<p class="max-w-full truncate text-[0.68rem] text-ink-3">{collectionName.get(b.collection) ?? b.collection}</p>
									<p class="mt-auto pt-1 text-[0.78rem] leading-snug text-ink-2">{card.preview}</p>
								</div>
								<!-- The back -->
								<div class="face face-on absolute inset-0 flex rotate-y-180 flex-col items-center justify-center gap-2 overflow-hidden rounded-2xl border px-3 py-4 backface-hidden">
									<i class="absolute inset-x-0 top-0 h-[3px]" style="background:var(--flag)" aria-hidden="true"></i>
									<span class="orb block shrink-0" class:flag={isFlag} class:pride={isPride} style="width:calc(var(--s) * 1.4); height:calc(var(--s) * 1.4)" aria-hidden="true"></span>
									<h3 class="name mt-2 text-[0.92rem] leading-tight font-semibold">{card.title}</h3>
									<p class="text-[0.7rem] text-ink-3 tabular-nums">{count === 1 ? 'popped once' : `popped ×${count}`}</p>
									<p class="max-w-full truncate text-[0.7rem] text-ink-2">{collectionName.get(b.collection) ?? b.collection}</p>
									<p class="mt-1 text-[0.62rem] tracking-[0.12em] text-ink-3">··· turn back ···</p>
								</div>
							</div>
						</button>
					{:else if b}
						<div
							class="face face-off relative flex h-full flex-col items-center gap-1.5 overflow-hidden rounded-2xl border border-dashed px-3 pt-6 pb-3 text-center"
							style={paint(b)}
						>
							<i class="absolute inset-x-0 top-0 h-[3px] opacity-50" style="background:var(--flag)" aria-hidden="true"></i>
							<span class="orb block h-(--s) w-(--s) shrink-0 opacity-45 saturate-50" class:flag={isFlag} class:pride={isPride} aria-hidden="true"></span>
							<h3 class="mt-1.5 text-[0.92rem] leading-tight font-semibold text-ink-2">{card.title}</h3>
							<p class="pill dim rounded-full border px-2 py-0.5 text-[0.62rem] tracking-[0.06em]">
								<span aria-hidden="true">{dress.emoji}</span> {b.rarity}
							</p>
							<p class="max-w-full truncate text-[0.68rem] text-ink-3">{collectionName.get(b.collection) ?? b.collection}</p>
							<p class="mt-auto pt-2 text-[0.66rem] tracking-[0.12em] text-ink-3">··· pop to read ···</p>
						</div>
					{/if}
				</li>
			{/each}
		</ul>
	{/if}
</div>

<style>
	/* The painterly few — each mixes a per-card colour (`--t`, `--c`, set by paint()) into the live theme tokens. */

	/* A card's surface — the star's colour bleeding into the theme's surface. */
	.face {
		background: var(--bg-surface);
		border-color: color-mix(in srgb, var(--t) 45%, var(--border-color));
		transition: box-shadow 0.25s ease, border-color 0.25s ease;
	}
	.face-on {
		background: linear-gradient(180deg, color-mix(in srgb, var(--t) 13%, var(--bg-surface)), var(--bg-surface) 72%);
		border-color: color-mix(in srgb, var(--t) 55%, var(--border-color));
		box-shadow: 0 8px 22px -14px color-mix(in srgb, var(--t) 70%, transparent);
	}
	/* A soft halo rising behind the orb, in the rarity's tint. */
	.face-on::after {
		content: '';
		position: absolute;
		inset: -45% -25% auto;
		height: 75%;
		pointer-events: none;
		background: radial-gradient(ellipse at 50% 0%, color-mix(in srgb, var(--t) 22%, transparent), transparent 62%);
	}
	.group:hover .face-on,
	.group:focus-visible .face-on {
		border-color: color-mix(in srgb, var(--t) 75%, var(--border-color));
		box-shadow:
			0 0 26px color-mix(in srgb, var(--t) 22%, transparent),
			0 12px 28px -14px color-mix(in srgb, var(--t) 60%, transparent);
	}
	/* A waiting star: the surface thinner, the edge dashed and faint. */
	.face-off {
		background: color-mix(in srgb, var(--bg-surface) 72%, transparent);
		border-color: color-mix(in srgb, var(--t) 28%, var(--border-color));
	}

	/* The name wears the star's colour, mixed toward the theme's ink. */
	.name {
		color: color-mix(in srgb, var(--t) 58%, var(--text));
	}

	/* The rarity pill and the count pill — tinted, never loud. */
	.pill {
		background: color-mix(in srgb, var(--t) 16%, transparent);
		border-color: color-mix(in srgb, var(--t) 38%, transparent);
		color: color-mix(in srgb, var(--t) 72%, var(--text));
	}
	.pill.dim {
		background: color-mix(in srgb, var(--t) 8%, transparent);
		border-color: color-mix(in srgb, var(--t) 22%, transparent);
		color: color-mix(in srgb, var(--t) 45%, var(--text-muted));
	}

	/* The sieves' active states wear the colour of what they hold (`--a`). */
	.chip {
		border-color: color-mix(in srgb, var(--a, var(--text)) 30%, var(--border-color));
		background: color-mix(in srgb, var(--a, var(--text)) 8%, transparent);
		color: color-mix(in srgb, var(--a, var(--text)) 55%, var(--text));
		opacity: 0.72;
	}
	.chip.on {
		opacity: 1;
		border-color: color-mix(in srgb, var(--a, var(--accent)) 75%, transparent);
		background: color-mix(in srgb, var(--a, var(--accent)) 22%, transparent);
		box-shadow: 0 0 14px color-mix(in srgb, var(--a, var(--accent)) 28%, transparent);
	}
	.sieve-select.on {
		border-color: color-mix(in srgb, var(--a, var(--accent)) 70%, transparent);
		box-shadow: 0 0 12px color-mix(in srgb, var(--a, var(--accent)) 25%, transparent);
	}

	/* The chosen collection's banner — `--a` is the collection's own colour, or the theme's accent when it has many. */
	.coll-banner {
		--a: var(--accent);
		background: linear-gradient(90deg, color-mix(in srgb, var(--a) 14%, transparent), transparent 70%);
	}

	@media (prefers-reduced-motion: reduce) {
		.face,
		.chip {
			transition: none;
		}
	}
</style>
