WIM_CHANGE_LOG = [[
Version 1.5.10 (03-07-2007)|cffffffff
[*] - Revised event handler. Should correct whisper catching issue.
[*] - Now validates window data before creating. Prevents errors.
[*] - Fixed Ace/WIM compatibilty issue with linking items.

|rVersion 1.5.6 (03-06-2007)|cffffffff
[*] - Linking stackable items will no longer show split dialogue.
[+] - Added "Add Friend" shortcut to shortcut bar. (Only if not a friend).
[+] - Added an icon to the shortcut bar where you can see the users location.
[*] - Defined filters to catch GuildAds, Ace, CT and Metamap messages.
[+] - Added option to select different time stamp formats.
[+] - Added interface for SpamSentry.
[*] - Recoded event hooks by using ChatFrame_MessageEventHandler.
[*] - Modified filter checking to use less resources.
[+] - Added options to auto close idle messages (friends and non-friends).
[+] - Added "(Show All)" to user list in history viewer.
[+] - Added ability to export history. (raw text & html).
[+] - Added flood control. (10 second cool down on duplicate messages).
[+] - Right-Clicking minimap icon now shows "WIM Tools" menu.
[+] - Added option to turn off "WIM Tools" menu from minimap.
[*] - LootLink (Standard) now works with WIM.
[+] - WIM is now functional with AdvancedTradeSkillWindow.
[+] - Added option to ignore arrow keys while typing messages.

|rVersion 1.4.66 (01-09-2007)|cffffffff
[*] - Updated to work with 2.0.3 patch.

|rVersion 1.4.58 (12-30-2006)|cffffffff
[*] - Fixed error when showing all and hiding all message windows.
[*] - Fixed error with linking from auction house.
[*] - Updated Korean translations.
[+] - 'Enter' with no message to be sent will now drop focus.
[*] - Fixed problem with whispering users with special characters.
[*] - Modified slash command handler as suggested by 'egingell'.
[+] - Updated default filters to include GuildAds 2.0.
[+] - On version upgrades, default filters are automatically reloaded.

|rVersion 1.4.50 (12-08-2006)|cffffffff
[!] - WIM is now updated to work with WoW 2.0 Interface.
[-] - Removed incompatible buttons from shortcut bar. Ideas for new ones?
[*] - Hooking structure revamped due to new blizz function ChatEdit_InsertLink().

|rVersion 1.4.16 (11-14-2006)|cffffffff
[+] - Added Traditional Chinese Translations (Thanks Junxian).
[+] - Added new option interface for "Show Shortcutbar"
[+] - You can now choose which buttons to show on shortcut bar.
[+] - Added options for FuBar plugin.
[*] - FuBar plugin should now retain settings.
[*] - Users are now case insensitive, preventing mulitple windows per user.
[*] - Intercepting /whisper commands now follows popup combat rules.
[*] - Corrected issue where outbound popups still popped while in combat.
[*] - Corrected possible bug preventing linking to party/guild/raid chat.

|rVersion 1.4.5 (10-31-2006)|cffffffff
[*] - FuBar plugin fix. (Added SetFontSize() method).

|rVersion 1.4.4 (10-31-2006)|cffffffff
[+] - Added German Translations (Thanks Corrilian).
[*] - Made changes to the way FuBar2 Plugin loads (Hopefully a fix).
[*] - Fixed bug that caused error message when linking from ItemSync.
[*] - Fixed bug that caused EngInventory to open split when linking.
[+] - Added Spanish Translations (Thanks AlbertQ).
[+] - Added Simplified Chinese Translations (Thanks Annie).
[+] - Added French Translations (Thanks Khellendros).
[*] - Removed some depricated minimap menu code. (Thanks Soin).
[*] - Attempt to correct issue with Polish and Russian fonts.
[*] - Tweaked chat fonts to be as backward compatible as possible.
[*] - Reworked SuperInspect, compatibilty. Corrected linking issues.

|rVersion 1.4.3 (10-24-2006)|cffffffff
[+] - All english text can now be localized!
[*] - All WIM strings now use system font declarations. (For localizing).
[+] - Added some problematic addons to Optional Dependency List. (Fix?).
[-] - Removed some depricated code and objects from Titan plugin.
[*] - Fixed bug where slash commands were intercepted when WIM was disabled.
[*] - Changed intercept option position to be more intuitive.
[+] - You can now link items from the vendor window.
[+] - You can now link quests from your quest log.
[+] - You can now link quest items from a quest giver.
[+] - You can now link quest rewards from your quest log.
[+] - You can now link items from the auction house.
[+] - Added FuBar 2.0 Plugin support.
[+] - Added Korean Translations (Thanks Bitz).
[+] - Added support for ItemSync.

|rVersion 1.3.1 (10-17-2006)|cffffffff
[+] - Created new minimap icon menu. No longer using Blizzards Drop Down Menu.
[+] - You can now close conversations from the minimap icon menu.
[*] - Made required code changes for titan plugin and new minimap icon menu.
[*] - Who window no longer pops up when speaking with GM or offline user.
[+] - WIM replaces "Send Message" button in the Friends Frame.
[+] - Now interecepts /w and /whisper commands and opens a message window.
[+] - Added option to enable/disable whisper slash command intercepting.
[+] - Added support for LootLink.
[+] - Added support for EngInventory.
[+] - You can now execute slash commands inside a message window.
]]




--[[
Things to Do:



]]