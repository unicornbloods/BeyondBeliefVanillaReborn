#version 120
/////////ADJUSTABLE VARIABLES//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////ADJUSTABLE VARIABLES//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//#define CELSHADING //
	#define BORDER 1.0

//#define OFOG
	#define OFOGR 112 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define OFOGG 128 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define OFOGB 144 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define OFOGI 0.3 //[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0]
	#define OFOGA 0.77 //[0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.3 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.4 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.5 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.6 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.7 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.8 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.9 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.0]

#define CustomUWF
	#define AWATER 230 // [200 205 210 215 220 225 230 235 240 245 250 255]
	#define RWATER 36 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define GWATER 236 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define BWATER 216 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define UWFI 2.0 //[1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6.0 6.1 6.2 6.3 6.4 6.5 6.6 6.7 6.8 6.9 7.0 7.1 7.2 7.3 7.4 7.5 7.6 7.7 7.8 7.9 8.0]
	#define UwU 0.07 //Intensifies[0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15]

	/////////INTERNAL VARIABLES////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////INTERNAL VARIABLES////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uniform sampler2D colortex0;
uniform int   isEyeInWater;

varying vec2 texcoord;

uniform vec3 skyColor;
uniform vec3 fogColor;
uniform sampler2D gdepthtex;
uniform sampler2D depthtex1;
uniform sampler2D gaux1;
uniform sampler2D depthtex0;
uniform float near;
uniform float far;
uniform float viewWidth;
uniform float viewHeight;
uniform float isSwamp;
uniform float rainStrength;

#define land_mask(x) (x < 1.0)


/////////////////////////FUNCTIONS/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////FUNCTIONS/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

vec2 newtc = texcoord.xy;

float     GetDepthLinear(in vec2 coord) {                    //Function that retrieves the scene depth. 0 - 1, higher values meaning farther away
   return 2.0f * near * far / (far + near - (2.0f * texture2D(gdepthtex, coord).x - 1.0f) * (far - near));
}


float 	ExpToLinearDepth(in float depth)
{
	return 2.0f * near * far / (far + near - (2.0f * depth - 1.0f) * (far - near));
}

vec3 water_fog(in vec3 color) {
                float depth = ExpToLinearDepth(texture2D(depthtex0, texcoord.st).r )-ExpToLinearDepth( texture2D(depthtex1, texcoord.st).r);

                return mix((vec3(RWATER, GWATER, BWATER) / 420 ), color, exp(depth * UwU));
}


  #include "/lib/celshading.glsl"

  #include "/lib/Kernels.glsl"

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////MAIN//////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void main() {
	vec3 color = texture2D(colortex0, texcoord).rgb;

	float iswater = float(aux.g > 0.04 && aux.g < 0.07);

	#ifdef CELSHADING
		color = celshade(color, iswater);
	#endif

#include "/lib/OverworldFog.glsl"

#ifdef CustomUWF
if(isEyeInWater == 1) {
	float depth = texture2D(depthtex0, newtc).r;

		// vec3 fogColor = pow(vec3(RWATER, GWATER, BWATER) / 255.0, vec3(2.2));

		vec3 WaterColor = (vec3(RWATER, GWATER, BWATER) / 420);

		color = mix(color, WaterColor, min(GetDepthLinear(texcoord.st) * UWFI / far, 0.85));
		// color *= (vec3(RWATER, GWATER, BWATER) / 420);


} 

	if(iswater < 0.9 && isEyeInWater == 0) {
    color = mix(color, water_fog(color), 0.85);
	}

#endif

//lava fog
if(isEyeInWater == 2) {
	float depth = texture2D(depthtex0, newtc).r;

		vec3 fogColor = pow(vec3(195, 87, 0) / 255.0, vec3(2.2));

		color = mix(color, fogColor, min(GetDepthLinear(texcoord.st) * 500.0 / far, 0.985));
}

/* DRAWBUFFERS:0 */
	//gl_FragData[0] = vec4(color, 1.0); //colortex0

	#if (kernel_type == 0)

		gl_FragData[0] = vec4(color, 1.0); //colortex0

		#else

    vec3 sampleTex[9];
    for(int i = 0; i < 9; i++)
    {
        sampleTex[i] = vec3(texture2D(colortex0, texcoord.st + offsets[i]));
    }
    vec3 col = vec3(0.0);
    for(int i = 0; i < 9; i++)
        col += sampleTex[i] * kernel[i];

		

    gl_FragData[0] = vec4(col, 1.0);

		#endif

	gl_FragData[1] = vec4(1.0);
}
