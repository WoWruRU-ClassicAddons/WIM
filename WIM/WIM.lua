WIM_VERSION = "1.5.10";

WIM_Windows = {};
WIM_EditBoxInFocus = nil;
WIM_NewMessageFlag = false;
WIM_NewMessageCount = 0;
WIM_Icon_TheMenu = nil;
WIM_Icon_UpdateInterval = .5;
WIM_CascadeStep = 0;
WIM_MaxMenuCount = 20;
WIM_ClassIcons = {};
WIM_ClassColors = {};

WIM_SpamCheck_LastMSG = "";

WIM_SHORTCUTBAR_COUNT = 0;

WIM_AlreadyCheckedGuildRoster = false;

WIM_GuildList = {}; --[Not saved between sessions: Autopopulates from GUILD_ROSTER_UPDATE event
WIM_FriendList = {}; --[Not saved between sessions: Autopopulates from FRIENDLIST_SHOW & FRIENDLIST_UPDATE event

WIM_Alias = {};
WIM_Filters = nil;
	
WIM_ToggleWindow_Timer = 0;
WIM_ToggleWindow_Index = 1;

WIM_RecentList = {}; --[Not saved between sessions: Store's list of recent conversations.
	
WIM_History = {};

WIM_TimeStamp_Formats = {
	t01 = "%I:%M",			-- HH:MM (12hr)
	t02 = "%I:%M %p",		-- HH:MM AM/PM (12hr)
	t03 = "%H:%M",			-- HH:MM (24hr)
	t04 = "%I:%M:%S",		-- HH:MM:SS (12hr)
	t05 = "%I:%M:%S %p",	-- HH:MM:SS AM/PM (12hr)
	t06 = "%H:%M:%S"		-- HH:MM:SS (24hr)
};

WIM_TimeOuts = {
	to1 = 300 * 1, -- 5m
	to2 = 300 * 2, -- 10m
	to3 = 300 * 3, -- 15m
	to4 = 300 * 6, -- 30m
	to5 = 300 * 12 -- 60m
};

WIM_Data_DEFAULTS = {
	versionLastLoaded = "",
	showChangeLogOnNewVersion = true,
	enableWIM = true,
	iconPosition=337,
	showMiniMap=true,
	displayColors = {
		wispIn = {r=0.5607843137254902, g=0.03137254901960784, b=0.7607843137254902},
		wispOut = {r=1, g=0.07843137254901961, b=0.9882352941176471},
		sysMsg = {r=1, g=0.6627450980392157, b=0},
		errorMsg = {r=1, g=0, b=0},
		webAddress = {r=0, g=0, b=1},
	},
	fontSize = 12,
	windowSize = 1,
	windowAlpha = .8,
	supressWisps = true,
	keepFocus = false,
	keepFocusRested = false,
	popNew = true,
	popUpdate = true,
	popOnSend = true,
	popCombat = false,
	autoFocus = false,
	playSoundWisp = true,
	showToolTips = true,
	sortAlpha = false,
	winSize = {
		width = 384,
		height = 256
	},
	winLoc = {
		left =242 ,
		top =775
	},
	winCascade = {
		enabled = true,
		direction = "downright"
	},
	miniFreeMoving = {
		enabled = false;
		left = 0,
		top = 0
	},
	characterInfo = {
		show = true,
		classIcon = true,
		details = true,
		classColor = true
	},
	showTimeStamps = true,
	timeStampFormat = "t03",
	showShortcutBar = true,
	showShortcutBarButton = {
		target = true,
		invite = true,
		trade = true,
		inspect = true,
		follow = true,
		duel = true,
		friend = true,
		location = true,
		ignore = true
	},
	enableAlias = true,
	enableFilter = true,
	aliasAsComment = true,
	enableHistory = true,
	historySettings = {
		recordEveryone = false,
		recordFriends = true,
		recordGuild = true,
		colorIn = {
				r=0.4705882352941176,
				g=0.4705882352941176,
				b=0.4705882352941176
		},
		colorOut = {
				r=0.7058823529411764,
				g=0.7058823529411764,
				b=0.7058823529411764
		},
		popWin = {
			enabled = true,
			count = 25
		},
		maxMsg = {
			enabled = true,
			count = 200
		},
		autoDelete = {
			enabled = true,
			days = 7
		}
	},
	showAFK = true,
	useEscape = true,
	hookWispParse = true,
	msgTimeOut = {
		friends = false,
		fTO = "to4",
		other = false,
		oTO = "to3"
	},
	ignoreArrowKeys = true,
	menuOnRightClick = true
};
--[initialize defualt values
WIM_Data = WIM_Data_DEFAULTS;

WIM_CascadeDirection = {
	up = {
		left = 0,
		top = 25
	},
	down = {
		left = 0,
		top = -25
	},
	left = {
		left = -50,
		top = 0
	},
	right = {
		left = 50,
		top = 0
	},
	upleft = {
		left = -50,
		top = 25
	},
	upright = {
		left = 50,
		top = 25
	},
	downleft = {
		left = -50,
		top = -25
	},
	downright = {
		left = 50,
		top = -25
	}
};

WIM_IconItems = { };

function WIM_OnLoad()
	SlashCmdList["WIM"] = WIM_SlashCommand;
	SLASH_WIM1 = "/wim";
end


function WIM_Incoming(event)
	--[Events
	if(event == "VARIABLES_LOADED") then
		if(WIM_Data.enableWIM == nil) then WIM_Data.enableWIM = WIM_Data_DEFAULTS.enableWIM; end;
		if(WIM_Data.versionLastLoaded == nil) then WIM_Data.versionLastLoaded = ""; end;
		if(WIM_Data.showChangeLogOnNewVersion == nil) then WIM_Data.showChangeLogOnNewVersion = WIM_Data_DEFAULTS.showChangeLogOnNewVersion; end;
		if(WIM_Data.displayColors == nil) then WIM_Data.displayColors = WIM_Data_DEFAULTS.displayColors; end;
		if(WIM_Data.displayColors.sysMsg == nil) then WIM_Data.displayColors.sysMsg = WIM_Data_DEFAULTS.displayColors.sysMsg; end;
		if(WIM_Data.displayColors.errorMsg == nil) then WIM_Data.displayColors.errorMsg = WIM_Data_DEFAULTS.displayColors.errorMsg; end;
		if(WIM_Data.fontSize == nil) then WIM_Data.fontSize = WIM_Data_DEFAULTS.fontSize; end;
		if(WIM_Data.windowSize == nil) then WIM_Data.windowSize = WIM_Data_DEFAULTS.windowSize; end;
		if(WIM_Data.windowAlpha == nil) then WIM_Data.windowAlpha = WIM_Data_DEFAULTS.windowAlpha; end;
		if(WIM_Data.supressWisps == nil) then WIM_Data.supressWisps = WIM_Data_DEFAULTS.supressWisps; end;
		if(WIM_Data.keepFocus == nil) then WIM_Data.keepFocus = WIM_Data_DEFAULTS.keepFocus; end;
		if(WIM_Data.keepFocusRested == nil) then WIM_Data.keepFocusRested = WIM_Data_DEFAULTS.keepFocusRested; end;
		if(WIM_Data.popNew == nil) then WIM_Data.popNew = WIM_Data_DEFAULTS.popNew; end;
		if(WIM_Data.popUpdate == nil) then WIM_Data.popNew = WIM_Data_DEFAULTS.popUpdate; end;
		if(WIM_Data.autoFocus == nil) then WIM_Data.autoFocus = WIM_Data_DEFAULTS.autoFocus; end;
		if(WIM_Data.playSoundWisp == nil) then WIM_Data.playSoundWisp = WIM_Data_DEFAULTS.playSoundWisp; end;
		if(WIM_Data.showToolTips == nil) then WIM_Data.showToolTips = WIM_Data_DEFAULTS.showToolTips; end;
		if(WIM_Data.sortAlpha == nil) then WIM_Data.sortAlpha = WIM_Data_DEFAULTS.sortAlpha; end;
		if(WIM_Data.winSize == nil) then WIM_Data.winSize = WIM_Data_DEFAULTS.winSize; end;
		if(WIM_Data.miniFreeMoving == nil) then WIM_Data.miniFreeMoving = WIM_Data_DEFAULTS.miniFreeMoving; end;
		if(WIM_Data.popCombat == nil) then WIM_Data.popCombat = WIM_Data_DEFAULTS.popCombat; end;
		if(WIM_Data.characterInfo == nil) then WIM_Data.characterInfo = WIM_Data_DEFAULTS.characterInfo; end;
		if(WIM_Data.showTimeStamps == nil) then WIM_Data.showTimeStamps = WIM_Data_DEFAULTS.showTimeStamps; end;
		if(WIM_Data.showShortcutBar == nil) then WIM_Data.showShortcutBar = WIM_Data_DEFAULTS.showShortcutBar; end;
		if(WIM_Data.enableAlias == nil) then WIM_Data.enableAlias = WIM_Data_DEFAULTS.enableAlias; end;
		if(WIM_Data.enableFilter == nil) then WIM_Data.enableFilter = WIM_Data_DEFAULTS.enableFilter; end;
		if(WIM_Data.aliasAsComment == nil) then WIM_Data.aliasAsComment = WIM_Data_DEFAULTS.aliasAsComment; end;
		if(WIM_Data.enableHistory == nil) then WIM_Data.enableHistory = WIM_Data_DEFAULTS.enableHistory; end;
		if(WIM_Data.historySettings == nil) then WIM_Data.historySettings = WIM_Data_DEFAULTS.historySettings; end;
		if(WIM_Data.winLoc == nil) then WIM_Data.winLoc = WIM_Data_DEFAULTS.winLoc; end;
		if(WIM_Data.winCascade == nil) then WIM_Data.winCascade = WIM_Data_DEFAULTS.winCascade; end;
		if(WIM_Data.popOnSend == nil) then WIM_Data.popOnSend = WIM_Data_DEFAULTS.popOnSend; end;
		if(WIM_Data.versionLastLoaded == nil) then WIM_Data.versionLastLoaded = WIM_Data_DEFAULTS.versionLastLoaded; end;
		if(WIM_Data.showAFK == nil) then WIM_Data.showAFK = WIM_Data_DEFAULTS.showAFK; end;
		if(WIM_Data.useEscape == nil) then WIM_Data.useEscape = WIM_Data_DEFAULTS.useEscape; end;
		if(WIM_Data.hookWispParse == nil) then WIM_Data.hookWispParse = WIM_Data_DEFAULTS.hookWispParse; end;
		if(WIM_Data.showShortcutBarButton == nil) then WIM_Data.showShortcutBarButton = WIM_Data_DEFAULTS.showShortcutBarButton; end;
		if(WIM_Data.showShortcutBarButton.friend == nil) then WIM_Data.showShortcutBarButton.friend = WIM_Data_DEFAULTS.showShortcutBarButton.friend; end;
		if(WIM_Data.showShortcutBarButton.location == nil) then WIM_Data.showShortcutBarButton.location = WIM_Data_DEFAULTS.showShortcutBarButton.location; end;
		if(WIM_Data.timeStampFormat == nil) then WIM_Data.timeStampFormat = WIM_Data_DEFAULTS.timeStampFormat; end;
		if(WIM_Data.msgTimeOut == nil) then WIM_Data.msgTimeOut = WIM_Data_DEFAULTS.msgTimeOut; end;
		if(WIM_Data.ignoreArrowKeys == nil) then WIM_Data.ignoreArrowKeys = WIM_Data_DEFAULTS.ignoreArrowKeys; end;
		if(WIM_Data.menuOnRightClick == nil) then WIM_Data.menuOnRightClick = WIM_Data_DEFAULTS.menuOnRightClick; end;
		
		if(WIM_Filters == nil) then
			WIM_LoadDefaultFilters();
		end
		
		ShowFriends(); --[update friend list
		if(IsInGuild()) then GuildRoster(); end; --[update guild roster
		
		ItemRefTooltip:SetFrameStrata("TOOLTIP");
		
		WIM_HistoryPurge();
		
		WIM_InitClassProps();
		
		WIM_SetWIM_Enabled(WIM_Data.enableWIM);
		
		-- SuperInspect may load before WIM, check if it has and hook it.
		if(IsAddOnLoaded("SuperInspect_UI")) then
			WIM_HookInspect();
		end
		
		if(WIM_VERSION ~= WIM_Data.versionLastLoaded) then
			WIM_LoadDefaultFilters();
			WIM_Help:Show();
		end
		WIM_Data.versionLastLoaded = WIM_VERSION;
		
		if(WIM_Data.miniFreeMoving.enabled) then
			if(WIM_Data.showMiniMap == false) then
				WIM_IconFrame:Hide();
			else
				WIM_IconFrame:Show();
				WIM_IconFrame:SetFrameStrata("HIGH");
				WIM_IconFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT",WIM_Data.miniFreeMoving.left,WIM_Data.miniFreeMoving.top);
			end
		else
			WIM_Icon_UpdatePosition();
		end
		
	elseif(event == "GUILD_ROSTER_UPDATE") then
		WIM_LoadGuildList();
		WIM_AlreadyCheckedGuildRoster = true;
	elseif(event == "FRIENDLIST_SHOW" or event == "FRIENDLIST_UPDATE") then
		WIM_LoadFriendList();
		WIM_SetAllWindowProps();
	elseif(event == "ADDON_LOADED") then
		WIM_AddonDetectToHook(arg1);
	else
		if(WIM_AlreadyCheckedGuildRoster == false) then
			if(IsInGuild()) then GuildRoster(); end; --[update guild roster
		end
	end
end

function WIM_ChatFrame_MessageEventHandler(event, internalEvent)
	-- if WIM is disabled, don't bother doing anything, let everything work as normal.
	if(internalEvent == nil) then internalEvent = false; end
	if( WIM_Data.enableWIM == false) then
		if( internalEvent == false ) then WIM_ChatFrame_MessageEventHandler_orig(event); end
		return true;
	end
	
	local msg = "";
	local filterResult;
	
	if((event == "CHAT_MSG_AFK" or event == "CHAT_MSG_DND") and WIM_Data.showAFK) then
		local afkType;
		if( event == "CHAT_MSG_AFK" ) then
			afkType = WIM_LOCALIZED_AFK;
		else
			afkType = WIM_LOCALIZED_DND;
		end
		msg = "<"..afkType.."> |Hplayer:"..arg2.."|h"..arg2.."|h: "..arg1;
		WIM_PostMessage(arg2, msg, 3);
		if(WIM_Data.supressWisps) then
			ChatEdit_SetLastTellTarget(ChatFrameEditBox, arg2);
			return false; --[ false to supress from chatframe
		else
			if( internalEvent == false ) then WIM_ChatFrame_MessageEventHandler_orig(event); end
			return true;
		end	
	elseif(event == "CHAT_MSG_WHISPER") then
		filterResult = WIM_FilterResult(arg1, arg2);
		if(filterResult ~= 1 and filterResult ~= 2) then
			msg = "[|Hplayer:"..arg2.."|h"..WIM_GetAlias(arg2, true).."|h]: "..arg1;
			WIM_PostMessage(arg2, msg, 1, arg2, arg1);
		end
		if(WIM_Data.supressWisps) then
			if(filterResult == 1) then
				if( internalEvent == false ) then WIM_ChatFrame_MessageEventHandler_orig(event); end
				return true;
			else
				ChatEdit_SetLastTellTarget(ChatFrameEditBox, arg2);
				return false; --[ false to supress from chatframe
			end
		else
			if(filterResult == 2) then
				return false;
			else
				if( internalEvent == false ) then WIM_ChatFrame_MessageEventHandler_orig(event); end
				return true;
			end
		end
	elseif(event == "CHAT_MSG_WHISPER_INFORM") then
		filterResult = WIM_FilterResult(arg1, UnitName("player"));
		if(filterResult ~= 1 and filterResult ~= 2) then
			msg = "[|Hplayer:"..UnitName("player").."|h"..WIM_GetAlias(UnitName("player"), true).."|h]: "..arg1;
			WIM_PostMessage(arg2, msg, 2, UnitName("player") ,arg1);
		end
		if(WIM_Data.supressWisps) then
			if(filterResult == 1) then
				if( internalEvent == false ) then WIM_ChatFrame_MessageEventHandler_orig(event); end
				return true;
			else
				return false; --[ false to supress from chatframe
			end
		else
			if(filterResult == 2) then
				return false;
			else
				if( internalEvent == false ) then WIM_ChatFrame_MessageEventHandler_orig(event); end
				return true;
			end
		end
	elseif(event == "CHAT_MSG_SYSTEM") then
		local tstart,tfinish = string.find(arg1, "\'(%a+)\'");
		if(tstart ~= nil and tfinish ~= nil) then
			user = string.sub(arg1, tstart+1, tfinish-1);
			user = string.gsub(user, "^%l", string.upper)
			tstart, tfinish = string.find(arg1, "playing");
			if(tstart ~= nil and WIM_Windows[user] ~= nil) then
				-- player not playing, can't whisper
				msg = "|Hplayer:"..user.."|h"..user.."|h is not currently playing!";
				WIM_PostMessage(user, msg, 4);
				if(WIM_Data.supressWisps) then
					return false; --[ false to supress from chatframe
				else
					if( internalEvent == false ) then WIM_ChatFrame_MessageEventHandler_orig(event); end
					return true;
				end
			end
		end
	end
	if( internalEvent == false ) then WIM_ChatFrame_MessageEventHandler_orig(event); end
	return true;
end

function WIM_FormatName(theUser)
	local user = theUser;
	if(user ~= nil) then
		user = string.gsub(user, "[A-Z]", string.lower);
		user = string.gsub(user, "^[a-z]", string.upper);
	end
	return user;
end

function WIM_PostMessage(user, msg, ttype, from, raw_msg)
		--[[
			ttype:
				1 - Wisper from someone
				2 - Wisper sent
				3 - System Message
				4 - Error Message
				5 - Show window... Do nothing else...
		]]--
		
		-- if called without user identified, close.
		if(user == nil) then return; end
		
		-- duplicate message check
		if(msg == nil) then msg = "*NONE*"; end
		if(from == nil) then from = "*NONE*"; end
		local checkString = user..msg..ttype..from;
		if(checkString == WIM_SpamCheck_LastMSG) then return; end
		WIM_SpamCheck_LastMSG = checkString;
		
		user = WIM_FormatName(user);
		
		local f,chatBox;
		local isNew = false;
		if(WIM_Windows[user] == nil) then
			if(getglobal("WIM_msgFrame"..user)) then
				f = getglobal("WIM_msgFrame"..user);
			else
				f = CreateFrame("Frame","WIM_msgFrame"..user,UIParent, "WIM_msgFrameTemplate");
			end
			f.theUser = user;
			WIM_SetWindowProps(f);
			WIM_Windows[user] = {
									frame = "WIM_msgFrame"..user, 
									newMSG = true, 
									is_visible = false, 
									last_msg=time(), 
									waiting_who=false,
									class="",
									level="",
									race="",
									guild="",
									location=WIM_LOCALIZED_UNKNOWN
								};
			getglobal("WIM_msgFrame"..user.."From"):SetText(WIM_GetAlias(user));
			WIM_Icon_AddUser(user);
			isNew = true;
			WIM_SetWindowLocation(f);
			if(WIM_Data.characterInfo.show) then
				if(table.getn(WIM_Split(user, "-")) == 2) then
					WIM_GetBattleWhoInfo(user);
				else
					WIM_SendWho(user); 
				end
			end
			WIM_UpdateCascadeStep();
			WIM_DisplayHistory(user);
			if(WIM_History[user]) then
				getglobal(f:GetName().."HistoryButton"):Show();
			end
		end
		f = getglobal("WIM_msgFrame"..user);
		chatBox = getglobal("WIM_msgFrame"..user.."ScrollingMessageFrame");
		msg = WIM_ConvertURLtoLinks(msg);
		WIM_Windows[user].newMSG = true;
		WIM_Windows[user].last_msg = time();
		if(ttype == 1) then
			WIM_PlaySoundWisp();
			WIM_AddToHistory(user, from, raw_msg, false);
			WIM_RecentListAdd(user);
			chatBox:AddMessage(WIM_getTimeStamp()..msg, WIM_Data.displayColors.wispIn.r, WIM_Data.displayColors.wispIn.g, WIM_Data.displayColors.wispIn.b);
		elseif(ttype == 2) then
			WIM_AddToHistory(user, from, raw_msg, true);
			WIM_RecentListAdd(user);
			chatBox:AddMessage(WIM_getTimeStamp()..msg, WIM_Data.displayColors.wispOut.r, WIM_Data.displayColors.wispOut.g, WIM_Data.displayColors.wispOut.b);
		elseif(ttype == 3) then
			chatBox:AddMessage(msg, WIM_Data.displayColors.sysMsg.r, WIM_Data.displayColors.sysMsg.g, WIM_Data.displayColors.sysMsg.b);
		elseif(ttype == 4) then
			chatBox:AddMessage(msg, WIM_Data.displayColors.errorMsg.r, WIM_Data.displayColors.errorMsg.g, WIM_Data.displayColors.errorMsg.b);
		end
		if( WIM_PopOrNot(isNew) or (ttype==2) or (ttype==5) ) then
			WIM_Windows[user].newMSG = false;
			if(ttype == 2 and WIM_Data.popOnSend == false) then
				--[ do nothing, user prefers not to pop on send
			elseif(ttype == 2 and WIM_Data.popOnSend == true and (WIM_Data.popCombat and UnitAffectingCombat("player"))) then
				--[ do nothing, user is in combat, don't send
			else
				f:Show();
				if(ttype ==5) then
					f:Raise();
					getglobal(f:GetName().."MsgBox"):SetFocus();
				end
			end
		end
		WIM_UpdateScrollBars(chatBox);
		WIM_Icon_DropDown_Update();
		if(WIM_HistoryFrame:IsVisible()) then
			WIM_HistoryViewNameScrollBar_Update();
			WIM_HistoryViewFiltersScrollBar_Update();
		end
end

function WIM_SetWindowLocation(theWin)
	local CascadeOffset_Left = 0;
	local CascadeOffset_Top = 0;

	if(WIM_Data.winCascade.enabled) then
		CascadeOffset_Left = WIM_CascadeDirection[WIM_Data.winCascade.direction].left;
		CascadeOffset_Top = WIM_CascadeDirection[WIM_Data.winCascade.direction].top;
	end
	
	theWin:SetPoint(
		"TOPLEFT",
		"UIParent",
		"BOTTOMLEFT",
		(WIM_Data.winLoc.left + WIM_CascadeStep*CascadeOffset_Left), 
		(WIM_Data.winLoc.top + WIM_CascadeStep*CascadeOffset_Top)
	);
end

function WIM_PopOrNot(isNew)
	if(isNew == true and WIM_Data.popNew == true) then
		if(WIM_Data.popCombat and UnitAffectingCombat("player")) then
			return false;
		else
			return true;
		end
	elseif(WIM_Data.popNew == true and WIM_Data.popUpdate == true) then
		if(WIM_Data.popCombat and UnitAffectingCombat("player")) then
			return false;
		else
			return true;
		end
	else
		return false;
	end
end


function WIM_UpdateScrollBars(smf)
	local parentName = smf:GetParent():GetName();
	if(smf:AtTop()) then
		getglobal(parentName.."ScrollUp"):Disable();
	else
		getglobal(parentName.."ScrollUp"):Enable();
	end
	if(smf:AtBottom()) then
		getglobal(parentName.."ScrollDown"):Disable();
	else
		getglobal(parentName.."ScrollDown"):Enable();
	end
end

function WIM_isLinkURL(link)
	if (strsub(link, 1, 3) == "url") then
		return true;
	else
		return false;
	end
end

function WIM_DisplayURL(link)
	local theLink = "";
	if (string.len(link) > 4) and (string.sub(link,1,4) == "url:") then
		theLink = string.sub(link,5, string.len(link));
	end
	--show UI to show url so it can be copied
	if(theLink) then
		WIM_urlCopyUrlBox:SetText(theLink);
		WIM_urlCopy:Show();
		WIM_urlCopyUrlBox:HighlightText(0);
	end
end

function WIM_ConvertURLtoLinks(text)
	local preLink, midLink, postLink;
	preLink = "|Hurl:";
	midLink = "|h|cff"..WIM_RGBtoHex(WIM_Data.displayColors.webAddress.r, WIM_Data.displayColors.webAddress.g, WIM_Data.displayColors.webAddress.b);
	postLink = "|h|r";
	text = string.gsub(text, "(%a+://[%w_/%.%?%%=~&-]+)", preLink.."%1"..midLink.."%1"..postLink);
	return text;
end

function WIM_SlashCommand(msg)
	if(msg == "reset") then
		WIM_Data = WIM_Data_DEFAULTS;
	elseif(msg == "clear history") then
		WIM_History = {};
	elseif(msg == "reset filters") then
		WIM_LoadDefaultFilters();
	elseif(msg == "history") then
		WIM_HistoryFrame:Show();
	elseif(msg == "help") then
		WIM_Help:Show();
	else
		WIM_Options:Show();
	end
end


function WIM_Icon_Move(toDegree)
	WIM_Data.iconPosition = toDegree;
	WIM_Icon_UpdatePosition();
end

function WIM_Icon_UpdatePosition()
	if(WIM_Data.showMiniMap == false) then
		WIM_IconFrame:Hide();
	else
		if(WIM_Data.miniFreeMoving.enabled == false) then
			WIM_IconFrame:SetPoint(
				"TOPLEFT",
				"Minimap",
				"TOPLEFT",
				54 - (78 * cos(WIM_Data.iconPosition)),
				(78 * sin(WIM_Data.iconPosition)) - 55
			);
		end
		WIM_IconFrame:Show();
	end
end


function WIM_SetWindowProps(theWin)
	if(WIM_Data.showShortcutBar) then
		WIM_LoadShortcutFrame(theWin);
		getglobal(theWin:GetName().."ShortcutFrame"):Show();
		local tHeight = WIM_Data.winSize.height;
		local tMinHeight = WIM_SHORTCUTBAR_COUNT * (28*.75) + 132;
		if(tHeight < tMinHeight and WIM_SHORTCUTBAR_COUNT > 0) then
			tHeight = tMinHeight;
		end
		theWin:SetHeight(tHeight);
	else
		getglobal(theWin:GetName().."ShortcutFrame"):Hide();
		theWin:SetHeight(WIM_Data.winSize.height);
	end
	theWin:SetWidth(WIM_Data.winSize.width);
	theWin:SetScale(WIM_Data.windowSize);
	theWin:SetAlpha(WIM_Data.windowAlpha);
	local Path,_,Flags = getglobal(theWin:GetName().."ScrollingMessageFrame"):GetFont();
	getglobal(theWin:GetName().."ScrollingMessageFrame"):SetFont(Path,WIM_Data.fontSize+2,Flags);
	getglobal(theWin:GetName().."ScrollingMessageFrame"):SetAlpha(1);
	getglobal(theWin:GetName().."MsgBox"):SetAlpha(1);
	getglobal(theWin:GetName().."ShortcutFrame"):SetAlpha(1);
	getglobal(theWin:GetName().."MsgBox"):SetAltArrowKeyMode(WIM_Data.ignoreArrowKeys);
	if(WIM_Data.useEscape) then
		WIM_AddEscapeWindow(theWin);
	else
		WIM_RemoveEscapeWindow(theWin);
	end
	--WIM_SetTabFrameProps();
end


function WIM_AddEscapeWindow(theWin)
	for i=1, table.getn(UISpecialFrames) do 
		if(UISpecialFrames[i] == theWin:GetName()) then
			return;
		end
	end
	tinsert(UISpecialFrames,theWin:GetName());
end

function WIM_RemoveEscapeWindow(theWin)
	for i=1, table.getn(UISpecialFrames) do 
		if(UISpecialFrames[i] == theWin:GetName()) then
			table.remove(UISpecialFrames, i);
			return;
		end
	end
end

function WIM_SetAllWindowProps()
	for key,_ in pairs(WIM_Windows) do
		WIM_SetWindowProps(getglobal(WIM_Windows[key].frame));
	end
end


function WIM_Icon_ToggleDropDown()
	--ToggleDropDownMenu(1, nil, WIM_Icon_DropDown);
	--local tMenu = getglobal("DropDownList"..UIDROPDOWNMENU_MENU_LEVEL);	
	--tMenu:ClearAllPoints();
	--tMenu:SetPoint("TOPRIGHT", "WIM_IconFrameButton", "BOTTOMLEFT", 0, 0);
	--WIM_Icon_DropDown:SetWidth(DropDownList1Button1:GetWidth()+50);
	--DropDownList1:SetScale(UIParent:GetScale());
	if(WIM_ConversationMenu:IsVisible()) then
		WIM_ConversationMenu:Hide();
	else
		WIM_ConversationMenu:ClearAllPoints();
		WIM_ConversationMenu:Show();
		WIM_ConversationMenu:SetPoint("TOPRIGHT", WIM_IconFrame, "BOTTOMLEFT", 5, 5);
	end
end

function WIM_Icon_DropDown_Update()
	
	local tList = { };
	local tListActivity = { };
	local tCount = 0;
	for key,_ in pairs(WIM_IconItems) do
		table.insert(tListActivity, key);
		tCount = tCount + 1;
	end
	
	--[first get a sorted list of users by most frequent activity
	table.sort(tListActivity, WIM_Icon_SortByActivity);
	--[account for only the allowable amount of active users
	for i=1,table.getn(tListActivity) do
		if(i <= WIM_MaxMenuCount) then
			table.insert(tList, tListActivity[i]);
		end
	end
	
	--Initialize Menu
	for i=1,20 do 
		getglobal("WIM_ConversationMenuTellButton"..i.."Close"):Show();
		getglobal("WIM_ConversationMenuTellButton"..i):Enable();
		getglobal("WIM_ConversationMenuTellButton"..i):Hide();
	end
	
	
	WIM_NewMessageCount = 0;
	
	if(tCount == 0) then
		info = { };
		info.justifyH = "LEFT"
		info.text = " - None -";
		info.notClickable = 1;
		info.notCheckable = 1;
		getglobal("WIM_ConversationMenuTellButton1Close"):Hide();
		getglobal("WIM_ConversationMenuTellButton1"):Disable();
		getglobal("WIM_ConversationMenuTellButton1"):SetText("|cffffffff - "..WIM_LOCALIZED_NONE.." -");
		getglobal("WIM_ConversationMenuTellButton1"):Show();
	else
		if(WIM_Data.sortAlpha) then
			table.sort(tList);
		end
		WIM_NewMessageFlag = false;
		for i=1, table.getn(tList) do
			if( WIM_Windows[tList[i]].newMSG and WIM_Windows[tList[i]].is_visible == false) then
				WIM_IconItems[tList[i]].color = "|cff"..WIM_RGBtoHex(77/255, 135/233, 224/255);
				WIM_NewMessageFlag = true;
				WIM_NewMessageCount = WIM_NewMessageCount + 1;
			else
				WIM_IconItems[tList[i]].color = "|cffffffff";
			end
			getglobal("WIM_ConversationMenuTellButton"..i):SetText(WIM_IconItems[tList[i]].color..WIM_GetAlias(WIM_IconItems[tList[i]].text, true));
			getglobal("WIM_ConversationMenuTellButton"..i).theUser = WIM_IconItems[tList[i]].text;
			getglobal("WIM_ConversationMenuTellButton"..i).value = WIM_IconItems[tList[i]].value;
			getglobal("WIM_ConversationMenuTellButton"..i):Show();
		end
	end
	
	--Set Height of Conversation Menu depending on message count
	local ConvoMenuHeight = 60;
	local CMH_Delta = 16 * (table.getn(tList)-1);
	if(CMH_Delta < 0) then CMH_Delta = 0; end
	ConvoMenuHeight = ConvoMenuHeight + CMH_Delta;
	WIM_ConversationMenu:SetHeight(ConvoMenuHeight);
	
	--Minimap icon
	if(WIM_Data.enableWIM == true) then
		if(WIM_NewMessageFlag == true) then
			WIM_IconFrameButton:SetNormalTexture("Interface\\AddOns\\WIM\\Images\\miniEnabled");
		else
			WIM_IconFrameButton:SetNormalTexture("Interface\\AddOns\\WIM\\Images\\miniDisabled");
		end
	else
		--show wim disabled icon
		WIM_IconFrameButton:SetNormalTexture("Interface\\AddOns\\WIM\\Images\\miniOff");
	end
end


function WIM_ConversationMenu_OnUpdate(elapsed)
	if(this.isCounting) then
		this.timeElapsed = this.timeElapsed + elapsed;
		if(this.timeElapsed > 1) then
			this:Hide();
			this.timeElapsed = 0;
			this.isCounting = false;
		end
	end
end

function WIM_Icon_AddUser(theUser)
	local info = { };
	info.text = theUser;
	info.justifyH = "LEFT"
	info.isTitle = nil;
	info.notCheckable = 1;
	info.value = WIM_Windows[theUser].frame;
	info.func = WIM_Icon_PlayerClick;
	WIM_IconItems[theUser] = info;
	table.sort(WIM_IconItems);
	WIM_Icon_DropDown_Update();
end

function WIM_Icon_PlayerClick()
	if(this.value ~= nil) then
		getglobal(this.value):Show();
		--[local user = getglobal(this.value.."From"):GetText();
		local user = getglobal(this.value).theUser;
		WIM_Windows[user].newMSG = false;
		WIM_Windows[user].is_visible = true;
		WIM_Icon_DropDown_Update();
	end
end

function WIM_Icon_OnUpdate(elapsedTime)
	if(WIM_NewMessageFlag == false) then
		this.TimeSinceLastUpdate = 0;
		if(WIM_Icon_NewMessageFlash:IsVisible()) then
			WIM_Icon_NewMessageFlash:Hide();
		end
		return;
	end

	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsedTime; 	

	while (this.TimeSinceLastUpdate > WIM_Icon_UpdateInterval) do
		if(WIM_Icon_NewMessageFlash:IsVisible()) then
			WIM_Icon_NewMessageFlash:Hide();
		else
			WIM_Icon_NewMessageFlash:Show();
		end
		this.TimeSinceLastUpdate = this.TimeSinceLastUpdate - WIM_Icon_UpdateInterval;
	end
end

function WIM_UpdateCascadeStep()
		WIM_CascadeStep = WIM_CascadeStep + 1;
		if(WIM_CascadeStep > 10) then
			WIM_CascadeStep = 0;
		end
end

function WIM_PlaySoundWisp()
	if(WIM_Data.playSoundWisp == true) then
		PlaySoundFile("Interface\\AddOns\\WIM\\Sounds\\wisp.wav");
	end
end

function WIM_Icon_SortByActivity(user1, user2)
	if(WIM_Windows[user1].last_msg > WIM_Windows[user2].last_msg) then
		return true;
	else
		return false;
	end
end

function WIM_RGBtoHex(r,g,b)
	return string.format ("%.2x%.2x%.2x",r*255,g*255,b*255);
end

function WIM_Icon_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	GameTooltip:SetText("WIM v"..WIM_VERSION.."              ");
	GameTooltip:AddDoubleLine("Conversation Menu", "Left-Click", 1,1,1,1,1,1);
	GameTooltip:AddDoubleLine("Show New Messages", "Right-Click", 1,1,1,1,1,1);
	GameTooltip:AddDoubleLine("WIM Options", "/wim", 1,1,1,1,1,1);
end

function WIM_ShowNewMessages()
	for key,_ in pairs(WIM_Windows) do
		if(WIM_Windows[key].newMSG == true) then
			getglobal(WIM_Windows[key].frame):Show();
			WIM_Windows[key].newMSG = false;
		end
	end
	WIM_Icon_DropDown_Update();
end


function WIM_SendWho(name)
	WIM_Windows[name].waiting_who = true;
	SetWhoToUI(1);
	SendWho("\""..name.."\"");
end


function WIM_ShowAll()
	for key in pairs(WIM_Windows) do
		getglobal(WIM_Windows[key].frame):Show();
	end
end

function WIM_HideAll()
	for key in pairs(WIM_Windows) do
		getglobal(WIM_Windows[key].frame):Hide();
	end
end

function WIM_CloseAllConvos()
	for key in pairs(WIM_Windows) do
		WIM_CloseConvo(key);
	end
end

function WIM_CloseConvo(theUser)
	if(WIM_Windows[theUser] == nil) then return; end; --[ fail silently
	
	getglobal(WIM_Windows[theUser].frame):Hide();
	getglobal(WIM_Windows[theUser].frame.."ScrollingMessageFrame"):Clear();
	getglobal(WIM_Windows[theUser].frame.."ClassIcon"):SetTexture("Interface\\AddOns\\WIM\\Images\\classBLANK");
	getglobal(WIM_Windows[theUser].frame.."CharacterDetails"):SetText("");
	WIM_Windows[theUser] = nil;
	WIM_IconItems[theUser] = nil;
	WIM_NewMessageFlag = false;
	WIM_Icon_DropDown_Update();
end

function WIM_InitClassProps()
	WIM_ClassIcons[WIM_LOCALIZED_DRUID] 	= "Interface\\AddOns\\WIM\\Images\\classDRUID";
	WIM_ClassIcons[WIM_LOCALIZED_HUNTER] 	= "Interface\\AddOns\\WIM\\Images\\classHUNTER";
	WIM_ClassIcons[WIM_LOCALIZED_MAGE]	 	= "Interface\\AddOns\\WIM\\Images\\classMAGE";
	WIM_ClassIcons[WIM_LOCALIZED_PALADIN] 	= "Interface\\AddOns\\WIM\\Images\\classPALADIN";
	WIM_ClassIcons[WIM_LOCALIZED_PRIEST] 	= "Interface\\AddOns\\WIM\\Images\\classPRIEST";
	WIM_ClassIcons[WIM_LOCALIZED_ROGUE] 	= "Interface\\AddOns\\WIM\\Images\\classROGUE";
	WIM_ClassIcons[WIM_LOCALIZED_SHAMAN] 	= "Interface\\AddOns\\WIM\\Images\\classSHAMAN";
	WIM_ClassIcons[WIM_LOCALIZED_WARLOCK] 	= "Interface\\AddOns\\WIM\\Images\\classWARLOCK";
	WIM_ClassIcons[WIM_LOCALIZED_WARRIOR] 	= "Interface\\AddOns\\WIM\\Images\\classWARRIOR";
	
	WIM_ClassColors[WIM_LOCALIZED_DRUID]	= "ff7d0a";
	WIM_ClassColors[WIM_LOCALIZED_HUNTER]	= "abd473";
	WIM_ClassColors[WIM_LOCALIZED_MAGE]		= "69ccf0";
	WIM_ClassColors[WIM_LOCALIZED_PALADIN]	= "f58cba";
	WIM_ClassColors[WIM_LOCALIZED_PRIEST]	= "ffffff";
	WIM_ClassColors[WIM_LOCALIZED_ROGUE]	= "fff569";
	WIM_ClassColors[WIM_LOCALIZED_SHAMAN]	= "f58cba";
	WIM_ClassColors[WIM_LOCALIZED_WARLOCK]	= "9482ca";
	WIM_ClassColors[WIM_LOCALIZED_WARRIOR]	= "c79c6e";
end

function WIM_UserWithClassColor(theUser)
	if(WIM_Windows[theUser].class == "") then
		return theUser;
	else
		if(WIM_ClassColors[WIM_Windows[theUser].class]) then
			return "|cff"..WIM_ClassColors[WIM_Windows[theUser].class]..WIM_GetAlias(theUser);
		else
			return WIM_GetAlias(theUser);
		end
	end
end

function WIM_SetWhoInfo(theUser)
	local classIcon = getglobal(WIM_Windows[theUser].frame.."ClassIcon");
	if(WIM_Data.characterInfo.classIcon and WIM_ClassIcons[WIM_Windows[theUser].class]) then
		classIcon:SetTexture(WIM_ClassIcons[WIM_Windows[theUser].class]);
	else
		classIcon:SetTexture("Interface\\AddOns\\WIM\\Images\\classBLANK");
	end
	if(WIM_Data.characterInfo.classColor) then	
		getglobal(WIM_Windows[theUser].frame.."From"):SetText(WIM_UserWithClassColor(theUser));
	end
	if(WIM_Data.characterInfo.details) then	
		local tGuild = "";
		if(WIM_Windows[theUser].guild ~= "") then
			tGuild = "<"..WIM_Windows[theUser].guild.."> ";
		end
		getglobal(WIM_Windows[theUser].frame.."CharacterDetails"):SetText("|cffffffff"..tGuild..WIM_Windows[theUser].level.." "..WIM_Windows[theUser].race.." "..WIM_Windows[theUser].class.."|r");
	end
	WIM_SetWindowProps(getglobal(WIM_Windows[theUser].frame));
end

function WIM_getTimeStamp()
	if(WIM_Data.showTimeStamps) then
		return "|cff"..WIM_RGBtoHex(WIM_Data.displayColors.sysMsg.r, WIM_Data.displayColors.sysMsg.g, WIM_Data.displayColors.sysMsg.b)..date(WIM_TimeStamp_Formats[WIM_Data.timeStampFormat]).."|r ";
	else
		return "";
	end
end

function WIM_Bindings_EnableWIM()
	WIM_SetWIM_Enabled(not WIM_Data.enableWIM);
end

function WIM_SetWIM_Enabled(YesOrNo)
	WIM_Data.enableWIM = YesOrNo
	WIM_Icon_DropDown_Update();
end

function WIM_LoadShortcutFrame(theWin)
	local tButtons = {};

	if(WIM_Data.characterInfo.show and WIM_Data.showShortcutBarButton.location) then
		local theLocation = WIM_LOCALIZED_UNKNOWN;
		if(WIM_Windows[theWin.theUser]) then theLocation = WIM_Windows[theWin.theUser].location; end
		local tmp = {
			--icon = "Interface\\Icons\\INV_Misc_GroupLooking",Ability_Spy
			icon = "Interface\\Icons\\Ability_TownWatch",
			cmd		= "update",
			tooltip = WIM_LOCALIZED_LOCATION..": |cffffffff"..theLocation.."|r\n"..WIM_LOCALIZED_CLICK_TO_UPDATE,
		};
		table.insert(tButtons, tmp);
	end
	
	if(WIM_Data.showShortcutBarButton.invite) then
		local tmp = {
			icon = "Interface\\Icons\\Spell_Holy_BlessingOfStrength",
			cmd		= "invite",
			tooltip = WIM_LOCALIZED_INVITE,
		};
		table.insert(tButtons, tmp);
	end

	if(WIM_Data.showShortcutBarButton.friend and WIM_FriendList[theWin.theUser] == nil and theWin.theUser ~= UnitName("player")) then
		local tmp = {
			icon = "Interface\\Icons\\INV_Misc_GroupNeedMore",
			cmd		= "friend",
			tooltip = WIM_LOCALIZED_FRIEND,
		};
		table.insert(tButtons, tmp);
	end
	
	if(WIM_Data.showShortcutBarButton.ignore) then
		local tmp = {
			icon = "Interface\\Icons\\Ability_Physical_Taunt",
			cmd		= "ignore",
			tooltip = WIM_LOCALIZED_IGNORE,
		};
		table.insert(tButtons, tmp);
	end
	WIM_SHORTCUTBAR_COUNT = 0;
	for i=1,5 do
		if(tButtons[i]) then
			getglobal(theWin:GetName().."ShortcutFrameButton"..i.."Icon"):SetTexture(tButtons[i].icon);
			getglobal(theWin:GetName().."ShortcutFrameButton"..i).cmd = tButtons[i].cmd;
			getglobal(theWin:GetName().."ShortcutFrameButton"..i).tooltip = tButtons[i].tooltip;
			getglobal(theWin:GetName().."ShortcutFrameButton"..i):Show();

			WIM_SHORTCUTBAR_COUNT = WIM_SHORTCUTBAR_COUNT + 1;
		else
			getglobal(theWin:GetName().."ShortcutFrameButton"..i):Hide();
		end
	end
	getglobal(theWin:GetName().."ShortcutFrame"):SetScale(.75);
end

function WIM_TargetByName(theName)
	ChatFrameEditBox:SetText("/tar "..theName);
	ChatEdit_ParseText(ChatFrameEditBox, 0);
end

function WIM_ShorcutButton_Clicked()
	local cmd = this.cmd;
	local theUser = this:GetParent():GetParent().theUser;
	if(cmd == "target") then
		WIM_TargetByName(theUser);
	elseif(cmd == "invite") then
		InviteByName(theUser);
	elseif(cmd == "friend") then
		AddFriend(theUser);
	elseif(cmd == "update") then
		WIM_SendWho(theUser);
		GameTooltip:Hide();
	elseif(cmd == "trade") then
		WIM_TargetByName(theUser);
		InitiateTrade("target");
	elseif(cmd == "inspect") then
		WIM_TargetByName(theUser);
		InspectUnit("target");
	elseif(cmd == "ignore") then
		getglobal(this:GetParent():GetParent():GetName().."IgnoreConfirm"):Show();
	end
end

function WIM_GetAlias(theUser, nameOnly)
	if(WIM_Data.enableAlias and WIM_Alias[theUser] ~= nil) then
		if(WIM_Data.aliasAsComment) then
			if(nameOnly) then
				return theUser;
			else
				return theUser.." |cffffffff- "..WIM_Alias[theUser].."|r";
			end
		else
			return WIM_Alias[theUser];
		end
	else
		return theUser;
	end
end


function WIM_FilterResult(theMSG, theUser)
	-- before we execute WIM's filtering, we want to accomodate SpamSentry.
	if( type(WIM_SpamSentry_IsMsgSpam) == "function" ) then
		if( WIM_SpamSentry_IsMsgSpam(theUser, theMSG) == true ) then
			return 2;
		end
	end

	if(WIM_Data.enableFilter) then
		local key, a, b;
		for key,_ in pairs(WIM_Filters) do
			if(strfind(strlower(theMSG), strlower(key)) ~= nil) then
				if(WIM_Filters[key] == "Ignore") then
					return 1;
				elseif(WIM_Filters[key] == "Block") then
					return 2;
				end
			end
		end
		return 0;
	else
		return 0;
	end
end

function WIM_CanRecordUser(theUser)
	if(WIM_Data.historySettings.recordEveryone) then
		return true;
	else
		if(WIM_Data.historySettings.recordFriends and WIM_FriendList[theUser]) then
			return true;
		elseif(WIM_Data.historySettings.recordGuild and WIM_GuildList[theUser]) then
			return true;
		end
	end
	return false;
end

function WIM_AddToHistory(theUser, userFrom, theMessage, isMsgIn)
	local tmpEntry = {};
	if(WIM_Data.enableHistory) then --[if history is enabled
		if(WIM_CanRecordUser(theUser)) then --[if record user
			getglobal(WIM_Windows[theUser].frame.."HistoryButton"):Show();
			tmpEntry["stamp"] = time();
			tmpEntry["date"] = date("%m/%d/%y");
			tmpEntry["time"] = date("%H:%M"); -- no longer used, but stored for backwards compatibilty
			tmpEntry["msg"] = WIM_ConvertURLtoLinks(theMessage);
			tmpEntry["from"] = userFrom;
			if(isMsgIn) then
				tmpEntry["type"] = 2;
			else
				tmpEntry["type"] = 1;
			end
			if(WIM_History[theUser] == nil) then
				WIM_History[theUser] = {};
			end
			table.insert(WIM_History[theUser], tmpEntry);
			
			if(WIM_Data.historySettings.maxMsg.enabled) then
				local tOver = table.getn(WIM_History[theUser]) - WIM_Data.historySettings.maxMsg.count;
				if(tOver > 0) then
					for i = 1, tOver do 
						table.remove(WIM_History[theUser], 1);
					end
				end
			end
			if(WIM_Options:IsVisible()) then
				WIM_HistoryScrollBar_Update();
			end
		end
	end
end

function WIM_SortHistory(a, b)
	if(a.stamp < b.stamp) then
		return true;
	else
		return false;
	end
end

function WIM_DisplayHistory(theUser)
	if(WIM_History[theUser] and WIM_Data.enableHistory and WIM_Data.historySettings.popWin.enabled) then
		table.sort(WIM_History[theUser], WIM_SortHistory);
		for i=table.getn(WIM_History[theUser])-WIM_Data.historySettings.popWin.count-1, table.getn(WIM_History[theUser]) do 
			if(WIM_History[theUser][i]) then
				--WIM_GetAlias
				msg = "|Hplayer:"..WIM_History[theUser][i].from.."|h["..WIM_GetAlias(WIM_History[theUser][i].from, true).."]|h: "..WIM_History[theUser][i].msg;
				if(WIM_Data.showTimeStamps) then
					msg = WIM_History[theUser][i].time.." "..msg;
				end
				if(WIM_History[theUser][i].type == 1) then
					getglobal("WIM_msgFrame"..theUser.."ScrollingMessageFrame"):AddMessage(msg, WIM_Data.historySettings.colorIn.r, WIM_Data.historySettings.colorIn.g, WIM_Data.historySettings.colorIn.b);
				elseif(WIM_History[theUser][i].type == 2) then
					getglobal("WIM_msgFrame"..theUser.."ScrollingMessageFrame"):AddMessage(msg, WIM_Data.historySettings.colorOut.r, WIM_Data.historySettings.colorOut.g, WIM_Data.historySettings.colorOut.b);
				end
			end
		end
	end
	--getglobal("WIM_msgFrame"..theUser.."ScrollingMessageFrame"):AddMessage(" ");
end

function WIM_LoadDefaultFilters()
	WIM_Filters = {};
	WIM_Filters[WIM_LOCALIZED_FILTER_1] 	= "Ignore";
	WIM_Filters[WIM_LOCALIZED_FILTER_2] 	= "Ignore";
	WIM_Filters[WIM_LOCALIZED_FILTER_3] 	= "Ignore";
	WIM_Filters[WIM_LOCALIZED_FILTER_4] 	= "Ignore";
	WIM_Filters[WIM_LOCALIZED_FILTER_5] 	= "Ignore";
	WIM_Filters[WIM_LOCALIZED_FILTER_6] 	= "Ignore";
	WIM_Filters[WIM_LOCALIZED_FILTER_7] 	= "Ignore";
	WIM_Filters[WIM_LOCALIZED_FILTER_8] 	= "Ignore";
	WIM_Filters[WIM_LOCALIZED_FILTER_9]		= "Ignore";
	WIM_Filters[WIM_LOCALIZED_FILTER_10]	= "Ignore";
	WIM_Filters[WIM_LOCALIZED_FILTER_11]	= "Ignore";
	WIM_Filters[WIM_LOCALIZED_FILTER_12]	= "Ignore";
	
	WIM_FilteringScrollBar_Update();
end

function WIM_LoadGuildList()
	WIM_GuildList = {};
	if(IsInGuild()) then
		for i=1, GetNumGuildMembers(true) do 
			local name, junk = GetGuildRosterInfo(i);
			if(name) then
				WIM_GuildList[name] = "1"; --[set place holder for quick lookup
			end
		end
	end
end

function WIM_LoadFriendList()
	WIM_FriendList = {};
	for i=1, GetNumFriends() do 
		local name, junk = GetFriendInfo(i);
		if(name) then
			WIM_FriendList[name] = "1"; --[set place holder for quick lookup
		end
	end
end

function WIM_HistoryPurge()
	if(WIM_Data.historySettings.autoDelete.enabled) then
		local delCount = 0;
		local eldestTime = time() - (60 * 60 * 24 * WIM_Data.historySettings.autoDelete.days);
		for key,_ in pairs(WIM_History) do
			if(WIM_History[key][1]) then
				while(WIM_History[key][1].stamp < eldestTime) do
					table.remove(WIM_History[key], 1);
					delCount = delCount + 1;
					if(table.getn(WIM_History[key]) == 0) then
						WIM_History[key] = nil;
						break;
					end
				end
			end
		end
		if(delCount > 0) then
			local tmpMsg, tmp = string.gsub(WIM_LOCALIZED_PURGED_HISTORY, "{n}", delCount);
			DEFAULT_CHAT_FRAME:AddMessage("[WIM]: "..tmpMsg);
		end
	end
end

function WIM_ToggleWindow_OnUpdate(elapsedTime)

	WIM_ToggleWindow_Timer = WIM_ToggleWindow_Timer + elapsedTime; 	

	while (WIM_ToggleWindow_Timer > 1) do
		WIM_ToggleWindow:Hide();
		WIM_ToggleWindow_Timer = 0;
	end
end

function WIM_RecentListAdd(theUser)
	for i=1, table.getn(WIM_RecentList) do 
		if(string.upper(WIM_RecentList[i]) == string.upper(theUser)) then
			table.remove(WIM_RecentList, i);
			break;
		end
	end
	table.insert(WIM_RecentList, 1, theUser);
end

function WIM_ToggleWindow_Toggle()
	if(table.getn(WIM_RecentList) == 0) then
		return;
	end
	
	if(WIM_RecentList[WIM_ToggleWindow_Index] == nil) then
		WIM_ToggleWindow_Index = 1;
	end
	
	WIM_ToggleWindowUser:SetText(WIM_GetAlias(WIM_RecentList[WIM_ToggleWindow_Index], true));
	WIM_ToggleWindow.theUser = WIM_RecentList[WIM_ToggleWindow_Index];
	local tmpStr, t = string.gsub(WIM_LOCALIZED_RECENT_CONVO_COUNT,  "{n1}", WIM_ToggleWindow_Index);
		  tmpStr, t = string.gsub(tmpStr,							 "{n2}", table.getn(WIM_RecentList));
	WIM_ToggleWindowCount:SetText(tmpStr);
	if(WIM_Windows[WIM_RecentList[WIM_ToggleWindow_Index]]) then
		if(WIM_Windows[WIM_RecentList[WIM_ToggleWindow_Index]].newMSG) then
			WIM_ToggleWindowStatus:SetText(WIM_LOCALIZED_NEW_MESSAGE);
			WIM_ToggleWindowIconNew:Show();
			WIM_ToggleWindowIconRead:Hide();
		else
			WIM_ToggleWindowStatus:SetText(WIM_LOCALIZED_NO_NEW_MESSAGES);
			WIM_ToggleWindowIconRead:Show();
			WIM_ToggleWindowIconNew:Hide();
		end
	else
		WIM_ToggleWindowStatus:SetText(WIM_LOCALIZED_CONVO_CLOSED);
		WIM_ToggleWindowIconRead:Show();
		WIM_ToggleWindowIconNew:Hide();
	end
	WIM_ToggleWindow_Timer = 0;
	WIM_ToggleWindow:Show();
	WIM_ToggleWindow_Index = WIM_ToggleWindow_Index + 1;
end

function WIM_Split(theString, thePattern)
	local t = {n = 0}
	local fpat = "(.-)"..thePattern
	local last_end = 1
	local s,e,cap = string.find(theString, fpat, 1)
	while s ~= nil do
		if s~=1 or cap~="" then
		table.insert(t,cap)
		end
		last_end = e+1
		s,e,cap = string.find(theString, fpat, last_end)
	end
	if last_end<=string.len(theString) then
		cap = string.sub(theString,last_end)
		table.insert(t,cap)
	end
	return t
end

function WIM_GetBattleWhoInfo(theUser)
	local user, server = unpack(WIM_Split(theUser, "-"));
	--[ call this function only if a "-" is in the name. Used to get cross realm info.
	for i=1, GetNumRaidMembers() do 
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		local race, raceEng = UnitRace("raid"..i);
		local guildName, guildRankName, guildRankIndex = GetGuildInfo("raid"..i);
		if(not guildName) then guildName=""; end
		if(name == user) then
			WIM_Windows[theUser].waiting_who = false;
			WIM_Windows[theUser].class = class;
			WIM_Windows[theUser].race = race;
			WIM_Windows[theUser].guild = guildName;
			WIM_Windows[theUser].level = level;
			WIM_Windows[theUser].location = zone;
			WIM_SetWhoInfo(theUser);
			return;
		end
	end
end

function WIM_SetTabFrameProps()
	WIM_TabFrame:SetScale(WIM_Data.windowSize * 1);
	WIM_TabFrame:SetAlpha(WIM_Data.windowAlpha);
end

function WIM_UpdateTabs()
	local tabs = {};
	local offset = 0;
	
	for key in pairs(WIM_IconItems) do
		table.insert(tabs, key);
	end
	
	for i=1,10 do 
		local tab = getglobal("WIM_TabFrameTab"..i);
		tab:Hide();
		if(tabs[i+offset]) then
			tab:SetText(WIM_GetAlias(tabs[i+offset], true));
			tab:Show();
			tab.theUser=tabs[i+offset];
		else
			tab:Hide();
			tab.theUser="";
		end
	end
	
end

function WIM_WindowOnShow()
--[[	if(WIM_TabMode.enabled) then
		WIM_TabFrame:ClearAllPoints();
		WIM_TabFrame:SetPoint("BOTTOMLEFT", this:GetName(), "TOPLEFT",45,-2);
		WIM_UpdateTabs();
		WIM_TabSetSelected(this.theUser);
		WIM_TabFrame:Show();
	else
		WIM_TabFrame:Hide();
	end
]]
end

function WIM_GetTabByUser(theUser)
	for i=1,10 do 
		local tab = getglobal("WIM_TabFrameTab"..i);
		if(string.upper(theUser) == string.upper(tab.theUser)) then
			return tab;
		end
	end
	return nil;
end

function WIM_TabSetSelected(theUser)
	for i=1,10 do 
		local tab = getglobal("WIM_TabFrameTab"..i);
		if(string.upper(theUser) == string.upper(tab.theUser)) then
			PanelTemplates_SelectTab(tab);
		else
			PanelTemplates_DeselectTab(tab);
		end
	end
end


function WIM_TimeOutCleanUp()
	-- first see if any work is being asked to be done.
	if( WIM_Data.msgTimeOut.friends == false and WIM_Data.msgTimeOut.other == false ) then return; end
	
	-- scan through each message that is currently loaded.
	for key,_ in pairs(WIM_Windows) do
		-- check if friend, guildie or self and apply timeout if necessary
		if(WIM_Data.msgTimeOut.friends and (key == UnitName("player") or WIM_FriendList[key] ~= nil or WIM_GuildList[key] ~= nil)) then
			if( (time() - WIM_Windows[key].last_msg) > WIM_TimeOuts[WIM_Data.msgTimeOut.fTO] ) then WIM_CloseConvo(key); end
		elseif(WIM_Data.msgTimeOut.other == true) then
			if( (time() - WIM_Windows[key].last_msg) > WIM_TimeOuts[WIM_Data.msgTimeOut.oTO] ) then WIM_CloseConvo(key); end
		end
	end
end

function WIM_CronTab(elapsedTime)
	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsedTime; 	
	
	while (this.TimeSinceLastUpdate > 10) do
		WIM_SpamCheck_LastMSG = "";
		WIM_TimeOutCleanUp();
		this.TimeSinceLastUpdate = 0;
	end
end

function WIM_IconNavMenu_Initialize()
	local info = {};
	
	info = { };
	info.text = "WIM Tools";
	info.isTitle = true;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = BINDING_NAME_WIMSHOWNEW;
	info.func = WIM_ShowNewMessages;
	info.notCheckable = true;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "";
	info.notClickable  = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = BINDING_NAME_WIMSHOWALL;
	info.func = WIM_ShowAll;
	info.notCheckable = true;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = BINDING_NAME_WIMHIDEALL;
	info.func = WIM_HideAll;
	info.notCheckable = true;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "";
	info.notClickable  = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = BINDING_NAME_WIMHISTORY.."...";
	info.notCheckable = true;
	info.func = function() WIM_HistoryFrame:Show(); end;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = WIM_LOCALIZED_ICON_OPTIONS.."...";
	info.notCheckable = true;
	info.func = function() WIM_Options:Show(); end;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

function WIM_IconNavMenu_Toggle()
	ToggleDropDownMenu(1, nil, WIM_IconNavMenu, this, -130, -1);
end
