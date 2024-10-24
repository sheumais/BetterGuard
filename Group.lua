BetterGuardAddon = BetterGuardAddon or {}
local BG = BetterGuardAddon

BG.groupMembers = {}

local function generateGroupList()
    BG.groupMembers = {}
    local groupSize = GetGroupSize()
    if groupSize == 0 then return end
    
    for i = 1, groupSize do
        BG.groupMembers[GetRawUnitName("group" .. i)] = "group" .. i
    end
end

EVENT_MANAGER:RegisterForEvent(BG.name, EVENT_GROUP_MEMBER_JOINED, generateGroupList)
EVENT_MANAGER:RegisterForEvent(BG.name, EVENT_GROUP_MEMBER_LEFT, generateGroupList)
EVENT_MANAGER:RegisterForEvent(BG.name, EVENT_PLAYER_ACTIVATED, generateGroupList)