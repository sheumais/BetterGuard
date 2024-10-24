BetterGuardAddon = BetterGuardAddon or {}
local BG = BetterGuardAddon

local characterName = GetRawUnitName("player")

local function monitorGuardStatus(event, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId, overflow)
    if result == ACTION_RESULT_EFFECT_GAINED then -- Guard Tether Created
        if sourceName == characterName then -- Your own guard tether
            local sourceGroupMember = BG.groupMembers[sourceName]
            local targetGroupMember = BG.groupMembers[targetName]
            if sourceGroupMember  ~= nil and targetGroupMember  ~= nil then -- You and your guard target are in a group
                BG.DrawLineBetweenPlayers(sourceGroupMember , targetGroupMember )
            end
        end
    elseif result == ACTION_RESULT_EFFECT_FADED then -- Guard Tether Destroyed
        BG.RemoveLine()
    else
        return
    end
end

BG.monitorGuardStatus = monitorGuardStatus