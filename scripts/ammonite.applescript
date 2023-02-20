#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Ammonite
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 💻
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Open Ammonite REPL in new terminal window
# @raycast.author PeuTit
# @raycast.authorURL https://github.com/peutit/

log "Hello World!"
tell application "Terminal"
	activate
	do script "amm"
end tell
