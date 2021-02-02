
#ifdef fsh
	#ifdef Global
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
				color.rgb = BetterColors(color.rgb);
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
	#endif


	#ifdef Nether
		/* #### Adjustable Variables #### */

			//#define lensMonochrome
				#define lMonoRed 255 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
				#define lMonoGreen 105 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
				#define lMonoBlue 205 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
				#define lMonoAlpha 0.75 //[0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]

			#define NETHER_REFRACTION
				#define NETHER_REFRACTION_AMOUNT 0.25 ///[0.0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1.0 1.25 1.5 1.75 2.0 2.25 2.5 2.75 3.0]
				#define NETHER_REFRACTION_ANIMATION_SPEED 0.75 //[0.0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1.0 1.25 1.5 1.75 2.0 2.25 2.5 2.75 3.0]

		/* #### Variables #### */

			uniform sampler2D colortex0;

			varying vec2 texcoord;

			#ifdef NETHER_REFRACTION
				uniform float frameTimeCounter;

				uniform float aspectRatio;
			#endif
		/* #### Functions #### */

			#ifdef NETHER_REFRACTION
				vec2 NetherRefraction(in vec2 coord) {
					vec2 refraction = vec2(sin(frameTimeCounter * 1.75 * NETHER_REFRACTION_ANIMATION_SPEED + texcoord.x * 50.0 + texcoord.y * 25.0), cos(frameTimeCounter * 2.5 * NETHER_REFRACTION_ANIMATION_SPEED + texcoord.y * 100.0 + texcoord.x * 25.0));
					return coord + refraction * 0.002 * NETHER_REFRACTION_AMOUNT;
					return coord;
				}
			#endif

		/* #### Includes #### */

			#include "/lib/Global/Tonemaps.glsl"

		/* #### VoidMain #### */

			void main() {

				vec2 coord = texcoord.st;

				#ifdef NETHER_REFRACTION
					coord = NetherRefraction(coord);
				#endif

				vec4 color = vec4(texture2D(colortex0, coord).rgb, 1.0); //always use the "refracted" coord instead of texcoord after the refraction

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
					color.rgb = BetterColors(color.rgb);
					color.rgb = color.SWIZZLE;
				#endif

				#ifdef lensMonochrome
					float brightness = dot(color.rgb, vec3(0.299, 0.587, 0.114)); // or (color.r + color.g + color.b) / 3
					vec3 tint = vec3(lMonoRed, lMonoGreen, lMonoBlue) / 255; // or vec3(1.0) - vec3(red, green, blue), idk how you want it
					color.rgb = mix(color.rgb, vec3(brightness * tint.r, brightness * tint.g, brightness * tint.b), lMonoAlpha);
				#endif
				
				gl_FragData[0] = vec4(color);
			}
	#endif
#endif