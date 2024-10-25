﻿local mod	= DBM:NewMod("Anub'arak_Coliseum", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5011 $"):sub(12, -3))
mod:SetCreatureID(34564)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

mod:SetUsedIcons(3, 4, 5, 6, 7, 8)

-- [[ ANNOUNCE ]] --
-- [ P1 ]
-- Adds
local warnAdds				= mod:NewAnnounce("warnAdds", 3, 45419)

-- [ P2 ]
mod:AddAnnounceSpacer()
-- Pursue
local warnPursue			= mod:NewTargetAnnounce(67574, 4)
local specWarnPursue		= mod:NewSpecialWarning("SpecWarnPursue")
local warnHoP				= mod:NewTargetAnnounce(10278, 2, nil, false)--Heroic strat revolves around kiting pursue and using Hand of Protection.
-- Emerge
local warnEmerge			= mod:NewAnnounce("WarnEmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnEmergeSoon		= mod:NewAnnounce("WarnEmergeSoon", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
-- Submerge
local warnSubmerge			= mod:NewAnnounce("WarnSubmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnSubmergeSoon		= mod:NewAnnounce("WarnSubmergeSoon", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local specWarnSubmergeSoon	= mod:NewSpecialWarning("specWarnSubmergeSoon", mod:IsTank())

-- [ P3 ]
mod:AddAnnounceSpacer()
-- Pursue
local warnPhase3			= mod:NewPhaseAnnounce(3)
local specWarnPCold			= mod:NewSpecialWarningYou(68510, false)
-- Freezing Slash
local warnFreezingSlash		= mod:NewTargetAnnounce(66012, 2, nil, mod:IsHealer() or mod:IsTank())
local specWarnShadowStrike	= mod:NewSpecialWarning("SpecWarnShadowStrike", mod:IsTank())
-- Shadow Strike
local preWarnShadowStrike	= mod:NewSoonAnnounce(66134, 3)
local warnShadowStrike		= mod:NewSpellAnnounce(66134, 4)


-- [[ TIMER ]] --
-- Phases
local enrageTimer			= mod:NewBerserkTimer(570)  -- 9:30 ? hmpf (no enrage while submerged... this sucks)

-- [ P1 ]
mod:AddTimerSpacer()
-- Adds
local timerAdds				= mod:NewTimer(45, "timerAdds", 45419)

-- [ P2 ]
mod:AddTimerSpacer()
-- Pursue
local timerHoP				= mod:NewBuffActiveTimer(10, 10278, nil, false)  --So we will track bops to make this easier.
-- Emerge
local timerEmerge			= mod:NewTimer(65, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
-- Submerge
local timerSubmerge			= mod:NewTimer(75, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")

-- [ P3 ]
mod:AddTimerSpacer()
-- Penetrating Cold
local timerPCold			= mod:NewBuffActiveTimer(15, 68509)
-- Freezing Slash
local timerFreezingSlash	= mod:NewCDTimer(20, 66012, nil, mod:IsHealer() or mod:IsTank())
-- Shadow Strike
local timerShadowStrike		= mod:NewNextTimer(30.5, 66134)
-- Shadow Strike stuns
-- local stunTimer = mod:NewTimer(30, "Stun Adds!") 	-- stunTimer REMOVAL


-- [[ MISC ]] --
-- [ P2 ]
mod:AddOptionSpacer()
-- Pursue
mod:AddBoolOption("PursueIcon")
mod:AddBoolOption("PlaySoundOnPursue")

-- [ P3 ]
mod:AddOptionSpacer()
-- Penetrating Cold
mod:AddBoolOption("SetIconsOnPCold", true)
mod:AddBoolOption("AnnouncePColdIcons", mod:IsHealer())
mod:AddBoolOption("AnnouncePColdIconsRemoved", false)
-- Freezing Slash
mod:AddBoolOption("yellFreezingSlash", true)
-- Stunning Adds
-- local TTSstun = mod:NewSoundFile("Interface\\AddOns\\DBM-Core\\sounds\\stunIn3.mp3", "TTS stun countdown", true) 	-- stunTimer REMOVAL
-- mod:AddBoolOption("BroadcastStunTimer", true) 	-- stunTimer REMOVAL
-- Remove Stamina Buffs in P3
mod:AddBoolOption("RemoveHealthBuffsInP3", false)



local stunTTSOffset = 4.87

local instanceMode, instanceSize = "normal", 10


function mod:OnCombatStart(delay)
	instanceMode, instanceSize = self:GetModeSize()
	
	timerAdds:Start(10-delay)
	warnAdds:Schedule(10-delay)
	self:ScheduleMethod(10-delay, "Adds")
	warnSubmergeSoon:Schedule(70-delay)
	specWarnSubmergeSoon:Schedule(70-delay)
	timerSubmerge:Start(80-delay)
	enrageTimer:Start(-delay)
	timerFreezingSlash:Start(-delay)
	if (instanceMode == "heroic") then
		-- Does not work on warmane, use "Stun Adds!" timer instead
		-- timerShadowStrike:Start()
		-- preWarnShadowStrike:Schedule(25.5-delay)
		-- self:ScheduleMethod(30.5-delay, "ShadowStrike")
		-- self:nextStunTimer() 	-- stunTimer REMOVAL
	end
end

-- function mod:nextStunTimer(duration) 	-- stunTimer REMOVAL
	-- local duration = duration or 30
	-- self:UnscheduleMethod("nextStunTimer")
	-- stunTimer:Cancel()
	-- TTSstun:Cancel()
	-- if self.Options.BroadcastStunTimer then
		-- DBM:CreatePizzaTimer(duration, "Stun Adds!", true)
	-- end
	-- stunTimer:Start(duration)
	-- TTSstun:Schedule(duration-stunTTSOffset)
	-- self:ScheduleMethod(duration, "nextStunTimer")
-- end

--[[ old implementation
-- set/reset on combatstart/combatend
local stunCount = 0
local stunTimerValues = {30, 30, 115, 30, 115, 30} -- for 2xburrow kill
function mod:nextStunTimer()
	self:UnscheduleMethod("nextStunTimer")
	-- keep using the last when list exhausted
	if stunCount < #stunTimerValues then
		stunCount = stunCount + 1
	end
	local duration = stunTimerValues[stunCount]
	if self.Options.BroadcastStunTimer then
		DBM:CreatePizzaTimer(duration, "Stun Adds!", true)
	end
	stunTimer:Start(duration)
	TTSstun:Schedule(duration-stunTTSOffset)
	self:ScheduleMethod(duration, "nextStunTimer")
end
--]]

--[[ older implementation
function mod:nextStunTimer()
	self:UnscheduleMethod("nextStunTimer")
	local duration = stunTimerValues[1+(stunCount % #stunTimerValues)]
	if self.Options.BroadcastStunTimer then
		DBM:CreatePizzaTimer(duration, "Stun Adds!", true)
	end
	stunTimer:Start(duration)
	TTSstun:Schedule(duration-stunTTSOffset)
	self:ScheduleMethod(duration, "nextStunTimer")
	stunCount = stunCount + 1
end
--]]

function mod:OnCombatEnd()
	-- self:UnscheduleMethod("nextStunTimer") 	-- stunTimer REMOVAL
	-- stunTimer:Stop() 	-- stunTimer REMOVAL
	-- TTSstun:Cancel() 	-- stunTimer REMOVAL
end

function mod:Adds()
	if self:IsInCombat() then
		timerAdds:Start()
		warnAdds:Schedule(45)
		self:ScheduleMethod(45, "Adds")
	end
end

function mod:ShadowStrike()
	if self:IsInCombat() then
		timerShadowStrike:Start()
		preWarnShadowStrike:Cancel()
		preWarnShadowStrike:Schedule(25.5)
		self:UnscheduleMethod("ShadowStrike")
		self:ScheduleMethod(30.5, "ShadowStrike")
	end
end

local PColdTargets = {}
do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(UnitName(v1)) < DBM:GetRaidSubgroup(UnitName(v2))
	end
	function mod:SetPcoldIcons()
		if DBM:GetRaidRank() > 0 then
			table.sort(PColdTargets, sort_by_group)
			local PColdIcon = 7
			for i, v in ipairs(PColdTargets) do
				if self.Options.AnnouncePColdIcons then
					SendChatMessage(L.PcoldIconSet:format(PColdIcon, UnitName(v)), "RAID")
				end
				self:SetIcon(UnitName(v), PColdIcon)
				PColdIcon = PColdIcon - 1
			end
			table.wipe(PColdTargets)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(67574) then			-- Pursue
		if args:IsPlayer() then
			specWarnPursue:Show()
			if self.Options.PlaySoundOnPursue then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
		if self.Options.PursueIcon then
			self:SetIcon(args.destName, 8, 15)
		end
		warnPursue:Show(args.destName)
	elseif args:IsSpellID(66013, 67700, 68509, 68510) then		-- Penetrating Cold
		if args:IsPlayer() then
			specWarnPCold:Show()
		end
		if self.Options.SetIconsOnPCold then
			table.insert(PColdTargets, DBM:GetRaidUnitId(args.destName))
			if ((instanceSize == 25) and #PColdTargets >= 5) or ((instanceSize == 10) and #PColdTargets >= 2) then
				self:SetPcoldIcons()--Sort and fire as early as possible once we have all targets.
			end
		end
		timerPCold:Show()
	elseif args:IsSpellID(66012) then							-- Freezing Slash
		warnFreezingSlash:Show(args.destName)
		timerFreezingSlash:Start()
	elseif args:IsSpellID(10278) and self:IsInCombat() then		-- Hand of Protection
		warnHoP:Show(args.destName)
		timerHoP:Start(args.destName)
	end
end

mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(66013, 67700, 68509, 68510) then			-- Penetrating Cold
		mod:SetIcon(args.destName, 0)
		if (self.Options.AnnouncePColdIcons and self.Options.AnnouncePColdIconsRemoved) and DBM:GetRaidRank() >= 1 then
			SendChatMessage(L.PcoldIconRemoved:format(args.destName), "RAID")
		end
	elseif args:IsSpellID(10278) and self:IsInCombat() then		-- Hand of Protection
		timerHoP:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66118, 67630, 68646, 68647) then			-- Swarm (start p3)
		warnPhase3:Show()
		warnEmergeSoon:Cancel()
		warnSubmergeSoon:Cancel()
		specWarnSubmergeSoon:Cancel()
		timerEmerge:Stop()
		timerSubmerge:Stop()
		if self.Options.RemoveHealthBuffsInP3 then
			mod:ScheduleMethod(0.1, "RemoveBuffs")
		end
		if (instanceMode == "normal") then
			timerAdds:Cancel()
			warnAdds:Cancel()
			self:UnscheduleMethod("Adds")
		end
	--elseif args:IsSpellID(66134) then							-- Shadow Strike
		-- Does not work on warmane, use "Stun Adds!" timer instead
		-- self:ShadowStrike()
		-- specWarnShadowStrike:Show()
		-- warnShadowStrike:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg and msg:find(L.Burrow) then
		timerAdds:Cancel()
		warnAdds:Cancel()
		warnSubmerge:Show()
		warnEmergeSoon:Schedule(55)
		timerEmerge:Start()
		timerFreezingSlash:Stop()
		-- self:nextStunTimer(95)

		timerAdds:Start(75)
		warnAdds:Schedule(75)
		self:UnscheduleMethod("Adds")
		self:ScheduleMethod(75, "Adds")
		warnSubmergeSoon:Schedule(130)
		specWarnSubmergeSoon:Schedule(55)
		timerSubmerge:Schedule(65)
	end
end

function mod:RemoveBuffs()
	CancelUnitBuff("player", (GetSpellInfo(47440)))		-- Commanding Shout
	CancelUnitBuff("player", (GetSpellInfo(48161)))		-- Power Word: Fortitude
	CancelUnitBuff("player", (GetSpellInfo(48162)))		-- Prayer of Fortitude
	CancelUnitBuff("player", (GetSpellInfo(69377)))		-- Runescroll of Fortitude
end

