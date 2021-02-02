
#ifdef fsh
	#ifdef Global
		//#define MOTION_BLUR
		#define MOTION_BLUR_NOISE
		#define MOTION_BLUR_STRENGTH 3.0 //[0.5 0.75 1.0 1.25 1.5 1.75 2.0 2.25 2.5 2.75 3.0]

		uniform sampler2D colortex0;
		varying vec4 texcoord;

		#ifdef MOTION_BLUR
			uniform mat4 gbufferProjectionInverse;
			uniform mat4 gbufferPreviousProjection;
			uniform mat4 gbufferModelViewInverse;
			uniform mat4 gbufferPreviousModelView;

			uniform vec3 cameraPosition;
			uniform vec3 previousCameraPosition;

			uniform float frameTime;
			uniform sampler2D depthtex0;


			vec4 getCameraPosition(in vec2 coord) {
				float depth = texture2D(depthtex0, texcoord.st).x;
				vec4 positionNdcSpace = vec4(coord.s * 2.0 - 1.0, coord.t * 2.0 - 1.0, 2.0 * depth - 1.0, 1.0);
				vec4 positionCameraSpace = gbufferProjectionInverse * positionNdcSpace;

				return positionCameraSpace / positionCameraSpace.w;
			}

			vec4 getWorldSpacePosition(in vec2 coord) {
				vec4 cameraPos = getCameraPosition(coord);
				vec4 worldPos = gbufferModelViewInverse * cameraPos;
				worldPos.xyz += cameraPosition;

				return worldPos;
			}

			vec4 worldSpaceToPreviousNdcSpace(in vec4 worldSpacePosition) {
				vec4 previousWorldSpacePosition = worldSpacePosition;
				previousWorldSpacePosition.xyz -= previousCameraPosition;

				vec4 previousNdcSpacePosition = gbufferPreviousModelView * previousWorldSpacePosition;
				previousNdcSpacePosition = gbufferPreviousProjection * previousNdcSpacePosition;
				previousNdcSpacePosition /= previousNdcSpacePosition.w;
				return previousNdcSpacePosition;
			}

			float rand(vec2 coord) {
				return fract(sin(dot(coord, vec2(12.9898, 78.233))) * 43758.5453);
			}

			//////////////////////////////////////////////////////////////////////////////////////////////////
			// Motion Blur implemented using: https://developer.nvidia.com/gpugems/GPUGems3/gpugems3_ch27.html
			const int samples = 5;
			const float maxVel = 0.05;

			vec3 MotionBlur(in vec3 color) {
				float depth = texture2D(depthtex0, texcoord.st).x;
				if(depth < 0.56) { //hand
					return color;
				}

				//get current position in NDC space
				vec4 curPosition = vec4(texcoord.s * 2.0 - 1.0, texcoord.t * 2.0 - 1.0, 2.0 * depth - 1.0, 1.0); 

				//get previous position in NDC space
				vec4 prevPosition = getWorldSpacePosition(texcoord.st);
				prevPosition = worldSpaceToPreviousNdcSpace(prevPosition);

				vec2 vel = clamp((curPosition - prevPosition).st * (1.0 / frameTime) * 0.003, vec2(-maxVel), vec2(maxVel));

				#ifdef MOTION_BLUR_NOISE
					float noise = rand(texcoord.st);
				#else
					float noise = 0.0;
				#endif

				vec3 col = vec3(0.0);
				int fSamples = (samples - 1) / 2;

				for (int i = -fSamples; i <= fSamples; ++i) {
					vec2 coord = texcoord.st + vel * (i + noise) / MOTION_BLUR_STRENGTH;
					col += texture2D(colortex0, coord).xyz; //or however you get your color (just use the coord)
				}

				return col /= samples;
			}
		#endif
		//////////////////////////////////////////////////////////////////////////////////////////////////

		/* DRAWBUFFERS:0 */
		//depending on your input, at least 0

		void main() {
			vec3 color = texture2D(colortex0, texcoord.st).xyz;

			#ifdef MOTION_BLUR
				color = MotionBlur(color);
			#endif

			gl_FragData[0] = vec4(color, 1.0);
		}
	#endif
#endif