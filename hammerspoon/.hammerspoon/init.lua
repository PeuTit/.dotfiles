hs.loadSpoon("fnMate")
spoon.fnMate:init()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.notify.new({title="Config loaded"}):send()
