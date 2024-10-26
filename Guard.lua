BetterGuardAddon = BetterGuardAddon or {}
local BG = BetterGuardAddon

local characterName = GetRawUnitName("player")

local function MonitorGuardStatus(event, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId, overflow)
    if result == ACTION_RESULT_EFFECT_GAINED then -- Guard Tether Created
        local sourceGroupMember = BG.groupMembers[sourceName]
        local targetGroupMember = BG.groupMembers[targetName]
        if sourceGroupMember == nil or targetGroupMember == nil then return end
        if (sourceName == characterName) or (BG.savedVariables.showGuardOnYou and targetName == characterName) then
            BG.DrawLineBetweenPlayers(sourceGroupMember, targetGroupMember)
        end
    elseif result == ACTION_RESULT_EFFECT_FADED then -- Guard Tether Destroyed
        BG.RemoveLine()
    else
        return
    end
end

BG.MonitorGuardStatus = MonitorGuardStatus