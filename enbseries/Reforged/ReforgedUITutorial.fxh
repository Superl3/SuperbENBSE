// ----------------------------------------------------------------------------------------------------------
// REFORGED UI TUTORIAL FILE
// by The Sandvich Maker
// ----------------------------------------------------------------------------------------------------------


// are you using a DX9 ENB?
#define DX9_ENB 0


#if DX9_ENB
    // In older DX9 ENBs that don't have the TimeOfDay1/2 variables but does have the WeatherAndTime variable
    // you can enable UI_CALCULATE_CUSTOM_TOD to make TOD parameters usable. You should provide your own
    // TOD values that match the ones set in the ENB GUI.

    // ALL OF THESE have to be defined BEFORE including ReforgedUI.fxh
    #define UI_CALCULATE_CUSTOM_TOD 1
    #define DAWN 2.0
    #define SUNRISE 7.50
    #define DAY 13.0
    #define SUNSET 18.50
    #define DUSK 2.0
    #define NIGHT 0.0 // doesn't actually do anything in my implementation
#endif



// Include the ReforgedUI.fxh file in your shader to start the fun
#include "Reforged/ReforgedUI.fxh"



// Every ENB UI element has to be unique, there are 128 separate unique whitespaces to use mapped to the
// numbers 1 through 128, it doesn't matter which you choose to use as long as it hasn't been used before in
// the same shader.
UI_WHITESPACE(128)
// UI_WHITESPACE(129) << don't do this! unless you want me to generate even more whitespace defines...


// There is a UI_MESSAGE macro for using parameters just to write some text, they need a unique
// identifier which can be just a number or anything else
UI_MESSAGE(Message1, "This is the Reforged UI tutorial.")
UI_MESSAGE(1, "And this is another message.")


UI_WHITESPACE(1)


// The default category for UI elements is NO_CATEGORY
#define UI_CATEGORY NO_CATEGORY


// UI_SEPARATOR will create a separator using the current defined UI_CATEGORY
UI_SEPARATOR


// UI_SEPARATOR_UNIQUE will take a unique identifier in the first argument the same as messages, and a string
// which represents the text you want to show up in the separator. This is relevant because you can make as
// many unique separators as you want independent of the UI_CATEGORY
UI_SEPARATOR_UNIQUE(1, "Unique Separator")


// The default prefix mode is MODE_NO_PREFIX. When UI_PREFIX_MODE is set to MODE_NO_PREFIX, UI elements will not
// have any added prefix.
#define UI_PREFIX_MODE NO_PREFIX


// You can make a new UI parameter with the syntax UI_type(variableName, uiName, args...)
// the number of arguments changes depending on the type of UI element
// UI_BOOL(variable name, ui name, default value)
UI_BOOL(Bool, "Some Bool", false)
// UI_INT(variable name, ui name, minimum value, maximum value, default value)
UI_INT(Int, "Some Int", 0, 2, 0)
// UI_QUALITY(variable name, ui name, minimum value, maximum value, default value)
UI_QUALITY(Quality, "Some Quality", -1, 3, 0)
// UI_FLOAT(variable name, ui name, minimum value, maximum value, default value)
UI_FLOAT(Float, "Some Float", 0.0, 1.0, 0.0)
// UI_FLOAT_FINE(variable name, ui name, minimum value, maximum value, default value, step size)
UI_FLOAT_FINE(FloatFine, "Some Fine Float", 0.0, 1.0, 0.0, 0.0001)
// UI_FLOAT3(variable name, ui name, default red, default green, default blue)
UI_FLOAT3(Float3, "Some Float3", 1.0, 0.25, 0.69)
// UI_FLOAT4(variable name, ui name, default x, default y, default z, default w)
UI_FLOAT4(Float4, "Some Float4", -1.0, 1.0, 0.5, -0.5)
	

UI_WHITESPACE(2)


// Here's an example of typical category usage.
#define UI_CATEGORY Category
// When UI_PREFIX_MODE is set to PREFIX, UI elements will have the current UI_CATEGORY added as a prefix.
#define UI_PREFIX_MODE PREFIX
UI_SEPARATOR
UI_BOOL(CategoryBool, "A Bool With A Category", false)


UI_WHITESPACE(3)


// Here's a more fancy example of category usage.
#define UI_CATEGORY CoolCategory

// When UI_PREFIX_MODE is set to CUSTOM_PREFIX, UI elements will have the string defined as UI_CUSTOM_PREFIX
// added as a prefix.
#define UI_PREFIX_MODE CUSTOM_PREFIX
#define UI_CUSTOM_PREFIX "Cool \xD7 Prefix"

UI_BOOL(CoolBool, "A\xB9 Cool\xB2 Bool\xB3", false)


UI_WHITESPACE(4)


// All of the UI parameters have a _MULTI equivalent which allows for creation of duplicates of the same
// parameter that represent various times of day / locations.
// All of the following can also accessed as UI_type_multiparameter instead of UI_type_MULTI(multiparameter, ...)

// The available multiparameter types are:
// SINGLE (it's just the one parameter)
// EI (Exterior/Interior)
// DNI / DN_I (Day/Night/Interior)
// DNE_DNI (Exterior: Day/Night, Interior: Day/Night)
// TODI / TOD_I (Dawn/Sunrise/Day/Dusk/Sunset/Night/Interior)
// TODE_DNI (Exterior: Dawn/Sunrise/Day/Dusk/Sunset/Night, Interior: Day/Night)
// TODE_TODI (Separate Exterior and Interior TOD parameters)

// There are two other types of multiparams that don't have a UI_type_multiparameter syntax equivalent
// because I forgot about them and adding them now would be a lot of work for something really not very useful.
// They are:
// DN (Day/Night, shared values for exterior and interior)
// TOD (Dawn/Sunrise/Day/Dusk/Sunset/Night, shared values for exterior and interior)

// You can set bools and integers to any of these as well, but transitions will be choppy, so for general
// use you probably only want to use EI. Maybe some Day/Night stuff if the transitions aren't noticable.

// Look at the examples below and the result in the ENB UI:
#define UI_CATEGORY Tonemap
#define UI_PREFIX_MODE NO_PREFIX
UI_SEPARATOR
UI_FLOAT_DNI(DNI_Brightness, "Brightness", 0.0, 10.0, 1.0)
UI_FLOAT_DNI(DNI_Saturation, "Saturation", 0.0, 10.0, 1.0)
UI_FLOAT_DNI(DNI_Contrast, "Contrast", 0.0, 10.0, 1.0)
UI_FLOAT_DNI(DNI_AdaptationMax, "AdaptationMax", 0.01, 2.0, 1.0)
UI_FLOAT_DNI(DNI_AdaptationMin, "AdaptationMin", 0.01, 2.0, 1.0)
UI_FLOAT_DNI(DNI_LinearStart, "LinearStart", 0.01, 1.0, 0.22)
UI_FLOAT_DNI(DNI_LinearEnd, "LinearEnd", 0.01, 1.0, 0.4)
UI_FLOAT_DNI(DNI_Black, "Black", 0.5, 3.0, 1.0)
UI_FLOAT_DNI(DNI_Pedestal, "Pedestal", 0.00, 1.0, 0.0)


UI_WHITESPACE(5)


// Any of the multiparam parameters can be used just as normal global variables, while the interpolation is
// handled behind the scenes:
static const float bBrightness = DNI_Brightness;
static const float bSaturation = DNI_Saturation;
static const float bContrast = DNI_Contrast;
static const float bAdaptationMax = DNI_AdaptationMax;
static const float bAdaptationMin = DNI_AdaptationMin;
static const float bLinearStart = DNI_LinearStart;
static const float bLinearEnd = DNI_LinearEnd;
static const float bBlack = DNI_Black;
static const float bPedestal = DNI_Pedestal;

UI_WHITESPACE(6)



// ----------------------------------------------------------------------------------------------------------
// UNIT TEST (it's not actually a unit test but I use this to test all of the parameters work)
// leave this alone if you don't know what the point is
// ----------------------------------------------------------------------------------------------------------
#define RUN_MACRO_UNIT_TEST 1
#define TEST_TODI_TOO 1

#if RUN_MACRO_UNIT_TEST
    #define TEST_TYPE SINGLE
    #include "Reforged/ReforgedUIUnitTest.fxh"
    #define TEST_TYPE EI
    #include "Reforged/ReforgedUIUnitTest.fxh"
    #define TEST_TYPE DN
    #include "Reforged/ReforgedUIUnitTest.fxh"
    #define TEST_TYPE DNI
    #include "Reforged/ReforgedUIUnitTest.fxh"
    #define TEST_TYPE DNE_DNI
    #include "Reforged/ReforgedUIUnitTest.fxh"
    #if TEST_TODI_TOO
        #define TEST_TYPE TOD
        #include "Reforged/ReforgedUIUnitTest.fxh"
        #define TEST_TYPE TODI
        #include "Reforged/ReforgedUIUnitTest.fxh"
        #define TEST_TYPE TODE_DNI
        #include "Reforged/ReforgedUIUnitTest.fxh"
        #define TEST_TYPE TODE_TODI
        #include "Reforged/ReforgedUIUnitTest.fxh"
    #endif
#endif