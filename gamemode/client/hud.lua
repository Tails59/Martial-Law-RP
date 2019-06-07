if SERVER then return end

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

local function HUDPaint(name)

end
hook.Add("HUDPaint", "drawHUD", HUDPaint)

local health_icon = Material("hudicons/heart_icon.png")
local hunger_icon = Material("hudicons/burger_icon.png")
local thirst_icon = Material("hudicons/water_icon.png")
local stamina_icon = Material("hudicons/running_icon.png")

local healthValue = 0
hook.Add("HUDPaint", "drawHealthbar", function()
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
 
	healthValue = Lerp(2.5 * FrameTime(), healthValue, LocalPlayer():Health()/100)
	surface.SetDrawColor( colour( colors.fill ))
	surface.DrawRect( x, y, w * healthValue, h)

	surface.SetMaterial(health_icon)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawTexturedRect(ScrW/2 - 25/2, 12, 25,25)
end)

local staminaval = 0
hook.Add("HUDPaint", "drawStaminaBar", function()
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
	 
	staminaval = Lerp(2.5 * FrameTime(), staminaval, LocalPlayer():getStamina()/100)
	surface.SetDrawColor( colour( colors.fill ))
	surface.DrawRect( x, y, w * staminaval, h)

	surface.SetMaterial(stamina_icon)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawTexturedRect(ScrW/2 - 25/2, variables.marginB - 29, 25,25)
end)

local hungerval = 0
hook.Add("HUDPaint", "drawHungerBar", function()
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
	 
	hungerval = Lerp(2.5 * FrameTime(), hungerval, LocalPlayer():getHunger()/100)
	surface.SetDrawColor( colour( colors.fill ))
	surface.DrawRect( x, y, w * hungerval, h)

	surface.SetMaterial(hunger_icon)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawTexturedRect(ScrW/2 - 25/2, variables.marginB - 0.062*ScrH + 3, 25,25)
end)

local thirstval = 0
hook.Add("HUDPaint", "drawThirstBar", function()
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
	 
	thirstval = Lerp(2.5 * FrameTime(), thirstval, LocalPlayer():getThirst()/100)
	surface.SetDrawColor( colour( colors.fill ))
	surface.DrawRect( x, y, w * thirstval, h)

	surface.SetMaterial(thirst_icon)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawTexturedRect(ScrW/2 - 25/2, variables.marginB - 0.094*ScrH + 3, 25,25)
end)
