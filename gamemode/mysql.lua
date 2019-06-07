local db = MLRP.MySQL and MLRP.MySQL.database or nil
MLRP.MySQL = {}
MLRP.MySQL.database = db

MLRP.MySQL.User = ""
MLRP.MySQL.Password = ""
MLRP.MySQL.Database = ""
MLRP.MySQL.Table = "mlrp"
MLRP.MySQL.Host = ""
MLRP.MySQL.Port = 3306

if MLRP.EnableMySQL then
	local a, b = pcall(require, "tmysql4")

	if not a then 
		logFail("tmysql4 module is not installed and MySQL is set to enabled in the config!")
		logWarn("Reverting to file storage instead of MySQL!")
	else
		logSuccesss("Loaded tmysql4 module successfully!")
	end
else
	logWarn("Using file storage instead of MySQL!")
end

function dbConnect()
	if not MLRP.EnableMySQL then return end
	
	if MLRP.MySQL.database then
		dbDisconnect()
	end
	
	local err
	BaseWars.MySQL.database, err = tmysql.initialize(BaseWars.MySQL.Host, BaseWars.MySQL.User, BaseWars.MySQL.Password, BaseWars.MySQL.Database, BaseWars.MySQL.Port, nil, CLIENT_MULTI_STATEMENTS)
	
	if err or not MLRP.MySQL.database then
		BaseWars.MySQL.Enabled = false
		logFail("Couldn't establish connection to the MySQL database!")
		error(err)
	else
		logSuccess("Successfully connected to database!")
	end
end

function dbDisconnect()
	if not MLRP.EnableMySQL then return end
	
	if MLRP.MySQL.database then
		MLRP.MySQL.database:Disconnect()
	end
end