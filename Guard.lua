BetterGuardAddon = BetterGuardAddon or {}
local BG = BetterGuardAddon

local characterName = GetRawUnitName("player")

local function monitorGuardStatus(event, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId, overflow)
    if abilityId ~= 61511 then return end
    if result == 2240 then -- Guard Tether Created
        if sourceName == characterName then -- Your own guard tether
            if BG.groupMembers[sourceName] ~= nil and BG.groupMembers[targetName] ~= nil then -- You and your guard target are in a group
                BG.DrawLineBetweenPlayers(BG.groupMembers[sourceName], BG.groupMembers[targetName])
            end
        end
    elseif result == 2250 then -- Guard Tether Destroyed
        BG.RemoveLine()
    else
        return
    end
end


EVENT_MANAGER:RegisterForEvent(BG.name, EVENT_COMBAT_EVENT, monitorGuardStatus)