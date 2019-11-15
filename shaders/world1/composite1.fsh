#version 120


//////////////////////////////////////////////////////////////////////////////////
/////////DOF File, Credit to Sildur for dof base./////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

//#define Depth_of_Field			//Simulates eye focusing on objects. Low performance impact
//	#define Distance_Blur			//Requires Depth of Field to be enabled. Replaces eye focusing effect with distance being blurred instead.
	#define DoF_Strength 90			//[60 90 120 150]
	#define Dof_Distance_View 256	//[128 256 384 512]
	#define DOF_FOCAL 0.011 //[0.014 0.024 0.034]

  varying vec2 texcoord;
  varying vec4 color;

  uniform sampler2D texture;


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

#ifdef Depth_of_Field
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
	float focus = ld(texture2D(depthtex0, vec2(0.5)).r)*far;
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

  float depth0 = texture2D(depthtex0, texcoord.xy).x;
  float depth1 = texture2D(depthtex1, texcoord.xy).x;
  float depth2 = texture2D(depthtex2, texcoord.xy).x;
  bool hand = depth0 < depth2;
  if(depth0 < depth1 || !hand){
  	#ifdef Depth_of_Field
  		tex.rgb = calcDof(tex.rgb, depth0, depth1);
  	#endif
  }

    gl_FragData[0] = tex;

}
