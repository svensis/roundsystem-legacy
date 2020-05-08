--[[
	� 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local PLUGIN = PLUGIN;

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Number("vPoints");
	playerVars:Number("lPoints");
end;

Role = {}

CombineRoles = {
{"City Administrator", "CA", 1, "As the City Administrator, you are tasked with governing the City on behalf of your benefactors. Prevent disaster, if you can. And keep the workforce in line."},
{"Sectorial", "SECTORIAL", 1, "The Sectorial or 'SeC' is the commander of the CCA in this City. You must keep your units on a short leash, while ensuring stability within the confines of the City walls."},
{"Union", "UNION", 5, "The Union is a standard patrol unit in the CCA."},
{"Helix", "HELIX", 2, "The Helix is a medical unit in the CCA."},
{"Judge", "JUDGE", 1, "The Judge is a judicial unit in the CCA, who deals with prisoners and torture."},
{"Grid", "GRID", 2, "The Grid is a mechanical unit in the CCA, who deals with city scanners and other advanced Combine equipment."}
}

CitizenRoles = {
{"Citizen", "CITIZEN", 99, "As a citizen, you must survive the Combine occupation in one of their many urban centers. Decide your own allegiance. Try not to crack under the pressure of the Civil Protection. "},
{"Civil Worker", "CWU_WORKER", 2, "Civil Workers own stores where citizens may purchase produce. They also manage the work cycles where citizens work."},
{"Civil Doctor", "CWU_DOCTOR", 1, "Civil Doctors run the City's hospital and ensure that the citizens are healthy."}
--{"Loyalist", "LOYALIST", 5, "Universal Union sympathisers who have earned the status of 'Loyalist'."},
}

SpecialRoles = {
-- {"Biotic", "BIOTIC", 2, "Aliens that originate from the border world, 'Xen'. Now enslaved by the combine, even they are treated worse than the human citizens of Earth.."},
{"Black Market Dealer", "BMD", 1, "Skilled smugglers who have smuggled contraband behind the City walls."}
}

AntagonistsRoles = {
{"Resistance Supplier", "ANTAG_LEADER", 1, "You are the RESISTANCE LEADER. Use your handheld radio in a secret location to reveal your companions. As Leader, you have a radio that you must take to the Resistance base before you can begin with your objectives. Work together to complete your objectives and to take down the Combine.", "CITIZEN"},
{"Resistance Member", "ANTAG_RESISTANCE", 1, "You are a RESISTANCE MEMBER. Use your handheld radio in a secret location to reveal your companions. Follow your Leader to the Resistance base. Work together to complete your objectives and to take down the Combine.", "CITIZEN"},
{"Resistance Member", "ANTAG_RESISTANCE", 1, "You are a RESISTANCE MEMBER. Use your handheld radio in a secret location to reveal your companions. Follow your Leader to the Resistance base. Work together to complete your objectives and to take down the Combine.", "CITIZEN"},
{"Loyalist", "ANTAG_LOYALIST", 1, "You are a LOYALIST. You have worked hard and have shown great obedience to get where you are now. The Union has rewarded you with a higher standard of living. You are equipped with a 'request device'. Use it to report anti-civil behaviour.", "CITIZEN"},
{"Loyalist", "ANTAG_LOYALIST", 1, "You are a LOYALIST. You have worked hard and have shown great obedience to get where you are now. The Union has rewarded you with a higher standard of living. You are equipped with a 'request device'. Use it to report anti-civil behaviour.", "CITIZEN"},
{"Resistance Member", "ANTAG_RESISTANCE", 1, "You are a RESISTANCE MEMBER. Use your handheld radio in a secret location to reveal your companions. Follow your Leader to the Resistance base. Work together to complete your objectives and to take down the Combine.", "CITIZEN"}
}

Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_plugin.lua");

concommand.Add("checktable", function()
    CheckTableAvailable()
end)

function PickNiggers(role)

if role == "ANTAG_LEADER" then
	LocalPlayer():ChatPrint("Nate Higgers")
end

if role == "ANTAG_RESISTANCE" then
	LocalPlayer():ChatPrint("Nate Higgers")
end

end

function CheckTableAvailable()

	for k,v in pairs(CombineRoles) do
		  if v[3] > RoleCount(v[2]) then
				print"No empty roles found"
		  else
				print("Removed Table "..v[2])
			--	table.remove(CombineRoles, CombineRoles[v])
				table.insert(v, 3, -2)
		  end
	end

	for k,v in pairs(CitizenRoles) do
		  if v[3] > RoleCount(v[2]) then
				print"No empty roles found"
		  else
				print("Removed Table "..v[2])
			--	table.remove(CombineRoles, CombineRoles[v])
				table.insert(v, 3, -2)
		  end
	end

	for k,v in pairs(SpecialRoles) do
		  if v[3] > RoleCount(v[2]) then
				print"No empty roles found"
		  else
				print("Removed Table "..v[2])
			--	table.remove(CombineRoles, CombineRoles[v])
				table.insert(v, 3, -2)
		  end
	end

	end



function RoleCount(role)
local PlayingRoles = 0

    for k, v in pairs(player.GetAll()) do
        if v:GetNWString("AssignedRole") == role then
            PlayingRoles = PlayingRoles + 1
        end
    end

    return PlayingRoles
end