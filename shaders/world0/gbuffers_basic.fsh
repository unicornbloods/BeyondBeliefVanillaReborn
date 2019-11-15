#version 120

//#define CSBOX //Customize the color of your block selection box. Enabling will also change leads to the selected color Sadly this is unavoidable.
	#define CSR 0 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define CSG 0 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]
	#define CSB 0 //[0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 255]

uniform sampler2D lightmap;
uniform sampler2D texture;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

void main() {

#ifdef CSBOX
vec3 color = vec3(CSR, CSG, CSB) / 255;
	/* DRAWBUFFERS:0 */
		gl_FragData[0] = vec4(color, 1.0);

#endif

#ifndef CSBOX
	vec4 color = texture2D(lightmap, lmcoord) * glcolor;
	//color *= texture2D(lightmap, lmcoord);

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //colortex0

#endif

			gl_FragData[1] = vec4(0.0);
}
