local ref = gui.Reference("Visuals", "World", "Materials", "Skybox");
local skyboxes = {"Default", "cs_tibet", "embassy", "italy", "jungle", "office", "sky_cs15_daylight01_hdr",
"sky_csgo_cloudy01", "sky_csgo_night02", "sky_csgo_night02b", "sky_day02_05_hdr", "sky_day02_05", "sky_dust", "vertigo_hdr",
"vertigoblue_hdr", "vertigo", "vietnam", "space_1", "space_3", "space_4", "space_5", "space_6", "space_7", "space_8", "space_9",
"space_10", "******"};

local skyboxesMenu = {"Default", "Tibet", "Embassy", "Italy", "Jungle", "Office", "CS15 Daylight HDR",
"Cloudy 1", "Night 2", "Night 2B", "Day 2 5 HDR", "Day 2 5", "Dust", "Vertigo HDR", "Vertigoblue HDR",
"Vertigo", "Vietnam", "Space 1", "Space 2", "Space 3", "Space 4", "Space 5", "Space 6", "Space 7",
"Space 8", "Decent"};

ref:SetOptions(unpack(skyboxesMenu));
local set = client.SetConVar;
local last = ref:GetValue();

local function SkyBox()
    if last ~= ref:GetValue() then
        set("sv_skyname" , skyboxes[ref:GetValue() + 1], true);
        last = ref:GetValue();
    end
end
callbacks.Register("Draw", SkyBox)