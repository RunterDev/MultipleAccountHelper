MAHButtonsMixin = CreateFromMixins(SquareIconButtonMixin)

function MAHButtonsMixin:OnEnter()
    if self.tooltipText:GetText() ~= nil then 
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(self.tooltipText:GetText(), 1, 1, 1)
        GameTooltip:Show()
    end
end

function MAHButtonsMixin:OnLeave()
    if self.tooltipText:GetText() ~= nil then 
        GameTooltip:Hide()
    end
end