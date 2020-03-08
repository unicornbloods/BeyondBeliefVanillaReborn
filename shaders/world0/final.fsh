#version 120

/* #### Variables #### */

    #define lensMonochrome
        #define lMonoRed 255 
        #define lMonoGreen 102
        #define lMonoBlue 204
        #define lMonoAlpha 0.75


    uniform sampler2D colortex0;
    uniform vec3 skyColor;
    uniform vec3 fogColor;
    uniform float isSwamp;

    varying vec2 texcoord;

/* #### Functions #### */

/* #### Includes #### */

    #include "/lib/Overworld/OverworldFog.glsl"

    #include "/lib/Global/FilmGrain.glsl"

/* #### VoidMain #### */

    void main() {

        vec4 color = vec4(texture2D(colortex0, texcoord).rgb, 1.0);
        
        #include "/lib/Global/FinalVoidCommon.glsl"

        #include "/lib/Overworld/OverworldFogVM.glsl"


        #ifdef lensMonochrome
            float brightness = dot(color.rgb, vec3(0.299, 0.587, 0.114)); // or (color.r + color.g + color.b) / 3
            vec3 tint = vec3(lMonoRed, lMonoGreen, lMonoBlue) / 255; // or vec3(1.0) - vec3(red, green, blue), idk how you want it
            color.rgb = mix(color.rgb, vec3(brightness * tint.r, brightness * tint.g, brightness * tint.b), lMonoAlpha);
        #endif
        
        gl_FragData[0] = vec4(color);
    } 
