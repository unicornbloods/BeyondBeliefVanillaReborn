#version 120

uniform sampler2D texture;

varying vec2 texcoord;
varying vec4 glcolor;
uniform vec3 fogColor;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;

	if(color.r < 0.1) {
		// Different because Lotr handles sky weird.
		color.a = 0;
	}
	
/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}