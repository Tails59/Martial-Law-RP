if SERVER then
	function logSuccess(str)
		if MLRP.Logs.SuppressSuccess then return end
		MsgC(Color(0, 255, 0), "[SUCCESS] ", str)
		MsgN("")
	end

	function logFail(err)
		if MLRP.Logs.SuppressFail then return end
		MsgC(Color(255, 0, 0), "[FAIL] ", err)
		MsgN("")
	end

	function logAction(action)
		if MLRP.Logs.SuppressAction then return end
		MsgC(Color(0, 0, 255), "[ACTION] ", action)
		MsgN("")
	end

	function logCommand(ply, command)
		if MLRP.Logs.SuppressCommand then return end
		MsgC(Color(190, 206, 97), "[COMMAND] ", ply, command or "")
		MsgN("")
	end

	function logWarn(warn)
		if MLRP.Logs.SuppressWarn then return end
		MsgC(Color(244, 179, 66), "[WARN] ", warn)
		MsgN("")
	end
end