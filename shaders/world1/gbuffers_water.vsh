#version 120

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

varying float matID;
attribute vec4 mc_Entity;

void main() {
	gl_Position = ftransform();

	matID = 0.0;
	if(mc_Entity.x == 10008) matID = 1.0; // Water
	if(mc_Entity.x == 13010) matID = 2.0; // tranclucents

	//gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
}