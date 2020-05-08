local PLUGIN = PLUGIN



-- function PLUGIN:MenuItemsAdd(menuItems)
-- menuItems:Add("Objectives", "cwObjectives", "Character and Faction Objectives");
-- end;

if CLIENT then

local LogoMaterial = fetch_asset("https://i.imgur.com/uw3CfmN.png")

local CombineInfo = fetch_asset("https://i.imgur.com/c0RjUWQ.png")

local LambdaMaterial = fetch_asset("https://i.imgur.com/sRmsiPq.png")

local CombineMaterial = fetch_asset("https://i.imgur.com/zep1OCQ.png")




function Derma_Query2( strText, strTitle, ... )

	local Window = vgui.Create( "DFrame" )
	Window:SetTitle( strTitle or "Message Title (First Parameter)" )
	Window:SetDraggable( false )
	Window:ShowCloseButton( false )
	Window:SetBackgroundBlur( true )
	Window:SetDrawOnTop( true )

	local InnerPanel = vgui.Create( "DPanel", Window )
	InnerPanel:SetPaintBackground( false )

	local Text = vgui.Create( "DLabel", InnerPanel )
	Text:SetText( strText or "Message Text (Second Parameter)" )
	Text:SizeToContents()
	Text:SetContentAlignment( 5 )
	Text:SetTextColor( color_white )

	local ButtonPanel = vgui.Create( "DPanel", Window )
	ButtonPanel:SetTall( 30 )
	ButtonPanel:SetPaintBackground( false )

	-- Loop through all the options and create buttons for them.
	local NumOptions = 0
	local x = 5

	for k=1, 8, 2 do

		local Text = select( k, ... )
		if Text == nil then break end

		local Func = select( k+1, ... ) or function() end

		local Button = vgui.Create( "DButton", ButtonPanel )
		Button:SetText( Text )
		Button:SetTextColor(color_white)
		Button:SizeToContents()
		Button:SetTall( 20 )
		Button:SetWide( Button:GetWide() + 20 )
		Button.DoClick = function() Window:Close() Func() end
		Button:SetPos( x, 5 )

		x = x + Button:GetWide() + 5

		ButtonPanel:SetWide( x )
		NumOptions = NumOptions + 1

	end

	local w, h = Text:GetSize()

	w = math.max( w, ButtonPanel:GetWide() )

	Window:SetSize( w + 50, h + 25 + 45 + 10 )
	Window:Center()

	InnerPanel:StretchToParent( 5, 25, 5, 45 )

	Text:StretchToParent( 5, 5, 5, 5 )

	ButtonPanel:CenterHorizontal()
	ButtonPanel:AlignBottom( 8 )

	Window:MakePopup()
	Window:DoModal()

	if ( NumOptions == 0 ) then

		Window:Close()
		Error( "Derma_Query: Created Query with no Options!?" )
		return nil

	end

	return Window

end


function OpenRoundTimer(roundtime)
local ShowTimer = true
local TimerValue = roundtime

timer.Create("TimerCountDownLol", 1, roundtime, function()
if TimerValue >= 0 then
TimerValue = TimerValue - 1
end
end)

hook.Add( "HUDPaint", "TimerCountDown", function()
if ShowTimer == true then
	draw.DrawText("Round is starting in "..TimerValue, "TargetID", ScrW() * 0.5, ScrH() * 0.25, Color(255,255,255,255), TEXT_ALIGN_CENTER)
end
end )

timer.Simple(roundtime, function()

ShowTimer = false
end)



end




function InformationCard(role)

local frame = vgui.Create( "DFrame" )
frame:SetTitle("")
frame:SetSize( ScrW() * 0.45, ScrH() * 0.6 )
frame:Center()
frame:MakePopup()

 		local mat = vgui.Create("Material", frame)
		--mat:SetSize(ScrW()/11 * 1.016930022573363 , ScrW()/11 )
		mat:SetSize(ScrW()*600/1360, ScrH()*400/768    )
		mat:SetMaterial("!" .. CombineInfo:GetName());
		mat:Center()
		mat.AutoSize = false



end




function OpenRoundMenu()
if IsValid(Frame) then
Frame:Remove()
end
        local Frame = vgui.Create("DFrame")
		Frame:SetTitle("")
        Frame:MakePopup(true)
        Frame:SetSize(ScrW(), ScrH())
        Frame:Center()
        Frame:SetBackgroundBlur(true)
		Frame:SetDraggable( false )
		if !LocalPlayer():IsAdmin() then
			Frame:ShowCloseButton( false )
		end

 		local mat = vgui.Create("Material", Frame)
		--mat:SetSize(ScrW()/11 * 1.016930022573363 , ScrW()/11 )
		mat:SetSize(ScrW()*580/1360, ScrH()*85/768    )
		mat:SetPos(nil, ScrH()/9.9)
		mat:SetMaterial("!" .. LogoMaterial:GetName());
		mat:CenterHorizontal()
		mat.AutoSize = false
		
		local antag = vgui.Create("DButton", Frame)
		antag:SetPos(ScrW()/1.3, ScrH()/5)
        antag:SetColor(Color(230,149,0) )
        antag:SetText("Antagonist Menu")
        antag:SetFont("ixMenuButtonFont")
        antag:SizeToContents()

        antag.DoClick = function()
		
        local AntagMenu = vgui.Create("DFrame", Frame)
		AntagMenu:SetTitle("")
        AntagMenu:MakePopup(true)
        AntagMenu:SetSize(ScrW()/3 , ScrH()/1.9)
        AntagMenu:Center()
        AntagMenu:SetBackgroundBlur(true)
		AntagMenu:SetDraggable( true  )
		
        local antagframe = vgui.Create("DPanel", AntagMenu)
        antagframe:SetSize(ScrW() / 3.3 , ScrH() / 2.5 )
		antagframe:Center()

        local p_antag = vgui.Create("DPanel", antagframe  )
        p_antag:Dock(FILL )
        p_antag:DockMargin(0, 0, 0, 0)
		p_antag:SetBackgroundColor(Color(0,0,0,0))
		
		
        for k, i in pairs(AntagonistsRoles) do
            local l = vgui.Create("DButton", p_antag)
            l:Dock(TOP)
            l:DockMargin(0, 0, 0, 0) -- shift to the right
            l:SetColor(color_white)

			l:SetText(i[1].." [ON]")
			l:SetToolTip("Currently you cant disable them." )
            l:SetFont("ixMenuButtonFont")
            l:SizeToContents()

            l.DoClick = function()
            --    ClickButton(l, i)
            end
            -- l:SetHelixTooltip(function(tooltip)
                -- local name = tooltip:AddRow("name")
                -- name:SetImportant()
                -- name:SetText(i[1])
                -- name:SizeToContents()
                -- tooltip:SizeToContents()
                -- local description = tooltip:AddRow("description")
                -- description:SetText(i[4])
                -- description:SizeToContents()
            -- end)
        end

        end
			
		
		if LocalPlayer():GetNWBool("DidntGetRole") == false then
		
		local welcome = vgui.Create("DLabel", Frame)
		local TimerValue2 = 61
		timer.Create("TimerCountDownLol", 1, 61, function()
		if TimerValue2 >= 0 then
		TimerValue2 = TimerValue2 - 1
		if IsValid(Frame) == false then return end
        welcome:SetText("Time to pick your role "..TimerValue2)
        welcome:SetFont("ixMenuButtonFont")
        welcome:SetTextColor(Color(255, 255, 255))
        welcome:SizeToContents()
        welcome:SetPos(nil, ScrH()/3.65)
        welcome:CenterHorizontal()
		end
		if TimerValue2 == 0 then
			if IsValid(Frame) then
				Frame:Remove()
				if LocalPlayer():GetNWBool("DontShowAgain") ~= true then

                    net.Start("RoleInformation")
                    net.WriteEntity(LocalPlayer())
                    net.WriteInt(0, 32)
                    net.WriteString("I_DIDNT_PICK")
                    net.SendToServer()

					LocalPlayer():SetNWBool("DidntGetRole", true)
					CheckTableAvailable()
					OpenRoundMenu()
				end

			end
		end
		end)
		else
		local welcome = vgui.Create("DLabel", Frame)
		welcome:SetText("Pick a role that is free")
        welcome:SetFont("ixMenuButtonFont")
        welcome:SetTextColor(Color(255, 255, 255))
        welcome:SizeToContents()
       -- welcome:SetPos(nil, 200)
        welcome:CenterHorizontal()
		end
		

		
        local RoleFrameCitizen = vgui.Create("DPanel", Frame)
        RoleFrameCitizen:DockPadding(15, 0, 15, 0)
        RoleFrameCitizen:SetSize(ScrW() / 3, ScrH() / 2)
        RoleFrameCitizen:SetPos(0, ScrH()/2.5 )
		
        local welcome = vgui.Create("DLabel", Frame)
        welcome:SetText("Citizens")
        welcome:SetFont("ixMenuButtonFont")
        welcome:SetTextColor(Color(0, 255, 0))
        welcome:SizeToContents()
        welcome:SetPos(nil, 250)
        welcome:SetPos(ScrW() * 0.135, RoleFrameCitizen.y - 50)
		
        local RoleFrame = vgui.Create("DPanel", Frame)
        RoleFrame:SetSize(ScrW() / 3, ScrH() / 2)
        RoleFrame:CenterHorizontal()
        RoleFrame:SetPos(RoleFrame.x, ScrH()/2.5 )
		
        local welcome = vgui.Create("DLabel", Frame)
        welcome:SetText("Universial-Union")
        welcome:SetFont("ixMenuButtonFont")
        welcome:SetTextColor(Color(46, 126, 152))
        welcome:SizeToContents()
        welcome:SetPos(nil, RoleFrame.y - 50)
        welcome:CenterHorizontal()
		
        local RoleFrameSpecial = vgui.Create("DPanel", Frame)
        RoleFrameSpecial:DockPadding(15, 0, 15, 0)
        RoleFrameSpecial:SetSize(ScrW() / 3, ScrH() / 2)
        RoleFrameSpecial:CenterHorizontal()
        RoleFrameSpecial:SetPos(RoleFrameSpecial.x * 2, ScrH()/2.5)
		
        local welcome = vgui.Create("DLabel", Frame)
        welcome:SetText("Special")
        welcome:SetFont("ixMenuButtonFont")
        welcome:SetTextColor(Color(255, 255, 0))
        welcome:SizeToContents()
        welcome:SetPos(ScrW() * 0.81, RoleFrameSpecial.y - 50)
		

        function ClickButton(l, i)
            local ply = LocalPlayer()
            local maxam = i[3]
            local role = i[2]

			if i[3] == -2 then return end
            if ply:GetNWBool("HasPicked") ~= true then
			if LocalPlayer():GetNWBool("DidntGetRole") == false then
                Derma_Query2("Do you wish to lock in as " .. i[1].."?", "Confirmation", "Lock In", function()
                    net.Start("RoleInformation")
                    net.WriteEntity(ply)
                    net.WriteInt(maxam, 32)
                    net.WriteString(role)
                    net.SendToServer()
                    l:SetText("Locked in as " .. i[1])
                    l:SetName("Selected")
                    l:SetColor(Color(255, 255, 255, 255))

                    l.Paint = function(self, w, h)
                        draw.RoundedBox(0, 0, 0, w, h, Color(41, 128, 185, 250)) -- Draw a blue button
                    end
					
                end, "Cancel", function() end)
            else
				
                if l:GetName() == "Selected" then return end
                l:SetText("You have already locked in")
                l:SetColor(Color(255, 255, 255, 255))
				end
                l.Paint = function(self, w, h)
                    draw.RoundedBox(0, 0, 0, w, h, Color(255, 0, 0, 250)) -- Draw a blue button
                end
            end
			
			if LocalPlayer():GetNWBool("DidntGetRole") == true then
                Derma_Query2("Do you want to play as " .. i[1].."?", "Confirmation", "Confirm", function()
                    net.Start("RoleInformation")
                    net.WriteEntity(ply)
                    net.WriteInt(maxam, 32)
                    net.WriteString(role)
                    net.SendToServer()
					Frame:Remove()
					
                end, "Cancel", function() end)
			end
        end
		COLOR_TEAM_RED = Color(255, 64, 64, 255)
        local p_citizen = vgui.Create("DPanel", RoleFrameCitizen)
        p_citizen:Dock(FILL)
        p_citizen:DockMargin(0, 0, 0, 0)
		--p_citizen:SetBackgroundColor(COLOR_TEAM_RED)
        local p_combine = vgui.Create("DPanel", RoleFrame)
        p_combine:Dock(FILL)
        p_combine:DockMargin(0, 0, 0, 0)
		p_combine:SetBackgroundColor(Color(0,0,0,0))
        local p_special = vgui.Create("DPanel", RoleFrameSpecial)
        p_special:Dock(FILL)
        p_special:DockMargin(0, 0, 0, 0)
		p_special:SetBackgroundColor(Color(0,0,0,0))

        for k, i in pairs(CombineRoles) do
            local l = vgui.Create("DButton", p_combine)
            l:Dock(TOP)
            l:DockMargin(0, 0, 0, 0) -- shift to the right
            l:SetColor(color_white)
			l:SetText(i[1])
			if i[3] == -2 then
			l:SetText(i[1].." [FULL]")
			l:SetColor(Color(200,0,0))
			end
            l:SetFont("ixMenuButtonFont")
            l:SizeToContents()

            l.DoClick = function()
                ClickButton(l, i)
            end
			l:SetToolTip(i[4])
            -- l:SetHelixTooltip(function(tooltip)
                -- local name = tooltip:AddRow("name")
                -- name:SetImportant()
                -- name:SetText(i[1])
                -- name:SizeToContents()
                -- tooltip:SizeToContents()
                -- local description = tooltip:AddRow("description")
                -- description:SetText(i[4])
                -- description:SizeToContents()
            -- end)
        end

        for k, i in pairs(CitizenRoles, true) do
            local l = vgui.Create("DButton", p_citizen)
            l:Dock(TOP)
            l:DockMargin(0, 0, 0, 0) -- shift to the right
            l:SetColor(color_white)
            l:SetText(i[1])
			if i[3] == -2 then
			l:SetText(i[1].." [FULL]")
			l:SetColor(Color(200,0,0))
			end
            l:SetFont("ixMenuButtonFont")
            l:SizeToContents()

            l.DoClick = function()
                ClickButton(l, i)
            end

			l:SetToolTip(i[4])

            -- l:SetHelixTooltip(function(tooltip)
                -- local name = tooltip:AddRow("name")
                -- name:SetImportant()
                -- name:SetText(i[1])
                -- name:SizeToContents()
                -- tooltip:SizeToContents()
                -- local description = tooltip:AddRow("description")
                -- description:SetText(i[4])
                -- description:SizeToContents()
            -- end)
        end

        for k, i in pairs(SpecialRoles, true) do
            local l = vgui.Create("DButton", p_special)
            l:Dock(TOP)
            l:DockMargin(0, 0, 0, 0) -- shift to the right
            l:SetColor(color_white)
            l:SetText(i[1])
			if i[3] == -2 then
			l:SetText(i[1].." [FULL]")
			l:SetColor(Color(200,0,0))
			end
            l:SetFont("ixMenuButtonFont")
            l:SizeToContents()

            l.DoClick = function()
                ClickButton(l, i )
            end
			l:SetToolTip(i[4])
            -- l:SetHelixTooltip(function(tooltip)
                -- local name = tooltip:AddRow("name")
                -- name:SetImportant()
                -- name:SetText(i[1])
                -- name:SizeToContents()
                -- tooltip:SizeToContents()
                -- local description = tooltip:AddRow("description")
                -- description:SetText(i[4])
                -- description:SizeToContents()
            -- end)
        end
end



end