local mod	= DBM:NewMod("Ahune", "DBM-WorldEvents")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5005 $"):sub(12, -3))
mod:SetCreatureID(25740)--25740 Ahune, 25755, 25756 the two types of adds

mod:RegisterCombat("say", L.Pull)
-- mod:RegisterCombat("combat")
mod:SetMinCombatTime(15)

mod:RegisterEvents(
	-- "SPELL_AURA_APPLIED",
	-- "SPELL_AURA_REMOVED",
	"CHAT_MSG_SAY",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)


local idAhune = 25740
local t_combatStart = 13.5
local pull_say_locale = {
	['Der Eisbrocken ist geschmolzen!'] = 'deDE',
	['¡La piedra de hielo se ha derretido!'] = 'esES',
	['¡La piedra de hielo se ha derretido!'] = 'esMX',
	['La pierre de glace a fondu !'] = 'frFR',
	['얼음 기둥이 녹아 내렸다!'] = 'koKR',
	['Камень Льда растаял!'] = 'ruRU',
	['寒冰之石融化了！'] = 'zhCN',
	['冰石已經溶化了!'] = 'zhTW',
	['The Ice Stone has melted!'] = 'enUS',
}


local warnSubmerged				= mod:NewAnnounce("Submerged", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnEmerged				= mod:NewAnnounce("Emerged", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

local specWarnAttack			= mod:NewSpecialWarning("specWarnAttack")

local timerCombatStart			= mod:NewTimer(t_combatStart, "TimerCombat", 2457)--rollplay for first pull
local timerEmerge				= mod:NewTimer(35, "EmergeTimer", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerSubmerge				= mod:NewTimer(90, "SubmergTimer", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")

function mod:OnCombatStart(delay)
	timerSubmerge:Start(-delay)
end

-- function mod:SPELL_AURA_APPLIED(args)
	-- start if someone causes a debuff on ahune (not perfect, but better than nothing)
	-- if args:IsSpellID(45954) then				-- Ahunes Shield
		-- warnEmerged:Show()
		-- timerSubmerge:Start()
	-- end
-- end

-- function mod:SPELL_AURA_REMOVED(args)
	-- if args:IsSpellID(45954) then				-- Ahunes Shield
		-- warnSubmerged:Show()
		-- timerEmerge:Start()
		-- specWarnAttack:Show()
	-- end
-- end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.EmoteSubmerge then
		timerSubmerge:Stop()
		warnSubmerged:Show()
		
		timerEmerge:Start()
		
		-- specWarnAttack:Show()
		self:Schedule(4.5, function() specWarnAttack:Show() end)
		
	elseif msg == L.EmoteEmergeSoon then
		-- warnEmerged:Show()
		self:Schedule(5, function() warnEmerged:Show() end)
		
		-- timerSubmerge:Start(90+5)
		self:Schedule(5, function() timerSubmerge:Start() end)
	end
end


function mod:CHAT_MSG_SAY(msg)
	if not(timerCombatStart:IsStarted()) and (msg == L.Pull or pull_say_locale[msg]) then
		timerCombatStart:Start()
		self:Schedule(t_combatStart, function() DBM:StartCombat(mod, 0) end )
	end
end

-- 'enUS','Frost Lord Ahune'
-- 'deDE','Frostfürst Ahune'
-- 'esES','Señor de la Escarcha Ahune'
-- 'esMX','Señor de la Escarcha Ahune'
-- 'frFR','Seigneur du Givre Ahune.'
-- 'koKR','서리 군주 아훈'
-- 'ruRU','Повелитель Холода Ахун'
-- 'zhCN','冰霜之王埃霍恩'
-- 'zhTW','冰霜領主艾胡恩'
