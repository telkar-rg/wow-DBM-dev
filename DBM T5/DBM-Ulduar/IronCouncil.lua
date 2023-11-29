local mod	= DBM:NewMod("IronCouncil", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4154 $"):sub(12, -3))
mod:SetCreatureID(32927)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat", 32867, 32927, 32857)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_SUCCESS"
)

mod:AddBoolOption("HealthFrame", true)

mod:SetBossHealthInfo(
	32867, L.Steelbreaker,
	32927, L.RunemasterMolgeim,
	32857, L.StormcallerBrundir
)

-- local warnSupercharge			= mod:NewSpellAnnounce(61920, 3) -- not needed
mod:AddBoolOption("TempFormating", true, "announce")
local warnPhase2				= mod:NewPhaseAnnounce(2, 3)
local warnPhase3				= mod:NewPhaseAnnounce(3, 3)

local enrageTimer				= mod:NewBerserkTimer(900)

-- Stormcaller Brundir
-- local spacer11 = mod:AddOptionLine("announce")
-- mod:AddOptionSpacer("timer")
-- mod:AddOptionSpacer("misc")
-- High Voltage ... 63498
local warnChainlight			= mod:NewSpellAnnounce(64215, 1)
local specwarnLightningTendrils	= mod:NewSpecialWarningRun(63486)
local specwarnOverload			= mod:NewSpecialWarningRun(63481) 
mod:AddBoolOption("AlwaysWarnOnOverload", false, "announce")

local timerOverload				= mod:NewCastTimer(6, 63481)
local timerLightningWhirl		= mod:NewCastTimer(5, 63483)
local timerLightningTendrils	= mod:NewBuffActiveTimer(27, 63486)

-- mod:AddBoolOption("PlaySoundOnOverload", true)
-- mod:AddBoolOption("PlaySoundLightningTendrils", true)
local soundOverload          = mod:NewSound(63481, DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(63481), true)
local soundLightningTendrils = mod:NewSound(63486, DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(63486), true)


-- Runemaster Molgeim
-- mod:AddOptionSpacer("announce")
-- mod:AddOptionSpacer("timer")
-- mod:AddOptionSpacer("misc")
-- Lightning Blast ... don't know, maybe 63491
local warnRuneofPower			= mod:NewTargetAnnounce(64320, 2)
local warnRuneofDeath			= mod:NewSpellAnnounce(63490, 2)
local warnShieldofRunes			= mod:NewSpellAnnounce(63489, 2)
local warnRuneofSummoning		= mod:NewSpellAnnounce(62273, 3)
-- Runemaster Molgeim
local specwarnRuneofDeath		= mod:NewSpecialWarningMove(63490)
-- Runemaster Molgeim
local timerShieldofRunes		= mod:NewBuffActiveTimer(15, 63967)
-- local timerRuneofDeathDura		= mod:NewNextTimer(30, 63490)
local timerRuneofPower			= mod:NewCDTimer(30, 61974)
local timerRuneofDeath			= mod:NewCDTimer(25, 63490)
local timerRuneofSummoning		= mod:NewCDTimer(35, 62273)
-- Runemaster Molgeim
-- mod:AddBoolOption("PlaySoundDeathRune", true)
local soundDeathRune = mod:NewSound(63490, DBM_CORE_AUTO_SOUND_OPTION_TEXT_YOU:format(63490), true)


-- Steelbreaker
-- mod:AddOptionSpacer("announce")
-- mod:AddOptionSpacer("timer")
-- mod:AddOptionSpacer("misc")
-- High Voltage ... don't know what to show here - 63498
local warnFusionPunch			= mod:NewSpellAnnounce(61903, 4)
local warnOverwhelmingPower		= mod:NewTargetAnnounce(61888, 2)
local warnStaticDisruption		= mod:NewTargetAnnounce(61912, 3) 

local timerFusionPunchCast		= mod:NewCastTimer(3, 61903)
local timerFusionPunchActive	= mod:NewTargetTimer(4, 61903)
local timerOverwhelmingPower	= mod:NewTargetTimer(25, 61888)

mod:AddBoolOption("SetIconOnOverwhelmingPower")
mod:AddBoolOption("SetIconOnStaticDisruption")



mod:RemoveOption("TempFormating")

local disruptTargets = {}
local disruptIcon = 7
local phase = 0

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	table.wipe(disruptTargets)
	disruptIcon = 7
	phase = 1
end

function mod:RuneTarget()
	local targetname = self:GetBossTarget(32927)
	if not targetname then return end
		warnRuneofPower:Show(targetname)
end

local function warnStaticDisruptionTargets()
	warnStaticDisruption:Show(table.concat(disruptTargets, "<, >"))
	table.wipe(disruptTargets)
	disruptIcon = 7
end

function mod:SPELL_CAST_START(args)
	-- if args:IsSpellID(61920) then -- Supercharge - Unleashes one last burst of energy as the caster dies, increasing all allies damage by 25% and granting them an additional ability.	-- this never fires!
		-- warnSupercharge:Show()
	if args:IsSpellID(63479, 61879) then		-- Chain light
		warnChainlight:Show()
	elseif args:IsSpellID(63483, 61915) then	-- LightningWhirl
		timerLightningWhirl:Start()
	elseif args:IsSpellID(61903, 63493) then	-- Fusion Punch
		warnFusionPunch:Show()
		timerFusionPunchCast:Start()
	elseif args:IsSpellID(62274, 63489) then		-- Shield of Runes
		warnShieldofRunes:Show()
	elseif args:IsSpellID(62273) then				-- Rune of Summoning
		warnRuneofSummoning:Show()
		timerRuneofSummoning:Stop()
		timerRuneofSummoning:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(63490, 62269) then		-- Rune of Death
		warnRuneofDeath:Show()
		-- timerRuneofDeathDura:Start()
		timerRuneofDeath:Start()
	elseif args:IsSpellID(64320, 61974) then	-- Rune of Power
		self:ScheduleMethod(0.1, "RuneTarget")
		timerRuneofPower:Start()
	elseif args:IsSpellID(61869, 63481) then	-- Overload
		timerOverload:Start()
		if self.Options.AlwaysWarnOnOverload or UnitName("target") == L.StormcallerBrundir then
			specwarnOverload:Show()
			-- if self.Options.PlaySoundOnOverload then
				-- PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			-- end
			soundOverload:Play()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(61903, 63493) then		-- Fusion Punch
		timerFusionPunchActive:Start(args.destName)
	elseif args:IsSpellID(62269, 63490) then	-- Rune of Death - move away from it
		if args:IsPlayer() then
			specwarnRuneofDeath:Show()
			soundDeathRune:Play()
			-- if self.Options.PlaySoundDeathRune then
				-- PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			-- end
		end
	elseif args:IsSpellID(62277, 63967) and not args:IsDestTypePlayer() then		-- Shield of Runes
		timerShieldofRunes:Start()		
	elseif args:IsSpellID(64637, 61888) then	-- Overwhelming Power
		warnOverwhelmingPower:Show(args.destName)
		
		if args:IsSpellID(64637) then -- 60 sec (25 mode) ===========
		-- if mod:IsDifficulty("heroic10") then
			timerOverwhelmingPower:Start(60, args.destName)
			if self.Options.SetIconOnOverwhelmingPower then
				self:SetIcon(args.destName, 8, 60) -- skull for 60 seconds (until meltdown)
			end
		else -- 35 sec (10 mode) ===========
			timerOverwhelmingPower:Start(35, args.destName)
			if self.Options.SetIconOnOverwhelmingPower then
				self:SetIcon(args.destName, 8, 35) -- skull for 35 seconds (until meltdown)
			end
		end
		-- if self.Options.SetIconOnOverwhelmingPower then
			-- if mod:IsDifficulty("heroic10") then
				-- self:SetIcon(args.destName, 8, 60) -- skull for 60 seconds (until meltdown)
			-- else
				-- self:SetIcon(args.destName, 8, 35) -- skull for 35 seconds (until meltdown)
			-- end
		-- end
	elseif args:IsSpellID(63486, 61887) then	-- Lightning Tendrils
		timerLightningTendrils:Start()
		specwarnLightningTendrils:Show()
		-- if self.Options.PlaySoundLightningTendrils then
			-- PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		-- end
		soundLightningTendrils:Play()
	elseif args:IsSpellID(61912, 63494) then	-- Static Disruption (Hard Mode)
		disruptTargets[#disruptTargets + 1] = args.destName
		if self.Options.SetIconOnStaticDisruption then 
			self:SetIcon(args.destName, disruptIcon, 20)
			disruptIcon = disruptIcon - 1
		end
		self:Unschedule(warnStaticDisruptionTargets)
		self:Schedule(0.3, warnStaticDisruptionTargets)
		
	elseif args:IsSpellID(61920) then	-- Supercharge (Phase 2!)
		mod:gotoPhase(2)
		if args:GetDestCreatureID() == 32927 then	-- Runemaster Molgeim
			timerRuneofDeath:Start(20)	-- first RuneofDeath comes 20-30sec after Phase 2 begins
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(61920) then	-- Supercharge (Phase 3!)
		mod:gotoPhase(3)
		
		if args:GetDestCreatureID() == 32927 then	-- Runemaster Molgeim
			timerRuneofSummoning:Start(20)	-- first Rune of Summoning comes 20-30sec after Phase 3 begins
		else	-- stop all other timers of Runemaster Molgeim
			timerRuneofPower:Stop()
			timerRuneofDeath:Stop()
		end
	end
end


function mod:gotoPhase(num)
	if phase ~= num then
		phase = num
		
		if phase == 2 then
			warnPhase2:Show()
		elseif phase == 3 then
			warnPhase3:Show()
		end
	end
end

