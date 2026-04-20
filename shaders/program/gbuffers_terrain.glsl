#ifdef Global

#include "/lib/rple.glsl"

#ifdef fsh

    //#define Whiteworld

    uniform sampler2D texture;

    varying float isDirt;
    varying float isLava;

    varying vec2 randCoord;
    varying vec2 texcoord;
    varying vec4 glcolor;

    const int noiseTextureResolution = 64;
    const float invNoiseRes = 1.0 / float(noiseTextureResolution);


    void main() {
        vec4 blockLightColor = blockLight();

        vec4 color = glcolor * texture2D(texture, texcoord);
        #ifdef Whiteworld
            color.rgb = vec3(1); // Whiteworld
        #endif
        color *= blockLightColor;

    /* DRAWBUFFERS:02 */
        gl_FragData[0] = color; //colortex0

        gl_FragData[2] = vec4(getLightMapCoordinates(), 0.0, 1.0);
    }
#endif

#ifdef vsh
    #define wavingFoliage
    #define wavingSpeed 0.40//[0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75]
    #define wavingIntensity 0.6//[0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]

    #define wavingLeaves //This option can cause performance hits in large forests.

    varying vec2 texcoord;
    varying vec4 glcolor;

    #ifdef wavingFoliage
        attribute vec3 mc_Entity;
        attribute vec2 mc_midTexCoord;

        uniform int worldTime;

        uniform float rainStrength;
        uniform float wetness;
        uniform float night;
        uniform sampler2D noisetex;
        uniform float frameTimeCounter;
        uniform mat4 gbufferModelView;
        uniform mat4 gbufferModelViewInverse;
        uniform vec3 cameraPosition;

        const int noiseTextureResolution = 64;
        const float invNoiseRes = 1.0 / float(noiseTextureResolution);

        float lengthSquared2(vec2 v) { return dot(v, v); }

        float approxScaledCos(float x) { //x from 0 to 1, y from -1 to 1
            x = abs(fract(x) * 2.0 - 1.0);
            return x * x * (6.0 - 4.0 * x) - 1.0;
            //x = fract(x);
            //if (x <= 0.5) return -16.0 * x * x + 8.0 * x;
            //else return 16.0 * x * x - 24.0 * x + 8.0;
        }

        vec3 windOffset(vec3 pos, float multiplier, float speed) {
            float baseWindAmt = min(rainStrength, wetness) * 1.5 + (pos.y / 192.0 + 0.66666666) * (1.0 - night * 0.5); //1.0x at y=64, 2.0x at y=256, and rain increases this to 2.5x at y=64 and 3.5x at y=256. Rain also increases it by 1.5x, and night decreases it to 0.5x.
            vec3 waveStart = texture2D(noisetex, vec2(pos.x + frameTimeCounter, pos.z) * 0.375 * invNoiseRes).rgb; //oscillation direction and phase offset
            float waveMultiplier = texture2D(noisetex, vec2(pos.x * 0.125 + frameTimeCounter * 0.5, pos.z * 0.125) * invNoiseRes).r * 0.5 + 0.5; //multiplier to add variety
            vec2 offset = vec2(waveStart.y * 0.4 - 0.2, waveStart.z * 0.2 - 0.1) * approxScaledCos(waveStart.x + frameTimeCounter * speed) * waveMultiplier; //combine to get position offset
            offset.x -= baseWindAmt * 0.01 + 0.02; //biased towards east wind
            offset *= multiplier * baseWindAmt; //scale offset
            return vec3(offset.x, 0.5 / (lengthSquared2(offset) + 0.5) - 1.0, offset.y); //move vertexes down some based on how much they were offset
        }
    #endif

    void main() {

        bool isGrass = false;

        gl_Position = ftransform();
        texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
        setLightMapCoordinates();

        glcolor = gl_Color;

        #ifdef wavingFoliage
            vec4 pos = gbufferModelViewInverse * (gl_ModelViewMatrix * gl_Vertex); //chunk coords -> world coords

            vec3 normal;
            if (mc_Entity.x > 10000.0) {
                int id = int(mc_Entity.x) - 10000;
                if (id == 1) { //grass blocks and dirt
                    normal = gl_NormalMatrix * gl_Normal;
                } else if (id == 2) { //tallgrass and other plants
                    normal = gl_NormalMatrix[1];

                    float amt = float(texcoord.y < mc_midTexCoord.y);

                    if (amt > 0.1) { //will always either be 0.0 or 1.0
                        pos.xyz += windOffset(pos.xyz + cameraPosition, amt * wavingIntensity, wavingSpeed);
                    }
                } else if (id == 13) { //leaves
                    normal = gl_NormalMatrix * gl_Normal;

                    #ifdef wavingLeaves
                        pos.xyz += windOffset(pos.xyz + cameraPosition, wavingIntensity, wavingSpeed);
                    #endif
                } else if (id == 3 || id == 4) { //double plants
                    normal = gl_NormalMatrix[1];

                    float amt = (float(texcoord.y < mc_midTexCoord.y) + float(id == 4)) * 0.5;

                    //windSpeed = 0.5;
                    amt *= 1.5;

                    if (amt > 0.1) { //will always either be 0.0, 0.5 or 1.0
                        pos.xyz += windOffset(pos.xyz + cameraPosition, amt * wavingIntensity, wavingSpeed);
                    }
                } else if (id == 5) { //crops
                    normal = gl_NormalMatrix[1];

                    if (texcoord.y < mc_midTexCoord.y) {
                        pos.xyz += windOffset(pos.xyz + cameraPosition, wavingIntensity, wavingSpeed);
                    }
                } else if (id == 6) { //sugar cane and other arbitrarily-tall plants
                    normal = gl_NormalMatrix[1];
                } else if (id == 7) { //cobwebs and other stuff that shouldn't have shadows
                    normal = gl_NormalMatrix[1];
                } else if (id == 13011) {
                    normal = gl_NormalMatrix[1];
                }

                gl_Position = gl_ProjectionMatrix * (gbufferModelView * pos);
            }
        #endif
    }

#endif
#endif