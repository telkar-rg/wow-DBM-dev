﻿local mod	= DBM:NewMod("Algalon", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

--[[
--
--  Thanks to  Apathy @ Vek'nilash  who provided us with Informations and Combatlog about Algalon
--
--]]


mod:SetRevision(("$Revision: 5001 $"):sub(12, -3))
mod:SetCreatureID(32871)
mod:SetUsedIcons(3, 4, 5, 6, 7, 8)

mod:RegisterCombat("yell", L.YellPull)
mod:RegisterKill("yell", L.YellKill)
mod:SetWipeTime(20)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH",
	"CHAT_MSG_TARGETICONS",
	"UPDATE_MOUSEOVER_UNIT",
	"PLAYER_TARGET_CHANGED"
)

local announceBigBang			= mod:NewSpellAnnounce(64584, 4)
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnPhase2Soon			= mod:NewAnnounce("WarnPhase2Soon", 2)
local announcePreBigBang		= mod:NewPreWarnAnnounce(64584, 10, 3)
local announceBlackHole			= mod:NewSpellAnnounce(65108, 2)
local announceCosmicSmash		= mod:NewAnnounce("WarningCosmicSmash", 3, 62311)
local announcePhasePunch		= mod:NewAnnounce("WarningPhasePunch", 4, 64412, mod:IsHealer() or mod:IsTank())

local specwarnStarLow			= mod:NewSpecialWarning("warnStarLow", mod:IsHealer() or mod:IsTank())
local specWarnPhasePunch		= mod:NewSpecialWarningStack(64412, nil, 4)
local specWarnBigBang			= mod:NewSpecialWarningSpell(64584)
local specWarnCosmicSmash		= mod:NewSpecialWarningSpell(62311)

local timerCombatStart		    = mod:NewTimer(7, "TimerCombatStart", 2457)
local enrageTimer				= mod:NewBerserkTimer(360)
local timerNextBigBang			= mod:NewNextTimer(90.5, 64584)
local timerBigBangCast			= mod:NewCastTimer(8, 64584)
local timerNextCollapsingStar	= mod:NewTimer(15, "NextCollapsingStar")
local timerCDCosmicSmash		= mod:NewTimer(25, "PossibleNextCosmicSmash")
local timerCastCosmicSmash		= mod:NewCastTimer(4.5, 62311)
local timerPhasePunch			= mod:NewBuffActiveTimer(45, 64412)
local timerNextPhasePunch		= mod:NewNextTimer(16, 64412)

mod:AddBoolOption("SetIconOnCollapsingStar", true)

local warned_preP2 = false
local warned_star = false

local table_icon = {8,7,6,5,4,3}
local table_iconMAX,table_iconMIN = 8,3
local table_stars_uId = {}
-- local table_stars_icons = {}
-- local table_stars_GuidIcon = {}
-- local table_stars_IconGuid = {}

function mod:OnCombatStart(delay)
	warned_preP2 = false
	warned_star = false
	table_icon = {8,7,6,5,4,3}
	wipe(table_stars_uId)
	-- wipe(table_stars_GuidIcon)
	-- wipe(table_stars_IconGuid)
	
	local text = select(3, GetWorldStateUIInfo(1)) 
	local _, _, time = string.find(text, L.PullCheck)
	if not time then 
        	time = 60 
    	end
	time = tonumber(time)
	if time == 60 then
		timerCombatStart:Start(26.5-delay)
		self:ScheduleMethod(26.5-delay, "startTimers")	-- 26 seconds roleplaying
	else 
		timerCombatStart:Start(-delay)
		self:ScheduleMethod(7-delay, "startTimers")	-- 7 seconds roleplaying
	end 
end

function mod:startTimers()
	enrageTimer:Start()
	timerNextBigBang:Start()
	announcePreBigBang:Schedule(80)
	timerCDCosmicSmash:Start()
	timerNextCollapsingStar:Start()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(64584, 64443) then 	-- Big Bang
		timerBigBangCast:Start()
		timerNextBigBang:Start()
		announceBigBang:Show()
		announcePreBigBang:Schedule(80)
		specWarnBigBang:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(65108, 64122) then 	-- Black Hole Explosion
		announceBlackHole:Show()
		warned_star = false
	elseif args:IsSpellID(64598, 62301) then	-- Cosmic Smash (those are the actual spells cast by Alga)
		timerCastCosmicSmash:Start()
		timerCDCosmicSmash:Start()
		announceCosmicSmash:Show()
		specWarnCosmicSmash:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(64412) then
		timerNextPhasePunch:Start()
		local amount = args.amount or 1
		if args:IsPlayer() and amount >= 4 then
			specWarnPhasePunch:Show(args.amount)
		end
		timerPhasePunch:Start(args.destName)
		announcePhasePunch:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED


function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Emote_CollapsingStar or msg:find(L.Emote_CollapsingStar) then
		timerNextCollapsingStar:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase2 or msg:find(L.Phase2) then
		timerNextCollapsingStar:Cancel()
		warnPhase2:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_preP2 and self:GetUnitCreatureId(uId) == 32871 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.23 then
		warned_preP2 = true
		warnPhase2Soon:Show()
	elseif not warned_star and self:GetUnitCreatureId(uId) == 32955 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.25 then
		warned_star = true
		specwarnStarLow:Show()
	end
end


function mod:CHAT_MSG_TARGETICONS(msg)
	local _,_, rt = strfind(msg, "RaidTargetingIcon_(%d)")
	if not rt then return end
	rt = tonumber(rt)
	if not rt then return end
	
	mod:iconUsed(rt)
end



function mod:iconUsed(rt)
	if not rt then return end
	
	local isRemove
	for k,v in pairs(table_icon) do
		if v==rt then
			table.remove(table_icon, k)
			isRemove = 1
			break
		end
	end
	if isRemove then
		table.insert(table_icon, rt)
		-- print("-- RT", rt, "used", "--", strjoin(",", tostringall( unpack(table_icon) )))
	end
end



mod:RegisterOnUpdateHandler(function(self, elapsed)
	if not self:IsInCombat() then return end
	
	if DBM.Options.DontSetIcons then return end
	if DBM:GetRaidRank() == 0 then return end
	if not(self.Options.SetIconOnCollapsingStar) then return end
	
	local guid, rt
	wipe(table_stars_uId)
	-- wipe(table_stars_icons)
	
	-- get all stars in raid targets
	for i = 1, GetNumRaidMembers() do
		local uId = "raid"..i.."target"
		if self:GetUnitCreatureId(uId) == 32955 then
			guid = UnitGUID(uId)
			table_stars_uId[guid] = uId
			break
		end
	end
	
	-- get all current icons on stars
	for guid, uId in pairs(table_stars_uId) do
		-- time_left = 100 * UnitHealth(uId) / UnitHealthMax(uId) + 1
		rt = GetRaidTargetIndex(uId)
		if rt and rt > 0 then
			mod:iconUsed(rt)
		end
	end
	
	-- set remaining icons on stars
	for guid, uId in pairs(table_stars_uId) do
		rt = GetRaidTargetIndex(uId)
		if not rt or rt == 0 then
			rt=table_icon[1]
			SetRaidTarget(uId, rt)
			mod:iconUsed(rt)
		end
	end
	
end, (1+random()) )

