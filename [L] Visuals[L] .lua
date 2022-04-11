callbacks.Register("FireGameEvent", function(event)

	if event:GetName() == "round_start" then
		client.SetConVar("viewmodel_fov", 78, true)
		client.SetConVar("viewmodel_offset_z", -2, true)
		client.SetConVar("viewmodel_offset_x", 2, true)
		client.SetConVar("fov_cs_debug", 100, true);
	end

end)