#version 120

/* #### Adjustable Variables #### */

// #define OFOG
	#define OFOGR 112 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define OFOGG 128 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define OFOGB 144 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define OFOGA 0.77 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define OFOGI 2 //[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6.0]
	#define SWAMPFOG
	#define LBOFOG //Toggle the land based only fog effect. Will affect clouds and sky with it off based on the intensity.
	


#define waterFog
	#define waterAlpha 230 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define waterRed 36 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define waterGreen 130 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define waterBlue 185 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define waterFogDensity 2.00 //[1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6.0 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7.0 7.1 7.2 7.3 7.4 7.5 7.6 7.7 7.8 7.9 8.0]
	#define waterFogDensityAbove 0.070 //Intensifies[0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15]

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
	uniform mat4 gbufferProjectionInverse; 

	// for underwater fog
	uniform int   isEyeInWater;
	uniform sampler2D depthtex1;
	uniform sampler2D colortex1; // calls matID from buffer 1


/* #### Functions #### */

	vec2 newtc = texcoord.xy;

	float GetDepthLinear(in vec2 coord) { //Function that retrieves the scene depth. 0 - 1, higher values meaning farther away
		return 2.0f * near * far / (far + near - (2.0f * texture2D(gdepthtex, coord).x - 1.0f) * (far - near));
	}

	float 	ExpToLinearDepth(in float depth){
		return 2.0f * near * far / (far + near - (2.0f * depth - 1.0f) * (far - near));
	}

	vec3 water_fog(in vec3 color) {
		float depth = ExpToLinearDepth(texture2D(depthtex0, texcoord.st).r )-ExpToLinearDepth( texture2D(depthtex1, texcoord.st).r);

		return mix((vec3(waterRed, waterGreen, waterBlue) / 420 ), color, exp(depth * waterFogDensityAbove));
	}

/* #### Includes #### */

/* #### VoidMain #### */

void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;

	// for fog
	vec3 screenspace = vec3(texcoord, texture2D(depthtex0, texcoord).r);
	vec4 tmp = gbufferProjectionInverse * vec4(screenspace * 2.0 - 1.0, 1.0);
	vec3 viewPos = tmp.xyz / tmp.w;

	// end for fog

	float matID = texture2D(colortex1, texcoord).x; // we stored it in the first component
	matID *= 2.0; //back to the original range
	
	#ifdef waterFog
		if(isEyeInWater == 1) {
			float depth = texture2D(depthtex0, newtc).r;

			// vec3 fogColor = pow(vec3(waterRed, waterGreen, waterBlue) / 255.0, vec3(2.2));

			vec3 WaterColor = (vec3(waterRed, waterGreen, waterBlue) / 420);

			color = mix(color, WaterColor, length(viewPos) * waterFogDensity / far);
			color *= exp(-vec3(1.0, 0.2, 0.1) * depth);
			// color *= (vec3(waterRed, waterGreen, waterBlue) / 255); // makes underwater super dark


		} 

		if(matID >= 0.1 && matID <= 1.5 && isEyeInWater == 0) { // Targetting water
		float depth = texture2D(depthtex0, newtc).r;
			color = mix(color, water_fog(color), 0.85);
			color *= exp(-vec3(1.0, 0.2, 0.1) * depth);
		}

	#endif

	// Main fog

	// float depth = texture2D(depthtex0, newtc).r;
	float depth0 = texture2D(depthtex0, texcoord).x;

	float depth = texture2D(depthtex1, texcoord.xy).x;

	#ifdef LBOFOG
		if	(depth < 1.0 && isEyeInWater == 0) {
	#endif
	
	

		// float FogIntensity = mix(OFOGI, (OFOGI * 10), rainStrength);
		float FogIntensity = OFOGI;
	
		#ifdef OFOG
			vec3 fogcolor = fogColor * mix(fogColor, (vec3(OFOGR, OFOGG, OFOGB) / 255), 0.5);
		#else
			vec3 fogcolor = fogColor;
		#endif
	
		#ifdef SWAMPFOG
			if(isSwamp != 0.0) {
				FogIntensity =	OFOGI + (OFOGI * 10) * isSwamp;
				fogcolor.g *= 0.8;
				fogcolor.b *= 0.6;
				fogcolor.r *= 0.6;
			}
		#endif

		#ifdef OFOG
			fogcolor = pow(vec3(OFOGR, OFOGG, OFOGB) / 255, vec3(2.2));
		#endif

		color.rgb = mix(color.rgb, fogcolor, length(viewPos) / (far * OFOGI));

	#ifdef LBOFOG
		}
	#endif


	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}