local mod	= DBM:NewMod("Ignis", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

local _, TableShared = ...
local T = TableShared.Timers["Ignis"]

mod:SetRevision(("$Revision: 4133 $"):sub(12, -3))
mod:SetCreatureID(33118)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local announceSlagPot			= mod:NewTargetAnnounce(63477, 3)

local warnFlameJetsCast			= mod:NewSpecialWarningCast(63472)

local timerFlameJetsCast		= mod:NewCastTimer(2.7, 63472)
local timerFlameJetsCooldown	= mod:NewCDTimer(T.FlameJetsCooldown, 63472)
local timerScorchCooldown		= mod:NewNextTimer(T.ScorchCooldown, 63474)
local timerScorchCast			= mod:NewCastTimer(3, 63474)
local timerSlagPot				= mod:NewTargetTimer(10, 63477)
local timerAchieve				= mod:NewAchievementTimer(T.SpeedKill, 2930, "TimerSpeedKill")

mod:AddBoolOption("SlagPotIcon")

function mod:OnCombatStart(delay)
	timerAchieve:Start()
	timerScorchCooldown:Start(12-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(62680, 63472) then		-- Flame Jets
		timerFlameJetsCast:Start()
		warnFlameJetsCast:Show()
		timerFlameJetsCooldown:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(62546, 63474) then	-- Scorch (SPELL_CAST_SUCCESS by Ignis)
		timerScorchCast:Start()
		timerScorchCooldown:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62717, 63477) then		-- Slag Pot
		announceSlagPot:Show(args.destName)
		timerSlagPot:Start(args.destName)
		if self.Options.SlagPotIcon then
			self:SetIcon(args.destName, 8, 10)
		end
	end
end

-- Spells
-- NPC: Ignis (all spells are SPELL_FIRE_IMMOLATION)
-- -- 63474 -- channeling
-- -- 63473 -- instant cast (deals damage)
-- -- 62546 -- channeling
-- -- 62553 -- instant cast (deals damage)
-- NPC: "Versengen" (all spells are SPELL_FIRE_FIRE)
-- -- 63475 (deals damage)
-- -- 63476 SPELL_CAST_SUCCESS
-- -- 62549 (deals damage)
-- -- 62548 SPELL_CAST_SUCCESS