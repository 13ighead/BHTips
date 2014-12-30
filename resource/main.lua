local addon_name, global = ...

local localize = global.localize
local util = global.utility

if not global.isEnabled then
	util.warning(localize.addon_initialization_is_failed)
end

-- local mainFrame = CreateFrame("Frame", addon_name .. "_MainFrame", UIParent)
-- mainFrame:SetAllPoints(UIParent)
-- RegisterStateDriver(mainFrame, "visibility", "[petbattle] hide; show")

-- global.mainFrame = mainFrame
-- mainFrame:SetPoint("CENTER", UIParent)
-- mainFrame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
--                                             edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
--                                             tile = true, tileSize = 16, edgeSize = 16, 
--                                             insets = { left = 4, right = 4, top = 4, bottom = 4 }})
-- mainFrame:SetBackdropColor(1,0,0,1)
-- mainFrame:SetMovable(true)
-- mainFrame:EnableMouse(true)
-- mainFrame:SetSize(400,300)
-- mainFrame:Show()
-- mainFrame:RegisterForDrag("LeftButton")
-- mainFrame:SetScript("OnDragStart", mainFrame.StartMoving)
-- mainFrame:SetScript("OnDragStop", mainFrame.StopMovingOrSizing)

local h = global.Widget:New("test_health", "Health")
local r = global.Widget:New("test_resource", "Resource")
local c = global.Widget:New("test_cooldown", "Cooldown", {
	["spellName"] = "真气波",
	})

-- name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId 
-- = UnitAura("unit", index or "name"[, "rank"[, "filter"]])
-- print(UnitAura("PLAYER","疾风步"))