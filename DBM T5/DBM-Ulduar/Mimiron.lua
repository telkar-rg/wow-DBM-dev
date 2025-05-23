local mod	= DBM:NewMod("Mimiron", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4338 $"):sub(12, -3))
mod:SetCreatureID(33432)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("yell", L.YellPull)
mod:RegisterCombat("yell", L.YellComputerHM)
-- mod:RegisterCombat("yell", L.YellHardPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_CHANNEL_STOP",
	"CHAT_MSG_LOOT",
	"SPELL_SUMMON"
)

local c_timerPullP1 = 17.2
local c_timerPullP1HM = 21.5
local c_timerP1toP2 = 43
local c_timerP2toP3 = 32
local c_timerP3toP4 = 25

local c_timerFirstFlames = 6.0
local c_timerNextFlames = 28
local c_timerNextFlamesP4 = 28 	-- 18 -- it was measures to be 28s on 2023 07 13
local c_timerFlameSuppressantP1 = 83.5	-- spell=64570 -- from yell
local c_timerFirstShockblastP1 	= 43.5	-- spell=63631 -- from yell
local c_timerPlasmaBlastPull 	= 32	-- spell=64529 -- from yell
local c_timerPlasmaBlastPullHM 	= 36.5


local blastWarn					= mod:NewTargetAnnounce(64529, 4)
local shellWarn					= mod:NewTargetAnnounce(63666, 2)
local lootannounce				= mod:NewAnnounce("MagneticCore", 1)
local warnBombSpawn				= mod:NewAnnounce("WarnBombSpawn", 3)
local warnFrostBomb				= mod:NewSpellAnnounce(64623, 3)
local warnPlasmaBlastSoon		= mod:NewAnnounce("WarnPlasmaBlastSoon", 3, 64529, mod:IsTank() or mod:IsHealer())

local warnShockBlast			= mod:NewSpecialWarning("WarningShockBlast", nil, false)
mod:AddBoolOption("ShockBlastWarningInP1", mod:IsMelee(), "announce")
mod:AddBoolOption("ShockBlastWarningInP4", mod:IsMelee(), "announce")
local warnDarkGlare				= mod:NewSpecialWarningSpell(63293)

local enrage 					= mod:NewBerserkTimer(900)
local timerHardmode				= mod:NewTimer(603, "TimerHardmode", 64582)
local timerPullP1				= mod:NewTimer(c_timerPullP1, "TimeToPhase1")
local timerP1toP2				= mod:NewTimer(c_timerP1toP2, "TimeToPhase2")
local timerP2toP3				= mod:NewTimer(c_timerP2toP3, "TimeToPhase3")
local timerP3toP4				= mod:NewTimer(c_timerP3toP4, "TimeToPhase4")
local timerProximityMines		= mod:NewNextTimer(35, 63027)
local timerShockBlast			= mod:NewCastTimer(63631)
local timerSpinUp				= mod:NewCastTimer(4, 63414)
local timerDarkGlareCast		= mod:NewCastTimer(10, 63274)
local timerNextDarkGlare		= mod:NewNextTimer(41, 63274)
local timerNextShockblast		= mod:NewNextTimer(34, 63631)
local timerPlasmaBlastCD		= mod:NewCDTimer(30, 64529)
local timerShell				= mod:NewBuffActiveTimer(6, 63666)
local timerFlameSuppressant		= mod:NewNextTimer(62, 64570)
local timerNextFlameSuppressant	= mod:NewNextTimer(10, 65192)
local timerNextFlames			= mod:NewNextTimer(c_timerNextFlames, 64566)
local timerNextFrostBomb        = mod:NewNextTimer(30, 64623)
local timerBombExplosion		= mod:NewCastTimer(15, 65333)

mod:AddBoolOption("PlaySoundOnShockBlast", isMelee)
mod:AddBoolOption("PlaySoundOnDarkGlare", true)
mod:AddBoolOption("HealthFramePhase4", true)
mod:AddBoolOption("AutoChangeLootToFFA", true)
mod:AddBoolOption("SetIconOnNapalm", true)
mod:AddBoolOption("SetIconOnPlasmaBlast", true)
mod:AddBoolOption("RangeFrame")

local hardmode = false
local phase						= 0 
local lootmethod, masterlooterRaidID

local spinningUp				= GetSpellInfo(63414)
local lastSpinUp				= 0
local is_spinningUp				= false
local napalmShellTargets = {}
local napalmShellIcon 	= 7

local function warnNapalmShellTargets()
	shellWarn:Show(table.concat(napalmShellTargets, "<, >"))
	table.wipe(napalmShellTargets)
	napalmShellIcon = 7
end

function mod:OnCombatStart(delay)
    hardmode = false
	enrage:Start(-delay)
	timerPullP1:Start(-delay)
	
	phase = 0
	is_spinningUp = false
	napalmShellIcon = 7
	table.wipe(napalmShellTargets)
	self:NextPhase()
	timerPlasmaBlastCD:Start(c_timerPlasmaBlastPull - delay)
	if DBM:GetRaidRank() == 2 then
		lootmethod, _, masterlooterRaidID = GetLootMethod()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
	DBM.BossHealth:Hide()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
		if masterlooterRaidID then
			SetLootMethod(lootmethod, "raid"..masterlooterRaidID)
		else
			SetLootMethod(lootmethod)
		end
	end
end

function mod:Flames()
	if phase == 4 then
		-- timerNextFlames:Start(-c_timerNextFlames + c_timerNextFlamesP4)
		timerNextFlames:Start(c_timerNextFlamesP4)
		self:ScheduleMethod(c_timerNextFlamesP4, "Flames")
	else
		timerNextFlames:Start()
		self:ScheduleMethod(c_timerNextFlames, "Flames")
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(63811) then -- Bomb Bot
		warnBombSpawn:Show()
	end
end


function mod:UNIT_SPELLCAST_CHANNEL_STOP(unit, spell)
	if spell == spinningUp and GetTime() - lastSpinUp < 3.9 then
		is_spinningUp = false
		self:SendSync("SpinUpFail")
	end
end

function mod:CHAT_MSG_LOOT(msg)
	-- DBM:AddMsg(msg) --> Meridium receives loot: [Magnetic Core]
	local player, itemID = msg:match(L.LootMsg)
	if player and itemID and tonumber(itemID) == 46029 then
		lootannounce:Show(player)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(63631) then
		if phase == 1 and self.Options.ShockBlastWarningInP1 or phase == 4 and self.Options.ShockBlastWarningInP4 then
			warnShockBlast:Show()
		end
		timerShockBlast:Start()
		timerNextShockblast:Start()
		if self.Options.PlaySoundOnShockBlast then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
	if args:IsSpellID(64529, 62997) then -- plasma blast
		timerPlasmaBlastCD:Start()
		warnPlasmaBlastSoon:Show()
		
		-- 0x8517	34071
		local targetname = self:GetBossTarget(34071)
	end
	-- if args:IsSpellID(64570) then	-- "Flame Suppressant" is only cast ONCE, and not after it has been cast
		-- timerFlameSuppressant:Start()
	-- end
	if args:IsSpellID(64623) then
		warnFrostBomb:Show()
		timerBombExplosion:Start()
		timerNextFrostBomb:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(63666, 65026) and args:IsDestTypePlayer() then -- Napalm Shell
		napalmShellTargets[#napalmShellTargets + 1] = args.destName
		timerShell:Start()
		if self.Options.SetIconOnNapalm then
			if napalmShellIcon > 0 then 	-- only when we have raidtargets left
				self:SetIcon(args.destName, napalmShellIcon, 6)
				napalmShellIcon = napalmShellIcon - 1
			end
		end
		self:Unschedule(warnNapalmShellTargets)
		self:Schedule(0.3, warnNapalmShellTargets)
	elseif args:IsSpellID(64529, 62997) then -- Plasma Blast
		blastWarn:Show(args.destName)
		if self.Options.SetIconOnPlasmaBlast then
			self:SetIcon(args.destName, 8, 6)
		end
	end
end

local function show_warning_for_spinup()
	if is_spinningUp then
		warnDarkGlare:Show()
		if mod.Options.PlaySoundOnDarkGlare then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(63027) then				-- mines
		timerProximityMines:Start()

	elseif args:IsSpellID(63414) then			-- Spinning UP (before Dark Glare)
		is_spinningUp = true
		timerSpinUp:Start()
		timerDarkGlareCast:Schedule(4)
		timerNextDarkGlare:Schedule(19)			-- 4 (cast spinup) + 15 sec (cast dark glare)
		DBM:Schedule(0.15, show_warning_for_spinup)	-- wait 0.15 and then announce it, otherwise it will sometimes fail
		lastSpinUp = GetTime()
	
	elseif args:IsSpellID(65192) then
		timerNextFlameSuppressant:Start()
		
	elseif args:IsSpellID(64582) then	-- Emergency Mode (Hard Mode Buff)
		-- when this buff is applied to "Leviathan Mk II" then it is no longer invulnerable
		-- start timer for "Flame Suppressant" (62s after "Leviathan Mk II" becomes vulnerable)
		
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 33432 or cid == 34071 then	-- if "Leviathan Mk II" ID
			timerFlameSuppressant:Stop()
			timerFlameSuppressant:Start()	-- FlameSuppressant comes 62s after "Leviathan Mk II" attackable
			
			timerNextShockblast:Stop()
			timerNextShockblast:Start(22)	-- first Shockblast comes 22s after "Leviathan Mk II" attackable
			
			timerPlasmaBlastCD:Stop()
			timerPlasmaBlastCD:Start(15)	-- first PlasmaBlast comes 15s after "Leviathan Mk II" attackable
		end
	end
end

function mod:NextPhase()
	phase = phase + 1
	if phase == 1 then
		if self.Options.HealthFrame then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(33432, L.MobPhase1)
		end

	elseif phase == 2 then
		timerNextShockblast:Stop()
		timerProximityMines:Stop()
		timerFlameSuppressant:Stop()
		timerP1toP2:Start()
		if self.Options.HealthFrame then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(33651, L.MobPhase2)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if hardmode then
            timerNextFrostBomb:Start(114)
        end

	elseif phase == 3 then
		if self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
			SetLootMethod("freeforall")
		end
		timerDarkGlareCast:Cancel()
		timerNextDarkGlare:Cancel()
		timerNextFrostBomb:Cancel()
		timerP2toP3:Start()
		if self.Options.HealthFrame then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(33670, L.MobPhase3)
		end

	elseif phase == 4 then
		if self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
			if masterlooterRaidID then
				SetLootMethod(lootmethod, "raid"..masterlooterRaidID)
			else
				SetLootMethod(lootmethod)
			end
		end
		timerP3toP4:Start()
		if self.Options.HealthFramePhase4 or self.Options.HealthFrame then
			DBM.BossHealth:Show(L.name)
			DBM.BossHealth:AddBoss(33670, L.MobPhase3)
			DBM.BossHealth:AddBoss(33651, L.MobPhase2)
			DBM.BossHealth:AddBoss(33432, L.MobPhase1)
		end
		if hardmode then
			self:UnscheduleMethod("Flames")
			self:Flames()
            timerNextFrostBomb:Start(73)
        end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(63666, 65026) then -- Napalm Shell
		if self.Options.SetIconOnNapalm then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.YellPhase2 or msg:find(L.YellPhase2)) and mod:LatencyCheck() then
		--DBM:AddMsg("ALPHA: yell detect phase2, syncing to clients")
		self:SendSync("Phase2")	-- untested alpha! (this will result in a wrong timer)

	elseif (msg == L.YellPhase3 or msg:find(L.YellPhase3)) and mod:LatencyCheck() then
		--DBM:AddMsg("ALPHA: yell detect phase3, syncing to clients")
		self:SendSync("Phase3")	-- untested alpha! (this will result in a wrong timer)

	elseif (msg == L.YellPhase4 or msg:find(L.YellPhase4)) and mod:LatencyCheck() then
		--DBM:AddMsg("ALPHA: yell detect phase3, syncing to clients")
		self:SendSync("Phase4") -- SPELL_AURA_REMOVED detection might fail in phase 3...there are simply not enough debuffs on him

	elseif msg == L.YellComputerHM or msg:find(L.YellComputerHM) then
		enrage:Stop()
		hardmode = true
		timerHardmode:Start()
		
		timerPullP1:Stop()
		timerPullP1:Start(c_timerPullP1HM)
		
		timerNextFlames:Start(c_timerFirstFlames)
		self:ScheduleMethod(c_timerFirstFlames, "Flames")
		
		-- timers relative to Aggro Yell (encounter start)
		timerFlameSuppressant:Stop()
		timerFlameSuppressant:Start(c_timerFlameSuppressantP1)
		timerNextShockblast:Stop()
		timerNextShockblast:Start(c_timerFirstShockblastP1)
		timerPlasmaBlastCD:Stop()
		timerPlasmaBlastCD:Start(c_timerPlasmaBlastPullHM)
	
	elseif (msg == L.YellDefeat or msg:find(L.YellDefeat)) then -- register kill
		enrage:Stop()
		timerHardmode:Stop()
		timerNextFlames:Stop()
		timerNextShockblast:Stop()
		self:UnscheduleMethod("Flames")
	end
end


function mod:OnSync(event, args)
	if event == "SpinUpFail" then
		is_spinningUp = false
		timerSpinUp:Cancel()
		timerDarkGlareCast:Cancel()
		timerNextDarkGlare:Cancel()
		warnDarkGlare:Cancel()
	elseif event == "Phase2" and phase == 1 then -- alternate localized-dependent detection
		self:NextPhase()
	elseif event == "Phase3" and phase == 2 then
		self:NextPhase()
	elseif event == "Phase4" and phase == 3 then
		self:NextPhase()
	end
end

-- end P1:   20:42:32 "WUNDERBAR! Das sind Ergebnisse nach meinem Geschmack! Integrität der Hülle bei 98,9 Prozent! So gut wie keine Dellen! Und weiter geht's."
-- begin p2: 20:43:15.983  SPELL_AURA_APPLIED,0xF150008373000CEC,"VX-001",0xa48,0xF150008373000CEC,"VX-001",0xa48,64582,"Notfallmodus",0x1,BUFF

-- end P2:  20:44:17 || CHAT_MSG_MONSTER_YELL || Mimiron || "Danke Euch, Freunde! Eure Anstrengungen haben fantastische Daten geliefert! So, wo habe ich noch gleich... Ah, hier ist…"
-- begin P3 20:44:50.220  SPELL_AURA_APPLIED,0xF150008386000D43,"Luftkommandoeinheit",0xa48,0xF150008386000D43,"Luftkommandoeinheit",0xa48,64582,"Notfallmodus",0x1,BUFF

-- end P3   20:46:23 || CHAT_MSG_MONSTER_YELL || Mimiron || "Vorversuchsphase abgeschlossen. Jetzt kommt der eigentliche Test!"
-- begin P4 20:46:48.659  SPELL_CAST_START,0xF150008386000D43,"Luftkommandoeinheit",0xa48,0x0000000000000000,nil,0x80000000,65647,"Plasmakugel",0x44