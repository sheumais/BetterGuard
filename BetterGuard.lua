BetterGuardAddon = BetterGuardAddon or {}
local BG = BetterGuardAddon
BG.name = "BetterGuard"
BG.nameSpaced = "Better Guard"
BG.nameTitle = "|c3C80ffBETTER GUARD|r"
BG.version = "2.4"
BG.author = "TheMrPancake"
BG.GUARDS = { -- Guard morphs/levels
    [61511] = true,
    [61529] = true,
    [61536] = true,
    [63323] = true,
    [63329] = true,
    [63335] = true,
    [63341] = true,
    [63346] = true,
    [63351] = true,
}
BG.savedVariablesVersion = 1 -- don't change this otherwise it will wipe everyone's saved variables
BG.defaults = {
    alpha = 1,
    width = 12,
    safeDistance = 5,
    centerColour = {1, 0, 1, 1}, -- debug magenta
    edgeColour = {1, 1, 1, 1}, -- white
    safeColour = {0, 1, 0, 1}, -- green
    breakingColour = {1, 0, 0, 1}, -- red
    showGuardOnYou = false,
    rainbowLine = false,
    showBorder = true,
}
BG.window = GetWindowManager()


--------------------------
-- From OdySupportIcons --
--------------------------
function BG.CreateUI()
    -- create render space control
    BG.ctrl = BG.window:CreateControl( "BGCtrl", GuiRoot, CT_CONTROL )
    BG.ctrl:SetAnchorFill( GuiRoot )
    BG.ctrl:Create3DRenderSpace()
    BG.ctrl:SetHidden( true )

    -- create parent window for icons
	BG.win = BG.window:CreateTopLevelWindow( "BGWin" )
    BG.win:SetClampedToScreen( true )
    BG.win:SetMouseEnabled( false )
    BG.win:SetMovable( false )
    BG.win:SetAnchorFill( GuiRoot )
	BG.win:SetDrawLayer( DL_BACKGROUND )
	BG.win:SetDrawTier( DT_LOW )
	BG.win:SetDrawLevel( 0 )

    -- create parent window scene fragment
	local frag = ZO_HUDFadeSceneFragment:New( BG.win )
	HUD_UI_SCENE:AddFragment( frag )
    HUD_SCENE:AddFragment( frag )
    LOOT_SCENE:AddFragment( frag )
end


local function OnAddOnLoaded(_, name)
    if name ~= BG.name then return end
    EVENT_MANAGER:UnregisterForEvent(BG.name, EVENT_ADD_ON_LOADED)
    
    savedVariables = ZO_SavedVars:NewCharacterIdSettings("BGSavedVariables", BG.savedVariablesVersion, nil, BG.defaults)
    BG.savedVariables = savedVariables

    EVENT_MANAGER:RegisterForEvent(BG.name, EVENT_GROUP_MEMBER_JOINED, BG.GenerateGroupList)
    EVENT_MANAGER:RegisterForEvent(BG.name, EVENT_GROUP_MEMBER_LEFT, BG.GenerateGroupList)
    EVENT_MANAGER:RegisterForEvent(BG.name, EVENT_PLAYER_ACTIVATED, BG.GenerateGroupList)

    local i = 0
    for abilityId in pairs(BG.GUARDS) do
        i = i + 1
        local eventName = BG.name..i
        EVENT_MANAGER:RegisterForEvent(eventName, EVENT_COMBAT_EVENT, BG.MonitorGuardStatus)
        EVENT_MANAGER:AddFilterForEvent(eventName, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, abilityId)
    end

    BG.CreateUI()
    BG.RemoveLine()
    BG.GenerateGroupList()
    if LibAddonMenu2 then
        BG.RegisterLAMPanel()
    end
end

EVENT_MANAGER:RegisterForEvent(BG.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)