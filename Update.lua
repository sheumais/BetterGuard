BetterGuardAddon = BetterGuardAddon or {}
local BG = BetterGuardAddon

BG.interval = 10

function BG.OnUpdate()
    -- not sure what to put here, so im leaving it blank for now.
    -- d("test") -- spams my chat so it works
end

function BG.StopPolling()
    EVENT_MANAGER:UnregisterForUpdate( BG.name .. "Update" )
end

function BG.StartPolling()
    EVENT_MANAGER:UnregisterForUpdate( BG.name .. "Update" )
    EVENT_MANAGER:RegisterForUpdate( BG.name .. "Update", BG.interval, BG.OnUpdate )
end