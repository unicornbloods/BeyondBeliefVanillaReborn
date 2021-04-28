
#ifdef fsh
	#ifdef Global
		//////////////////////////////////////////////////////////////////////////////////
		/////////DOF File, Credit to Sildur for dof base./////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////

		// #define Depth_of_Field	//Simulates eye focusing on objects. Low performance impact
			//#define Distance_Blur	//Requires Depth of Field to be enabled. Replaces eye focusing effect with distance being blurred instead.
			#define DoF_Strength 75.0	//[50.0  55.0  60.0  65.0  70.0  75.0  80.0  85.0  90.0  95.0  100.0  105.0  110.0  115.0  120.0  125.0  130.0  135.0  140.0  145.0  150.0]
			#define Dof_Distance_View 128	//[128 192 256 320 384 448 512]
			#define DOF_FOCAL 0.011 //[0.010 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.018 0.019 0.020 0.021 0.022 0.023 0.024 0.025 0.026 0.027 0.028 0.029 0.030 0.031 0.032 0.033 0.034 0.035 0.036 0.037 0.038 0.039 0.040 0.041 0.042 0.043 0.044 0.045 0.046 0.047 0.048 0.049 0.050 0.051 0.052 0.053 0.054 0.055 0.056 0.057 0.058 0.059 0.060 0.061 0.062 0.063 0.064 0.065 0.066 0.067 0.068 0.069 0.070 0.071 0.072 0.073 0.074 0.075 0.076 0.077 0.078 0.079 0.080 0.081 0.082 0.083 0.084 0.085 0.086 0.087 0.088 0.089 0.090 0.091 0.092 0.093 0.094 0.095 0.096 0.097 0.098 0.099 0.100]

		varying vec2 texcoord;
		varying vec4 color;
		uniform sampler2D texture;

		#ifdef Depth_of_Field

			uniform sampler2D depthtex0;	//everything
			uniform sampler2D depthtex1;	//everything but transparency
			uniform sampler2D depthtex2;	//everything but transparency+hand
			uniform float near;
			uniform float far;
			uniform float aspectRatio;
			uniform float viewWidth;
			uniform float rainStrength;
			uniform vec3 cameraPosition;
			uniform vec3 previousCameraPosition;
			uniform mat4 gbufferProjectionInverse;
			uniform mat4 gbufferPreviousProjection;
			uniform mat4 gbufferModelViewInverse;
			uniform mat4 gbufferPreviousModelView;


			//Dof constant values
			const float focal = DOF_FOCAL;
			float aperture = 0.008;
			const float sizemult = DoF_Strength;

			float ld(float depth) {
				return (2.0 * near) / (far + near - depth * (far - near));
			}

			const vec2 hexBokeh[60] = vec2[60] (
				vec2(  0.2165,  0.1250 ),
				vec2(  0.0000,  0.2500 ),
				vec2( -0.2165,  0.1250 ),
				vec2( -0.2165, -0.1250 ),
				vec2( -0.0000, -0.2500 ),
				vec2(  0.2165, -0.1250 ),
				vec2(  0.4330,  0.2500 ),
				vec2(  0.0000,  0.5000 ),
				vec2( -0.4330,  0.2500 ),
				vec2( -0.4330, -0.2500 ),
				vec2( -0.0000, -0.5000 ),
				vec2(  0.4330, -0.2500 ),
				vec2(  0.6495,  0.3750 ),
				vec2(  0.0000,  0.7500 ),
				vec2( -0.6495,  0.3750 ),
				vec2( -0.6495, -0.3750 ),
				vec2( -0.0000, -0.7500 ),
				vec2(  0.6495, -0.3750 ),
				vec2(  0.8660,  0.5000 ),
				vec2(  0.0000,  1.0000 ),
				vec2( -0.8660,  0.5000 ),
				vec2( -0.8660, -0.5000 ),
				vec2( -0.0000, -1.0000 ),
				vec2(  0.8660, -0.5000 ),
				vec2(  0.2163,  0.3754 ),
				vec2( -0.2170,  0.3750 ),
				vec2( -0.4333, -0.0004 ),
				vec2( -0.2163, -0.3754 ),
				vec2(  0.2170, -0.3750 ),
				vec2(  0.4333,  0.0004 ),
				vec2(  0.4328,  0.5004 ),
				vec2( -0.2170,  0.6250 ),
				vec2( -0.6498,  0.1246 ),
				vec2( -0.4328, -0.5004 ),
				vec2(  0.2170, -0.6250 ),
				vec2(  0.6498, -0.1246 ),
				vec2(  0.6493,  0.6254 ),
				vec2( -0.2170,  0.8750 ),
				vec2( -0.8663,  0.2496 ),
				vec2( -0.6493, -0.6254 ),
				vec2(  0.2170, -0.8750 ),
				vec2(  0.8663, -0.2496 ),
				vec2(  0.2160,  0.6259 ),
				vec2( -0.4340,  0.5000 ),
				vec2( -0.6500, -0.1259 ),
				vec2( -0.2160, -0.6259 ),
				vec2(  0.4340, -0.5000 ),
				vec2(  0.6500,  0.1259 ),
				vec2(  0.4325,  0.7509 ),
				vec2( -0.4340,  0.7500 ),
				vec2( -0.8665, -0.0009 ),
				vec2( -0.4325, -0.7509 ),
				vec2(  0.4340, -0.7500 ),
				vec2(  0.8665,  0.0009 ),
				vec2(  0.2158,  0.8763 ),
				vec2( -0.6510,  0.6250 ),
				vec2( -0.8668, -0.2513 ),
				vec2( -0.2158, -0.8763 ),
				vec2(  0.6510, -0.6250 ),
				vec2(  0.8668,  0.2513 )
			);

			vec3 calcDof(vec3 color, float depth0, float depth1){
				float pw = 1.0/ viewWidth;
				float z = ld(depth0)*far;
				float focus = ld(texture2D(depthtex2, vec2(0.5)).r)*far;
				float pcoc = min(abs(aperture * (focal * (z - focus)) / (z * (focus - focal)))*sizemult,pw*15.0);

				#ifdef Distance_Blur
					float getdist = 1-(exp(-pow(ld(depth1)/Dof_Distance_View*far,4.0)*4.0));
					if(depth1 < 1.0-near/far/far)pcoc = getdist*pw*20.0;
				#endif

				for ( int i = 0; i < 9; i++) {
					color += texture2D(texture, texcoord.xy + hexBokeh[i]*pcoc*vec2(1.0,aspectRatio)).rgb;
				}
				
				return color*0.11; //*0.11 = / 9
			}
		#endif

		void main() {
			vec4 tex = texture2D(texture, texcoord.xy)*color;

			#ifdef Depth_of_Field
				float depth0 = texture2D(depthtex0, texcoord.xy).x;
				float depth1 = texture2D(depthtex1, texcoord.xy).x;
				float depth2 = texture2D(depthtex2, texcoord.xy).x;
				bool hand = depth0 < depth2;
				if(depth0 < depth1 || !hand){
						tex.rgb = calcDof(tex.rgb, depth0, depth1);
				}
			#endif

			gl_FragData[0] = tex;

		}
	#endif

	#ifdef Nether
		//////////////////////////////////////////////////////////////////////////////////
		/////////DOF File, Credit to Sildur for dof base./////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////

		// #define NDepth_of_Field	//Simulates eye focusing on objects. Low performance impact
			#define NDistance_Blur	//Requires Depth of Field to be enabled. Replaces eye focusing effect with distance being blurred instead.
			#define NDoF_Strength 50.0	//[50.0  55.0  60.0  65.0  70.0  75.0  80.0  85.0  90.0  95.0  100.0  105.0  110.0  115.0  120.0  125.0  130.0  135.0  140.0  145.0  150.0]
			#define NDof_Distance_View 128	//[128 192 256 320 384 448 512]
			#define NDOF_FOCAL 0.011 //[0.010 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.018 0.019 0.020 0.021 0.022 0.023 0.024 0.025 0.026 0.027 0.028 0.029 0.030 0.031 0.032 0.033 0.034 0.035 0.036 0.037 0.038 0.039 0.040 0.041 0.042 0.043 0.044 0.045 0.046 0.047 0.048 0.049 0.050 0.051 0.052 0.053 0.054 0.055 0.056 0.057 0.058 0.059 0.060 0.061 0.062 0.063 0.064 0.065 0.066 0.067 0.068 0.069 0.070 0.071 0.072 0.073 0.074 0.075 0.076 0.077 0.078 0.079 0.080 0.081 0.082 0.083 0.084 0.085 0.086 0.087 0.088 0.089 0.090 0.091 0.092 0.093 0.094 0.095 0.096 0.097 0.098 0.099 0.100]

		varying vec2 texcoord;
		varying vec4 color;
		uniform sampler2D texture;

		#ifdef NDepth_of_Field

			uniform sampler2D depthtex0;	//everything
			uniform sampler2D depthtex1;	//everything but transparency
			uniform sampler2D depthtex2;	//everything but transparency+hand
			uniform float near;
			uniform float far;
			uniform float aspectRatio;
			uniform float viewWidth;
			uniform float rainStrength;
			uniform vec3 cameraPosition;
			uniform vec3 previousCameraPosition;
			uniform mat4 gbufferProjectionInverse;
			uniform mat4 gbufferPreviousProjection;
			uniform mat4 gbufferModelViewInverse;
			uniform mat4 gbufferPreviousModelView;


			//Dof constant values
			const float focal = NDOF_FOCAL;
			float aperture = 0.008;
			const float sizemult = NDoF_Strength;

			float ld(float depth) {
				return (2.0 * near) / (far + near - depth * (far - near));
			}

			const vec2 hexBokeh[60] = vec2[60] (
				vec2(  0.2165,  0.1250 ),
				vec2(  0.0000,  0.2500 ),
				vec2( -0.2165,  0.1250 ),
				vec2( -0.2165, -0.1250 ),
				vec2( -0.0000, -0.2500 ),
				vec2(  0.2165, -0.1250 ),
				vec2(  0.4330,  0.2500 ),
				vec2(  0.0000,  0.5000 ),
				vec2( -0.4330,  0.2500 ),
				vec2( -0.4330, -0.2500 ),
				vec2( -0.0000, -0.5000 ),
				vec2(  0.4330, -0.2500 ),
				vec2(  0.6495,  0.3750 ),
				vec2(  0.0000,  0.7500 ),
				vec2( -0.6495,  0.3750 ),
				vec2( -0.6495, -0.3750 ),
				vec2( -0.0000, -0.7500 ),
				vec2(  0.6495, -0.3750 ),
				vec2(  0.8660,  0.5000 ),
				vec2(  0.0000,  1.0000 ),
				vec2( -0.8660,  0.5000 ),
				vec2( -0.8660, -0.5000 ),
				vec2( -0.0000, -1.0000 ),
				vec2(  0.8660, -0.5000 ),
				vec2(  0.2163,  0.3754 ),
				vec2( -0.2170,  0.3750 ),
				vec2( -0.4333, -0.0004 ),
				vec2( -0.2163, -0.3754 ),
				vec2(  0.2170, -0.3750 ),
				vec2(  0.4333,  0.0004 ),
				vec2(  0.4328,  0.5004 ),
				vec2( -0.2170,  0.6250 ),
				vec2( -0.6498,  0.1246 ),
				vec2( -0.4328, -0.5004 ),
				vec2(  0.2170, -0.6250 ),
				vec2(  0.6498, -0.1246 ),
				vec2(  0.6493,  0.6254 ),
				vec2( -0.2170,  0.8750 ),
				vec2( -0.8663,  0.2496 ),
				vec2( -0.6493, -0.6254 ),
				vec2(  0.2170, -0.8750 ),
				vec2(  0.8663, -0.2496 ),
				vec2(  0.2160,  0.6259 ),
				vec2( -0.4340,  0.5000 ),
				vec2( -0.6500, -0.1259 ),
				vec2( -0.2160, -0.6259 ),
				vec2(  0.4340, -0.5000 ),
				vec2(  0.6500,  0.1259 ),
				vec2(  0.4325,  0.7509 ),
				vec2( -0.4340,  0.7500 ),
				vec2( -0.8665, -0.0009 ),
				vec2( -0.4325, -0.7509 ),
				vec2(  0.4340, -0.7500 ),
				vec2(  0.8665,  0.0009 ),
				vec2(  0.2158,  0.8763 ),
				vec2( -0.6510,  0.6250 ),
				vec2( -0.8668, -0.2513 ),
				vec2( -0.2158, -0.8763 ),
				vec2(  0.6510, -0.6250 ),
				vec2(  0.8668,  0.2513 )
			);

			vec3 calcDof(vec3 color, float depth0, float depth1){
				float pw = 1.0/ viewWidth;
				float z = ld(depth0)*far;
				float focus = ld(texture2D(depthtex2, vec2(0.5)).r)*far;
				float pcoc = min(abs(aperture * (focal * (z - focus)) / (z * (focus - focal)))*sizemult,pw*15.0);

				#ifdef NDistance_Blur
					float getdist = 1-(exp(-pow(ld(depth1)/NDof_Distance_View*far,4.0)*4.0));
					if(depth1 < 1.0-near/far/far)pcoc = getdist*pw*20.0;
				#endif

				for ( int i = 0; i < 9; i++) {
					color += texture2D(texture, texcoord.xy + hexBokeh[i]*pcoc*vec2(1.0,aspectRatio)).rgb;
				}
				
				return color*0.11; //*0.11 = / 9
			}
		#endif

		void main() {
			vec4 tex = texture2D(texture, texcoord.xy)*color;

			#ifdef NDepth_of_Field
				float depth0 = texture2D(depthtex0, texcoord.xy).x;
				float depth1 = texture2D(depthtex1, texcoord.xy).x;
				float depth2 = texture2D(depthtex2, texcoord.xy).x;
				bool hand = depth0 < depth2;
				if(depth0 < depth1 || !hand){
						tex.rgb = calcDof(tex.rgb, depth0, depth1);
				}
			#endif

			gl_FragData[0] = tex;

		}
	#endif
#endif