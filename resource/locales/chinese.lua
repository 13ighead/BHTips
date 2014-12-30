local addon_name, Global = ...
local localize = Global.localize

if GetLocale() == "zhCN" then
	localize.read_me 		= addon_name .. " 是一款用于监视物品，buff，debuff等状态的插件~~"
	localize.how_to_config 	= "请使用%s config	设置" .. addon_name
	localize.how_to_show 	= "请使用%s show		显示界面"
	localize.how_to_hide 	= "请使用%s hide		隐藏界面"

	localize.addon_initialization_is_failed = addon_name .. "初始化失败"

	localize.category_is_not_found = "监控类别 %s 没有定义"
	localize.event_handle_is_not_found = "在监控类别%s的%s中没有找到事件%s相应的处理方法"
	localize.widget_need_function = "在监控类别%s的%s中缺少%s方法"
end