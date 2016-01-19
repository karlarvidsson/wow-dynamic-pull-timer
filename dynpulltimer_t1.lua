function(e)
    if not WA_DPT_initialized then
        WA_DPT_macro_name = "WA_DPT_pull_macro"
		WA_DPT_macro_body_text = "/ert pull %d"
        WA_DPT_update_interval = 3
        WA_DPT_countdown = WA_DPT_countdown or 10
        WA_DPT_pulse_timer = WA_DPT_pulse_timer or 0
        WA_DPT_last_pulse = WA_DPT_last_pulse or 0
        WA_DPT_time_needed_from_spec = {
            [62] = 10,    -- Mage: Arcane
            [63] = 10,    -- Mage: Fire
            [64] = 10,    -- Mage: Frost
            [65] = 10,    -- Paladin: Holy
            [66] = 10,    -- Paladin: Protection
            [70] = 10,    -- Paladin: Retribution
            [71] = 10,    -- Warrior: Arms
            [72] = 10,    -- Warrior: Fury
            [73] = 10,    -- Warrior: Protection
            [102] = 10,    -- Druid: Balance
            [103] = 10, -- Druid: Feral
            [104] = 10, -- Druid: Guardian
            [105] = 10, -- Druid: Restoration
            [250] = 10, -- Death Knight: Blood
            [251] = 10, -- Death Knight: Frost
            [252] = 10, -- Death Knight: Unholy
            [253] = 10, -- Hunter: Beast Mastery
            [254] = 10, -- Hunter: Marksmanship
            [255] = 10, -- Hunter: Survival
            [256] = 10, -- Priest: Discipline
            [257] = 10, -- Priest: Holy
            [258] = 10, -- Priest: Shadow
            [259] = 10, -- Rogue: Assassination
            [260] = 10, -- Rogue: Combat
            [261] = 10, -- Rogue: Subtlety
            [262] = 10, -- Shaman: Elemental
            [263] = 10, -- Shaman: Enhancement
            [264] = 10, -- Shaman: Restoration
            [265] = 22, -- Warlock: Affliction
            [266] = 10, -- Warlock: Demonology
            [267] = 10, -- Warlock: Destruction
            [268] = 10, -- Monk: Brewmaster
            [269] = 10, -- Monk: Windwalker
            [270] = 10, -- Monk: Mistweaver
        }
        if GetMacroIndexByName(WA_DPT_macro_name) == 0 then
            CreateMacro(WA_DPT_macro_name, "Spell_Holy_BorrowedTime", string.format(WA_DPT_macro_body_text, 10), nil)
        end
        WA_DPT_initialized = true
    end
    
    if not WA_DPT_initialized then
        return
    end
    
    WA_DPT_pulse_timer = time() - WA_DPT_last_pulse
    if WA_DPT_pulse_timer >= WA_DPT_update_interval then
        local time_needed = 10
        local n = GetNumGroupMembers() or 0
        for i=1,n do
            local name,_,subgroup = GetRaidRosterInfo(i)
            if _G["GExRT"].A["InspectViewer"].db.inspectDB[name] and _G["GExRT"].A["InspectViewer"].db.inspectDB[name].spec then
                local spec = _G["GExRT"].A["InspectViewer"].db.inspectDB[name].spec;
                if WA_DPT_time_needed_from_spec[spec] > time_needed then
                    time_needed = WA_DPT_time_needed_from_spec[spec]
                end
            end
        end
        WA_DPT_countdown = time_needed
        
        EditMacro(WA_DPT_macro_name, nil, nil, string.format(WA_DPT_macro_body_text, WA_DPT_countdown), 1, nil);
        WA_DPT_last_pulse = time()
    end
    return true
end

