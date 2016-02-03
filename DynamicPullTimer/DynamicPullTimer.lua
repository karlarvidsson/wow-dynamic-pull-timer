
DynamicPullTimer = {}


DynamicPullTimer.OptionsFrame = CreateFrame("FRAME", "DPTMainFrame", UIParent, "DPTOptionsFrameTemplate")
DynamicPullTimer.OptionsFrame:Hide()

local function tableCopy(t)
    local copy = {}
    for k, v in pairs(t) do
        copy[k] = v
    end
    return copy
end

DynamicPullTimer.countdown = 10

local defaultSpecTimers = {
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
            [267] = 10, -- Warlock: Destruction
            [268] = 10, -- Monk: Brewmaster
            [269] = 10, -- Monk: Windwalker
            [270] = 10, -- Monk: Mistweaver
        }
		
local specIcons = {
	[71] = "Interface\\Icons\\Ability_Warrior_SavageBlow", 
	[72] = "Interface\\Icons\\Ability_Warrior_InnerRage",
	[73] = "Interface\\Icons\\Ability_Warrior_DefensiveStance",
	[65] = "Interface\\Icons\\Spell_Holy_HolyBolt", 
	[66] = "Interface\\Icons\\Ability_Paladin_ShieldoftheTemplar", 
	[70] = "Interface\\Icons\\Spell_Holy_AuraOfLight",
	[253] = "INTERFACE\\ICONS\\ability_hunter_bestialdiscipline", 
	[254] = "Interface\\Icons\\Ability_Hunter_FocusedAim", 
	[255] = "INTERFACE\\ICONS\\ability_hunter_camouflage",
	[259] = "Interface\\Icons\\Ability_Rogue_Eviscerate", 
	[260] = "Interface\\Icons\\Ability_BackStab", 
	[261] = "Interface\\Icons\\Ability_Stealth",
	[256] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
	[257] = "Interface\\Icons\\Spell_Holy_GuardianSpirit", 
	[258] = "Interface\\Icons\\Spell_Shadow_ShadowWordPain",
	[250] = "Interface\\Icons\\Spell_Deathknight_BloodPresence", 
	[251] = "Interface\\Icons\\Spell_Deathknight_FrostPresence", 
	[252] = "Interface\\Icons\\Spell_Deathknight_UnholyPresence",
	[262] = "Interface\\Icons\\Spell_Nature_Lightning", 
	[263] = "Interface\\Icons\\Spell_Shaman_ImprovedStormstrike", 
	[264] = "Interface\\Icons\\Spell_Nature_MagicImmunity",
	[62] = "Interface\\Icons\\Spell_Holy_MagicalSentry", 
	[63] = "Interface\\Icons\\Spell_Fire_FireBolt02", 
	[64] = "Interface\\Icons\\Spell_Frost_FrostBolt02",
	[265] = "Interface\\Icons\\Spell_Shadow_DeathCoil", 
	[266] = "Interface\\Icons\\Spell_Shadow_Metamorphosis", 
	[267] = "Interface\\Icons\\Spell_Shadow_RainOfFire",
	[268] = "Interface\\Icons\\spell_monk_brewmaster_spec", 
	[269] = "Interface\\Icons\\spell_monk_windwalker_spec", 
	[270] = "Interface\\Icons\\spell_monk_mistweaver_spec",
	[102] = "Interface\\Icons\\Spell_Nature_StarFall", 
	[103] = "Interface\\Icons\\Ability_Druid_CatForm", 
	[104] = "Interface\\Icons\\Ability_Racial_BearForm", 
	[105] = "Interface\\Icons\\Spell_Nature_HealingTouch"
} 

local classNames = {"Death Knight","Druid","Hunter","Mage","Monk","Paladin","Priest","Rogue","Shaman","Warlock","Warrior"}
local classColors = {
	["Warrior"] = "C79C6E",
	["Paladin"] = "F58CBA",
	["Hunter"] = "ABD473",
	["Rogue"] = "FFF569",
	["Priest"] = "FFFFFF",
	["Death Knight"] = "C41F3B",
	["Shaman"] = "0070DE",
	["Mage"] = "69CCF0",
	["Warlock"] = "9482C9",
	["Monk"] = "00FF96",
	["Druid"] = "FF7D0A",
}
local specNamesByID = {
            [62] = "Arcane",
            [63] = "Fire",
            [64] = "Frost",
            [65] = "Holy",
            [66] = "Protection",
            [70] = "Retribution",
            [71] = "Arms",
            [72] = "Fury",
            [73] = "Protection",
            [102] = "Balance",
            [103] = "Feral",
            [104] = "Guardian",
            [105] = "Restoration",
            [250] = "Blood",
            [251] = "Frost",
            [252] = "Unholy",
            [253] = "Mastery",
            [254] = "Marksmanship",
            [255] = "Survival",
            [256] = "Discipline",
            [257] = "Holy",
            [258] = "Shadow",
            [259] = "Assassination",
            [260] = "Combat",
            [261] = "Subtlety",
            [262] = "Elemental",
            [263] = "Enhancement",
            [264] = "Restoration",
            [265] = "Affliction",
            [266] = "Demonology",
            [267] = "Destruction",
            [268] = "Brewmaster",
            [269] = "Windwalker",
            [270] = "Mistweaver"
}
local specByClass = {
	["Warrior"] = {71, 72, 73},
	["Paladin"] = {65, 66, 70},
	["Hunter"] = {253, 254, 255},
	["Rogue"] = {259, 260, 261},
	["Priest"] = {256, 257, 258},
	["Death Knight"] = {250, 251, 252},
	["Shaman"] = {262, 263, 264},
	["Mage"] = {62, 63, 64},
	["Warlock"] = {265, 266, 267},
	["Monk"] = {268, 269, 269},
	["Druid"] = {102, 103, 104, 105}
}

function DynamicPullTimer.OptionsFrame.Open()
	
	if not DynamicPullTimer.OptionsFrame.Initialized then
		DynamicPullTimer.OptionsFrame.Initialized = true
		DynamicPullTimerSaved = DynamicPullTimerSaved or {}
		DynamicPullTimerSaved.specTimes = DynamicPullTimerSaved.specTimes or tableCopy(defaultSpecTimers)

		local function SpecsEditBoxTextChanged(self,isUser)
			if not isUser then
				return
			end
			local spec = self.id
			local val = tonumber(self:GetText())
			if val == nil then
				val = 0
			elseif val > 60 then
				val = 60
			elseif val < 0 then
				val = 0
			end
			self:SetText(val)
			DynamicPullTimerSaved.specTimes[spec] = val
		end
		
		--self.scrollFrameText = ELib:Text(self,"Spec timers (preparation time, in seconds, needed per spec for dynamic pull timer):",13):Size(600,30):Point(20,-290):Top()
		--DynamicPullTimer.scrollFrame = ELib:ScrollFrame(self):Size(655,300):Point("TOP",0,-310):Height(550)
		DynamicPullTimer.classTitles = {}
		DynamicPullTimer.classFrames = {}
		local i = 1
		for key, class in ipairs(classNames) do
			
			local column = (key-1) % 3
			local row = math.floor((key-1) / 3)
			local frame = CreateFrame("Frame",nil, DynamicPullTimer.OptionsFrame)
			DynamicPullTimer.classFrames[class] = frame
			frame:SetSize(210,26)
			frame:SetPoint("TOPLEFT", 70 + 205 * column, -60 - 140 * row)
			DynamicPullTimer.classTitles[class] = ELib:Text(frame,"\124cFF"..classColors[class]..class.."\124r",13):Size(200,20):Point(0,0 ):Top()
			frame.icon = frame:CreateTexture(nil, "BACKGROUND")
			
			DynamicPullTimer.classFrames[class].specFrames = {}
			for specRow, spec in ipairs(specByClass[class]) do
				local specFrame = CreateFrame("Frame", nil, frame)
				DynamicPullTimer.classFrames[class].specFrames[spec] = specFrame
				specFrame:SetSize(20, 26)
				specFrame:SetPoint("TOPLEFT", -30, 0 - 22*specRow)
				specFrame.icon = specFrame:CreateTexture(nil, "BACKGROUND")
				specFrame.icon:SetTexture(specIcons[spec])
				specFrame.icon:SetPoint("TOPLEFT", 0, 0)
				specFrame.icon:SetSize(20,20)
				specFrame.specName = ELib:Text(specFrame, specNamesByID[spec],13):Size(100,20):Point(22,-5):Top():FontSize(10)
				--specFrame.specEditBox = CreateFrame("EditBox", nil, DynamicPullTimer.OptionsFrame, "DPTEditBoxTemplate")
				specFrame.specEditBox = ELib:Edit(specFrame):Size(30,20):Point(100,0):Text(DynamicPullTimerSaved.specTimes[spec]):OnChange(SpecsEditBoxTextChanged)
				specFrame.specEditBox.id = spec
			end
		end
		DynamicPullTimer.ButtonToDefaultTimers = ELib:Button(DynamicPullTimer.OptionsFrame,"Reset"):Size(100,20):Point(415,-562):Tooltip("Reset to default spec times"):OnClick(function()
			DynamicPullTimerSaved.specTimes = tableCopy(defaultSpecTimers)
			for key, class in ipairs(classNames) do
				for specRow, spec in ipairs(specByClass[class]) do
					local specFrame = DynamicPullTimer.classFrames[class].specFrames[spec]
					specFrame.specEditBox:SetText(DynamicPullTimerSaved.specTimes[spec])
				end
			end	
		end) 
		DynamicPullTimer.ButtonClose = ELib:Button(DynamicPullTimer.OptionsFrame,"Close"):Size(100,20):Point(520,-562):Tooltip("Close window"):OnClick(function()
			DynamicPullTimer.OptionsFrame:Hide()
		end) 
	end
	DynamicPullTimer.OptionsFrame:Show()
end



SLASH_DynamicPullTimer1 = "/dynpull"
SLASH_DynamicPullTimer2 = "/dpt"

SlashCmdList["DynamicPullTimer"] = function(arg, editbox)
	if arg == "pull" then
		DynamicPullTimer.CreatePullTimer()
	else
		DynamicPullTimer.OptionsFrame.Open()
	end
	
end


		

		

local function GetDynamicPullTime()
	local time_needed = 10
	local n = GetNumGroupMembers() or 0
	for i=1,n do
		local name,_, subgroup, _, _, _, _, online = GetRaidRosterInfo(i)
		if subgroup <= 6 and online then
			if _G["GExRT"].A.Inspect.db.inspectDB[name] and _G["GExRT"].A.Inspect.db.inspectDB[name].spec then
				local spec = _G["GExRT"].A.Inspect.db.inspectDB[name].spec
				if DynamicPullTimerSaved.specTimes[spec] > time_needed then
					time_needed = DynamicPullTimerSaved.specTimes[spec]
				end
			end
		end
	end
	return time_needed
end

function DynamicPullTimer.CreatePullTimer()
	local time_needed = GetDynamicPullTime()
	local s = "pull " .. time_needed
	SlashCmdList["exrtSlash"](s)
end






