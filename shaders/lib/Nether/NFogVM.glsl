#ifdef NFOG
	float depth = texture2D(depthtex0, newtc).r;

	vec3 fogColor = pow(vec3(NFOGR, NFOGG, NFOGB) / 255.0, vec3(2.2));

	color.rgb = mix(color.rgb, fogColor, min(GetDepthLinear(texcoord.st) * NFOGI / far, (NFOGA / 255.0)));

#endif