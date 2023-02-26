local mod	= DBM:NewMod("Halion", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4390 $"):sub(12, -3))
mod:SetCreatureID(39863)--40142 (twilight form)
mod:SetMinSyncRevision(4358)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Kill)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_HEALTH"
)

local warnPhase2Soon				= mod:NewAnnounce("WarnPhase2Soon", 2)
local warnPhase3Soon				= mod:NewAnnounce("WarnPhase3Soon", 2)
local warnPhase2					= mod:NewPhaseAnnounce(2)
local warnPhase3					= mod:NewPhaseAnnounce(3)
local warningShadowConsumption		= mod:NewTargetAnnounce(74792, 4)
local warningFieryConsumption		= mod:NewTargetAnnounce(74562, 4)
local warningMeteor					= mod:NewSpellAnnounce(74648, 3)
local warningShadowBreath			= mod:NewSpellAnnounce(75954, 2, nil, mod:IsTank() or mod:IsHealer())
local warningFieryBreath			= mod:NewSpellAnnounce(74526, 2, nil, mod:IsTank() or mod:IsHealer())
local warningTwilightCutter			= mod:NewAnnounce("TwilightCutterCast", 4, 77844)

local specWarnShadowConsumption		= mod:NewSpecialWarningRun(74792)
local specWarnFieryConsumption		= mod:NewSpecialWarningRun(74562)
local specWarnMeteorStrike			= mod:NewSpecialWarningMove(75952)
local specWarnTwilightCutter		= mod:NewSpecialWarningSpell(77844)

local timerShadowConsumptionCD		= mod:NewNextTimer(25, 74792)
local timerFieryConsumptionCD		= mod:NewNextTimer(25, 74562)
local timerMeteorCD					= mod:NewNextTimer(40, 74648)
local timerMeteorCast				= mod:NewCastTimer(7, 74648)--7-8 seconds from boss yell the meteor impacts.
-- local timerTwilightCutterCast		= mod:NewCastTimer(5, 77844)
local timerTwilightCutter			= mod:NewBuffActiveTimer(10, 77844)
local timerTwilightCutterCD			= mod:NewNextTimer(20, 77844)
local timerShadowBreathCD			= mod:NewCDTimer(19, 75954, nil, mod:IsTank() or mod:IsHealer())--Same as debuff timers, same CD, can be merged into 1.
local timerFieryBreathCD			= mod:NewCDTimer(19, 74526, nil, mod:IsTank() or mod:IsHealer())--But unique icons are nice pertaining to phase you're in ;)

local ttsPing = mod:NewSoundFile("Interface\\AddOns\\DBM-Core\\sounds\\ping.mp3", "TTS Ping when consumption on you", true)
local ttsCutterIn5 = mod:NewSoundFile("Interface\\AddOns\\DBM-Core\\sounds\\cutterIn5.mp3", "TTS Cutter countdown", true)
local ttsCutterIn5Offset = 6.5

local berserkTimer = mod:NewBerserkTimer(480)
local soundConsumption = mod:NewSound(74562, "SoundOnConsumption")

mod:AddBoolOption("YellOnConsumption", true, "announce")
mod:AddBoolOption("AnnounceAlternatePhase", true, "announce")
mod:AddBoolOption("WhisperOnConsumption", false, "announce")
mod:AddBoolOption("SetIconOnConsumption", true)

local warned_preP2 = false
local warned_preP3 = false
local lastflame = 0
local lastshroud = 0
local phases = {}
local corpValues = { -- % -> spellID for SPELL_AURA_APPLIED on Halion
	[74836] = 0,
	[74835] = 10,
	[74834] = 20,
	[74833] = 30,
	[74832] = 40,
	[74826] = 50,
	[74827] = 60,
	[74828] = 70,
	[74829] = 80,
	[74830] = 90,
	[74831] = 100
}
local currentCorpValue = 50

-- Corporeality damage counter
-- hide standard corp display with AlwaysUpFrame1:Hide() or WorldStateAlwaysUpFrame:Hide()
local function countDamage(self, event, ...)
	if select(4,...) == UnitName("player") then
		if select(2,...) == "SPELL_DAMAGE"
			or select(2,...) == "SPELL_PERIODIC_DAMAGE"
			or select(2,...) == "RANGE_DAMAGE" then
			self.damageSum = self.damageSum + select(12,...)
		elseif select(2,...) == "SWING_DAMAGE"  then
			self.damageSum = self.damageSum + select(9,...)
		end
	end
end
local damageCounter=CreateFrame("Frame", nil, UIParent)
damageCounter:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
damageCounter.Reset() = function() damageCounter.damageSum = 0 end
damageCounter.Start() = function() damageCounter.Reset(); damageCounter:SetScript("OnEvent", countDamage) end
damageCounter.Stop() = function() damageCounter:SetScript("OnEvent", nil) end

local function IsInTwilightRealm()
	if GetTime() - lastshroud < 3 then
		return true
	end
	return false
end

-- on inside damage aura taken every 2 seconds, damage is sent out to all, then physical answers. When physical is received, people set their indicator values to have a global view
local shadowDamage = 0
local lastShadowBroadcast = 0
local lastPhysicalBroadcast = 0
local syncFrame = CreateFrame("Frame",nil,UIParent)
syncFrame:RegisterEvent("CHAT_MSG_ADDON")
syncFrame:SetScript("OnEvent", function(_, _, prefix, msg, channel)
	if channel ~= "RAID" then return end
	if prefix == "DBMv4-Corp-Shadow" then
		local time = GetTime()
		if time - lastShadowBroadcast > 1.5 then -- anti spam
			shadowDamage = tonumber(msg)
			lastShadowBroadcast = time
			if not IsInTwilightRealm() and time - lastPhysicalBroadcast > 1.5 then
				sendPhysicalDamage()
			end
		end
	elseif prefix == "DBMv4-Corp-Physical" then
		local time = GetTime()
		if time - lastPhysicalBroadcast > 1.5 then -- anti spam
			statusBar.UpdateProgress(shadowDamage, tonumber(msg))
			lastPhysicalBroadcast = time
			-- TODO: check if addon messages have a strict ordering, e.g. if it's possible physical is first received, then shadow info (meaning the usage of old shadowdamage data)
			shadowDamage = nil
		end
	end
end)
local function sendShadowDamage()
	if select(3, GetNetStats()) < 400 then
		SendAddonMessage("DBMv4-Corp-Shadow", damageCounter.damageSum, "RAID")
	end
end
local function sendPhysicalDamage()
	if select(3, GetNetStats()) < 400 then
		SendAddonMessage("DBMv4-Corp-Physical", damageCounter.damageSum, "RAID")
	end
end


-- Corporeality statusBar
local statusBar = CreateFrame("Frame", nil, UIParent)
statusBar:SetPoint("TOP", UIParent, "TOP", 0, -20)
statusBar:SetWidth(204)
statusBar:SetHeight(20)
statusBar:SetMovable(true)
statusBar:EnableMouse(true)
statusBar:RegisterForDrag("LeftButton")
statusBar:SetScript("OnDragStart", statusBar.StartMoving)
statusBar:SetScript("OnDragStop", statusBar.StopMovingOrSizing)
statusBar:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 }});
statusBar:SetBackdropColor(0,0,0,1)
statusBar:SetBackdropBorderColor(0.4,0.4,0.4)
statusBar:Hide()

statusBar.Lprogress = statusBar:CreateTexture(nil, "ARTWORK")
statusBar.Lprogress:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
statusBar.Lprogress:SetPoint("LEFT", statusBar, "CENTER", 0, 0)
statusBar.Lprogress:SetVertexColor(0, 1, 0, 1)
statusBar.Lprogress:SetHeight(12)
statusBar.Lprogress:SetWidth(-1)

statusBar.Rprogress = statusBar:CreateTexture(nil, "ARTWORK")
statusBar.Rprogress:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
statusBar.Rprogress:SetPoint("RIGHT", statusBar, "CENTER", 0, 0)
statusBar.Rprogress:SetVertexColor(0, 1, 0, 1)
statusBar.Rprogress:SetHeight(12)
statusBar.Rprogress:SetWidth(-1)

statusBar.value = statusBar:CreateFontString(nil, "OVERLAY")
statusBar.value:SetPoint("CENTER", statusBar, "CENTER", 0, 0)
statusBar.value:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
statusBar.value:SetJustifyH("LEFT")
statusBar.value:SetShadowOffset(1, -1)
statusBar.value:SetTextColor(1, 1, 1)
statusBar.value:SetText("50")

statusBar.warning = statusBar:CreateFontString(nil, "OVERLAY")
statusBar.warning:SetPoint("CENTER", statusBar, "CENTER", 0, -20)
statusBar.warning:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
statusBar.warning:SetJustifyH("LEFT")
statusBar.warning:SetShadowOffset(1, -1)
statusBar.warning:SetTextColor(1, 0, 0)

statusBar.title = statusBar:CreateFontString(nil, "OVERLAY")
statusBar.title:SetPoint("CENTER", statusBar, "CENTER", 0, 20)
statusBar.title:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
statusBar.title:SetJustifyH("LEFT")
statusBar.title:SetShadowOffset(1, -1)
statusBar.title:SetTextColor(1, 1, 1)
statusBar.title:SetText("Corporeality")
statusBar.UpdateProgress = function(shadow, physical)
	if shadow == 0 or physical == 0 then
		statusBar.Rprogress:SetWidth(-1)
		statusBar.Lprogress:SetWidth(-1)
		return
	end
	local ratio
	if IsInTwilightRealm() then
		ratio = shadow / physical
	else
		ratio = physical / shadow
	end
	ratio = ((ratio - 1) * 1000) -- [0.9, 1.1] -> [-100, 100]
	ratio = math.min(math.max(ratio, -100), 100) -- clamp [-100, 100]
	-- bar width
	if ratio > 0 then
		statusBar.Rprogress:SetWidth(-1)
		statusBar.Lprogress:SetWidth(ratio)
	else
		statusBar.Lprogress:SetWidth(-1)
		statusBar.Rprogress:SetWidth(-ratio)
	end
	if statusBar.percentage >= 60 and ratio < 0 then
		statusBar.warning:SetText("MORE DPS!")
		statusBar.Rprogress:SetVertexColor(1, 1, 0, 1)
		statusBar.Lprogress:SetVertexColor(1, 1, 0, 1)
	elseif statusBar.percentage <= 40 and ratio > 0 then
		statusBar.Rprogress:SetVertexColor(1, 0, 0, 1)
		statusBar.Lprogress:SetVertexColor(1, 0, 0, 1)
		statusBar.warning:SetText("STOP DPS!")
	else
		statusBar.warning:SetText("")
		statusBar.Rprogress:SetVertexColor(0, 1, 0)
		statusBar.Lprogress:SetVertexColor(0, 1, 0)
	end
end
-- gets called when halion casts corp or on target switch
statusBar.UpdateCorp = function(spellID)
	statusBar.percentage = corpValues[args.spellId]
	if percentage <= 30 then
		statusBar.value:SetTextColor(1, 0, 0)
	elseif percentage >= 70 then
		statusBar.value:SetTextColor(1, 1, 0)
	else
		statusBar.value:SetTextColor(1, 1, 1)
	end
	statusBar.value:SetText(statusBar.percentage.."%")
end
-- update corp on target swap for players that jump between realms
statusBar:RegisterEvent("PLAYER_TARGET_CHANGED")
local function updateCorpOnTargetSwap(self, ...)
	local spellID = select(11, UnitAura("Halion", "Corporeality"))
	if spellID then
		self.UpdateCorp(spellID)
	end
end

function mod:LocationChecker()
	if GetTime() - lastshroud < 6 then
		DBM.BossHealth:RemoveBoss(39863)--you took damage from twilight realm recently so remove the physical boss from health frame.
	else
		DBM.BossHealth:RemoveBoss(40142)--you have not taken damage from twilight realm so remove twilight boss health bar.
	end
end

local function updateHealthFrame(phase)
	if phases[phase] then
		return
	end
	phases[phase] = true
	if phase == 1 then
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(39863, L.NormalHalion)
	elseif phase == 2 then
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(40142, L.TwilightHalion)
	elseif phase == 3 then
		DBM.BossHealth:AddBoss(39863, L.NormalHalion)--Add 1st bar back on. you have two bars for time being.
		mod:ScheduleMethod(20, "LocationChecker")--we remove the extra bar in 20 seconds depending on where you are at when check is run.
	end
end

function mod:OnCombatStart(delay)--These may still need retuning too, log i had didn't have pull time though.
	table.wipe(phases)
	warned_preP2 = false
	warned_preP3 = false
	phase2Started = 0
	lastflame = 0
	lastshroud = 0
	berserkTimer:Start(-delay)
	timerMeteorCD:Start(20-delay)
	timerFieryConsumptionCD:Start(15-delay)
	timerFieryBreathCD:Start(10-delay)
	updateHealthFrame(1)
end

function mod:OnCombatEnd()
	ttsCutterIn5:Cancel()
	statusBar:Hide()
	statusBar:SetScript("OnEvent", nil)
	damageCounter.Stop()
	currentCorpValue = 50
	-- TODO: add more things to cancel ?
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(74806, 75954, 75955, 75956) then
		warningShadowBreath:Show()
		timerShadowBreathCD:Start()
	elseif args:IsSpellID(74525, 74526, 74527, 74528) then
		warningFieryBreath:Show()
		timerFieryBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)--We use spell cast success for debuff timers in case it gets resisted by a player we still get CD timer for next one
	if args:IsSpellID(74792) then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerShadowConsumptionCD:Start(20)
		else
			timerShadowConsumptionCD:Start()
		end
		if mod:LatencyCheck() then
			self:SendSync("ShadowCD")
		end
	elseif args:IsSpellID(74562) then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerFieryConsumptionCD:Start(20)
		else
			timerFieryConsumptionCD:Start()
		end
		if mod:LatencyCheck() then
			self:SendSync("FieryCD")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)--We don't use spell cast success for actual debuff on >player< warnings since it has a chance to be resisted.
	if args:IsSpellID(74792) then
		if not self.Options.AnnounceAlternatePhase then
			warningShadowConsumption:Show(args.destName)
			if DBM:GetRaidRank() >= 1 and self.Options.WhisperOnConsumption then
				SendChatMessage(L.WhisperConsumption, "WHISPER", "COMMON", args.destName)
			end
		end
		if mod:LatencyCheck() then
			self:SendSync("ShadowTarget", args.destName)
		end
		if args:IsPlayer() then
			specWarnShadowConsumption:Show()
			soundConsumption:Play()
			ttsPing:Play()
			if self.Options.YellOnConsumption then
				SendChatMessage(L.YellConsumption, "SAY")
			end
		end
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 7)
		end
	elseif args:IsSpellID(74562) then
		if not self.Options.AnnounceAlternatePhase then
			warningFieryConsumption:Show(args.destName)
			if DBM:GetRaidRank() >= 1 and self.Options.WhisperOnConsumption then
				SendChatMessage(L.WhisperCombustion, "WHISPER", "COMMON", args.destName)
			end
		end
		if mod:LatencyCheck() then
			self:SendSync("FieryTarget", args.destName)
		end
		if args:IsPlayer() then
			specWarnFieryConsumption:Show()
			ttsPing:Play()
			soundConsumption:Play()
			if self.Options.YellOnConsumption then
				SendChatMessage(L.YellCombustion, "SAY")
			end
		end
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 8)
		end
	elseif corpValues[args.spellId] then
		statusBar.UpdateCorp(args.spellID)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(74792) then
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(74562) then
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if (args:IsSpellID(75952, 75951, 75950, 75949) or args:IsSpellID(75948, 75947)) and args:IsPlayer() and GetTime() - lastflame > 2 then
		specWarnMeteorStrike:Show()
		lastflame = GetTime()
	elseif args:IsSpellID(75483, 75484, 75485, 75486) and args:IsPlayer() then
		lastshroud = GetTime()--keeps a time stamp for twilight realm damage to determin if you're still there or not for bosshealth frame.
		if time - lastShadowBroadcast > 1.5 then -- anti spam
			sendShadowDamage()
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_preP2 and self:GetUnitCreatureId(uId) == 39863 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.79 then
		warned_preP2 = true
		warnPhase2Soon:Show()	
	elseif not warned_preP3 and self:GetUnitCreatureId(uId) == 40142 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.54 then
		warned_preP3 = true
		warnPhase3Soon:Show()	
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase2 or msg:find(L.Phase2) then
		updateHealthFrame(2)
		timerFieryBreathCD:Cancel()
		timerMeteorCD:Cancel()
		timerFieryConsumptionCD:Cancel()
		warnPhase2:Show()
		timerShadowBreathCD:Start(25)
		timerShadowConsumptionCD:Start(20)--not exact, 15 seconds from tank aggro, but easier to add 5 seconds to it as a estimate timer than trying to detect this
		-- if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then --These i'm not sure if they start regardless of drake aggro, or if it should be moved too.
		-- 	timerTwilightCutterCD:Start(30)
		-- else
		-- 	timerTwilightCutterCD:Start(35)
		-- end
		timerTwilightCutterCD:Start(35)
		ttsCutterIn5:Schedule(35-ttsCutterIn5Offset)
	elseif msg == L.Phase3 or msg:find(L.Phase3) then
		self:SendSync("Phase3")
		statusBar:Show()
		damageCounter.Start()
		statusBar:SetScript("OnEvent", updateCorpOnTargetSwap)
	elseif msg == L.MeteorCast or msg:find(L.MeteorCast) then--There is no CLEU cast trigger for meteor, only yell
		if not self.Options.AnnounceAlternatePhase then
			warningMeteor:Show()
			timerMeteorCast:Start()--7 seconds from boss yell the meteor impacts.
			timerMeteorCD:Start()
		end
		if mod:LatencyCheck() then
			self:SendSync("Meteor")
		end
	end
end

local lastEmote = 0 -- only react on the first emote, warmane only sometimes puts another emote right when the cutter starts
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if (msg == L.twilightcutter or msg:find(L.twilightcutter)) and GetTime() - lastEmote > 16 then
		specWarnTwilightCutter:Schedule(5)
		if not self.Options.AnnounceAlternatePhase then
			lastEmote = GetTime()
			warningTwilightCutter:Show()
			-- timerTwilightCutterCast:Start()
			timerTwilightCutter:Schedule(5)--Delay it since it happens 5 seconds after the emote
			timerTwilightCutterCD:Schedule(15)
			ttsCutterIn5:Schedule(35-ttsCutterIn5Offset)
		end
		if mod:LatencyCheck() then
			self:SendSync("TwilightCutter")
		end
	elseif (msg == L.CorporealityOut or msg:find(L.CorporealityOut)) then
		damageCounter.Reset()
	elseif (msg == L.CorporealityIn or msg:find(L.CorporealityIn)) then
		damageCounter.Reset()
	end
end

function mod:OnSync(msg, target)
	if msg == "TwilightCutter" then
		if self.Options.AnnounceAlternatePhase and GetTime() - lastEmote > 16 then
			lastEmote = GetTime()
			warningTwilightCutter:Show()
			-- timerTwilightCutterCast:Start()
			timerTwilightCutter:Schedule(5)--Delay it since it happens 5 seconds after the emote
			timerTwilightCutterCD:Schedule(15)
			ttsCutterIn5:Schedule(35-ttsCutterIn5Offset)
		end
	elseif msg == "Meteor" then
		if self.Options.AnnounceAlternatePhase then
			warningMeteor:Show()
			timerMeteorCast:Start()
			timerMeteorCD:Start()
		end
	elseif msg == "ShadowTarget" then
		if self.Options.AnnounceAlternatePhase then
			warningShadowConsumption:Show(target)
			if DBM:GetRaidRank() >= 1 and self.Options.WhisperOnConsumption then
				SendChatMessage(L.WhisperConsumption, "WHISPER", "COMMON", target)
			end
		end
	elseif msg == "FieryTarget" then
		if self.Options.AnnounceAlternatePhase then
			warningFieryConsumption:Show(target)
			if DBM:GetRaidRank() >= 1 and self.Options.WhisperOnConsumption then
				SendChatMessage(L.WhisperCombustion, "WHISPER", "COMMON", target)
			end
		end
	elseif msg == "ShadowCD" then
		if self.Options.AnnounceAlternatePhase then
			if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
				timerShadowConsumptionCD:Start(20)
			else
				timerShadowConsumptionCD:Start()
			end
		end
	elseif msg == "FieryCD" then
		if self.Options.AnnounceAlternatePhase then
			if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
				timerFieryConsumptionCD:Start(20)
			else
				timerFieryConsumptionCD:Start()
			end
		end
	elseif msg == "Phase3" then
		statusBar:Show()
		damageCounter.Start()
		updateHealthFrame(3)
		warnPhase3:Show()
		timerMeteorCD:Start(30) --These i'm not sure if they start regardless of drake aggro, or if it varies as well.
		timerFieryConsumptionCD:Start(20)--not exact, 15 seconds from tank aggro, but easier to add 5 seconds to it as a estimate timer than trying to detect this
	end
end
