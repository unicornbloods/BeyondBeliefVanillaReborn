#define FGrain	
	#define FGStrength 0.035

float depth0 = texture2D(depthtex0, texcoord).x;

#ifdef FGrain
	float randFilmGrain(in vec2 refcoord) { //just a noise function, calculates noise based on the given coord
		return fract(sin(dot(refcoord.st, vec2(12.9898, 78.233))) * 43758.5453);
	}


	void FilmGrain(inout vec3 color) {
		if	(depth0 < 1.0) {
		float brightness = dot(color.rgb, vec3(0.2627, 0.6780, 0.0593)); //gets brightness of screen
		float strength = FGStrength * (1.0 - brightness * 1.9); //applies brightness to strength
		
		if (strength >= 0) {
			vec2 refcoord = texcoord.st + frameTimeCounter * 0.01; //makes the texcoord move over time because the offset is frameTimeCounter which changes after every frame multiplied with 0.01 to make it slower than it is by default
			color += vec3(randFilmGrain(refcoord + 0.1), randFilmGrain(refcoord), randFilmGrain(refcoord - 0.1)) * strength; //use the moving texcoord to make the whole noise move and use offsets for the red and blue channel to make the noise colored, without the offset red, green and blue would overlap each other and the noise would be white/gray
		} else {
			color = color;
		}
		}
	}
#endif