local mod	= DBM:NewMod("ApothecaryTrio", "DBM-WorldEvents")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4181 $"):sub(12, -3))
mod:SetCreatureID(36272, 36296, 36565)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_SAY"
)

local timer1 = 10.5
local timer2 = 18.5
local timer3 = 26.5
local dt1 = 4
local dt2 = 6.5


local warnChainReaction			= mod:NewCastAnnounce(68821, 3)

local specWarnPerfumeSpill		= mod:NewSpecialWarningMove(68927)
local specWarnCologneSpill		= mod:NewSpecialWarningMove(68934)

local timerHummel				= mod:NewTimer(timer1, "HummelActive", 2457, nil, false)
local timerBaxter				= mod:NewTimer(timer2, "BaxterActive", 2457, nil, false)
local timerFrye					= mod:NewTimer(timer3, "FryeActive",   2457, nil, false)
mod:AddBoolOption("TrioActiveTimer", true, "timer")
local timerChainReaction		= mod:NewCastTimer(3, 68821)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68821) then
		warnChainReaction:Show()
		timerChainReaction:Start()
	end
end

do 
	local lastPerfspill = 0
	local lastColnspill = 0
	function mod:SPELL_DAMAGE(args)
		if args:IsSpellID(68927) and args:IsPlayer() and time() - lastPerfspill > 2 then
			specWarnPerfumeSpill:Show()
			lastPerfspill = time()
		elseif args:IsSpellID(68934) and args:IsPlayer() and time() - lastColnspill > 2 then
			specWarnCologneSpill:Show()
			lastColnspill = time()
		end
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if self.Options.TrioActiveTimer then
		if L.SayCombatStart and ( msg == L.SayCombatStart or msg:find(L.SayCombatStart) ) then
			-- Did they bother to tell you who I am and why I am doing this?
			timerHummel:Start()
			timerBaxter:Start()
			timerFrye:Start()
		elseif L.SayCombatStart2 and ( msg == L.SayCombatStart2 or msg:find(L.SayCombatStart2) ) then
			-- ...or are they just using you like they do everybody else?
			if not timerFrye:IsStarted() then
				timerHummel:Start(timer1 - dt1)
				timerBaxter:Start(timer2 - dt1)
				timerFrye:Start(timer3 - dt1)
			end
		elseif L.SayCombatStart3 and ( msg == L.SayCombatStart3 or msg:find(L.SayCombatStart3) ) then
			-- But what does it matter. It is time for this to end.
			if not timerFrye:IsStarted() then
				timerHummel:Start(timer1 - dt2)
				timerBaxter:Start(timer2 - dt2)
				timerFrye:Start(timer3 - dt2)
			end
		end
	end
end