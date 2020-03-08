#version 120


/* #### Variables #### */

    #define NetherDarkness 0.65//[0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]

    #define lensMonochrome
        #define lMonoRed 133 
        #define lMonoGreen 255
        #define lMonoBlue 243
        #define lMonoAlpha 0.90


    uniform sampler2D colortex0;

    varying vec2 texcoord;

    uniform float aspectRatio;

/* #### Functions #### */

/* #### Includes #### */

    #include "/lib/Nether/NFog.glsl"

    #include "/lib/Global/FilmGrain.glsl"

/* #### VoidMain #### */

    void main() {

        vec4 color = vec4(texture2D(colortex0, texcoord).rgb, 1.0);

        #include "/lib/Global/FinalVoidCommon.glsl"

        #include "/lib/Nether/NFogVM.glsl"

        color.rgb *= NetherDarkness;


        #ifdef lensMonochrome
            float brightness = dot(color.rgb, vec3(0.299, 0.587, 0.114)); // or (color.r + color.g + color.b) / 3
            vec3 tint = vec3(lMonoRed, lMonoGreen, lMonoBlue) / 255; // or vec3(1.0) - vec3(red, green, blue), idk how you want it
            color.rgb = mix(color.rgb, vec3(brightness * tint.r, brightness * tint.g, brightness * tint.b), lMonoAlpha);
        #endif
        
        gl_FragData[0] = vec4(color);
    } 
