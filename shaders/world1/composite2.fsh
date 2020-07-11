#version 120
#extension GL_ARB_shader_texture_lod : enable

#define AA 1 //[0 1 2]

varying vec2 texcoord;

uniform float aspectRatio;
uniform float viewWidth;
uniform float viewHeight;

uniform sampler2D colortex0;

#if AA == 1
	#include "/lib/antialiasing/fxaa.glsl"
#endif

#if AA == 2
	#include "/lib/antialiasing/taa.glsl"
#endif

#if AA == 0
	void main() {
		vec3 color = texture2D(colortex0, texcoord.st).rgb;

		/* DRAWBUFFERS:0 */
		gl_FragData[0] = vec4(color, 1.0); //colortex0
	}
#endif
