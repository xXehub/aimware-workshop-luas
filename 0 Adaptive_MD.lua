key = gui.Keybox(gui.Reference( "Ragebot", "Accuracy", "Weapon" ),"rbot.accuracy.mindmghealthkey","Min Damage Target Health Based",0)
adddamage = gui.Slider(gui.Reference( "Ragebot", "Accuracy", "Weapon" ), "rbot.accuracy.mindmghealthadd", "Add Damage", 0, 0, 100)
local targetIndex = 0;
local toggle = 1;
local lastdamage = 0;
local enabled = false;

local function fov(players, localPlayer)
local bestDelta = math.huge;
local bestIndex = nil;

for i = 1, # players do
local player = players[i];

if player and player:GetIndex() ~= localPlayer:GetIndex() then
local localPos = localPlayer:GetAbsOrigin();
local playerPos = player:GetAbsOrigin();
local viewAngles = engine.GetViewAngles();

localPos.z = localPos.z + localPlayer:GetPropVector("localdata", "m_vecViewOffset[0]").z;
playerPos.z = playerPos.z + player:GetPropVector("localdata", "m_vecViewOffset[0]").z;

local angle = (playerPos - localPos):Angles();
local delta = math.abs((angle - viewAngles).y); 

if delta < bestDelta then
bestDelta = delta;
bestIndex = player:GetIndex();
end

end
end

return bestIndex;
end

local function hDraw() 
local players = entities.FindByClass("CCSPlayer");
local localPlayer = entities.GetLocalPlayer();

for i = 1, # players do 
if players[i]:GetTeamNumber() == localPlayer:GetTeamNumber() then
players[i] = nil;
end
end

targetIndex = fov(players, localPlayer);

end

local function esp(builder)

local player = builder:GetEntity();

if targetIndex and player:GetIndex() == targetIndex then
    lastdamage = player:GetHealth() + adddamage:GetValue()
builder:Color(255, 0, 0, 255);
builder:AddTextTop(lastdamage);

    end

end


function indicator()

    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then
return end

x,y = draw.GetScreenSize();
FONT = draw.CreateFont("Microsoft Tai Le","20", 2000 )
draw.SetFont( FONT );

if (toggle%2 == 1) then
draw.Color(255,23,23,255);
draw.TextShadow(16, y - 50, "HEALTH MINDMG");
elseif (toggle%2 == 0) then
draw.Color(23,255,23,255);
draw.TextShadow(16, y - 50, "HEALTH MINDMG");
end

end

function updatehealth()

if enabled == true then
                    gui.SetValue("rbot.accuracy.weapon.asniper.mindmg", lastdamage)
                    gui.SetValue("rbot.accuracy.weapon.sniper.mindmg", lastdamage)
                    gui.SetValue("rbot.accuracy.weapon.pistol.mindmg", lastdamage)
                    gui.SetValue("rbot.accuracy.weapon.hpistol.mindmg", lastdamage)
                    gui.SetValue("rbot.accuracy.weapon.smg.mindmg", lastdamage)
                    gui.SetValue("rbot.accuracy.weapon.rifle.mindmg", lastdamage)
                    gui.SetValue("rbot.accuracy.weapon.shotgun.mindmg", lastdamage)
                    gui.SetValue("rbot.accuracy.weapon.scout.mindmg",lastdamage)
                    gui.SetValue("rbot.accuracy.weapon.lmg.mindmg", lastdamage)

end
end

function DamageChange()

if(input.IsButtonPressed(key:GetValue())) then
            toggle = toggle + 1;
    elseif(input.IsButtonDown) then
    -- do nothing
    end
    if(input.IsButtonReleased(key:GetValue())) then
            if (toggle%2 == 0) then

                    auto = gui.GetValue("rbot.accuracy.weapon.asniper.mindmg")
                    sniper = gui.GetValue("rbot.accuracy.weapon.sniper.mindmg")
                    pistol = gui.GetValue("rbot.accuracy.weapon.pistol.mindmg")
                    revolver = gui.GetValue("rbot.accuracy.weapon.hpistol.mindmg")
                    smg = gui.GetValue("rbot.accuracy.weapon.smg.mindmg")
                    rifle = gui.GetValue("rbot.accuracy.weapon.rifle.mindmg")
                    shotgun = gui.GetValue("rbot.accuracy.weapon.shotgun.mindmg")
                    scout = gui.GetValue("rbot.accuracy.weapon.scout.mindmg")
                    lmg = gui.GetValue("rbot.accuracy.weapon.lmg.mindmg")
enabled = true;
                    toggle = 0;
            elseif (toggle%2 == 1) then
    enabled = false;
                gui.SetValue("rbot.accuracy.weapon.asniper.mindmg", auto)
                gui.SetValue("rbot.accuracy.weapon.sniper.mindmg", sniper)
                gui.SetValue("rbot.accuracy.weapon.pistol.mindmg", pistol)
                gui.SetValue("rbot.accuracy.weapon.hpistol.mindmg", revolver)
                gui.SetValue("rbot.accuracy.weapon.smg.mindmg", smg)
                gui.SetValue("rbot.accuracy.weapon.rifle.mindmg", rifle)
                gui.SetValue("rbot.accuracy.weapon.shotgun.mindmg", shotgun)
                gui.SetValue("rbot.accuracy.weapon.scout.mindmg", scout)
                gui.SetValue("rbot.accuracy.weapon.lmg.mindmg", lmg)
                toggle = 1;
            end
    end

end

callbacks.Register("Draw", updatehealth);
callbacks.Register("Draw", DamageChange);
callbacks.Register("Draw", hDraw);
callbacks.Register("Draw", indicator);
callbacks.Register("DrawESP", esp);