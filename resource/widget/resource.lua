local addon_name, global = ...

local localize = global.localize
local util = global.utility
local UI = global.UI

if not global.isEnabled then
	util.warning(localize.addon_initialization_is_failed)
end

Resource = {}
setmetatable(Resource, Widget_Abstract)
Resource.__index = Resource

function Resource:New(name, settings)
	local resource = {}
	resource = Widget_Abstract:New(name, "Resource")
	setmetatable(resource, Resource)
	return resource
end

local function eventHandle(self, event, ...)
	print(event)
	self:RegisterUpdate(Resource.Update)
end

function Resource:Init()
	self.settings.unit = "player"
	self:RenderUI()
end

function Resource:Enable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", eventHandle)
	self:RegisterEvent("PLAYER_REGEN_DISABLED", eventHandle)
	self:RegisterEvent("PLAYER_REGEN_ENABLED", eventHandle)
	self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", eventHandle, "player")
	self:RegisterEvent("UNIT_POWER", eventHandle, "player")
end


function Resource:RenderUI()
	local bar = self.bar
	local text = self.text
	if not bar then
		bar = CreateFrame("StatusBar", self.name, self.frame)
		
		bar:SetMinMaxValues(0, UnitPowerMax(self.settings.unit))
		bar:SetPoint("CENTER", self.frame)
		bar:SetSize(100,10)
		bar:SetStatusBarTexture([[Interface\AddOns\ClassMonitor\medias\textures\normTex]])
		bar:SetStatusBarColor(1,1,0)
		self.bar = bar
	end
	if not text then
		text = UI.setFontString(self.bar, 24)
		text:SetPoint("CENTER", self.bar)
		self.text = text
	end
	self.frame:SetSize(110,20)
end

function Resource:Update(time)
	local bar = self.bar
	local maxValue = UnitPowerMax(self.settings.unit)
	local currentValue = UnitPower(self.settings.unit)
	bar:SetMinMaxValues(0, UnitPowerMax(self.settings.unit))
	bar:SetValue(currentValue)
	self.text:SetText(currentValue.." - ".. maxValue)
end

function Resource:Hide()
	self.frame:Hide()
end

function Resource:Show()
	self.frame:Show()
end	
