#version 120

/* #### Adjustable Variables #### */

#define NetherDarkness 15 //[30.0 29.0 28.0 27.0 26.0 25.0 24.0 23.0 22.0 21.0 20.0 19.0 18.0 17.0 16.0 15.0 14.0 13.0 12.0 11.0 10.0 9.0 8.0 7.0 6.0 5.0 4.0 3.0 2.0 1.0]

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
		float weight = NetherDarkness;

		color.rgb = pow(color.rgb, vec3(2.2)); // convert from gamma to linear

		float brightness = dot(color.rgb, vec3(0.2627, 0.6780, 0.0593));
		float amount = 0.01 / (pow(brightness * weight, 2.0) + 0.01);

		color = mix(color, color * 0.1, amount);

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