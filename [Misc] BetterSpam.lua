-- Thank you for using my script. If you like it recommend me. Special Thanks to superyu'#7167 who helped me with the auto updates. Also some of the Spams are copied but I can't find the source.

-- Hit me up on discord to request new features and maybe I add them.

-- If you want to add your own Spams just add them in a new line below, but make sure you have a "," above.

local author = "DaveLTC";
local discord = "https://discord.gg/6FWJDDm";

local Kill_BM_Spams = {
	"u r so ez ",
	"get clapped ",
	"did that hurt  ?",
	"do you want me to blow on that ?",
	"btw you are supposed to shoot me .",
	"sry I didn't know you were retarded ",
	"CSGO->Game->Game->TurnOnInstructorMessages that might help you ",
	"better luck next time ",
	"bro how did you hit the accept button with that aim ???",
	"ff ?",
	" should i teach you, just if you want .",
	"xD my cat killed you ",
	"better do you homework ",
	"Which controller are you using ???",
	"Did you ever think about suicide? It would make things quicker .",
	"is that a decoy, or are you trying to shoot somebody ?",
	"If this guy was the shooter Harambe would still be alive ",
	"CS:GO is too hard for you m8 maybe consider a game that requires less skill, like idk.... solitaire ",
	"Your shots are like a bad girlfriend: No Head",
	"I would call you AIDS but at least AIDS gets kills.",
	"I could swallow bullets and shit out a better spray than that",
	"Don't be a loser, buy a rope and hang yourself",
	"This guy is more toxic than the beaches at Fukushima",
	"deranking?",
	"Road to Bronce?",
	"Did you learn your spray downs in a bukkake video?",
	"Oops, I must have chosen easy bots by accident",
	"server cvar 'sv_rekt' changed to 1.",
	"Did you notice warm up is already over? Please start playing seriously!!!",
	"How do you change your difficulty settings? My CSGO is stuck on easy",
	"I'd say your aim is cancer, but cancer kills.",
	"I'd call you corona but nobody's afraid of you and corona gets kills.",
	"Nice $4750 decoy ' ' ",
	"CRY HERE ---> |___| <--- Africans need water",
	"Was that your spray on the wall or are you just happy to see me?",
	"Internet Explorer is faster than your reactions",
	"Safest place for us to stand is in front of ' ' ´s gun",
	"Is your monitor on?",
	"mad cuz bad",
	"Choose your excuse: I suck, I'm bad, I can't play CSGO, WHY ARE YOU BULLYING ME",
	"If you want to play against enemies of your skill level just go to the main menu and click 'Offline with Bots'",
	"Did you know that csgo is free to uninstall?"
};
local Death_BM_Spams = {
	"nice luck",
	"sry my brother was playing",
	"doesn't count my mom came in",
	"ok now I start playing",
	"I think you should be in bed already",
	"welcome to the scoreboard",
	"Theres more silver here than in the cutlery drawer",
	"I'm not trash talking, I'm talking to trash.",
	"We may have loose the game, but at the end of the day we, unlike you, are not russians.",
	"Dude you're so fat you run out of breath rushing B",
	"Rest in spaghetti never forgetti",
	"LISTEN HERE YOU LITTLE FUCKER, WHEN I WAS YOUR AGE, PLUTO WAS A PLANET!",
	"Which one of your 2 dads taught you how to play CS?",
	"Go have a 3 sum with your sister and your cousin you fucking hill billy redneck",
	"Watching you play is making my brain cells want commit suicide.",
	"Are you one of those SpECi4L kids?",
	"You're the reason the gene pool should have a life guard",
	"Isn't it uncomfortable playing Counterstrike in the kitchen?",
	"I'm surprised you've got the brain power to keep your heart beating",
	"At least I don't live in the world's most corrupt country",
	"With aim like that, I pity whoever has to clean the floor around your toilet.",
	"I bet you're the type of dude that likes it when your toilet paper breaks and your finger slides up your asshole.",
	"It's ok you play CSGO while I play Joe Mama.",
	"You don't deserve to play this game. Go back to playing with crayons and shitting yourself",
	"At least my country has indoor plumbing",
	"You only killed me because I ran out of health...",
	"Do you make eye-contact when you're fucking your dad in the ass?"
};
local General_BM_Spams = {
	"I smell your drunk mom from here.",
	"I'm the reason your dad's gay",
	"If you were a CSGO match, your mother would have a 7day cool down all the time, because she kept abandoning you.",
	"If I were to commit suicide, I would jump from your ego to your elo.",
	"You sound like your parents beat each other in front of you",
	"My knife is well-worn, just like your mother",
	"You're the human equivalent of a participation award.",
	"Did you grow up near by Chernobyl or why are you so toxic?",
	"I thought I put bots on hard, why are they on easy?",
	"Your nans like my ak vulcan, battle-scarred",
	"I have a coupon code for you = y0UStUP1d. It only works for dumb people so can you maybe try that one out for me?",
	"You're almost as salty as the semen dripping from your mum's mouth",
	"If you fuck your mom and sister it's still only a 2 sum. Are you from Alabama by any chance?",
	"Maybe if you stopped taking loads in the mouth you wouldn't be so salty",
	"The only thing you carry is an extra chromosome.",
	"I kissed your mom last night. Her breath was globally offensive",
	"You can't even carry groceries in from the car",
	"You can feel the autism",
	"Who are you sponsored by? Parkinson's?",
	"You define autism",
	"You dropped your weapon just like your mom dropped you on your head as a kid",
	"Shut up kid and talk to me when your balls have reached the bottom of your spiderman underwear!",
	"The time you need to react is equal to the WindowsXP boot time!",
	"You Polish fuck, Hitler should had killed your family",
	"Do you know the STOP BULLYING ME kid? That could be you.",
	"Bro you couldn't hit an elephant in the ass with a shotgun with aim like that",
	"Hey man, dont worry about being bad. It's called a trashCAN not a trashCAN'T.",
	"If i wanted to listen to an asshole I would fart",
	"Sell your computer and buy a Wii"
};



-- Better Spam Tab
local ref = gui.Tab(gui.Reference("Misc"), "better_spam.settings", "Better Spam")

--Kill BM Spam
local Kill_BM_Group = gui.Groupbox(ref, "Kill Message", 15, 15, 294);
local Kill_BM_Act = gui.Combobox( Kill_BM_Group, "lua_combobox", "Enable", "off", "standard", "custom" );
local Kill_BM_Edit = gui.Editbox( Kill_BM_Group, "lua_editbox", "custom message:");
local Kill_BM_STAN_NAME = gui.Checkbox( Kill_BM_Group,"lua_checkbox" , "activate @player name", false);

--Death BM Spam
local Death_BM_Group = gui.Groupbox(ref, "Death Message", 327, 15, 294);
local Death_BM_Act = gui.Combobox( Death_BM_Group, "lua_combobox", "Enable", "off", "standard", "custom" );
local Death_BM_Edit = gui.Editbox( Death_BM_Group, "lua_editbox", "custom message:");
local Death_BM_STAN_NAME = gui.Checkbox( Death_BM_Group,"lua_checkbox" , "activate @player name", false);

--General BM Spam
local General_BM_Group = gui.Groupbox(ref, "Spam Message", 15, 230, 607);
local General_BM_Act = gui.Combobox( General_BM_Group, "lua_combobox", "Enable", "off", "standard", "custom" );
local General_BM_Edit = gui.Editbox( General_BM_Group, "lua_editbox", "custom message:");
local General_BM_Speed = gui.Slider( General_BM_Group, "lua_slider","Delay in Seconds" , 10,1,60)

--General Spam Timer
local last_message = globals.TickCount();
function GeneralSpam()
	if ( globals.TickCount() - last_message < 0 ) then
        last_message = 0;
    end;

	local spammer_speed = General_BM_Speed:GetValue() *60;
    if ( General_BM_Act:GetValue()==1 and globals.TickCount() - last_message > (math.max(22, spammer_speed)) ) then
        client.ChatSay( ' ' .. tostring( General_BM_Spams[math.random(1,table.getn(General_BM_Spams))] ));
        last_message = globals.TickCount();
	elseif ( General_BM_Act:GetValue()==2 and globals.TickCount() - last_message > (math.max(22, spammer_speed)) ) then
        client.ChatSay(General_BM_Edit:GetValue());
        last_message = globals.TickCount();
    end
end



--Kill/Death Trigger
local function CHAT_KillSay( Event )

   if ( Event:GetName() == 'player_death' ) then

       local ME = client.GetLocalPlayerIndex();

       local INT_UID = Event:GetInt( 'userid' );
       local INT_ATTACKER = Event:GetInt( 'attacker' );

       local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
       local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );

       local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
       local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );

       if ( INDEX_Attacker == ME and INDEX_Victim ~= ME) then
			if (Kill_BM_Act:GetValue()==1) then
				if(Kill_BM_STAN_NAME:GetValue()==true) then
					client.ChatSay( ' ' .. tostring( Kill_BM_Spams[math.random(1,table.getn(Kill_BM_Spams))] ) .. ' ' .. NAME_Victim );
				else
					client.ChatSay( ' ' .. tostring( Kill_BM_Spams[math.random(1,table.getn(Kill_BM_Spams))] ));
				end

			elseif (Kill_BM_Act:GetValue()==2) then
				if(Kill_BM_STAN_NAME:GetValue()==true) then
					client.ChatSay(Kill_BM_Edit:GetValue() .. ' ' .. NAME_Victim );
				else
					client.ChatSay(Kill_BM_Edit:GetValue());
				end
			end
        elseif ( INDEX_Victim == ME and INDEX_Attacker ~= ME and Death_BM_Act:GetValue()==1) then
			if (Death_BM_Act:GetValue()==1) then
				if(Death_BM_STAN_NAME:GetValue()==true) then
					client.ChatSay( ' ' .. tostring( Death_BM_Spams[math.random(1,table.getn(Death_BM_Spams))] ) .. ' ' .. NAME_Victim );
				else
					client.ChatSay( ' ' .. tostring( Death_BM_Spams[math.random(1,table.getn(Death_BM_Spams))] ));
				end

			elseif (Death_BM_Act:GetValue()==2) then
				if(Death_BM_STAN_NAME:GetValue()==true) then
					client.ChatSay(Death_BM_Edit:GetValue() .. ' ' .. NAME_Victim );
				else
					client.ChatSay(Death_BM_Edit:GetValue());
				end
			end

		end

	end

end

callbacks.Register( "Draw", "GeneralSpam", GeneralSpam );

client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', 'AWKS', CHAT_KillSay );



--- Auto updater by ShadyRetard/Shady#0001
local SCRIPT_FILE_NAME = GetScriptName();
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/dayv007/BetterSpamAW/master/BetterSpam.lua";
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/dayv007/BetterSpamAW/master/version.txt";
local VERSION_NUMBER = "3.0";
local version_check_done = false;
local update_downloaded = false;
local update_available = false;
local BETTERSPAM_UPDATER_TAB = gui.Tab(gui.Reference("Settings"), "DaveLTC's.updater.tab", "BetterSpam Autoupdater")
local BETTERSPAM_UPDATER_GROUP = gui.Groupbox(BETTERSPAM_UPDATER_TAB, "Auto Updater for BetterSpam | v" .. VERSION_NUMBER,15, 15, 603)
local BETTERSPAM_UPDATER_TEXT = gui.Text(BETTERSPAM_UPDATER_GROUP, "")


local function handleUpdates()

    if (update_available and not update_downloaded) then
        BETTERSPAM_UPDATER_TEXT:SetText("Update is getting downloaded.")
        local new_version_content = http.Get(SCRIPT_FILE_ADDR);
        local old_script = file.Open(SCRIPT_FILE_NAME, "w");
        old_script:Write(new_version_content);
        old_script:Close();
        update_available = false;
        update_downloaded = true;
    end

    if (update_downloaded) then
        BETTERSPAM_UPDATER_TEXT:SetText("Update available, please reload the script.")
        return;
	else 
		BETTERSPAM_UPDATER_TEXT:SetText("No update available. You use the newest version(v"..VERSION_NUMBER..")")
    end

    if (not version_check_done) then
        version_check_done = true;
        local version = http.Get(VERSION_FILE_ADDR);
        if (version ~= VERSION_NUMBER) then
            update_available = true;
        end
    end
end

callbacks.Register("Draw", handleUpdates)
