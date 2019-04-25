/**
 * CLibRef - clientInit
 * 
 * Author: James
 * 
 * Description:
 * Initializes the CLibRef flagInteraction module on the client-side. This example uses CLib's addAction
 * function to mimic the addAction command of Vanilla Arma3, that spawns its code in an scheduled environment
 * 
 * Parameter(s):
 * None
 * 
 * Return Value:
 * None
 * 
 */
// Include the macro-file from the module-root
#include "macros.hpp"
#define ACTION_DISTANCE 5

// write something to the log in order to show that this function actually got called
// Normally one would use the DUMP(MessageHere) macro for this kind of logging as the log
// messages would not be part of the final code when the ISDEV flag has not been set.
// But for demonstration purposes we always want this message to be logged
diag_log "Successfully loaded the CLibRef/flagInteraction module on the client";

// add an EventHandler (EH) that gets called as soon as a mission starts
// This clearly shows that the calling of the clientInit may be before the mission has
// started. Therefore one often wants to wrapt the code that should be executed in such an EH
// All available Clib-Events are listed here: https://github.com/TaktiCool/CLib/wiki/Events
["missionStarted", {
	diag_log "The mission has started";
	
	// CLib_Player is a special macro that holds a reference to the current player object
	// Similarly to e.g. the ACE_Player macro this does return something different than the player
	// SQF command when e.g. the player is currently remote controlling a unit via Zeus.
	// If yoi don't have any particular reason not to, you should use this macro instead of the player command
	if (!isNil "flagPole") then 
	{
		[
			"<t size='1.2' color='#00ff00'>Draw Flag</t>", // Title of the action <String, Code>
			flagPole, // Object or type which the action should be added to <Object, Array, String> 
			ACTION_DISTANCE, //  Distance in which the action is visible <Number>
			{!(_target getVariable ["owner", sideUnknown] isEqualTo side _this);}, // Condition which is evaluated on every frame if player is in range to determine if the action is visible <String, Code>
			FUNC(captureFlag), // Callback which gets called when the action is activated <Code>
			["arguments", [flagPole], "shortcut", "User1","radius", 5, "priority", 99] //  Optional named parameters <Array>
		] call CFUNC(addAction);
	};

}, []] call CFUNC(addEventHandler); // The macros CFUNC and CGVAR are similar to the FUNC and GVAR macros with the exception that
// the former ones will always refer to CLib-API functions/variables instead of this module's own functions/variables.