string strExtDay = "Exterior Day Parameters";

float	ExtDayBrightness
<
	string UIName = "ED: Brightness";
	string UIWidget = "Spinner";
	float UIMin = 1;
	float UIMax = 100;
> = { 1 };
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

string strExtNight = "Exterior Night Parameters";

float	ExtNightBrightness
<
	string UIName = "EN: Brightness";
	string UIWidget = "Spinner";
	float UIMin = 1;
	float UIMax = 100;
> = { 1 };
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

string strIntDay = "Interior Day Parameters";

float	IntDayBrightness
<
	string UIName = "ID: Brightness";
	string UIWidget = "Spinner";
	float UIMin = 1;
	float UIMax = 100;
> = { 1 };
float	IntDayAdaptationMax
<
	string UIName = "ID: AdaptationMax";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 5.00;
> = { 1 };
float	IntDayAdaptationMin
<
	string UIName = "ID: AdaptationMin";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 5.00;
> = { 1 };
float	IntDayContrast
<
	string UIName = "ID: Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.1;
	float UIMax = 5.0;
> = { 1.0 };
float	IntDayLinearSectionStart
<
	string UIName = "ID: LinearStart";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 1.00;
> = { 0.22 };
float	IntDayLinearSectionLength
<
	string UIName = "ID: LinearLength";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 1.00;
> = { 0.4 };
float	IntDayBlack
<
	string UIName = "ID: Black";
	string UIWidget = "Spinner";
	float UIMin = 1.00;
	float UIMax = 3.00;
> = { 1.33 };

string strIntNight = "Interior Night Parameters";

float	IntNightBrightness
<
	string UIName = "IN: Brightness";
	string UIWidget = "Spinner";
	float UIMin = 1;
	float UIMax = 100;
> = { 1 };
float	IntNightAdaptationMax
<
	string UIName = "IN: AdaptationMax";
	string UIWINget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 5.00;
> = { 1 };
float	IntNightAdaptationMin
<
	string UIName = "IN: AdaptationMin";
	string UIWINget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 5.00;
> = { 1 };
float	IntNightContrast
<
	string UIName = "IN: Contrast";
	string UIWidget = "Spinner";
	float UIMin = 0.1;
	float UIMax = 5.0;
> = { 1.0 };
float	IntNightLinearSectionStart
<
	string UIName = "IN: LinearStart";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 1.00;
> = { 0.22 };
float	IntNightLinearSectionLength
<
	string UIName = "IN: LinearLength";
	string UIWidget = "Spinner";
	float UIMin = 0.01;
	float UIMax = 1.00;
> = { 0.4 };
float	IntNightBlack
<
	string UIName = "IN: Black";
	string UIWidget = "Spinner";
	float UIMin = 1.00;
	float UIMax = 3.00;
> = { 1.33 };

//changes in range 0..1, 0 means that night time, 1 - day time

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

float ExtIntDayNight(float ExtDay, float ExtNight, float IntDay, float IntNight) {
	float Ext = lerp(ExtNight, ExtDay, ENightDayFactor);
	float Int = lerp(IntNight, IntDay, ENightDayFactor);
	return lerp(Ext, Int, EInteriorFactor);
}

float3 Tonemap_Uchimura(float3 x) {
	float Brightness = ExtIntDayNight(ExtDayBrightness, ExtNightBrightness, IntDayBrightness, IntNightBrightness);
	float Contrast = ExtIntDayNight(ExtDayContrast, ExtNightContrast, IntDayContrast, IntNightContrast);
	float LinearSectionStart = ExtIntDayNight(ExtDayLinearSectionStart, ExtNightLinearSectionStart, IntDayLinearSectionStart, IntNightLinearSectionStart);
	float LinearSectionLength = ExtIntDayNight(ExtDayLinearSectionLength, ExtNightLinearSectionLength, IntDayLinearSectionLength, IntNightLinearSectionLength);
	float Black = ExtIntDayNight(ExtDayBlack, ExtNightBlack, IntDayBlack, IntNightBlack);
	return Tonemap_Uchimura(x, Brightness, Contrast, LinearSectionStart, LinearSectionLength, Black, 0.0);
	/*
	const float P = 1.0;  // max display brightness
	const float a = 1.0;  // contrast
	const float m = 0.22; // linear section start
	const float l = 0.4;  // linear section length
	const float c = 1.33; // black
	const float b = 0.0;  // pedestal
	return Tonemap_Uchimura(x, P, a, m, l, c, b);
	*/
}
