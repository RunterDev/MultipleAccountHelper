local ADDON_NAME, MAH = ...

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

local function CreateTab(panel)
    local tab = LibStub('SecureTabs-2.0'):Add(FriendsFrame)
    tab:SetText(L["TAB_TITLE"])
    tab.frame = panel
end

local function CreateInset(panel)
    local inset = CreateFrame("Frame", "$parentInset", panel, "InsetFrameTemplate")
    inset:SetSize(328, 600)
    inset:SetPoint("TOPLEFT", 4, -60)
    inset:SetPoint("BOTTOMLEFT", 4, 26)

    panel.inset = inset;
end

local function CreateSettingsButton(panel)
    local button = CreateFrame("Button", "MAHSettingsButton", panel, "UIPanelButtonTemplate")
    button:SetText(L["SETTINGS"])
    button:SetSize(134, 21)
    button:SetPoint("BOTTOMLEFT", panel, 4, 4)

    button:SetScript("OnClick", function ()
        MAH:ToogleSettingsPanel()
    end)

    panel.settingsBtn = button
end

local function CreateActualizeButton(panel)
    local button = CreateFrame("Button", "MAHActualizeButton", panel, "UIPanelButtonTemplate")
    button:SetText(L["ACTUALIZE"])
    button:SetSize(134, 21)
    button:SetPoint("BOTTOMRIGHT", panel, -6, 4)

    button:SetScript("OnClick", function ()
        -- Todo
    end)

    panel.actualizeBtn = button
end

function MAH:CreateFriendlistPanel()
    local panel = CreateFrame("Frame", "MultipleAccountHelper", FriendsFrame, "PortraitFrameTemplate")
    panel:SetTitle(L["TAB_TITLE"])
    panel:SetPortraitToAsset(GetSpellTexture(359542))

    CreateInset(panel)
    CreateSettingsButton(panel)
    CreateActualizeButton(panel)

    CreateTab(panel)

    MAH.friendlistPanel = panel
end
