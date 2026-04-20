#version 120

uniform sampler2D texture;

varying vec2 texcoord;
varying vec4 glcolor;
uniform vec3 fogColor;

void main() {
    // vec4 color = texture2D(texture, texcoord) * glcolor;

    // Different because Twilight forest handles sky weird.
    vec4 color = vec4(fogColor, 1);
/* DRAWBUFFERS:0 */
    gl_FragData[0] = color; //gcolor
}