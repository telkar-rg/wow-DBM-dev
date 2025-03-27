local mod = DBM:NewMod("LichKingEvent", "DBM-Party-WotLK", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2153 $"):sub(12, -3))
mod:RegisterEvents(
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_YELL"
)
local time_ARpEscapeBegin = 15.5
local time_HRpEscapeBegin = 15.5
local time_RpEscapeComplete = 21

local WarnWave1	= mod:NewAnnounce("WarnWave1", 2, nil, nil, false)
local WarnWave2	= mod:NewAnnounce("WarnWave2", 2, nil, nil, false)
local WarnWave3	= mod:NewAnnounce("WarnWave3", 2, nil, nil, false)
local WarnWave4	= mod:NewAnnounce("WarnWave4", 2, nil, nil, false)
mod:AddBoolOption("ShowWaves", true, "announce")

local timerRoleplay	= mod:NewTimer(time_ARpEscapeBegin, "TimerRoleplay", 59887)
local timerEscape	= mod:NewAchievementTimer(360, 4526, "achievementEscape")

mod:RemoveOption("HealthFrame")


function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(69708, 70194) then			--Lich King has broken out of his iceblock, this starts actual event
		if mod:IsDifficulty("heroic5") then
			timerEscape:Start()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Wave1 or msg:find(L.Wave1) then
		if self.Options.ShowWaves then
			WarnWave1:Show()
		end
	elseif msg == L.Wave2 or msg:find(L.Wave2) then
		if self.Options.ShowWaves then
			WarnWave2:Show()
		end
	elseif msg == L.Wave3 or msg:find(L.Wave3) then
		if self.Options.ShowWaves then
			WarnWave3:Show()
		end
	elseif msg == L.Wave4 or msg:find(L.Wave4) then
		if self.Options.ShowWaves then
			WarnWave4:Show()
		end
	-- elseif msg == L.ARpEscapeBegin or msg:find(L.ARpEscapeBegin) then
		-- timerRoleplay:Start(time_ARpEscapeBegin)
	-- elseif msg == L.HRpEscapeBegin or msg:find(L.HRpEscapeBegin) then
		-- timerRoleplay:Start(time_HRpEscapeBegin)
	elseif msg == L.RpEscapeComplete or msg:find(L.RpEscapeComplete) then
		timerRoleplay:Start(time_RpEscapeComplete)
	end
end