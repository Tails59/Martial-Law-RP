if SERVER then
	function logSuccess(str)
		if MLRP.Logs.SuppressSuccess then return end
		MsgC(MLRP.Logs.SuccessColour, "[SUCCESS] ", str)
		MsgN("")
	end

	function logFail(err)
		if MLRP.Logs.SuppressFail then return end
		MsgC(MLRP.Logs.FailColour, "[FAIL] ", err)
		MsgN("")
	end

	function logAction(action)
		if MLRP.Logs.SuppressAction then return end
		MsgC(MLRP.Logs.ActionColour, "[ACTION] ", action)
		MsgN("")
	end

	function logCommand(ply, command)
		if MLRP.Logs.SuppressCommand then return end
		MsgC(MLRP.Logs.CommandColour, "[COMMAND] ", ply, command or "")
		MsgN("")
	end

	function logWarn(warn)
		if MLRP.Logs.SuppressWarn then return end
		MsgC(MLRP.Logs.WarnColour, "[WARN] ", warn)
		MsgN("")
	end
end