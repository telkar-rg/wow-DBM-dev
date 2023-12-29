local mod	= DBM:NewMod("Razorscale", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4133 $"):sub(12, -3))
mod:SetCreatureID(33186)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")
mod:RegisterCombat("yell", L.YellExtinguish)
-- mod:RegisterCombat("yell", L.YellAggro) -- this doesnt work because after 8s timeout for combat

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	-- "UNIT_TARGET",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local castFlames
local t_aggroYell = 0
local razorStart = false
-- the timers in the first round (after aggroing) are a bit longer
local c_firstRound = 38
-- these are the timers AFTER the first round
local c_timerTurret1 = 31
local c_timerTurret2 = 51
local c_timerTurret3 = 71
local c_timerTurret4 = 91


local warnTurretsReadySoon			= mod:NewAnnounce("warnTurretsReadySoon", 1, 48642)
local warnTurretsReady				= mod:NewAnnounce("warnTurretsReady", 3, 48642)
-- local warnDevouringFlameCast		= mod:NewAnnounce("WarnDevouringFlameCast", 2, 64733, false, "OptionDevouringFlame") -- new option is just a work-around...the saved variable handling will be updated to allow changing and updating default values soon

local specWarnDevouringFlame		= mod:NewSpecialWarningMove(64733)
local specWarnDevouringFlameCast	= mod:NewSpecialWarning("SpecWarnDevouringFlameCast")

local enrageTimer					= mod:NewBerserkTimer(900)
local timerDeepBreathCooldown		= mod:NewCDTimer(21, 64021)
local timerDeepBreathCast			= mod:NewCastTimer(2.5, 64021)
local timerTurret1					= mod:NewTimer(c_timerTurret1, "timerTurret1", 48642)
local timerTurret2					= mod:NewTimer(c_timerTurret2, "timerTurret2", 48642)
local timerTurret3					= mod:NewTimer(c_timerTurret3, "timerTurret3", 48642)
local timerTurret4					= mod:NewTimer(c_timerTurret4, "timerTurret4", 48642)
local timerGrounded                 = mod:NewTimer(45, "timerGrounded")

-- mod:AddBoolOption("PlaySoundOnDevouringFlame", false)
local soundDevouringFlame = mod:NewSound(64733, DBM_CORE_AUTO_SOUND_OPTION_TEXT_YOU:format(64733))


function mod:OnCombatStart(delay)
	local t_OnCombatStart = GetTime() - t_aggroYell
	local t_diff = c_firstRound - delay - t_OnCombatStart
	
	-- stop if we have not seen the aggro yell in the last 60s
	if not t_OnCombatStart or t_OnCombatStart < 0 or t_OnCombatStart > 60 then return end
	
	enrageTimer:Start(-delay)
	
	-- turret timers in first round are longer then in the following rounds
	if mod:IsDifficulty("heroic10") then
		timerTurret1:Start(c_timerTurret1 + t_diff)
		timerTurret2:Start(c_timerTurret2 + t_diff)
		
		warnTurretsReadySoon:Schedule(c_timerTurret1 + t_diff)
		warnTurretsReady:Schedule(c_timerTurret2 + t_diff)
	else
		timerTurret1:Start(c_timerTurret1 + t_diff)
		timerTurret2:Start(c_timerTurret2 + t_diff)
		timerTurret3:Start(c_timerTurret3 + t_diff)
		timerTurret4:Start(c_timerTurret4 + t_diff)
		
		warnTurretsReadySoon:Schedule(c_timerTurret3 + t_diff)
		warnTurretsReady:Schedule(c_timerTurret4 + t_diff)
	end
	
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(64733, 64704) and args:IsPlayer() then
		specWarnDevouringFlame:Show()
		-- if self.Options.PlaySoundOnDevouringFlame then
			-- PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		-- end		
		soundDevouringFlame:Play()
	end
end


function mod:CHAT_MSG_RAID_BOSS_EMOTE(emote)
	if emote == L.EmotePhase2 or emote:find(L.EmotePhase2) then
		-- phase2
		timerTurret1:Stop()
		timerTurret2:Stop()
		timerTurret3:Stop()
		timerTurret4:Stop()
		timerGrounded:Stop()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, mob)
	-- print("-- --","CHAT_MSG_MONSTER_YELL", GetTime()-t_aggroYell, "\n"..msg)
	
	
	
	if msg == L.YellExtinguish then
		if razorStart then
			-- skip on aggro (first time harpunes are handled differently)
			razorStart = false
		else
			if mod:IsDifficulty("heroic10") then -- not sure?
				timerTurret1:Start()
				timerTurret2:Start()
				warnTurretsReadySoon:Schedule(c_timerTurret1)
				warnTurretsReady:Schedule(c_timerTurret2)
			else
				timerTurret1:Start()
				timerTurret2:Start()
				timerTurret3:Start()
				timerTurret4:Start()
				warnTurretsReadySoon:Schedule(c_timerTurret3)
				warnTurretsReady:Schedule(c_timerTurret4)
			end
		end

	elseif msg == L.YellGround then
		timerGrounded:Start()
		
	elseif msg == L.YellAggro then
		razorStart = true
		t_aggroYell = GetTime()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(64021) then	-- deep breath
		timerDeepBreathCast:Start()
		timerDeepBreathCooldown:Start()
	elseif args:IsSpellID(63236) then
		local target = self:GetBossTarget(self.creatureId)
		if target then
			self:CastFlame(target)
		else
			castFlames = GetTime()
		end
	end
end

-- function mod:UNIT_TARGET(unit)	-- I think this is useless, why would anyone in the raid target razorflame right after the flame stuff?
	-- if castFlames and GetTime() - castFlames <= 1 and self:GetUnitCreatureId(unit.."target") == self.creatureId then
		-- local target = UnitName(unit.."targettarget")
		-- if target then
			-- self:CastFlame(target)
		-- else
			-- self:CastFlame(L.FlamecastUnknown)
		-- end
		-- castFlames = false
	-- end
-- end 

function mod:CastFlame(target)
	warnDevouringFlameCast:Show(target)
	if target == UnitName("player") then
		specWarnDevouringFlameCast:Show()
	end
	self:SetIcon(target, 8, 9)
end 