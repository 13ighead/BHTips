local addon_name, global = ...

local localize = global.localize
local util = global.utility
local UI = global.UI

if not global.isEnabled then
	util.warning(localize.addon_initialization_is_failed)
end

Cooldown = {}
setmetatable(Cooldown, Widget_Abstract)
Cooldown.__index = Cooldown

function Cooldown:New(name, settings)
	local health = {}
	health = Widget_Abstract:New(name, "Cooldown", settings)
	setmetatable(health, Cooldown)
	return health
end

local function eventHandle(self, event, ...)
	self:RegisterUpdate(Cooldown.Update)
end

function Cooldown:Init()
	if not self.settings.spellID and not self.settings.spellName then
		print("需要id or name")
		return
	end
	self.settings.unit = self.settings.unit or "player"
	self.settings.color = self.settings.color or UI.getClassColor()
	self.settings.spellName = self.settings.spellName or GetSpellInfo(self.settings.spellID)
	self.settings.spellID = self.settings.spellID or select(11, UnitAura(self.settings.unit, self.settings.spellName))
	self:RenderUI()
end

function Cooldown:Enable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", eventHandle)
	self:RegisterEvent("PLAYER_REGEN_DISABLED", eventHandle)
	self:RegisterEvent("PLAYER_REGEN_ENABLED", eventHandle)
	self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", eventHandle, "player")
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN", eventHandle)
end


function Cooldown:RenderUI()
	local bar = self.bar
	local barText = self.barText
	local nameText = self.nameText
	if not bar then
		local start, duration, enabled = GetSpellCooldown(self.settings.spellName)
		bar = CreateFrame("StatusBar", self.name, self.frame)

		bar:SetPoint("CENTER", self.frame)
		bar:SetSize(100,10)
		bar:SetStatusBarTexture([[Interface\AddOns\ClassMonitor\medias\textures\normTex]])
		bar:SetMinMaxValues(0, 1)
		bar:SetStatusBarColor(0,1,0)

		self.bar = bar
	end
	if not barText then
		barText = UI.setFontString(self.bar, 24)
		barText:SetPoint("CENTER", self.bar)
		print(self.settings.spellName)
		barText:SetText("呵呵")
		self.barText = barText
	end

	if not nameText then
		nameText = UI.setFontString(self.bar, 24)
		nameText:SetPoint("LEFT", self.bar, "RIGHT")
		nameText:SetText(self.settings.spellName)
		self.nameText = nameText
	end	

	self.frame:SetSize(110,20)
end

function Cooldown:Update(time)
	local bar = self.bar
	local start, duration, enabled = GetSpellCooldown(self.settings.spellName)
	if start > 0 and duration > 1.5 then
		local time = start + duration - GetTime()
		bar:SetMinMaxValues(0, duration)
		bar:SetValue(time)
		self.barText:SetText(string.format("%.1fs",time))
	else
		self.barText:SetText()
		bar:SetValue(select(2, bar:GetMinMaxValues()))
	end
end

function Cooldown:Hide()
	self.frame:Hide()
end

function Cooldown:Show()
	self.frame:Show()
end

	
