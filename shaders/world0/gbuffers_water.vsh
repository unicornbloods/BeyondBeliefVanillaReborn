#version 120

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

#define waterWaving
#define waterWaveIntensity 0.50 //Will look broken over 1.45[0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00 1.05 1.10 1.15 1.20 1.25 1.30 1.35 1.40 1.45 1.50 1.55 1.60 1.65 1.70 1.75 1.80 1.85 1.90 1.95 2.00]
#define waterWaveSpeed 0.40 //[0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]

#ifdef waterWaving
	uniform int worldTime;
	uniform float frameTimeCounter;
	uniform mat4 gbufferModelView;
	uniform mat4 gbufferModelViewInverse;
	uniform vec3 cameraPosition;

	varying float iswater;
	varying vec3 wpos;

	attribute vec4 mc_Entity;

	const float PI = 3.1415927;
#endif

void main() {
	#ifndef waterWaving
		gl_Position = ftransform();
	#else
		vec4 position = gl_ModelViewMatrix * gl_Vertex;

		vec4 viewpos = gbufferModelViewInverse * position;

		vec3 worldpos = viewpos.xyz + cameraPosition;
		wpos = worldpos;

		float displacement = 0.0;

		if(mc_Entity.x == 10008.0 || mc_Entity.x == 10009.0) {
			iswater = 1.0;
			float fy = fract(worldpos.y + 0.0001);

				float wave = 0.07 * sin(2 * PI * (frameTimeCounter*waterWaveSpeed + worldpos.x /  7.0 + worldpos.z / 13.0))
						+ 0.02 * sin(2 * PI * (frameTimeCounter*(waterWaveSpeed * 0.8) + worldpos.x / 1.0 + worldpos.z /  5.0));

				displacement = clamp(wave, -fy, 1.0-fy);
				viewpos.y += displacement*waterWaveIntensity;
		}

		if (mc_Entity.x == 13010) {
			iswater = 0.8;
		}

		viewpos = gbufferModelView * viewpos;
		gl_Position = gl_ProjectionMatrix * viewpos;
	#endif

	//gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
}