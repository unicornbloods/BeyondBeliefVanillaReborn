#version 120

#define waterCustom 1 //[0 1 2 3]
	#define waterAlpha 230 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define waterRed 36 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define waterGreen 130 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
	#define waterBlue 185 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]


uniform sampler2D lightmap;
uniform sampler2D texture;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

varying float matID;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color *= texture2D(lightmap, lmcoord);

	if (matID >= 0.1 && matID <= 1.5) {
		#if waterCustom == 1
			color = (color * vec4(waterRed, waterGreen, waterBlue, waterAlpha ) / 255.0f) * texture2D(lightmap, lmcoord);
		#elif waterCustom == 2
			color = (texture2D(texture, texcoord)* vec4(waterRed, waterGreen, waterBlue, waterAlpha ) / 255.0f) * texture2D(lightmap, lmcoord);
		#elif waterCustom == 3 
			color = (vec4(waterRed, waterGreen, waterBlue, waterAlpha ) / 255.0f) * texture2D(lightmap, lmcoord);
		#endif
	}

/* DRAWBUFFERS:01 */
	gl_FragData[0] = color; //gcolor

	// gl_FragData[n] = vec4(matID / 2.0, vec3(anythingElse)); //matID / <Number of matID's in vsh> to bring it down to a range of 0 - 1
	gl_FragData[1] = vec4(matID / 2.0);
}