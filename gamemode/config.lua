MLRP = {}

MLRP.GMFolder = GM.Folder
MLRP.EnableMySQL = false

MLRP.Config = {
	VoiceRadius = 450,
}

MLRP.Logs = {
	SuppressWarn = false, //Suppress logging of server warnings
	SuppressSuccess = false,
	SuppressFail = false,
	SuppressCommand = false, //Suppresses player commands from being logged in the server console
	SuppressAction = false,
	SuppressDebug = false, //suppress debug messages, usually you wont need this unless there is a problem

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

	ExhaustedRunSpeed = 150, //sprint speed when player has low stamina
	WalkSpeed = 150, //default walking speed, not affected by stamina
	RunSpeed = 300, //default run speed
}

MLRP.BadWords = {
	BannedNames = { //example of some RP names that will get rejected, add as many as you want or leave blank to have no banned names
		//keep all the text in lowercase for better matching
		"nigger",
		"chink", 
		"mike hunt",
		"peter phile",
	}
}

MLRP.Props = { //list of banned props
	BannedProps = {
		["models/props_c17/oildrum001_explosive.mdl"] = true,
	},

	//put the model path of any chairs you add, this is used to stop the petrol meter and other actual vehicle things
	//from being shown. Gmod treats chairs as vehicles too.
	Chairs = { 
		"models/nova/airboat_seat.mdl",
		"models/props_phx/carseat.mdl",
		"models/props_phx/carseat2.mdl",
		"models/props_phx/carseat3.mdl",
		"models/nova/jalopy_seat.mdl",
		"models/nova/jeep_seat.mdl",
		"models/nova/chair_office01.mdl",
		"models/nova/chair_wood01.mdl",
		"models/nova/chair_office02.mdl",
		"models/nova/chair_plastic01.mdl",
	},

	MaxLimit = 500, //the absolute maximum prop limit, not even admins will be able to set over this
}

MLRP.Veh = {
	//Use this function for calculating the rate at which vehicles use fuel
	//If you've got the knowledge you can use this to make certain vehicles use less fuel
	FuelEfficiency = function(veh)
		//An example of varying efficiency based on the car
		/*
		if veh:GetModel() == "badcar.mdl" then
			return 0.35
		else
			return 0.1
		end
		//Would return a higher usage rate for a car with the model "badcar.mdl"
		*/

		//take 0.1 fuel each second the car has the engine enabled
		//This works out at around 1 full tank each ~15 minutes
		return 0.1 
	end
}

hook.Add("GetFallDamage", "customFallDamage", function(ply, speed)
	//use this hook to calculate your own fall damage numbers

	/* example

	local fall_damage = speed / 4 //this will set the fall damage to the players speed divided by 4
	return fall_damage //dont forget to add a return statement at the end, or the damage will stay default

	*/
end)