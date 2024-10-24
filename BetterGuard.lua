BetterGuardAddon = BetterGuardAddon or {}
local BG = BetterGuardAddon
BG.name = "BetterGuard"
BG.version = "1.0"
BG.author = "TheMrPancake"

-- Defaults
BG.alpha = 1
BG.centerColour = {1, 0, 1, alpha}
BG.edgeColour = {1, 1, 1, alpha}
BG.safeColour = {0, 1, 0, alpha}
BG.breakingColour = {1, 0, 0, alpha}

local function OnAddOnLoaded(_, name)
    if name ~= BG.name then return end
    EVENT_MANAGER:UnregisterForEvent(BG.name, EVENT_ADD_ON_LOADED)
    BG.RemoveLine()
end

EVENT_MANAGER:RegisterForEvent(BG.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)