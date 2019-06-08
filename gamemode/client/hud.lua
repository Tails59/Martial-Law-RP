AddCSLuaFile()

local hud = {}

local function colour(col)
	return col.r, col.g, col.b, col.a
end

function hud:DrawBar(x, y, w, h, colors, value) //partly taken from https://maurits.tv/data/garrysmod/wiki/wiki.garrysmod.com/index1064.html
	surface.SetDrawColor( colour( colors.border ) )
	surface.DrawOutlinedRect( x, y, w, h )
 
	x = x + 1
	y = y + 1
	w = w - 2
	h = h - 2
 
	surface.SetDrawColor( colour( colors.background ) )
	surface.DrawRect( x, y, w, h )
 
	local width = w * math.Clamp( value, 0, 1 )
	surface.SetDrawColor( colour( colors.fill ))
	surface.DrawRect( x, y, width, h)
end

function hud:DrawPanel(x, y, w, h, background)
	surface.SetDrawColor(background)
	surface.DrawRect(x, y, w, h)
end

local ScrW, ScrH = ScrW(), ScrH()
local variables = {
	marginL = 35,
	marginT = 5,
	marginB = ScrH - 5,
	marginR = ScrW - 35,
}

local default_colours = {
	healthbar = {
		border = Color(0, 0, 0, 255),
		fill = Color(130, 40, 42, 200),
		background = Color(114, 114, 114, 150),
	},

	staminabar = {
		border = Color(0, 0, 0, 255),
		fill = Color(82, 64, 196, 255),
		background = Color(114, 114, 114, 255),
	},

	hungerbar = {
		border = Color(0, 0, 0, 255),
		fill = Color(128, 186, 107, 255),
		background = Color(114, 114, 114, 255),
	},

	thirstbar = {
		border = Color(0, 0, 0, 255),
		fill = Color(46, 149, 193, 255),
		background = Color(114, 114, 114, 255),
	},
}


local hide = {
	CHudHealth = true,
	CHudBattery = true,
}

hook.Add("HUDShouldDraw", "hidedefaulthud", function(name)
	if hide[name] then return false end
end)


local health_icon = Material("hudicons/heart_icon.png")
local hunger_icon = Material("hudicons/burger_icon.png")
local thirst_icon = Material("hudicons/water_icon.png")
local stamina_icon = Material("hudicons/running_icon.png")

local healthValue = 0
hook.Add("HUDPaint", "drawHealthbar", function()
	local ply = ply or LocalPlayer()
	local colors = default_colours.healthbar
	local x, y, w, h = ScrW/2 - 0.22*ScrW/2, 5, 0.22*ScrW, 0.035*ScrH

	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(x, y, w, h)

	x = x + 4
	y = y + 4
	w = w - 8
	h = h - 8
 
	surface.SetDrawColor( colour( colors.background ) )
	surface.DrawRect( x, y, w, h )
 
	healthValue = Lerp(2.5 * FrameTime(), healthValue, ply:Health()/100)
	surface.SetDrawColor( colour( colors.fill ))
	surface.DrawRect( x, y, w * healthValue, h)

	surface.SetMaterial(health_icon)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawTexturedRect(ScrW/2 - 25/2, 12, 25,25)
end)

local staminaval = 0
hook.Add("HUDPaint", "drawStaminaBar", function()
	local ply = ply or LocalPlayer()
	local colors = default_colours.staminabar
	local x, y, w, h = ScrW/2 - 0.22*ScrW/2, variables.marginB - 0.03*ScrH, 0.22*ScrW, 0.03*ScrH

	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(x, y, w, h)

	x = x + 4
	y = y + 4
	w = w - 8
	h = h - 8
	 
	surface.SetDrawColor( colour( colors.background ) )
	surface.DrawRect( x, y, w, h )
	 
	staminaval = Lerp(2.5 * FrameTime(), staminaval, ply:getStamina()/100)
	surface.SetDrawColor( colour( colors.fill ))
	surface.DrawRect( x, y, w * staminaval, h)

	surface.SetMaterial(stamina_icon)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawTexturedRect(ScrW/2 - 25/2, variables.marginB - 29, 25,25)
end)

local hungerval = 0
hook.Add("HUDPaint", "drawHungerBar", function()
	local ply = ply or LocalPlayer()
	local colors = default_colours.hungerbar
	local x, y, w, h = ScrW/2 - 0.22*ScrW/2, variables.marginB - 0.062*ScrH, 0.22*ScrW, 0.03*ScrH

	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(x, y, w, h)

	x = x + 4
	y = y + 4
	w = w - 8
	h = h - 8
	 
	surface.SetDrawColor( colour( colors.background ) )
	surface.DrawRect( x, y, w, h )
	 
	hungerval = Lerp(2.5 * FrameTime(), hungerval, ply:getHunger()/100)
	surface.SetDrawColor( colour( colors.fill ))
	surface.DrawRect( x, y, w * hungerval, h)

	surface.SetMaterial(hunger_icon)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawTexturedRect(ScrW/2 - 25/2, variables.marginB - 0.062*ScrH + 3, 25,25)
end)

local thirstval = 0
hook.Add("HUDPaint", "drawThirstBar", function()
	local ply = ply or LocalPlayer()
	local colors = default_colours.thirstbar
	local x, y, w, h = ScrW/2 - 0.22*ScrW/2, variables.marginB - 0.094*ScrH, 0.22*ScrW, 0.03*ScrH

	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(x, y, w, h)

	x = x + 4
	y = y + 4
	w = w - 8
	h = h - 8
	 
	surface.SetDrawColor( colour( colors.background ) )
	surface.DrawRect( x, y, w, h )
	 
	thirstval = Lerp(2.5 * FrameTime(), thirstval, ply:getThirst()/100)
	surface.SetDrawColor( colour( colors.fill ))
	surface.DrawRect( x, y, w * thirstval, h)

	surface.SetMaterial(thirst_icon)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawTexturedRect(ScrW/2 - 25/2 + 3, variables.marginB - 0.094*ScrH + 3, 20,25)
end)

surface.CreateFont("MLRP.Hud", {
	font = "Bahnschrift", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = ScreenScale(5),
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

surface.CreateFont("MLRP.HudLarge", {
	font = "Bahnschrift", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = ScreenScale(7),
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

local money_icon = Material("hudicons/coins.png")
local location_icon = Material("hudicons/location_icon.png")
local clan_icon = Material("hudicons/clan_icon.png")
local function drawInfoPanel()
	local ply = ply or LocalPlayer()
	hud:DrawPanel(variables.marginL, variables.marginB - 0.15*ScrH, 0.2*ScrW, 0.15*ScrH, Color(0, 0, 0, 200))

	local textw, texth;

	surface.SetFont("MLRP.HudLarge")
	textw, texth = surface.GetTextSize(ply:getRPName())
	draw.DrawText(ply:getRPName(), "MLRP.HudLarge", variables.marginL + 0.1*ScrW - textw/2, variables.marginB - 0.15*ScrH, Color(255, 255, 255, 255))

	textw, texth = surface.GetTextSize(ply:getMoney(true))
	surface.SetMaterial(money_icon)
	surface.DrawTexturedRect(variables.marginL + 18, variables.marginB - 0.115*ScrH, texth+ 10, texth+15)
	draw.DrawText(ply:getMoney(true), "MLRP.HudLarge", variables.marginL + 65, variables.marginB - 0.115*ScrH+5, Color(255, 255, 255, 255))

	surface.SetMaterial(location_icon)
	surface.DrawTexturedRect(variables.marginL + 18, variables.marginB - 0.075*ScrH, texth+ 10, texth+15)

	surface.SetMaterial(clan_icon)
	surface.DrawTexturedRect(variables.marginL + 10, variables.marginB - 0.035*ScrH, texth+ 26, texth+ 10)
end
hook.Add("HUDPaint", "infoPanelDraw", drawInfoPanel)