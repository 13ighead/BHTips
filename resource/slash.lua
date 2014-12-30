local addon_name, global = ...

local localize = global.localize
local util = global.utility

SLASH_BHTIPS1 = "/bh"

local function showHelp()
	util.warning(localize.read_me)
	util.warning(localize.how_to_config, SLASH_BHTIPS1)
	util.warning(localize.how_to_show, SLASH_BHTIPS1)
	util.warning(localize.how_to_hide, SLASH_BHTIPS1)
end

local function configAddon(args)
	print(args)
end

local function show(args)
	global.Widget:AllShow()
end

local function hide(args)
	global.Widget:AllHide()
end

local function showCategory(args)
	if not args then
		global.Widget:ShowAllCategoryList()
	else
		global.Widget:ShowWidgetListInOneCategory(args)
	end
end

local slashSwitch = {
	["config"] = configAddon,
	["show"] = show,
	["hide"] = hide,
	["showcategory"] = showCategory,
}

SlashCmdList[string.upper(addon_name)] = function(cmd)
	local switch = cmd:match("([^ ]+)")
	local args = cmd:match("[^ ]+ (.+)")
	if not switch or not slashSwitch[switch] then
		showHelp()
		return
	end

	slashSwitch[switch](args)

end
