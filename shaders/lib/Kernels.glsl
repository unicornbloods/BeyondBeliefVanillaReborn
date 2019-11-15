
// Kernels base stolen from Rotartsi

const float offset = 1.0 / 300.0;

vec2 offsets[9] = vec2[](
		vec2(-offset,  offset), // top-left
		vec2( 0.0f,    offset), // top-center
		vec2( offset,  offset), // top-right
		vec2(-offset,  0.0f),   // center-left
		vec2( 0.0f,    0.0f),   // center-center
		vec2( offset,  0.0f),   // center-right
		vec2(-offset, -offset), // bottom-left
		vec2( 0.0f,   -offset), // bottom-center
		vec2( offset, -offset)  // bottom-right
);


  #define kernel_type 0 // [0 1 2]

  #if (kernel_type == 1)
float kernel[9] = float[](
		1, 1, 1,
		1,  -8, 1,
		1, 1, 1
);
#endif

#if (kernel_type == 2)
float kernel[9] = float[](
		-1, -1, -1,
		-1,  9, -1,
		-1, -1, -1
);
#endif