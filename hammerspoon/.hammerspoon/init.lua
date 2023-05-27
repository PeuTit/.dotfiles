---@diagnostic disable: undefined-global
local darkmode = require("darkmode")

-- --------------------------------------------------------------------------
-- System notification function
-- --------------------------------------------------------------------------

local function sendSystemNotification(isDarkModeEnabled)
    local modeText = isDarkModeEnabled and "Dark Mode" or "Light Mode"
    local title = "System Theme Changed"
    local informativeText = "The system theme has been changed to " .. modeText

    hs.notify.new({
        title = title,
        informativeText = informativeText
    }):send()
end

darkmode.addHandler(sendSystemNotification)

--[[ -- Function to trigger the theme change in Wezterm
local function changeWeztermTheme(theme)
    local command = string.format("weztermctl set-color-scheme %s", theme)
    hs.execute(command)
end

-- Example usage: change the Wezterm theme to "light"
changeWeztermTheme("light")
]]

hs.loadSpoon("fnMate")
spoon.fnMate:init()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.notify.new({title="Config loaded"}):send()
