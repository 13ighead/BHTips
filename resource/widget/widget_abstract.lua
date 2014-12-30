local addon_name, global = ...

local localize = global.localize
local util = global.utility

if not global.isEnabled then
	util.warning(localize.addon_initialization_is_failed)
	return
end

Widget_Abstract = {}
Widget_Abstract.__index = Widget_Abstract

local function test(rootFrame)
	rootFrame:SetPoint("CENTER", UIParent)
	rootFrame:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
		tile = true,
		tileSize = 16,
		edgeSize = 16, 
		insets = {
			left = 4,
			right = 4,
			top = 4,
			bottom = 4
		}
	})
	rootFrame:SetBackdropColor(0,0,0,1)
	rootFrame:SetMovable(true)
	rootFrame:EnableMouse(true)
	rootFrame:SetSize(200,100)
	rootFrame:Show()
	rootFrame:RegisterForDrag("LeftButton")
	rootFrame:SetScript("OnDragStart", rootFrame.StartMoving)
	rootFrame:SetScript("OnDragStop", rootFrame.StopMovingOrSizing)
end

-- 插件抽象类
function Widget_Abstract:New(name, category, settings)
	local widget = {}
	setmetatable(widget, Widget_Abstract)
	
	widget.frame = CreateFrame("Frame")
	widget.name = name or "NoName"
	widget.settings = settings or {}
	widget.category = category
	widget.frame.parent = widget
	widget.eventHandle = {}

	test(widget.frame)
	return widget
end

-- 事件触发路由
function Widget_Abstract:OnEvent(event, ...)
	local self = self.parent
	if not self.eventHandle[event] then
		util.warning(localize.event_handle_is_not_found, self.category, self.name, event)
		return
	end

	self.eventHandle[event](self, event, ...)
end

-- 轮询事件路由
function Widget_Abstract:OnUpdate(time, ...)
	local self = self.parent
	if not self.eventHandle["OnUpdate"] then
		util.warning(localize.event_handle_is_not_found, self.category, self.name, event)
	end

	self.eventHandle["OnUpdate"](self, time)
end

-- 注册事件
function Widget_Abstract:RegisterEvent(event, func)
	self.frame:RegisterEvent(event)
	self.eventHandle[event] = func
	self.frame:SetScript("OnEvent", self.OnEvent)
end

-- 注册单位事件
function Widget_Abstract:RegisterUnitEvent(event, unit, func)
	self.frame:RegisterUnitEvent(event, unit)
	self.eventHandle[event] = func
	self.frame:SetScript("OnEvent", self.OnEvent)
end

-- 注销事件
function Widget_Abstract:UnregisterEvent(event)
	self.frame:UnregisterEvent(event)
	self.eventHandle[event] = nil
end

-- 注销所有事件
function Widget_Abstract:UnregisterAllEvents()
	self.frame:UnregisterAllEvents()
	self.eventHandle = {}
	self.frame:SetScript("OnEvent", nil)
end

-- 注册轮询事件
function Widget_Abstract:RegisterUpdate(func)
	self.eventHandle["OnUpdate"] = func
	self.frame:SetScript("OnUpdate", self.OnUpdate)
end

-- 注销轮询事件
function Widget_Abstract:UnregisterUpdate()
	self.frame:SetScript("OnUpdate", nil)
	self.eventHandle["OnUpdate"] = nil
end

---------------------------------------------

-- 初始化
function Widget_Abstract:Init()
	util.warning(localize.widget_need_function, self.category, self.name, "Init")
end

-- 激活
function Widget_Abstract:Enable()
	util.warning(localize.widget_need_function, self.category, self.name, "Enable")
end

-- 冻结
function Widget_Abstract:Disable()
	util.warning(localize.widget_need_function, self.category, self.name, "Disable")
end

-- 显示
function Widget_Abstract:Show()
	util.warning(localize.widget_need_function, self.category, self.name, "Show")
end

-- 隐藏
function Widget_Abstract:Hide()
	util.warning(localize.widget_need_function, self.category, self.name, "Hide")
end

-- 重载
function Widget_Abstract:Reload()
	util.warning(localize.widget_need_function, self.category, self.name, "Reload")
end


