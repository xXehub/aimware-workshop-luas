local Kill_String = {
[1] = "S-Sorry onii-chan p-please d-do me harder ;w;",
[2] = "Y-You got me all wet now senpai!",
[3] = "D-Don't t-touch me there senpai",
[4] = "P-Please l-love me harder oniichan ohh grrh aahhhh~!",
[5] = "Give me all your cum senpai ahhhhh~",
[6] = "F-Fuck me harder chan!",
[7] = "Oh my god I hate you so much senpai but please k-keep fucking me harder! ahhh~",
[8] = "D-do you like my stripped panties getting soaked by you and your hard cock? ehhh master you're so lewd ^0^~",
[9] = "kun your cute little dick between my pussy lips looks really cute, I'm blushing",
[10] = "Master does it feel good when I slide by tits up and down on your cute manly part?",
[11] = "oniichan my t-toes are so warm with your cum all over them uwu~",
[12] = "Lets take this swimsuit off already <3 i'll drink your unknown melty juice",
[13] = "S-stop senpai if we keep making these lewd sounds im going to cum~~",
[14] = "You're such a pervert for filling me up with your baby batter senpai~~",
[15] = "Fill up my baby chamber with your semen kun ^-^",
[16] = "M-master d-dont spank my petite butt so hard ahhhH~~~ you're getting me so w-wet~",
[17] = "senpai your cock is already throbbing from my huge tits~",
[18] = "Hey kun, Can I have some semen?"
}

local Death_String = {
[1] = "hehe don't touch me there oni-chann UwU ",
[2] = "Your cum is all over my wet clit M-master",
[3] = "It Feels like you're pounding me with the force of a thousand suns senpai"
};


function CHAT_KillSay( Event )

if ( Event:GetName() == 'player_death' ) then

  local ME = client.GetLocalPlayerIndex();

  local INT_UID = Event:GetInt( 'userid' );
  local INT_ATTACKER = Event:GetInt( 'attacker' );

  local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
  local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );

  local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
  local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );

  if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then

      random = math.random (1, 18)
      client.ChatSay( ' ' .. tostring( Kill_String[random]));

  elseif ( INDEX_Victim == ME and INDEX_Attacker ~= ME ) then

      random = math.random (1, 3)
      client.ChatSay( ' ' .. tostring( Death_String[random]));

  end

end

end

client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', 'AWKS', CHAT_KillSay );