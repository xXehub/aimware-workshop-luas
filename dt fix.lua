local gui_gref = gui.Reference("Ragebot", "Aimbot", "Extra")
local gui_dtap = gui.Checkbox(gui_gref, "lua.dtap", "Double Tap Fix", 1)
local gui_shotswitch = gui.Checkbox(gui_gref, "lua.shotswitch", "Switch Desync On Shot", 0)
local cache = {shot, dtap}

local function switch(var)
    if var == 1 then
        return 2
    else
        return 1
    end
end

callbacks.Register("Draw", function()
    if cache.shot then
        gui.SetValue("rbot.antiaim.fakeyawstyle", switch(gui.GetValue("rbot.antiaim.fakeyawstyle")))
        cache.shot = false
    end
end)

callbacks.Register("CreateMove", function(cmd)
    if cache.dtap then
        cmd.sidemove = 0
        cmd.forwardmove = 0
        cache.dtap = false
    end
end)

callbacks.Register("FireGameEvent", function(event)
if not entities.GetLocalPlayer() then return end
    if ( event:GetName() == 'weapon_fire' ) then

        local lp = client.GetLocalPlayerIndex()
        local int_shooter = event:GetInt('userid')
        local index_shooter = client.GetPlayerIndexByUserID(int_shooter)

        if ( index_shooter == lp) then
            if gui_shotswitch:GetValue() then
                cache.shot = true
            end
            if gui_dtap:GetValue() then
                cache.dtap = true
            end
        end
    end
end)