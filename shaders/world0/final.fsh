#version 120
/////////ADJUSTABLE VARIABLES//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////ADJUSTABLE VARIABLES//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define FGrain	
	#define FGStrength 0.08

#define UNDERWATER_REFRACTION
	#define UNDERWATER_REFRACTION_AMOUNT 1.0 //[0.25 0.5 0.75 1.0 1.25 1.5 1.75 2.0 2.25 2.5 2.75 3.0]
	#define UNDERWATER_REFRACTION_ANIMATION_SPEED 1.0 //[0.0 0.25 0.5 0.75 1.0 1.25 1.5 1.75 2.0 2.25 2.5 2.75 3.0]

#define About 0 //[0]

	/////////INTERNAL VARIABLES////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////INTERNAL VARIABLES////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
const int colortex0Format = RGBA16F;
const int colortex1Format = RGBA16F;
*/

uniform sampler2D colortex0;

varying vec2 texcoord;

uniform float frameTimeCounter;

uniform int   isEyeInWater;

/////////////////////////FUNCTIONS/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////FUNCTIONS//////////////////////////////////////////////////////////////////////////////////

/*#include "/lib/LensFlares.glsl"*/

float randFilmGrain(in vec2 refcoord) { //just a noise function, calculates noise based on the given coord
    return fract(sin(dot(refcoord.st, vec2(12.9898, 78.233))) * 43758.5453);
}

void FilmGrain(inout vec3 color) {
    float brightness = dot(color.rgb, vec3(0.2627, 0.6780, 0.0593)); //gets brightness of screen
    float strength = FGStrength * (1.0 - brightness * 1.9); //applies brightness to strength
    vec2 refcoord = texcoord.st + frameTimeCounter * 0.01; //makes the texcoord move over time because the offset is frameTimeCounter which changes after every frame multiplied with 0.01 to make it slower than it is by default
    color += vec3(randFilmGrain(refcoord + 0.1), randFilmGrain(refcoord), randFilmGrain(refcoord - 0.1)) * strength; //use the moving texcoord to make the whole noise move and use offsets for the red and blue channel to make the noise colored, without the offset red, green and blue would overlap each other and the noise would be white/gray
}

#ifdef UNDERWATER_REFRACTION
vec2 UnderwaterRefraction(in vec2 coord) {
    if(isEyeInWater == 1) {
        vec2 refraction = vec2(sin(frameTimeCounter * 1.75 * UNDERWATER_REFRACTION_ANIMATION_SPEED + texcoord.x * 50.0 + texcoord.y * 25.0), cos(frameTimeCounter * 2.5 * UNDERWATER_REFRACTION_ANIMATION_SPEED + texcoord.y * 100.0 + texcoord.x * 25.0));
        return coord + refraction * 0.002 * UNDERWATER_REFRACTION_AMOUNT;
    }
    return coord;
}
#endif


	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////MAIN//////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void main() {
	vec2 coord = texcoord.st;

    #ifdef UNDERWATER_REFRACTION
    	coord = UnderwaterRefraction(coord);
    #endif

	vec3 color = texture2D(colortex0, coord).rgb; //always use the "refracted" coord instead of texcoord after the refraction

	// Add new effects below this line

	



	// FilmGrain must come after Underwater Refraction or else the effects don't apply
	#ifdef FGrain 
		FilmGrain(color);
	#endif

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //colortex0
}
