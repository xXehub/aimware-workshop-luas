print("Loaded Aimware QuickSwitch Lua by Starlordaiden")
local uid_to_idx = client.GetPlayerIndexByUserID;
local get_local_player = client.GetLocalPlayerIndex;
local in_action;
local equipped;
local ref = gui.Reference("MISC", "GENERAL","Extra")
local quickswitch = gui.Checkbox(ref, 'lua_quick_switch', 'Quick Switch AWP', 0);
local function on_weapon_fire( _event )
    if quickswitch:GetValue() then
    if ( _event:GetName( ) ~= 'weapon_fire' ) then
        return;
    end

    if (gui.GetValue("misc.fakelatency.enable")) then
        return;
    end

    local _local = get_local_player( );
    local _id = _event:GetInt('userid');

    if ( _local == uid_to_idx( _id ) ) then
        local _weapon = _event:GetString( 'weapon' );

        if ( _weapon == 'weapon_awp' ) then
            client.Command( 'slot3', true )
            flip = true;
        end
    end
end
end
client.AllowListener( 'weapon_fire' );
callbacks.Register( 'FireGameEvent', 'on_weapon_fire', on_weapon_fire );
local function on_item_equip( _event )
    if ( _event:GetName( ) ~= 'item_equip' ) then
        return;
    end

    local _local = get_local_player( );
    local _id = _event:GetInt( 'userid' );
    local _item =  _event:GetString( 'item' );

    if ( _local == uid_to_idx( _id ) ) then
        equipped = _item;
    end
end

client.AllowListener( 'item_equip' );
callbacks.Register( 'FireGameEvent', 'on_item_equip', on_item_equip );
function reset_tick( _cmd )
  if ( flip ) then
        if ( equipped ~= 'awp' ) then
            client.Command( "slot1", true )
            flip = false;
        end
    end
end

callbacks.Register( 'CreateMove', 'reset_tick', reset_tick );