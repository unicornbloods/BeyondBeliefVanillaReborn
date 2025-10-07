#ifdef Global

#include "/lib/rple.glsl"

#ifdef fsh
    uniform sampler2D texture;

    varying vec2 texcoord;
    varying vec4 glcolor;

    void main() {
        vec4 blockLightColor = blockLight();
        vec4 color = texture2D(texture, texcoord) * glcolor * blockLightColor;

    /* DRAWBUFFERS:0 */
        gl_FragData[0] = color; //gcolor
    }
#endif

#ifdef vsh
    varying vec2 texcoord;
    varying vec4 glcolor;

    void main() {
        setLightMapCoordinates();
        gl_Position = ftransform();
        texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
        glcolor = gl_Color;
    }
#endif
z
#endif