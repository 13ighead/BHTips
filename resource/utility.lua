local addon_name, global = ...

global.utility.warning = function (localiztion_warning_template, ...) 
	print(string.format(localiztion_warning_template, ...))
end

global.utility.error = function (localiztion_error_template, ...) 
	print("|CFFFF0000" .. string.format(localiztion_error_template, ...) .. "|r")
end

global.utility.class = select(2, UnitClass("player"))
