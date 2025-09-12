#ifdef Global

#include "/lib/rple.glsl"

#ifdef fsh

    #define waterCustom 1 //[0 1 2 3]
        #define waterAlpha 230 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
        #define waterRed 36 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
        #define waterGreen 130 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]
        #define waterBlue 185 //[0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0 155.0 160.0 165.0 170.0 175.0 180.0 185.0 190.0 195.0 200.0 205.0 210.0 215.0 220.0 225.0 230.0 235.0 240.0 245.0 250.0 255.0]

    uniform sampler2D texture;

    varying vec2 texcoord;
    varying vec4 glcolor;

    // Being passed through buffer
    varying float matID; // 1

    void main() {
        vec4 blockLightColor = blockLight();

        vec4 color = glcolor * texture2D(texture, texcoord);
        color *= blockLightColor;

        if (matID >= 0.1 && matID <= 1.5) {
            #if waterCustom == 1
                color = (color * vec4(waterRed, waterGreen, waterBlue, waterAlpha ) / 255.0f);
            #elif waterCustom == 2
                color = (texture2D(texture, texcoord)* vec4(waterRed, waterGreen, waterBlue, waterAlpha ) / 255.0f) * texture2D(lightmap, lmcoord);
            #elif waterCustom == 3
                color = (vec4(waterRed, waterGreen, waterBlue, waterAlpha ) / 255.0f) * texture2D(lightmap, lmcoord);
            #endif
        }

    /* DRAWBUFFERS:012 */
        gl_FragData[0] = color; //gcolor

        // gl_FragData[n] = vec4(matID / 2.0, vec3(anythingElse)); //matID / <Number of matID's in vsh> to bring it down to a range of 0 - 1
        gl_FragData[1] = vec4(matID * 0.5);

        gl_FragData[2] = vec4(getLightMapCoordinates(), 0.0, 1.0);
    }
#endif

#ifdef vsh
    #define waterWaving
        #define waterWaveIntensity 0.50 //Will look broken over 1.45[0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00 1.05 1.10 1.15 1.20 1.25 1.30 1.35 1.40 1.45 1.50 1.55 1.60 1.65 1.70 1.75 1.80 1.85 1.90 1.95 2.00]
        #define waterWaveSpeed 0.40 //[0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]

    varying vec2 texcoord;
    varying vec4 glcolor;

    varying float matID;
    attribute vec4 mc_Entity;

    #ifdef waterWaving
        uniform int worldTime;
        uniform float frameTimeCounter;
        uniform mat4 gbufferModelView;
        uniform mat4 gbufferModelViewInverse;
        uniform vec3 cameraPosition;

        varying vec3 wpos;

        const float PI = 3.1415927;
    #endif

    void main() {
        setLightMapCoordinates();

        matID = 0.0;
        if(mc_Entity.x == 10008) matID = 1.0; // Water
        if(mc_Entity.x == 13010) matID = 2.0; // tranclucents

        #ifndef waterWaving
            gl_Position = ftransform();
        #else
            vec4 position = gl_ModelViewMatrix * gl_Vertex;

            vec4 viewpos = gbufferModelViewInverse * position;

            vec3 worldpos = viewpos.xyz + cameraPosition;
            wpos = worldpos;

            float displacement = 0.0;

            if(matID == 1.0) {
                float fy = fract(worldpos.y + 0.0001);

                float wave = 0.07 * sin(2 * PI * (frameTimeCounter*waterWaveSpeed + worldpos.x /  7.0 + worldpos.z / 13.0))
                + 0.02 * sin(2 * PI * (frameTimeCounter*(waterWaveSpeed * 0.8) + worldpos.x / 1.0 + worldpos.z /  5.0));

                displacement = clamp(wave, -fy, 1.0-fy);
                viewpos.y += displacement*waterWaveIntensity;
            }

            viewpos = gbufferModelView * viewpos;
            gl_Position = gl_ProjectionMatrix * viewpos;
        #endif

        //gl_Position = ftransform();
        texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
        glcolor = gl_Color;
    }
#endif

#endif