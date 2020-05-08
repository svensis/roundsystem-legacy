local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("charsetSC");
COMMAND.tip = "Set a players sterelized credits.";
COMMAND.text = "<string Name> <number Amount>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID( arguments[1] )
	local amount = arguments[2];
	

		if (target) then
			target:SetCharacterData( "SterelizedCredits", amount )
			if ( player != target )	then
				Clockwork.player:Notify(target, player:Name().." has set your sterelized credits to "..amount..".");
				Clockwork.player:Notify(player, "You have set "..target:Name().."'s sterelized credits to "..amount..".");
			else
				Clockwork.player:Notify(player, "You have set your sterelized credits to "..amount..".");
			end;
		else
			Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
		end;
end;

COMMAND:Register();