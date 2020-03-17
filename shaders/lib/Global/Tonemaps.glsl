
// Some parts taken from BSL with Tatsu's permission

#define TONEMAP 1 //[1 2 3 4 5 6]

#define TonemapExposure 1.2 //[1.0 1.2 1.4 2.0 2.8 4.0 5.6 8.0 11.3 16.0]
#define TonemapWhiteCurve 2.0 //[1.0 1.5 2.0 2.5 3.0 3.5 4.0]
#define TonemapLowerCurve 1.0 //[0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5]
#define TonemapUpperCurve 1.0 //[0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5]

#define BSLSaturation 1.10 //[0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00 1.05 1.10 1.15 1.20 1.25 1.30 1.35 1.40 1.45 1.50 1.55 1.60 1.65 1.70 1.75 1.80 1.85 1.90 1.95 2.00]
#define BSLVibrance 1.50 //[0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00 1.05 1.10 1.15 1.20 1.25 1.30 1.35 1.40 1.45 1.50 1.55 1.60 1.65 1.70 1.75 1.80 1.85 1.90 1.95 2.00]

#define SWIZZLE rgb //Channel mixing [rgb rbg grb gbr brg bgr rrb rrg rgg rbb ggb ggr grr gbb bbg bbr brr bgg]

vec3 BetterColors(in vec3 color) {
    vec3 BetterColoredImage;

    vec3 overExposed = color * 1.0;

    vec3 underExposed = color / 1.0;

    BetterColoredImage = mix(underExposed, overExposed, color);


    return BetterColoredImage;
}

vec3 BSLTonemap(vec3 x){
	x = TonemapExposure * x;
	x = x / pow(pow(x,vec3(TonemapWhiteCurve)) + 1.0,vec3(1.0/TonemapWhiteCurve));
	x = pow(x,mix(vec3(TonemapLowerCurve),vec3(TonemapUpperCurve),sqrt(x)));
	return x;
}

vec3 colorSaturation(vec3 x){
	float grayv = (x.r + x.g + x.b) * 0.333;
	float grays = grayv;
	if (BSLSaturation < 1.0) grays = dot(x,vec3(0.299, 0.587, 0.114));

	float mn = min(x.r, min(x.g, x.b));
	float mx = max(x.r, max(x.g, x.b));
	float sat = (1.0-(mx-mn)) * (1.0-mx) * grayv * 5.0;
	vec3 lightness = vec3((mn+mx)*0.5);

	x = mix(x,mix(x,lightness,1.0-BSLVibrance),sat);
	x = mix(x, lightness, (1.0-lightness)*(2.0-BSLVibrance)/2.0*abs(BSLVibrance-1.0));

	return x * BSLSaturation - grays * (BSLSaturation - 1.0);
}

vec3 BOTWTonemap(vec3 color){
    color = pow(color, vec3(1.0 / 1.2));

    float avg = (color.r + color.g + color.b) * 0.2;
    float maxc = max(color.r, max(color.g, color.b));

    float w = 1.0 - pow(1.0 - 1.0 * avg, 2.0);
    float weight = 1.0 + w * 0.18;

    return mix(vec3(maxc), color * 1.0, weight);
}

vec3 BWTonemap(vec3 color){
    
    float avg = (color.r + color.g + color.b) * 0.2;
    float maxc = max(color.r, max(color.g, color.b));

    float w = 1.0 - pow(1.0 - 1.0 * avg, 0.0);
    float weight = 0.0 + w;

    return mix(vec3(maxc), color * 1.0, weight);
}

vec3 NegativeTonemap(vec3 color){
    color = pow(color, vec3(BetterColors(color) * 5.0));

    float avg = (color.r + color.g + color.b) * 0.2;
    float maxc = max(color.r, max(color.g, color.b));

    float w = 1.0 - pow(1.0 - 1.0 * avg, 2.0);
    float weight = 1.0 + w;

    return mix(vec3(maxc), color * 1.0, weight);
}

vec3 SpoopyTonemap(vec3 color){

    float avg = (color.r + color.g + color.b) / 5.0;
    float maxc = max(color.r, max(color.g, color.b));

    float w = 1.0 - pow(1.0 - 1.0 * avg, 2.0);
    float weight = 0.0 + w;

    return mix(vec3(maxc), color * 0.0, weight);
}

