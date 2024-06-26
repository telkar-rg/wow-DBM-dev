local mod	= DBM:NewMod("GrandChampions", "DBM-Party-WotLK", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4265 $"):sub(12, -3))
mod:SetCreatureID(34657, 34701, 34702, 34703, 34705, 35569, 35570, 35571, 35572, 35617)

mod:RegisterCombat("combat")
mod:SetDetectCombatInVehicle(false)

mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL"
)

local isDispeller = select(2, UnitClass("player")) == "MAGE"
				 or select(2, UnitClass("player")) == "PRIEST"
				 or select(2, UnitClass("player")) == "SHAMAN"

local warnHealingWave		= mod:NewSpellAnnounce(68318, 2)
local warnHaste				= mod:NewTargetAnnounce(66045, 2)
local warnPolymorph			= mod:NewTargetAnnounce(66043, 1)
local warnHexOfMending		= mod:NewTargetAnnounce(67534, 1)

local specWarnPoison		= mod:NewSpecialWarningMove(68316)
local specWarnHaste			= mod:NewSpecialWarningDispel(66045, isDispeller)

local combatStart_1 		= 87
local combatStart_2 		= 27
local timerCombatStart		= mod:NewTimer(combatStart_1, "TimerCombatStart", 2457)
local combatActive

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68318, 67528) then								-- Healing Wave
		warnHealingWave:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(66045) and not args:IsDestTypePlayer() then		-- Haste
		warnHaste:Show(args.destName)
		specWarnHaste:Show(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(66043, 68311) then								-- Polymorph on <x>
		warnPolymorph:Show(args.destName)
	elseif args:IsSpellID(67534) then									-- Hex of Mending on <x>
		warnHexOfMending:Show(args.destName)
	elseif args:IsSpellID(67594, 68316) and args:IsPlayer() then		-- Standing in Poison Bottle.
		specWarnPoison:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPullAlliance or msg:find(L.YellPullAlliance) then 	-- Alliance intro timing
		timerCombatStart:Start()
		combatActive = true
	elseif msg == L.YellPullHorde or msg:find(L.YellPullHorde) then 	-- Horde intro timing
		timerCombatStart:Start()
		combatActive = true
	elseif msg == L.YellPullShort or msg:find(L.YellPullShort) then 	-- Short intro timing
		if not combatActive then
			timerCombatStart:Start(combatStart_2)
		end
		combatActive = false
	end
end

