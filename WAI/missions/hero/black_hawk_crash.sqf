if(isServer) then {

	private 		["_mission","_playerPresent","_position","_crate","_baserunover"];

	_position		= [30] call find_position;
	_mission		= [_position,"Medium","Black Hawk Crash","MainHero",true] call init_mission;	
	
	diag_log 		format["WAI: [Hero] black_hawk_crash started at %1",_position];

	_num_guns		= round(random 5);
	_num_tools		= round(random 5);
	_num_items		= round(random 10);

	//Dynamic Box
	_crate 			= createVehicle ["BAF_VehicleBox",[(_position select 0),(_position select 1),0], [], 0, "CAN_COLLIDE"];
	[_crate,_num_guns,_num_tools,_num_items] call spawn_ammo_box;

	_baserunover 	= createVehicle ["UH60_ARMY_Wreck_burned_DZ",[((_position select 0)  + 15), ((_position select 1)  + 15), 0], [], 15, "FORM"];

	[[_position select 0, _position select 1, 0],3,"Medium","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0, _position select 1, 0],3,"Medium","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;

	//Turrets
	[[
		[(_position select 0) + 25, (_position select 1) + 25, 0],
		[(_position select 0) - 25, (_position select 1) - 25, 0]
	],"M2StaticMG","Easy","Bandit","Bandit",0,2,"Random","Random",_mission] call spawn_static;

	[
		[_mission,_crate],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 	// cleanup objects
		"A Black Hawk carrying supplies has crashed and bandits are securing the site! Check your map for the location!",	// mission announcement
		"Survivors have secured the crashed Black Hawk!",																	// mission success
		"Survivors did not secure the crashed Black Hawk in time"															// mission fail
	] call mission_winorfail;

	diag_log format["WAI: [Hero] black_hawk_crash ended at %1",_position];
	h_missionrunning = false;
};