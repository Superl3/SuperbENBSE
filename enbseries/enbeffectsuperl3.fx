//#include "Reforged/ReforgedUITutorial.fxh"

int		TonemapStart < string UIName = "-------<<< Superl3 ENB >>>-------"; string UIWidget = "spinner"; int UIMin = 0; int UIMax = 0; > = { 0.0 };
int		strExtDay < string UIName = "--------| Exterior Day |--------"; string UIWidget = "spinner"; int UIMin = 0; int UIMax = 0; > = { 0.0 };
float	ExtDayBrightness
<
	string UIName = "ED: Brightness";
	string UIWidget = "Spinner";
	float UIMin = 1;
	float UIMax = 100;
> = { 1 };
float	ExtDaySaturation
<
	string UIName = "ED: Saturation";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 2.0;
> = { 1.0 };
float	ExtDayAdaptationMax
<
	string UIName = "ED: AdaptationMax";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 5.00;
> = { 1 };
float	ExtDayAdaptationMin
<
	string UIName = "ED: AdaptationMin";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 5.00;
> = { 1 };
float	ExtDayContrast
<
	string UIName = "ED: Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.1;
	float UIMax = 5.0;
> = { 1.0 };
float	ExtDayLinearSectionStart
<
	string UIName = "ED: LinearStart";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 1.00;
> = { 0.22 };
float	ExtDayLinearSectionLength
<
	string UIName = "ED: LinearLength";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 1.00;
> = { 0.4 };
float	ExtDayBlack
<
	string UIName = "ED: Black";
	string UIWidget = "Spinner";
	float UIMin = 1.00;
	float UIMax = 3.00;
> = { 1.33 };
float	ExtDayPedestal
<
	string UIName = "ED: Pedestal";
	string UIWidget = "Spinner";
	float UIMin = 0.00;
	float UIMax = 1.00;
> = { 0.0 };

int		strExtNight < string UIName = "--------| Exterior Night |--------"; string UIWidget = "spinner"; int UIMin = 0; int UIMax = 0; > = { 0.0 };

float	ExtNightBrightness
<
	string UIName = "EN: Brightness";
	string UIWidget = "Spinner";
	float UIMin = 1;
	float UIMax = 100;
> = { 1 };
float	ExtNightSaturation
<
	string UIName = "EN: Saturation";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 2.0;
> = { 1.0 };
float	ExtNightAdaptationMax
<
	string UIName = "EN: AdaptationMax";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 5.00;
> = { 1 };
float	ExtNightAdaptationMin
<
	string UIName = "EN: AdaptationMin";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 5.00;
> = { 1 };
float	ExtNightContrast
<
	string UIName = "EN: Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.1;
	float UIMax = 5.0;
> = { 1.0 };
float	ExtNightLinearSectionStart
<
	string UIName = "EN: LinearStart";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 1.00;
> = { 0.22 };
float	ExtNightLinearSectionLength
<
	string UIName = "EN: LinearLength";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 1.00;
> = { 0.4 };
float	ExtNightBlack
<
	string UIName = "EN: Black";
	string UIWidget = "Spinner";
	float UIMin = 1.00;
	float UIMax = 3.00;
> = { 1.33 };
float	ExtNightPedestal
<
	string UIName = "EN: Pedestal";
	string UIWidget = "Spinner";
	float UIMin = 0.00;
	float UIMax = 1.00;
> = { 0.0 };

int		strInt < string UIName = "--------| Interior |--------"; string UIWidget = "spinner"; int UIMin = 0; int UIMax = 0; > = { 0.0 };

float	IntBrightness
<
	string UIName = "IN: Brightness";
	string UIWidget = "Spinner";
	float UIMin = 1;
	float UIMax = 100;
> = { 1.25 };
float	IntSaturation
<
	string UIName = "IN: Saturation";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 2.0;
> = { 1.15 };
float	IntAdaptationMax
<
	string UIName = "IN: AdaptationMax";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 5.00;
> = { 0.75 };
float	IntAdaptationMin
<
	string UIName = "IN: AdaptationMin";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 5.00;
> = { 0.5 };
float	IntContrast
<
	string UIName = "IN: Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.1;
	float UIMax = 5.0;
> = { 1.0 };
float	IntLinearSectionStart
<
	string UIName = "IN: LinearStart";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 1.00;
> = { 0.27 };
float	IntLinearSectionLength
<
	string UIName = "IN: LinearLength";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 1.00;
> = { 0.5 };
float	IntBlack
<
	string UIName = "IN: Black";
	string UIWidget = "Spinner";
	float UIMin = 1.00;
	float UIMax = 3.00;
> = { 1.15 };
float	IntPedestal
<
	string UIName = "IN: Pedestal";
	string UIWidget = "Spinner";
	float UIMin = 0.00;
	float UIMax = 1.00;
> = { 0.0 };

int		TonemapEnd < string UIName = "----------------------------------"; string UIWidget = "spinner"; int UIMin = 0; int UIMax = 0; > = { 0.0 };

float	Desaturation
<
	string UIName = "Desaturation";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = { 0.7 };
float	HueShift
<
	string UIName = "HueShift";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = { 0.4 };
float	Resaturation
<
	string UIName = "Resaturation";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = { 0.3 };
//changes in range 0..1, 0 means that night time, 1 - day time


#define min3(v) (min(v.x, min(v.y, v.z)))
#define max3(v) (max(v.x, max(v.y, v.z)))
#define remap(v, a, b) (((v) - (a)) / ((b) - (a)))
float rand21(float2 uv)
{
	float2 noise = frac(sin(dot(uv, float2(12.9898, 78.233) * 2.0)) * 43758.5453);
	return (noise.x + noise.y) * 0.5;
}
float rand11(float x) { return frac(x * 0.024390243); }
float permute(float x) { return ((34.0 * x + 1.0) * x) % 289.0; }

#define DITHER_QUALITY_LEVEL 1
#define BIT_DEPTH 10
float3 triDither(float3 color, float2 uv, float timer)
{
	static const float bitstep = pow(2.0, BIT_DEPTH) - 1.0;
	static const float lsb = 1.0 / bitstep;
	static const float lobit = 0.5 / bitstep;
	static const float hibit = (bitstep - 0.5) / bitstep;

	float3 m = float3(uv, rand21(uv + timer)) + 1.0;
	float h = permute(permute(permute(m.x) + m.y) + m.z);

	float3 noise1, noise2;
	noise1.x = rand11(h); h = permute(h);
	noise2.x = rand11(h); h = permute(h);
	noise1.y = rand11(h); h = permute(h);
	noise2.y = rand11(h); h = permute(h);
	noise1.z = rand11(h); h = permute(h);
	noise2.z = rand11(h);

#if DITHER_QUALITY_LEVEL == 1
	float lo = saturate(remap(min3(color.xyz), 0.0, lobit));
	float hi = saturate(remap(max3(color.xyz), 1.0, hibit));
	return lerp(noise1 - 0.5, noise1 - noise2, min(lo, hi)) * lsb;
#elif DITHER_QUALITY_LEVEL == 2
	float3 lo = saturate(remap(color.xyz, 0.0, lobit));
	float3 hi = saturate(remap(color.xyz, 1.0, hibit));
	float3 uni = noise1 - 0.5;
	float3 tri = noise1 - noise2;
	return float3(
		lerp(uni.x, tri.x, min(lo.x, hi.x)),
		lerp(uni.y, tri.y, min(lo.y, hi.y)),
		lerp(uni.z, tri.z, min(lo.z, hi.z))) * lsb;
#endif
}

float3 lin2srgb_fast(float3 v) { return sqrt(v); }
float3 srgb2lin_fast(float3 v) { return v * v; }

float3 Tonemap_Uchimura(float3 x, float P, float a, float m, float l, float c, float b) {
	// Uchimura 2017, "HDR theory and practice"
	// Math: https://www.desmos.com/calculator/gslcdxvipg
	// Source: https://www.slideshare.net/nikuque/hdr-theory-and-practicce-jp
	float l0 = ((P - m) * l) / a;
	float L0 = m - m / a;
	float L1 = m + (1.0 - m) / a;
	float S0 = m + l0;
	float S1 = m + a * l0;
	float C2 = (a * P) / (P - S1);
	float CP = -C2 / P;

	float3 w0 = 1.0 - smoothstep(0.0, m, x);
	float3 w2 = step(m + l0, x);
	float3 w1 = 1.0 - w0 - w2;

	float3 C = float3(c,c,c);
	float3 T = m * pow(x / m, C) + b;
	float3 S = P - (P - S1) * exp(CP * (x - S0));
	float3 L = m + a * (x - m);

	return T * w0 + L * w1 + S * w2;
}

float DayNightInt(float ExtDay, float ExtNight, float Int) {
	float Ext = lerp(ExtNight, ExtDay, ENightDayFactor);
	return lerp(Ext, Int, EInteriorFactor);
}

float naturalShoulder(float x)
{
	return 1.0 - exp(-x);
}

float naturalShoulder(float x, float t)
{
	float v1 = x;
	float v2 = t + (1.0 - t) * naturalShoulder((x - t) / (1.0 - t));
	return x < t ? v1 : v2;
}
/*
float naturalShoulder(float x, float linearStart, float linearSection)
{
	float v1 = x;
	float v2 = t + (1.0 - t) * naturalShoulder((x - t) / (1.0 - t));
	return x < t ? v1 : v2;
}*/

float3 naturalShoulder(float3 x, float t)
{
	return float3(
		naturalShoulder(x.x, t),
		naturalShoulder(x.y, t),
		naturalShoulder(x.z, t)
		);
}

float3 Tonemap_Uchimura(float3 x) {

	float LinearSection = 0.25;
	float Whitepoint = 4.0;

	float Brightness = DayNightInt(ExtDayBrightness, ExtNightBrightness, IntBrightness);
	float Contrast = DayNightInt(ExtDayContrast, ExtNightContrast, IntContrast);
	float LinearSectionStart = DayNightInt(ExtDayLinearSectionStart, ExtNightLinearSectionStart, IntLinearSectionStart);
	float LinearSectionLength = DayNightInt(ExtDayLinearSectionLength, ExtNightLinearSectionLength, IntLinearSectionLength);
	float Black = DayNightInt(ExtDayBlack, ExtNightBlack, IntBlack);
	float Pedestal = DayNightInt(ExtDayPedestal, ExtNightPedestal, IntPedestal);
	float3 color = Tonemap_Uchimura(x, Brightness, Contrast, LinearSectionStart, LinearSectionLength, Black, Pedestal);
	return color;
	//return naturalShoulder(color.xyz, LinearSection) * rcp(naturalShoulder(Whitepoint, LinearSection));
}

#include "ictcp_colorspaces.fx"
float3 frostbyteTonemap(float3 color)
{
	float3 ictcp = rgb2ictcp(color.xyz);
	float saturation = pow(smoothstep(1.0, 1.0 - Desaturation, ictcp.x), 1.3);
	color.xyz = ictcp2rgb(ictcp * float3(1.0, saturation.xx));

	float3 perChannel = Tonemap_Uchimura(color.xyz);

	float peak = max(color.x, max(color.y, color.z));
	color.xyz *= rcp(peak + 1e-6);
	color.xyz *= Tonemap_Uchimura(peak);

	color.xyz = lerp(color.xyz, perChannel, HueShift);

	color.xyz = rgb2ictcp(color.xyz);
	float saturationBoost = Resaturation * smoothstep(1.0, 0.5, ictcp.x);
	color.yz = lerp(color.yz, ictcp.yz * color.x / max(1e-3, ictcp.x), saturationBoost);
	float Saturation = DayNightInt(ExtDaySaturation, ExtNightSaturation, IntSaturation);
	color.yz *= Saturation;
	color.xyz = ictcp2rgb(color.xyz);

	return color;
}
