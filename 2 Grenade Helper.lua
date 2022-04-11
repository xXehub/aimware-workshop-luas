-- Grenade Helper by ShadyRetard, updated to v5 by TitanumIchigo

local WALK_SPEED = 100;
local DRAW_MARKER_DISTANCE = 100;
local GH_ACTION_COOLDOWN = 30;
local GAME_COMMAND_COOLDOWN = 40;
local GRENADE_SAVE_FILE_NAME = "grenade_helper_data.dat";

local TabPosition = gui.Reference("VISUALS");

local TAB = gui.Tab(TabPosition, "gh_tab", "Grenade Helper");

local MULTIBOX = gui.Groupbox(TAB, "Grenade Helper", 15, 15, 295, 400);

local GH_ENABLED = gui.Checkbox( MULTIBOX, "gh_enabled", "Grenade Helper Enabled", 1 );
local RECT_SIZE = gui.Slider(MULTIBOX, "gh_rect_size", "Throw Rect Size", 10, 0, 25);
local GH_CHECKBOX_THROWRECT = gui.Checkbox( MULTIBOX, "gh_ch_throw", "Throw Rectangle Enabled", 1 );
local GH_CHECKBOX_HELPERLINE = gui.Checkbox( MULTIBOX, "gh_ch_throwline", "Throw Helper Line Enabled", 1 );
local GH_CHECKBOX_BOXSTAND = gui.Checkbox( MULTIBOX, "gh_ch_standbox", "Stand Box Enabled", 1 );
local GH_CHECKBOX_OOD = gui.Checkbox( MULTIBOX, "gh_ch_standbox_ood", "Stand Box Out of Distance Custom Color Enabled", 1 );
local GH_CHECKBOX_TEXT = gui.Checkbox( MULTIBOX, "gh_ch_text", "Text Enabled (Name)", 1 );
local GH_VISUALS_DISTANCE_SL = gui.Slider(MULTIBOX, "gh_max_distance", "Max Distance", 3000, 0, 5000);
local GH_CHECKBOX_FIXSTRAFE = gui.Checkbox(MULTIBOX, "gh_fix_strafe", "Affect Autostrafe", 1);
local GH_CHECKBOX_FIXSTRAFEAIR = gui.Checkbox(MULTIBOX, "gh_fix_airstrafe", "Affect Airstrafe", 1);
local THROW_RADIUS = gui.Slider(MULTIBOX, "gh_box_radius", "GH Box Size", 20, 0, 50);


local GH_CHECKBOX_KEYBINDS = gui.Checkbox( MULTIBOX, "gh_ch_keybinds", "Enable Keybinds", 0 );
local GH_ADD = gui.Keybox(MULTIBOX, "gh_kb_add", "Add Throw", 0);
local GH_REMOVE = gui.Keybox(MULTIBOX, "gh_kb_rem", "Remove Throw", 0);

local CLR_THROW = gui.ColorPicker(GH_CHECKBOX_THROWRECT, "gh_clr_throw", "Grenade Helper Throw Point", 255, 0, 0, 255);
local CLR_HELPER_LINE = gui.ColorPicker(GH_CHECKBOX_HELPERLINE, "gh_clr_helper", "Grenade Helper Line Color", 233, 212, 96, 255);
local CLR_STAND_BOX = gui.ColorPicker(GH_CHECKBOX_BOXSTAND, "gh_clr_standbox", "Grenade Helper Location", 0, 230, 64, 255);
local CLR_STAND_BOX_OOD = gui.ColorPicker(GH_CHECKBOX_OOD, "gh_clr_standbox_oop", "Grenade Helper Location (Out)", 22, 160, 133, 255);
local CLR_TEXT = gui.ColorPicker(GH_CHECKBOX_TEXT, "gh_clr_text", "Grenade Helper Text Color", 255, 255, 255, 255);



local maps = {}

local GH_WINDOW_ACTIVE = false;

local window_show = false;
local window_cb_pressed = true;
local should_load_data = true;
local last_action = globals.TickCount();
local throw_to_add;
local chat_add_step = 1;
local message_to_say;
local my_last_message = globals.TickCount();
local screen_w, screen_h = 0,0;
local should_load_data = true;

local nade_type_mapping = {
    "auto",
    "smokegrenade",
    "flashbang",
    "hegrenade",
    "molotovgrenade";
    "decoy";
}

local throw_type_mapping = {
    "stand",
    "jump",
    "run",
    "crouch",
    "right",
	"leftright",
	"jumpcrouch",
	"jumpleftright",
	"jumpright",
	"runjump";
}

local chat_add_messages = {
    "[GH] Welcome to GH Setup. Type 'cancel' at any time to cancel. Please enter the name of the throw (e.g. CT to B site):",
    "[GH] Please enter the throw type (stand / jump / run / crouch / right / leftright / jumpcrouch / runjump / jumpleftright / jumpright):"
}

-- Just open up the file in append mode, should create the file if it doesn't exist and won't override anything if it does
local my_file = file.Open(GRENADE_SAVE_FILE_NAME, "a");
my_file:Close();

local current_map_name;

function gameEventHandler(event)
	if (GH_ENABLED:GetValue() == false) then
		return
	end

	local event_name = event:GetName();
	
    if (event_name == "player_say" and throw_to_add ~= nil) then
        local self_pid = client.GetLocalPlayerIndex();
        print(self_pid);
        local chat_uid = event:GetInt('userid');
        local chat_pid = client.GetPlayerIndexByUserID(chat_uid);
        print(chat_pid);

        if (self_pid ~= chat_pid) then
            return;
        end

        my_last_message = globals.TickCount();

        local say_text = event:GetString('text');

        if (say_text == "cancel") then
            message_to_say = "[GH] Throw cancelled";
            throw_to_add = nil;
            chat_add_step = 0;
            return;
        end

        -- Don't use the bot's messages
        if (string.sub(say_text, 1, 4) == "[GH]") then
            return;
        end

        -- Enter name
        if (chat_add_step == 1) then
            throw_to_add.name = say_text;
        elseif (chat_add_step == 2) then
            if (hasValue(throw_type_mapping, say_text) == false) then
                message_to_say = "[GH] The throw type '" .. say_text .. "' is invalid, please enter one of the following values: stand / jump / run / crouch / right";
                return;
            end

            throw_to_add.type = say_text;
            message_to_say = "[GH] Your throw '" .. throw_to_add.name .. "' - " .. throw_to_add.type .. " has been added.";
            table.insert(maps[current_map_name], throw_to_add);
            throw_to_add = nil;
            local value = convertTableToDataString(maps);
            local data_file = file.Open(GRENADE_SAVE_FILE_NAME, "w");
            if (data_file ~= nil) then
                data_file:Write(value);
                data_file:Close();
            end

            chat_add_step = 0;
            return;
        else
            chat_add_step = 0;
            return;
        end

        chat_add_step = chat_add_step + 1;
        message_to_say = chat_add_messages[chat_add_step];

        return;
    end
end

function doAdd(cmd)
	local me = entities.GetLocalPlayer();
    if (current_map_name == nil or maps[current_map_name] == nil or me == nil or not me:IsAlive()) then
        return;
    end
	
	local myPos = me:GetAbsOrigin();
	local angles = cmd:GetViewAngles();
	local nade_type = getWeaponName(me);
    if (nade_type ~= nil and nade_type ~= "smokegrenade" and nade_type ~= "flashbang" and nade_type ~= "molotovgrenade" and nade_type ~= "hegrenade" and nade_type ~= "decoy") then
        return;
    end
	
	local new_throw = {
        name = "",
        type = "not_set",
        nade = nade_type,
        pos = {
            x = myPos.x,
            y = myPos.y,
            z = myPos.z
        },
        ax = angles.x,
        ay = angles.y
    };
	
	throw_to_add = new_throw;
    chat_add_step = 1;
    message_to_say = chat_add_messages[chat_add_step];
end

function removeFirstThrow(throw)
    for i, v in ipairs(maps[current_map_name]) do
        if (v.name == throw.name and v.pos.x == throw.pos.x and v.pos.y == throw.pos.y and v.pos.z == throw.pos.z) then
            return table.remove(maps[current_map_name], i);
        end
    end
end

function doDel(throw)
	if (current_map_name == nil or maps[current_map_name] == nil) then
        return;
    end

    removeFirstThrow(throw);

    local value = convertTableToDataString(maps);
    local data_file = file.Open(GRENADE_SAVE_FILE_NAME, "w");
    if (data_file ~= nil) then
        data_file:Write(value);
        data_file:Close();
    end
end

function moveEventHandler(cmd)

	if (GH_ENABLED:GetValue() == false) then
		return
	end

	local me = entities.GetLocalPlayer();
	

    if (current_map_name == nil or maps == nil or maps[current_map_name] == nil or me == nil or not me:IsAlive()) then
        throw_to_add = nil;
        chat_add_step = 1;
        message_to_say = nil;
        return;
    end
	
	if (throw_to_add ~= nil) then
        return;
    end
	
	local add_keybind = GH_ADD:GetValue();
    local del_keybind = GH_REMOVE:GetValue();
	
	if (GH_CHECKBOX_KEYBINDS:GetValue() == false or (add_keybind == 0 and del_keybind == 0)) then
        return;
    end
	
	if (last_action ~= nil and last_action > globals.TickCount()) then
        last_action = globals.TickCount();
    end

    if (add_keybind ~= 0 and input.IsButtonDown(add_keybind) and globals.TickCount() - last_action > GH_ACTION_COOLDOWN) then
        last_action = globals.TickCount();
        return doAdd(cmd);
    end

    local closest_throw, distance = getClosestThrow(maps[current_map_name], me, cmd);
    if (closest_throw == nil or distance > THROW_RADIUS:GetValue()) then
        return;
    end

    if (del_keybind ~= 0 and input.IsButtonDown(del_keybind) and globals.TickCount() - last_action > GH_ACTION_COOLDOWN) then
        last_action = globals.TickCount();
        return doDel(closest_throw);
    end
end

function drawEventHandler()
	if (GH_ENABLED:GetValue() == false) then
		return
	end

    if (should_load_data) then
        loadData();
        should_load_data = false;
    end

    screen_w, screen_h = draw.GetScreenSize();

    local active_map_name = engine.GetMapName();

    -- If we don't have an active map, stop
    if (active_map_name == nil or maps == nil) then
        return;
    end

    if (maps[active_map_name] == nil) then
        maps[active_map_name] = {};
    end

    if (current_map_name ~= active_map_name) then
        current_map_name = active_map_name;
    end

    if (maps[current_map_name] == nil) then
        return;
    end

    if (my_last_message ~= nil and my_last_message > globals.TickCount()) then
        my_last_message = globals.TickCount();
    end

    if (message_to_say ~= nil and globals.TickCount() - my_last_message > 100) then
        client.ChatTeamSay(message_to_say);
        message_to_say = nil;
    end

    showNadeThrows();
end


function loadData()
    local data_file = file.Open(GRENADE_SAVE_FILE_NAME, "r");
    if (data_file == nil) then
        return;
    end
    local throw_data = data_file:Read();
    data_file:Close();
    if (throw_data ~= nil and throw_data ~= "") then
       maps = parseStringifiedTable(throw_data);
    end
end

function showNadeThrows()
    local me = entities:GetLocalPlayer();
	if (me == nil) then
        return;
    end

	local myPos = me:GetAbsOrigin();
    local weapon_name = getWeaponName(me);

    if (weapon_name ~= nil and weapon_name ~= "smokegrenade" and weapon_name ~= "flashbang" and weapon_name ~= "molotovgrenade" and weapon_name ~= "hegrenade" and weapon_name ~= "decoy") then
		if GH_CHECKBOX_FIXSTRAFE:GetValue() then
			gui.SetValue("misc.strafe.enable", 1);
		end
		if GH_CHECKBOX_FIXSTRAFEAIR:GetValue() then
			gui.SetValue("misc.strafe.air", 1);
		end
        return;
    end


    local throws_to_show, within_distance = getActiveThrows(maps[current_map_name], me, weapon_name);

	if GH_CHECKBOX_FIXSTRAFE:GetValue() then
		gui.SetValue("misc.strafe.enable", 1);
	end
	if GH_CHECKBOX_FIXSTRAFEAIR:GetValue() then
		gui.SetValue("misc.strafe.air", 1);
	end
	
    for i=1, #throws_to_show do
        local throw = throws_to_show[i];
				
		local throwVector = Vector3(throw.pos.x, throw.pos.y, throw.pos.z);
        local cx, cy = client.WorldToScreen(throwVector);

        if (within_distance) then
			if GH_CHECKBOX_FIXSTRAFE:GetValue() then
				gui.SetValue("misc.strafe.enable", 0);
			end
			if GH_CHECKBOX_FIXSTRAFEAIR:GetValue() then
				gui.SetValue("misc.strafe.air", 0);
			end
            local z_offset = 64;
            if (throw.type == "crouch") then
                z_offset = 46;
            end

            local t_x, t_y, t_z = getThrowPosition(throw.pos.x, throw.pos.y, throw.pos.z, throw.ax, throw.ay, z_offset);
			local drawVector = Vector3(t_x, t_y, t_z);
            local draw_x, draw_y = client.WorldToScreen(drawVector);
            if (draw_x ~= nil and draw_y ~= nil) then
				-- Draw rectangle for throw point
				if GH_CHECKBOX_THROWRECT:GetValue() then
					draw.Color(CLR_THROW:GetValue());
					local rSize = RECT_SIZE:GetValue();
					draw.RoundedRect(draw_x - rSize, draw_y - rSize, draw_x + rSize, draw_y + rSize);
				end
				
                -- Draw a line from the center of our screen to the throw position
				if GH_CHECKBOX_HELPERLINE:GetValue() then
					draw.Color(CLR_HELPER_LINE:GetValue());
					draw.Line(draw_x, draw_y, screen_w / 2, screen_h / 2);				
				end
				              
				-- Draw throw type
				if GH_CHECKBOX_TEXT:GetValue() then
					draw.Color(CLR_TEXT:GetValue());
					local text_size_w, text_size_h = draw.GetTextSize(throw.name);
					draw.Text(draw_x - text_size_w / 2, draw_y - 30 - text_size_h / 2, throw.name);
					text_size_w, text_size_h = draw.GetTextSize(throw.type);
					draw.Text(draw_x - text_size_w / 2, draw_y - 20 - text_size_h / 2, throw.type);
				end
            end
        end
		
    	local ulVector = Vector3(throw.pos.x - THROW_RADIUS:GetValue() / 2, throw.pos.y - THROW_RADIUS:GetValue() / 2, throw.pos.z);
        local ulx, uly = client.WorldToScreen(ulVector);
		local blVector = Vector3(throw.pos.x - THROW_RADIUS:GetValue() / 2, throw.pos.y + THROW_RADIUS:GetValue() / 2, throw.pos.z);
        local blx, bly = client.WorldToScreen(blVector);
		local urVector = Vector3(throw.pos.x + THROW_RADIUS:GetValue() / 2, throw.pos.y - THROW_RADIUS:GetValue() / 2, throw.pos.z);
        local urx, ury = client.WorldToScreen(urVector);
		local brVector = Vector3(throw.pos.x + THROW_RADIUS:GetValue() / 2, throw.pos.y + THROW_RADIUS:GetValue() / 2, throw.pos.z);
        local brx, bry = client.WorldToScreen(brVector);
	

		if (cx ~= nil and cy ~= nil and ulx ~= nil and uly ~= nil and blx ~= nil and bly ~= nil and urx ~= nil and ury ~= nil and brx ~= nil and bry ~= nil) then

			if(throw.distance < GH_VISUALS_DISTANCE_SL:GetValue()) then



				-- Draw name
				if (throw.name ~= nil) then
					if GH_CHECKBOX_TEXT:GetValue() then
						local text_size_w, text_size_h = draw.GetTextSize(throw.name);
						draw.Color(CLR_TEXT:GetValue());
						draw.Text(cx - text_size_w / 2, cy - 20 - text_size_h / 2, throw.name);
					end
				end

				-- Show radius as green when in distance, blue otherwise
				if (within_distance) then
					
					if GH_CHECKBOX_BOXSTAND:GetValue() then
						draw.Color(CLR_STAND_BOX:GetValue());
					else
						draw.Color(255, 255, 255, 0);
					end
				else		
					if GH_CHECKBOX_OOD:GetValue() then
						draw.Color(CLR_STAND_BOX_OOD:GetValue());
					end
				end
				
				
		
				-- Top left to rest
				draw.Line(ulx, uly, blx, bly);
		
				draw.Line(ulx, uly, urx, ury);
				draw.Line(ulx, uly, brx, bry);

				-- Bottom right to rest
				draw.Line(brx, bry, blx, bly);
				draw.Line(brx, bry, urx, ury);

				-- Diagonal
				draw.Line(blx, bly, urx, ury);
			end
		end
    end
end


function getThrowPosition(pos_x, pos_y, pos_z, ax, ay, z_offset)
    return pos_x - DRAW_MARKER_DISTANCE * math.cos(math.rad(ay + 180)), pos_y - DRAW_MARKER_DISTANCE * math.sin(math.rad(ay + 180)), pos_z - DRAW_MARKER_DISTANCE * math.tan(math.rad(ax)) + z_offset;
end

function getWeaponName(me)
	if me ~= nil then
		local my_weapon = me:GetPropEntity("m_hActiveWeapon");
		if (my_weapon == nil) then
			return nil;
		end

		local weapon_name = my_weapon:GetClass();
		if weapon_name ~= nil then
			weapon_name = weapon_name:gsub("CWeapon", "");
			weapon_name = weapon_name:lower();

			if (weapon_name:sub(1, 1) == "c") then
				weapon_name = weapon_name:sub(2)
			end

			if (weapon_name == "incendiarygrenade") then
				weapon_name = "molotovgrenade";
			end
		end
		return weapon_name;
	end
	return nil;
end

function getDistanceToTarget(my_x, my_y, my_z, t_x, t_y, t_z)
    local dx = my_x - t_x;
    local dy = my_y - t_y;
    local dz = my_z - t_z;
    return math.sqrt(dx*dx + dy*dy + dz*dz);
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function getActiveThrows(map, me, nade_name)
    local throws = {};
    local throws_in_distance = {};
    -- Determine if any are within range, we should only show those if that's the case
    for i=1, #map do

        local throw = map[i];
		
        if (throw ~= nil and throw.nade == nade_name) then
            local myPos = me:GetAbsOrigin();

            local distance = getDistanceToTarget(myPos.x, myPos.y, throw.pos.z, throw.pos.x, throw.pos.y, throw.pos.z);
            throw.distance = distance;
	
            if (distance < THROW_RADIUS:GetValue()) then
                table.insert(throws_in_distance, throw);
            else
                table.insert(throws, throw);
            end
        end
    end

    if (#throws_in_distance > 0) then
        return throws_in_distance, true;
    end

    return throws, false;
end

function getClosestThrow(map, me, cmd)
    local closest_throw;
    local closest_distance;
    local closest_distance_from_center;
    local myPos = me:GetAbsOrigin();
    for i = 1, #map do
        local throw = map[i];
        local distance = getDistanceToTarget(myPos.x, myPos.y, throw.pos.z, throw.pos.x, throw.pos.y, throw.pos.z);
        local z_offset = 64;
        if (throw.type == "crouch") then
            z_offset = 46;
        end
        local pos_x, pos_y, pos_z = getThrowPosition(throw.pos.x, throw.pos.y, throw.pos.z, throw.ax, throw.ay, z_offset);
		local drawVector = Vector3(pos_x, pos_y, pos_z);
        local draw_x, draw_y = client.WorldToScreen(drawVector);
        local distance_from_center;

        if (draw_x ~= nil and draw_y ~= nil) then
            distance_from_center = math.abs(screen_w / 2 - draw_x + screen_h / 2 - draw_y);
        end

        if (
        closest_distance == nil
                or (
        distance <= THROW_RADIUS:GetValue()
                and (
        closest_distance_from_center == nil
                or (closest_distance_from_center ~= nil and distance_from_center ~= nil and distance_from_center < closest_distance_from_center)
        )
        )
                or (
        (closest_distance_from_center == nil and distance < closest_distance)
        )
        ) then
            closest_throw = throw;
            closest_distance = distance;
            closest_distance_from_center = distance_from_center;
        end
    end

    return closest_throw, closest_distance;
end

function parseStringifiedTable(stringified_table)
    local new_map = {};

    local strings_to_parse = {};
    for i in string.gmatch(stringified_table, "([^\n]*)\n") do
        table.insert(strings_to_parse, i);
    end

    for i=1, #strings_to_parse do
        local matches = {};

        for word in string.gmatch(strings_to_parse[i], "([^,]*)") do
            table.insert(matches, word);
        end

        local map_name = matches[1];
        if new_map[map_name] == nil then
            new_map[map_name] = {};
        end

        table.insert(new_map[map_name], {
            name = matches[3],
            type = matches[5],
            nade = matches[7],
            pos = {
                x = tonumber(matches[9]),
                y = tonumber(matches[11]),
                z = tonumber(matches[13])
            },
            ax = tonumber(matches[15]),
            ay = tonumber(matches[17]);
        });
    end

    return new_map;
end

function convertTableToDataString(object)
    local converted = "";
    for map_name, map in pairs(object) do
        for i, throw in ipairs(map) do
            if (throw ~= nil) then
                converted = converted..map_name.. ','..throw.name..','..throw.type..','..throw.nade..','..throw.pos.x..','..throw.pos.y..','..throw.pos.z..','..throw.ax..','..throw.ay..'\n';
            end
        end
    end

    return converted;
end

function hasValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end



client.AllowListener("player_say");
callbacks.Register("FireGameEvent", "GH_EVENT", gameEventHandler);
callbacks.Register("CreateMove", "GH_MOVE", moveEventHandler);
callbacks.Register("Draw", "GH_DRAW", drawEventHandler);