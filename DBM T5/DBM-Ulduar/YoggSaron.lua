local mod	= DBM:NewMod("YoggSaron", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5001 $"):sub(12, -3))
mod:SetCreatureID(33288)

-- mod:SetMinCombatTime(30)
-- mod:RegisterCombat("combat")
mod:RegisterCombat("yell", L.YellPull) 	-- must be EXACT match

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_AURA_REMOVED_DOSE",
	-- "UPDATE_MOUSEOVER_UNIT",
	"UNIT_HEALTH"
)

local orig_print = print
local function print(...)
	orig_print("|cFFFFFF00".."DBM-Yogg:".."|r",...)
end

mod:SetUsedIcons(5, 6, 7, 8)
local pathSoundFile_critical = "Interface\\AddOns\\DBM-Core\\sounds\\UI_RaidBossWhisperWarning.mp3"
local pathSoundFile_medium = "Sound\\Doodad\\Belltollalliance.wav"


local warnSanity 					= mod:NewAnnounce("WarningSanity", 3, 63050)
local specWarnSanity 				= mod:NewSpecialWarning("SpecWarnSanity")

-- p1
mod:AddAnnounceSpacer()
local warnGuardianSpawned 			= mod:NewAnnounce("WarningGuardianSpawned", 3, 62979)
local specWarnGuardianLow 			= mod:NewSpecialWarning("SpecWarnGuardianLow", false)
local warnFervorCast 				= mod:NewCastAnnounce(63138, 3)
local warnFervor					= mod:NewTargetAnnounce(63138, 4)
local specWarnFervor				= mod:NewSpecialWarningYou(63138)
local specWarnFervorCast			= mod:NewSpecialWarning("SpecWarnFervorCast", mod:IsMelee())
local warnP2 						= mod:NewPhaseAnnounce(2, 2)
-- p2
mod:AddAnnounceSpacer()
local warnBrainPortalSoon			= mod:NewAnnounce("WarnBrainPortalSoon", 2)
local specWarnBrainPortalSoon		= mod:NewSpecialWarning("specWarnBrainPortalSoon", false)
local warnMadness 					= mod:NewCastAnnounce(64059, 2)
local specWarnMadnessOutNow			= mod:NewSpecialWarning("SpecWarnMadnessOutNow")
local warnBrainLink 				= mod:NewTargetAnnounce(63802, 3)
local specWarnBrainLink 			= mod:NewSpecialWarningYou(63802)
local warnMaladyCast 				= mod:NewCastAnnounce(63830, 3)
local specWarnMaladyNear			= mod:NewSpecialWarning("SpecWarnMaladyNear", true)
local specWarnMaladyCast			= mod:NewSpecialWarning("specWarnMaladyCast", true)
local warnCrusherTentacleSpawned	= mod:NewAnnounce("WarningCrusherTentacleSpawned", 2)
local warnSqueeze					= mod:NewTargetAnnounce(64125, 3, nil, nil, "warnSqueezeTarget")

local warnP3 						= mod:NewPhaseAnnounce(3, 2)
-- p3
mod:AddAnnounceSpacer()
local warnDeafeningRoarSoon			= mod:NewPreWarnAnnounce(64189, 5, 3)
local specWarnDeafeningRoar			= mod:NewSpecialWarningSpell(64189, true, nil, false, pathSoundFile_critical)
									--	bossModPrototype:NewSpecialWarningSpell(text, optionDefault, ...)
									--	newSpecialWarning(self, "spell", text, nil, optionDefault, ...)
									--	newSpecialWarning(self, "spell", 64189, nil, true, nil, false, DBM.Options.SpecialWarningSound2)
									--	newSpecialWarning(self, announceType, spellId, stacks, optionDefault, optionName, noSound, runSound, color)
									--	newSpecialWarning(self, spell, 64189, nil, true, nil, noSound, runSound, color)
local warnEmpowerSoon				= mod:NewSoonAnnounce(64486, 4)



local enrageTimer					= mod:NewBerserkTimer(900)
local timerAchieve					= mod:NewAchievementTimer(420, 3012, "TimerSpeedKill")
-- p2
mod:AddTimerSpacer()
local timerBrainportal				= mod:NewTimer(20, "NextPortal", 57687)
local timerMadness 					= mod:NewCastTimer(60, 64059)
local timerFervor					= mod:NewTargetTimer(15, 63138)
-- p2
mod:AddTimerSpacer()
local timerLunaticGaze				= mod:NewCastTimer(4, 64163)
local timerNextLunaticGaze			= mod:NewCDTimer(12, 64163)
local timerEmpowerDuration			= mod:NewBuffActiveTimer(10, 64465)
local timerEmpower					= mod:NewCDTimer(45, 64465)
local timerCastDeafeningRoar		= mod:NewCastTimer(2.3, 64189, "timerCastDeafeningRoar")
local timerNextDeafeningRoar		= mod:NewNextTimer(60, 64189, "timerNextDeafeningRoar")

mod:AddOptionSpacer() 	-- P1
mod:AddBoolOption("ShowSaraHealth", true)
mod:AddBoolOption("SetIconOnFervorTarget")
mod:AddBoolOption("SetIconOnEldestGuardian")

mod:AddOptionSpacer() 	-- P2
mod:AddBoolOption("SetIconOnConstrictorTarget",true)
mod:AddBoolOption("SetIconOnBrainLinkTarget",true)
mod:AddBoolOption("SetIconOnMaladyTarget",true)
local PlaySoundOnCrusher = mod:NewSoundFile(pathSoundFile_critical, "PlaySoundOnCrusher", true)
-- local ttsSpawnConstrictor = mod:NewSoundFile("Interface\\AddOns\\DBM-Core\\sounds\\UR_YOGG_new_constrictor_spawned.mp3", "ttsSpawnConstrictor", true)
mod:AddBoolOption("PlaySoundOnConstrictor", true)
mod:AddBoolOption("PlaySoundOnConstrictorHelp", false)

-- mod:AddBoolOption("MaladyArrow")

mod:AddBoolOption("WarningSqueeze", true)
mod:AddBoolOption("PingConstrictorSelf", true)

local ttsPortalIn10 				= mod:NewSoundFile("Interface\\AddOns\\DBM-Core\\sounds\\TTS_Portal_in_10.mp3", "ttsPortalIn10", true)
local ttsPortalCountdown			= mod:NewSoundFile("Interface\\AddOns\\DBM-Core\\sounds\\5to1.mp3", "ttsPortalCountdown", true)
mod:AddBoolOption("RangeFramePortal25", true)

mod:AddOptionSpacer() 	-- P3
local ttsLunaticGazeCountdown 		= mod:NewSoundFile("Interface\\AddOns\\DBM-Core\\sounds\\2to1.mp3", "ttsLunaticGazeCountdown", true)
local tts2to1Offset = 2.2
-- local tts3to1Offset = 3.2
local tts5to1Offset = 5.2




local phase							= 1
local targetWarningsShown			= {}
local brainLinkTargets = {}
local brainLinkIcon = 7
local Guardians = 0
local crusherDetected = {}

local keeperFreya = 0
local keeperHodir = 0
local keeperMimiron = 0
local keeperThorim = 0


local instanceMode, instanceSize = "normal", 10

local numeral_table = { -- DBM 1.4a
	["mapName"] = "Ulduar",
	["mapLevel"] = 4, -- only in "descent into madness"
	[1] = {0.681031, 0.356199},
	[2] = {0.695205, 0.362903},
	[3] = {0.703943, 0.379381},
	[4] = {0.705289, 0.400340},
	[5] = {0.699395, 0.418070},
	[6] = {0.681031, 0.430334},
	[7] = {0.662667, 0.418070},
	[8] = {0.656773, 0.400340},
	[9] = {0.658119, 0.379381},
	[10] = {0.666857, 0.362903},
}

local pathSoundFileHelp = {
	["BloodElf"] = {
		[3] = {
			"Sound\\Character\\Bloodelf\\Bloodelffemalehelp01.Wav",
			"Sound\\Character\\Bloodelf\\Bloodelffemalehelp02.Wav",
		},
		[2] = {
			"Sound\\Character\\Bloodelf\\Bloodelfmalehelp01.Wav",
			"Sound\\Character\\Bloodelf\\Bloodelfmalehelp02.Wav",
		},
	},
	["Draenei"] = {
		[3] = {
			"Sound\\Character\\Draenei\\Draeneifemalehelp01.Wav",
			"Sound\\Character\\Draenei\\Draeneifemalehelp02.Wav",
		},
		[2] = {
			"Sound\\Character\\Draenei\\Draeneimalehelp01.Wav",
			"Sound\\Character\\Draenei\\Draeneimalehelp02.Wav",
		},
	},
	["Dwarf"] = {
		[3] = {
			"Sound\\Character\\Dwarf\\Dwarfvocalfemale\\Dwarffemalehelp01.Wav",
			"Sound\\Character\\Dwarf\\Dwarfvocalfemale\\Dwarffemalehelp02.Wav",
		},
		[2] = {
			"Sound\\Character\\Dwarf\\Dwarfvocalmale\\Dwarfmalehelp01.Wav",
			"Sound\\Character\\Dwarf\\Dwarfvocalmale\\Dwarfmalehelp02.Wav",
		},
	},
	["Gnome"] = {
		[3] = {
			"Sound\\Character\\Gnome\\Gnomevocalfemale\\Gnomefemalehelp01.Wav",
			"Sound\\Character\\Gnome\\Gnomevocalfemale\\Gnomefemalehelp02.Wav",
			"Sound\\Character\\Gnome\\Gnomevocalfemale\\Gnomefemalehelp03.Wav",
		},
		[2] = {
			"Sound\\Character\\Gnome\\Gnomevocalmale\\Gnomemalehelp01.Wav",
			"Sound\\Character\\Gnome\\Gnomevocalmale\\Gnomemalehelp02.Wav",
		},
	},
	["Human"] = {
		[3] = {
			"Sound\\Character\\Human\\Humanvocalfemale\\Humanfemalehelp01.Wav",
			"Sound\\Character\\Human\\Humanvocalfemale\\Humanfemalehelp02.Wav",
		},
		[2] = {
			"Sound\\Character\\Human\\Humanvocalmale\\Humanmalehelp01.Wav",
			"Sound\\Character\\Human\\Humanvocalmale\\Humanmalehelp02.Wav",
		},
	},
	["NightElf"] = {
		[3] = {
			"Sound\\Character\\Nightelf\\Nightelfvocalfemale\\Nightelffemalehelp01.Wav",
			"Sound\\Character\\Nightelf\\Nightelfvocalfemale\\Nightelffemalehelp02.Wav",
		},
		[2] = {
			"Sound\\Character\\Nightelf\\Nightelfvocalmale\\Nightelfmalehelp01.Wav",
			"Sound\\Character\\Nightelf\\Nightelfvocalmale\\Nightelfmalehelp02.Wav",
			"Sound\\Character\\Nightelf\\Nightelfvocalmale\\Nightelfmalehelp03.Wav",
		},
	},
	["Orc"] = {
		[3] = {
			"Sound\\Character\\Orc\\Orcvocalfemale\\Orcfemalehelp01.Wav",
			"Sound\\Character\\Orc\\Orcvocalfemale\\Orcfemalehelp02.Wav",
		},
		[2] = {
			"Sound\\Character\\Orc\\Orcvocalmale\\Orcmalehelp01.Wav",
			"Sound\\Character\\Orc\\Orcvocalmale\\Orcmalehelp02.Wav",
		},
	},
	["Scourge"] = {
		[3] = {
			"Sound\\Character\\Scourge\\Scourgevocalfemale\\Undeadfemalehelp01.Wav",
			"Sound\\Character\\Scourge\\Scourgevocalfemale\\Undeadfemalehelp02.Wav",
		},
		[2] = {
			"Sound\\Character\\Scourge\\Scourgevocalmale\\Undeadmalehelp01.Wav",
			"Sound\\Character\\Scourge\\Scourgevocalmale\\Undeadmalehelp02.Wav",
		},
	},
	["Tauren"] = {
		[3] = {
			"Sound\\Character\\Tauren\\Taurenvocalfemale\\Taurenfemalehelp01.Wav",
			"Sound\\Character\\Tauren\\Taurenvocalfemale\\Taurenfemalehelp02.Wav",
		},
		[2] = {
			"Sound\\Character\\Tauren\\Taurenvocalmale\\Taurenmalehelp01.Wav",
			"Sound\\Character\\Tauren\\Taurenvocalmale\\Taurenmalehelp02.Wav",
			"Sound\\Character\\Tauren\\Taurenvocalmale\\Taurenmalehelp03.Wav",
		},
	},
	["Troll"] = {
		[3] = {
			"Sound\\Character\\Troll\\Trollvocalfemale\\Trollfemalehelp01.Wav",
			"Sound\\Character\\Troll\\Trollvocalfemale\\Trollfemalehelp02.Wav",
		},
		[2] = {
			"Sound\\Character\\Troll\\Trollvocalmale\\Trollmalehelp01.Wav",
			"Sound\\Character\\Troll\\Trollvocalmale\\Trollmalehelp02.Wav",
		},
	},
}



function mod:OnCombatStart(delay)
	instanceMode, instanceSize = self:GetModeSize()
	
	Guardians = 0
	phase = 1
	
	keeperFreya = 0
	keeperHodir = 0
	keeperMimiron = 0
	keeperThorim = 0
	
	enrageTimer:Start()
	timerAchieve:Start()
	if self.Options.ShowSaraHealth and not self.Options.HealthFrame then
		DBM.BossHealth:Show(L.name)
	end
	if self.Options.ShowSaraHealth then
		DBM.BossHealth:AddBoss(33134, L.Sara)
	end
	
	-- 25 player mode only
	if (instanceSize == 25) then
		if self.Options.RangeFramePortal25 then -- DBM 1.4a
			DBM.RangeCheck:Show("range", 12, "filter", GetRaidTargetIndex, "numeral", numeral_table)
		end
	end -- 25 player mode only
	
	table.wipe(targetWarningsShown)
	table.wipe(brainLinkTargets)
	table.wipe(crusherDetected)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then -- DBM 1.4a
		DBM.RangeCheck:Hide()
	end
	
	ttsLunaticGazeCountdown:Cancel()
end

function mod:MaladyTarget()
	local targetname = self:GetBossTarget(33134)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnMaladyCast:Show()
	end
end

function mod:FervorTarget()
	local targetname = self:GetBossTarget(33134)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnFervorCast:Show()
	end
end

function mod:warnBrainLink()
	warnBrainLink:Show(table.concat(brainLinkTargets, "<, >"))
	-- table.wipe(brainLinkTargets)
	brainLinkIcon = 7 	-- rt7 = Red X / Cross
end

function mod:wipeBrainLinkTable()
	table.wipe(brainLinkTargets)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(64059) then	-- Induce Madness (start of brain phase)
		warnMadness:Show()
		timerMadness:Start()
		
		-- PORTAL BLOCK
		local timePortal = 80
		timerBrainportal:Schedule(timePortal-20)
		warnBrainPortalSoon:Schedule(timePortal-5)
		specWarnBrainPortalSoon:Schedule(timePortal-5)
		ttsPortalIn10:Schedule(timePortal-12)
		ttsPortalCountdown:Schedule(timePortal-tts5to1Offset)
	elseif args:IsSpellID(64189) then		--Deafening Roar
		timerNextDeafeningRoar:Start()
		warnDeafeningRoarSoon:Schedule(55)
		timerCastDeafeningRoar:Start()
		specWarnDeafeningRoar:Show()
	elseif args:IsSpellID(63830) then		-- "Fear" / Malady of the Mind
		-- self:ScheduleMethod(0.1, "MaladyTarget")
		-- warnFervorCast:Show()
	elseif args:IsSpellID(63138) then		--Sara's Fervor
		self:ScheduleMethod(0.1, "FervorTarget")
		warnFervorCast:Show()
	elseif args:IsSpellID(64145) then		-- DETECTION - Crusher Tentacle: Casts "Diminish Power"
		-- 11/24 22:12:38.932  SPELL_CAST_START,0xF1300084AE0012A4,"Schmettertentakel",0xa48,0x0000000000000000,nil,0x80000000,64145,"Kraft schwächen",0x20
		mod:AnnounceSpawnCrusher(args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	-- if args:IsSpellID(64144) and self:GetUnitCreatureId(args.sourceGUID) == 33966 then -- currently (2023 07 12) this does not show in CLEU
		-- warnCrusherTentacleSpawned:Show()
	-- end
end

do
	aliveGuardians = {}
	sortedGuardians = {}
	function mod:SPELL_SUMMON(args)
		if args:IsSpellID(62979) then
			Guardians = Guardians + 1
			warnGuardianSpawned:Show(Guardians)
			
			if self.Options.SetIconOnEldestGuardian and DBM:GetRaidRank() > 0 then
				wipe(aliveGuardians)
				local uId, guid
				for i = 1, GetNumRaidMembers() do
					uId = "raid"..i.."target"
					guid = UnitGUID(uId)
					if self:GetCIDFromGUID(guid) == 33136 then
						table.insert(aliveGuardians, guid) -- store all known targeted guardians
						aliveGuardians[guid] = 1
					end
				end
				wipe(sortedGuardians)
				for guid,_ in pairs(aliveGuardians) do
					table.insert(sortedGuardians, guid)
				end
				
				sort(sortedGuardians) -- sort, so that eldest(lowest guid) is at index 1
				if #sortedGuardians > 0 then -- if at least 1 guardian alive
					for i = 1, GetNumRaidMembers() do
						uId = "raid"..i.."target"
						guid = UnitGUID(uId)
						if UnitGUID(uId) == sortedGuardians[1] then -- search for the eldest alive guardian
							SetRaidTarget(uId, 8) -- set rt8
							break
						end
					end
				end
			end
		end
	end
end


function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(63802) then		-- Brain Link
		self:UnscheduleMethod("warnBrainLink")
		self:UnscheduleMethod("wipeBrainLinkTable")
		
		brainLinkTargets[#brainLinkTargets + 1] = args.destName
		if self.Options.SetIconOnBrainLinkTarget then
			self:SetIcon(args.destName, brainLinkIcon, 30)
			brainLinkIcon = brainLinkIcon - 1
		end
		if args:IsPlayer() then
			specWarnBrainLink:Show()
		end
		
		mod:ScheduleMethod(0.2, "warnBrainLink")
		mod:ScheduleMethod(30.5, "wipeBrainLinkTable")	-- safety wipe if SPELL_AURA_REMOVED is not seen after 30s
		
	elseif args:IsSpellID(63830, 63881) then   -- "Fear" / Malady of the Mind (Death Coil) 
		if self.Options.SetIconOnMaladyTarget then
			self:SetIcon(args.destName, 8, 4.5) 	-- malady lasts only for 4s !
		end
		local uId = DBM:GetRaidUnitId(args.destName) 
		if uId then 
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then 
				specWarnMaladyNear:Show(args.destName)
				if self.Options.MaladyArrow then
					DBM.Arrow:ShowRunAway(x, y, 12, 5)
				end
			end 
		end 
		
	elseif args:IsSpellID(63138) then	-- Sara's Fervor
		warnFervor:Show(args.destName)
		timerFervor:Start(args.destName)
		if self.Options.SetIconOnFervorTarget then
			self:SetIcon(args.destName, 7, 15)
		end
		if args:IsPlayer() then 
			specWarnFervor:Show()
		end
		
	elseif args:IsSpellID(64126, 64125) then	-- Squeeze		
		mod:AnnounceSpawnConstrictor(args.destName)
		
		if self.Options.SetIconOnConstrictorTarget then
			self:SetIcon(args.destName, 5)
		end
		
		if args:IsPlayer() then			
			if self.Options.WarningSqueeze then
				SendChatMessage(L.WarningYellSqueeze, "SAY")
				SendChatMessage( format("{rt5} %s {rt5}", L.WarningYellSqueeze), "RAID")
			end
			
			if self.Options.PingConstrictorSelf then
				Minimap:PingLocation()
			end
		end	
	elseif args:IsSpellID(63894) then	-- Shadowy Barrier of Yogg-Saron (this is happens when p2 starts)
		mod:gotoP2()
		-- phase = 2
		
		-- PORTAL BLOCK
		-- timerBrainportal:Start(60)
		-- warnBrainPortalSoon:Schedule(57)
		-- specWarnBrainPortalSoon:Schedule(57)
		-- warnP2:Show()
		-- if self.Options.ShowSaraHealth then
			-- DBM.BossHealth:RemoveBoss(33134)
			-- if not self.Options.HealthFrame then
				-- DBM.BossHealth:Hide()
			-- end
		-- end
	elseif args:IsSpellID(64163) then	-- Lunatic Gaze (reduces sanity)
		timerLunaticGaze:Start()
		timerNextLunaticGaze:Start()
		ttsLunaticGazeCountdown:Schedule(12-tts2to1Offset)
	elseif args:IsSpellID(64465) then	-- Shadow Beacon / Empowering Shadows
		timerEmpower:Start()
		timerEmpowerDuration:Start()
		warnEmpowerSoon:Schedule(40)
	
	
	elseif args.sourceGUID:sub(9, 12) == "84AE" then 	-- DETECTION - Crusher Tentacle: if src is Crusher
		mod:AnnounceSpawnCrusher(args.sourceGUID)
	elseif args.destGUID:sub(9, 12) == "84AE" then 	-- DETECTION - Crusher Tentacle: if dst is Crusher
		mod:AnnounceSpawnCrusher(args.destGUID)
		
	elseif not keeperFreya   and args:IsSpellID(62670) then	-- Resilience of Nature BUFF
		keeperFreya = 1
		-- print("Detected keeperFreya")
	elseif not keeperHodir   and args:IsSpellID(62650) then	-- Fortitude of Frost BUFF
		keeperHodir = 1
		-- print("Detected keeperHodir")
	elseif not keeperMimiron and args:IsSpellID(62671) then	-- Speed of Invention BUFF
		keeperMimiron = 1
		-- print("Detected keeperMimiron")
	elseif not keeperThorim  and args:IsSpellID(62702) then	-- Fury of the Storm BUFF
		keeperThorim = 1
		-- print("Detected keeperThorim")
		
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(63894) then		-- Shadowy Barrier removed from Yogg-Saron (start p3)
		mod:gotoP3() -- save transition to p3
		
		if mod:LatencyCheck() then
			self:SendSync("Phase3")			-- Sync this because you don't get it in your combat log if you are in brain room.
		end
	-- elseif args:IsSpellID(64167, 64163) then	-- Lunatic Gaze
		-- timerNextLunaticGaze:Start()
		
	elseif args:IsSpellID(63802) then		-- Brain Link REMOVED
		-- if removed early before scheduled wipe
		self:UnscheduleMethod("wipeBrainLinkTable")
		
		if self.Options.SetIconOnBrainLinkTarget then
			if brainLinkTargets and #brainLinkTargets > 0 then
				if brainLinkTargets[1] then self:RemoveIcon(brainLinkTargets[1]) end
				if brainLinkTargets[2] then self:RemoveIcon(brainLinkTargets[2]) end
			end
		end
		self:wipeBrainLinkTable()
		
	elseif args:IsSpellID(64126, 64125) then	-- Squeeze
		if self.Options.SetIconOnConstrictorTarget then
			-- get current raid icon
			local curIcon = self:GetIcon(args.destName) or 0
			-- if we still have constrictor icon, then remove it
			if curIcon == 5 then
				self:RemoveIcon(args.destName)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	if args:IsSpellID(63050) and args.destGUID == UnitGUID("player") then
		if args.amount == 50 then
			warnSanity:Show(args.amount)
		elseif args.amount == 25 or args.amount == 15 or args.amount == 5 then
			warnSanity:Show(args.amount)
			specWarnSanity:Show(args.amount)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if phase == 1 and uId == "target" and self:GetUnitCreatureId(uId) == 33136 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.3 and not targetWarningsShown[UnitGUID(uId)] then
		targetWarningsShown[UnitGUID(uId)] = true
		specWarnGuardianLow:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:find(L.YellPhase2) then
		mod:gotoP2()
		
		if mod:LatencyCheck() then
			self:SendSync("Phase2")
		end
	elseif msg:find(L.YellPhase3) then
		mod:gotoP3()
		
		if mod:LatencyCheck() then
			self:SendSync("Phase3")
		end
	end
end


function mod:OnSync(msg, arg)
	if msg == "Phase2" then
		mod:gotoP2()
	elseif msg == "Phase3" then
		mod:gotoP3()
	-- elseif msg == "SaraHP" and arg then
		
	elseif msg == "CrusherDetect" and arg then
		if arg:sub(9, 12) == "84AE" then -- check if really crusher
			mod:AnnounceSpawnCrusher(arg, true)
		end
	end
end

function mod:gotoP2()
	if phase < 2 then
		phase = 2
		warnP2:Show()
		
		timerFervor:Stop()
		timerFervor:Cancel()
		
		-- PORTAL BLOCK
		local timePortal = 60
		timerBrainportal:Start(timePortal)
		warnBrainPortalSoon:Schedule(timePortal-5)
		specWarnBrainPortalSoon:Schedule(timePortal-5)
		ttsPortalIn10:Schedule(timePortal-10)
		ttsPortalCountdown:Schedule(timePortal-tts5to1Offset)
		
		if self.Options.ShowSaraHealth then
			DBM.BossHealth:RemoveBoss(33134)
			if not self.Options.HealthFrame then
				DBM.BossHealth:Hide()
			end
		end
	end
end

function mod:gotoP3()
	if phase < 3 then
		warnP3:Show()
		phase = 3
		
		timerNextLunaticGaze:Start()	-- first gaze comes exactly 12s after p3 starts
		ttsLunaticGazeCountdown:Schedule(12-tts2to1Offset)
		
		timerEmpower:Start()
		warnEmpowerSoon:Schedule(40)
		
		-- 25 players and less than 4 Keeper Buffs
		-- if (instanceSize == 25) and not(keeperFreya or keeperHodir or keeperMimiron or keeperThorim) then
		if (instanceSize == 25) then
			timerNextDeafeningRoar:Start(30)
			warnDeafeningRoarSoon:Schedule(25)
		end
		
		timerMadness:Cancel()
		timerBrainportal:Cancel()
		
		ttsPortalIn10:Cancel()
		ttsPortalCountdown:Cancel()
		
		specWarnBrainPortalSoon:Cancel()
		warnBrainPortalSoon:Cancel()
		specWarnMadnessOutNow:Cancel()
		
		if self.Options.RangeFramePortal25 then -- DBM 1.4a
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:AnnounceSpawnCrusher(guid, isSync)
	-- only react to a crusher guid ONCE
	if crusherDetected[guid] then return end
	crusherDetected[guid] = true
	
	-- send Sync only if *we* detected this guid.
	if not isSync then
		self:SendSync("CrusherDetect", guid)
	end
	
	
	-- only active if we are in the right DungeonLevel to fight Crushers
	SetMapToCurrentZone()
	if GetCurrentMapDungeonLevel() == 4 then
		warnCrusherTentacleSpawned:Show()
		
		PlaySoundOnCrusher:Play()
	end
end

function mod:AnnounceSpawnConstrictor(playerName)
	-- only active if we are in the right DungeonLevel
	SetMapToCurrentZone()
	if GetCurrentMapDungeonLevel() == 4 then
		warnSqueeze:Show(playerName)
		
		if self.Options.PlaySoundOnConstrictor then
			PlaySoundFile(pathSoundFile_medium)
			
			if self.Options.PlaySoundOnConstrictorHelp then
				local _, pRace = UnitRace(playerName)
				local pSex = UnitSex(playerName)
				
				local path = pathSoundFileHelp[pRace or "BloodElf"]
				if path then
					path = path[pSex or 2]
					if path then
						path = path[random(1,#path)]
						if path then
							self:Schedule(1, function() PlaySoundFile(path) end )
							-- txt:match("\\([^\\]+.Wav)")
							-- print("--", playerName, "!!", tostring(path:match("\\([^\\]+.Wav)")) )
						end
					end
				end
			end
		end
	end
end


