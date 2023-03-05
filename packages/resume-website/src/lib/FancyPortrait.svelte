<script lang="ts">
	import { onMount } from 'svelte';
	import { browser } from '$app/environment';
	import * as THREE from 'three';

	import fragmentShader from './fancyportrait_frag.glsl';
	import vertexShader from './fancyportrait_vertex.glsl';

	let time = 0;
	let threshold1 = 0.3;
	let threshold2 = 0.6;
	export let width = 300;
	export let height = 400;

	$: aspectRatio = width / height;
	const animDuration = 0.6;

	/**
	 * Source: https://easings.net/#easeInOutQuart
	 */
	function easeInOutQuart(x: number): number {
		return x < 0.5 ? 8 * x * x * x * x : 1 - Math.pow(-2 * x + 2, 4) / 2;
	}

	function clamp(x: number, min: number, max: number): number {
		return Math.min(Math.max(x, min), max);
	}

	function reset() {
		time = 0;
	}

	onMount(async () => {
		if (!browser) {
			return;
		}
		let canvas = document.getElementById('fancyportrait');
		if (!canvas) {
			console.error('Could not find canvas element');
			return;
		}

		// const vertexShader = await fetch('/fancyportrait_vertex.glsl').then((r) => r.text());
		// const fragmentShader = await fetch('/fancyportrait_frag.glsl').then((r) => r.text());

		const scene = new THREE.Scene();
		const camera = new THREE.PerspectiveCamera(75, aspectRatio, 0.1, 1000);

		const renderer = new THREE.WebGLRenderer({
			alpha: true,
			antialias: true,
			canvas
		});
		renderer.setSize(width, height);

		const geometry = new THREE.PlaneGeometry(3, 3 / aspectRatio, 60, 80);
		const texture = new THREE.TextureLoader().load('/portrait.png');
		const material = new THREE.ShaderMaterial({
			vertexShader,
			fragmentShader,
			glslVersion: THREE.GLSL3,
			uniforms: {
				itexture: { value: texture },
				aspect: { value: aspectRatio },
				gridLineColor: { value: new THREE.Vector4(...new THREE.Color(0xff5a5f).toArray(), 1.0) }
			},
			transparent: true
		});
		const cube = new THREE.Mesh(geometry, material);
		scene.add(cube);

		camera.position.z = 3;

		let start = Date.now();
		function animate() {
			if (time > 1.5) {
				return;
			}
			requestAnimationFrame(animate);

			// update
			camera.aspect = aspectRatio;
			material.uniforms.time = { value: time };
			let t1progress = clamp((time - 0.5) / animDuration, 0, 1);
			threshold1 = easeInOutQuart(t1progress);
			let t2progress = clamp((time - 0.2) / animDuration, 0, 1);
			threshold2 = easeInOutQuart(t2progress);
			material.uniforms.threshold1 = { value: threshold1 };
			material.uniforms.threshold2 = { value: threshold2 };

			renderer.render(scene, camera);
			let elapsed = Date.now() - start;
			time += elapsed / 1000;
			start = Date.now();
		}
		animate();
	});
</script>

<!-- <span>{time}</span> -->
<div style:width>
	<!-- {#if !isAnimationStarted || isAnimationDone}
		<img src="/portrait.png" alt="Portrait" />
	{/if} -->
	<canvas id="fancyportrait" {width} {height} />
</div>

<!-- <input type="range" min="0" max="1" step="0.01" bind:value={threshold1} /><br />
<input type="range" min="0" max="1" step="0.01" bind:value={threshold2} /><br />
<button on:click={reset}>Reset</button> -->
<style lang="scss">
</style>
