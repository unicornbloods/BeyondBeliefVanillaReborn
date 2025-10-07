
#ifdef fsh
    #ifdef Global
        #define AA 1 //[0 1 2]

        varying vec2 texcoord;

        #ifdef AA
            uniform float aspectRatio;
            uniform float viewWidth;
            uniform float viewHeight;
        #endif

        uniform sampler2D colortex0;

        #if AA == 1
            #include "/lib/antialiasing/fxaa.glsl"
        #endif

        #if AA == 2
            #include "/lib/antialiasing/taa.glsl"
        #endif

        #if AA == 0
            void main() {
                vec3 color = texture2D(colortex0, texcoord.st).rgb;

                /* DRAWBUFFERS:0 */
                gl_FragData[0] = vec4(color, 1.0); //colortex0
            }
        #endif
    #endif
#endif