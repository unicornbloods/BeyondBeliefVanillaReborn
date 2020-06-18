#version 120

/* #### Adjustable Variables #### */

#define NFOG
	#define NFOGR 205 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define NFOGG 75 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define NFOGB 25 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define NFOGA 123 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define NFOGI 2.2 //[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6.0]
	

#define NetherDarkness 0.8 //[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]

/* #### Variables #### */

	uniform sampler2D gcolor;
	varying vec2 texcoord;

	// for fog
	uniform float near;
	uniform float far;
	uniform sampler2D depthtex0;
	uniform sampler2D depthtex1;
	uniform sampler2D gdepthtex;
	uniform mat4 gbufferProjectionInverse; 

	uniform int isEyeInWater;


/* #### Functions #### */

	void darkerShadows(inout vec3 color) {
		float weight = 15;

		color.rgb = pow(color.rgb, vec3(2.2)); // convert from gamma to linear

		float brightness = dot(color.rgb, vec3(0.2627, 0.6780, 0.0593));
		float amount = 0.01 / (pow(brightness * weight, 2.0) + 0.01);

		color = mix(color, color * NetherDarkness, amount);

		color.rgb = pow(color.rgb, vec3(1.0 / 2.2)); // convert from linear to gamma
	}

	float GetDepthLinear(in vec2 coord) { //Function that retrieves the scene depth. 0 - 1, higher values meaning farther away
		return 2.0f * near * far / (far + near - (2.0f * texture2D(gdepthtex, coord).x - 1.0f) * (far - near));
	}

/* #### Includes #### */

/* #### VoidMain #### */

void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;

	#ifdef NFOG

		// for fog
		vec3 screenspace = vec3(texcoord, texture2D(depthtex0, texcoord).r);
		vec4 tmp = gbufferProjectionInverse * vec4(screenspace * 2.0 - 1.0, 1.0);
		vec3 viewPos = tmp.xyz / tmp.w;

		// end for fog

		vec3 fogColor = pow(vec3(NFOGR, NFOGG, NFOGB) / 255.0, vec3(2.2));

		// color.rgb = mix(color.rgb, fogColor, length(viewPos) / (far * NFOGI)); // Proper but doesn't color the sky orange

		color.rgb = mix(color.rgb, fogColor, min(GetDepthLinear(texcoord.st) * NFOGI / far, (NFOGA / 255.0)));

	#endif

	//lava fog
	if(isEyeInWater == 2) {
		vec2 newtc = texcoord.xy;
		float depth = texture2D(depthtex0, newtc).r;

		vec3 fogColor = pow(vec3(195, 87, 0) / 255.0, vec3(2.2));

		color = mix(color, fogColor, min(GetDepthLinear(texcoord.st) * 500.0 / far, 0.955));
	}


	darkerShadows(color.rgb);

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}