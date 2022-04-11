--local author = "zeenwee";
--https://github.com/zeenwee/Baim-on-key/blob/master/BAIM%20ON%20KEY.lua  
local group = gui.Groupbox( gui.Reference( 'Ragebot', 'Hitscan' ), 'Baim on key', 328, 311, 296, 200 )
local mode = gui.Combobox( group, 'baim_on_key_mode', 'Mode', 'Toggle', 'Hold' )
local hotkey = gui.Keybox( group, 'baim_on_key_key', 'Key', 86 )
hotkey:SetDescription( 'Switches between baim and lethal.' )

local font = draw.CreateFont( 'Tahoma', 24, 1000 )
local screenW, screenH = draw.GetScreenSize()
local X, Y = 10, screenH * 0.6

local types = { 'shared.', 'zeus.', 'pistol.', 'hpistol.', 'smg.', 'rifle.', 'shotgun.', 'scout.', 'asniper.', 'sniper.', 'lmg.' }
local active = { [true]={['bodyaim.force']=1, ['bodyaim.lethal']=0, ['bodyaim.onshot']=0, ['bodyaim.safepoint']=0, ['prefersafe']=0, ['forcesafe']=1, ['forcesafe.limbs']=1, ['forcesafe.head']=1, ['forcesafe.body']=1}, [false]={} }

local function setValues( val )
for i=1, #types do
local wep = 'rbot.hitscan.mode.' .. types[i]

if val then
for k, v in pairs( active[true] ) do
active[false][ wep .. k ] = gui.GetValue( wep .. k )
gui.SetValue( wep .. k, v )
end
else
for k, v in pairs( active[false] ) do
gui.SetValue( k, v )
end
end
end
end

local function move_box()
for i=1, #types do
if gui.GetValue( 'rbot.hitscan.mode.'.. types[i] ..'forcesafe' ) then
return true
end
end
end

local pressed = false
callbacks.Register( 'Draw', function()
if move_box() then
group:SetPosY( 366 )
else
group:SetPosY( 311 )
end

local key = hotkey:GetValue()
if key == 0 then
return
end

if not entities.GetLocalPlayer() then
return
end

local mode = mode:GetString()
if mode == 'Hold' then
if input.IsButtonDown( key ) then
if not pressed then
setValues( true )
pressed = true
end
else
if pressed then
setValues( false )
pressed = false
end
end

elseif mode == 'Toggle' then
if input.IsButtonReleased( key ) then
pressed = not pressed
setValues( pressed )
end
end

local r, g, b = 255, 25, 25
if pressed then
r, g, b = 112, 255, 0
end

draw.SetFont( font )
draw.Color( r, g, b )
draw.TextShadow( X, Y, 'BAIM' )
end)