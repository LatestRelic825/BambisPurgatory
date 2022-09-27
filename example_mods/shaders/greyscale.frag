#pragma header

uniform float iStrength;
                                                                        
void main()                                                             
{
    float intensity = iStrength;
    if (intensity > 1.0) {
        intensity = 1.0;
    }
    if (intensity < 0.0) {
        intensity = 0.0;
    }
    vec4 toUse=texture2D(bitmap,openfl_TextureCoordv);
    float grey = (toUse.r + toUse.g + toUse.b) / 3;
    toUse.r=(toUse.r*(1.0-iStrength) + grey*(iStrength));
    toUse.g=(toUse.g*(1.0-iStrength) + grey*(iStrength));
    toUse.b=(toUse.b*(1.0-iStrength) + grey*(iStrength));
    
    gl_FragColor=toUse;
}   