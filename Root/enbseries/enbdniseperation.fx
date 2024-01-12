float DayNightInt(float ExtDay, float ExtNight, float Int) {
	float Ext = lerp(ExtNight, ExtDay, ENightDayFactor);
	return lerp(Ext, Int, EInteriorFactor);
}

float DayNightExtInt(float ExtDay, float ExtNight, float IntDay, float IntNight) {
	float Ext = lerp(ExtNight, ExtDay, ENightDayFactor);
	float Int = lerp(IntNight, IntDay, ENightDayFactor);
	return lerp(Ext, Int, EInteriorFactor);
}

float DayNightSunriseSunset(float Day, float Night, float Sunrise, float Sunset, float4 TimeOfDay1, float4 TimeOfDay2) {
	//Fourth
	float timeweight=0.000001;
	float timevalue=0.0;
		
	timevalue+=TimeOfDay1.x * Sunrise;
	timevalue+=TimeOfDay1.y * Sunrise;
	timevalue+=TimeOfDay1.z * Day;
	timevalue+=TimeOfDay1.w * Sunset;
	timevalue+=TimeOfDay2.x * Sunset;
	timevalue+=TimeOfDay2.y * Night;

	timeweight+=TimeOfDay1.x;
	timeweight+=TimeOfDay1.y;
	timeweight+=TimeOfDay1.z;
	timeweight+=TimeOfDay1.w;
	timeweight+=TimeOfDay2.x;
	timeweight+=TimeOfDay2.y;

	return timevalue / timeweight;
}

float DayNight(float Day, float Night) {
	return lerp(Day, Night, ENightDayFactor);
}

float TODSeperation(float Day, float Night, float Sunrise, float Sunset, float IntDay, float IntNight, float4 TimeOfDay1, float4 TimeOfDay2) {
	return lerp(DayNightSunriseSunset(Day,Night,Sunrise,Sunset, TimeOfDay1, TimeOfDay2), DayNight(IntDay, IntNight), EInteriorFactor);
}