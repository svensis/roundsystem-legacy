local PLUGIN = PLUGIN
local Clockwork = Clockwork



-- local stunstickState = false
-- local stunstickLastState = false
-- local lastActiveWep = ""





-- function Perform()
-- timer.Create("stunstickCheck", 1.0, 0, function()
    -- if Raised == false then
        -- if (Clockwork.player:GetWeaponRaised(LocalPlayer()) == true) then
            -- Raised = true
            -- LastWep = LocalPlayer():GetActiveWeapon():GetClass()

            -- if LocalPlayer():GetActiveWeapon():GetPrintName() ~= "Hands" or LocalPlayer():GetActiveWeapon():GetPrintName() ~= "Stunstick" then
                -- sendToChat(3, "raises their " .. LocalPlayer():GetActiveWeapon():GetPrintName() .. " and gets ready to fire.")
            -- elseif LocalPlayer():GetActiveWeapon():GetPrintName() == "Stunstick" then
                -- sendToChat(3, "raises their stunstick and flicks it on.")
            -- elseif LocalPlayer():GetActiveWeapon():GetPrintName() == "Hands" then
                -- sendToChat(3, "raises their fists in a fighting stance.")
            -- end
        -- end
    -- end

    -- if Raised == true and Clockwork.player:GetWeaponRaised(LocalPlayer()) == false and LastWep == LocalPlayer():GetActiveWeapon():GetClass() and LocalPlayer():IsSprinting() ~= true then
        -- Raised = false
        -- LastWep = LocalPlayer():GetActiveWeapon():GetClass()

        -- if LocalPlayer():GetActiveWeapon():GetPrintName() ~= "Hands" then
            -- sendToChat(3, "lowers their " .. LocalPlayer():GetActiveWeapon():GetPrintName() .. " and holds it in their right hand.")
        -- else
            -- sendToChat(3, "lowers their fists, and returns to their normal stance.")
        -- end
    -- end

-- end)
-- end

-- function sendToChat(type, string)
	-- net.Start( "combineassistant" )
		-- net.WriteInt( tonumber(type), 32 )
		-- net.WriteString( string )
	-- net.SendToServer()
-- end


	-- // Raise stunstick
	-- if stunstickState != stunstickLastState then
		-- if (Clockwork.player:GetWeaponRaised(LocalPlayer()) == true) then
			-- sendToChat(3, "raises his stunstick and flicks it on "..stunstickVoltage.." voltage.");
			-- stunstickLastState = true
		-- else
			-- sendToChat(3, "turns off his stunstick and lowers it.");
			-- stunstickLastState = false
		-- end
	-- end
	
	-- // Un(holster) Stunstick.
	-- if currentActiveWep != lastActiveWep then
		-- if currentActiveWep == "Stunstick" and lastActiveWep != "Stunstick" then
			-- sendToChat(3, "unclips his stunstick from the belt and places it in his right hand.");
			-- lastActiveWep = "Stunstick"
		-- elseif lastActiveWep == "Stunstick" then
			-- sendToChat(3, "clips his stunstick it to the belt.");
			-- lastActiveWep = LocalPlayer():GetActiveWeapon():GetPrintName()
		-- end
	-- end


--[[
    A Simple Garry's mod drawing library
    Copyright (C) 2016 Bull [STEAM_0:0:42437032] [76561198045139792]
    Freely acquirable at https://github.com/bull29/b_draw-lib
    You can use this anywhere for any purpose as long as you acredit the work to the original author with this notice.
    Optionally, if you choose to use this within your own software, it would be much appreciated if you could inform me of it.
    I love to see what people have done with my code! :)
]]--

file.CreateDir("downloaded_assets")

net.Receive( "VisorInform", function()
    local ply = net.ReadEntity(ply)
	local info = net.ReadString(info)
	
	Schema:AddCombineDisplayLine( ply:Nick().." has ordered "..info.." from the supply terminal.", Color(0, 200, 0, 255) );
	
end)

local exists = file.Exists
local write = file.Write
local fetch = http.Fetch
local white = Color( 255, 255, 255 )
local surface = surface
local crc = util.CRC
local _error = Material("error")
local math = math
local mats = {}
local fetchedavatars = {}

function fetch_asset(url)
	if not url then return _error end

	if mats[url] then
		return mats[url]
	end

	local crc = crc(url)

	if exists("downloaded_assets/" .. crc .. ".png", "DATA") then
		mats[url] = Material("data/downloaded_assets/" .. crc .. ".png")

		return mats[url]
	end

	mats[url] = _error

	fetch(url, function(data)
		write("downloaded_assets/" .. crc .. ".png", data)
		mats[url] = Material("data/downloaded_assets/" .. crc .. ".png", "noclamp smooth")
	end)

	return mats[url]
end

local function fetchAvatarAsset( id64, size )
	id64 = id64 or "BOT"
	size = size == "medium" and "medium" or size == "small" and "" or size == "large" and "full" or ""

	if fetchedavatars[ id64 .. " " .. size ] then
		return fetchedavatars[ id64 .. " " .. size ]
	end

	fetchedavatars[ id64 .. " " .. size ] = id64 == "BOT" and "http://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/09/09962d76e5bd5b91a94ee76b07518ac6e240057a_full.jpg" or "http://i.imgur.com/uaYpdq7.png"
	if id64 == "BOT" then return end
	fetch("http://steamcommunity.com/profiles/" .. id64 .. "/?xml=1",function( body )
		local link = body:match("http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/.-jpg")
		if not link then return end

		fetchedavatars[ id64 .. " " .. size ] = link:Replace( ".jpg", ( size ~= "" and "_" .. size or "") .. ".jpg")
	end)
end

function draw.WebImage( url, x, y, width, height, color, angle, cornerorigin )
	color = color or white

	surface.SetDrawColor( color.r, color.g, color.b, color.a )
	surface.SetMaterial( fetch_asset( url ) )
	if not angle then
		surface.DrawTexturedRect( x, y, width, height)
	else
		if not cornerorigin then
			surface.DrawTexturedRectRotated( x, y, width, height, angle )
		else
			surface.DrawTexturedRectRotated( x + width / 2, y + height / 2, width, height, angle )
		end
	end
end

function draw.SeamlessWebImage( url, parentwidth, parentheight, xrep, yrep, color )
	color = color or white
	local xiwx, yihy = math.ceil( parentwidth/xrep ), math.ceil( parentheight/yrep )
	for x = 0, xrep - 1 do
		for y = 0, yrep - 1 do
			draw.WebImage( url, x*xiwx, y*yihy, xiwx, yihy, color )
		end
	end
end

function draw.SteamAvatar( avatar, res, x, y, width, height, color, ang, corner )
	draw.WebImage( fetchAvatarAsset( avatar, res ), x, y, width, height, color, ang, corner )
end





function OpenEndMenu(victory)

print(victory)
        
		
		local Frame = vgui.Create("DFrame")
        Frame:MakePopup(true)
        Frame:SetSize(ScrW(), ScrH())
        Frame:Center()
		Frame:SetDraggable( false )
        Frame:SetBackgroundBlur(true)
		Frame:ShowCloseButton( false )
		
		
        local title = vgui.Create("DLabel", Frame)
		if victory == "Lambda" then
        title:SetText("THE LAMBDA IS VICTORIOUS")
		end
		if victory == "Combine" then
		title:SetText("THE COMBINE IS VICTORIOUS")
		end
        title:SetFont("ixMenuButtonHugeFont")
        title:SetTextColor(Color(255, 255, 255))
        title:SizeToContents()
        title:SetPos(nil, ScrH()/7.5)
        title:CenterHorizontal()


		local LambdaMaterial = fetch_asset("https://i.imgur.com/sRmsiPq.png")
		local CombineMaterial = fetch_asset("https://i.imgur.com/zep1OCQ.png")


 		local mat = vgui.Create("Material", Frame)
		--mat:SetSize(ScrW()/11 * 1.016930022573363 , ScrW()/11 )
		mat:SetSize(ScrW()/11 * 1.016930022573363 , ScrW()/11   )
		mat:SetPos(nil, ScrH()/4.5)
		mat:CenterHorizontal() 
 if victory == "Lambda" then
		mat:SetMaterial("!" .. LambdaMaterial:GetName())
end
if victory == "Combine" then
		mat:SetMaterial("!" .. CombineMaterial:GetName() )
end
		mat.AutoSize = false
		


		

	    local title = vgui.Create("DLabel", Frame)
        title:SetText("WIN REASON")
        title:SetFont("ixMenuButtonFont")
        title:SetTextColor(Color(255, 255, 255))
        title:SizeToContents()
        title:SetPos(nil, (ScrH()/2) - (ScrH()/10  )  )
        title:CenterHorizontal( )	
		
        local title = vgui.Create("DLabel", Frame)
        title:SetText("FUN THING 1")
        title:SetFont("ixMenuButtonFont")
        title:SetTextColor(Color(255, 255, 255))
        title:SizeToContents()
        title:SetPos(nil, ScrH()/2 )
        title:CenterHorizontal()
				
		local title = vgui.Create("DLabel", Frame)
        title:SetText("FUN THING 2")
        title:SetFont("ixMenuButtonFont")
        title:SetTextColor(Color(255, 255, 255))
        title:SizeToContents()
        title:SetPos(nil, (ScrH()/2) + (ScrH()/10) )
        title:CenterHorizontal()
		
end