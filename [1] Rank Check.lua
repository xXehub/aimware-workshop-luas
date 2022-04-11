
local w,h = draw.GetScreenSize()

local IN_SCOREBOARD = false

local ranks = {
"Silver 1",
"Silver 2",
"Silver 3",
"Silver 4",
"Silver Elite",
"Silver Elite Master",

"GOLD NOVA 1",
"GOLD NOVA 2",
"GOLD NOVA 3",
"GOLD NOVA Master",

"MG1",
"MG2",
"MGE",
"DMG",

"LE",
"LEM",
"SMFC",
"GE"
}

local font = draw.CreateFont("Tahoma", 20, 450)

callbacks.Register("CreateMove", function(cmd)
local IN_SCORE = bit.lshift(1, 16)
IN_SCOREBOARD = bit.band(cmd.buttons, IN_SCORE) == IN_SCORE
end)

callbacks.Register("Draw", function()
if not engine.GetServerIP() then return end

if not engine.GetServerIP():gmatch("=[A:") then return end

if not gui.Reference("menu"):IsActive() and not IN_SCOREBOARD then return end

local y = h/2

for i, v in next, entities.FindByClass("CCSPlayer") do
if v:GetName() ~= "GOTV" and entities.GetPlayerResources():GetPropInt("m_iPing", v:GetIndex()) ~= 0 then
local index = v:GetIndex()
local rank_index = entities.GetPlayerResources():GetPropInt("m_iCompetitiveRanking", index)
local wins = entities.GetPlayerResources():GetPropInt("m_iCompetitiveWins", index)
local rank = ranks[rank_index] or "Unranked"
draw.SetFont(font)
draw.Color(210,210,210,255)
draw.Text(5, y, v:GetName().." - Rank: "..rank.." Wins: "..wins)
y = y + 30
end
end
end)