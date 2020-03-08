
	float depth = texture2D(depthtex0, newtc).r;
	float depth0 = texture2D(depthtex0, texcoord).x;

	//vec3 skycolor = (vec3(255, 25, 25)) / 255;



	// if (depth0 >= 1.0) {

	// 	color = skycolor;

	// }

	#define SWAMPFOG
	#define LBOFOG //Toggle the land based only fog effect. Will affect clouds and sky with it off based on the intensity.
	


	#ifdef LBOFOG
	if	(depth0 < 1.0) {
	#endif
	
	

		// float FogIntensity = mix(OFOGI, (OFOGI * 10), rainStrength);
		float FogIntensity = OFOGI;
	
		#ifdef OFOG
			vec3 fogcolor = fogColor * mix(fogColor, (vec3(OFOGR, OFOGG, OFOGB) / 255), 0.5);
		#else
			vec3 fogcolor = fogColor * mix(fogColor, (vec3(168, 220, 255)) / 255, 0.5);
		#endif
	
		#ifdef SWAMPFOG
			if(isSwamp != 0.0) {
				FogIntensity =	OFOGI + (OFOGI * 10) * isSwamp;
				fogcolor.g *= 0.8;
				fogcolor.b *= 0.6;
				fogcolor.r *= 0.6;
			}
		#endif

		#ifdef OFOG
			fogcolor = pow(vec3(OFOGR, OFOGG, OFOGB) / 255, vec3(2.2));
		#endif

		color.rgb = mix(color.rgb, fogcolor, min(GetDepthLinear(texcoord.st) * FogIntensity / far, (OFOGA / 255)));

	#ifdef LBOFOG
	}
	#endif
