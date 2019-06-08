
local function time()
	return os.date("%H:%M:%S", os.time())
end

function logSuccess(str)
	if MLRP.Logs.SuppressSuccess then return end
	MsgC(time().. " - ",MLRP.Logs.SuccessColour, "[SUCCESS] ", str)
	MsgN("")
end

function logFail(err)
	if MLRP.Logs.SuppressFail then return end
	MsgC(time().. " - ", MLRP.Logs.FailColour, "[FAIL] ", err)
	MsgN("")
end

function logAction(action)
	if MLRP.Logs.SuppressAction then return end
	MsgC(time().. " - ",MLRP.Logs.ActionColour, "[ACTION] ", action)
	MsgN("")
end

function logCommand(ply, command)
	if MLRP.Logs.SuppressCommand then return end
	MsgC(time().. " - ",MLRP.Logs.CommandColour, "[COMMAND] ", ply, command or "")
	MsgN("")
end

function logWarn(warn)
	if MLRP.Logs.SuppressWarn then return end
	MsgC(time().. " - ",MLRP.Logs.WarnColour, "[WARN] ", warn)
	MsgN("")
end

function logDebug(thing)
	if MLRP.Logs.SuppressDebug then return end
	MsgC(time().. " - ",Color(172, 110, 234), "[DEBUG] ", thing)
	MsgN("")
end

function logFatal(thing) //for big bad errors that will break the whole gm
	MsgC(time().. " - ",Color(255, 0, 0, 255), "[F A T A L] ", thing, " [F A T A L]")
	MsgN("")
end
