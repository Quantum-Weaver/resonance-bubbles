<script lang="ts">
  // Four bubbles on a wall — the collection seen whole; the quiet ones
  // fade the way uncollected stars wait.
  let { size = 20, color = 'currentColor' }: { size?: number; color?: string } = $props();
</script>
<svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
  <circle cx="8" cy="8" r="3.5" />
  <circle cx="16" cy="8" r="3.5" opacity="0.75" />
  <circle cx="8" cy="16" r="3.5" opacity="0.5" />
  <circle cx="16" cy="16" r="3.5" opacity="0.3" />
</svg>
