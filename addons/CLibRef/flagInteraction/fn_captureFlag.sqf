/**
 * CLibRef - clientInit
 * 
 * Author: James
 * 
 * Description:
 * Code that will be executed once the action of the addAction command is triggered
 * 
 * Parameter(s):
 * 0: <OBJECT> flag that was captured
 * 
 * Return Value:
 * <BOOL> true - flag was captured successfully, false - otherwise
 * 
 */
// Include the macro-file from the module-root
#include "macros.hpp"

params 
[
	["_flag", objNull, [objNull], 1]
];

if (_flag isEqualTo objNull) exitWith {false};

_flag setFlagTexture "\A3\Data_F\Flags\Flag_red_CO.paa";

true