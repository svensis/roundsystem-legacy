local Clockwork = Clockwork;
local pairs = pairs;
local vgui = vgui;
local math = math;

local PANEL = {};

-- Called when the panel is initialized.
function PANEL:Init()
	self:SetSize(Clockwork.menu:GetWidth(), Clockwork.menu:GetHeight());

        local antagframe = vgui.Create("DPanel", self)
        antagframe:SetSize(Clockwork.menu:GetWidth()/1.1 , Clockwork.menu:GetHeight()/1.1)
		antagframe:Center()
		antagframe.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
			draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 255 ) ) -- Draw a red box instead of the frame
		end
 

        local objectivelist = vgui.Create("DPanel", antagframe)
        objectivelist:SetSize(antagframe:GetWide()/1.1, antagframe:GetTall()/1.2)
		objectivelist:Center()
		objectivelist.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
			draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 255 ) ) -- Draw a red box instead of the frame
		end

        local p_combine = vgui.Create("DPanel", objectivelist)
        p_combine:Dock(FILL)
        p_combine:DockMargin(0, 0, 0, 0)
		p_combine:SetBackgroundColor(Color(0,0,0,0))
	
        for k, i in pairs(CombineRoles) do
            local l = vgui.Create("DLabel", p_combine)
            l:Dock(TOP)
            l:DockMargin(0, 0, 0, 0) -- shift to the right
            l:SetColor(Color(0,0,0))
			l:SetText(i[1])
            l:SetFont("ixMenuButtonFontThick")
            l:SizeToContents()
        end


	self:Rebuild();
end;

-- A function to rebuild the panel.
function PANEL:Rebuild()
self:SetSize(Clockwork.menu:GetWidth(), Clockwork.menu:GetHeight());



end;

-- A function to get whether the button is visible.


-- Called when the panel is selected.
function PANEL:OnSelected() self:Rebuild(); end;

-- Called when the layout should be performed.
function PANEL:PerformLayout(w, h)
	self:SetSize(w, ScrH() * 0.75);
	draw.RoundedBox( 0, 0, 0, w, h, Color( 231, 76, 60, 255 ) )
end;

-- Called when the panel is painted.
function PANEL:Paint(w, h)
	derma.SkinHook("Paint", "Frame", self, w, h);
	
	return true;
end;

-- Called each frame.
function PANEL:Think()
	self:InvalidateLayout(true);
end;


vgui.Register("cwObjectives", PANEL, "EditablePanel");