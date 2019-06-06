if SERVER then
	function logSuccess(str)
		MsgC(Color(0, 255, 0), "[SUCCESS] ", str)
	end

	function logFail(err)
		MsgC(Color(255, 0, 0), "[FAIL] ", str)
	end

	function logAction(action)
		MsgC(Color(0, 0, 255), "[ACTION]", action)
	end

	function logCommand(command)
		MsgC(Color(190, 206, 97), "[COMMAND]", command)
	end
end