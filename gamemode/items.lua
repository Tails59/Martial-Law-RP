AddCSLuaFile()
include("plugins/logs.lua")

/*
A lot of the code for the item system was taken/modified from Hexahedronic's Arista gamemode, an RP framework based off of applejack
https://github.com/hexahedronic/arista
*/

MLRP.Item = {}
MLRP.Item.Items = {}
MLRP.Item.Meta = {}
MLRP.Item.Cats = {}
MLRP.Item.Index = 0

MLRP.Item.Meta.__index = MLRP.Item.Meta

local mt = {
	__call = function(self, tab)
		return setmetatable(tab or {}, self)
	end
}
setmetatable(MLRP.Item.Meta, mt)
debug.getregistry().Item = MLRP.Item.Meta //does something im too underpaid to explain

function GM:LoadItems()
	logAction("Loading items...")
	local path = self.Folder.."/gamemode/items/"
	
	local files, folders, _
	files, _ = file.Find(path.."base/*.lua", "GAME")

	if not files then
		logFail("Failed to load items")
	end

	for _, filename in ipairs(files) do
		local filePath = path .. "base/" .. filename

		if filenname then
			ITEM = MLRP.Item.Meta
			ITEM.name = "NULL" -- For the search

			if SERVER then AddCSLuaFile(filePath) end
			include(filePath)

			local uid = filename:sub(1, -5)
			ITEM.uniqueID = uid
			ITEM:register()

			ITEM = nil
		end
	end

	logAction("Loading item categories...")

	local total = 0
	//_, folders = arista.file.findInLua(path .. "*")
	_, folders = file.Find(path.."*", "GAME")

	for _, filename in ipairs(folders) do
		local initPath = "items/"..filename.."/init.lua"

		if filename ~= "base" then
			local str, count = "", 0
			CAT = {}

			if SERVER then AddCSLuaFile(initPath) end
			include(initPath)

			-- Enumerations.
			local newCat = self:RegisterCategory(CAT)
			_G['CATEGORY_' .. filename:upper()] = newCat

			files, _ = file.Find(path..filename.."/*.lua", "GAME")

			for _, item in ipairs(files) do
				local filePath = path .. filename .. "/" .. item

				if item ~= "class.lua" then
					//if arista.config.vars.disabledItems[filename .. "/" .. item] then continue end
					ITEM = MLRP.Item.Meta

					if SERVER then AddCSLuaFile(filePath) end
					//include(filePath)

					local uid = item:sub(1, -5)
					ITEM.uniqueID = uid
					ITEM.category = newCat
					//ITEM:register()

					ITEM = nil

					str = str .. ", " .. uid
					count = count + 1
				end
			end

			str = str:sub(3)

			CAT = nil

			total = total + count
			logSuccess("Loaded category '" .. filename .. "' with " .. count .. " items")
		end
	end
	logSuccess("Loaded "..total.." items in total")
end

function GM:RegisterCategory(cat) 
	cat.index = MLRP.Item.Index
	MLRP.Item.Cats[cat.index] = cat

	MLRP.Item.Index = MLRP.Item.Index + 1

	return cat.index
end

function GM:GetCategory(id)
	if not id then
		logFail("GetCategory was passed nil")
	return end

	-- If we're passed a valid UniqueID, then return the item
	if MLRP.Item.Cats[id] then
		return MLRP.Item.Cats[id]
	end

	-- Otherwise, we're looking for part of a name.
	local res, len
	id = string.lower(id)

	for _, data in pairs(MLRP.Item.Cats) do
		local name = string.lower(data.name)

		if name:find(id, 1, true) then
			local lon = string.len(name)

			if res then
				if lon < len then
					res = data
					len = lon
				end
			else
				res = data
				len = lon
			end
		end
	end

	return res
end
MLRP.Item.GetCategory = GM.GetCategory

function GM:GetItem(id)
	if not id then
		logFail("GetItem was passed nil")
	return end

	-- If we're passed a valid UniqueID, then return the item
	if MLRP.Item.Items[id] then
		return MLRP.Item.Items[id]
	end

	-- Otherwise, we're looking for part of a name.
	local res, len
	id = string.lower(id)

	for _, data in pairs(MLRP.Item.Items) do
		local name = string.lower(data.name)


		if name:find(id, 1, true) then
			local lon = string.len(name)

			if res then
				if lon < len then
					res = data
					len = lon
				end
			else
				res = data
				len = lon
			end
		end
	end

	return res
end
MLRP.Item.GetItem = GM.GetItem
