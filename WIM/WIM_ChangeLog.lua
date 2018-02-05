WIM_CHANGE_LOG = [[
Version 2.0.9 (03-20-2007)|cffffffff
[!] - Initial 2.x Series Release!
[*] - Updated class color for Shamans.
[*] - Cleaned the Bindings.xml as per Drizzd's suggestion.
[*] - Updated FuBar plugin code as per Rhidon's suggestion.
[*] - Filters are no longer cleared between updates.
[+] - Added Tabbed Window Mode - built WIM tab engine.
[*] - Reorganized Template XML. (Requires Restart).
[*] - WIM_Options is now a LoD Addon. (Reduces ~1mb memory).
[+] - Added update detection for newer versions of WIM.
[+] - Added function WIM_API_InsertText.
[*] - WIM is now independent of chat frame msg events.
[*] - Corrected issue with duplicate messages.
[*] - Linking from AtlasLoot no longer causes disconnect.
[+] - Tabbed Mode: <Tab> & <Shift Tab> scroll through tabs.

|rVersion 1.5.10 (03-07-2007)|cffffffff
[*] - Revised event handler. Should correct whisper catching issue.
[*] - Now validates window data before creating. Prevents errors.
[*] - Fixed Ace/WIM compatibilty issue with linking items.
]]




--[[
Things to Do:

/script WIM_SendAddonMessage("VERSION_CHECK#2.0.99");


]]