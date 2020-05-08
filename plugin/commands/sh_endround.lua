local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("roundendcp");
COMMAND.tip = "Finish round CP side";
COMMAND.text = "<string Name> <number Amount>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)


EndRound("Combine")	
	

end;

COMMAND:Register();


local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("roundendrebel");
COMMAND.tip = "Finish round rebel side";
COMMAND.text = "<string Name> <number Amount>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)


EndRound("Lambda")	
	

end;

COMMAND:Register();