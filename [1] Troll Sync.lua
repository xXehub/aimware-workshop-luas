local PlayerFollow_Window = gui.Window( "PlayerFollow.Window", "Player Follow", 15, 20, 400, 350 )
local PlayerFollow_G_Keybinds = gui.Groupbox(PlayerFollow_Window, "Keybinds", 5, 5, 390, 150);
local PlayerFollow_G_Settings = gui.Groupbox(PlayerFollow_Window, "Settings", 5, 112, 390, 150);

local select_closest_team_key = gui.Keybox( PlayerFollow_G_Keybinds, "select_closest_team.key", "Select closest enemy", 6)
local deselect_closest_team_key = gui.Keybox( PlayerFollow_G_Keybinds, "deselect_closest_team.key", "Deselect closest enemy", 5)
deselect_closest_team_key:SetPosY(0)
deselect_closest_team_key:SetPosX(185)


-- Sync options
local sync_settings = gui.Multibox( PlayerFollow_G_Settings, "Sync settings" )
local PlayerFollow_SyncMovement = gui.Checkbox(sync_settings, "PlayerFollow.movement", "Sync movement", false)
local PlayerFollow_SyncScope = gui.Checkbox(sync_settings, "PlayerFollow.movement", "Sync scope", false)
local PlayerFollow_SyncDuck = gui.Checkbox(sync_settings, "PlayerFollow.movement", "Sync duck", false)
local PlayerFollow_SyncDpeek = gui.Checkbox(sync_settings, "PlayerFollow.movement", "Sync when team mate is very close and shoots (auto doublepeek)", false)

local PlayerFollow_DrawCircles = gui.Checkbox(PlayerFollow_G_Settings, "PlayerFollow.DrawCircles", "Draw circles above you and target", false)

gui.Text(PlayerFollow_G_Settings, "Teammate circle color")
local PlayerFollow_DrawTargetColor = gui.ColorPicker(PlayerFollow_G_Settings, "PlayerFollow.teammate_color", '', 255, 0, 0, 150)
PlayerFollow_DrawTargetColor:SetPosY(90)
PlayerFollow_DrawTargetColor:SetPosX(-210)


gui.Text(PlayerFollow_G_Settings, "Localplayer circle color")
local PlayerFollow_DrawMyColor = gui.ColorPicker(PlayerFollow_G_Settings, "PlayerFollow.my_color", '', 0, 0, 255, 150)
PlayerFollow_DrawMyColor:SetPosY(122)
PlayerFollow_DrawMyColor:SetPosX(-210)


function colorChannelMixer(colorChannelA, colorChannelB, amountToMix)
    channelA = colorChannelA*amountToMix
    channelB = colorChannelB*(1-amountToMix)
    return tonumber(channelA+channelB)
end

function colorMixer(rgbA, rgbB, amountToMix)
    r = colorChannelMixer(rgbA[1],rgbB[1],amountToMix)
    g = colorChannelMixer(rgbA[2],rgbB[2],amountToMix)
    b = colorChannelMixer(rgbA[3],rgbB[3],amountToMix)
    return draw.Color(r,g,b), {r,g,b}
end


local function DrawCircle(pos, radius, fill_color, outline_color)
    local center = {client.WorldToScreen(Vector3(pos.x, pos.y, pos.z)) }
    for degrees = 1, 360, 1 do
        local cur_point = nil;
        local old_point = nil;

        if pos.z == nil then
            cur_point = {pos.x + math.sin(math.rad(degrees)) * radius, pos.y + math.cos(math.rad(degrees)) * radius};    
            old_point = {pos.x + math.sin(math.rad(degrees - 1)) * radius, pos.y + math.cos(math.rad(degrees - 1)) * radius};
        else
            cur_point = {client.WorldToScreen(Vector3(pos.x + math.sin(math.rad(degrees)) * radius, pos.y + math.cos(math.rad(degrees)) * radius, pos.z))};
            old_point = {client.WorldToScreen(Vector3(pos.x + math.sin(math.rad(degrees - 1)) * radius, pos.y + math.cos(math.rad(degrees - 1)) * radius, pos.z))};
        end
                    
        if cur_point[1] ~= nil and cur_point[2] ~= nil and old_point[1] ~= nil and old_point[2] ~= nil then        
            -- fill
            if fill_color then
                draw.Color(unpack(fill_color))
            else
                draw.Color(255,0,0)
            end

            
            draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], center[1], center[2])
            -- outline
            if outline_color then
                draw.Color(unpack(outline_color))
            else
                draw.Color(0,0,0)
            end
            
            draw.Line(cur_point[1], cur_point[2], old_point[1], old_point[2]);        
        end
    end
end

function IsValid(entity)
  return pcall(function() tostring(entity:GetAbsOrigin()) end)
end

function is_movement_keys_down()
    return input.IsButtonDown( 87 ) or input.IsButtonDown( 65 ) or input.IsButtonDown( 83 ) or input.IsButtonDown( 68 ) or input.IsButtonDown( 32 ) or input.IsButtonDown( 17 )
end

local function get_closest_teammate()
 local me = entities.GetLocalPlayer()
 local closest = nil
 lowest_dist = 999999
 local players = entities.FindByClass( "CCSPlayer" );
 for k, v in pairs(players) do
 local distance = vector.Distance({v:GetAbsOrigin().x, v:GetAbsOrigin().y, v:GetAbsOrigin().z}, {entities.GetLocalPlayer():GetAbsOrigin().x, entities.GetLocalPlayer():GetAbsOrigin().y, entities.GetLocalPlayer():GetAbsOrigin().z})
 if distance < lowest_dist and v:IsAlive() and v:GetIndex() ~= me:GetIndex() and v:GetTeamNumber() == me:GetTeamNumber() then
 lowest_dist = distance
 closest = v
 end
 end
 return closest
end

function is_crouching(player)
 return player:GetProp('m_flDuckAmount') > 0.1
end

function is_scoped(player)
 if player:GetProp("m_bIsScoped") ~= 0 then return true else return false end
end


function move_to_pos(pos, cmd)
 local LocalPlayer = entities.GetLocalPlayer()
 local angle_to_target = (pos - entities.GetLocalPlayer():GetAbsOrigin()):Angles()
        -- local velocity = math.sqrt(tr.entity:GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + tr.entity:GetPropFloat( "localdata", "m_vecVelocity[1]" )^2)

    cmd.forwardmove = math.cos(math.rad((engine:GetViewAngles() - angle_to_target).y)) * 5540  
    cmd.sidemove = math.sin(math.rad((engine:GetViewAngles() - angle_to_target).y)) * 5540
end

local Target = false

client.AllowListener("weapon_fire")
callbacks.Register("FireGameEvent", function(e)
 if not PlayerFollow_SyncDpeek:GetValue() then return end


 if e and e:GetName() == "weapon_fire" then
    local shooter = entities.GetByUserID(e:GetInt('userid'))
    if shooter:GetTeamNumber() == entities.GetLocalPlayer():GetTeamNumber() and shooter:GetIndex() ~= entities.GetLocalPlayer():GetIndex() then
    local distance = vector.Distance({shooter:GetAbsOrigin().x, shooter:GetAbsOrigin().y, shooter:GetAbsOrigin().z}, {entities.GetLocalPlayer():GetAbsOrigin().x, entities.GetLocalPlayer():GetAbsOrigin().y, entities.GetLocalPlayer():GetAbsOrigin().z})
    print(distance)
    if distance < 35 then
    Target = shooter
    end
    end
 end
end)


callbacks.Register("CreateMove", function(cmd)
 if is_movement_keys_down() or not Target then return end

 if PlayerFollow_SyncMovement:GetValue() then
 move_to_pos(Target:GetAbsOrigin(), cmd)
 end

 if PlayerFollow_SyncDuck:GetValue() and is_crouching(Target) then
 cmd.buttons = bit.bor(cmd.buttons, 4)
 end
 
 if PlayerFollow_SyncScope:GetValue() and is_scoped(Target) ~= is_scoped(entities.GetLocalPlayer()) then
 cmd.buttons = bit.bor(cmd.buttons, 2048)
 end
end)

callbacks.Register("Draw", function()
 if input.IsButtonPressed(gui.GetValue("adv.menukey")) then
 PlayerFollow_Window:SetActive(not PlayerFollow_Window:IsActive())
 end

 if input.IsButtonDown(select_closest_team_key:GetValue()) then
 Target = get_closest_teammate()
 elseif input.IsButtonDown(deselect_closest_team_key:GetValue()) then
 Target = false
 end

 if not Target or not PlayerFollow_DrawCircles:GetValue() then return end

 local r1, g1, b1, a1 = PlayerFollow_DrawTargetColor:GetValue()
 local r2, g2, b2, a2 = PlayerFollow_DrawMyColor:GetValue()

 local alpha = 255
 if a1 == a2 then
 alpha = a1
 elseif a1 < a2 then
 alpha = a1
 elseif a2 < a1 then
 alpha = a2
 end


 if IsValid(Target) and IsValid(entities.GetLocalPlayer())  then 
 local distance = vector.Distance({Target:GetAbsOrigin().x, Target:GetAbsOrigin().y, Target:GetAbsOrigin().z}, {entities.GetLocalPlayer():GetAbsOrigin().x, entities.GetLocalPlayer():GetAbsOrigin().y, entities.GetLocalPlayer():GetAbsOrigin().z})
 if distance < 10 then
 local _, mixed_color_tbl = colorMixer({r1,g1,b1}, {r2,g2,b2}, 0.5)
 table.insert(mixed_color_tbl, alpha)
 DrawCircle(Target:GetAbsOrigin(), 15, mixed_color_tbl, {0,255,0})
 else
 DrawCircle(Target:GetAbsOrigin(), 15, {r1,g1,b1, a1}, {255,255,255})
 DrawCircle(entities.GetLocalPlayer():GetAbsOrigin(), 15, {r2,g2,b2, a2}, {255,255,255})
 end
 end
end)