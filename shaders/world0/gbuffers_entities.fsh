#version 120

uniform sampler2D lightmap;
uniform sampler2D texture;

uniform vec4 entityColor;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color *= texture2D(lightmap, lmcoord);

	if(entityColor.a > 0) color.r *= 1.5;

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}