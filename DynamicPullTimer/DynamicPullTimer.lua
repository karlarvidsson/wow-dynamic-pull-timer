

DynamicPullTimer = {}

DynamicPullTimer.countdown = 10
DynamicPullTimer.time_needed_from_spec = {
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
            [261] = 25, -- Rogue: Subtlety
            [262] = 16, -- Shaman: Elemental
            [263] = 10, -- Shaman: Enhancement
            [264] = 10, -- Shaman: Restoration
            [265] = 22, -- Warlock: Affliction
            [266] = 10, -- Warlock: Demonology
            [267] = 12, -- Warlock: Destruction
            [268] = 10, -- Monk: Brewmaster
            [269] = 10, -- Monk: Windwalker
            [270] = 10, -- Monk: Mistweaver
        }
SLASH_DynamicPullTimer1 = "/dynpull"
SLASH_DynamicPullTimer2 = "/dpt"

SlashCmdList["DynamicPullTimer"] = function(arg, editbox)
	DynamicPullTimer.CreatePullTimer()
end
		
function DynamicPullTimer.EventHandler(self, event, arg1)
	if event == "PLAYER_SPECIALIZATION_CHANGED" then
		if arg1 then
			NotifyInspect(UnitName(arg1))
		end
	elseif event == "INSPECT_READY" then
		local _,_,_,_,_,name,_ = GetPlayerInfoByGUID(arg1)
		if name then
			local spec = GetInspectSpecialization(name)
			if not spec then
				return
			end
			if not DynamicPullTimer.time_needed_from_spec[spec] then
				return
			end
			if DynamicPullTimer.time_needed_from_spec[spec] >= DynamicPullTimer.countdown then
				DynamicPullTimer.countdown = DynamicPullTimer.time_needed_from_spec[spec]
			else
				local n = GetNumGroupMembers() or 0
				local largest = 0
				for i=1,n do
					local raider,_, subgroup, _, _, _, _, online = GetRaidRosterInfo(i)
					if subgroup <= 6 and online then
						if _G["GExRT"].A["InspectViewer"].db.inspectDB[raider] and _G["GExRT"].A["InspectViewer"].db.inspectDB[raider].spec and name ~= raider then
							local s = _G["GExRT"].A["InspectViewer"].db.inspectDB[raider].spec;
							if DynamicPullTimer.time_needed_from_spec[s] > largest then
								largest = DynamicPullTimer.time_needed_from_spec[s]
							end
						end
					end
				end
				if largest == 0 then
					largest = DynamicPullTimer.time_needed_from_spec[spec]
				end
				if largest < DynamicPullTimer.countdown then
					DynamicPullTimer.countdown = largest
				end
			end
		end
	end
end
		
DynamicPullTimer.EventFrame = CreateFrame("FRAME")
DynamicPullTimer.EventFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
DynamicPullTimer.EventFrame:RegisterEvent("INSPECT_READY")
DynamicPullTimer.EventFrame:SetScript("OnEvent", DynamicPullTimer.EventHandler)



function DynamicPullTimer.UpdateCountdown()
	local time_needed = 10
	local n = GetNumGroupMembers() or 0
	for i=1,n do
		local name,_, subgroup, _, _, _, _, online = GetRaidRosterInfo(i)
		if subgroup <= 6 and online then
			if _G["GExRT"].A["InspectViewer"].db.inspectDB[name] and _G["GExRT"].A["InspectViewer"].db.inspectDB[name].spec then
				local spec = _G["GExRT"].A["InspectViewer"].db.inspectDB[name].spec;
				if spec and DynamicPullTimer.time_needed_from_spec[spec] then
					if DynamicPullTimer.time_needed_from_spec[spec] > time_needed then
						time_needed = DynamicPullTimer.time_needed_from_spec[spec]
					end
				end
			end
		end
	end
	DynamicPullTimer.countdown = time_needed
end



function DynamicPullTimer.CreatePullTimer()
	DynamicPullTimer.UpdateCountdown()
	local s = "pull " .. DynamicPullTimer.countdown
	SlashCmdList["exrtSlash"](s)
end






