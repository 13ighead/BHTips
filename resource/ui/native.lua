local addon_name, global = ...
local UI = global.UI
local utility = global.utility

local ufFont = [=[Interface\Addons\ClassMonitor\medias\fonts\uf_font.ttf]=]

UI.setFontString = function(parent, fontHeight)
	local fontString = parent:CreateFontString(nil, "OVERLAY")
	fontString:SetFont(ufFont, fontHeight)
	fontString:SetJustifyH("LEFT")
	fontString:SetShadowColor(0, 0, 0)
	fontString:SetShadowOffset(1.25, -1.25)
	return fontString
end

UI.getClassColor = function(className)
	local class = className or utility.class
	return RAID_CLASS_COLORS[class]
end
-- Blah Blah