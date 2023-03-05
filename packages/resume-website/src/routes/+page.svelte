<script lang="ts">
	import { faGithub, faYoutube } from '@fortawesome/free-brands-svg-icons';
	import { FontAwesomeIcon } from '@fortawesome/svelte-fontawesome';
	import FancyPortrait from '../lib/FancyPortrait.svelte';

	const socials = [
		{
			icon: faGithub,
			url: 'https://github.com/dyc3',
			text: '@dyc3'
		},
		{
			icon: faYoutube,
			url: 'https://youtube.com/@rollthedyc3',
			text: '@rollthedyc3'
		}
	];
</script>

<div class="hero">
	<div class="name">
		<h1>Carson McManus</h1>
		<h2>Full-Stack Software Engineer</h2>
		<div class="socials">
			{#each socials as social}
				<a class="social" href={social.url} target="_blank" rel="noreferrer">
					<FontAwesomeIcon icon={social.icon} /><span class="handle">{social.text}</span>
				</a>
			{/each}
		</div>
	</div>

	<FancyPortrait width={2613 / 8} height={4216 / 8} />
</div>

<div>
	<p>I love coding.</p>
</div>

<div>
	Get in touch: <a href="mailto:carson.mcmanus1+hello@gmail.com">carson.mcmanus1+hello@gmail.com</a>
</div>

<style lang="scss">
	@import '../lib/variables.scss';

	.hero {
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: center;
		height: 500px;

		background-image: url('/bg.png');
		background-size: cover;
		background-position: 100%;

		font-size: 36px;
		margin-bottom: 50px;

		@media screen and (max-width: $screen-sm) {
			font-size: 24px;

			flex-direction: column;
			height: auto;
		}
	}

	.name {
		text-align: center;
		margin-right: 50px;

		@media screen and (max-width: $screen-sm) {
			margin-right: 0;
		}
	}

	.socials {
		:link,
		:visited {
			text-decoration: none;
			color: $color-fg;
		}

		.social:hover {
			.handle {
				text-decoration: underline;
			}
		}

		.handle {
			margin-left: 10px;
		}
	}
</style>
