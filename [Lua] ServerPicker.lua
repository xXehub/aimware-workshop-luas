-- Credits: wlan, iPeaks & Nexxed

local dataCentres = {
    -- For unsetting
    "\"\"",

    -- Europe
    "ams", -- Amsterdam (EU West)
    "fra", -- Frankfurt (EU West)
    "lux", -- Luxembourg (EU West)
    "par", -- Paris (EU West)
    "waw", -- Warsaw (EU Central)
    "mad", -- Madrid (EU South)

    -- United Kingdom
    "lhr", -- London (UK East)
    "iad", -- Sterling (UK Central)

    -- United States
    "lax", -- Los Angeles (US West)
    "atl", -- Atlanta (US Central)
    "ord", -- Chicago (US Central)
    "sea", -- Seattle (US North-West)

    -- South America
    "gru", -- Sao Paulo (SA West)
    "lim", -- Peru (SA West)
    "scl", -- Santiago (SA South-West)

    -- Others
    "bom", -- Bombay (India West)
    "maa", -- Chennai (India South-East)

    "hkg", -- Hong Kong (Asia East)
    "sgp", -- Singapore (Asia South-East)

    "dxb", -- Dubai (Middle-East)

    "jnb", -- Johannesburg (South Africa)
    "syd" -- Sydney (AU)
};

local currentRegion = 0;

local reference = gui.Reference("MISC", "GENERAL", "Main");

local selection = gui.Combobox(
    reference,
    "nex_forceregion",
    "Matchmaking Region",

    "Automatic",
    "EU: Amsterdam (W)",
    "EU: Frankfurt (W)",
    "EU: Luxembourg (W)",
    "EU: Paris (W)",
    "EU: Warsaw (C)",
    "EU: Madrid (S)",
    "UK: London (E)",
    "UK: Sterling (C)",
    "US: Los Angeles (W)",
    "US: Atlanta (C)",
    "US: Chicago (C)",
    "US: Seattle (NW)",
    "SA: Sao Paulo (W)",
    "SA: Peru (W)",
    "SA: Santiago (SW)",
    "IN: Bombay (W)",
    "IN: Chennai (SE)",
    "AS: Hong Kong (E)",
    "AS: Singapore (SE)",
    "ME: Dubai",
    "AF: Johannesburg",
    "AU: Sydney"
);

callbacks.Register("Draw", "Nex.RS.Draw", function()
    if(not entities.GetLocalPlayer()) then
        if(currentRegion ~= selection:GetValue()+1) then 
            client.Command("sdr ClientForceRelayCluster "..dataCentres[selection:GetValue()+1], true);
            currentRegion = selection:GetValue()+1;
        end
    end
end);