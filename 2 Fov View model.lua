local REF = gui.Reference( "Settings" )

local TAB = gui.Tab(REF, "lua_fov_tab", "Fov Changer")

local FOVBOX = gui.Groupbox(TAB, "FOV", 15, 15, 605, 500)
local SLIDER = gui.Slider( FOVBOX, "lua_fov_slider", "Field of View", 90, 0, 180 )
local SLIDER_ONE = gui.Slider( FOVBOX, "lua_fov_slider_one", "Field of View for 1st Zoom", 40, 0, 180 )
local SLIDER_TWO = gui.Slider( FOVBOX, "lua_fov_slider_two", "Field of View for 2nd Zoom", 15, 0, 180 )
local FOVBETWEENCHECK = gui.Checkbox( FOVBOX, "lua_fov_between__shot_checkbox", "Reset FOV between scoped shots" , 0 )

local VIEWBOX = gui.Groupbox(TAB, "Viewmodel", 15, 260, 605, 500)
local SLIDER_VIEW = gui.Slider( VIEWBOX, "lua_fov_slider_view", "Viewmodel Field of View", 60, 0, 180 )
local SLIDER_VIEWX = gui.Slider( VIEWBOX, "lua_fov_slider_viewX", "Viewmodel Offset X", 1, -40, 40 )
local SLIDER_VIEWY = gui.Slider( VIEWBOX, "lua_fov_slider_viewY", "Viewmodel Offset Y", 1, -40, 40 )
local SLIDER_VIEWZ = gui.Slider( VIEWBOX, "lua_fov_slider_viewZ", "Viewmodel Offset Z", -1, -40, 40 )

local betweenshot

callbacks.Register( "Draw", function()
    if(entities.GetLocalPlayer() ~= nil and engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil) then
        local a = 0
        local player_local = entities.GetLocalPlayer();
        local scoped = player_local:GetProp("m_bIsScoped")

        if scoped ~= 0 and scoped ~= 256 and (FOVBETWEENCHECK:GetValue() and tostring(scoped) == "65536") ~= true then
            local gWeapon = player_local:GetPropEntity("m_hActiveWeapon")
            local zoomLevel = gWeapon:GetProp("m_zoomLevel")
            if zoomLevel == 1 then 
                if SLIDER_ONE:GetValue() == 90 then
                    a = -40
                end
                client.SetConVar( "fov_cs_debug", SLIDER_ONE:GetValue(), true )
            elseif zoomLevel == 2 then 
                if SLIDER_TWO:GetValue() == 90 then
                    a = -40
                end
                client.SetConVar( "fov_cs_debug", SLIDER_TWO:GetValue(), true )
            end
        else
            client.SetConVar( "fov_cs_debug", SLIDER:GetValue(), true )
        end
        client.SetConVar("viewmodel_fov", SLIDER_VIEW:GetValue(), true)
        client.SetConVar("viewmodel_offset_x", SLIDER_VIEWX:GetValue(), true);
        client.SetConVar("viewmodel_offset_y", SLIDER_VIEWY:GetValue(), true);
        client.SetConVar("viewmodel_offset_z", SLIDER_VIEWZ:GetValue() + a, true);
    end
end)