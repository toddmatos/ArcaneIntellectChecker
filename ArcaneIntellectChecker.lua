local ARCANE_INTELLECT_SPELL_IDS = {
    1459,  -- Rank 1
    1460,  -- Rank 2
    1461,  -- Rank 3
    10156, -- Rank 4
    10157, -- Rank 5
}

function ArcaneIntellectChecker_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("UNIT_AURA")
end

function ArcaneIntellectChecker_OnEvent(self, event, arg1)
    if event == "PLAYER_ENTERING_WORLD" or (event == "UNIT_AURA" and arg1 == "player") then
        ArcaneIntellectChecker_CheckBuff()
    end
end

function ArcaneIntellectChecker_CheckBuff()
    local hasArcaneIntellect = false
    for i = 1, 40 do
        local name, _, _, _, _, _, _, _, _, spellId = UnitBuff("player", i)
        if not name then break end
        if ArcaneIntellectChecker_IsArcaneIntellect(spellId) then
            hasArcaneIntellect = true
            break
        end
    end

    if hasArcaneIntellect then
        ArcaneIntellectIcon:Hide()
    else
        ArcaneIntellectIcon:Show()
    end
end

function ArcaneIntellectChecker_IsArcaneIntellect(spellId)
    for _, id in ipairs(ARCANE_INTELLECT_SPELL_IDS) do
        if spellId == id then
            return true
        end
    end
    return false
end

ArcaneIntellectCheckerFrame:SetScript("OnEvent", ArcaneIntellectChecker_OnEvent)

