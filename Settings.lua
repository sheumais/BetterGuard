BetterGuardAddon = BetterGuardAddon or {}
local BG = BetterGuardAddon

local LAM = LibAddonMenu2


local panelData = {
    type = "panel",
    name = BG.nameSpaced, -- sidebar name
    displayName = BG.nameTitle,
    author = BG.author,
    version = BG.version,
    slashCommand = "/betterguard",
    website = "https://www.esoui.com/downloads/info3974-BetterGuard.html",
    feedback = "https://github.com/sheumais/BetterGuard/issues",
    registerForRefresh = true,
    registerForDefaults = true,
}

local optionsTable = {
    [1] = {
        type = "description",
        title = nil,
        text = "This addon creates a coloured line between guard tethered players.",
    },
    [2] = {type = "divider"},
    [3] = { 
        type = "checkbox",
        name = "Show other's tether",
        tooltip = "Show a tether, when someone else guards you.",
        getFunc = function() return BG.savedVariables.showGuardOnYou end,
        setFunc = function(value) BG.savedVariables.showGuardOnYou = value end,
        default = BG.defaults.showGuardOnYou,
    },
    [4] = {type = "divider"},
    [5] = {
        type = "slider",
        name = "Alpha",
        tooltip = "Alpha/Transparency",
        min = 1,
        max = 100,
        step = 1,
        getFunc = function() return BG.savedVariables.alpha * 100 end,
        setFunc = function(value) BG.savedVariables.alpha = value / 100 end,
        default = BG.defaults.alpha * 100,
    },
    [6] = {
        type = "slider",
        name = "Width",
        tooltip = "Width of line",
        min = 1,
        max = 50,
        step = 1,
        getFunc = function() return BG.savedVariables.width end,
        setFunc = function(value) BG.savedVariables.width = value end,
        default = BG.defaults.width,
    },
    [7] = {
        type = "colorpicker",
        name = "Edge Colour",
        tooltip = "Edge Colour",
        getFunc = function() return unpack(BG.savedVariables.edgeColour) end,
        setFunc = function(r, g, b, a) BG.savedVariables.edgeColour = {r, g, b, BG.savedVariables.alpha} end,
        default = ZO_ColorDef:New(unpack(BG.defaults.edgeColour)),
    },
    [8] = {
        type = "colorpicker",
        name = "Safe Colour",
        tooltip = "Colour to use when close/safe",
        getFunc = function() return unpack(BG.savedVariables.safeColour) end,
        setFunc = function(r, g, b, a) BG.savedVariables.safeColour = {r, g, b, BG.savedVariables.alpha} end,
        default = ZO_ColorDef:New(unpack(BG.defaults.safeColour)),
    },
    [9] = {
        type = "colorpicker",
        name = "Danger Colour",
        tooltip = "Colour to use when guard is close to breaking",
        getFunc = function() return unpack(BG.savedVariables.breakingColour) end,
        setFunc = function(r, g, b, a) BG.savedVariables.breakingColour = {r, g, b, BG.savedVariables.alpha} end,
        default = ZO_ColorDef:New(unpack(BG.defaults.breakingColour)),
    },
    [10] = {type = "divider"},
}

local function RegisterLAMPanel()
    LAM:RegisterAddonPanel(BG.name, panelData)
    LAM:RegisterOptionControls(BG.name, optionsTable)
end

BG.RegisterLAMPanel = RegisterLAMPanel