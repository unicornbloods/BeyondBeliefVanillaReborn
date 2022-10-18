#version 120

uniform sampler2D texture;

varying vec2 texcoord;
varying vec4 glcolor;
uniform vec3 fogColor;

void main() {
	// vec4 color = texture2D(texture, texcoord) * glcolor;

	vec4 color = texture2D(texture, texcoord) * glcolor;
/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}