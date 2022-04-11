callbacks.Register("Draw", function()
    if globals.TickCount() % 5 == 0 then
        gui.SetValue("rbot.antiaim.desync", 55)
        gui.SetValue("rbot.antiaim.desyncleft", 55)
        gui.SetValue("rbot.antiaim.desyncright", 55)
        gui.SetValue("rbot.antiaim.yaw", 165)
    else
        gui.SetValue("rbot.antiaim.desync", 25)
        gui.SetValue("rbot.antiaim.desyncleft", 25)
        gui.SetValue("rbot.antiaim.desyncright", 25)
        gui.SetValue("rbot.antiaim.yaw", 180)
    end
end)