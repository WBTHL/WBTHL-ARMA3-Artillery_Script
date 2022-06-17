posGot = false;
hint "Open the map and click where you want to fire."
onMapSingleClick "target setPos _pos; posGot = true; false";

@posGot;
onMapSingleClick "";
hint "";

? ! (getPos target inRangeOfArtillery [units group f1, "32Rnd_155mm_Mo_shells"]) : goto "OutOfRange"

f1 sideChat "Target location received. Ordnance inbound. Out."
{[_x] exec "artyFire.sqf"} forEach [f1, f2, f3, f4, f5, f6];
_eta = floor (f1 getArtilleryETA [getPos target, "32Rnd_155mm_Mo_shells"]);
_marker = createMarker ["m1", getPos target];
"m1" setMarkerType "mil_destroy";
"m1" setMarkerColor "ColorRed";
_i = 0;
#ETA
"m1" setMarkerText format ["Fire Target - ETA %1 s", _eta - _i];
_i = _i + 1;
~1
? _i < _eta: goto "ETA"
f1 sideChat "Splash. Out."
deleteMarker "m1";
goto "End";

#OutOfRange
hint "Location is out of range.";
~5
hint "";

#End
exit;