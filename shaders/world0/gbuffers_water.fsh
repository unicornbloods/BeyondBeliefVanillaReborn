#version 120

#define CWATER 1 //[0 1 2 3]
	#define AWATER 230 // [200 205 210 215 220 225 230 235 240 245 250 255]
	#define RWATER 36 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define GWATER 236 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define BWATER 216 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]


uniform sampler2D lightmap;
uniform sampler2D texture;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

varying float matID;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color *= texture2D(lightmap, lmcoord);

	if (matID == 1) {
		#if CWATER == 1
			color = (color * vec4(RWATER, GWATER, BWATER, AWATER ) / 255.0f) * texture2D(lightmap, lmcoord);
		#elif CWATER == 2
			color = (texture2D(texture, texcoord)* vec4(RWATER, GWATER, BWATER, AWATER ) / 255.0f) * texture2D(lightmap, lmcoord);
		#elif CWATER == 3 
			color = (vec4(RWATER, GWATER, BWATER, AWATER ) / 255.0f) * texture2D(lightmap, lmcoord);
		#endif
	}

/* DRAWBUFFERS:01 */
	gl_FragData[0] = color; //gcolor

	// gl_FragData[n] = vec4(matID / 2.0, vec3(anythingElse)); //matID / <Number of matID's in vsh> to bring it down to a range of 0 - 1
	gl_FragData[1] = vec4(matID / 2.0);
}