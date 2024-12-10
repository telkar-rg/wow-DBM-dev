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
	"UNIT_HEALTH"
)

mod:SetUsedIcons(6, 7, 8)

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
mod:AddBoolOption("WarningSqueeze", true, "announce")
mod:AddBoolOption("PingConstrictorSelf", true, "announce")
local warnP3 						= mod:NewPhaseAnnounce(3, 2)
-- p3
mod:AddAnnounceSpacer()
local warnDeafeningRoarSoon			= mod:NewPreWarnAnnounce(64189, 5, 3)
local specWarnDeafeningRoar			= mod:NewSpecialWarningSpell(64189, true, nil, false, DBM.Options.SpecialWarningSound2)
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
local timerCastDeafeningRoar		= mod:NewCastTimer(2.3, 64189)
local timerNextDeafeningRoar		= mod:NewNextTimer(60, 64189)

mod:AddOptionSpacer() 	-- P1
mod:AddBoolOption("ShowSaraHealth", true)
mod:AddBoolOption("SetIconOnFervorTarget")

mod:AddOptionSpacer() 	-- P2
mod:AddBoolOption("SetIconOnBrainLinkTarget",true)
mod:AddBoolOption("SetIconOnMaladyTarget",true)
local ttsSpawnCrusher 				= mod:NewSoundFile("Interface\\AddOns\\DBM-Core\\sounds\\UR_YOGG_new_crusher_spawned.mp3", "ttsSpawnCrusher", true)
-- local ttsSpawnConstrictor 			= mod:NewSoundFile("Interface\\AddOns\\DBM-Core\\sounds\\UR_YOGG_new_constrictor_spawned.mp3", "ttsSpawnConstrictor", true)

-- mod:AddBoolOption("MaladyArrow")
mod:AddBoolOption("RangeFramePortal25", true)

mod:AddOptionSpacer() 	-- P3
local ttsLunaticGazeCountdown 		= mod:NewSoundFile("Interface\\AddOns\\DBM-Core\\sounds\\3to1-blip.mp3", "ttsLunaticGazeCountdown", true)




local tts3to1Offset = 4
-- local ttsLunaticGazeCountdown 		= mod:NewSoundFile("Interface\\AddOns\\DBM-Core\\sounds\\3to1.mp3", "TTS Lunatic Gaze Countdown", true)
-- local tts3to1Offset = 3.7
-- ttsLunaticGazeCountdown:Schedule(12-tts3to1Offset)


local phase							= 1
local targetWarningsShown			= {}
local brainLinkTargets = {}
local brainLinkIcon = 7
local Guardians = 0
local crusherDetected = {}

local buffsKeeper = -1

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

function mod:OnCombatStart(delay)
	instanceMode, instanceSize = self:GetModeSize()
	
	Guardians = 0
	phase = 1
	enrageTimer:Start()
	timerAchieve:Start()
	if self.Options.ShowSaraHealth and not self.Options.HealthFrame then
		DBM.BossHealth:Show(L.name)
	end
	if self.Options.ShowSaraHealth then
		DBM.BossHealth:AddBoss(33134, L.Sara)
	end
	
	buffsKeeper = -1 	-- deactivate if not in 25 player
	-- 25 player mode only
	if (instanceSize == 25) then
		if self.Options.RangeFramePortal25 then -- DBM 1.4a
			DBM.RangeCheck:Show("range", 12, "filter", GetRaidTargetIndex, "numeral", numeral_table)
		end
		
		-- check for Keeper Buffs after 1 sec after combat start
		self:ScheduleMethod(1, "delayedKeeperBuffCheck")
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
		timerBrainportal:Schedule(60)	-- 
		warnBrainPortalSoon:Schedule(78)
		specWarnBrainPortalSoon:Schedule(78)
		specWarnMadnessOutNow:Schedule(55)
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
		if not crusherDetected[args.sourceGUID] then 	-- have we not seen this unique GUID before?
			crusherDetected[args.sourceGUID] = true
			-- warnCrusherTentacleSpawned:Show()
			mod:AnnounceSpawnCrusher()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	-- if args:IsSpellID(64144) and self:GetUnitCreatureId(args.sourceGUID) == 33966 then -- currently (2023 07 12) this does not show in CLEU
		-- warnCrusherTentacleSpawned:Show()
	-- end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(62979) then
		Guardians = Guardians + 1
		warnGuardianSpawned:Show(Guardians)
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
		
		if args:IsPlayer() and self.Options.WarningSqueeze then			
			SendChatMessage(L.WarningYellSqueeze, "SAY")
			
			local m = format("{rt%d}", random(1,8) ) 
			SendChatMessage( format("%s %s %s", m, L.WarningYellSqueeze, m), "RAID")
			
			if self.Options.PingConstrictorSelf then
				Minimap:PingLocation()
			end
		end	
	elseif args:IsSpellID(63894) then	-- Shadowy Barrier of Yogg-Saron (this is happens when p2 starts)
		mod:gotoP2()
		-- phase = 2
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
		ttsLunaticGazeCountdown:Schedule(12-tts3to1Offset)
	elseif args:IsSpellID(64465) then	-- Shadow Beacon / Empowering Shadows
		timerEmpower:Start()
		timerEmpowerDuration:Start()
		warnEmpowerSoon:Schedule(40)
	elseif args.sourceGUID:sub(9, 12) == "84AE" then 	-- DETECTION - Crusher Tentacle: if src is Crusher
		if not crusherDetected[args.sourceGUID] then
			crusherDetected[args.sourceGUID] = true
			-- warnCrusherTentacleSpawned:Show()
			mod:AnnounceSpawnCrusher()
		end
	elseif args.destGUID:sub(9, 12) == "84AE" then 	-- DETECTION - Crusher Tentacle: if dst is Crusher
		if not crusherDetected[args.destGUID] then
			crusherDetected[args.destGUID] = true
			-- warnCrusherTentacleSpawned:Show()
			mod:AnnounceSpawnCrusher()
		end
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
	elseif msg == "SaraHP" and arg then
		
	end
end

function mod:gotoP2()
	if phase < 2 then
		phase = 2
		
		timerFervor:Stop()
		
		timerBrainportal:Start(60)
		warnBrainPortalSoon:Schedule(57)
		specWarnBrainPortalSoon:Schedule(57)
		warnP2:Show()
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
		ttsLunaticGazeCountdown:Schedule(12-tts3to1Offset)
		
		timerEmpower:Start()
		warnEmpowerSoon:Schedule(40)
		
		-- 25 players and less than 4 Keeper Buffs
		if buffsKeeper == 0 then
			timerNextDeafeningRoar:Start(30)
			warnDeafeningRoarSoon:Schedule(25)
		end
		
		-- timerMadness:Stop()
		-- timerBrainportal:Stop()
		timerMadness:Cancel()
		timerBrainportal:Cancel()
		
		specWarnBrainPortalSoon:Cancel()
		warnBrainPortalSoon:Cancel()
		specWarnMadnessOutNow:Cancel()
		
		if self.Options.RangeFramePortal25 then -- DBM 1.4a
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:AnnounceSpawnCrusher()
	warnCrusherTentacleSpawned:Show()
	
	SetMapToCurrentZone()
	if GetCurrentMapDungeonLevel() == 4 then
		ttsSpawnCrusher:Play()
	end
end

function mod:AnnounceSpawnConstrictor(playerName)
	warnSqueeze:Show(playerName)
	
	-- SetMapToCurrentZone() 	-- this is distracting
	-- if GetCurrentMapDungeonLevel() == 4 then
		-- ttsSpawnConstrictor:Play()
	-- end
end

function mod:delayedKeeperBuffCheck()
	buffsKeeper = 0
	for i=1,40 do
		local _, _, _, _, _, _, _, _, _, _, spellId = UnitAura("player", i)
		if spellId then
			if spellId == 62650 or spellId == 62670 or spellId == 62670 or spellId == 62670 then
				buffsKeeper = buffsKeeper + 1
			end
		end
	end
	print("-- DEBUG YoggSaron.lua","Buff=",buffsKeeper) 	-- DEBUG PRINT
end

