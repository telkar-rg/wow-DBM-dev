local mod	= DBM:NewMod("YoggSaron", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4338 $"):sub(12, -3))
mod:SetCreatureID(33288)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_AURA_REMOVED_DOSE",
	"UNIT_HEALTH"
)

mod:SetUsedIcons(6, 7, 8)

local warnMadness 					= mod:NewCastAnnounce(64059, 2)
local warnFervorCast 				= mod:NewCastAnnounce(63138, 3)
local warnSqueeze					= mod:NewTargetAnnounce(64125, 3)
local warnFervor					= mod:NewTargetAnnounce(63138, 4)
local warnDeafeningRoarSoon			= mod:NewPreWarnAnnounce(64189, 5, 3)
local warnGuardianSpawned 			= mod:NewAnnounce("WarningGuardianSpawned", 3, 62979)
local warnCrusherTentacleSpawned	= mod:NewAnnounce("WarningCrusherTentacleSpawned", 2)
local warnP2 						= mod:NewPhaseAnnounce(2, 2)
local warnP3 						= mod:NewPhaseAnnounce(3, 2)
local warnSanity 					= mod:NewAnnounce("WarningSanity", 3, 63050)
local warnBrainLink 				= mod:NewTargetAnnounce(63802, 3)
local warnBrainPortalSoon			= mod:NewAnnounce("WarnBrainPortalSoon", 2)
local warnEmpowerSoon				= mod:NewSoonAnnounce(64486, 4)

local specWarnGuardianLow 			= mod:NewSpecialWarning("SpecWarnGuardianLow", false)
local specWarnBrainLink 			= mod:NewSpecialWarningYou(63802)
local specWarnSanity 				= mod:NewSpecialWarning("SpecWarnSanity")
local specWarnMadnessOutNow			= mod:NewSpecialWarning("SpecWarnMadnessOutNow")
local specWarnBrainPortalSoon		= mod:NewSpecialWarning("specWarnBrainPortalSoon", false)
local specWarnDeafeningRoar			= mod:NewSpecialWarningSpell(64189)
local specWarnFervor				= mod:NewSpecialWarningYou(63138)
local specWarnFervorCast			= mod:NewSpecialWarning("SpecWarnFervorCast", mod:IsMelee())
local specWarnMaladyNear			= mod:NewSpecialWarning("SpecWarnMaladyNear", true)

mod:AddBoolOption("WarningSqueeze", true, "announce")

local enrageTimer					= mod:NewBerserkTimer(900)
local timerFervor					= mod:NewTargetTimer(15, 63138)
local brainportal					= mod:NewTimer(20, "NextPortal")
local timerLunaticGaze				= mod:NewCastTimer(4, 64163)
local timerNextLunaticGaze			= mod:NewCDTimer(12, 64163)
local timerEmpower					= mod:NewCDTimer(45, 64465)
local timerEmpowerDuration			= mod:NewBuffActiveTimer(10, 64465)
local timerMadness 					= mod:NewCastTimer(60, 64059)
local timerCastDeafeningRoar		= mod:NewCastTimer(2.3, 64189)
local timerNextDeafeningRoar		= mod:NewNextTimer(30, 64189)
local timerAchieve					= mod:NewAchievementTimer(420, 3012, "TimerSpeedKill")

local ttsLunaticGazeCountdown 		= mod:NewSoundFile("Interface\\AddOns\\DBM-Core\\sounds\\3to1.mp3", "TTS Lunatic Gaze Countdown", true)
local tts3to1Offset = 3.7
-- ttsLunaticGazeCountdown:Schedule(12-tts3to1Offset)

mod:AddBoolOption("ShowSaraHealth", true)
mod:AddBoolOption("SetIconOnFearTarget")
mod:AddBoolOption("SetIconOnFervorTarget")
mod:AddBoolOption("SetIconOnBrainLinkTarget")
mod:AddBoolOption("MaladyArrow")

mod:AddBoolOption("RangeFramePortal25", true)

local phase							= 1
local targetWarningsShown			= {}
local brainLinkTargets = {}
local brainLinkIcon = 7
local Guardians = 0

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
	if self.Options.RangeFramePortal25 then -- DBM 1.4a
		if (mod:IsDifficulty("normal25") or mod:IsDifficulty("heroic25")) then	-- 25 player mode only
			DBM.RangeCheck:Show("range", 12, "filter", GetRaidTargetIndex, "numeral", numeral_table)
		end
	end
	
	table.wipe(targetWarningsShown)
	table.wipe(brainLinkTargets)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then -- DBM 1.4a
		DBM.RangeCheck:Hide()
	end
	
	ttsLunaticGazeCountdown:Cancel()
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
	table.wipe(brainLinkTargets)
	brainLinkIcon = 7
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(64059) then	-- Induce Madness (start of brain phase)
		warnMadness:Show()
		timerMadness:Start()
		brainportal:Schedule(60)	-- 
		warnBrainPortalSoon:Schedule(78)
		specWarnBrainPortalSoon:Schedule(78)
		specWarnMadnessOutNow:Schedule(55)
	elseif args:IsSpellID(64189) then		--Deafening Roar
		timerNextDeafeningRoar:Start()
		warnDeafeningRoarSoon:Schedule(55)
		timerCastDeafeningRoar:Start()
		specWarnDeafeningRoar:Show()
	elseif args:IsSpellID(63138) then		--Sara's Fervor
		self:ScheduleMethod(0.1, "FervorTarget")
		warnFervorCast:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(64144) and self:GetUnitCreatureId(args.sourceGUID) == 33966 then 
		warnCrusherTentacleSpawned:Show()
	end
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
		brainLinkTargets[#brainLinkTargets + 1] = args.destName
		if self.Options.SetIconOnBrainLinkTarget then
			self:SetIcon(args.destName, brainLinkIcon, 30)
			brainLinkIcon = brainLinkIcon - 1
		end
		if args:IsPlayer() then
			specWarnBrainLink:Show()
		end
		mod:ScheduleMethod(0.2, "warnBrainLink")
	elseif args:IsSpellID(63830, 63881) then   -- Malady of the Mind (Death Coil) 
		if self.Options.SetIconOnFearTarget then
			self:SetIcon(args.destName, 8, 30) 
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
	elseif args:IsSpellID(64126, 64125) then	-- Squeeze		
		warnSqueeze:Show(args.destName)
		if args:IsPlayer() and self.Options.WarningSqueeze then			
			SendChatMessage(L.WarningYellSqueeze, "SAY")			
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
	elseif args:IsSpellID(63894) then	-- Shadowy Barrier of Yogg-Saron (this is happens when p2 starts)
		mod:gotoP2()
		-- phase = 2
		-- brainportal:Start(60)
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


function mod:OnSync(msg)
	if msg == "Phase2" then
		mod:gotoP2()
	elseif msg == "Phase3" then
		mod:gotoP3()
	end
end

function mod:gotoP2()
	if phase < 2 then
		phase = 2
		
		timerFervor:Stop()
		
		brainportal:Start(60)
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
		timerNextDeafeningRoar:Start(30)
		warnDeafeningRoarSoon:Schedule(25)
		
		timerMadness:Stop()
		brainportal:Stop()
		specWarnBrainPortalSoon:Cancel()
		warnBrainPortalSoon:Cancel()
		specWarnMadnessOutNow:Cancel()
		
		if self.Options.RangeFramePortal25 then -- DBM 1.4a
			DBM.RangeCheck:Hide()
		end
	end
end

-- msg:find(L["phase3_trigger"])