---@diagnostic disable: undefined-global
-- --------------------------------------------------------------------------
--
-- Implementation of a dark mode library for detecting and setting dark
-- mode in MacOS.
--
-- --------------------------------------------------------------------------
--
-- Example:
--
-- dm = require "darkmode"
-- dm.addHandler(function(dm2) print('darkmode changed:',dm2) end)
-- print('darkmode:',dm.getDarkMode())
--
-- --------------------------------------------------------------------------

-- --------------------------------------------------------------------------
-- internal Data which should not be garbage collected
-- --------------------------------------------------------------------------

local internalData = {
	darkmode = false,
	watcher = nil,
	handler = {}
}

-- --------------------------------------------------------------------------
-- General functions
-- --------------------------------------------------------------------------

local function getDarkModeFromSystem()
	local _, darkmode = hs.osascript.javascript("Application('System Events').appearancePreferences.darkMode.get()")
    return darkmode
end

local function getDarkMode()
	return internalData.darkmode
end

local function addHandler(fn)
	-- add it here...
	internalData.handler[#internalData.handler+1] = fn
end

-- --------------------------------------------------------------------------
-- Internal functions
-- --------------------------------------------------------------------------

local function initialize()
	internalData.darkmode = getDarkModeFromSystem()
end

local function initializeWatcher()
	-- exit if already watching
	if internalData.watcher ~= nil then return end

	internalData.watcher = hs.distributednotifications.new(function(name, object, userInfo)
		local hasDarkMode = getDarkModeFromSystem()
		if hasDarkMode ~= internalData.darkmode then
			internalData.darkmode = hasDarkMode
			-- execute each handler with the darkmode as parameter (may change in future)
			for index, fn in ipairs(internalData.handler) do
				fn(hasDarkMode)
			end
		end
	end,'AppleInterfaceThemeChangedNotification')

	internalData.watcher:start()
end

-- --------------------------------------------------------------------------
-- Initialization
-- --------------------------------------------------------------------------

initialize()
initializeWatcher()

local module = {
	_ = internalData,
	getDarkMode = getDarkMode,
	addHandler = addHandler
}

return module
