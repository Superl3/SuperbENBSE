//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ENBSeries TES Skyrim SE hlsl DX11 format, example post process
// visit http://enbdev.com for updates
// Author: Boris Vorontsov
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//Warning! In this version Weather index is not yet implemented

//post processing mode. Change value (could be 1, 2, 3, 4). Every mode have own internal parameters, look below

bool	ditherbool <
	string UIName = "Dithering";
	string UIWidget = "Toggle";
> = true;

//+++++++++++++++++++++++++++++
//internal parameters, modify or add new
//+++++++++++++++++++++++++++++
//modify these values to tweak various color processing


#ifdef E_CC_PROCEDURAL
//parameters for ldr color correction
float	ECCGamma
<
	string UIName = "CC: Gamma";
	string UIWidget = "Spinner";
	float UIMin = 0.2;//not zero!!!
	float UIMax = 5.0;
> = { 1.0 };

float	ECCInBlack
<
	string UIName = "CC: In black";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = { 0.0 };

float	ECCInWhite
<
	string UIName = "CC: In white";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = { 1.0 };

float	ECCOutBlack
<
	string UIName = "CC: Out black";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = { 0.0 };

float	ECCOutWhite
<
	string UIName = "CC: Out white";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = { 1.0 };

float	ECCBrightness
<
	string UIName = "CC: Brightness";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 10.0;
> = { 1.0 };

float	ECCContrastGrayLevel
<
	string UIName = "CC: Contrast gray level";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 0.99;
> = { 0.5 };

float	ECCContrast
<
	string UIName = "CC: Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 10.0;
> = { 1.0 };
/*
float	ECCSaturation
<
	string UIName = "CC: Saturation";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 10.0;
> = { 1.0 };
*/

float	ECCDesaturateShadows
<
	string UIName = "CC: Desaturate shadows";
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
> = { 0.0 };
/*
float3	ECCColorBalanceShadows <
	string UIName = "CC: Color balance shadows";
	string UIWidget = "Color";
> = { 0.5, 0.5, 0.5 };

float3	ECCColorBalanceHighlights <
	string UIName = "CC: Color balance highlights";
	string UIWidget = "Color";
> = { 0.5, 0.5, 0.5 };

float3	ECCChannelMixerR <
	string UIName = "CC: Channel mixer R";
	string UIWidget = "Color";
> = { 1.0, 0.0, 0.0 };

float3	ECCChannelMixerG <
	string UIName = "CC: Channel mixer G";
	string UIWidget = "Color";
> = { 0.0, 1.0, 0.0 };

float3	ECCChannelMixerB <
	string UIName = "CC: Channel mixer B";
	string UIWidget = "Color";
> = { 0.0, 0.0, 1.0 };
*/

#endif //E_CC_PROCEDURAL

//+++++++++++++++++++++++++++++
//external enb parameters, do not modify
//+++++++++++++++++++++++++++++
//x = generic timer in range 0..1, period of 16777216 ms (4.6 hours), y = average fps, w = frame time elapsed (in seconds)
float4	Timer;
//x = Width, y = 1/Width, z = aspect, w = 1/aspect, aspect is Width/Height
float4	ScreenSize;
//changes in range 0..1, 0 means full quality, 1 lowest dynamic quality (0.33, 0.66 are limits for quality levels)
float	AdaptiveQuality;
//x = current weather index, y = outgoing weather index, z = weather transition, w = time of the day in 24 standart hours. Weather index is value from weather ini file, for example WEATHER002 means index==2, but index==0 means that weather not captured.
float4	Weather;
//x = dawn, y = sunrise, z = day, w = sunset. Interpolators range from 0..1
float4	TimeOfDay1;
//x = dusk, y = night. Interpolators range from 0..1
float4	TimeOfDay2;
//changes in range 0..1, 0 means that night time, 1 - day time
float	ENightDayFactor;
//changes 0 or 1. 0 means that exterior, 1 - interior
float	EInteriorFactor;
float	FieldOfView;
#include "enbdniseperation.fx"
#include "enbeffectsuperl3.fx"

//+++++++++++++++++++++++++++++
//external enb debugging parameters for shader programmers, do not modify
//+++++++++++++++++++++++++++++
//keyboard controlled temporary variables. Press and hold key 1,2,3...8 together with PageUp or PageDown to modify. By default all set to 1.0
float4	tempF1; //0,1,2,3
float4	tempF2; //5,6,7,8
float4	tempF3; //9,0
// xy = cursor position in range 0..1 of screen;
// z = is shader editor window active;
// w = mouse buttons with values 0..7 as follows:
//    0 = none
//    1 = left
//    2 = right
//    3 = left+right
//    4 = middle
//    5 = left+middle
//    6 = right+middle
//    7 = left+right+middle (or rather cat is sitting on your mouse)
float4	tempInfo1;
// xy = cursor position of previous left mouse button click
// zw = cursor position of previous right mouse button click
float4	tempInfo2;



//+++++++++++++++++++++++++++++
//game and mod parameters, do not modify
//+++++++++++++++++++++++++++++
float4				Params01[7]; //skyrimse parameters
//x - bloom amount; y - lens amount
float4				ENBParams01; //enb parameters

Texture2D			TextureColor; //hdr color
Texture2D			TextureBloom; //vanilla or enb bloom
Texture2D			TextureLens; //enb lens fx
Texture2D			TextureDepth; //scene depth
Texture2D			TextureAdaptation; //vanilla or enb adaptation
Texture2D			TextureAperture; //this frame aperture 1*1 R32F hdr red channel only. computed in depth of field shader file
Texture2D			TexturePalette; //enbpalette texture, if loaded and enabled in [colorcorrection].

SamplerState		Sampler0
{
	Filter = MIN_MAG_MIP_POINT;//MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
};
SamplerState		Sampler1
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = Clamp;
	AddressV = Clamp;
};



//+++++++++++++++++++++++++++++
//
//+++++++++++++++++++++++++++++
struct VS_INPUT_POST
{
	float3 pos		: POSITION;
	float2 txcoord	: TEXCOORD0;
};
struct VS_OUTPUT_POST
{
	float4 pos		: SV_POSITION;
	float2 txcoord0	: TEXCOORD0;
};



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
VS_OUTPUT_POST	VS_Draw(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST	OUT;
	float4	pos;
	pos.xyz = IN.pos.xyz;
	pos.w = 1.0;
	OUT.pos = pos;
	OUT.txcoord0.xy = IN.txcoord.xy;
	return OUT;
}

float4	PS_DrawBloomTexture(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
	float4 res;
	res.xyz = TextureBloom.Sample(Sampler1, IN.txcoord0.xy);
	res.w = 1.0;
	return res;
}
float4	PS_DrawAdaptationTexture(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
	float4 res;
	res.xyz = TextureAdaptation.Sample(Sampler0, IN.txcoord0.xy);
	res.y = res.x;
	res.z = res.x;
	res.w = 1.0;
	return res;
}



float4	PS_Draw(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
	float4	res;
	float4	color;

	color = TextureColor.Sample(Sampler0, IN.txcoord0.xy); //hdr scene color
	//return color;

	float3	lens;
	lens.xyz = TextureLens.Sample(Sampler1, IN.txcoord0.xy).xyz;
	color.xyz += lens.xyz * ENBParams01.y; //lens amount

	float3	bloom = TextureBloom.Sample(Sampler1, IN.txcoord0.xy);
	//bloom.xyz = bloom - color;
	//bloom.xyz = max(bloom, 0.0);
	color.xyz += bloom * ENBParams01.x; //bloom amount

	float	grayadaptation = TextureAdaptation.Sample(Sampler0, IN.txcoord0.xy).x;
	grayadaptation = max(grayadaptation, 0.0);
	grayadaptation = min(grayadaptation, 50.0);

	color.xyz = color.xyz / grayadaptation;

	float depth = TextureDepth.Sample(Sampler1, IN.txcoord0.xy, 0).x;
	depth = min(depth * rcp(mad(depth, -2999.0, 3000.0)), 1);
	color.xyz = frostbyteTonemap(color.xyz, depth);
	//color.xyz = Tonemap_Uchimura(color.xyz, depth);

	#ifdef E_CC_PALETTE
		//activated by UsePaletteTexture=true
		color.rgb = saturate(color.rgb);
		float3	brightness = grayadaptation;//adaptation luminance
		brightness = max(brightness.x, max(brightness.y, brightness.z));
		brightness.x = (brightness.x / (brightness.x + 1.0));
		float3	palette;
		float2	uvpalette;
		uvpalette.y = brightness.x;
		uvpalette.x = color.r;
		palette.r = TexturePalette.SampleLevel(Sampler1, uvpalette, 0.0).r;
		uvpalette.x = color.g;
		palette.g = TexturePalette.SampleLevel(Sampler1, uvpalette, 0.0).g;
		uvpalette.x = color.b;
		palette.b = TexturePalette.SampleLevel(Sampler1, uvpalette, 0.0).b;
		color.rgb = palette.rgb;
	#endif //E_CC_PALETTE


	#ifdef E_CC_PROCEDURAL
		//activated by UseProceduralCorrection=true
		float	tempgray;
		float4	tempvar;
		float3	tempcolor;

		//+++ levels like in photoshop, including gamma, lightness, additive brightness
		color = max(color - ECCInBlack, 0.0) / max(ECCInWhite - ECCInBlack, 0.0001);
		if (ECCGamma != 1.0) color = pow(color, ECCGamma);
		color = color * (ECCOutWhite - ECCOutBlack) + ECCOutBlack;

		//+++ brightness
		color = color * ECCBrightness;

		//+++ contrast
		color = (color - ECCContrastGrayLevel) * ECCContrast + ECCContrastGrayLevel;

		//+++ desaturate shadows
		tempgray = dot(color.xyz, 0.3333);
		tempvar.x = saturate(1.0 - tempgray);
		tempvar.x *= tempvar.x;
		tempvar.x *= tempvar.x;
		color = lerp(color, tempgray, ECCDesaturateShadows*tempvar.x);

	#endif //E_CC_PROCEDURAL
		// Somewhere at the end of your shader pipeline:
		if (ditherbool) {
			color.xyz = lin2srgb_fast(color.xyz);
			color.xyz = srgb2lin_fast(color.xyz + triDither(color.xyz, IN.txcoord0.xy, Timer.x));
		}

		res.xyz = saturate(color);
		res.w = 1.0;
		return res;
}



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Vanilla post process. Do not modify
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
float4	PS_DrawOriginal(VS_OUTPUT_POST IN, float4 v0 : SV_Position0) : SV_Target
{
	float4	res;
	float4	color;

	float2	scaleduv = Params01[6].xy*IN.txcoord0.xy;
	scaleduv = max(scaleduv, 0.0);
	scaleduv = min(scaleduv, Params01[6].zy);

	color = TextureColor.Sample(Sampler0, IN.txcoord0.xy); //hdr scene color

	float4	r0, r1, r2, r3;
	r1.xy = scaleduv;
	r0.xyz = color.xyz;
	if (0.5 <= Params01[0].x) r1.xy = IN.txcoord0.xy;
	r1.xyz = TextureBloom.Sample(Sampler1, r1.xy).xyz;
	r2.xy = TextureAdaptation.Sample(Sampler1, IN.txcoord0.xy).xy; //in skyrimse it two component

	r0.w = dot(float3(2.125000e-001, 7.154000e-001, 7.210000e-002), r0.xyz);
	r0.w = max(r0.w, 1.000000e-005);
	r1.w = r2.y / r2.x;
	r2.y = r0.w * r1.w;
	if (0.5 < Params01[2].z) r2.z = 0xffffffff; else r2.z = 0;
	r3.xy = r1.w * r0.w + float2(-4.000000e-003, 1.000000e+000);
	r1.w = max(r3.x, 0.0);
	r3.xz = r1.w * 6.2 + float2(5.000000e-001, 1.700000e+000);
	r2.w = r1.w * r3.x;
	r1.w = r1.w * r3.z + 6.000000e-002;
	r1.w = r2.w / r1.w;
	r1.w = pow(r1.w, 2.2);
	r1.w = r1.w * Params01[2].y;
	r2.w = r2.y * Params01[2].y + 1.0;
	r2.y = r2.w * r2.y;
	r2.y = r2.y / r3.y;
	if (r2.z == 0) r1.w = r2.y; else r1.w = r1.w;
	r0.w = r1.w / r0.w;
	r1.w = saturate(Params01[2].x - r1.w);
	r1.xyz = r1 * r1.w;
	r0.xyz = r0 * r0.w + r1;
	r1.x = dot(r0.xyz, float3(2.125000e-001, 7.154000e-001, 7.210000e-002));
	r0.w = 1.0;
	r0 = r0 - r1.x;
	r0 = Params01[3].x * r0 + r1.x;
	r1 = Params01[4] * r1.x - r0;
	r0 = Params01[4].w * r1 + r0;
	r0 = Params01[3].w * r0 - r2.x;
	r0 = Params01[3].z * r0 + r2.x;
	r0.xyz = saturate(r0);
	r1.xyz = pow(r1.xyz, Params01[6].w);
	//active only in certain modes, like khajiit vision, otherwise Params01[5].w=0
	r1 = Params01[5] - r0;
	res = Params01[5].w * r1 + r0;

		res.xyz = color.xyz;
		res.w=1.0;
		return res;
}



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//techniques
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#include "enbeffect_AdaptTool.fxh"

technique11 TestBloom < string UIName = "BloomTexture"; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Draw()));
		SetPixelShader(CompileShader(ps_5_0, PS_DrawBloomTexture()));
	}
}

technique11 TestAdaptation < string UIName = "AdaptationTexture"; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Draw()));
		SetPixelShader(CompileShader(ps_5_0, PS_DrawAdaptationTexture()));
	}
}

technique11 Draw < string UIName = "ENBSeries"; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Draw()));
		SetPixelShader(CompileShader(ps_5_0, PS_Draw()));
	}

	pass ADAPT_TOOL_PASS
}


technique11 ORIGINALPOSTPROCESS < string UIName = "Vanilla"; >
{
	pass p0
	{
		SetVertexShader(CompileShader(vs_5_0, VS_Draw()));
		SetPixelShader(CompileShader(ps_5_0, PS_DrawOriginal()));
	}
	
	pass ADAPT_TOOL_PASS
}