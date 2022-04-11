local OnyxTable = {
    DefaultMessage = "[Onyx] LUA by OurmineOGTv",
    PlayerData = {
        [0] = {
            Enable = true,
            Rank = 0,
            Level = -1,
            Prime = true,
            Commends = {
                Friendly = 0,
                Teacher = 0,
                Leader = 0
            }        },
        [1] = {
            Enable = true,
            Rank = 0,
            Level = -1,
            Prime = true,
            Commends = {
                Friendly = 0,
                Teacher = 0,
                Leader = 0
            }
        },
        [2] = {
            Enable = true,
            Rank = 0,
            Level = -1,
            Prime = true,
            Commends = {
                Friendly = 0,
                Teacher = 0,
                Leader = 0
            }
        },
        [3] = {
            Enable = true,
            Rank = 0,
            Level = -1,
            Prime = true,
            Commends = {
                Friendly = 0,
                Teacher = 0,
                Leader = 0
            }
        },
        [4] = {
            Enable = true,
            Rank = 0,
            Level = -1,
            Prime = true,
            Commends = {
                Friendly = 0,
                Teacher = 0,
                Leader = 0
            }
        }
    },
    ErrMessage = {
        "1_FailPingServer",
        "1_FailReadyUp",
        "1_FailReadyUp_Title",
        "1_FailVerifyClan",
        "1_FailVerifyClan_Title",
        "1_InsufficientLevel",
        "1_InsufficientLevel02",
        "1_InsufficientLevel03",
        "1_InsufficientLevel04",
        "1_InsufficientLevel05",
        "1_NotLoggedIn",
        "1_NotVacVerified",
        "1_OngoingMatch",
        "1_PenaltySeconds",
        "1_PenaltySecondsGreen",
        "1_VacBanned",
        "1_VacBanned_Title",
        "ClientBetaVersionMismatch",
        "ClientUpdateRequired",
        "FailedToPingServers",
        "FailedToReadyUp",
        "FailedToSetupSearchData",
        "FailedToVerifyClan",
        "InvalidGameMode",
        "NoOngoingMatch",
        "NotLoggedIn",
        "NotVacVerified",
        "OperationPassInvalid",
        "OperationQuestIdInactive",
        "PartyRequired1",
        "PartyRequired2",
        "PartyRequired3",
        "PartyRequired4",
        "PartyRequired5",
        "PartyTooLarge",
        "SkillGroupLargeDelta",
        "SkillGroupMissing",
        "TournamentMatchInvalidEvent",
        "TournamentMatchNoEvent",
        "TournamentMatchRequired",
        "TournamentMatchSetupNoTeam",
        "TournamentMatchSetupSameTeam",
        "TournamentMatchSetupYourTeam",
        "TournamentTeamAccounts",
        "TournamentTeamSize",
        "UnavailMapSelect",
        "VacBanned",
        "X_AccountWarningNonPrime",
        "X_AccountWarningTrustMajor",
        "X_AccountWarningTrustMajor_Summary",
        "X_AccountWarningTrustMinor",
        "X_FailPingServer",
        "X_FailReadyUp",
        "X_FailVerifyClan",
        "X_InsecureBlocked",
        "X_InsufficientLevel",
        "X_InsufficientLevel02",
        "X_InsufficientLevel03",
        "X_InsufficientLevel04",
        "X_InsufficientLevel05",
        "X_NotLoggedIn",
        "X_NotVacVerified",
        "X_OngoingMatch",
        "X_PenaltySeconds",
        "X_PenaltySecondsGreen",
        "X_PerfectWorldDenied",
        "X_PerfectWorldRequired",
        "X_VacBanned"
    }
}

panorama.RunScript([[
    var OnyxWaitPUpdate = null;

    function OnyxCall(times, callback) {
        for (var i = 1; i <= times; i++){
            callback();
        }
    }

    if (!LobbyAPI.IsSessionActive()) { 
        LobbyAPI.CreateSession(); 
    }

    function OnyxStop() {
        if (OnyxWaitPUpdate != null) {
            $.UnregisterForUnhandledEvent( 'PanoramaComponent_Lobby_PlayerUpdated', OnyxWaitPUpdate);
            OnyxWaitPUpdate = null;
        }
    }

]])

--lul GUI
local OnyxRef = gui.Reference("Misc");
local OnyxTab = gui.Tab(OnyxRef, "onyx.tab", "[Onyx] Profile Changer");
local OnyxGroupbox1 = gui.Groupbox(OnyxTab, "In Lobby", 15, 15, 315);
local OnyxGroupbox2 = gui.Groupbox(OnyxTab, "Important", 345, 15, 250);
local OnyxGroupbox3 = gui.Groupbox(OnyxTab, "Profile Changer", 345, 385, 250);
local OnyxGroupbox4 = gui.Groupbox(OnyxTab, "Information", 15, 485, 315);
local OnyxTarget = gui.Slider(OnyxGroupbox2, "onyx.select.user", "Select Target", 1, 1, 5);

--uhhh GUI
local OnyxActivate = gui.Checkbox(OnyxGroupbox1, "onyx.activate", "Enable", false);
local OnyxWindowSpam = gui.Checkbox(OnyxGroupbox1, "onyx.window.spam", "Enable Window Spam", false);
local OnyxSpamError = gui.Checkbox(OnyxGroupbox1, "onyx.spam.error", "Enable Spam Error", false);
local OnyxRandomSpam = gui.Checkbox(OnyxGroupbox1, "onyx.random.spam", "Enable Random Spam", false);
local OnyxSelectErrMessage = gui.Combobox(OnyxGroupbox1, "onyx.error.message", "Select Error Message", "{user} vac banned.", "{user} vac error.", "{user} temporary penalty.", "{user} other vac error.", "SkillGroupLargeDelta");
local OnyxCustomMessage = gui.Editbox(OnyxGroupbox1, "onyx.custom.message", "Custom Message");
local OnyxLoopTimes = gui.Slider(OnyxGroupbox1, "onyx.loop", "Select Loop Messages", 1, 1, 500);

--Descriptions
OnyxActivate:SetDescription("Enable lobby functions.");
OnyxWindowSpam:SetDescription("Enable window spam. (Sometimes you can see this window)");
OnyxSpamError:SetDescription("Enable spam error with user.");
OnyxRandomSpam:SetDescription("Enable random spam. (Random users and error messages)");
OnyxTarget:SetDescription("Select user (1 is lobby host).");
OnyxSelectErrMessage:SetDescription("Select error message to spam.");
OnyxCustomMessage:SetDescription("Write your message here to spam.");

--oh GUI
local OnyxActivateProfile = gui.Checkbox(OnyxGroupbox3, "onyx.profile.activate", "Enable", false);
local OnyxRankChangerActivate = gui.Checkbox(OnyxGroupbox3, "onyx.profile.rank.changer.activate", "Activate", false);
local OnyxFakePrime = gui.Checkbox(OnyxGroupbox3, "onyx.fake.prime", "Activate", false);
local OnyxSelectRank = gui.Combobox(OnyxGroupbox3, "onyx.profile.selected.rank", "Select Rank", "Unranked", "Silver I", "Silver II", "Silver III", "Silver IV", "Silver Elite", "Silver Elite Master", "Gold Nova I", "Gold Nova II", "Gold Nova III", "Gold Nova Master", "Master Guardian I", "Master Guardian II", "Master Guardian Elite", "Distinguished Master Guardian", "Legendary Eagle", "Legendary Eagle Master", "Supreme Master First Class", "The Global Elite")
local OnyxFakeLvl = gui.Editbox(OnyxGroupbox3, "onyx.profile.lvl", "Level");
local OnyxCMDfriendly = gui.Editbox(OnyxGroupbox3, "onyx.commands.friendly", "Friendly");
local OnyxCMDteacher = gui.Editbox(OnyxGroupbox3, "onyx.commands.teacher", "Teacher");
local OnyxCMDleader = gui.Editbox(OnyxGroupbox3, "onyx.commands.leader", "Leader");

--Description 2
OnyxActivateProfile:SetDescription("Enable profile changer.");
OnyxRankChangerActivate:SetDescription("Activate rank changer.");
OnyxFakePrime:SetDescription("Activate fake prime.");
OnyxSelectRank:SetDescription("Select rank from list.");
OnyxFakeLvl:SetDescription("Set fake level.");
OnyxCMDfriendly:SetDescription("Set friendly commends.");
OnyxCMDteacher:SetDescription("Set teacher commends.");
OnyxCMDleader:SetDescription("Set leader commends.");

--info GUI
gui.Text(OnyxGroupbox4, "Profile and spam errors working only if you are lobby    host.");
gui.Text(OnyxGroupbox4, "All working good for me.. But remember to wait a whilebefore using a function again.");
gui.Text(OnyxGroupbox4, "If you have any problem join to unofficial AW Discord   Server: discord.com/invite/5eH69PF");
gui.Text(OnyxGroupbox4, "Author: OurmineOGTv#6846");

--Define closePopups() function
local function closePopups()
    if OnyxActivate:GetValue() then
        panorama.RunScript([[
            UiToolkitAPI.CloseAllVisiblePopups();
        ]])
    end
end
gui.Button(OnyxGroupbox2, "Close All Popups", closePopups)

--Define spamStartStopMM() function
local function spamStartStopMM()
    if OnyxActivate:GetValue() then
        panorama.RunScript([[
            OnyxStop();
            OnyxCall(]] .. OnyxLoopTimes:GetValue() .. [[, ()=>{ 
                LobbyAPI.StartMatchmaking( "", "", "", "" );LobbyAPI.StopMatchmaking(); 
            });
        ]])
    end
end
gui.Button(OnyxGroupbox2, "Spam Start/Stop", spamStartStopMM)

--Define emptyMessage() function
local function emptyMessage()
    if OnyxActivate:GetValue() then
        panorama.RunScript([[
            OnyxStop();
            OnyxCall(]] .. OnyxLoopTimes:GetValue() .. [[, ()=>{ 
                PartyListAPI.SessionCommand("Game::Chat", `run all xuid ${MyPersonaAPI.GetXuid()} name ${MyPersonaAPI.GetName()} chat `); 
            });
        ]])
    end
end
gui.Button(OnyxGroupbox2, "Send Empty Message", emptyMessage)

--Define sendCustomMessage() function
local function sendCustomMessage()
    if OnyxActivate:GetValue() then
        OnyxPlayerCheck = entities.GetLocalPlayer()
        if OnyxPlayerCheck ~= nil or engine.GetServerIP() ~= nil then
            return
        end
        local OnyxCustomMessage = OnyxCustomMessage:GetValue()
        if OnyxCustomMessage ~= "" then
            panorama.RunScript([[
                var LobbyChat = $('#MainMenu').FindChildInLayoutFile('PartyChat');
                var LobbyChatInput = LobbyChat.FindChildInLayoutFile('ChatInput');

                LobbyChatInput.text = "]]..tostring(OnyxCustomMessage)..[["
                OnyxCall(]] .. OnyxLoopTimes:GetValue() .. [[, ()=>{
                    LobbyChat.SubmitChatText();
                });
                LobbyChatInput.text = ""
                LobbyChat.ScrollToBottom();
            ]])
        else
            print("[Onyx] Custom Message box is empty!")
        end
    end
end
gui.Button(OnyxGroupbox2, "Send Custom Message", sendCustomMessage)

--Define required functions
local function randomErrMessage()
    local randomMessage = math.random(1, 68);
    return randomMessage
end

local function getTarget()
    local OnyxTarget = OnyxTarget:GetValue()
    OnyxTarget = OnyxTarget - 1;
    return OnyxTarget
end

local function getRankToChange()
    local rankToChange = OnyxSelectRank:GetValue()
    return rankToChange
end

--Define oneErrMessage() function
local function oneErrMessage()
    local OnyxSelectErrMessage = OnyxSelectErrMessage:GetValue()
    OnyxSelectErrMessage = OnyxSelectErrMessage + 1;
    local simpleErrors = {
        "X_VacBanned",
        "X_NotVacVerified",
        "X_PenaltySeconds",
        "X_InsecureBlocked",
        "SkillGroupLargeDelta"
    }
    panorama.RunScript([[
        OnyxStop();
        OnyxCall(1, ()=>{
            PartyListAPI.SessionCommand("Game::ChatReportError", `run all xuid ${PartyListAPI.GetXuidByIndex(]] .. getTarget() .. [[)} error #SFUI_QMM_ERROR_]]..simpleErrors[OnyxSelectErrMessage]..[[`);
        });    
    ]])
end
gui.Button(OnyxGroupbox2, "One Error Message", oneErrMessage)

--Define lobbyFeatures() function
local function lobbyFeatures()
    if OnyxActivate:GetValue() then
        if OnyxWindowSpam:GetValue() then
            closePopups();
            panorama.RunScript([[
                OnyxStop();
                OnyxCall(20, ()=>{ 
                    PartyListAPI.SessionCommand("Game::HostEndGamePlayAgain", `run all xuid ${MyPersonaAPI.GetXuid()}`); 
                });
            ]])
        end
        local simpleErrors = {
            "X_VacBanned",
            "X_NotVacVerified",
            "X_PenaltySeconds",
            "X_InsecureBlocked",
            "SkillGroupLargeDelta"
        }
        if OnyxSpamError:GetValue() then
            local OnyxSelectErrMessage = OnyxSelectErrMessage:GetValue()
            OnyxSelectErrMessage = OnyxSelectErrMessage + 1;
            panorama.RunScript([[
				OnyxStop();
                OnyxCall(1, ()=>{
                    PartyListAPI.SessionCommand("Game::ChatReportError", `run all xuid ${PartyListAPI.GetXuidByIndex(]] .. getTarget() .. [[)} error #SFUI_QMM_ERROR_]]..simpleErrors[OnyxSelectErrMessage]..[[`);
                });
            ]])
        end
        if OnyxRandomSpam:GetValue() then
            panorama.RunScript([[
                OnyxCall(1, ()=>{
                    PartyListAPI.SessionCommand("Game::ChatReportError", `run all xuid ${PartyListAPI.GetXuidByIndex(]] .. getTarget() .. [[)} error #SFUI_QMM_ERROR_]]..OnyxTable.ErrMessage[randomErrMessage()]..[[`);
                });
            ]])
        end
    end
end

--Define savePerUserData() function
local function savePerUserData()
    local fakePrime = 0
    local fakePrimeActive = tostring(OnyxFakePrime:GetValue())
    if OnyxFakePrime:GetValue() then
        fakePrime = 1
    else
        fakePrime = 0
    end

    local user = getTarget()
    OnyxTable.PlayerData[user].Rank = getRankToChange();
    OnyxTable.PlayerData[user].Prime = fakePrime;
    OnyxTable.PlayerData[user].Level = OnyxFakeLvl:GetValue();
    OnyxTable.PlayerData[user].Commends.Friendly = OnyxCMDfriendly:GetValue();
    OnyxTable.PlayerData[user].Commends.Teacher = OnyxCMDteacher:GetValue();
    OnyxTable.PlayerData[user].Commends.Leader = OnyxCMDleader:GetValue();
end

--Define profileChanger() function
local function profileChanger()
    if OnyxActivateProfile:GetValue() then
        local activeCustomRank = tostring(OnyxRankChangerActivate:GetValue())
        local fakePrimeActive = tostring(OnyxFakePrime:GetValue())

        panorama.RunScript([[
            OnyxStop();

            var playerData = {
                update: {
                    members: {
                    }
                }
            }

            var updateMessage = "";
        ]])
        for i=0, #OnyxTable.PlayerData do
            if OnyxTable.PlayerData[i].Enable then
                panorama.RunScript([[
                    if (PartyListAPI.GetXuidByIndex(0) != ]]..tostring(i)..[[) {
                        var machineName = "machine]]..i..[["
                        if (]] .. activeCustomRank .. [[ == true) {
                            if (]] .. tostring(OnyxTable.PlayerData[i].Rank ~= 0) .. [[ == true) {
                                updateMessage += "Update/Members/" + machineName + "/player0/game/ranking " + ]] .. OnyxTable.PlayerData[i].Rank .. [[ + " ";
                            }
                        }

                        if (]] .. tostring(OnyxTable.PlayerData[i].Level ~= -1) .. [[ == true) {
                            updateMessage += "Update/Members/" + machineName + "/player0/game/level " + ]] .. OnyxTable.PlayerData[i].Level .. [[ + " ";
                        }

                    if (]] .. fakePrimeActive .. [[ == true) {
                            updateMessage += "Update/Members/" + machineName + "/player0/game/prime " + ]] .. (OnyxTable.PlayerData[i].Prime and "1" or "0") .. [[ + " ";
                    }

                        updateMessage += "Update/Members/" + machineName + "/player0/game/commends " + "[f]].. OnyxTable.PlayerData[i].Commends.Friendly ..[[][t]].. OnyxTable.PlayerData[i].Commends.Teacher ..[[][l]].. OnyxTable.PlayerData[i].Commends.Leader ..[[] ";
                    }
            
                    OnyxWaitPUpdate = $.RegisterForUnhandledEvent( "PanoramaComponent_Lobby_PlayerUpdated", function(xuid) {
                        PartyListAPI.UpdateSessionSettings(updateMessage);
                    });
            
                    PartyListAPI.UpdateSessionSettings(updateMessage);
                ]])
            end
        end
        panorama.RunScript([[
            OnyxWaitPUpdate = $.RegisterForUnhandledEvent( "PanoramaComponent_Lobby_PlayerUpdated", function(xuid) {
                PartyListAPI.UpdateSessionSettings(updateMessage);
            });

            PartyListAPI.UpdateSessionSettings(updateMessage);
        ]])
    end
end
gui.Button(OnyxGroupbox3, "Force Reload", function() savePerUserData(); profileChanger(); end)

--callbacks
callbacks.Register("Draw", lobbyFeatures)