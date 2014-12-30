local addon_name, global = ...
local localize = global.localize
local util = global.utility

if not global.isEnabled then
	util.warning(localize.addon_initialization_is_failed)
	return
end

local Widget = {}

local Widget_List = {}

local Widget_Category = {
	["Health"] = Health,
	["Resource"] = Resource,
	["Cooldown"] = Cooldown,
}

function Widget:New(name, category, settings)
	if not Widget_Category[category] then return end
	local widget = Widget_Category[category]:New(name, settings)
	if type(Widget_List[category] ~= "table") then
		Widget_List[category] = {}
	end

	table.insert(Widget_List[category], widget)

	widget:Init()
	widget:Enable()
	return widget
end

function Widget:AllShow()
	for _, category in pairs(Widget_List) do
		local c = category
		for _, widget in pairs(c) do
			widget:Show()
		end
	end
end

function Widget:AllHide()
	for _, category in pairs(Widget_List) do
		local c = category
		for _, widget in pairs(c) do
			widget:Hide()
		end
	end
end

function Widget:ShowAllCategoryList()
	for category_name, _ in pairs(Widget_List) do
		util.warning(category_name)
	end
end

function Widget:ShowWidgetListInOneCategory(category_name)
	local category = Widget_List[category_name]
	if not category or type(category) ~= "table" then return end
	for _, widget in pairs(category) do
		util.warning(widget.name)
	end
end

global.Widget = Widget
