//Set to true to enable the debug commands
if true then 

MLRP.Logs.SuppressDebug = false //force debug messages to show, otherwise everything in here is useless

local function memusage()
	print([[////////// MEMORY USAGE \\\\\\\\\\]])
	logDebug(collectgarbage("count") / 1024)
end
concommand.Add("show_mem", memusage)

local function memcollect()
	print([[////////// MEMORY USAGE (PRE-COLLECTION) \\\\\\\\\\]])
	logDebug(collectgarbage("count") / 1024)
	collectgarbage("collect")
	print([[////////// MEMORY USAGE (POST-COLLECTION) \\\\\\\\\\]])
	logDebug(collectgarbage("count") / 1024)
end
concommand.Add("collect_garb", memcollect)

end