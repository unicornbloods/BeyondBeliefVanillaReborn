#version 120

/* #### Adjustable Variables #### */

//#define OFOG
	#define OFOGR 112 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define OFOGG 128 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define OFOGB 144 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define OFOGA 0.77 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define OFOGI 0.3 //[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6.0]

#define CustomUWF
	#define AWATER 230 // [200 205 210 215 220 225 230 235 240 245 250 255]
	#define RWATER 36 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define GWATER 236 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define BWATER 216 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define UWFI 2.0 //[1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6.0 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7.0 7.1 7.2 7.3 7.4 7.5 7.6 7.7 7.8 7.9 8.0]
	#define UwU 0.07 //Intensifies[0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15]

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

		return mix((vec3(RWATER, GWATER, BWATER) / 420 ), color, exp(depth * UwU));
	}

/* #### Includes #### */

/* #### VoidMain #### */

void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;

	float matID = texture2D(colortex1, texcoord).x; // we stored it in the first component
	matID *= 2.0; //back to the original range
	
	#ifdef CustomUWF
		if(isEyeInWater == 1) {
			float depth = texture2D(depthtex0, newtc).r;

			// vec3 fogColor = pow(vec3(RWATER, GWATER, BWATER) / 255.0, vec3(2.2));

			vec3 WaterColor = (vec3(RWATER, GWATER, BWATER) / 420);

			color = mix(color, WaterColor, min(GetDepthLinear(texcoord.st) * UWFI / far, 0.85));
			// color *= (vec3(RWATER, GWATER, BWATER) / 420);


		} 

		if(matID > 0.9 && matID < 1.5) { // Targetting water
			color = mix(color, water_fog(color), 0.85);
		}

	#endif


	#include "/lib/Overworld/OverworldFogVM.glsl"

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}