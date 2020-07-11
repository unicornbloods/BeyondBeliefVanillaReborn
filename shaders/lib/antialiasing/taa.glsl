uniform vec3 cameraPosition;
uniform vec3 previousCameraPosition;

uniform mat4 gbufferPreviousProjection;
uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferPreviousModelView;
uniform mat4 gbufferModelViewInverse;

uniform sampler2D colortex2;
uniform sampler2D depthtex1;

//Previous frame reprojection from Chocapic13
vec2 reprojection(vec3 pos){
		vec4 fragpositionPrev = gbufferProjectionInverse * vec4(pos*2.0-1.0,1.);
		fragpositionPrev /= fragpositionPrev.w;
		
		fragpositionPrev = gbufferModelViewInverse * fragpositionPrev;

		vec4 previousPosition = fragpositionPrev + vec4(cameraPosition-previousCameraPosition,0.0)*float(pos.z > 0.56);
		previousPosition = gbufferPreviousModelView * previousPosition;
		previousPosition = gbufferPreviousProjection * previousPosition;
		return previousPosition.xy/previousPosition.w*0.5+0.5;
}

vec3 neighbourhoodClamping(vec3 color, vec3 tempcolor, vec2 view){
	vec3 coltl = texture2DLod(colortex0,texcoord.xy+vec2(-1.0,-1.0)*view,0).rgb;
	vec3 coltm = texture2DLod(colortex0,texcoord.xy+vec2( 0.0,-1.0)*view,0).rgb;
	vec3 coltr = texture2DLod(colortex0,texcoord.xy+vec2( 1.0,-1.0)*view,0).rgb;
	vec3 colml = texture2DLod(colortex0,texcoord.xy+vec2(-1.0, 0.0)*view,0).rgb;
	vec3 colmr = texture2DLod(colortex0,texcoord.xy+vec2( 1.0, 0.0)*view,0).rgb;
	vec3 colbl = texture2DLod(colortex0,texcoord.xy+vec2(-1.0, 1.0)*view,0).rgb;
	vec3 colbm = texture2DLod(colortex0,texcoord.xy+vec2( 0.0, 1.0)*view,0).rgb;
	vec3 colbr = texture2DLod(colortex0,texcoord.xy+vec2( 1.0, 1.0)*view,0).rgb;
	
	vec3 minclr = min(color,min(min(min(coltl,coltm),min(coltr,colml)),min(min(colmr,colbl),min(colbm,colbr))));
	vec3 maxclr = max(color,max(max(max(coltl,coltm),max(coltr,colml)),max(max(colmr,colbl),max(colbm,colbr))));
	
	return clamp(tempcolor,minclr,maxclr);
}

void main(){
	vec3 color = texture2DLod(colortex0,texcoord.xy,0).rgb;

	float temp = texture2DLod(colortex2,texcoord.xy,0).r;
	
	vec2 prvcoord = reprojection(vec3(texcoord.xy,texture2DLod(depthtex1,texcoord.xy,0).r));
	vec2 view = vec2(viewWidth,viewHeight);
	vec3 tempcolor = neighbourhoodClamping(color,texture2DLod(colortex2,prvcoord.xy,0).gba,1.0/view);
	
	vec2 velocity = (texcoord.xy-prvcoord.xy)*view;
	float blendfactor = float(prvcoord.x > 0.0 && prvcoord.x < 1.0 && prvcoord.y > 0.0 && prvcoord.y < 1.0);
	blendfactor *= clamp(1.0-sqrt(length(velocity))/1.999,0.0,1.0)*0.3+0.6;
	
	color = mix(color,tempcolor,blendfactor);
	tempcolor = color;


/*DRAWBUFFERS:1*/
	gl_FragData[0] = vec4(color,1.0);
/*DRAWBUFFERS:12*/
	gl_FragData[1] = vec4(temp,tempcolor);
}