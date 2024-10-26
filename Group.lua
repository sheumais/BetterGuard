BetterGuardAddon = BetterGuardAddon or {}
local BG = BetterGuardAddon

BG.groupMembers = {}

local function GenerateGroupList()
    BG.groupMembers = {}
    local groupSize = GetGroupSize()
    if groupSize == 0 then return end
    for i = 1, GetGroupSize() do
        local unitTag = GetGroupUnitTagByIndex(i)
        if unitTag then
          -- Important to check if unitTag exists here as it might be nil due to group's unitttags being changed as you run around and switch zones without a loading screen, inside dungeons e.g.
             BG.groupMembers[GetRawUnitName(unitTag)] = unitTag 
        end
    end
end

BG.GenerateGroupList = GenerateGroupList