float DayNightInt(float ExtDay, float ExtNight, float Int) {
	float Ext = lerp(ExtNight, ExtDay, ENightDayFactor);
	return lerp(Ext, Int, EInteriorFactor);
}

float DayNightExtInt(float ExtDay, float ExtNight, float IntDay, float IntNight) {
	float Ext = lerp(ExtNight, ExtDay, ENightDayFactor);
	float Int = lerp(IntNight, IntDay, ENightDayFactor);
	return lerp(Ext, Int, EInteriorFactor);
}