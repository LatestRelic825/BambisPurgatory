//SHADERTOY PORT FIX
#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main
//SHADERTOY PORT FIX
uniform float Pixelly;

void main()
{
    vec2 uv = fragCoord/iResolution.xy;

    uv = floor(uv*iResolution.x*Pixelly)/(iResolution.x*Pixelly);

    fragColor = texture(iChannel0, uv);
}