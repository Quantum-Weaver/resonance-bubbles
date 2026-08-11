// THE DRESS — one definition of what a star looks like.
//
// The sky (`/bubbles`) and the gallery (`/gallery`) both draw the same 123
// stars, and both used to hold their own copy of the rarity's face. The
// gallery's copy went stale the moment the sky's colours moved, which is the
// copy-tax the Grammar's first law names: one definition per object. The
// colours live here now, read from the cosmic tokens, and both doors import
// them.
//
// What is NOT here: the game's numbers — points, weight, size, speed. Those
// are the game's law and they stay in the game's own page. This file only
// says what a star LOOKS like.
import { QUANTUM_COLORS } from '$lib/cosmic';

export type Rarity = 'common' | 'rare' | 'epic' | 'legendary' | 'mythic';

export type Bubble = {
	slug: string;
	name: string;
	rarity: Rarity;
	collection: string;
	description: string;
	/** A flag's stripes — cosmic token keys, or a hex where no token stands yet. */
	palette?: string[];
	/** The ring some flags carry instead of stripes. */
	ring?: string;
};

export type Collection = {
	slug: string;
	name: string;
	description: string;
	/** The collection's own colour — a cosmic token key. */
	accent?: string;
	/** Or its own many colours, when one will not do. */
	palette?: string[];
};

/** Rarity's face, from the cosmic tokens — never loose hex.
 *  Mythic wears the curator's magenta, not the old rose: no red anywhere. */
export const RARITY_DRESS: Record<Rarity, { color: string; emoji: string }> = {
	common: { color: QUANTUM_COLORS['void.light'], emoji: '✨' },
	rare: { color: QUANTUM_COLORS['neurospark'], emoji: '💫' },
	epic: { color: QUANTUM_COLORS['quantum.light'], emoji: '⚡' },
	legendary: { color: QUANTUM_COLORS['hearth.gold'], emoji: '🌌' },
	mythic: { color: QUANTUM_COLORS['entity.curator'], emoji: '🪐' }
};

/** Common first — the order the pyramid is built in. */
export const RARITY_ORDER: Rarity[] = ['common', 'rare', 'epic', 'legendary', 'mythic'];

/** A palette entry is a cosmic token key first, a literal colour second. */
export function hue(v: string): string {
	return (QUANTUM_COLORS as Record<string, string>)[v] ?? v;
}

/** Hard-stop stripes — a flag inside a shape, not a smear. */
export function stripes(palette: readonly string[], angle = '162deg'): string {
	const c = palette.map(hue);
	const stops = c.map(
		(col, i) => `${col} ${((i / c.length) * 100).toFixed(2)}% ${(((i + 1) / c.length) * 100).toFixed(2)}%`
	);
	return `linear-gradient(${angle}, ${stops.join(', ')})`;
}

/** Its own colour if it has one; its rarity's otherwise. */
export function edge(b: Bubble): string {
	return b.palette?.length ? hue(b.palette[0]) : RARITY_DRESS[b.rarity].color;
}

/** A collection's fill — its stripes if it has them, else its accent. */
export function collectionFill(c: Collection, angle = '90deg'): string {
	return c.palette ? stripes(c.palette, angle) : hue(c.accent ?? 'quantum.purple');
}

/** A collection's single colour, for rules and dots and glows. */
export function collectionHue(c: Collection): string {
	return c.palette ? hue(c.palette[0]) : hue(c.accent ?? 'quantum.purple');
}
