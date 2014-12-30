local addon_name, global = ...

local localize = global.localize
local util = global.utility
local UI = global.UI

if not global.isEnabled then
	util.warning(localize.addon_initialization_is_failed)
end

Health = {}
setmetatable(Health, Widget_Abstract)
Health.__index = Health

function Health:New(name, settings)
	local health = {}
	health = Widget_Abstract:New(name, "Health")
	setmetatable(health, Health)
	return health
end

local function eventHandle(self, event, ...)
	self:RegisterUpdate(Health.Update)
end

function Health:Init()
	self.settings.unit = "player"
	self:RenderUI()
end

function Health:Enable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", eventHandle)
	self:RegisterEvent("PLAYER_REGEN_DISABLED", eventHandle)
	self:RegisterEvent("PLAYER_REGEN_ENABLED", eventHandle)
	self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", eventHandle, "player")
	self:RegisterEvent("UNIT_POWER", eventHandle, "player")
end


function Health:RenderUI()
	local bar = self.bar
	local text = self.text
	if not bar then
		bar = CreateFrame("StatusBar", self.name, self.frame)
		
		bar:SetMinMaxValues(0, UnitHealthMax(self.settings.unit))
		bar:SetPoint("CENTER", self.frame)
		bar:SetSize(100,10)
		bar:SetStatusBarTexture([[Interface\AddOns\ClassMonitor\medias\textures\normTex]])
		bar:SetStatusBarColor(0,1,0)
		self.bar = bar
	end
	if not text then
		text = UI.setFontString(self.bar, 24)
		text:SetPoint("CENTER", self.bar)
		self.text = text
	end
	self.frame:SetSize(110,20)
end

function Health:Update(time)
	local bar = self.bar
	local maxValue = UnitHealthMax(self.settings.unit)
	local currentValue = UnitHealth(self.settings.unit)
	bar:SetMinMaxValues(0, UnitHealthMax(self.settings.unit))
	bar:SetValue(currentValue)
	self.text:SetText(currentValue.." - ".. maxValue)
end

function Health:Hide()
	self.frame:Hide()
end

function Health:Show()
	self.frame:Show()
end

	
