BetterGuardAddon = BetterGuardAddon or {}
local BG = BetterGuardAddon
BG.name = "BetterGuard"
BG.nameSpaced = "Better Guard"
BG.nameTitle = "|c3C80ffBETTER GUARD|r"
BG.version = "2.3"
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
    centerColour = {1, 0, 1, 1}, -- debug magenta
    edgeColour = {1, 1, 1, 1}, -- white
    safeColour = {0, 1, 0, 1}, -- green
    breakingColour = {1, 0, 0, 1}, -- red
    showGuardOnYou = false,
}

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

    BG.RemoveLine()
    BG.GenerateGroupList()
    BG.RegisterLAMPanel()
end

EVENT_MANAGER:RegisterForEvent(BG.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)