--[[
# DON'T BE A DICK PUBLIC LICENSE

> Version 1.1, December 2016

> Copyright (C) [2020] [Sestain]

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document.

> DON'T BE A DICK PUBLIC LICENSE
> TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

1. Do whatever you like with the original work, just don't be a dick.

   Being a dick includes - but is not limited to - the following instances:

 1a. Outright copyright infringement - Don't just copy this and change the name.
 1b. Selling the unmodified original with no work done what-so-ever, that's REALLY being a dick.
 1c. Modifying the original work to contain hidden harmful content. That would make you a PROPER dick.

2. If you become rich through modifications, related works/services, or supporting the original work,
share the love. Only a dick would make loads off this work and not buy the original work's
creator(s) a pint.

3. Code is provided with no warranty. Using somebody else's code and bitching when it goes wrong makes
you a DONKEY dick. Fix the problem yourself. A non-dick would submit the fix back.
]]

local SCRIPT_FILE_NAME = GetScriptName()
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/Sestain/Aimware-Luas/master/Sestains%20Script/Sestains%20Script.lua"
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/sestain/Aimware-Luas/master/Sestains%20Script/version.txt"
local VERSION_NUMBER = "1.1"
local version_check_done = false
local update_downloaded = false
local update_available = false
local up_to_date = false
local updaterfont1 = draw.CreateFont("Bahnschrift", 18)
local updaterfont2 = draw.CreateFont("Bahnschrift", 14)
local updateframes = 0
local fadeout = 0
local spacing = 0
local fadein = 0

callbacks.Register( "Draw", "handleUpdates", function()
	if updateframes < 5.5 then
		if up_to_date or updateframes < 0.25 then
			updateframes = updateframes + globals.AbsoluteFrameTime()
			if updateframes > 5 then
				fadeout = ((updateframes - 5) * 510)
			end
			if updateframes > 0.1 and updateframes < 0.25 then
				fadein = (updateframes - 0.1) * 4500
			end
			if fadein < 0 then fadein = 0 end
			if fadein > 650 then fadein = 650 end
			if fadeout < 0 then fadeout = 0 end
			if fadeout > 255 then fadeout = 255 end
		end
		if updateframes >= 0.25 then fadein = 650 end
		for i = 0, 600 do
			local alpha = 200-i/3 - fadeout
			if alpha < 0 then alpha = 0 end
			draw.Color(15,15,15,alpha)
			draw.FilledRect(i - 650 + fadein, 0, i+1 - 650 + fadein, 30)
			draw.Color(255, 150, 75,alpha)
			draw.FilledRect(i - 650 + fadein, 30, i+1 - 650 + fadein, 31)
		end
		draw.SetFont(updaterfont1)
		draw.Color(255,150,75,255 - fadeout)
		draw.Text(7 - 650 + fadein, 7, "Sestain's")
		draw.Color(225,225,225,255 - fadeout)
		draw.Text(7 + draw.GetTextSize("Sestain's ") - 650 + fadein, 7, "Script")
		draw.Color(255,150,75,255 - fadeout)
		draw.Text(7 + draw.GetTextSize("Sestain's Script  ") - 650 + fadein, 7, "\\")
		spacing = draw.GetTextSize("Sestain's Script  \\  ")
		draw.SetFont(updaterfont2)
		draw.Color(225,225,225,255 - fadeout)
	end

    if (update_available and not update_downloaded) then
		draw.Text(7 + spacing - 650 + fadein, 9, "Downloading latest version.")
        local new_version_content = http.Get(SCRIPT_FILE_ADDR);
        local old_script = file.Open(SCRIPT_FILE_NAME, "w");
        old_script:Write(new_version_content);
        old_script:Close();
        update_available = false
        update_downloaded = true
	end
	
    if (update_downloaded) and updateframes < 5.5 then
		draw.Text(7 + spacing - 650 + fadein, 9, "Update available, please reload the script.")
    end

    if (not version_check_done) then
        version_check_done = true
		local version = http.Get(VERSION_FILE_ADDR)
		version = string.gsub(version, "\n", "")
		if (version ~= VERSION_NUMBER) then
            update_available = true
		else 
			up_to_date = true
		end
	end
	
	if up_to_date and updateframes < 5.5 then
		draw.Text(7 + spacing - 650 + fadein, 9, "Successfully loaded latest version: v" .. VERSION_NUMBER)
	end
end)



local w, h = draw.GetScreenSize()
local x = w/2
local y = h/2
local current_angle = 0
local drawLeft = 0
local drawRight = 0
local drawBack = 0
local in_act_sr = false;
local next_tick_should_fakelag = true

local rb_ref = gui.Reference("Ragebot")
local tab = gui.Tab(rb_ref, "sestain", "Sestain's Script")
local gb_r = gui.Groupbox(tab, "Anti-Aim & Other", 15, 15, 250, 400)
local gb_r2 = gui.Groupbox(tab, "Indicators", 280, 15, 335, 400)

local desync_indicator = gui.Checkbox(gb_r2, "desync_indicator", "Desync Indicator", false)
local desync_position_z = gui.Slider(gb_r2, "desync_z", "Desync Indicator's Z Position", y, 0, h)
local desync_bgcp = gui.ColorPicker(gb_r2, "desync_bgclr", "Desync Indicator's Background Color", 0,0,0,128)
local desync_icp = gui.ColorPicker(gb_r2, "desync_iclr", "Desync Indicator's Indicator Color", 0,135,206,235)
local manual_indicator = gui.Checkbox(gb_r2, "manual_indicator", "Manual AA Indicator", false)
local manual_position_z = gui.Slider(gb_r2, "manual_z", "Manual AA Indicator's Z Position", h/1.25, 0, h)
local manual_bgcp = gui.ColorPicker(gb_r2, "manual_bgclr", "Manual AA Indicator's Background Color", 0,0,0,128)
local manual_icp = gui.ColorPicker(gb_r2, "manual_iclr", "Manual AA Indicator's Indicator Color", 235,235,235,235)

local safe_revolver = gui.Checkbox(gb_r, "safe_revolver", "Safe Revolver", false)
local antionshot = gui.Checkbox(gb_r, "antionshot", "Anti Onshot", false)
local invert_key = gui.Keybox(gb_r, "ikey", "Invert Key", 0)
local legit_aa_key = gui.Keybox(gb_r, "lkey", "Legit AA Key", 0)
local left_key = gui.Keybox(gb_r, "left", "Manual AA to Left", 0)
local back_key = gui.Keybox(gb_r, "back", "Manual AA to Backwards", 0)
local right_key = gui.Keybox(gb_r,"right","Manual AA to Right", 0)
local rotation_angle = gui.Slider(gb_r, "rotationangle", "Rotation Offset", 0, -58, 58)
local lby_angle = gui.Slider(gb_r, "lbyangle", "LBY Offset", 0, -180, 180)

desync_indicator:SetDescription("Shows which side your anti-aim desync is with an arrow indicator")
desync_position_z:SetDescription("Changes desync indicator's height")
manual_indicator:SetDescription("Shows where manual anti-aim is set with an arrow indicator")
manual_position_z:SetDescription("Changes manual aa indicator's height")
safe_revolver:SetDescription("R8 Revolver shouldn't shoot ground anymore")
antionshot:SetDescription("This is useful in mm (Desyncs while shooting)")
invert_key:SetDescription("Key used to invert anti-aim")
legit_aa_key:SetDescription("Sets Anti-Aim 0° (Forward)")
left_key:SetDescription("Sets Anti-Aim 90° (Left)")
back_key:SetDescription("Sets Anti-Aim 180° (Backwards)")
right_key:SetDescription("Sets Anti-Aim -90° (Right)")
rotation_angle:SetDescription("Sets Rotation offset")
lby_angle:SetDescription("Sets LBY offset")

callbacks.Register( "weapon_fire", "fire", function()
	if not entities.GetLocalPlayer() then return end
	if not entities.GetLocalPlayer():IsAlive() then return end
	
	local ent = Entity.GetEntityFromUserID(Event.GetInt("userid"))
    if (ent ~= Entity.GetLocalPlayer()) then return end
    next_tick_should_fakelag = false
end)

callbacks.Register( "CreateMove", "cM", function()
	if not entities.GetLocalPlayer() then return end
	if not entities.GetLocalPlayer():IsAlive() then return end

	if gui.GetValue("rbot.sestain.antionshot") == true then
		if gui.GetValue("rbot.master") == true then
    		gui.SetValue("misc.fakelag.enable", true)
    		if not (next_tick_should_fakelag) then
    		    gui.SetValue("misc.fakelag.enable", false)
    		    next_tick_should_fakelag = true
			end
		end
	end
end)

callbacks.Register( "CreateMove", "create_move", function()
	if not entities.GetLocalPlayer() then return end
	if not entities.GetLocalPlayer():IsAlive() then return end

	local WeaponID = entities.GetLocalPlayer():GetWeaponID();

	if gui.GetValue("rbot.sestain.safe_revolver") == true then
		if gui.GetValue("rbot.master") == true then
    		if (WeaponType == 0 and WeaponID == 36) then
    		    in_act_sr = Math.round(1 / Globals.Frametime()) < 65 == true or false
    		    gui.SetValue("misc.fakelag.enable", Math.round(1 / Globals.Frametime()) < 65 == false or true)
    		else
    		    in_act_sr = false
    		    gui.SetValue("misc.fakelag.enable", true)
			end
		end
	end
end)

callbacks.Register( "Draw", "Antiaim", function()
	if gui.GetValue("rbot.master") == true then
		if invert_key:GetValue() ~= 0 then
			if input.IsButtonPressed(invert_key:GetValue()) then
				current_angle = current_angle == 0 and 1 or 0;
		end
	end

	if left_key:GetValue() ~= 0 then
		if input.IsButtonPressed(left_key:GetValue()) then
			drawLeft = drawLeft == 0 and 1 or 0;
			drawBack = 0
			drawRight = 0
			if drawLeft == 0 then
				gui.SetValue("rbot.antiaim.base", 180)
			elseif drawLeft == 1 then
				gui.SetValue("rbot.antiaim.base", 90)
			end
		end
	end

	if back_key:GetValue() ~= 0 then
		if input.IsButtonPressed(back_key:GetValue()) then
			drawLeft = 0
			drawBack = drawBack == 0 and 1 or 0;
			drawRight = 0
			if drawBack == 0 then
				gui.SetValue("rbot.antiaim.base", 180)
			elseif drawBack == 1 then
				gui.SetValue("rbot.antiaim.base", 180)
			end
		end
	end

	if right_key:GetValue() ~= 0 then
		if input.IsButtonPressed(right_key:GetValue()) then
			drawLeft = 0
			drawBack = 0
			drawRight = drawRight == 0 and 1 or 0;
			if drawRight == 0 then
				gui.SetValue("rbot.antiaim.base", 180)
			elseif drawRight == 1 then
				gui.SetValue("rbot.antiaim.base", -90)
			end
		end
	end

	if current_angle ~= 2 then
		local lby = current_angle == 0 and -lby_angle:GetValue() or lby_angle:GetValue()
		local rotation = current_angle == 0 and -rotation_angle:GetValue() or rotation_angle:GetValue()
			lby = 0 and -lby or lby
			rotation = 0 and -rotation or rotation
			gui.SetValue("rbot.antiaim.base.lby", lby)
			gui.SetValue("rbot.antiaim.base.rotation", rotation)
		else
			gui.SetValue("rbot.antiaim.base.lby", -lby)
			gui.SetValue("rbot.antiaim.base.rotation", -rotation)
		end
	end
end)

callbacks.Register( "Draw", "DesyncIndicator", function()
	if not entities.GetLocalPlayer() then return end
	
	local desync_bgr, desync_bgg, desync_bgb, desync_bga = desync_bgcp:GetValue()
	local desync_ir, desync_ig, desync_ib, desync_ia = desync_icp:GetValue()
	
	if gui.GetValue("rbot.sestain.desync_indicator") == true then
		if gui.GetValue("rbot.master") == true then
			if current_angle == 0 then 
				draw.Color(desync_ir, desync_ig, desync_ib, desync_ia)
				draw.Triangle(x + 55, desync_position_z:GetValue(), x + 35, desync_position_z:GetValue() + 10, x + 35, desync_position_z:GetValue() - 10)
				draw.Color(desync_bgr, desync_bgg, desync_bgb, desync_bga)
				draw.Triangle(x - 35, desync_position_z:GetValue() - 10, x - 35, desync_position_z:GetValue() + 10, x - 55, desync_position_z:GetValue())
			elseif current_angle == 1 then 
				draw.Color(desync_ir, desync_ig, desync_ib, desync_ia)
				draw.Triangle(x - 35, desync_position_z:GetValue() - 10, x - 35, desync_position_z:GetValue() + 10, x - 55, desync_position_z:GetValue())
				draw.Color(desync_bgr, desync_bgg, desync_bgb, desync_bga)
				draw.Triangle(x + 55, desync_position_z:GetValue(), x + 35, desync_position_z:GetValue() + 10, x + 35, desync_position_z:GetValue() - 10)
			end
		end
	end
end)

callbacks.Register( "Draw", "ManualIndicator", function()
	if not entities.GetLocalPlayer() then return end
	
	local manual_bgr, manual_bgg, manual_bgb, manual_bga = manual_bgcp:GetValue()
	local manual_ir, manual_ig, manual_ib, manual_ia = manual_icp:GetValue()
	
	if gui.GetValue("rbot.sestain.manual_indicator") == true then
		if gui.GetValue("rbot.master") == true then
			if drawLeft == 0 then
				draw.Color(manual_bgr, manual_bgg, manual_bgb, manual_bga)
				draw.Triangle(x - 50, manual_position_z:GetValue() + 10, x - 70, manual_position_z:GetValue(), x - 50, manual_position_z:GetValue() - 10)
			elseif drawLeft == 1 then
				draw.Color(manual_ir, manual_ig, manual_ib, manual_ia)
				draw.Triangle(x - 50, manual_position_z:GetValue() + 10, x - 70, manual_position_z:GetValue(), x - 50, manual_position_z:GetValue() - 10)
			end
		
			if drawBack == 0 then
				draw.Color(manual_bgr, manual_bgg, manual_bgb, manual_bga)
				draw.Triangle(x - 10, manual_position_z:GetValue() + 50, x + 10, manual_position_z:GetValue() + 50, x, manual_position_z:GetValue() + 70)
			elseif drawBack == 1 then
				draw.Color(manual_ir, manual_ig, manual_ib, manual_ia)
				draw.Triangle(x - 10, manual_position_z:GetValue() + 50, x + 10, manual_position_z:GetValue() + 50, x, manual_position_z:GetValue() + 70)
			end
			
			if drawRight == 0 then
				draw.Color(manual_bgr, manual_bgg, manual_bgb, manual_bga)
				draw.Triangle(x + 50, manual_position_z:GetValue() - 10, x + 70, manual_position_z:GetValue(), x + 50, manual_position_z:GetValue() + 10)
			elseif drawRight == 1 then
				draw.Color(manual_ir, manual_ig, manual_ib, manual_ia)
				draw.Triangle(x + 50, manual_position_z:GetValue() - 10, x + 70, manual_position_z:GetValue(), x + 50, manual_position_z:GetValue() + 10)
			end
		end
	end
end)

callbacks.Register( "Draw", "LegitAA", function()
	if not entities.GetLocalPlayer() then return end
	if not entities.GetLocalPlayer():IsAlive() then return end

	if legit_aa_key:GetValue() ~= 0 then
		if gui.GetValue("rbot.master") == true then
			if input.IsButtonDown( legit_aa_key:GetValue() ) then
				gui.SetValue( "rbot.antiaim.base", 0 )
				gui.SetValue( "rbot.antiaim.advanced.pitch", 0 )
			else
				gui.SetValue( "rbot.antiaim.base", 180 )
				gui.SetValue( "rbot.antiaim.advanced.pitch", 1 )
				if drawLeft == 1 then
					gui.SetValue("rbot.antiaim.base", 90)
				end
				if drawRight == 1 then
					gui.SetValue("rbot.antiaim.base", -90)
				end
			end
		end
	end
end)