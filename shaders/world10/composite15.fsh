#version 120

/* #### Adjustable Variables #### */

	#define nightEye
		#define ndeSat 15.0 //[30.0 29.0 28.0 27.0 26.0 25.0 24.0 23.0 22.0 21.0 20.0 19.0 18.0 17.0 16.0 15.0 14.0 13.0 12.0 11.0 10.0 9.0 8.0 7.0 6.0 5.0 4.0 3.0 2.0 1.0]

/* #### Variables #### */

	uniform sampler2D colortex0;
	uniform sampler2D depthtex0;

	uniform float frameTimeCounter;

	varying vec2 texcoord;

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

/* #### Includes #### */

	#include "/lib/Global/FilmGrain.glsl"

/* #### VoidMain #### */

	void main() {

		vec4 color = vec4(texture2D(colortex0, texcoord).rgb, 1.0);
		
		#ifdef FGrain
			FilmGrain(color.rgb);
		#endif

		#ifdef nightEye
			getNightDesaturation(color.rgb);
		#endif
		
		gl_FragData[0] = color;
	} 
