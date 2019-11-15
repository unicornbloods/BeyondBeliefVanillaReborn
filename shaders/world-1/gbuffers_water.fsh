#version 120

#define CWATER 1 //[0 1 2 3]
	#define AWATER 230 // [200 205 210 215 220 225 230 235 240 245 250 255]
	#define RWATER 36 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define GWATER 236 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define BWATER 216 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]



uniform sampler2D lightmap;
uniform sampler2D texture;

varying float iswater;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

uniform float aspectRatio;
uniform sampler2D colortex0;


#include "/lib/Tonemaps.glsl"

	const vec2 Bokeh[15] = vec2[15] (
	    vec2(  0.2165,  0.0250 ),
		vec2(  0.0000,  0.1500 ),
		vec2( -0.2165,  0.0250 ),
		vec2( -0.2165, -0.2250 ),
		vec2( -0.0000, -0.3500 ),
		vec2(  0.2165, -0.2250 ),
		vec2(  0.4330,  0.1500 ),
		vec2(  0.0000,  0.6000 ),
		vec2( -0.4330,  0.1500 ),
		vec2( -0.4330, -0.3500 ),
		vec2( -0.0000, -0.6000 ),
		vec2(  0.4330, -0.3500 ),
		vec2(  0.6495,  0.2750 ),
		vec2(  0.0000,  0.6500 ),
		vec2( -0.6495,  0.2750 )
	);

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color *= texture2D(lightmap, lmcoord);
	vec4 bcolor = color;

	

	#ifdef CWATER
		if (iswater > 0.9) {

			#if CWATER == 0
			
			#endif
			#if CWATER == 1
				color = (color * vec4(RWATER, GWATER, BWATER, AWATER ) / 255.0f) * texture2D(lightmap, lmcoord);
			#endif
			#if CWATER == 2
				color = (texture2D(texture, texcoord)* vec4(RWATER, GWATER, BWATER, AWATER ) / 255.0f) * texture2D(lightmap, lmcoord);
			#endif
			#if CWATER == 3 
				color = (vec4(RWATER, GWATER, BWATER, AWATER ) / 255.0f) * texture2D(lightmap, lmcoord);
			#endif



			#if TONEMAP == 1
			color.rgb = color.rgb;
			#endif

			#if TONEMAP == 2
			color.rgb = BOTWTonemap(color.rgb);
			#endif

			#if TONEMAP == 3
			color.rgb = BWTonemap(color.rgb);
			#endif

			#if TONEMAP == 4
			color.rgb = VibrantTonemap(color.rgb);
			#endif

			#if TONEMAP == 5
			color.rgb = NegativeTonemap(color.rgb);
			#endif

			#if TONEMAP == 6
			color.rgb = SpoopyTonemap(color.rgb);
			#endif

			#if TONEMAP == 7
				color.rgb = BSLTonemap(color.rgb);

				color.rgb = colorSaturation(color.rgb);
			#endif
		
			gl_FragData[0] = color;
		} else if (iswater < 0.9) {
			
					#if TONEMAP == 1
			color.rgb = color.rgb;
			#endif

			#if TONEMAP == 2
			color.rgb = BOTWTonemap(color.rgb);
			#endif

			#if TONEMAP == 3
			color.rgb = BWTonemap(color.rgb);
			#endif

			#if TONEMAP == 4
			color.rgb = VibrantTonemap(color.rgb);
			#endif

			#if TONEMAP == 5
			color.rgb = NegativeTonemap(color.rgb);
			#endif

			#if TONEMAP == 6
			color.rgb = SpoopyTonemap(color.rgb);
			#endif

			#if TONEMAP == 7
				color.rgb = BSLTonemap(color.rgb);

				color.rgb = colorSaturation(color.rgb);
			#endif

			gl_FragData[0] = color;
		}
	#endif

	// 			vec2 offsetScale = vec2(1.0, aspectRatio) * 0.05;
	// for(int i = 0; i < 15; i++){
    // 	color.rgb += texture2D(colortex0, texcoord + Bokeh[i] * offsetScale).rgb;
	// }
	// color.rgb /= 15;

/* DRAWBUFFERS:0 */
}
