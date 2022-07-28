WIM_ButtonsHooked = false;
WIM_TradeSkillIsHooked = false;
WIM_CraftSkillIsHooked = false;
WIM_InspectIsHooked = false;



function WIM_FriendsFrame_SendMessage()
	if(WIM_Data.enableWIM) then
		local name = GetFriendInfo(FriendsFrame.selectedFriend);
		WIM_PostMessage(name, "", 5, "", "");
	else
		WIM_FriendsFrame_SendMessage_orig();
	end
end

function WIM_ChatEdit_ExtractTellTarget(editBox, msg)
	-- Grab the first "word" in the string
	local target = gsub(msg, "(%s*)([^%s]+)(.*)", "%2", 1);
	if ( (strlen(target) <= 0) or (strsub(target, 1, 1) == "|") ) then
		return;
	end
	
	if(WIM_Data.hookWispParse and WIM_Data.enableWIM and WIM_Data.popOnSend and not (WIM_Data.popCombat and UnitAffectingCombat("player"))) then
		target = string.gsub(target, "^%l", string.upper)
		WIM_PostMessage(target, "", 5, "", "");
		editBox:SetText("");
		editBox:Hide();
	else
		WIM_ChatEdit_ExtractTellTarget_orig(editBox, msg);
	end
end


function WIM_HookInspect()
	if(WIM_InspectIsHooked) then
		return;
	end
	
	if(SuperInspectFrame) then
		WIM_SuperInspect_InspectPaperDollItemSlotButton_OnClick_orig = SuperInspect_InspectPaperDollItemSlotButton_OnClick;
		SuperInspect_InspectPaperDollItemSlotButton_OnClick = WIM_SuperInspect_InspectPaperDollItemSlotButton_OnClick;
		WIM_InspectIsHooked = true;
	end
	
	--DEFAULT_CHAT_FRAME:AddMessage("Hooking Complete.");
end

function WIM_AtlasLootItem_OnClick(arg1)
	if ( IsShiftKeyDown() ) then
		if ( WIM_EditBoxInFocus ) then
			local color = strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 1, 10);
			local name = strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 11);
			WIM_EditBoxInFocus:Insert(color.."|Hitem:"..this.itemID..":0:0:0:0:0:0:0|h["..name.."]|h|r");
		end
	end
	WIM_AtlasLootItem_OnClick_orig(arg1);
end

function WIM_AllInOneInventoryFrameItemButton_OnClick(button, ignShift)
	if ( IsShiftKeyDown() ) then
		if ( WIM_EditBoxInFocus ) then
			local bag, slot = AllInOneInventory_GetIdAsBagSlot(this:GetID());
			WIM_EditBoxInFocus:Insert(GetContainerItemLink(bag, slot));
		end
	end
	WIM_AllInOneInventoryFrameItemButton_OnClick_orig(button, ignShift);
end

function WIM_SuperInspect_InspectPaperDollItemSlotButton_OnClick(button, ignoreModifiers)
	local itemLink = this.link;
	if ( IsShiftKeyDown() ) then
		if ( WIM_EditBoxInFocus ) then
			local link = "|c"..this.c.."|H"..itemLink.."|h["..GetItemInfo(itemLink).."]|h|r";
			WIM_EditBoxInFocus:Insert(link);
		end
	end
	WIM_SuperInspect_InspectPaperDollItemSlotButton_OnClick_orig(button, ignoreModifiers);
end

function WIM_ATSWItem_OnClick()
	if ( IsShiftKeyDown() ) then
		if ( WIM_EditBoxInFocus ) then
			WIM_EditBoxInFocus:Insert(ATSW_GetTradeSkillReagentItemLink(ATSWFrame.selectedSkill, this:GetID()));
		end
	end
	WIM_ATSWReagentOnClick_orig();
end

function WIM_ATSWSkill_OnClick()
	if ( IsShiftKeyDown() ) then
		if ( WIM_EditBoxInFocus ) then
			WIM_EditBoxInFocus:Insert(ATSW_GetTradeSkillItemLink(ATSWFrame.selectedSkill));
		end
	end
	WIM_ATSWSkill_OnClick_orig();
end


function WIM_ATSW_AddTradeSkillReagentLinksToChatFrame(skillName)
	if ( IsShiftKeyDown() ) then
		if( WIM_EditBoxInFocus ) then
			local chatline;
			for i=1,table.getn(atsw_tradeskilllist),1 do
				if(atsw_tradeskilllist[i]) then
					if(atsw_tradeskilllist[i].name==skillName) then
						SendChatMessage(ATSW_REAGENTLIST1..atsw_tradeskilllist[i].link..ATSW_REAGENTLIST2, "WHISPER", nil, WIM_EditBoxInFocus:GetParent().theUser);
						for j=1,table.getn(atsw_tradeskilllist[i].reagents),1 do
							chatline=atsw_tradeskilllist[i].reagents[j].count.."x "..atsw_tradeskilllist[i].reagents[j].link;
							SendChatMessage(chatline,"WHISPER",nil,WIM_EditBoxInFocus:GetParent().theUser);
						end
					end
				end
			end
		end
	end
end

function WIM_ATSWFrame_SetSelection(id,wasClicked)
	local skillName, skillType, numAvailable;
	local listpos=ATSW_GetSkillListingPos(id);
	if(atsw_skilllisting[listpos]) then
		skillName = atsw_skilllisting[listpos].name;
		skillType = atsw_skilllisting[listpos].type;
	else
		skillName=nil;
	end
	if(IsShiftKeyDown() and skillName~=nil and wasClicked~=nil) then
		if(arg1=="LeftButton" and WIM_EditBoxInFocus) then
			WIM_ATSW_AddTradeSkillReagentLinksToChatFrame(skillName);
		end
	end
	WIM_ATSWFrame_SetSelection_orig(id, wasClicked);
end

function WIM_HookATSW()
	if(getglobal("ATSWReagent1") ~= nil) then
		-- Skill Icon
		WIM_ATSWSkill_OnClick_orig = getglobal("ATSWSkillIcon"):GetScript("OnClick");
		
		-- Reagent Icons
		getglobal("ATSWSkillIcon"):SetScript("OnClick", WIM_ATSWSkill_OnClick);
		WIM_ATSWReagentOnClick_orig = getglobal("ATSWReagent1"):GetScript("OnClick");
		for i=1,8 do
			getglobal("ATSWReagent"..i):SetScript("OnClick", WIM_ATSWItem_OnClick);
		end
		
		-- Skill list
		WIM_ATSWFrame_SetSelection_orig = ATSWFrame_SetSelection;
		ATSWFrame_SetSelection = WIM_ATSWFrame_SetSelection;
	end
end


-- copy of Lootlink's local function - modified
function WIM_LootLink_GetHyperlink(name)
	local itemLink = ItemLinks[name];
	if( itemLink and itemLink.i and LootLink_CheckItemServer(itemLink, LootLink_GetServerIndex(GetCVar("realmName"))) ) then
		local item;
		if( string.find(itemLink.i, "^%d+:%d+:%d+:%d+$") ) then
			-- Upgrade old links, removing instance-specific data
			item = string.gsub(itemLink.i, "^(%d+):(%d+):(%d+):(%d+)$", "%1:0:0:0:0:0:%3:%4");
		else
			-- Remove instance-specific data that we captured from the link we return (2nd is enchantment, 3rd-5th are sockets)
			item = string.gsub(itemLink.i, "(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+):(%-?%d+)", "%1:0:0:0:0:%6:%7:%8");
		end
		return "item:"..item;
	end
	return nil;
end

-- copy of Lootlink's local function - modified
function WIM_LootLink_GetLink(name)
	local itemLink = ItemLinks[name];
	if( itemLink and itemLink.c and itemLink.i ) then
		local link = "|c"..itemLink.c.."|H"..WIM_LootLink_GetHyperlink(name).."|h["..name.."]|h|r";
		return link;
	end
	return nil;
end

function WIM_LootLinkItemButton_OnClick(button)
	if(button == "LeftButton" and IsShiftKeyDown()) then
		if(WIM_EditBoxInFocus) then
			WIM_EditBoxInFocus:Insert(WIM_LootLink_GetLink(this:GetText()));
		end
	end
	WIM_LootLinkItemButton_OnClick_orig(button);
end




function WIM_EngInventory_ItemButton_OnClick(arg1, arg2)
	if(arg1 == "LeftButton" and IsShiftKeyDown()) then
		if(WIM_EditBoxInFocus) then
			local bar, position, itm, bagnum, slotnum;

			if (EngInventory_buttons[this:GetName()] ~= nil) then
                bar = EngInventory_buttons[this:GetName()]["bar"];
                position = EngInventory_buttons[this:GetName()]["position"];

				bagnum = EngInventory_bar_positions[bar][position]["bagnum"];
				slotnum = EngInventory_bar_positions[bar][position]["slotnum"];

                itm = EngInventory_item_cache[bagnum][slotnum];

				if(itm) then
					WIM_EditBoxInFocus:Insert(GetContainerItemLink(itm["bagnum"], itm["slotnum"]));
					return;
				end
			end
		end
	end
	WIM_EngInventory_ItemButton_OnClick_orig(arg1, arg2);
end


function WIM_FriendsFrame_OnEvent()
  if(event == "WHO_LIST_UPDATE") then
	local numWhos, totalCount = GetNumWhoResults();
	if(numWhos > 0) then
		for i=1, numWhos do 
			local name, guild, level, race, class, zone = GetWhoInfo(i);
			if(WIM_Windows[name] and name ~= "" and name ~= nil) then
				if(WIM_Windows[name].waiting_who) then
					WIM_Windows[name].waiting_who = false;
					WIM_Windows[name].class = class;
					WIM_Windows[name].level = level;
					WIM_Windows[name].race = race;
					WIM_Windows[name].guild = guild;
					WIM_Windows[name].location = zone;
					WIM_SetWhoInfo(name);
					SetWhoToUI(0);
					return;
				end
			end
		end
	else
		SetWhoToUI(0);
		return;
	end
  end
  WIM_FriendsFrame_OnEvent_orig(event);
end


function WIM_SetItemRef (link, text, button)
	if (WIM_isLinkURL(link)) then
		WIM_DisplayURL(link);
		return;
	end
	if (strsub(link, 1, 6) ~= "player") and ( IsShiftKeyDown() ) and ( not ChatFrameEditBox:IsVisible() ) then
		if(WIM_EditBoxInFocus) then
			WIM_EditBoxInFocus:Insert(text);
		end
	end
end

function WIM_ISync_ButtonClick(button)
	if(button == "LeftButton" and IsShiftKeyDown()) then
		if(WIM_EditBoxInFocus) then
			local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..this.storeID);
			if(name_X and link_X and quality_X) then
				WIM_EditBoxInFocus:Insert("|c"..ISync:ReturnHexColor(quality_X).."|H"..link_X.."|h["..name_X.."]|h|r");
			end
		end
	end
end


--Core hooking function. Allows compatibilty across all wow frames.
function WIM_ChatEdit_InsertLink(text)
	if(WIM_EditBoxInFocus) then
		WIM_EditBoxInFocus:Insert(text);
		return true;
	end
	WIM_ChatEdit_InsertLink_orig(text);
end


function WIM_SetUpHooks()
	if(WIM_ButtonsHooked) then
		return;
	end

	--Hook ChatEdit_InsertLink (If other addons follow this convension all will work the way it should.
	WIM_ChatEdit_InsertLink_orig = ChatEdit_InsertLink;
	ChatEdit_InsertLink = WIM_ChatEdit_InsertLink;
	
	--Hook Friends Frame Send Message Button
	WIM_FriendsFrame_SendMessage_orig = FriendsFrame_SendMessage;
	FriendsFrame_SendMessage = WIM_FriendsFrame_SendMessage;
	
	--Hook Chat Frame Whisper Parse
	WIM_ChatEdit_ExtractTellTarget_orig = ChatEdit_ExtractTellTarget;
	ChatEdit_ExtractTellTarget = WIM_ChatEdit_ExtractTellTarget;
	
	--Hook FriendsFrame_OnEvent
	WIM_FriendsFrame_OnEvent_orig = FriendsFrame_OnEvent;
	FriendsFrame_OnEvent = WIM_FriendsFrame_OnEvent;
	
	--Hook ChatFrame_OnEvent
	WIM_ChatFrame_MessageEventHandler_orig = ChatFrame_MessageEventHandler;
	ChatFrame_MessageEventHandler = WIM_ChatFrame_MessageEventHandler;
	
	--Hook SetItemRef
	WIM_SetItemRef_orig = SetItemRef;
	SetItemRef = function(link, text, button) if(not WIM_isLinkURL(link)) then WIM_SetItemRef_orig(link, text, button); end; WIM_SetItemRef(link, text, button); end;

	--Hook ContainerFrameItemButton_OnClick
	WIM_ContainerFrameItemButton_OnClick_orig = ContainerFrameItemButton_OnClick;
	ContainerFrameItemButton_OnClick = function(button, ignoreModifiers) WIM_ContainerFrameItemButton_OnClick_orig(button, ignoreModifiers); WIM_ItemButton_OnClick(button, ignoreModifiers); end;
	
	--Hook AtlasLoot
	WIM_AtlasLootItem_OnClick_orig = AtlasLootItem_OnClick
	AtlasLootItem_OnClick = WIM_AtlasLootItem_OnClick
	
	--Hook AllInOneInventory
	WIM_AllInOneInventoryFrameItemButton_OnClick_orig = AllInOneInventoryFrameItemButton_OnClick;
	AllInOneInventoryFrameItemButton_OnClick = WIM_AllInOneInventoryFrameItemButton_OnClick;
	
	--Hook EngInventory
	WIM_EngInventory_ItemButton_OnClick_orig = EngInventory_ItemButton_OnClick;
	EngInventory_ItemButton_OnClick = WIM_EngInventory_ItemButton_OnClick;
	
	--Hook LootLink
	WIM_LootLinkItemButton_OnClick_orig = LootLinkItemButton_OnClick;
	LootLinkItemButton_OnClick = WIM_LootLinkItemButton_OnClick;
	
	--Hook ATSW
	WIM_HookATSW();
	
	--Hook ItemSync
	if(ISync) then
		for i=1,24 do 
			local button = getglobal("ISyncItem"..i);
			if(button) then
				local origOnClick = button:GetScript("OnClick");
				button:SetScript("OnClick", function() origOnClick(arg1); WIM_ISync_ButtonClick(arg1); end);
			end
		end
	end

	WIM_ButtonsHooked = true;
end


function WIM_AddonDetectToHook(theAddon)
	if(theAddon == "SuperInspect_UI" or theAddon == "Blizzard_InspectUI") then
		WIM_HookInspect();
	end
end
