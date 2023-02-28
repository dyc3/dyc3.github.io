precision highp float;
varying vec2 vUv;
uniform float time;
uniform float threshold1;
uniform float threshold2;

float parabola(float x, float k){
    return pow(4.0*x*(1.0-x), k);
}

float waveActivation(float threshold, float waveLength, float uvY) {
	float waveStart = threshold - waveLength;
	float waveEnd = threshold + waveLength;
	float yprog = (uvY - waveStart) / (waveEnd - waveStart);
	float activation = parabola(yprog, 1.0);
	return clamp(activation, 0.0, 1.0);
}

void main() {
	vUv = uv;
	vec4 mvPosition = modelViewMatrix * vec4(position, 1.0);

	float waveHeight = 0.1;
	float waveLength = 0.1;

	float activateWave1 = waveActivation(threshold1, waveLength, uv.y);
	float activateWave2 = waveActivation(threshold2, waveLength, uv.y);

	mvPosition.z += waveHeight * activateWave1;
	mvPosition.z += waveHeight * activateWave2;
	gl_Position = projectionMatrix * mvPosition;
}
