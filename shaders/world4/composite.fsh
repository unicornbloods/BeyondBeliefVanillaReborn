#version 120

/* #### Adjustable Variables #### */

// 0 = vanilla, 1 = custom
#define OFOG 0 //[0 1]
	#define OFOGR 112 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define OFOGG 128 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define OFOGB 144 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define OFOGI 1.7 //[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6.0 10.0]
	#define SWAMPFOG
	#define LBOFOG //Toggle the land based only fog effect. Will affect clouds and sky with it off based on the intensity.
	

// 0 = vanilla, 1 = custom
#define waterFog 0 //[0 1]
	#define waterAlpha 230 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define waterRed 36 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define waterGreen 130 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define waterBlue 185 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define waterFogDensity 1.00 //[1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6.0 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7.0 7.1 7.2 7.3 7.4 7.5 7.6 7.7 7.8 7.9 8.0]
	#define waterFogDensityAbove 0.070 //Intensifies[0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15]

/* #### Variables #### */

	uniform sampler2D colortex0;
	varying vec2 texcoord;


	// for fog
	uniform vec3 skyColor;
	uniform vec3 fogColor;
	uniform float isSwamp;
	uniform float near;
	uniform float far;
	uniform sampler2D depthtex0;
	uniform sampler2D gdepthtex;
	uniform mat4 gbufferProjectionInverse; 

	// for underwater fog
	uniform int   isEyeInWater;
	uniform sampler2D depthtex1;
	uniform sampler2D colortex1; // calls matID from buffer 1
	uniform sampler2D colortex2; // calls lmcoord from buffer 2


/* #### Functions #### */

	vec2 newtc = texcoord.xy;

	float GetDepthLinear(in vec2 coord) { //Function that retrieves the scene depth. 0 - 1, higher values meaning farther away
		return 2.0f * near * far / (far + near - (2.0f * texture2D(gdepthtex, coord).x - 1.0f) * (far - near));
	}

	float 	ExpToLinearDepth(in float depth){
		return 2.0f * near * far / (far + near - (2.0f * depth - 1.0f) * (far - near));
	}

/* #### Includes #### */

/* #### VoidMain #### */

void main() {
	vec3 color = texture2D(colortex0, texcoord).rgb;

	// for fog
	vec3 screenspace = vec3(texcoord, texture2D(depthtex0, texcoord).r);
	vec4 tmp = gbufferProjectionInverse * vec4(screenspace * 2.0 - 1.0, 1.0);
	vec3 viewPos = tmp.xyz / tmp.w;
	// end for fog

	float matID = texture2D(colortex1, texcoord).x; // we stored it in the first component
	matID *= 2.0; //back to the original range

	float depth = texture2D(depthtex0, newtc).r;
	#ifdef waterFog
		if(isEyeInWater == 1) { // Underwater

			#if waterFog == 0
				vec3 WaterColor = fogColor;
			#else
				vec3 WaterColor = (vec3(waterRed, waterGreen, waterBlue) / 420);
			#endif

			color *= exp(-vec3(1.0, 0.2, 0.1) * depth);
			color = mix(color, WaterColor, length(viewPos) * waterFogDensity / far);

		}

		if(matID > 0.9 && matID < 1.5 && isEyeInWater == 0) { // Targetting water
			color *= exp(-vec3(1.0, 0.2, 0.1) * depth);

		}

	#endif

	// Main fog

	float depth0 = texture2D(depthtex0, texcoord).x;

	depth = texture2D(depthtex1, texcoord.xy).x;

	#ifdef LBOFOG
		if	(depth < 1.0) {
	#endif
			if (isEyeInWater == 0) { // Above water

				// float FogIntensity = mix(OFOGI, (OFOGI * 10), rainStrength);
				float FogIntensity = OFOGI;
			
				#if OFOG == 1
					vec3 fogcolor = fogColor * mix(fogColor, (vec3(OFOGR, OFOGG, OFOGB) / 255), 0.5);
				#else
					vec3 fogcolor = fogColor;
				#endif
			
				color.rgb = mix(color.rgb, fogcolor, length(viewPos) / (far * OFOGI));
				color.rgb -= near;
			}
	#ifdef LBOFOG
		}
	#endif

	//lava fog
	if(isEyeInWater == 2) {
		float depth = texture2D(depthtex0, newtc).r;

		vec3 fogColor = pow(vec3(195, 87, 0) / 255.0, vec3(2.2));

		color = mix(color, fogColor, min(GetDepthLinear(texcoord.st) * 500.0 / far, 0.955));
	}

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}