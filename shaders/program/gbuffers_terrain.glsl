
#ifdef fsh
	#ifdef Global

		//#define Whiteworld

		uniform sampler2D lightmap;
		uniform sampler2D texture;

		varying float isDirt;
		varying float isLava;
		varying vec2 lmcoord; // 2
		varying vec2 randCoord;
		varying vec2 texcoord;
		varying vec4 glcolor;

		const int noiseTextureResolution = 64;
		const float invNoiseRes = 1.0 / float(noiseTextureResolution);


		void main() {
			vec4 color = texture2D(texture, texcoord) * glcolor;
			#ifdef Whiteworld
				color.rgb = vec3(1); // Whiteworld
			#endif
			color *= texture2D(lightmap, lmcoord);

		/* DRAWBUFFERS:02 */
			gl_FragData[0] = color; //colortex0

			gl_FragData[2] = vec4(lmcoord.xy, 0.0, 1.0);
		}

	#endif
#endif