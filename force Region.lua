-- Updated by CEED
local dataCentres = {
    -- For unsetting
    "\"\"",
    -- Europe
    "ams", -- Amsterdam
    "lux", -- Luxembourg
    "vie", -- Vienna
    "sto", -- Warsaw
    "mad", -- Madrid
    "fra", -- Frankfurt
    "par", -- Paris
    -- United Kingdom
    "lhr", -- London
    "iad", -- Sterling
    -- United States
    "lax", -- Los Angeles
    "ord", -- Chicago
    "okc", -- Oklahoma City
    "sea", -- Seattle
    "eat", -- Moses Lake
    "atl", -- Atlanta
    -- South America
    "gru", -- Sao Paulo
    "lim", -- Peru
    "scl", -- Santiago
    -- Others
    "dxb", -- Dubai
    "bom", -- Mumbai
    "maa", -- Chennai
    "tyo", -- Tokyo
    "hkg", -- Hong Kong
    "sgp", -- Singapore
    "sha", -- Shanghai
    "can", -- Guangzhou
    "tsn", -- Tianjin
    "jnb", -- Johannesburg
    "syd" -- Sydney
}

local currentRegion = 0

local reference = gui.Reference("Misc", "General", "Main")

local selection =
    gui.Combobox(
    reference,
    "nex_forceregion",
    "Matchmaking Region",
    "Automatic",
    "EU: Amsterdam",
    "EU: Luxembourg",
    "EU: Vienna",
    "EU: Warsaw",
    "EU: Madrid",
    "EU: Frankfurt",
    "EU: Paris",
    "UK: London",
    "UK: Sterling",
    "US: Los Angeles",
    "US: Chicago",
    "US: Oklahoma City",
    "US: Seattle",
    "US: Moses Lake",
    "US: Atlanta",
    "SA: Sao Paulo",
    "SA: Peru",
    "SA: Santiago",
    "ME: Dubai",
    "IN: Mumbai",
    "IN: Chennai",
    "JAP: Tokyo",
    "CN: Hong Kong",
    "CN: Singapore",
    "CN: Shanghai",
    "CN: Guangzhou",
    "CN: Tianjin",
    "SA: Johannesburg",
    "AU: Sydney"
)

callbacks.Register(
    "Draw",
    "Nex.RS.Draw",
    function()
        if (not entities.GetLocalPlayer()) then
            if (currentRegion ~= selection:GetValue() + 1) then
                client.Command("sdr ClientForceRelayCluster " .. dataCentres[selection:GetValue() + 1], true)
                currentRegion = selection:GetValue() + 1
            end
        end
    end
)