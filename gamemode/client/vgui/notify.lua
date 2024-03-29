/*
NOTIFY_GENERIC	= 0
NOTIFY_ERROR	= 1
NOTIFY_UNDO		= 2
NOTIFY_HINT		= 3
NOTIFY_CLEANUP	= 4
*/

local Notices = {}

function AddProgress( uid, text )
	if ( IsValid( Notices[ uid ] ) ) then
		Notices[ uid ].StartTime = SysTime()
		Notices[ uid ].Length = 1000000
		Notices[ uid ]:SetText( text )
		Notices[ uid ]:SetProgress()
		return
	end

	local parent = nil
	if ( GetOverlayPanel ) then parent = GetOverlayPanel() end

	local Panel = vgui.Create( "NoticePanel", parent )
	Panel.StartTime = SysTime()
	Panel.Length = 1000000
	Panel.VelX = -5
	Panel.VelY = 0
	Panel.fx = ScrW() + 200
	Panel.fy = ScrH()
	Panel:SetAlpha( 255 )
	Panel:SetText( text )
	Panel:SetPos( Panel.fx, Panel.fy )
	Panel:SetProgress()

	Notices[ uid ] = Panel

end

function Kill( uid )

	if ( !IsValid( Notices[ uid ] ) ) then return end

	Notices[ uid ].StartTime = SysTime()
	Notices[ uid ].Length = 0.8

end

function addMLRPNotify( text, type, length )

	local parent = nil
	if ( GetOverlayPanel ) then parent = GetOverlayPanel() end

	local Panel = vgui.Create( "MLRP.NotifyPanel", parent )
	Panel.StartTime = SysTime()
	Panel.Length = length
	Panel.VelX = -5
	Panel.VelY = 0
	Panel.fx = ScrW() + 200
	Panel.fy = ScrH()
	Panel:SetAlpha( 255 )
	Panel:SetText( text )
	Panel:SetLegacyType( type )
	Panel:SetPos( Panel.fx, Panel.fy )

	table.insert( Notices, Panel )

end

-- This is ugly because it's ripped straight from the old notice system
local function UpdateNotice( pnl, total_h )

	local x = pnl.fx
	local y = pnl.fy

	local w = pnl:GetWide() + 16
	local h = pnl:GetTall() + 4

	local ideal_y = ScrH() - 150 - h - total_h
	local ideal_x = ScrW() - w - 20

	local timeleft = pnl.StartTime - ( SysTime() - pnl.Length )

	-- Cartoon style about to go thing
	if ( timeleft < 0.7 ) then
		ideal_x = ideal_x - 50
	end

	-- Gone!
	if ( timeleft < 0.2 ) then
		ideal_x = ideal_x + w * 2
	end

	local spd = RealFrameTime() * 15

	y = y + pnl.VelY * spd
	x = x + pnl.VelX * spd

	local dist = ideal_y - y
	pnl.VelY = pnl.VelY + dist * spd * 1
	if ( math.abs( dist ) < 2 && math.abs( pnl.VelY ) < 0.1 ) then pnl.VelY = 0 end
	dist = ideal_x - x
	pnl.VelX = pnl.VelX + dist * spd * 1
	if ( math.abs( dist ) < 2 && math.abs( pnl.VelX ) < 0.1 ) then pnl.VelX = 0 end

	-- Friction.. kind of FPS independant.
	pnl.VelX = pnl.VelX * ( 0.95 - RealFrameTime() * 8 )
	pnl.VelY = pnl.VelY * ( 0.95 - RealFrameTime() * 8 )

	pnl.fx = x
	pnl.fy = y

	-- If the panel is too high up (out of screen), do not update its position. This lags a lot when there are lot of panels outside of the screen
	if ( ideal_y > -ScrH() ) then
		pnl:SetPos( pnl.fx, pnl.fy )
	end

	return total_h + h

end

local function Update()

	if ( !Notices ) then return end

	local h = 0
	for key, pnl in pairs( Notices ) do

		h = UpdateNotice( pnl, h )

	end

	for k, Panel in pairs( Notices ) do

		if ( !IsValid( Panel ) || Panel:KillSelf() ) then Notices[ k ] = nil end

	end

end
hook.Add( "Think", "MLRPNotifyThink", Update)

local PANEL = {}
function PANEL:Paint( w, h )

	self.BaseClass.Paint( self, w, h )

	surface.SetDrawColor(114, 114, 114, 255)
	surface.DrawRect(0, 0, w, h)
end
vgui.Register( "MLRP.NotifyPanel", PANEL, "NoticePanel" )

concommand.Add("notifytails", function(ply, args)
	addMLRPNotify(args[1], NOTIFY_GENERIC, 5)
end)