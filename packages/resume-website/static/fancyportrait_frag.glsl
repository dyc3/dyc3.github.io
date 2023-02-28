precision highp float;
uniform sampler2D itexture;
uniform float time;
uniform float threshold1;
uniform float threshold2;
uniform float aspect;
uniform vec4 gridLineColor;

in vec2 vUv;
out vec4 fragColor;

vec4 grid(vec2 uv, float size, float thickness, vec4 color) {
	uv *= vec2(aspect, 1.0);
	float x = fract(uv.x * size);
	float y = fract(uv.y * size);
	float d = min(x, y);
	d = min(d, 1.0 - x);
	d = min(d, 1.0 - y);
	float alpha = smoothstep(thickness, thickness - 0.01, d);
	return vec4(color.rgb, alpha);
}

void main() {
	vec4 truecolor = texture2D(itexture, vUv);
	float beforeThreshold1 = vUv.y < threshold1 ? 1.0 : 0.0;
	float beforeThreshold2 = threshold1 < vUv.y && vUv.y < threshold2 ? 1.0 : 0.0;

	vec4 gridColor = grid(vUv, 25.0, 0.04, gridLineColor);
	gridColor.a *= truecolor.a;

	fragColor = gridColor * beforeThreshold2 + truecolor * beforeThreshold1;
}