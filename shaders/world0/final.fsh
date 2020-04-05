#version 120

/* #### Adjustable Variables #### */

	// #define lensMonochrome
		#define lMonoRed 255 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
		#define lMonoGreen 105 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
		#define lMonoBlue 205 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
		#define lMonoAlpha 0.75 //[0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]

/* #### Variables #### */

	uniform sampler2D gcolor;

	varying vec2 texcoord;

/* #### Functions #### */

/* #### Includes #### */

	#include "/lib/Global/Tonemaps.glsl"

/* #### VoidMain #### */

void main() {
	vec3 color = texture2D(gcolor, texcoord).rgb;

	// Tonemapping 

	#if TONEMAP == 2
		color.rgb = BOTWTonemap(color.rgb);
	#elif TONEMAP == 3
		color.rgb = BWTonemap(color.rgb);
	#elif TONEMAP == 4
		color.rgb = NegativeTonemap(color.rgb);
	#elif TONEMAP == 5
		color.rgb = SpoopyTonemap(color.rgb);
	#elif TONEMAP == 6
		color.rgb = BSLTonemap(color.rgb);
		color.rgb = colorSaturation(color.rgb);
	#else
		color.rgb = color.SWIZZLE;
	#endif

	#ifdef lensMonochrome
		float brightness = dot(color.rgb, vec3(0.299, 0.587, 0.114)); // or (color.r + color.g + color.b) / 3
		vec3 tint = vec3(lMonoRed, lMonoGreen, lMonoBlue) / 255; // or vec3(1.0) - vec3(red, green, blue), idk how you want it
		color.rgb = mix(color.rgb, vec3(brightness * tint.r, brightness * tint.g, brightness * tint.b), lMonoAlpha);
	#endif

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}