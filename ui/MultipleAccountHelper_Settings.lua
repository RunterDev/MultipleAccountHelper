local ADDON_NAME, MAH = ...

local AceGUI = LibStub("AceGUI-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

local function SynchronizeAccounts()
    
end

function MAH:CreateSettingsPanel()
    -- Main Options panel
    local panel = CreateFrame("Frame", "MAHOptionsPanel")
    panel.name = ADDON_NAME

    InterfaceOptions_AddCategory(panel)

    local title = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 15, -10)
    title:SetText(L["ADDON_FULL_NAME"])

    local synchronizationLabel = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    synchronizationLabel:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -22)
    synchronizationLabel:SetText(L["SYNCHRONIZATION_CATEGORY_TITLE"])

    local synchronizationCount = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    synchronizationCount:SetPoint("TOPLEFT", synchronizationLabel, "BOTTOMLEFT", 0, -12)
    synchronizationCount:SetText(L["SYNCHRONIZATION_COUNT"])
    synchronizationCount:SetTextColor(255, 255, 255, 1)

    local synchronizeBtn = CreateFrame("Button", "MAHSynchronizeButton", panel, "RefreshButtonTemplate")
    synchronizeBtn:SetPoint("LEFT", synchronizationCount, "RIGHT", 0, 0)
    synchronizeBtn:SetWidth(30)
    synchronizeBtn:SetHeight(30)

    local inset = CreateFrame("Frame", nil, panel, "InsetFrameTemplate")
    inset:SetSize(600, 600)
    inset:SetPoint("TOPLEFT", 8, -100)
    inset:SetPoint("BOTTOMRIGHT", -8, 10)

    -- local test = CreateFrame("Frame", nil, inset, "MAHSynchronizedAccountDisplayTemplate");
    -- test.title:SetText("test")

    -- About panel
    local about = CreateFrame("Frame", "MAHAboutPanel")
    about.name = L["ABOUT"]
    about.parent = ADDON_NAME

    InterfaceOptions_AddCategory(about)

    MAH.settingsPanel = panel
    MAH.aboutPanel = about
end

function MAH:ToogleSettingsPanel()
    InterfaceOptionsFrame_Show()
    InterfaceOptionsFrame_OpenToCategory(MAH.settingsPanel)
end
