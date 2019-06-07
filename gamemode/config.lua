MLRP = {}

MLRP.EnableMySQL = false

MLRP.Logs = {
	SuppressWarn = false, //Suppress logging of server warnings
	SuppressSuccess = false,
	SuppressFail = false,
	SuppressCommand = false, //Suppresses player commands from being logged in the server console
	SuppressAction = false,

	WarnColour = 		Color(244, 179, 066),
	FailColour = 		Color(255, 000, 000),
	SuccessColour = 	Color(000, 255, 000),
	ActionColour = 		Color(066, 206, 244),
	CommandColour = 	Color(190, 206, 097),
}

MLRP.Stats = {
	JumpDrain = 6, //amount of stamina lost after a jump

	HungerDrainTime = 45, //Time before 2 hunger is removed (in seconds)

	ThirstDrainTime = 30, //time before 3 thirst is removed (in seconds)
}

hook.Add("GetFallDamage", "customFallDamage", function(ply, speed)
	//use this hook to calculate your own fall damage numbers

	/* example

	local fall_damage = speed / 4 //this will set the fall damage to the players speed divided by 4
	return fall_damage //dont forget to add a return statement at the end, or the damage will stay default

	*/
end)