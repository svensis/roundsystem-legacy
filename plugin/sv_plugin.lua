local PLUGIN = PLUGIN
local Clockwork = Clockwork
if SERVER then
    HLStories = {}
	HLStories.CombinePoints = 0
	HLStories.RebelPoints = 0
    HLStories.HasRoundStarted = false
	
	HLStories.ResearchMP7 = false
	HLStories.ResearchShotgun = false
	HLStories.ResearchFrag = false
	HLStories.ResearchPulse = false

if game.GetMap() == "rp_industrial17_v1" then

HLStories.Industrial = true

HLStories.RebelShipment1 = Vector(4963.072754, 3630.056885, 896.031250)
HLStories.RebelShipment2 = Vector(5700.427734, 3505.552490, 264.031250)
HLStories.RebelShipment3 = Vector(6055.172852, 1861.960205, 484.031250)
HLStories.RebelShipment4 = Vector(4387.916016, 3121.583984, 150.003571)

HLStories.CWUShipment = Vector(58.051399230957,2660.5297851563,188.53692626953)
HLStories.CWUShipment2 = Vector(58.051399230957,2660.5297851563,188.53692626953)

HLStories.TablePosition = Vector(5934.4951171875,5329.6928710938,-13.612091064453)
HLStories.TableAngle = Angle(4.5434455871582,-89.999542236328,0.0056289355270565)

HLStories.SabotagePosition = Vector(3989.9360351563,4755.333984375,816.47583007813)
HLStories.SabotageAngle = Angle(0.0028116253670305,90.115875244141,0.057583913207054)

HLStories.WorkerComputerPos = Vector(-50.00643157959,2982.0895996094,172.52619934082)
HLStories.WorkerComputerAng = Angle(0,270.10876464844,0)

HLStories.GenericComputerPos = Vector(1951.3385009766,5080.2861328125,418.1125793457)
HLStories.GenericComputerAng = Angle(0,-100.82386016846,0)

HLStories.GenericComputerSpawn = Vector(1981.5576171875,5068.9057617188,435.9567565918)

HLStories.CombineArmoryPos = Vector(3349.4045410156,4181.5048828125,392.45007324219)
HLStories.CombineArmoryAng = Angle(-0.00020596910326276,179.90277099609,-0.08612060546875)


end	

	
	ResistanceRadio = {}
	ResistanceRadio.RadioFreq = math.random(100, 199).."."..math.random(1,9)
	
	
ResistanceMembers = {}

function PLUGIN:DoPlayerDeath(player, attacker, damageInfo)
   
if player:GetCharacterData("IsRebel") == true then

player:SetCharacterData("IsRebel", false)
	if #ResistanceMembers > 0 then
		
		table.RemoveByValue(ResistanceMembers, player)
		
		timer.Simple(0.1, function()
			if #ResistanceMembers == 0 then
				
				if HLStories.VictoryCombine ~= true then
					HLStories.VictoryCombine = true
					EndRound("Combine")		
				end
			
			end
		end)
		
	end

end
		


end


util.AddNetworkString("VisorInform")
function VisorInformServerSide(ply, info)
	for k,v in pairs(player.GetAll()) do
		if v:GetFaction() == FACTION_MPF then
			net.Start("VisorInform")
			net.WriteEntity(ply)
			net.WriteString(info)
			net.Send(v)
		end
	end
end


function AddCombinePoints(amount)

HLStories.CombinePoints = HLStories.CombinePoints + amount


	for k,v in pairs(ents.FindByClass("combine_generator")) do 
		
		v:SetNWInt("Points", HLStories.CombinePoints)
		
	end
	
	for k,v in pairs(ents.FindByClass("combine_research")) do 
		
		v:SetNWInt("Points", HLStories.CombinePoints)
		
	end

end

function ReturnCombinePoints()

	return HLStories.CombinePoints

end

function CreateCWUShipment(uniqueid, amount)
    local entity = ents.Create("cw_shipment")
    entity:SetItemTable(uniqueid, amount)
    entity:SetNWBool("CWUShipment", true)
    entity:SetAngles(Angle(0, 0, 0))
	entity:SetModel("models/items/item_item_crate.mdl")
-- I select random twice cause I dont want the only type of model to spawn in that type of location.
    local RandomLocation = math.random(1, 2)

    if RandomLocation == 1 then
        entity:SetPos(HLStories.CWUShipment)
    elseif RandomLocation == 2 then
        entity:SetPos(HLStories.CWUShipment2)
    end

    entity:Spawn()
end

function SpendCombinePoints(amount)

	if HLStories.CombinePoints >= amount then
		
		HLStories.CombinePoints = HLStories.CombinePoints - amount
		
	for k,v in pairs(ents.FindByClass("combine_generator")) do 
		
		v:SetNWInt("Points", HLStories.CombinePoints)
		
	end

	for k,v in pairs(ents.FindByClass("combine_research")) do 
		
		v:SetNWInt("Points", HLStories.CombinePoints)
		
	end

		return true
		
	else
		return false
	end

end

function AddRebelPoints(amount)

HLStories.RebelPoints = HLStories.RebelPoints + amount
print"test"

	for k,v in pairs(ents.FindByClass("radio")) do 
		
		v:SetNWInt("Money", HLStories.RebelPoints)
		
	end
	
	for k,v in pairs(ents.FindByClass("computer")) do 
		
		v:SetNWInt("Money", HLStories.RebelPoints)
		
	end

end

function ReturnRebelPoints()

return HLStories.RebelPoints

end



function SpendRebelPoints(amount)

	if HLStories.RebelPoints >= amount then
		
		HLStories.RebelPoints = HLStories.RebelPoints - amount
		
	for k,v in pairs(ents.FindByClass("radio")) do 
		
		v:SetNWInt("Money", HLStories.RebelPoints)
		
	end

	for k,v in pairs(ents.FindByClass("computer")) do 
		
		v:SetNWInt("Money", HLStories.RebelPoints)
		
	end

		return true
		
	else
		return false
	end

end

-- if SpendCombinePoints(amount) == true then
    -- concommand.Add("addpoints", function()
	-- AddCombinePoints(15)
    -- end)

    -- concommand.Add("countpoints", function()
	-- print(tostring(ReturnCombinePoints()))
    -- end)

	
	print(ResistanceRadio.RadioFreq)

    function PLUGIN:ClockworkInitPostEntity()
        
    for k,v in pairs(ents.FindByClass("prop_door_rotating")) do
        v:Fire("Close","",0)
    end
	
	if HLStories.Industrial == true then
	

local ent = ents.Create( 'combine_generator' )
ent:SetModel("models/props_combine/masterinterface.mdl")
ent:SetPos(Vector(1280.6416015625,5689.6845703125,128.94323730469))
ent:SetAngles(Angle(0,359.41235351562,0))
ent:Spawn()
local phys = ent:GetPhysicsObject()
phys:EnableMotion(false)

local ent = ents.Create( 'combine_research' )
ent:SetModel("models/betaprops/arcade/arcademachine.mdl")
ent:SetPos(Vector(1318.2626953125,5276.4482421875,168.45452880859))
ent:SetAngles(Angle(0.12056158483028,-179.86737060547,-0.0069580078125))
ent:Spawn()
local phys = ent:GetPhysicsObject()
phys:EnableMotion(false)

local ent = ents.Create( 'combine_recycler' )
ent:SetModel("models/props_combine/combine_intwallunit.mdl")
ent:SetPos(Vector(1200.5889892578,5526.0981445312,183.86433410645))
ent:SetAngles(Angle(-0.19410128891468,0.084640696644783,0.037994384765625))
ent:Spawn()
local phys = ent:GetPhysicsObject()
phys:EnableMotion(false)

local ent = ents.Create( 'table' )
ent:SetModel("models/props_wasteland/controlroom_desk001b.mdl")
ent:SetPos(HLStories.TablePosition)
ent:SetAngles(HLStories.TableAngle)
ent:Spawn()
local phys = ent:GetPhysicsObject()
phys:EnableMotion(false)

local ent = ents.Create( 'sabotage_mission' )
ent:SetModel("models/props_combine/combinethumper002.mdl")
ent:SetPos(HLStories.SabotagePosition)
ent:SetAngles(HLStories.SabotageAngle)
ent:Spawn()
local phys = ent:GetPhysicsObject()
phys:EnableMotion(false)

local ent = ents.Create( 'cwu_computer' )
ent:SetModel("models/props_lab/monitor02.mdl")
ent:SetPos(HLStories.WorkerComputerPos)
ent:SetAngles(HLStories.WorkerComputerAng)
ent:Spawn()
ent:SetNWInt("Points", 999)
local phys = ent:GetPhysicsObject()
phys:EnableMotion(false)

local ent = ents.Create( 'cwu_computer' )
ent:SetModel("models/props_lab/monitor02.mdl")
ent:SetPos(HLStories.GenericComputerPos)
ent:SetAngles(HLStories.GenericComputerAng)
ent:Spawn()
ent:SetNWInt("Points", 999)
ent:SetNWBool("IsGeneric", true)
local phys = ent:GetPhysicsObject()
phys:EnableMotion(false)

local ent = ents.Create( 'combine_armory' )
ent:SetModel("models/props_combine/combine_interface002.mdl")
ent:SetPos(HLStories.CombineArmoryPos)
ent:SetAngles(HLStories.CombineArmoryAng)
ent:Spawn()
local phys = ent:GetPhysicsObject()
phys:EnableMotion(false)
	
	end
	
		timer.Simple(1, function()
		for k,v in pairs(ents.FindByClass("cw_shipment")) do 
			v:Remove()
		end
		end)
		
		timer.Simple(1.5, function()
		
		for k,v in pairs(ents.FindByClass("cw_item")) do
			v:Remove()
		end
		
		for k,v in pairs(ents.FindByClass("prop_physics")) do
			if v:GetModel() == string.lower("models/props_lab/citizenradio.mdl") and v:CreatedByMap() == true then
				v:Remove()
			end
		end


		for k,v in pairs(ents.FindByClass("prop_dynamic")) do
			if v:GetModel() == string.lower("models/props_interiors/VendingMachineSoda01a.mdl") and v:CreatedByMap() == true then
				v:Remove()
			end
		end

		for k,v in pairs(ents.FindByClass("prop_dynamic")) do
			if v:GetModel() == string.lower("models/props_wasteland/controlroom_desk001a.mdl") and v:CreatedByMap() == true then
				v:Remove()
			end
		end
	

	end)
	
end




   
	
    MsgC("Round system serverside loaded")

    function BeginRound()

        if not file.Exists("currentround.txt", "DATA") then
            print"lol"
            file.Write("currentround.txt", "0")
        else
            file.Write("currentround.txt", tonumber(file.Read("currentround.txt")) + 1)
        end
    end

    BeginRound()

    function GetRound()
        return tonumber(file.Read("currentround.txt"))
    end



function ResetCharacter(client)

        local character = client:GetCharacter()
        local inventory = client:GetInventory()
		
        for k,v in pairs( inventory ) do
            for k2,v2 in pairs( v ) do
                client:TakeItem( v2 )
            end
        end
		Clockwork.player:ClearRecognisedNames(client);
		client:SetCharacterData("Cash", 0, true)
        client:SetSharedVar("Cash", 0)
		client:SetSharedVar("bleeding", 0);
		client:SetSharedVar("cardiacArrest", 0);
		client:SetCharacterData( "heart", 60);
		client:SetCharacterData( "oxygen", 100);
		client:SetCharacterData( "blood", 100);
		client:SetCharacterData("HasDieded", false)
		client:SetArmor(0)
		client:SetCharacterData("NextDispenser", os.time())
		client:SetCharacterData("hunger", 0);
		client:SetCharacterData("thirst", 0);
		Clockwork.player:TakeFlags(client, "vV")
		client:SetCharacterData("AntagRole", false)
		client:SetCharacterData("IsSectorial", false)
		client:SetCharacterData("IsGrid", false)
		client:SetCharacterData("IsRebel", false)
		client:SetCharacterData("IsHelix", false)
		client:RemoveClothes();
		
		client:SetSharedVar("lPoints", 0);
		client:SetSharedVar("vPoints", 0);
		
		if client:GetCharacterData("SterelizedCredits") == nil then
			client:SetCharacterData("SterelizedCredits", 0)
		end
		
		timer.Simple(1, function()
		local model = client:GetCharacterData("OriginalModel")
		client:SetCharacterData("Model", model);
        client:SetModel(model)
		Clockwork.player:SetName(client, client:GetCharacterData("OriginalName"));
		end)
	
		client:SetCharacterData("LimbData", {});
		Clockwork.datastream:Start(client, "ResetLimbDamage", true);
		Clockwork.plugin:Call("PlayerLimbDamageReset", client);
		client:SaveCharacter();
        client:SetMaxHealth()
        
                if client:GetFaction() ~= FACTION_CITIZEN then
                    timer.Simple(0.01, function()
                        client:SetNWBool("HotLoad", true)
                        ResetIntoCitizen(client)

                        timer.Simple(0.01, function()
                            client:SetNWBool("HotLoad", false)
                        end)
                    end)
                end
        
		if HLStories.HasRoundStarted == false then
		    timer.Simple(2, function()
			client:SetPos(Vector(-13128.653320, 2306.515869, -13307.218750))
			end)
		else
		end
		




end



function PLUGIN:PlayerCharacterLoaded(client)
    if client:GetNWBool("HotLoad") == true then return end

    timer.Simple(0.5, function()
        if client:GetCharacterData("FirstTimeCheck") ~= true then
            client:SetCharacterData("FirstTimeCheck", true)
            client:SetCharacterData("OriginalModel", tostring(client:GetModel()))
            client:SetCharacterData("OriginalName", client:Nick())
        end
    end)


    if client:GetCharacterData("RoundID") == GetRound() then
        -- remember to add resistance variables here
        if client:GetCharacterData("IsSectorial") == true then
            client:SetNWBool("Sectorial", true)
        end

        if client:GetCharacterData("IsGrid") == true then
            client:SetNWBool("IsGrid", true)
        end

        if client:GetCharacterData("IsRebel") == true then
            client:SetNWBool("IsRebel", true)
        end

        if client:GetCharacterData("IsHelix") == true then
            client:SetNWBool("IsRebel", true)
        end
    end


if client:GetCharacterData("RoundID") ~= GetRound() then
    timer.Simple(0.1, function()
        if HLStories.HasRoundStarted == false then
            ResetCharacter(client)
            client:SetNWBool("HasPicked", false)
            client:SetNWBool("InLobby", true)
            client:SetCharacterData("RoundID", GetRound())
            timer.Simple(0.1, function() end)
        end

        if HLStories.HasRoundStarted == true then
            ResetCharacter(client)
            client:SetNWBool("DidntGetRole", true)
            CheckTableAvailable()
            client:SendLua("CheckTableAvailable()")
            client:SendLua("OpenRoundMenu()")
        end
    end)
end
    -- else
    -- Clockwork.datastream:Start(client, "InvClear", true);
    -- Clockwork.datastream:Start(client, "AttrClear", true);
    -- client:SetMaxHealth()
    -- client:SetCharacterData("RoundID", GetRound())
    -- client:Respawn()
end



	-- concommand.Add("victoryroyale1", function()
		-- EndRound("Combine")
	-- end)
	
	-- concommand.Add("victoryroyale2", function()
		-- EndRound("Lambda")
	-- end)
	
	function EndRound(stringarg)
		if stringarg == "Lambda" then
			for k,v in pairs(player.GetAll()) do
				v:SendLua("OpenEndMenu('Lambda')")
			end
		end
		if stringarg == "Combine" then
			for k,v in pairs(player.GetAll()) do
				v:SendLua("OpenEndMenu('Combine')")
			end
		end
	end

    concommand.Add("startround", function(ply)
		if ply:IsAdmin() then
		  HLStories.HasRoundStarted = true
			StartRound(15)
		end
    end)


concommand.Add("npc_pos", function(ply)
    local tr = ply:GetEyeTrace()

    if (IsValid(tr.Entity)) then
		ply:ChatPrint("local ent = ents.Create( '"..tostring(tr.Entity:GetClass()).."' )")
		ply:ChatPrint([[ent:SetModel("]]..tr.Entity:GetModel()..[[")]])
        ply:ChatPrint("ent:SetPos(Vector(" .. tostring(tr.Entity:GetPos()[1] .. "," .. tr.Entity:GetPos()[2] .. "," .. tr.Entity:GetPos()[3]) .. "))")
        ply:ChatPrint("ent:SetAngles(Angle(" .. tostring(tr.Entity:GetAngles()[1] .. "," .. tr.Entity:GetAngles()[2] .. "," .. tr.Entity:GetAngles()[3]) .. "))")
		ply:ChatPrint("ent:Spawn()")
    else
        ply:ChatPrint("Crosshair position:", tostring(tr.HitPos))
    end
end)

function AssignAntag(myPlayer, role)
    local RandomValue = math.random(1, #AntagonistsRoles)
    local NateHiggers = AntagonistsRoles[RandomValue]
    if role == NateHiggers[5] and NateHiggers[3] <= player.GetCount() then
            Clockwork.player:Notify(myPlayer, NateHiggers[4])
			myPlayer:SetCharacterData("AntagRole", NateHiggers[2])
        if NateHiggers[2] == "ANTAG_LEADER" then
		
        
        table.insert(ResistanceMembers, myPlayer)
            
            for k,v in pairs(player.GetAll()) do
                if v:IsAdmin() then
                    v:ChatPrint(myPlayer:Nick().." Is resistance leader.")
                end
            end
            
			myPlayer:SendLua("surface.PlaySound('music/resistance_theme.mp3')")
			
			myPlayer:GiveItem(Clockwork.item:CreateInstance("resistance_radio"))
			myPlayer:GiveItem(Clockwork.item:CreateInstance("handh_radio"))
			Clockwork.player:Notify(myPlayer,"Your shared frequency is: "..ResistanceRadio.RadioFreq)
			myPlayer:SetCharacterData("IsRebel", true)
			myPlayer:SetNWBool("IsRebel", true)
			
        end
        if NateHiggers[2] == "ANTAG_RESISTANCE" then

        table.insert(ResistanceMembers, myPlayer)

			Clockwork.player:Notify(myPlayer,"Your shared frequency is: "..ResistanceRadio.RadioFreq)
			myPlayer:SendLua("surface.PlaySound('music/resistance_theme.mp3')")

		myPlayer:SetCharacterData("IsRebel", true)
		myPlayer:SetNWBool("IsRebel", true)
		myPlayer:GiveItem(Clockwork.item:CreateInstance("handh_radio"))
		

        end
		PrintTable(ResistanceMembers)
		if NateHiggers[2] == "ANTAG_LOYALIST" then


			myPlayer:SendLua("surface.PlaySound('music/resistance_theme.mp3')")

		myPlayer:GiveItem(Clockwork.item:CreateInstance("request_device"))
		myPlayer:GiveItem(Clockwork.item:CreateInstance("laborer_uniform"))


		end

        table.remove(AntagonistsRoles, RandomValue)
        print("Removed from table xd")
    end
end
		
function AssignRole(player, role)
    

    
    if role == "CITIZEN" then
        player:SetNWBool("HotLoad", true)
        TurnIntoCitizen(player)
        Clockwork.player:Notify(player, "You are a CITIZEN. You have been re-located to this city for reasons unknown to you. Life is hard here, but you must learn to survive here one way or another. Protect yourself and avoid Civil Protection.")
		
		
        AssignAntag(player, role)
		
		local itemTable = Clockwork.item:CreateInstance(Clockwork.player:GetFactionTable(player).giveCard)
		if (itemTable) then
			player:GiveItem(itemTable, true);
		end;
		
		
		timer.Simple(1, function()
		local model = player:GetCharacterData("OriginalModel")
		player:SetCharacterData("Model", model);
        player:SetModel(model)
		end)
		
    end

    if role == "CWU_WORKER" then
        player:SetNWBool("HotLoad", true)
        TurnIntoCWU(player)
        Clockwork.player:Notify(player, "You are a CIVIL WORKER. The Civil Workers' Union has decided to hire you. You have been assigned a store, and you must sell CWU produce. You are also tasked with manufacturing items, by supplying citizens with Work Cycles.")
		
		local itemTable = Clockwork.item:CreateInstance("worker_card")
		if (itemTable) then
			player:GiveItem(itemTable, true);
		end;
		
		player:GiveItem(Clockwork.item:CreateInstance("cwu_uniform"))
		player:GiveItem(Clockwork.item:CreateInstance("worker_radio"))
		if math.random(1,3) == 2 then 
		player:GiveItem(Clockwork.item:CreateInstance("book_zotu"))
		end
		
		timer.Simple(1, function()
		local model = player:GetCharacterData("OriginalModel")
		player:SetCharacterData("Model", model);
        player:SetModel(model)
		end)
		
    end

    if role == "CWU_DOCTOR" then
        player:SetNWBool("HotLoad", true)
        TurnIntoCWU(player)
        Clockwork.player:Notify(player, "You are a CIVIL DOCTOR. The Civil Workers' Union has decided to hire you. You have been assigned to the city's Hospital, and you must treat citizens who need medical attention.")

		local itemTable = Clockwork.item:CreateInstance("worker_card")
		if (itemTable) then
			player:GiveItem(itemTable, true);
		end;
				
		player:GiveItem(Clockwork.item:CreateInstance("doctor_uniform"))
		player:GiveItem(Clockwork.item:CreateInstance("worker_radio"))
		player:GiveItem(Clockwork.item:CreateInstance("uu_bandage"))
		if math.random(1,3) == 2 then 
		player:GiveItem(Clockwork.item:CreateInstance("uu_bandage"))
		end
		
		timer.Simple(1, function()
		local model = player:GetCharacterData("OriginalModel")
		player:SetCharacterData("Model", model);
        player:SetModel(model)
		end)
		
    end

    if role == "BMD" then
        player:SetNWBool("HotLoad", true)
        TurnIntoCitizen(player)
		Clockwork.player:GiveFlags(player, "vV")
        Clockwork.player:Notify(player, "You are a BLACK MARKET DEALER. You have managed to smuggle contraband into the city, and many are lining up to see your goods. Sell your wares but don't get caught by Civil Protection.")
		local itemTable = Clockwork.item:CreateInstance(Clockwork.player:GetFactionTable(player).giveCard)
			if (itemTable) then
				player:GiveItem(itemTable, true);
			end;
		player:SetCharacterData("Cash", 1000, true)
        player:SetSharedVar("Cash", 1000)

    	timer.Simple(1, function()
		local model = player:GetCharacterData("OriginalModel")
		player:SetCharacterData("Model", model);
        player:SetModel(model)
		end)

    end



    if role == "BIOTIC" then
        player:SetNWBool("HotLoad", true)
        Clockwork.player:Notify(player, "You are a BIOTIC. You have been enslaved and shackled by the Combine after only moments of freedom. Under increased scrutiny by the CCA, you must follow their orders or risk amputation.")
    end

    if role == "UNION" then
        player:SetNWBool("HotLoad", true)
        TurnIntoCP(player, role)
		SetCPName(player, role)
        player:GiveItem(Clockwork.item:CreateInstance("union_civil_protection_uniform"))
        player:GiveItem(Clockwork.item:CreateInstance("cw_stunstick"))
        Clockwork.player:Notify(player, "You are a UNION. A standard patrol unit of the CCA. Maintain stability and answer to your superiors.")
    end

    if role == "HELIX" then
        player:SetNWBool("HotLoad", true)
        TurnIntoCP(player, role)
        SetCPName(player, role)
        player:GiveItem(Clockwork.item:CreateInstance("helix_civil_protection_uniform"))
        player:GiveItem(Clockwork.item:CreateInstance("cw_stunstick"))
        Clockwork.player:Notify(player, "You are a HELIX. A medical unit of the CCA. You are tasked with ensuring the health and well-being of your fellow units. Answer to your superiors.")
		player:SetCharacterData("IsHelix", true)
		player:SetNWBool("IsHelix", true)
    end

    if role == "JUDGE" then
        player:SetNWBool("HotLoad", true)
        TurnIntoCP(player, role)
        SetCPName(player, role)
        player:GiveItem(Clockwork.item:CreateInstance("judge_civil_protection_uniform"))
        player:GiveItem(Clockwork.item:CreateInstance("cw_stunstick"))
		Clockwork.player:Notify(player, "You are a JUDGE. You are tasked with processing prisoners. You are also tasked with interrogation, and sometimes torture. Answer to your superiors.")
    end

    if role == "GRID" then
        player:SetNWBool("HotLoad", true)
        TurnIntoCP(player, role)
        SetCPName(player, role)
        player:GiveItem(Clockwork.item:CreateInstance("grid_civil_protection_uniform"))
        player:GiveItem(Clockwork.item:CreateInstance("cw_stunstick"))
        Clockwork.player:Notify(player, "You are a GRID. A mechanical unit of the CCA. You are tasked with ensuring the mechanical stability of the Combine tech in the city.")
		player:SetCharacterData("IsGrid", true)
		player:SetNWBool("IsGrid", true)
    end

    if role == "SECTORIAL" then
        player:SetNWBool("HotLoad", true)
        TurnIntoCP(player, role)
        SetCPName(player, role)
        player:GiveItem(Clockwork.item:CreateInstance("sectorial_civil_protection_uniform"))
        player:GiveItem(Clockwork.item:CreateInstance("cw_stunstick"))

		player:SetCharacterData("IsSectorial", true)
		player:SetNWBool("IsSectorial", true)

        Clockwork.player:Notify(player, "You are the SECTORIAL. Commander-in-chief of the CCA. Command your units and take orders from the City Administrator. Maintain stability in the city.")
		
    end
    if role == "CA" then
        player:SetNWBool("HotLoad", true)
        TurnIntoCA(player) 
        Clockwork.player:Notify(player, "You are the CITY ADMINISTRATOR. You have been selected by your benefactors to maintain stability in this City by any means necessary. Use the CCA to your benefit and serve the Universal Union.")
    end
    timer.Simple(0.5, function()
    player:Spawn()
    end)
end

function SetCPName(player, role)
    				--local CombineRank = "RCT"
    				local CombineRank = "0"..math.random(1,5)
				
				if tonumber(player:GetCharacterData("SterelizedCredits")) == 1 then
					CombineRank = "05"
				end
				if tonumber(player:GetCharacterData("SterelizedCredits")) >= 3 then
					CombineRank = "04"				
				end
				if tonumber(player:GetCharacterData("SterelizedCredits")) >= 10 then
					CombineRank = "03"				
				end
				if tonumber(player:GetCharacterData("SterelizedCredits")) >= 15 then
					CombineRank = "02"				
				end
				if tonumber(player:GetCharacterData("SterelizedCredits")) >= 20 then
					CombineRank = "01"				
				end
				if tonumber(player:GetCharacterData("SterelizedCredits")) >= 30 then
					CombineRank = "EpU"				
				end
				if tonumber(player:GetCharacterData("SterelizedCredits")) >= 45 then
					CombineRank = "OfC"				
				end
				if tonumber(player:GetCharacterData("SterelizedCredits")) >= 60 then
					CombineRank = "DvL"				
				end
				
				timer.Simple(1.5, function()
			    	if role ~= "SECTORIAL" then	
				    	player:SetCharacterData("Name", "MPF-"..role.."."..CombineRank.."."..tostring((math.random(1,9)))..tostring(math.random(1,9)), true);
			       	else
				    	player:SetCharacterData("Name", "MPF-SeC."..tostring((math.random(1,9)))..tostring(math.random(1,9)), true);
			    	end
				end)
end

    function TurnIntoCP(player, role)
        timer.Simple(0.01, function()
            if player:GetFaction() ~= FACTION_MPF then
                player:SetCharacterData("Faction", FACTION_MPF, true)
                Clockwork.player:LoadCharacter(player, Clockwork.player:GetCharacterID(player))
				local modelName = string.gsub(string.lower(player:GetModel()), "^.-/.-/.-/", "");
				if (modelName == "male_10.mdl" or modelName == "male_11.mdl") then
					modelName = "male_01.mdl";
				end;

				player:SetCharacterData("Model", "models/humans/combine/"..modelName, true);
				player:SetModel("models/humans/combine/"..modelName);
				
				player:SendLua("surface.PlaySound('music/combine_theme.mp3')")
				player:SendLua("InformationCard()")
				

                timer.Simple(0.01, function()
                    player:Respawn()
                    player:SetNWBool("HotLoad", nil)
                end)
            end
        end)
    end

    function TurnIntoCitizen(player)
        timer.Simple(0.01, function()

                player:SetCharacterData("Faction", FACTION_CITIZEN, true)
                Clockwork.player:LoadCharacter(player, Clockwork.player:GetCharacterID(player))
	

                timer.Simple(0.01, function()
                    player:Spawn()
                    player:SetNWBool("HotLoad", nil)
					player:SetCharacterData("Model", player:GetCharacterData("OriginalModel"));
                    player:SetModel(player:GetCharacterData("OriginalModel"))
                end)
        end)
    end

    function ResetIntoCitizen(player)
        timer.Simple(0.01, function()
            if player:GetFaction() ~= FACTION_CITIZEN then
                player:SetCharacterData("Faction", FACTION_CITIZEN, true)
                Clockwork.player:LoadCharacter(player, Clockwork.player:GetCharacterID(player))

                timer.Simple(0.01, function()
                    player:SetNWBool("HotLoad", nil)
					player:SetCharacterData("Model", player:GetCharacterData("OriginalModel"));
                    player:SetModel(player:GetCharacterData("OriginalModel"))
                end)
            end
        end)
    end

    function TurnIntoCWU(player)
        timer.Simple(0.01, function()
            if player:GetFaction() ~= FACTION_CWU then
                player:SetCharacterData("Faction", FACTION_CWU, true)
                Clockwork.player:LoadCharacter(player, Clockwork.player:GetCharacterID(player))
			end

                timer.Simple(0.01, function()
                    player:Spawn()
                    player:SetNWBool("HotLoad", nil)
					player:SetCharacterData("Model", player:GetCharacterData("OriginalModel"), true);
                    player:SetModel(player:GetCharacterData("OriginalModel"))
                end)
            
        end)
    end
	
    function TurnIntoCA(player)
        timer.Simple(0.01, function()
            if player:GetFaction() ~= FACTION_ADMIN then
                player:SetCharacterData("Faction", FACTION_ADMIN, true)
                Clockwork.player:LoadCharacter(player, Clockwork.player:GetCharacterID(player))
			end

                timer.Simple(0.01, function()
                    player:Spawn()
                    player:SetNWBool("HotLoad", nil)
                    
					if (player:GetGender() == GENDER_FEMALE) then
						player:SetCharacterData("Model", "models/humans/suitfem/female_02.mdl", true);
						player:SetModel("models/humans/suitfem/female_02.mdl");
					else
						player:SetCharacterData("Model", "models/taggart/gallahan.mdl", true);
						player:SetModel("models/taggart/gallahan.mdl");
					end;
					
                end)
            
        end)
    end
	
    function TurnIntoCMU(player)
        timer.Simple(0.01, function()
            if player:GetFaction() ~= FACTION_CMU then
                player:SetCharacterData("Faction", FACTION_CMU, true)
                Clockwork.player:LoadCharacter(player, Clockwork.player:GetCharacterID(player))
			end

                timer.Simple(0.01, function()
                    player:Spawn()
                    player:SetNWBool("HotLoad", nil)
					player:SetCharacterData("Model", player:GetCharacterData("OriginalModel"), true);
                    player:SetModel(player:GetCharacterData("OriginalModel"))
                end)
            
        end)
    end
	
	

    -- function TurnIntoVort(player)
    -- timer.Simple(0.01, function()
    -- if player:GetFaction() ~= FACTION_CWU then
    -- player:SetCharacterData("Faction", FACTION_CWU, true);
    -- Clockwork.player:LoadCharacter(player, Clockwork.player:GetCharacterID(player));
    -- end
    -- end)
    -- end
    function GmanPick()
        timer.Simple(60, function()
            if CountPlayers() != 0 then
                timer.Create("GmanPickCounter", 0.01, CountPlayers(), function()
                    ClaimRoles()
                end)
            end
        end)



    end

    -- roundtime in seconds
    function StartRound(roundtime)
        for k, v in pairs(player.GetAll()) do
            v:SendLua("OpenRoundTimer(" .. roundtime .. ")")
        end

        timer.Simple(roundtime, function()
            for k, v in pairs(player.GetAll()) do
                if v:GetNWBool("InLobby") == true then
                    v:SendLua("OpenRoundMenu()")
					v:SendLua("surface.PlaySound('music/gman_choose.mp3')")
                end
				GmanPick()
            end
        end)
    end

    util.AddNetworkString("RoleInformation")
	
    net.Receive("RoleInformation", function(len, pl)
        local ply = net.ReadEntity(ply)
        local maxam = net.ReadInt(32)
        local role = net.ReadString(role)
		
		if ply:SteamID64() ~= pl:SteamID64() then return end

		
		if role == "I_DIDNT_PICK" and ply:GetNWBool("HasPicked") ~= true then
			ply:SetNWBool("LatePick", true)
			return
		end
	
	ResetCharacter(ply)
	ply:SetNWBool("DontShowAgain", true)
        if ply:GetNWBool("HasPicked") ~= true and ply:GetNWBool("LatePick") ~= true then
            ply:SetNWBool("HasPicked", true)
            InsertPlayerRole(ply, role, maxam)
        end
		
		if ply:GetNWBool("DidntGetRole") == true and ply:GetNWBool("LatePick") ~= true then
			if MaxRoles(role, maxam, ply) == true then
				ply:SetNWBool("GotRole", true)
				ply:SetNWString("AssignedRole",role)
				AssignRole(ply, role)
				--table.Remove(PickedRole, table.RemoveByValue(PickedRole,CurrentPlayer[1][1]))
			end
		end
		
		if ply:GetNWBool("LatePick") == true and ply:GetNWBool("DidntGetRole") ~= true then
			if MaxRoles(role, maxam, ply) == true then
				ply:SetNWBool("GotRole", true)
				ply:SetNWString("AssignedRole",role)
				AssignRole(ply, role)
				--table.Remove(PickedRole, table.RemoveByValue(PickedRole,CurrentPlayer[1][1]))
			end
		end
		
    end)

    PickedRole = {}

    function InsertPlayerRole(player, role, maxam)
        local Arguments = {player, role, maxam}
        PrintTable(Arguments)
        table.insert(PickedRole, Arguments)
        --player:SetNWString("PickedRole", role)
    end

    function MaxRoles(role, maxamount, jews)
		
		if maxamount > RoleCount(role) then
			return true
		else
			if jews:GetNWBool("GotRole") ~= true then
				
				jews:SetNWBool("DidntGetRole", true)
				timer.Simple(5, function()
				CheckTableAvailable()
				jews:SendLua("CheckTableAvailable()")
				jews:SendLua("OpenRoundMenu()")
				end)
				
				
			end
		end
		
    end

    function CountPlayers()
        local CountPlayers = 0

        for k, v in pairs(player.GetAll()) do
            if v:GetNWBool("HasPicked") == true then
                CountPlayers = CountPlayers + 1
            end
        end

        return CountPlayers
    end



    function ClaimRoles()
        local CurrentPlayer = {}
        local RandomValue = math.random(1, #PickedRole)
        local RandomPlayer = PickedRole[RandomValue]
        table.insert(CurrentPlayer, RandomPlayer)
        table.remove(PickedRole, RandomValue)
        --if !IsValid(PickedRole) then return end
        if IsValid(CurrentPlayer[1][1]) == false then return end

        if MaxRoles(CurrentPlayer[1][2], CurrentPlayer[1][3], CurrentPlayer[1][1]) == true then
            CurrentPlayer[1][1]:SetNWBool("GotRole", true)
			CurrentPlayer[1][1]:SetNWString("AssignedRole",CurrentPlayer[1][2])
            AssignRole(CurrentPlayer[1][1], CurrentPlayer[1][2])
			Clockwork.player:ClearRecognisedNames(CurrentPlayer[1][1]);
            table.remove(CurrentPlayer)
            --table.Remove(PickedRole, table.RemoveByValue(PickedRole,CurrentPlayer[1][1]))
        end
    end







end