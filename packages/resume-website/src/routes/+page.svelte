<script lang="ts">
	import FancyPortrait from '../lib/FancyPortrait.svelte';
</script>

<div class="hero">
	<h1>Welcome to My Website</h1>

	<FancyPortrait width={408} height={612} />
</div>

<style lang="scss">
	.hero {
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: center;
		height: 500px;
	}
</style>
