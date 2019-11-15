#ifdef NFOG
	float depth = texture2D(depthtex0, newtc).r;

	//if(land_mask(depth)) {
				vec3 fogColor = pow(vec3(NFOGR, NFOGG, NFOGB) / 255.0, vec3(2.2));

		color = mix(color, fogColor, min(GetDepthLinear(texcoord.st) * NFOGI / far, NFOGA));

	//}

#endif
