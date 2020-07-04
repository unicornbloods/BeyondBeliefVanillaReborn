#version 120

/* #### Adjustable Variables #### */

#define nightEye
	#define ndeSat 15.0 //[30.0 29.0 28.0 27.0 26.0 25.0 24.0 23.0 22.0 21.0 20.0 19.0 18.0 17.0 16.0 15.0 14.0 13.0 12.0 11.0 10.0 9.0 8.0 7.0 6.0 5.0 4.0 3.0 2.0 1.0]

#define UNDERWATER_REFRACTION
	#define UNDERWATER_REFRACTION_AMOUNT 0.5 //[0.25 0.5 0.75 1.0 1.25 1.5 1.75 2.0 2.25 2.5 2.75 3.0]
	#define UNDERWATER_REFRACTION_ANIMATION_SPEED 1.0 //[0.0 0.25 0.5 0.75 1.0 1.25 1.5 1.75 2.0 2.25 2.5 2.75 3.0]

/* #### Variables #### */

	uniform sampler2D colortex0;
	uniform sampler2D colortex1; // calls matID from buffer 1
	uniform sampler2D depthtex0;

	uniform float frameTimeCounter;

	varying vec2 texcoord;

	uniform int isEyeInWater;
/* #### Functions #### */

#ifdef nightEye
	void getNightDesaturation(inout vec3 color) {
	float weight = ndeSat;

	color = pow(color, vec3(2.2)); // convert from gamma to linear

	float brightness = dot(color, vec3(0.2627, 0.6780, 0.0593));
	float amount = 0.01 / (pow(brightness * weight, 2.0) + 0.01);
	vec3 desatColor = mix(color, vec3(brightness), vec3(0.9)) * vec3(0.2, 1.0, 2.0);

	color = mix(color, desatColor, amount);

	color = pow(color, vec3(1.0 / 2.2)); // convert from linear to gamma
	}
#endif

#ifdef UNDERWATER_REFRACTION
	vec2 UnderwaterRefraction(in vec2 coord) {
		// float matID = texture2D(colortex1, texcoord).x; // we stored it in the first component
		// matID /= 0.1; //back to the original range

		if(isEyeInWater == 1) {
			vec2 refraction = vec2(sin(frameTimeCounter * 1.75 * UNDERWATER_REFRACTION_ANIMATION_SPEED + texcoord.x * 50.0 + texcoord.y * 25.0), cos(frameTimeCounter * 2.5 * UNDERWATER_REFRACTION_ANIMATION_SPEED + texcoord.y * 100.0 + texcoord.x * 25.0));
			return coord + refraction * 0.002 * UNDERWATER_REFRACTION_AMOUNT;
		}
		// if(matID < 1 && matID > 0.4) {
		// 	vec2 refraction = vec2(sin(frameTimeCounter * 1.75 * UNDERWATER_REFRACTION_ANIMATION_SPEED + texcoord.x * 50.0 + texcoord.y * 25.0), cos(frameTimeCounter * 2.5 * UNDERWATER_REFRACTION_ANIMATION_SPEED + texcoord.y * 100.0 + texcoord.x * 25.0));
		// 	return coord + refraction * 0.002 * UNDERWATER_REFRACTION_AMOUNT;
		// }
		return coord;
	}
#endif

/* #### Includes #### */

	#include "/lib/Global/FilmGrain.glsl"

/* #### VoidMain #### */

void main() {
	vec2 coord = texcoord.st;

	#ifdef UNDERWATER_REFRACTION
		coord = UnderwaterRefraction(coord);
	#endif

	vec4 color = vec4(texture2D(colortex0, coord).rgb, 1.0);
	
	#ifdef FGrain
		FilmGrain(color.rgb);
	#endif

	#ifdef nightEye
		getNightDesaturation(color.rgb);
	#endif
	
	gl_FragData[0] = color;
} 
