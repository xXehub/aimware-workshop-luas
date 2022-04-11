callbacks.Register("FireGameEvent", function(event)

    if event:GetName() == "round_start" then
        client.SetConVar("sv_skyname", "sky_descent", true);
    end

end)