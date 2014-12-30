local addon_name, global = ...

local localize = global.localize
local util = global.utility

if not global.isEnabled then
	util.warning(localize.addon_initialization_is_failed)
end

global.config = {}

