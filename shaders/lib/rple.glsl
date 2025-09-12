#ifdef RPLE
	varying vec2 lmcoordRed;
	varying vec2 lmcoordGreen;
	varying vec2 lmcoordBlue;
#else
	varying vec2 lmcoord;
#endif

#ifdef vsh

// Just call this anywhere in void Main()
// Internally sets the light map coordinates into `lmcoordRed`, `lmcoordGreen`, and `lmcoordBlue`.
void setLightMapCoordinates() {
	#ifdef RPLE
		lmcoordRed = (gl_TextureMatrix[1] * gl_MultiTexCoord1).st;
		lmcoordGreen = (gl_TextureMatrix[6] * gl_MultiTexCoord6).st;
		lmcoordBlue = (gl_TextureMatrix[7] * gl_MultiTexCoord7).st;
	#else
		lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).st;
	#endif
}
#endif

#ifdef fsh

#ifdef RPLE
	uniform sampler2D redLightMap;
	uniform sampler2D greenLightMap;
	uniform sampler2D blueLightMap;
#else
	uniform sampler2D lightmap;
#endif

// Use this in addition to texture2D(texture, texcoord) * glcolor.
// I.E. vec4 color = glcolor * blockLightColor * texture2D(texture, texcoord);
// Returns the colored light value of the current block light.
vec4 blockLight() {
	#ifdef RPLE
		vec4 redLight = texture2D(redLightMap, lmcoordRed);
		vec4 greenLight = texture2D(greenLightMap, lmcoordGreen);
		vec4 blueLight = texture2D(blueLightMap, lmcoordBlue);
		return redLight * greenLight * blueLight;
	#else
		return texture2d(lightmap, lmcoord);
	#endif
}

// This replaces lmcoord calls.
// Returns the lightmap coordinates.
vec2 getLightMapCoordinates() {
	#ifdef RPLE
		return max(max(lmcoordRed, lmcoordGreen), lmcoordBlue);
	#else
		return lmcoord;
	#endif
}


#endif