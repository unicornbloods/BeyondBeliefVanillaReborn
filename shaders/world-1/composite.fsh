#version 120

/* #### Adjustable Variables #### */

#define NetherDarkness 0.8 //[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]

/* #### Variables #### */

	uniform sampler2D gcolor;
	varying vec2 texcoord;

	// for fog
	uniform float near;
	uniform float far;
	uniform sampler2D depthtex0;
	uniform sampler2D gdepthtex;


/* #### Functions #### */

	void darkerShadows(inout vec3 color) {
		float weight = 15;

		color.rgb = pow(color.rgb, vec3(2.2)); // convert from gamma to linear

		float brightness = dot(color.rgb, vec3(0.2627, 0.6780, 0.0593));
		float amount = 0.01 / (pow(brightness * weight, 2.0) + 0.01);

		color = mix(color, color * NetherDarkness, amount);

		color.rgb = pow(color.rgb, vec3(1.0 / 2.2)); // convert from linear to gamma
	}

/* #### Includes #### */

	#include "/lib/Nether/NFog.glsl"

/* #### VoidMain #### */

void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;

	#include "/lib/Nether/NFogVM.glsl"

	darkerShadows(color.rgb);

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}