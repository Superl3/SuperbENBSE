//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
//  SunSpritesFX11 by kingeric1992                                              //
//                              (for TESV:SE ENBseries mod by Boris Vorontsov)  //
//  Features                                                                    //
//      *aperture generation with diffraction                                   //
//      *sunglare with diffraction                                              //
//      *flare with lens distortion                                             //
//      *layered chromatic aberration                                           //
//                                                                              //
//  For more info, visit                                                        //
//      http://enbseries.enbdev.com/forum/viewtopic.php?f=7&t=3549              //
//                                                                              //
//  update: Apr.30.2019                                                         //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

//#define ADV_UI //enable advanced params
#define ENABLE_ADAPTIVE // flare intensity reflects the perceived sun brightness.
#define ENABLE_CORONA
#define ENABLE_DIRT    //use enbsunsprite alpha (.png transparency) channel as lens dirt texture.
#define ENABLE_GLARE
#define ENABLE_FAST_COMPILE //not really makes any difference.

Texture2D TextureSprite <string UIName="Sprite"; string ResourceName="enbseries/enbsunsprite.png"; >;

//////////////////////////////////////////////////////////////////////////////////
//
#define S_CONST static const
#ifndef ADV_UI
    #define ADV_UI static const
#endif
#ifdef ENABLE_GLARE
    #define S_GLARE
#else
    #undef  ENABLE_CORONA
    #define S_GLARE static const
#endif
//
//////////////////////////////////////////////////////////////////////////////////
        int    Lens_Settings        <string UIName="+++++ Lens +++++";    float UIMin=0; float UIMax=0;   > ={ 0};
        int    Lens_Leaf            <string UIName="Shutter Leaf";          int   UIMin=5; int   UIMax=10;  > ={ 6};     // Blades count, controls sprite shape & diffraction pattern.
        float  Lens_fNumber         <string UIName="F-Number";              float UIMin=1; float UIMax=22;  > ={ 5.6};   // f-stop, controls sprite shape & size(relative).
        int    Lens_Angle           <string UIName="Offset Angle(\xB0)";    int   UIMin=0; int   UIMax=36;  > ={ 0};     // Aperture angle offset.
S_CONST float  Lens_Dirt_Curve      = 3.0;                                                                               // lens dirt contrast
S_CONST float  Lens_Fmin            = 2.8;                                                                               // maximum F-number to have circle aperture.
S_CONST float  Lens_Fmax            = 4;                                                                                 // minimum F-number to have polygon aperture.
S_GLARE int    Glare_Settings       <string UIName="+++++ Glare +++++";   float UIMin=0; float UIMax=0;   > ={ 0};
S_GLARE float  Glare_Diff_Curve     <string UIName="Glare_Diff_Curve";      float UIMin=0;                  > ={ 6};     // contrast of glare diffraction pattern (only visible when polygon aperture applied)
S_GLARE float  Glare_Diff_Intensity <string UIName="Glare_Diff_Intensity";  float UIMin=0;                  > ={ 10};    // diffraction pattern intensity
S_GLARE float  Glare_Intensity      <string UIName="Glare_Intensity";       float UIMin=0;                  > ={ 0.07};  // intensity
S_GLARE float  Glare_AlphaWeight    <string UIName="Glare_AlphaWeight";     float UIMin=0;                  > ={ 30};    // intensity modifier when overlaping with sprites
S_GLARE float3 Glare_Tint           <string UIName="Glare_Tint";            string UIWidget="Color";        > ={ 0.5, 1, 1};
S_CONST float  Glare_DynamicMod     = 0.4;                                                                               // glare dynamic rotation modifier

#ifdef ENABLE_CORONA
        int    Corona_Settings      <string UIName="+++++ Corona +++++"; float UIMin=0; float UIMax=0;   > ={ 0};
        float  Corona_Radius        <string UIName="Corona_Radius";        float UIMin=0; float UIMax=0.5; > ={ 0.3};    // Corona radius
        float  Corona_Intensity     <string UIName="Corona_Intensity";     float UIMin=0;                  > ={ 3};      // Corona intensity
S_CONST float  Corona_Width         = 0.5;
S_CONST float  Corona_Diff_Freq     = 500;
S_CONST float  Corona_Diff_Scale    = 0.3;
S_CONST float  Corona_Weight[3]     = {1, 0.5, 0.25};
#endif
        int    Global_Settings      <string UIName="+++++ Sprite +++++";  float UIMin=0; float UIMax=0;   > ={ 0};
        float  Sprite_Intensity     <string UIName="Sprite_Intensity";      float UIMin=0;                  > ={ 0.2};   // global sprite intensity
        float  Sprite_Scale         <string UIName="Sprite_Scale";          float UIMin=0;                  > ={ 0.5};   // global scale
S_CONST float  Sprite_Diff_Mod      = 200;                                                                               // Sprite diffraction pattern frequency(strips around edges)

        int    G1_Settings          <string UIName="+++++ Group1 +++++";  float UIMin=0; float UIMax=0;   > ={ 0}; // 9 small
        float  G1_Offset_Scale      <string UIName="G1_Offset_Scale";       float UIMin=0; float UIMax=100; > ={ 0.22};  // 1 == screen size
        float  G1_Scale             <string UIName="G1_Scale";              float UIMin=0; float UIMax=100; > ={ 0.15};  // 1 == screen size
        float  G1_Intensity         <string UIName="G1_Intensity";          float UIMin=0; float UIMax=2;   > ={ 1};     // intensity modifier for current group
        float  G1_Edge_Intensity    <string UIName="G1_Edge_Intensity";     float UIMin=0; float UIMax=100; > ={ 5};     // edge intensity
        float  G1_Edge_Curve        <string UIName="G1_Edge_Curve";         float UIMin=0; float UIMax=100; > ={ 6};     // intensity curve from edge towards center
        float  G1_Chroma            <string UIName="G1_Chroma";             float UIMin=1;                  > ={ 1.04};  // chromatic aberration amount
        float3 G1_Tint              <string UIName="G1_Tint";               string UIWidget="Color";        > ={ 0.5, 1, 1};
ADV_UI  float  G1_Vignette          <string UIName="G1_Vignette";           float UIMin=1;                  > ={ 0.5};
ADV_UI  float  G1_Feather           <string UIName="G1_Feather";            float UIMin=1;                  > ={ 0.85};

        int    G2_Settings          <string UIName="+++++ Group2 +++++";  float UIMin=0; float UIMax=0;   > ={ 0}; // 9 small
        float  G2_Offset_Scale      <string UIName="G2_Offset_Scale";       float UIMin=0; float UIMax=100; > ={ 0.18};  // 1 == screen size
        float  G2_Scale             <string UIName="G2_Scale";              float UIMin=0; float UIMax=100; > ={ 0.2};   // 1 == screen size
        float  G2_Intensity         <string UIName="G2_Intensity";          float UIMin=0; float UIMax=2;   > ={ 1};     // intensity modifier for current group
        float  G2_Edge_Intensity    <string UIName="G2_Edge_Intensity";     float UIMin=0; float UIMax=100; > ={ 2};     // edge intensity
        float  G2_Edge_Curve        <string UIName="G2_Edge_Curve";         float UIMin=0; float UIMax=100; > ={ 5};     // intensity curve from edge towards center
        float  G2_Chroma            <string UIName="G2_Chroma";             float UIMin=1;                  > ={ 1.04};  // chromatic aberration amount
        float3 G2_Tint              <string UIName="G2_Tint";               string UIWidget="Color";        > ={ 0.5, 1, 1};
ADV_UI  float  G2_Vignette          <string UIName="G2_Vignette";           float UIMin=1;                  > ={ 0.5};
ADV_UI  float  G2_Feather           <string UIName="G2_Feather";            float UIMin=1;                  > ={ 0.85};

        int    G3_Settings          <string UIName="+++++ Group3 +++++";  float UIMin=0; float UIMax=0;   > ={ 0}; // 9 large
        float  G3_Offset_Scale      <string UIName="G3_Offset_Scale";       float UIMin=0; float UIMax=100; > ={ 0.12};  // 1 == screen size
        float  G3_Scale             <string UIName="G3_Scale";              float UIMin=0; float UIMax=100; > ={ 0.5};   // 1 == screen size
        float  G3_Intensity         <string UIName="G3_Intensity";          float UIMin=0; float UIMax=2;   > ={ 1};     // intensity modifier for current group
        float  G3_Edge_Intensity    <string UIName="G3_Edge_Intensity";     float UIMin=0; float UIMax=100; > ={ 2};     // edge intensity
        float  G3_Edge_Curve        <string UIName="G3_Edge_Curve";         float UIMin=0; float UIMax=100; > ={ 5};     // intensity curve from edge towards center
        float  G3_Chroma            <string UIName="G3_Chroma";             float UIMin=1;                  > ={ 1.04};  // chromatic aberration amount
        float3 G3_Tint              <string UIName="G3_Tint";               string UIWidget="Color";        > ={ 0.5, 1, 1};
ADV_UI  float  G3_Vignette          <string UIName="G3_Vignette";           float UIMin=1;                  > ={ 0.45};
ADV_UI  float  G3_Feather           <string UIName="G3_Feather";            float UIMin=1;                  > ={ 0.85};

        int    G4_Settings          <string UIName="+++++ Group4 +++++";  float UIMin=0; float UIMax=0;   > ={ 0}; // 9 large
        float  G4_Offset_Scale      <string UIName="G4_Offset_Scale";       float UIMin=0; float UIMax=100; > ={ 0.08};  // 1 == screen size
        float  G4_Scale             <string UIName="G4_Scale";              float UIMin=0; float UIMax=100; > ={ 0.73};  // 1 == screen size
        float  G4_Intensity         <string UIName="G4_Intensity";          float UIMin=0; float UIMax=2;   > ={ 0};     // intensity modifier for current group
        float  G4_Edge_Intensity    <string UIName="G4_Edge_Intensity";     float UIMin=0; float UIMax=100; > ={ 1};     // edge intensity
        float  G4_Edge_Curve        <string UIName="G4_Edge_Curve";         float UIMin=0; float UIMax=100; > ={ 5};     // intensity curve from edge towards center
        float  G4_Chroma            <string UIName="G4_Chroma";             float UIMin=1;                  > ={ 1.1};   // chromatic aberration amount
        float3 G4_Tint              <string UIName="G4_Tint";               string UIWidget="Color";        > ={ 0.5, 1, 1};
ADV_UI  float  G4_Vignette          <string UIName="G4_Vignette";           float UIMin=1;                  > ={ 0.45};
ADV_UI  float  G4_Feather           <string UIName="G4_Feather";            float UIMin=1;                  > ={ 0.85};

int    S1_Settings      <string UIName="+++ Secondary Sprite1 +++"; float UIMin=0; float UIMax=0;   > ={ 0};
float  S1_Scale         <string UIName="S1_Scale";                  float UIMin=0; float UIMax=100; > ={ 0.5};   // 1 == screen size
float  S1_Intensity     <string UIName="S1_Intensity";              float UIMin=0; float UIMax=100; > ={ 4};     // intensity
float  S1_Offset        <string UIName="S1_Offset";                                                 > ={ 1.44};  // -1 == Sun pos, 0 == screen center
int    S1_Axis          <string UIName="S1_Axis(\xB0)";             float UIMin=0; float UIMax=180; > ={ 0};     // rotate sprite axis, center at sunpos
float  S1_Edge_Curve    <string UIName="S1_Edge_Curve";             float UIMin=0; float UIMax=100; > ={ 5};     // intensity curve from edge towards center
float  S1_Edge_Intensity<string UIName="S1_Edge_Intensity";         float UIMin=0; float UIMax=100; > ={ 0};     // edge intensity
float  S1_VigRadius     <string UIName="S1_VigRadius";              float UIMin=0; float UIMax=0.5; > ={ 0.5};   // vignette radius
float  S1_Feather       <string UIName="S1_Feather";                float UIMin=0; float UIMax=1;   > ={ 0.7};   // feather radius
float  S1_Distort_Offset<string UIName="S1_Distort_Offset";                                         > ={ -1.54}; // distortion center, -1 == Sun pos, 0 == screen center
float  S1_Distort_Scale <string UIName="S1_Distort_Scale";                                          > ={ -0.68}; // distortion amount
float  S1_Chroma        <string UIName="S1_Chroma";                 float UIMin=0;                  > ={ 1.06};  // chromatic aberration amount
float3 S1_Tint          <string UIName="S1_Tint";                   string UIWidget="Color";        > ={ 0.5, 1, 1};

int    S2_Settings      <string UIName="+++ Secondary Sprite2 +++"; float UIMin=0; float UIMax=0;   > ={ 0};
float  S2_Scale         <string UIName="S2_Scale";                  float UIMin=0; float UIMax=100; > ={ 0.49};  // 1 == screen size
float  S2_Intensity     <string UIName="S2_Intensity";              float UIMin=0; float UIMax=100; > ={ 2};     // intensity
float  S2_Offset        <string UIName="S2_Offset";                                                 > ={ -1.65}; // -1 == Sun pos, 0 == screen center
int    S2_Axis          <string UIName="S2_Axis(\xB0)";             float UIMin=0; float UIMax=180; > ={ 0};     // rotate sprite axis, center at sunpos
float  S2_Edge_Curve    <string UIName="S2_Edge_Curve";             float UIMin=0; float UIMax=100; > ={ 5};     // intensity curve from edge towards center
float  S2_Edge_Intensity<string UIName="S2_Edge_Intensity";         float UIMin=0; float UIMax=100; > ={ 0};     // edge intensity
float  S2_VigRadius     <string UIName="S2_VigRadius";              float UIMin=0; float UIMax=0.5; > ={ 0.5};   // vignette radius
float  S2_Feather       <string UIName="S2_Feather";                float UIMin=0; float UIMax=1;   > ={ 0.8};   // feather radius
float  S2_Distort_Offset<string UIName="S2_Distort_Offset";                                         > ={ 1.95};  // distortion center, -1 == Sun pos, 0 == screen center
float  S2_Distort_Scale <string UIName="S2_Distort_Scale";                                          > ={ -0.52}; // distortion amount
float  S2_Chroma        <string UIName="S2_Chroma";                 float UIMin=0;                  > ={ 1.01};  // chromatic aberration amount
float3 S2_Tint          <string UIName="S2_Tint";                   string UIWidget="Color";        > ={ 0.5, 1, 1};

int    S3_Settings      <string UIName="+++ Secondary Sprite3 +++"; float UIMin=0; float UIMax=0;   > ={ 0};
float  S3_Scale         <string UIName="S3_Scale";                  float UIMin=0; float UIMax=100; > ={ 0.56};  // 1 == screen size
float  S3_Intensity     <string UIName="S3_Intensity";              float UIMin=0; float UIMax=100; > ={ 4};     // intensity
float  S3_Offset        <string UIName="S3_Offset";                                                 > ={ -0.11}; // -1 == Sun pos, 0 == screen center
int    S3_Axis          <string UIName="S3_Axis(\xB0)";             float UIMin=0; float UIMax=180; > ={ 0};     // rotate sprite axis, center at sunpos
float  S3_Edge_Curve    <string UIName="S3_Edge_Curve";             float UIMin=0; float UIMax=100; > ={ 8};     // intensity curve from edge towards center
float  S3_Edge_Intensity<string UIName="S3_Edge_Intensity";         float UIMin=0; float UIMax=100; > ={ 3};     // edge intensity
float  S3_VigRadius     <string UIName="S3_VigRadius";              float UIMin=0; float UIMax=0.5; > ={ 0.5};   // vignette radius
float  S3_Feather       <string UIName="S3_Feather";                float UIMin=0; float UIMax=1;   > ={ 0.7};   // feather radius
float  S3_Distort_Offset<string UIName="S3_Distort_Offset";                                         > ={ 0.6};   // distortion center, -1 == Sun pos, 0 == screen center
float  S3_Distort_Scale <string UIName="S3_Distort_Scale";                                          > ={ -0.25}; // distortion amount
float  S3_Chroma        <string UIName="S3_Chroma";                 float UIMin=0;                  > ={ 1.06};  // chromatic aberration amount
float3 S3_Tint          <string UIName="S3_Tint";                   string UIWidget="Color";        > ={ 0.5, 1, 1};

int    S4_Settings      <string UIName="+++ Secondary Sprite4 +++"; float UIMin=0; float UIMax=0;   > ={ 0};
float  S4_Scale         <string UIName="S4_Scale";                  float UIMin=0; float UIMax=100; > ={ 0.4};   // 1 == screen size
float  S4_Intensity     <string UIName="S4_Intensity";              float UIMin=0; float UIMax=100; > ={ 5};     // intensity
float  S4_Offset        <string UIName="S4_Offset";                                                 > ={ -2};    // -1 == Sun pos, 0 == screen center
int    S4_Axis          <string UIName="S4_Axis(\xB0)";             float UIMin=0; float UIMax=180; > ={ 141};   // rotate sprite axis, center at sunpos
float  S4_Edge_Curve    <string UIName="S4_Edge_Curve";             float UIMin=0; float UIMax=100; > ={ 5};     // intensity curve from edge towards center
float  S4_Edge_Intensity<string UIName="S4_Edge_Intensity";         float UIMin=0; float UIMax=100; > ={ 0};     // edge intensity
float  S4_VigRadius     <string UIName="S4_VigRadius";              float UIMin=0; float UIMax=0.5; > ={ 0.5};   // vignette radius
float  S4_Feather       <string UIName="S4_Feather";                float UIMin=0; float UIMax=1;   > ={ 0.35};  // feather radius
float  S4_Distort_Offset<string UIName="S4_Distort_Offset";                                         > ={ 1};     // distortion center, -1 == Sun pos, 0 == screen center
float  S4_Distort_Scale <string UIName="S4_Distort_Scale";                                          > ={ 0.64};  // distortion amount
float  S4_Chroma        <string UIName="S4_Chroma";                 float UIMin=0;                  > ={ 0.73};  // chromatic aberration amount
float3 S4_Tint          <string UIName="S4_Tint";                   string UIWidget="Color";        > ={ 0.5, 1, 1};

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  external enb parameters, do not modify
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

float4  Timer;           // x = generic timer in range 0..1, period of 16777216 ms (4.6 hours), y = average fps, w = frame time elapsed (in seconds)
float4  ScreenSize;      // x = Width, y = 1/Width, z = Width/Height, w = Height/Width
float   AdaptiveQuality; // changes in range 0..1, 0 means full quality, 1 lowest dynamic quality (0.33, 0.66 are limits for quality levels)
float4  Weather;         // x = current weather index, y = outgoing weather index, z = weather transition, w = time of the day in 24 standart hours. Weather index is value from weather ini file, for example WEATHER002 means index==2, but index==0 means that weather not captured.
float4  TimeOfDay1;      // x = dawn, y = sunrise, z = day, w = sunset. Interpolators range from 0..1
float4  TimeOfDay2;      // x = dusk, y = night. Interpolators range from 0..1
float   ENightDayFactor; // changes in range 0..1, 0 means that night time, 1 - day time
float   EInteriorFactor; // changes 0 or 1. 0 means that exterior, 1 - interior
float4  LightParameters; // xy=sun position on screen, w=visibility

//Press and hold key 0...9 together with PageUp or PageDown to modify. By default all set to 1.0
float4    tempF1, tempF2, tempF3; // {0,1,2,3}, {4,5,6,7}, {8,9, null, null}
//    0 = none; 1 = left; 2 = right;  3 = left+right
//    4 = middle; 5 = left+middle; 6 = right+middle;  7 = left+right+middle (or rather cat is sitting on your mouse)
float4    tempInfo1; // .xy = cursor pos; .z = is shader editor window active; .w = mouse buttons with values 0..7 as above listing:
float4    tempInfo2; // cursor pos of previous LMB(.xy)/RMB(.zw) click

Texture2D    TextureMask; //mask of sun as visibility factor
Texture2D    TextureColor;
SamplerState SamplerLinear { Filter = MIN_MAG_MIP_LINEAR; AddressU = Clamp; AddressV = Clamp; };
BlendState   DstAlpha_One  { BlendEnable[0]=TRUE; SrcBlend=DEST_ALPHA; DestBlend=ONE; };
BlendState   Alpha_One     { BlendEnable[0]=TRUE; SrcBlend=ONE;        DestBlend=ONE; SrcBlendAlpha=ONE;  DestBlendAlpha=ONE; };

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  Helpers
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//rotate input vec by radians
float2 rotate( float2 vec, float rad) {
    float2 rot;
    sincos(rad, rot.y, rot.x);
    return float2( vec.x * rot.x - vec.y * rot.y, dot(vec, rot.yx));
}

//convert Cartesian into Polar; ret = (r, theta), theta = [-pi, pi];
float2 polar( float2 coord) {
    float r = length(coord);
    return float2( r, ( r == 0)? 0 : atan2(coord.y, coord.x));
}

float2 distort( float2 coord, float curve, float scale) {
    float  r = length(coord);
    return coord + pow( 2*r, curve) * (coord / r) * scale;;
}

float lum( float3 col, float3 w = float3( 0.2126, 0.7152, 0.0722)) {
    return dot(col, w);
}

//http://simple.wikipedia.org/wiki/Rainbow
static const float3 Spectrum[7] = {
    { 1,   0,   0 }, //red
    { 1,   0.5, 0 }, //orange
    { 1,   1,   0 }, //yellow
    { 0,   1,   0 }, //green
    { 0,   0,   1 }, //blue
    { 0.3, 0, 0.5 }, //indigo
    { 0.6, 0,   1 }  //purple
};

static const float3 TINT_CYAN    = { 0.1, 1.0, 1.0 };
static const float3 TINT_MAGENTA = { 1.0, 0.1, 1.0 };
static const float3 TINT_YELLOW  = { 1.0, 1.0, 0.1 };
static const float3 TINT_RED     = { 1.0, 0.1, 0.1 };
static const float3 TINT_GREEN   = { 0.1, 1.0, 0.1 };
static const float3 TINT_BLUE    = { 0.1, 0.1, 1.0 };

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  Shaders
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void VS_Sprite( inout float4 pos : SV_POSITION, inout float4 uv : TEXCOORD0 ) {
    pos.w = 1.0;
    uv.z  = pow( TextureMask[uint2(0,0)].x, 3.0);

#ifdef ENABLE_ADAPTIVE
    float3 ratio    = ScreenSize.y * float3(1, ScreenSize.z, -1);
    float2 sunUV    = LightParameters.xy * float2(0.5, -0.5) + 0.5;

    uv.z *= pow(max(
      max(dot(0.333, TextureColor.SampleLevel(SamplerLinear, sunUV + ratio.xy * 5, 0).xyz),
          dot(0.333, TextureColor.SampleLevel(SamplerLinear, sunUV + ratio.zy * 5, 0).xyz)),
      max(dot(0.333, TextureColor.SampleLevel(SamplerLinear, sunUV - ratio.xy * 5, 0).xyz),
          dot(0.333, TextureColor.SampleLevel(SamplerLinear, sunUV - ratio.zy * 5, 0).xyz))), 5);
#endif
}

void VS_Sprite( in uniform float4 param, inout float4 pos : SV_POSITION, inout float4 uv : TEXCOORD0)
{
    VS_Sprite(pos, uv);

    pos.xy *= param.z * Sprite_Scale / lerp( Lens_fNumber, 1, param.w);
    pos.xy  = rotate(pos.xy, radians(lerp( Lens_Angle, 0, param.w)));
    pos.y  *= ScreenSize.z;
    pos.xy += LightParameters.xy - rotate(LightParameters.xy * ( 1 + param.x), radians(param.y));
}

float4 PS_Blank(float4 pos : SV_POSITION, float4 uv : TEXCOORD0) : SV_Target {
    return any(abs(uv - .5) < 0.003) * LightParameters.w * uv.z;
}

//float4 tint    == {color tint, intensity modifier}
//float4 weight  == {edge_intensity, edge_curve, vignette, feather_range}
//float  chroma  == chromatic amount
//float3 distort == {chromatic amount, distortion scale, distortion center offset}
float4 PS_Sprite(float4 pos : SV_POSITION, float4 uv : TEXCOORD0,
    uniform float4 _t, uniform float4 _w, uniform float _c, uniform Texture2D texIn) : SV_Target
{
    float4 res     = 0;
    float  sunmask = uv.z * _t.a * Sprite_Intensity;
    clip(  sunmask - 0.001);
    {
        float  leaf      = 6.28318530 / Lens_Leaf;
        float2 Pcoord    = polar(uv.xy - 0.5);
               Pcoord.y  = (Pcoord.y + 3.1415926) % leaf;
               Pcoord.y -= leaf / 2;
               Pcoord.x *= 2 * lerp( 1, cos(Pcoord.y)/cos(leaf/2), smoothstep(Lens_Fmin, Lens_Fmax, Lens_fNumber));

        if (_c < 1.001) {
            float  l = cos(( 1 - Pcoord.x) * ( 1 - Pcoord.x) * Sprite_Diff_Mod) + 1;
            res.rgb += (pow(Pcoord.x, _w.y) * _w.x * l + 1) * smoothstep( 1, _w.w, Pcoord.x);
        }
        else {
            for(int i=0; i<4; i++) {
                float l  = cos(( 1 - Pcoord.x) * ( 1 - Pcoord.x) * Sprite_Diff_Mod) + 1;
                res.rgb += (pow(Pcoord.x, _w.y) * _w.x * l + 1) * smoothstep( 1, _w.w, Pcoord.x) * Spectrum[i * 2];
                Pcoord.x *= _c;
            }
        }
    }
   res.rgb *= smoothstep( 1, 0.95, length(pos.xy * ScreenSize.y - 0.5) / _w.z) * _t.rgb * LightParameters.w * sunmask;
#ifdef ENABLE_DIRT
    res.rgb *= pow(texIn.Sample(SamplerLinear, uv.xy).a, Lens_Dirt_Curve); //lens dirt
#endif
    res.a    = lum(res.rgb) * Glare_AlphaWeight;
    return res;
}

float4 PS_Sprite(float4 pos : SV_POSITION, float4 uv : TEXCOORD0,
    uniform float4 _t, uniform float4 _w, uniform float3 _d, uniform Texture2D texIn) : SV_Target
{
    float4 res     = 0;
    float  sunmask = uv.z * _t.a * Sprite_Intensity;
    clip(  sunmask - 0.001);
    {
        float2 sscoord    = pos.xy * ScreenSize.y;
               sscoord.y *= ScreenSize.z;
               sscoord   -= 0.5 + float2(0.5, -0.5) * LightParameters.xy * _d.z;//distort center offset
               sscoord.x *= ScreenSize.z;

        float2 shift = distort(sscoord, 0.5, _d.y) - sscoord;//delta
        float  leaf  = 6.28318530 / Lens_Leaf;
        float  lensF = smoothstep(Lens_Fmin, Lens_Fmax, Lens_fNumber);

        for(int i=0; i < 7; i++)
        {
            float2 Pcoord = polar(uv.xy + shift - 0.5);
            Pcoord.y  = (Pcoord.y + 3.1415926 + radians(Lens_Angle)) % leaf;
            Pcoord.y -= leaf/2;
            Pcoord.x *= 2.0 * Lens_fNumber * lerp( 1, cos(Pcoord.y)/cos(leaf/2), lensF);
            shift    *= _d.x;

            float l  = cos(( 1 - Pcoord.x) * ( 1 - Pcoord.x) * Sprite_Diff_Mod) + 1;
            res.rgb += ( pow(Pcoord.x, _w.y) * _w.x * l + 1 ) * smoothstep( 1, _w.w, Pcoord.x) * Spectrum[i];
        }
    }
    res.rgb *= smoothstep( 1, 0.95, length(uv.xy - 0.5) / _w.z) * _t.rgb * LightParameters.w * sunmask;
#ifdef ENABLE_DIRT
    res.rgb *= pow(texIn.Sample(SamplerLinear, uv.xy).a, Lens_Dirt_Curve);
#endif
    res.a    = lum(res.rgb) * Glare_AlphaWeight;
    return res;
}

//Sun glare shader with 3 layers of corona
float4  PS_Glare(float4 pos : SV_POSITION, float4 uv : TEXCOORD0, uniform Texture2D texIn) : SV_Target
{
    float  sunmask = uv.z * Glare_Intensity;
    clip(  sunmask - 0.001);//skip current pixel if sunmask < 0.001

//Glare (note: check this)
    float2 coord = uv.xy - .5;
    float4 res   = texIn.Sample(SamplerLinear, uv.xy).r +
                   texIn.Sample(SamplerLinear, rotate(coord.xy, length(LightParameters.xy) * Glare_DynamicMod) + 0.5).r; //dynamic
    coord = polar(coord);

    float deltaAngle  = (coord.y * 0.159155 + 0.5) * Lens_Leaf;
          deltaAngle *= (Lens_Leaf % 2.) + 1;
          deltaAngle  = abs(frac(deltaAngle) - 0.5) * 2;

    res.rgb *= 1 + pow(deltaAngle, Glare_Diff_Curve) * Glare_Diff_Intensity * smoothstep(Lens_Fmin, Lens_Fmax, Lens_fNumber);//weight
    res.rgb *= sunmask * LightParameters.w * Glare_Tint * 0.01;
    res.a    = lum(res.rgb);
//Glare Ends

#ifdef ENABLE_CORONA
    float2 r = Corona_Radius;
    r.x     *= Corona_Width;
    r       /= (sin(coord.y * Corona_Diff_Freq) + 1) * Corona_Diff_Scale + 1;
    for(int i=0; i < 3; i++) {
        float d = (coord.x - r.x) / (r.y - r.x);
        float t = frac(d) * 7;
        res.rgb += lerp(Spectrum[t%7], Spectrum[(t+1)%7], frac(t)) *
            smoothstep( 0, 0.25, 0.5 - abs(d - 0.5)) * Corona_Weight[i] * Corona_Intensity * res.a;//weight;
        r /= 2;
    }
#endif
    return res;
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  Techniques & passes
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void VS_Sprite( in uniform float4 _p, in uniform float4 _t, in uniform float4 _w, in uniform float3 _d,
    inout float4 pos : SV_POSITION, inout float4 uv : TEXCOORD0,
    out float4 tint : TEXCOORD1, out float4 weight : TEXCOORD2, out float4 distort : TEXCOORD3) {
    VS_Sprite(_p, pos, uv); tint = _t; weight = _w; distort = _d.xyzz;
}

//wrapper for fast compile
float4 PS_Sprite(float4 pos : SV_POSITION, float4 uv : TEXCOORD0,
    float4 _t : TEXCOORD1, float4 _w : TEXCOORD2, float4 _d : TEXCOORD3) : SV_Target {
    return PS_Sprite(pos, uv, _t, _w, _d.x, TextureSprite);
}

float4 PS_Sprite_Alt(float4 pos : SV_POSITION, float4 uv : TEXCOORD0,
    float4 _t : TEXCOORD1, float4 _w : TEXCOORD2, float4 _d : TEXCOORD3) : SV_Target {
    return PS_Sprite(pos, uv, _t, _w, _d.xyz, TextureSprite);
}

#ifdef ENABLE_FAST_COMPILE
PixelShader PSO_Sprite = CompileShader(ps_5_0, PS_Sprite());

#define SUNSPRITE_PASS( a0, a1, a2, a3) \
    SetVertexShader(CompileShader(vs_5_0, VS_Sprite(a0, a1, a2, a3)));\
    SetPixelShader(PSO_Sprite)

PixelShader PSO_Sprite_Alt = CompileShader(ps_5_0, PS_Sprite_Alt());

#define SUNSPRITE_PASS_ALT( a0, a1, a2, a3) \
    SetVertexShader(CompileShader(vs_5_0, VS_Sprite(a0, a1, a2, a3)));\
    SetPixelShader(PSO_Sprite_Alt)

#else //compiling shit tons of shaders.
#define SUNSPRITE_PASS( a0, a1, a2, a3) \
    SetVertexShader(CompileShader(vs_5_0, VS_Sprite(a0)));\
    SetPixelShader(CompileShader(ps_5_0, PS_Sprite(a1, a2, a3, TextureSprite)))

#define SUNSPRITE_PASS_ALT( a0, a1, a2, a3) SUNSPRITE_PASS( a0, a1, a2, a3)
#endif

technique11 Draw <string UIName="Draw";>
{
#if 0
    pass p0 { //for debug purpose
        SetVertexShader(CompileShader(vs_5_0, VS_Sprite(float4(-1, 0, 1.75, 1))));
        SetPixelShader(CompileShader(ps_5_0, PS_Blank()));
        SetBlendState( Alpha_One, float4( 0,0,0,0 ), 0xFFFFFFFF );
    }
#endif
//////////////////////////////////Group1//////////////////////////////////
    pass p1 {
        SUNSPRITE_PASS(
            float4(-1 + 4 * G1_Offset_Scale, 0, G1_Scale * 0.75, 0),
            float4(TINT_BLUE * G1_Tint, G1_Intensity),
            float4(G1_Edge_Intensity, G1_Edge_Curve, G1_Vignette + 0.2, G1_Feather), G1_Chroma);
        SetBlendState( Alpha_One, float4( 0,0,0,0 ), 0xFFFFFFFF );
    }
    pass p2 {
        SUNSPRITE_PASS(
            float4(-1 + 3 * G1_Offset_Scale, 1, G1_Scale * 1.2, 0),
            float4(TINT_BLUE * G1_Tint, G1_Intensity),
            float4(G1_Edge_Intensity, G1_Edge_Curve, G1_Vignette + 0.1, G1_Feather), G1_Chroma);
    }
    pass p3 {
        SUNSPRITE_PASS(
            float4(-1 + 2 * G1_Offset_Scale, 0, G1_Scale, 0),
            float4(TINT_GREEN * G1_Tint, G1_Intensity),
            float4(G1_Edge_Intensity, G1_Edge_Curve, G1_Vignette, G1_Feather), G1_Chroma);
    }
    pass p4 {
        SUNSPRITE_PASS(
            float4(-1 + G1_Offset_Scale, 0, G1_Scale * 0.5, 0),
            float4(TINT_CYAN * G1_Tint, G1_Intensity),
            float4(G1_Edge_Intensity, G1_Edge_Curve, G1_Vignette, G1_Feather), G1_Chroma);
    }
    pass p5 {
        SUNSPRITE_PASS(
            float4(-1, 0, G1_Scale, 0),
            float4(G1_Tint, G1_Intensity),
            float4(G1_Edge_Intensity, G1_Edge_Curve, G1_Vignette + 0.125, G1_Feather), G1_Chroma);
    }
    pass p6 {
        SUNSPRITE_PASS(
            float4(-1 - G1_Offset_Scale, 0, G1_Scale * 0.8, 0),
            float4(TINT_CYAN * G1_Tint, G1_Intensity),
            float4(G1_Edge_Intensity, G1_Edge_Curve, G1_Vignette, G1_Feather), G1_Chroma);
    }
    pass p7 {
        SUNSPRITE_PASS(
            float4(-1 - 2 * G1_Offset_Scale, 0, G1_Scale, 0),
            float4(TINT_MAGENTA * G1_Tint, G1_Intensity),
            float4(G1_Edge_Intensity, G1_Edge_Curve, G1_Vignette + 0.1, G1_Feather), G1_Chroma);
    }
    pass p8 {
        SUNSPRITE_PASS(
            float4(-1 - 3 * G1_Offset_Scale, -1, G1_Scale * 1.2, 0),
            float4(TINT_MAGENTA * G1_Tint, G1_Intensity),
            float4(G1_Edge_Intensity, G1_Edge_Curve, G1_Vignette + 0.2, G1_Feather), G1_Chroma);
    }
    pass p9 {
        SUNSPRITE_PASS(
            float4(-1 - 4 * G1_Offset_Scale, 0, G1_Scale * 0.9, 0),
            float4(TINT_RED * G1_Tint, G1_Intensity),
            float4(G1_Edge_Intensity, G1_Edge_Curve, G1_Vignette + 0.3, G1_Feather), G1_Chroma);
    }
//////////////////////////////////Group2//////////////////////////////////
    pass p10 {
        SUNSPRITE_PASS(
			float4( 1 + 4 * G2_Offset_Scale, 0, G2_Scale, 0),
            float4(TINT_RED * G2_Tint, G2_Intensity),
            float4(G2_Edge_Intensity, G2_Edge_Curve, G2_Vignette + 0.3, G2_Feather), G2_Chroma);
    }
    pass p11 {
        SUNSPRITE_PASS(
			float4( 1 + 3 * G2_Offset_Scale, -2, G2_Scale * 1.3, 0),
            float4(TINT_BLUE * G2_Tint, G2_Intensity),
            float4(G2_Edge_Intensity, G2_Edge_Curve, G2_Vignette + 0.2, G2_Feather), G2_Chroma);
    }
    pass p12 {
        SUNSPRITE_PASS(
			float4( 1 + 2 * G2_Offset_Scale, 0, G2_Scale, 0),
            float4(TINT_BLUE * G2_Tint, G2_Intensity),
            float4(G2_Edge_Intensity, G2_Edge_Curve, G2_Vignette + 0.1, G2_Feather), G2_Chroma);
    }
    pass p13 {
        SUNSPRITE_PASS(
			float4( 1 + G2_Offset_Scale, 1, G2_Scale * 1.1, 0),
            float4(G2_Tint, G2_Intensity),
            float4(G2_Edge_Intensity, G2_Edge_Curve, G2_Vignette, G2_Feather), G2_Chroma);
    }
    pass p14 {
        SUNSPRITE_PASS(
			float4( 1, 0, G2_Scale, 0),
            float4(TINT_MAGENTA * G2_Tint, G2_Intensity),
            float4(G2_Edge_Intensity, G2_Edge_Curve, G2_Vignette, G2_Feather), G2_Chroma);
    }
    pass p15 {
        SUNSPRITE_PASS(
			float4( 1 - G2_Offset_Scale, 0, G2_Scale, 0),
            float4(TINT_MAGENTA * G2_Tint, G2_Intensity),
            float4(G2_Edge_Intensity, G2_Edge_Curve, G2_Vignette, G2_Feather), G2_Chroma);
    }
    pass p16 {
        SUNSPRITE_PASS(
			float4( 1 - 2 * G2_Offset_Scale, 0, G2_Scale * 0.5, 0),
            float4(TINT_GREEN * G2_Tint, G2_Intensity),
            float4(G2_Edge_Intensity, G2_Edge_Curve, G2_Vignette, G2_Feather), G2_Chroma);
    }
    pass p17 {
        SUNSPRITE_PASS(
			float4( 1 - 3 * G2_Offset_Scale, 2, G2_Scale * 0.9, 0),
            float4(TINT_CYAN * G2_Tint, G2_Intensity),
            float4(G2_Edge_Intensity, G2_Edge_Curve, G2_Vignette, G2_Feather), G2_Chroma);
    }
    pass p18 {
        SUNSPRITE_PASS(
			float4( 1 - 4 * G2_Offset_Scale, -1, G2_Scale * 0.7, 0),
            float4(TINT_CYAN * G2_Tint, G2_Intensity),
            float4(G2_Edge_Intensity, G2_Edge_Curve, G2_Vignette, G2_Feather), G2_Chroma);
    }
//////////////////////////////////Group3//////////////////////////////////
    pass p19 {
        SUNSPRITE_PASS(
			float4( -1 + 4 * G3_Offset_Scale, 0, G3_Scale * 0.7, 0),
            float4(TINT_CYAN * G3_Tint, G3_Intensity),
            float4(G3_Edge_Intensity, G3_Edge_Curve, G3_Vignette, G3_Feather), G3_Chroma);
    }
    pass p20 {
        SUNSPRITE_PASS(
			float4( -1 + 3 * G3_Offset_Scale, 2, G3_Scale * 0.9, 0),
            float4(TINT_CYAN * G3_Tint, G3_Intensity),
            float4(G3_Edge_Intensity, G3_Edge_Curve, G3_Vignette, G3_Feather), G3_Chroma);
    }
    pass p21 {
        SUNSPRITE_PASS(
			float4( -1 + 2 * G3_Offset_Scale, 2, G3_Scale * 1.5, 0),
            float4(TINT_GREEN * G3_Tint, G3_Intensity),
            float4(G3_Edge_Intensity, G3_Edge_Curve, G3_Vignette, G3_Feather), G3_Chroma);
    }
    pass p22 {
        SUNSPRITE_PASS(
			float4( -1 + G3_Offset_Scale, -1, G3_Scale * 1.7, 0),
            float4(TINT_GREEN * G3_Tint, G3_Intensity),
            float4(G3_Edge_Intensity, G3_Edge_Curve, G3_Vignette, G3_Feather), G3_Chroma);
    }
    pass p23 {
        SUNSPRITE_PASS(
			float4( -1, 0, G3_Scale * 1.4, 0),
            float4(TINT_BLUE * G3_Tint, G3_Intensity),
            float4(G3_Edge_Intensity, G3_Edge_Curve, G3_Vignette, G3_Feather), G3_Chroma);
    }
    pass p24 {
        SUNSPRITE_PASS(
			float4( -1 - G3_Offset_Scale, -2, G3_Scale * 1.3, 0),
            float4(TINT_BLUE * G3_Tint, G3_Intensity),
            float4(G3_Edge_Intensity, G3_Edge_Curve, G3_Vignette, G3_Feather), G3_Chroma);
    }
    pass p25 {
        SUNSPRITE_PASS(
			float4( -1 - 2 * G3_Offset_Scale, 1, G3_Scale, 0),
            float4(G3_Tint, G3_Intensity),
            float4(G3_Edge_Intensity, G3_Edge_Curve, G3_Vignette + 0.1, G3_Feather), G3_Chroma);
    }
    pass p26 {
        SUNSPRITE_PASS(
			float4( -1 - 3 * G3_Offset_Scale, 2, G3_Scale * 0.8, 0),
            float4(TINT_BLUE * G3_Tint, G3_Intensity),
            float4(G3_Edge_Intensity, G3_Edge_Curve, G3_Vignette + 0.2, G3_Feather), G3_Chroma);
    }
    pass p27 {
        SUNSPRITE_PASS(
			float4( -1 - 4 * G3_Offset_Scale, 0, G3_Scale * 0.6, 0),
            float4(TINT_BLUE * G3_Tint, G3_Intensity),
            float4(G3_Edge_Intensity, G3_Edge_Curve, G3_Vignette + 0.3, G3_Feather), G3_Chroma);
    }
//////////////////////////////////Group4//////////////////////////////////
    pass p28 {
        SUNSPRITE_PASS(
			float4( 1 + 4 * G4_Offset_Scale, 0, G4_Scale * 0.6, 0),
            float4(TINT_BLUE * G4_Tint, G4_Intensity),
            float4(G4_Edge_Intensity, G4_Edge_Curve, G4_Vignette + 0.3, G4_Feather), G4_Chroma);
    }
    pass p29 {
        SUNSPRITE_PASS(
			float4( 1 + 3 * G4_Offset_Scale, -1, G4_Scale * 0.8, 0),
            float4(TINT_CYAN * G4_Tint, G4_Intensity),
            float4(G4_Edge_Intensity, G4_Edge_Curve, G4_Vignette + 0.2, G4_Feather), G4_Chroma);
    }
    pass p30 {
        SUNSPRITE_PASS(
			float4( 1 + 2 * G4_Offset_Scale, 2, G4_Scale, 0),
            float4(G4_Tint, G4_Intensity),
            float4(G4_Edge_Intensity, G4_Edge_Curve, G4_Vignette + 0.1, G4_Feather), G4_Chroma);
    }
   pass p31 {
        SUNSPRITE_PASS(
			float4( 1 + G4_Offset_Scale, 0, G4_Scale * 1.2, 0),
            float4(TINT_BLUE * G4_Tint, G4_Intensity),
            float4(G4_Edge_Intensity, G4_Edge_Curve, G4_Vignette, G4_Feather), G4_Chroma);
    }
    pass p32 {
        SUNSPRITE_PASS(
			float4( 1, 1, G4_Scale * 1.5, -2),
            float4(TINT_GREEN * G4_Tint, G4_Intensity),
            float4(G4_Edge_Intensity, G4_Edge_Curve, G4_Vignette, G4_Feather), G4_Chroma);
    }
    pass p33 {
        SUNSPRITE_PASS(
			float4( 1 - G4_Offset_Scale, -2, G4_Scale * 1.5, 0),
            float4(TINT_MAGENTA * G4_Tint, G4_Intensity),
            float4(G4_Edge_Intensity, G4_Edge_Curve, G4_Vignette, G4_Feather), G4_Chroma);
    }
    pass p34 {
        SUNSPRITE_PASS(
			float4( 1 - 2 * G4_Offset_Scale, 0, G4_Scale, 0),
            float4(TINT_MAGENTA * G4_Tint, G4_Intensity),
            float4(G4_Edge_Intensity, G4_Edge_Curve, G4_Vignette, G4_Feather), G4_Chroma);
    }
    pass p35 {
        SUNSPRITE_PASS(
			float4( 1 - 3 * G4_Offset_Scale, 2, G4_Scale * 0.7, 0),
            float4(TINT_GREEN * G4_Tint, G4_Intensity),
            float4(G4_Edge_Intensity, G4_Edge_Curve, G4_Vignette, G4_Feather), G4_Chroma);
    }
    pass p36 {
        SUNSPRITE_PASS(
			float4( 1 - 4 * G4_Offset_Scale, 0, G4_Scale * 0.5, 0),
            float4(TINT_CYAN * G4_Tint, G4_Intensity),
            float4(G4_Edge_Intensity, G4_Edge_Curve, G4_Vignette, G4_Feather), G4_Chroma);
    }
////////////////////////////////Secondary////////////////////////////////
    pass p37 {
        SUNSPRITE_PASS_ALT(
			float4(S1_Offset, S1_Axis, S1_Scale, 1), float4(S1_Tint, S1_Intensity),
            float4(S1_Edge_Intensity, S1_Edge_Curve, S1_VigRadius, S1_Feather),
            float3(S1_Distort_Scale, S1_Chroma, S1_Distort_Offset));
    }
    pass p38 {
        SUNSPRITE_PASS_ALT(
			float4(S2_Offset, S2_Axis, S2_Scale, 1), float4(S2_Tint, S2_Intensity),
            float4(S2_Edge_Intensity, S2_Edge_Curve, S2_VigRadius, S2_Feather),
            float3(S2_Distort_Scale, S2_Chroma, S2_Distort_Offset));
    }
    pass p39 {
        SUNSPRITE_PASS_ALT(
			float4(S3_Offset, S3_Axis, S3_Scale, 1), float4(S3_Tint, S3_Intensity),
            float4(S3_Edge_Intensity, S3_Edge_Curve, S3_VigRadius, S3_Feather),
            float3(S3_Distort_Scale, S3_Chroma, S3_Distort_Offset));

    }
    pass p40 {
        SUNSPRITE_PASS_ALT(
			float4(S4_Offset, S4_Axis, S4_Scale, 1), float4(S4_Tint, S4_Intensity),
            float4(S4_Edge_Intensity, S4_Edge_Curve, S4_VigRadius, S4_Feather),
            float3(S4_Distort_Scale, S4_Chroma, S4_Distort_Offset));
    }
/*
    pass p41 {
        SUNSPRITE_PASS(
			float4(Sprite_Offset, Sprite_Axis, Sprite_Scale, 0),
            float4(Sprite_Tint, Sprite_Intensity),
            float4(Sprite_Edge_Intensity, Sprite_Edge_Curve, Sprite_VigRadius, Sprite_Feather), Sprite_Chroma_Axial);
    }
    pass p42 {
        SUNSPRITE_PASS(
			float4(Sprite_Offset, Sprite_Axis, Sprite_Scale, 0),
            float4(Sprite_Tint, Sprite_Intensity),
            float4(Sprite_Edge_Intensity, Sprite_Edge_Curve, Sprite_VigRadius, Sprite_Feather), Sprite_Chroma_Axial);
    }
    pass p43 {
        SUNSPRITE_PASS(
			float4(Sprite_Offset, Sprite_Axis, Sprite_Scale, 0),
            float4(Sprite_Tint, Sprite_Intensity),
            float4(Sprite_Edge_Intensity, Sprite_Edge_Curve, Sprite_VigRadius, Sprite_Feather), Sprite_Chroma_Axial);
    }
    pass p44 {
        SUNSPRITE_PASS(
			float4(Sprite_Offset, Sprite_Axis, Sprite_Scale, 0),
            float4(Sprite_Tint, Sprite_Intensity),
            float4(Sprite_Edge_Intensity, Sprite_Edge_Curve, Sprite_VigRadius, Sprite_Feather), Sprite_Chroma_Axial);
    }
    pass p45 {
        SUNSPRITE_PASS(
			float4(Sprite_Offset, Sprite_Axis, Sprite_Scale, 0),
            float4(Sprite_Tint, Sprite_Intensity),
            float4(Sprite_Edge_Intensity, Sprite_Edge_Curve, Sprite_VigRadius, Sprite_Feather), Sprite_Chroma_Axial);
    }
    pass p46 {
        SUNSPRITE_PASS(
			float4(Sprite_Offset, Sprite_Axis, Sprite_Scale, 0),
            float4(Sprite_Tint, Sprite_Intensity),
            float4(Sprite_Edge_Intensity, Sprite_Edge_Curve, Sprite_VigRadius, Sprite_Feather), Sprite_Chroma_Axial);
    }
    pass p47 {
        SUNSPRITE_PASS(
			float4(Sprite_Offset, Sprite_Axis, Sprite_Scale, 0),
            float4(Sprite_Tint, Sprite_Intensity),
            float4(Sprite_Edge_Intensity, Sprite_Edge_Curve, Sprite_VigRadius, Sprite_Feather), Sprite_Chroma_Axial);
    }
    pass p48 {
        SUNSPRITE_PASS(
			float4(Sprite_Offset, Sprite_Axis, Sprite_Scale, 0),
            float4(Sprite_Tint, Sprite_Intensity),
            float4(Sprite_Edge_Intensity, Sprite_Edge_Curve, Sprite_VigRadius, Sprite_Feather), Sprite_Chroma_Axial);
    }
    pass p49 {
        SUNSPRITE_PASS(
			float4(Sprite_Offset, Sprite_Axis, Sprite_Scale, 0),
            float4(Sprite_Tint, Sprite_Intensity),
            float4(Sprite_Edge_Intensity, Sprite_Edge_Curve, Sprite_VigRadius, Sprite_Feather), Sprite_Chroma_Axial);
    }
    pass p50 {
        SUNSPRITE_PASS(
			float4(Sprite_Offset, Sprite_Axis, Sprite_Scale, 0),
            float4(Sprite_Tint, Sprite_Intensity),
            float4(Sprite_Edge_Intensity, Sprite_Edge_Curve, Sprite_VigRadius, Sprite_Feather), Sprite_Chroma_Axial);
    }
*/
#ifdef ENABLE_GLARE
    pass p51 { //Glare
        SetVertexShader(CompileShader(vs_5_0, VS_Sprite(float4(-1, 0, 1.75, 1))));
        SetPixelShader(CompileShader(ps_5_0, PS_Glare(TextureSprite)));
        SetBlendState( DstAlpha_One, float4( 0,0,0,0 ), 0xFFFFFFFF );
    }
#endif
} //technique ends

