<script lang="ts">
	// THE BUBBLES — the standalone playable, brought into the app.
	//
	// The laws are the game's IDENTITY, not its settings. They came whole
	// from the origin (AudHDities athena BubblePopGame) and are not tunable
	// by anyone building here. If a change would make this stickier, it is
	// the wrong change.
	//   · the limit slider is the point, not a feature — the boundary is theirs
	//   · "take a breath" at 50 pops · cooldown after 15 minutes
	//   · every rarity drifts for everyone — rare is rare, never locked
	//   · the reward is the words — no streaks, no combos, no timers, no red
	//   · local-first absolutely — collection and boundary in localStorage only
	import { onDestroy, onMount } from 'svelte';
	import set from '$lib/data/bubbles-set.json';

	type Rarity = 'common' | 'rare' | 'epic' | 'legendary' | 'mythic';
	type Bubble = { slug: string; name: string; rarity: Rarity; collection: string; description: string };

	const RARITY: Record<Rarity, { pts: number; w: number; size: number; speed: number; color: string; emoji: string }> = {
		common:    { pts: 1,  w: 60, size: 40, speed: 0.6, color: '#94a3b8', emoji: '✨' },
		rare:      { pts: 3,  w: 25, size: 48, speed: 0.5, color: '#22d3ee', emoji: '💫' },
		epic:      { pts: 5,  w: 10, size: 56, speed: 0.4, color: '#a855f7', emoji: '⚡' },
		legendary: { pts: 10, w: 4,  size: 64, speed: 0.3, color: '#f59e0b', emoji: '🌌' },
		mythic:    { pts: 25, w: 1,  size: 80, speed: 0.2, color: '#f43f5e', emoji: '🪐' }
	};

	const KEY = 'the-bubbles';
	const SPAWN_MS = 1200;
	const BREATH_POPS = 50;
	const COOLDOWN_MIN = 15;
	const DEFAULT_MAX = 500;

	const BUBBLES = set.bubbles as Bubble[];
	const COLLECTIONS = set.collections as { slug: string; name: string; description: string }[];

	type Saved = { daily: number; max: number; day: string; collected: Record<string, number>; sound: boolean };

	function today() { return new Date().toISOString().slice(0, 10); }

	function load(): Saved {
		let s: Partial<Saved> = {};
		try { s = JSON.parse(localStorage.getItem(KEY) || '{}') || {}; } catch { /* a broken save is not a reason to refuse the sky */ }
		const d = today();
		return {
			daily: s.day === d ? (s.daily ?? 0) : 0,
			max: s.max ?? DEFAULT_MAX,
			day: d,
			collected: s.collected ?? {},
			sound: s.sound ?? true
		};
	}

	let state = $state<Saved>({ daily: 0, max: DEFAULT_MAX, day: today(), collected: {}, sound: true });
	function save() { try { localStorage.setItem(KEY, JSON.stringify(state)); } catch { /* nothing leaves the page either way */ } }

	// ── the sky ──────────────────────────────────────────────────────────
	type Floater = { id: number; b: Bubble; x: number; y: number; speed: number; drift: number; popped: boolean };
	let floaters = $state<Floater[]>([]);
	let sky = $state<HTMLDivElement | null>(null);
	let nextId = 0;

	let score = $state(0);
	let sessionPops = 0;
	let sessionStart = Date.now();
	let paused = $state(false);
	// Kept apart from `paused` on purpose: leaving the breath door must never
	// silently undo a pause the player asked for themselves.
	let manualPause = $state(false);
	let lastSpawn = 0;
	let raf = 0;

	let card = $state<{ b: Bubble; pts: number; emoji: string; color: string } | null>(null);
	let cardTimer = 0;
	let showBreathDoor = $state(false);
	let showLimitDoor = $state(false);
	let showPanel = $state(false);

	const totalWeight = Object.values(RARITY).reduce((a, r) => a + r.w, 0);

	function pickRarity(): Rarity {
		// Every rarity drifts for everyone. Weighted, never locked.
		let n = Math.random() * totalWeight;
		for (const [k, r] of Object.entries(RARITY) as [Rarity, (typeof RARITY)[Rarity]][]) {
			if ((n -= r.w) <= 0) return k;
		}
		return 'common';
	}

	function spawn() {
		const rarity = pickRarity();
		const pool = BUBBLES.filter((b) => b.rarity === rarity);
		if (!pool.length || !sky) return;
		const b = pool[Math.floor(Math.random() * pool.length)];
		const W = sky.clientWidth || 800;
		floaters.push({
			id: nextId++,
			b,
			x: Math.random() * Math.max(1, W - RARITY[rarity].size),
			// Below the floor, so they RISE into the sky — bubbles go up.
			y: -RARITY[rarity].size - 20,
			speed: RARITY[rarity].speed * (0.8 + Math.random() * 0.5),
			drift: (Math.random() - 0.5) * 0.25,
			popped: false
		});
	}

	function audioFor(i: number) {
		const names = ['pop-bubble.wav', 'pop-bubble-2.wav', 'pop-bubble-3.wav', 'pop-bubble-4.wav',
			'pop-bubble-5.wav', 'pop-bubble-6.wav', 'pop-bubble-7.wav'];
		return `/sounds/${names[i % names.length]}`;
	}
	let lastPopSound = -1;
	function playPop() {
		if (!state.sound) return;
		// No two pops in a row are ever the same — KP's spec, carried.
		let i = Math.floor(Math.random() * 7);
		if (i === lastPopSound) i = (i + 1) % 7;
		lastPopSound = i;
		try { const a = new Audio(audioFor(i)); a.volume = 0.5; void a.play(); } catch { /* silence plays just as well */ }
	}

	function pop(f: Floater) {
		if (f.popped || paused || manualPause) return;
		const r = RARITY[f.b.rarity];
		if (state.daily + r.pts > state.max) { showLimit(); return; }
		f.popped = true;
		floaters = floaters.filter((x) => x.id !== f.id);
		playPop();
		state.daily += r.pts;
		state.collected[f.b.slug] = (state.collected[f.b.slug] || 0) + 1;
		save();
		score += r.pts;
		sessionPops += 1;
		card = { b: f.b, pts: r.pts, emoji: r.emoji, color: r.color };
		clearTimeout(cardTimer);
		cardTimer = window.setTimeout(() => (card = null), 3600);
		if (sessionPops === BREATH_POPS) showBreath();
	}

	function showBreath() {
		if (showBreathDoor) return;
		paused = true;
		showBreathDoor = true;
	}
	function breathResume() {
		showBreathDoor = false;
		paused = false;
		sessionPops = 0;
		sessionStart = Date.now();
	}
	function showLimit() { paused = true; showLimitDoor = true; }

	function frame(now: number) {
		if (!paused && !manualPause && sky) {
			if (now - lastSpawn > SPAWN_MS + Math.random() * 1000 && state.daily < state.max) {
				spawn();
				lastSpawn = now;
			}
			const H = sky.clientHeight || 600;
			for (const f of floaters) {
				// `bottom` grows — they rise. Bubbles go up.
				f.y += f.speed;
				f.x += f.drift;
			}
			floaters = floaters.filter((f) => f.y < H + 160);
			if ((now - sessionStart) / 60000 > COOLDOWN_MIN && sessionPops > BREATH_POPS) showBreath();
		}
		raf = requestAnimationFrame(frame);
	}

	const collectedCount = $derived(Object.keys(state.collected).length);

	function collectionProgress(slug: string) {
		const inSet = BUBBLES.filter((b) => b.collection === slug);
		const have = inSet.filter((b) => state.collected[b.slug]).length;
		return { have, total: inSet.length };
	}

	onMount(() => {
		state = load();
		raf = requestAnimationFrame(frame);
	});
	onDestroy(() => {
		if (raf) cancelAnimationFrame(raf);
		clearTimeout(cardTimer);
	});
</script>

<svelte:head><title>Bubbles</title></svelte:head>

<div class="wrap" style="padding-top: env(safe-area-inset-top, 0px);">
	<header class="bar">
		<div class="stat"><span class="n">{score}</span><span class="l">this sitting</span></div>
		<div class="stat"><span class="n">{state.daily}<span class="of">/{state.max}</span></span><span class="l">today</span></div>
		<div class="stat"><span class="n">{collectedCount}<span class="of">/{BUBBLES.length}</span></span><span class="l">collected</span></div>
		<button class="chip" onclick={() => (manualPause = !manualPause)} aria-pressed={manualPause}>
			{manualPause ? 'resume' : 'pause'}
		</button>
		<button class="chip" onclick={() => (state.sound = !state.sound, save())} aria-pressed={state.sound}>
			{state.sound ? 'sound on' : 'sound off'}
		</button>
		<button class="chip" onclick={() => (showPanel = !showPanel)}>collections</button>
	</header>

	<div class="sky" bind:this={sky}>
		{#each floaters as f (f.id)}
			<button
				class="bubble"
				style="left:{f.x}px; bottom:{f.y}px; width:{RARITY[f.b.rarity].size}px; height:{RARITY[f.b.rarity].size}px; --c:{RARITY[f.b.rarity].color};"
				onclick={() => pop(f)}
				aria-label="Pop {f.b.name}"
			></button>
		{/each}

		{#if card}
			<div class="card" style="--c:{card.color}">
				<div class="card-top"><span class="card-emoji">{card.emoji}</span><span class="card-pts">+{card.pts}</span></div>
				<h3>{card.b.name}</h3>
				<p>{card.b.description}</p>
			</div>
		{/if}
	</div>

	{#if showPanel}
		<aside class="panel">
			<h2>Collections</h2>
			{#each COLLECTIONS as c}
				{@const p = collectionProgress(c.slug)}
				<div class="coll">
					<div class="coll-head"><strong>{c.name}</strong><span>{p.have}/{p.total}</span></div>
					<div class="bar-track"><i style="width:{p.total ? (p.have / p.total) * 100 : 0}%"></i></div>
					<p>{c.description}</p>
				</div>
			{/each}
			<label class="limit">
				<span>Your daily boundary — {state.max} points</span>
				<input type="range" min="50" max="2000" step="50" bind:value={state.max} onchange={save} />
			</label>
			<button class="ghost" onclick={() => (showPanel = false)}>close</button>
		</aside>
	{/if}

	{#if showBreathDoor}
		<div class="overlay">
			<div class="inner">
				<h2>Take a breath</h2>
				<p>You've been playing for a while. The stars will still be here when you return — every one of them.</p>
				<button class="primary" onclick={breathResume}>Continue</button>
				<br /><a class="ghost" href="/sattva">enough for now</a>
			</div>
		</div>
	{/if}

	{#if showLimitDoor}
		<div class="overlay">
			<div class="inner">
				<h2>You've reached your boundary</h2>
				<p>You collected {state.daily} points today. The sky rests now — it will be full again tomorrow.</p>
				<label class="limit">
					<span>Move it if you want to — {state.max} points</span>
					<input type="range" min="50" max="2000" step="50" bind:value={state.max} onchange={save} />
				</label>
				<button class="primary" onclick={() => { save(); showLimitDoor = false; paused = state.daily >= state.max; }}>
					Done
				</button>
			</div>
		</div>
	{/if}
</div>

<style>
	.wrap { position: relative; height: 100%; display: flex; flex-direction: column; }
	.bar { display: flex; gap: 18px; align-items: center; padding: 12px 16px; flex-wrap: wrap; }
	.stat { display: flex; flex-direction: column; line-height: 1.1; }
	.stat .n { font-size: 1.15rem; font-weight: 500; }
	.stat .of { font-size: 0.85rem; opacity: 0.4; }
	.stat .l { font-size: 0.7rem; opacity: 0.45; letter-spacing: 0.03em; }
	.chip { margin-left: auto; background: rgba(255,255,255,0.06); border: none; border-radius: 999px;
		padding: 6px 14px; font-size: 0.78rem; color: inherit; cursor: pointer; opacity: 0.75; }
	.chip + .chip { margin-left: 8px; }
	.sky { position: relative; flex: 1; overflow: hidden; }
	.bubble { position: absolute; border-radius: 50%; border: 1px solid var(--c); cursor: pointer; padding: 0;
		background: radial-gradient(circle at 32% 28%, rgba(255,255,255,0.35), transparent 62%),
			color-mix(in srgb, var(--c) 22%, transparent);
		box-shadow: 0 0 18px color-mix(in srgb, var(--c) 35%, transparent); }
	.card { position: absolute; left: 50%; bottom: 8%; transform: translateX(-50%); max-width: 420px;
		background: rgba(12,12,18,0.92); border: 1px solid color-mix(in srgb, var(--c) 45%, transparent);
		border-radius: 14px; padding: 14px 18px; text-align: center; }
	.card-top { display: flex; gap: 10px; justify-content: center; align-items: center; }
	.card-emoji { font-size: 1.3rem; }
	.card-pts { color: var(--c); font-size: 0.85rem; }
	.card h3 { margin: 6px 0 4px; font-size: 1.05rem; }
	.card p { font-size: 0.88rem; opacity: 0.7; line-height: 1.5; margin: 0; }
	.panel { position: absolute; right: 0; top: 0; bottom: 0; width: min(340px, 88vw); overflow-y: auto;
		background: rgba(10,10,16,0.96); padding: 18px; }
	.coll { margin-bottom: 14px; }
	.coll-head { display: flex; justify-content: space-between; font-size: 0.85rem; }
	.coll p { font-size: 0.75rem; opacity: 0.5; margin: 4px 0 0; line-height: 1.45; }
	.bar-track { height: 5px; background: rgba(255,255,255,0.08); border-radius: 3px; overflow: hidden; margin-top: 5px; }
	.bar-track i { display: block; height: 100%; background: #a855f7; border-radius: 3px; transition: width 0.4s ease; }
	.limit { display: block; margin: 18px 0; font-size: 0.8rem; opacity: 0.8; }
	.limit input { width: 100%; margin-top: 8px; }
	.overlay { position: absolute; inset: 0; display: grid; place-items: center; background: rgba(6,6,10,0.93); z-index: 20; }
	.overlay .inner { max-width: 420px; text-align: center; padding: 24px; }
	.overlay h2 { font-size: 1.25rem; margin-bottom: 10px; }
	.overlay p { opacity: 0.55; font-size: 0.9rem; line-height: 1.55; margin-bottom: 18px; }
	.primary { background: #a855f7; border: none; border-radius: 999px; padding: 9px 22px; color: #fff; cursor: pointer; }
	.ghost { background: none; border: none; color: rgba(224,224,224,0.4); font-size: 0.8rem;
		cursor: pointer; margin-top: 14px; display: inline-block; text-decoration: none; }
</style>
