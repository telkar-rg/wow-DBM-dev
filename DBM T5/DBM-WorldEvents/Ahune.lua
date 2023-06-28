local mod	= DBM:NewMod("Ahune", "DBM-WorldEvents")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4198 $"):sub(12, -3))
mod:SetCreatureID(25740)--25740 Ahune, 25755, 25756 the two types of adds

mod:RegisterCombat("say", L.Pull)
mod:RegisterCombat("combat")
mod:SetMinCombatTime(15)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	-- "SPELL_AURA_REMOVED",
	-- "CHAT_MSG_SAY",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

-- fix for different language clients in grp
-- local combatStartYell = {
	-- ["The Ice Stone has melted!"] = "enUS",
	-- ["Der Eisbrocken ist geschmolzen!"] = "deDE",
	-- ["¡La piedra de hielo se ha derretido!"] = "esES",
	-- ["¡La piedra de hielo se ha derretido!"] = "esMX",
	-- ["La pierre de glace a fondu !"] = "frFR",
	-- ["얼음 기둥이 녹아 내렸다!"] = "koKR",
	-- ["Камень Льда растаял!"] = "ruRU",
	-- ["寒冰之石融化了！"] = "zhCN",
	-- ["冰石已經溶化了!"] = "zhTW",
-- }
-- local last_summon = 0

local debug_t_start = 0
local debug_t_combat = 0
local debug_t = 0


local idAhune = 25740
local t_combatStart = 13.5

local warnSubmerged				= mod:NewAnnounce("Submerged", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnEmerged				= mod:NewAnnounce("Emerged", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

local specWarnAttack			= mod:NewSpecialWarning("specWarnAttack")

local timerCombatStart			= mod:NewTimer(t_combatStart, "TimerCombat", 2457)--rollplay for first pull
local timerEmerge				= mod:NewTimer(35, "EmergeTimer", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerSubmerge				= mod:NewTimer(90, "SubmergTimer", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")

function mod:OnCombatStart(delay)
	debug_t_combat = GetTime()
	print("--AHUNE--", "mod:OnCombatStart(delay)", delay, debug_t_combat)
	ChatFrame3:AddMessage( format("OnCombatStart - %.3f - (%.3f)", debug_t_combat, debug_t_combat-debug_t_start) )
	
	-- timerCombatStart:Start(-delay)
	timerSubmerge:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if not self:IsInCombat() and (args:GetDestCreatureID() == idAhune) then
		DBM:StartCombat(mod, 0)
	end
	-- if args:IsSpellID(45954) then				-- Ahunes Shield
		-- warnEmerged:Show()
		-- timerSubmerge:Start()
	-- end
end

-- function mod:SPELL_AURA_REMOVED(args)
	-- if args:IsSpellID(45954) then				-- Ahunes Shield
		-- warnSubmerged:Show()
		-- timerEmerge:Start()
		-- specWarnAttack:Show()
	-- end
-- end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.EmoteSubmerge then
		warnSubmerged:Show()
		timerEmerge:Start()
		self:Schedule(4.5, function() specWarnAttack:Show() end)
		-- specWarnAttack:Show()
		-- print("--AHUNE--", "mod:CHAT_MSG_SAY(msg)", "msg == L.EmoteSubmerge")
		debug_t = GetTime()
		ChatFrame3:AddMessage( format("EmoteSubmerge - %.3f - (%.3f)", debug_t, debug_t-debug_t_combat) )
		
	elseif msg == L.EmoteEmergeSoon then
		-- warnEmerged:Show()
		self:Schedule(5, function() warnEmerged:Show() end)
		
		-- timerSubmerge:Start(90+5)
		self:Schedule(5, function() timerSubmerge:Start() end)
		-- print("--AHUNE--", "mod:CHAT_MSG_SAY(msg)", "msg == L.EmoteEmergeSoon")
		debug_t = GetTime()
		ChatFrame3:AddMessage( format("EmoteSubmerge - %.3f - (%.3f)", debug_t, debug_t-debug_t_combat) )
	end
end

function mod:CHAT_MSG_SAY(msg)
	-- if msg == L.Pull or combatStartYell[msg] then
		-- if time() > last_summon then
			-- last_summon = time()+60
			
			-- timerCombatStart:Start()
			-- -- self:Schedule(t_combatStart, DBM.StartCombat, DBM, self, 0)
			-- -- DBM:StartCombat(mod, 0)
			
			-- print("--AHUNE--", "mod:CHAT_MSG_SAY(msg) - msg == L.Pull", GetTime())
			-- ChatFrame3:AddMessage(format("CHAT_MSG_SAY(msg) - msg == L.Pull - %.3f", GetTime()))
			-- debug_t_start = GetTime()
		-- end
	-- end
	-- print(self)
end