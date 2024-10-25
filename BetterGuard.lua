BetterGuardAddon = BetterGuardAddon or {}
local BG = BetterGuardAddon
BG.name = "BetterGuard"
BG.version = "2.1"
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

-- Defaults
BG.alpha = 1
BG.centerColour = {1, 0, 1, alpha}
BG.edgeColour = {1, 1, 1, alpha}
BG.safeColour = {0, 1, 0, alpha}
BG.breakingColour = {1, 0, 0, alpha}

local function OnAddOnLoaded(_, name)
    if name ~= BG.name then return end
    EVENT_MANAGER:UnregisterForEvent(BG.name, EVENT_ADD_ON_LOADED)
    EVENT_MANAGER:RegisterForEvent(BG.name, EVENT_GROUP_MEMBER_JOINED, BG.generateGroupList)
    EVENT_MANAGER:RegisterForEvent(BG.name, EVENT_GROUP_MEMBER_LEFT, BG.generateGroupList)
    EVENT_MANAGER:RegisterForEvent(BG.name, EVENT_PLAYER_ACTIVATED, BG.generateGroupList)

    local i = 0
    for abilityId in pairs(BG.GUARDS) do
        i = i + 1
        local eventName = BG.name..i
        EVENT_MANAGER:RegisterForEvent(eventName, EVENT_COMBAT_EVENT, BG.monitorGuardStatus)
        EVENT_MANAGER:AddFilterForEvent(eventName, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, abilityId)
    end

    BG.RemoveLine()
    BG.generateGroupList()
end

EVENT_MANAGER:RegisterForEvent(BG.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)