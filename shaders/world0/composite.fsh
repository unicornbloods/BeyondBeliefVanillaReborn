#version 120

/* #### Adjustable Variables #### */

/* #### Variables #### */

	uniform sampler2D gcolor;
	varying vec2 texcoord;

	// for fog
	uniform vec3 skyColor;
	uniform vec3 fogColor;
	uniform float isSwamp;
	uniform float near;
	uniform float far;
	uniform sampler2D depthtex0;
	uniform sampler2D gdepthtex;


/* #### Functions #### */

	#include "/lib/Overworld/OverworldFog.glsl"

/* #### Includes #### */

/* #### VoidMain #### */

void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;

	#include "/lib/Overworld/OverworldFogVM.glsl"

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}