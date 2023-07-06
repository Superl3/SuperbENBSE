float DayNightInt(float ExtDay, float ExtNight, float Int) {
	float Ext = lerp(ExtNight, ExtDay, ENightDayFactor);
	return lerp(Ext, Int, EInteriorFactor);
}