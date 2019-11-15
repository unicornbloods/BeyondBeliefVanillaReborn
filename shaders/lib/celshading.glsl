
  float pw = 1.0/ viewWidth;
  float ph = 1.0/ viewHeight;

  float edepth(vec2 coord) {
  	return texture2D(depthtex0,coord).z;
  }


  vec3 celshade(vec3 clrr, float iswater) {
      //  if (iswater < 0.9) return clrr;
            //edge detect
            float d = edepth(newtc.xy);
            float dtresh = 1/(far-near)/5000.0;
            vec4 dc = vec4(d,d,d,d);
            vec4 sa;
            vec4 sb;
            sa.x = edepth(newtc.xy + vec2(-pw,-ph)*BORDER);
            sa.y = edepth(newtc.xy + vec2(pw,-ph)*BORDER);
            sa.z = edepth(newtc.xy + vec2(-pw,0.0)*BORDER);
            sa.w = edepth(newtc.xy + vec2(0.0,ph)*BORDER);

            //opposite side samples
            sb.x = edepth(newtc.xy + vec2(pw,ph)*BORDER);
            sb.y = edepth(newtc.xy + vec2(-pw,ph)*BORDER);
            sb.z = edepth(newtc.xy + vec2(pw,0.0)*BORDER);
            sb.w = edepth(newtc.xy + vec2(0.0,-ph)*BORDER);

            vec4 dd = abs(2.0* dc - sa - sb) - dtresh;
            dd = vec4(step(dd.x,0.0),step(dd.y,0.0),step(dd.z,0.0),step(dd.w,0.0));

            float e = clamp(dot(dd,vec4(0.25f,0.25f,0.25f,0.25f)),0.0,1.0);
            return clrr*e;
        }
        vec3 aux = texture2D(gaux1, texcoord.st).rgb;
