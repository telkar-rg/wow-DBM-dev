-- ***************************************************
-- **             DBM Range Check Frame             **
-- **         http://www.deadlybossmods.com         **
-- ***************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
--
-- The localizations are written by:
--    * enGB/enUS: Tandanu				http://www.deadlybossmods.com
--    * deDE: Tandanu					http://www.deadlybossmods.com
--    * zhCN: Diablohu					http://wow.gamespot.com.cn
--    * ruRU: BootWin					bootwin@gmail.com
--    * ruRU: Vampik					admin@vampik.ru
--    * zhTW: Hman						herman_c1@hotmail.com
--    * zhTW: Azael/kc10577				paul.poon.kw@gmail.com
--    * koKR: BlueNyx/nBlueWiz			bluenyx@gmail.com / everfinale@gmail.com
--    * esES: Snamor/1nn7erpLaY      	romanscat@hotmail.com
--
-- Special thanks to:
--    * Arta
--    * Omegal @ US-Whisperwind (continuing mod support for 3.2+)
--    * Tennberg (a lot of fixes in the enGB/enUS localization)
--
--
-- The code of this addon is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
-- All included textures and sounds are copyrighted by their respective owners.
--
--
--  You are free:
--    * to Share ?to copy, distribute, display, and perform the work
--    * to Remix ?to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--
--
-- This file makes use of the following free (Creative Commons Sampling Plus 1.0) sounds:
--    * alarmclockbeeps.ogg by tedthetrumpet (http://www.freesound.org/usersViewSingle.php?id=177)
--    * blip_8.ogg by Corsica_S (http://www.freesound.org/usersViewSingle.php?id=7037)
--  The full of text of the license can be found in the file "Sounds\Creative Commons Sampling Plus 1.0.txt".
--
--
--	Additional contributions by:
--    * Vargoth @ Rising-Gods
--    * Telkar @ Rising-Gods

---------------
--  Globals  --
---------------
DBM.RangeCheck = {}
--[[ DBM:RegisterMapSize("Stormwind",
	0, 1737.499958992, 1158.3330078125
)]]

--------------
--  Locals  --
--------------
local rangeCheck = DBM.RangeCheck
local checkFuncs = {}
local frame
local createFrame
local radarFrame
local createRadarFrame
local onUpdate
local onUpdateRadar
local dropdownFrame
local initializeDropdown
local initRangeCheck -- initializes the range check for a specific range (if necessary), returns false if the initialization failed (because of a map range check in an unknown zone)
local dots = {}
local charms = {}
local icon_numerals = {}
local dot_numerals = {}
local coord_numerals = {}

-- for Phanx' Class Colors
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS

local CHARM_TEX_COORDS = {
	[1] = 	{ 0,	0.25, 0,    0.25 },
	[2] = 	{ 0.25, 0.5,  0,    0.25 },
	[3] = 	{ 0.5, 	0.75, 0,    0.25 },
	[4] = 	{ 0.75, 1,    0,    0.25 },
	[5] = 	{ 0, 	0.25, 0.25, 0.5  },
	[6] = 	{ 0.25, 0.5,  0.25, 0.5  },
	[7] = 	{ 0.5, 	0.75, 0.25, 0.5  },
	[8] = 	{ 0.75, 1,    0.25, 0.5  }
}

-- DBM 1.4a
local NUMERAL_COLORS = {
	[0] = { 1.0, 1.0, 1.0 },
	[1] = { 0.6, 1.0, 0.3 }, -- green
	[2] = { 1.0, 0.4, 0.8 }, -- magenta
	[3] = { 1.0, 0.9, 0.3 }, -- yellow
	[4] = { 0.3, 0.7, 1.0 }  -- blue
}
local hexColors = {}
local vertexColors = {}
for k, v in pairs(RAID_CLASS_COLORS) do
	hexColors[k] = ("|cff%02x%02x%02x"):format(v.r * 255, v.g * 255, v.b * 255)
	vertexColors[k] = { v.r, v.g, v.b }
end
---------------------
--  Dropdown Menu  --
---------------------

-- todo: this dropdown menu is somewhat ugly and unflexible....
do
	local function setRange(self, range)
		rangeCheck:Show(range)
	end

	local sound0 = "none"
	local sound1 = "Interface\\AddOns\\DBM-Core\\Sounds\\blip_8.ogg"
	local sound2 = "Interface\\AddOns\\DBM-Core\\Sounds\\alarmclockbeeps.ogg"
	local function setSound(self, option, sound)
		DBM.Options[option] = sound
		if sound ~= "none" then
			PlaySoundFile(sound)
		end
	end

	local function setFrames(self, option)
		DBM.Options.RangeFrameFrames = option
		radarFrame:Hide()
		frame:Hide()
		rangeCheck:Show(frame.range, frame.filter)
	end

--	local function setSpeed(self, option)
--		DBM.Options.RangeFrameUpdates = option
--	end

	local function toggleLocked()
		DBM.Options.RangeFrameLocked = not DBM.Options.RangeFrameLocked
	end

	local function toggleRadar()
		DBM.Options.RangeFrameRadar = not DBM.Options.RangeFrameRadar
		if DBM.Options.RangeFrameRadar then
			radarFrame = radarFrame or createRadarFrame()
			radarFrame:Show()
		else
			radarFrame:Hide()
		end
	end

	function initializeDropdown(dropdownFrame, level, menu)
		local info
		if level == 1 then
			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SETRANGE
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "range"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SOUNDS
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "sounds"
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_OPTION_FRAMES
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "frames"
			UIDropDownMenu_AddButton(info, 1)

--[[			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_OPTION_SPEED
			info.notCheckable = true
			info.hasArrow = true
			info.menuList = "speed"
			UIDropDownMenu_AddButton(info, 1)]]

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_LOCK
			if DBM.Options.RangeFrameLocked then
				info.checked = true
			end
			info.func = toggleLocked
			UIDropDownMenu_AddButton(info, 1)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_HIDE
			info.notCheckable = true
			info.func = rangeCheck.Hide
			info.arg1 = rangeCheck
			UIDropDownMenu_AddButton(info, 1)

		elseif level == 2 then
			if menu == "range" then
				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(5)
					info.func = setRange
					info.arg1 = 5
					info.checked = (frame.range == 5)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(6)
					info.func = setRange
					info.arg1 = 6
					info.checked = (frame.range == 6)
					UIDropDownMenu_AddButton(info, 2)
				end

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(8)
					info.func = setRange
					info.arg1 = 8
					info.checked = (frame.range == 8)
					UIDropDownMenu_AddButton(info, 2)
				end

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(10)
				info.func = setRange
				info.arg1 = 10
				info.checked = (frame.range == 10)
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(11)
				info.func = setRange
				info.arg1 = 11
				info.checked = (frame.range == 11)
				UIDropDownMenu_AddButton(info, 2)

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(12)
					info.func = setRange
					info.arg1 = 12
					info.checked = (frame.range == 12)
					UIDropDownMenu_AddButton(info, 2)
				end

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(15)
				info.func = setRange
				info.arg1 = 15
				info.checked = (frame.range == 15)
				UIDropDownMenu_AddButton(info, 2)

				if initRangeCheck() then
					info = UIDropDownMenu_CreateInfo()
					info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(20)
					info.func = setRange
					info.arg1 = 20
					info.checked = (frame.range == 20)
					UIDropDownMenu_AddButton(info, 2)
				end

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SETRANGE_TO:format(28)
				info.func = setRange
				info.arg1 = 28
				info.checked = (frame.range == 28)
				UIDropDownMenu_AddButton(info, 2)
			elseif menu == "sounds" then
				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SOUND_OPTION_1
				info.notCheckable = true
				info.hasArrow = true
				info.menuList = "RangeFrameSound1"
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_SOUND_OPTION_2
				info.notCheckable = true
				info.hasArrow = true
				info.menuList = "RangeFrameSound2"
				UIDropDownMenu_AddButton(info, 2)
			elseif menu == "frames" then
				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_TEXT
				info.func = setFrames
				info.arg1 = "text"
				info.checked = (DBM.Options.RangeFrameFrames == "text")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_RADAR
				info.func = setFrames
				info.arg1 = "radar"
				info.checked = (DBM.Options.RangeFrameFrames == "radar")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_BOTH
				info.func = setFrames
				info.arg1 = "both"
				info.checked = (DBM.Options.RangeFrameFrames == "both")
				UIDropDownMenu_AddButton(info, 2)
--[[			elseif menu == "speed" then
				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_SLOW
				info.func = setSpeed
				info.arg1 = "Slow"
				info.checked = (DBM.Options.RangeFrameUpdates == "Slow")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_AVERAGE
				info.func = setSpeed
				info.arg1 = "Average"
				info.checked = (DBM.Options.RangeFrameUpdates == "Average")
				UIDropDownMenu_AddButton(info, 2)

				info = UIDropDownMenu_CreateInfo()
				info.text = DBM_CORE_RANGECHECK_OPTION_FAST
				info.func = setSpeed
				info.arg1 = "Fast"
				info.checked = (DBM.Options.RangeFrameUpdates == "Fast")
				UIDropDownMenu_AddButton(info, 2)	]]
			end
		elseif level == 3 then
			local option = menu
			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SOUND_0
			info.func = setSound
			info.arg1 = option
			info.arg2 = sound0
			info.checked = (DBM.Options[option] == sound0)
			UIDropDownMenu_AddButton(info, 3)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SOUND_1
			info.func = setSound
			info.arg1 = option
			info.arg2 = sound1
			info.checked = (DBM.Options[option] == sound1)
			UIDropDownMenu_AddButton(info, 3)

			info = UIDropDownMenu_CreateInfo()
			info.text = DBM_CORE_RANGECHECK_SOUND_2
			info.func = setSound
			info.arg1 = option
			info.arg2 = sound2
			info.checked = (DBM.Options[option] == sound2)
			UIDropDownMenu_AddButton(info, 3)
		end
	end
end

-----------------
-- Play Sounds --
-----------------
local function updateSound(numPlayers) -- called every 5 seconds
	if not UnitAffectingCombat("player") then
		return
	end
	if numPlayers == 1 then
		if DBM.Options.RangeFrameSound1 ~= "none" then
			PlaySoundFile(DBM.Options.RangeFrameSound1)
		end
	elseif numPlayers > 1 then
		if DBM.Options.RangeFrameSound2 ~= "none" then
			PlaySoundFile(DBM.Options.RangeFrameSound2)
		end
	end
end

------------------------
--  Create the frame  --
------------------------
-- stock ValidateFramePosition snaps too high up on the bottom exit
-- TODO: stop being a noob and use GetBottom/GetTop/GetLeft/GetRight with GetScreenWidth/GetScreenHeight instead
--[[ didn't test
function ownValidateFramePosition(frame)
	local point, relFrame, relPoint, x, y = frame:GetPoint(1)
   if frame:GetLeft() <= 0 then
      x = 0
   end
   if frame:GetRight() >= GetScreenWidth() then
      x = GetScreenWidth()
   end
   if frame:GetBottom() <= 0 then
      y = 0
   end
   if frame:GetTop() >= GetScreenHeight() then
      y = GetScreenHeight()
   end
   frame:SetPoint(point, relFrame, relPoint, x, y)
--]]
local function ownValidateFramePosition(frame)
	local point, relFrame, relPoint, x, y = frame:GetPoint(1)
	if point == "BOTTOMRIGHT" then
		if x > 0 then x = 0 end
		if y < 0 then y = 0 end
	elseif point == "RIGHT" then
		if x > 0 then x = 0 end
	elseif point == "TOPRIGHT" then
		if x > 0 then x = 0 end
		if y > 0 then y = 0 end
	elseif point == "TOP" then
		if y > 0 then y = 0 end
	elseif point == "TOPLEFT" then
		if x < 0 then x = 0 end
		if y > 0 then y = 0 end
	elseif point == "LEFT" then
		if x < 0 then x = 0 end
	elseif point == "BOTTOMLEFT" then
		if x < 0 then x = 0 end
		if y < 0 then y = 0 end
	elseif point == "BOTTOM" then
		if y < 0 then y = 0 end
	end
	frame:SetPoint(point, relFrame, relPoint, x, y)
end

function createFrame()
	local elapsed = 0
--[[	local updateRate
	if DBM.Options.RangeFrameUpdates == "Slow" then
		updateRate = 0.5
	elseif DBM.Options.RangeFrameUpdates == "Average" then
		updateRate = 0.25
	elseif DBM.Options.RangeFrameUpdates == "Fast" then
		updateRate = 0.05
	end]]
	local frame = CreateFrame("GameTooltip", "DBMRangeCheck", UIParent, "GameTooltipTemplate")
	dropdownFrame = CreateFrame("Frame", "DBMRangeCheckDropdown", frame, "UIDropDownMenuTemplate")
	frame:SetFrameStrata("DIALOG")
	frame:SetPoint(DBM.Options.RangeFramePoint, UIParent, DBM.Options.RangeFramePoint, DBM.Options.RangeFrameX, DBM.Options.RangeFrameY)
	frame:SetHeight(64)
	frame:SetWidth(64)
	frame:EnableMouse(true)
	frame:SetToplevel(true)
	frame:SetMovable()
	GameTooltip_OnLoad(frame)
	frame:SetPadding(16)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function(self)
		if not DBM.Options.RangeFrameLocked then
			self:StartMoving()
		end
	end)
	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		-- ValidateFramePosition(self) -- doesn't work on bottom border, will snap too high up
		ownValidateFramePosition(self)
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.RangeFrameX = x
		DBM.Options.RangeFrameY = y
		DBM.Options.RangeFramePoint = point
	end)
	frame:SetScript("OnUpdate", function(self, e)
		elapsed = elapsed + e
		if elapsed >= 0.05 and self.checkFunc then
			onUpdate(self, elapsed)
			elapsed = 0
		end
	end)
	frame:SetScript("OnMouseDown", function(self, button)
		if button == "RightButton" then
			UIDropDownMenu_Initialize(dropdownFrame, initializeDropdown, "MENU")
			ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
		end
	end)
	return frame
end

function createRadarFrame()
	local elapsed = 0
--[[	local updateRate
	if DBM.Options.RangeFrameUpdates == "Slow" then
		updateRate = 0.5
	elseif DBM.Options.RangeFrameUpdates == "Average" then
		updateRate = 0.25
	elseif DBM.Options.RangeFrameUpdates == "Fast" then
		updateRate = 0.05
	end]]
	local radarFrame = CreateFrame("Frame", "DBMRangeCheckRadar", UIParent)
	radarFrame:SetFrameStrata("DIALOG")

	radarFrame:SetPoint(DBM.Options.RangeFrameRadarPoint, UIParent, DBM.Options.RangeFrameRadarPoint, DBM.Options.RangeFrameRadarX, DBM.Options.RangeFrameRadarY)
	radarFrame:SetHeight(128)
	radarFrame:SetWidth(128)
	radarFrame:EnableMouse(true)
	radarFrame:SetToplevel(true)
	radarFrame:SetMovable()
	radarFrame:RegisterForDrag("LeftButton")
	radarFrame:SetScript("OnDragStart", function(self)
		if not DBM.Options.RangeFrameLocked then
			self:StartMoving()
		end
	end)
	radarFrame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		-- ValidateFramePosition(self) -- doesn't work on bottom border, will snap too high up
		ownValidateFramePosition(self)
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.RangeFrameRadarX = x
		DBM.Options.RangeFrameRadarY = y
		DBM.Options.RangeFrameRadarPoint = point
	end)
	radarFrame:SetScript("OnUpdate", function(self, e)
		elapsed = elapsed + e
		if elapsed >= 0.05 then
			onUpdateRadar(self, elapsed)
			elapsed = 0
		end
	end)
	radarFrame:SetScript("OnMouseDown", function(self, button)
		if button == "RightButton" then
			UIDropDownMenu_Initialize(dropdownFrame, initializeDropdown, "MENU")
			ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
		end
	end)

	local bg = radarFrame:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints(radarFrame)
	bg:SetBlendMode("BLEND")
	bg:SetTexture(0, 0, 0, 0.3)
	radarFrame.background = bg

	local circle = radarFrame:CreateTexture(nil, "ARTWORK")
	circle:SetPoint("CENTER")
	circle:SetTexture("Interface\\AddOns\\DBM-Core\\textures\\radar_circle.blp")
	circle:SetBlendMode("ADD")
	radarFrame.circle = circle

	local player = radarFrame:CreateTexture(nil, "OVERLAY")
	player:SetSize(32, 32)
	player:SetTexture("Interface\\Minimap\\MinimapArrow.blp")
	player:SetBlendMode("ADD")
	player:SetPoint("CENTER")

	local text = radarFrame:CreateFontString(nil, "OVERLAY","GameTooltipText")
	text:SetWidth(128)
	text:SetHeight(15)
	text:SetPoint("BOTTOMLEFT", radarFrame, "TOPLEFT", 0,0)
--	text:SetFont("Fonts\\FRIZQT__.TTF", 11)
	text:SetTextColor(1, 1, 1, 1)
	text:Show()
	radarFrame.text = text

--	for i=1, 40 do
--		local dot = CreateFrame("Frame", "DBMRangeCheckRadarDot"..i, radarFrame, "WorldMapPartyUnitTemplate")
--		dot:SetWidth(24)
--		dot:SetHeight(24)
--		dot:SetFrameStrata("TOOLTIP")
--		dot:Hide()
--		dots[i] = {dot = dot}
--	end
	for i=1, 8 do
		local charm = radarFrame:CreateTexture("DBMRangeCheckRadarCharm"..i, "OVERLAY")
		charm:SetTexture("interface\\targetingframe\\UI-RaidTargetingIcons.blp")
		charm:SetWidth(16)
		charm:SetHeight(16)
		charm:SetTexCoord(
			CHARM_TEX_COORDS[i][1],
			CHARM_TEX_COORDS[i][2],
			CHARM_TEX_COORDS[i][3],
			CHARM_TEX_COORDS[i][4]
		)
		charm:Hide()
		charms[i] = charm
	end
	
	for i=1, 10 do -- DBM 1.4a
		local numeral = radarFrame:CreateTexture("DBMRangeCheckRadarNumeral"..i, "OVERLAY")
		numeral:SetTexture( string.format("Interface\\AddOns\\DBM-Core\\textures\\Numerals\\numeral_%d.tga", i) )
		numeral:SetWidth(16)
		numeral:SetHeight(16)
		numeral:SetVertexColor(unpack(NUMERAL_COLORS[(i-1) % 5]))
		numeral.x = 0
		numeral.y = 0
		numeral:Hide()
		icon_numerals[i] = numeral
	end

	radarFrame:Hide()
	return radarFrame
end

----------------
--  OnUpdate  --
----------------

local soundUpdate = 0
function onUpdate(self, elapsed)
	local color
	local j = 0
	self:ClearLines()
	self:SetText(DBM_CORE_RANGECHECK_HEADER:format(self.range), 1, 1, 1)
	if initRangeCheck(self.range) then
		if GetNumRaidMembers() > 0 then
			for i = 1, GetNumRaidMembers() do
				local uId = "raid"..i
				if not UnitIsUnit(uId, "player") and not UnitIsDeadOrGhost(uId) and self.checkFunc(uId, self.range) and (not self.filter or self.filter(uId)) then
					j = j + 1
					color = RAID_CLASS_COLORS[select(2, UnitClass(uId))] or NORMAL_FONT_COLOR
					local icon = GetRaidTargetIndex(uId)
					local text = icon and ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t %s"):format(icon, UnitName(uId)) or UnitName(uId)
					self:AddLine(text, color.r, color.g, color.b)
					if j >= 5 then
						break
					end
				end
			end
		elseif GetNumPartyMembers() > 0 then
			for i = 1, GetNumPartyMembers() do
				local uId = "party"..i
				if not UnitIsUnit(uId, "player") and not UnitIsDeadOrGhost(uId) and self.checkFunc(uId, self.range) and (not self.filter or self.filter(uId)) then
					j = j + 1
					color = RAID_CLASS_COLORS[select(2, UnitClass(uId))] or NORMAL_FONT_COLOR
					local icon = GetRaidTargetIndex(uId)
					local text = icon and ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t %s"):format(icon, UnitName(uId)) or UnitName(uId)
					self:AddLine(text, color.r, color.g, color.b)
					if j >= 5 then
						break
					end
				end
			end
		end
	else
		self:AddLine(DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED:format(self.range))
	end
	soundUpdate = soundUpdate + elapsed
	if soundUpdate >= 5 and j > 0 then
		updateSound(j)
		soundUpdate = 0
	end
	self:Show()
end

do
	local rotation, pixelsperyard, prevNumPlayers, range, isInSupportedArea
	local function createDot(id)
		local dot = radarFrame:CreateTexture("DBMRangeCheckRadarDot"..id, "OVERLAY")
		dot:SetTexture([[Interface\AddOns\DBM-Core\textures\blip]])
		dot:SetWidth(16)
		dot:SetHeight(16)
		dot:Hide()

		dots[id].dot = dot	-- store the dot so we can use it later again
		return dot
	end

	local function setDotColor(id, class)
		if not class then -- set to white color, dont set .class so we can try again later when class returns properly i guess?
			dots[id].dot:SetVertexColor(unpack(vertexColors["PRIEST"]))
			return
		end
		if class and class == dots[id].class then return end

		dots[id].dot:SetVertexColor(unpack(vertexColors[class]))
		dots[id].class = class
	end

	local function setDot(id, icon, filtered)
		local dot = dots[id].dot or createDot(id)		-- load the dot, or create a new one if none exists yet (creating new probably never happens as the dots are created when the frame is created)
		local x = dots[id].x
		local y = dots[id].y
		local range = (x*x + y*y) ^ 0.5
		if range < (1.5 * frame.range) then							-- if person is closer than 1.5 * range, show the dot. Else hide it
			local dx = ((x * math.cos(rotation)) - (-y * math.sin(rotation))) * pixelsperyard		-- Rotate the X,Y based on player facing
			local dy = ((x * math.sin(rotation)) + (-y * math.cos(rotation))) * pixelsperyard

			if icon and type(icon) == "number" and icon >= 1 and icon <= 8 then -- GetRaidTargetIndex seems to return strange values sometimes; see http://www.deadlybossmods.com/phpbb3/viewtopic.php?f=2&t=3213&p=30889#p30889
				if dots[id].icon and dots[id].icon ~= icon then
					charms[dots[id].icon]:Hide()
				end
				if not filtered then
					charms[icon]:ClearAllPoints()
					charms[icon]:SetPoint("CENTER", radarFrame, "CENTER", dx, dy)
					charms[icon]:Show()
				else
					charms[icon]:Hide()
				end
				dot:Hide()
				dots[id].icon = icon
			elseif not filtered then
				dot:ClearAllPoints()
				dot:SetPoint("CENTER", radarFrame, "CENTER", dx, dy)
				dot:Show()
				if dots[id].icon then
					charms[dots[id].icon]:Hide()
					dots[id].icon = nil
				end
			else
				if dots[id].icon and dots[id].icon ~= icon then
					charms[dots[id].icon]:Hide()
					dots[id].icon = nil
				end
				dot:Hide()
			end
		else
			dot:Hide()
			if dots[id].icon then
				charms[dots[id].icon]:Hide()
				dots[id].icon = nil
			end
		end
		if range <= 1.001 * frame.range and not filtered then
			dots[id].tooClose = true
		elseif range < 1.10 * frame.range and not filtered then
			dots[id].maybeTooClose = true
		else
			dots[id].tooClose = false
			dots[id].maybeTooClose = false
		end
	end
	
	-- DBM 1.4a
	local function createDotNumeral(idx)
		local numeral = radarFrame:CreateTexture("DBMRangeCheckRadarNumeral"..idx, "OVERLAY")
		numeral:SetTexture( string.format("Interface\\AddOns\\DBM-Core\\textures\\Numerals\\numeral_%d.tga", idx) )
		numeral:SetWidth(16)
		numeral:SetHeight(16)
		numeral:SetVertexColor(unpack(NUMERAL_COLORS[idx % 5]))
		numeral:Hide()
		icon_numerals[idx] = numeral
	
		return numeral
	end

	local function setDotNumeral(idx)
		if not(type(idx)=="number" and (idx>=1 and idx<=10) ) then return end
		
		local numeral = icon_numerals[idx] or createDotNumeral(idx)		-- load the dot, or create a new one if none exists yet (creating new probably never happens as the dots are created when the frame is created)
		local x = numeral.x
		local y = numeral.y
		local range = (x*x + y*y) ^ 0.5
		if range < (1.5 * frame.range) then							-- if person is closer than 1.5 * range, show the dot. Else hide it
			local dx = ((x * math.cos(rotation)) - (-y * math.sin(rotation))) * pixelsperyard		-- Rotate the X,Y based on player facing
			local dy = ((x * math.sin(rotation)) + (-y * math.cos(rotation))) * pixelsperyard

			numeral:ClearAllPoints()
			numeral:SetPoint("CENTER", radarFrame, "CENTER", dx, dy)
			numeral:Show()
		else
			numeral:Hide()
		end
	end
	-- ######

	function onUpdateRadar(self, elapsed)
		if initRangeCheck(frame.range) then--This is basically fixing a bug with map not being on right dungeon level half the time.
			pixelsperyard = min(radarFrame:GetWidth(), radarFrame:GetHeight()) / (frame.range * 3)
			radarFrame.circle:SetSize(frame.range * pixelsperyard * 2, frame.range * pixelsperyard * 2)

			if frame.range ~= (range or 0) then
				range = frame.range
				radarFrame.text:SetText(DBM_CORE_RANGERADAR_HEADER:format(range))
			end

			local mapName = GetMapInfo()
			local mapLevel = GetCurrentMapDungeonLevel()
			
			local dims  = DBM.MapSizes[mapName] and DBM.MapSizes[mapName][mapLevel]
			if not dims then -- This ALWAYS happens when leaving a zone that has a map and moving into one that does not.
				if select(3, radarFrame.circle:GetVertexColor()) < 0.5 then
					radarFrame.circle:SetVertexColor(1,1,1)
				end
				for i, v in pairs(dots) do
					v.dot:Hide()
				end
				for i = 1, 8 do
					charms[i]:Hide()
				end
				for i = 1, 10 do -- DBM 1.4a
					icon_numerals[i]:Hide()
				end
			else
				isInSupportedArea = true
				rotation = (2 * math.pi) - GetPlayerFacing()
				local numPlayers = 0
				local unitID = "raid%d"
				if GetNumRaidMembers() > 0 then
					unitID = "raid%d"
					numPlayers = GetNumRaidMembers()
				elseif GetNumPartyMembers() > 0 then
					unitID = "party%d"
					numPlayers = GetNumPartyMembers()
				end
				if numPlayers < (prevNumPlayers or 0) then
					for i=numPlayers, prevNumPlayers do
						if dots[i] then
							if dots[i].dot then
								dots[i].dot:Hide()		-- Hide dots when people leave the group
							end
							dots[i].tooClose = false
							dots[i].maybeTooClose = false
							dots[i].icon = nil
						end
					end
					for i=1, 8 do
						charms[i]:Hide()
					end
					for i = 1, 10 do -- DBM 1.4a
						icon_numerals[i]:Hide()
					end
				end
				prevNumPlayers = numPlayers

				local playerX, playerY = GetPlayerMapPosition("player")
				if playerX == 0 and playerY == 0 then return end		-- Somehow we can't get the correct position?

				for i=1, numPlayers do
					local uId = unitID:format(i)
					if not UnitIsUnit(uId, "player") then
						local x,y = GetPlayerMapPosition(uId)
						if UnitIsDeadOrGhost(uId) then x = 100 end	-- hack to make sure dead people aren't shown
						if not dots[i] then
							dots[i] = {
								icon = nil,
								class = "none",
								x = (x - playerX) * dims[1],
								y = (y - playerY) * dims[2]
							}
						else
							dots[i].x = (x - playerX) * dims[1]
							dots[i].y = (y - playerY) * dims[2]
						end
						setDot(i, GetRaidTargetIndex(uId), (frame.filter and not frame.filter(uId)))
						setDotColor(i, (select(2, UnitClass(uId))))
					else
						if dots[i] and dots[i].dot then
							dots[i].dot:Hide()
						end
					end
				end

				local playerTooClose = false
				local playerMaybeTooClose = false
				for i,v in pairs(dots) do
					if v.tooClose then
						playerTooClose = true
						break;
					end
					if v.maybeTooClose then
						playerMaybeTooClose = true
					end
				end
				if UnitIsDeadOrGhost("player") then
					radarFrame.circle:SetVertexColor(1,1,1)
				elseif playerTooClose then
					radarFrame.circle:SetVertexColor(1,0,0)
				elseif playerMaybeTooClose then
					radarFrame.circle:SetVertexColor(1,1,0)
				else
					radarFrame.circle:SetVertexColor(0,1,0)
				end
				
				-- added for DBM 1.4a Numerals
				if coord_numerals and coord_numerals["mapName"] == mapName and coord_numerals["mapLevel"] == mapLevel and coord_numerals["length"] > 0 then
					-- if correct mapName and mapLevel and valid table length, then use the numerals
					local x,y
					
					for i = 1, 10 do
						if i > coord_numerals["length"] then
							icon_numerals[i]:Hide() -- hide all numerals that are unused
						else
							x = coord_numerals[i][1] -- get numeral fixed coordinates
							y = coord_numerals[i][2]
							icon_numerals[i].x = (x - playerX) * dims[1] -- calculate delta coordinates to player
							icon_numerals[i].y = (y - playerY) * dims[2]
							setDotNumeral(i) -- update the numeral with new delta coords
						end
					end
				else -- otherwise make sure that they are hidden
					for i = 1, 10 do
						icon_numerals[i]:Hide()
					end
				end
				
				
				self:Show()
			end
		else
			if isInSupportedArea then
				-- we were in an area with known map dimensions during the last update but looks like we left it
				isInSupportedArea = false
				-- white frame
				radarFrame.circle:SetVertexColor(1,1,1)
				-- hide everything
				for i, v in pairs(dots) do
					v.dot:Hide()
				end
				for i = 1, 8 do
					charms[i]:Hide()
				end
				for i = 1, 10 do -- DBM 1.4a
					icon_numerals[i]:Hide()
				end
			end
		end
	end
end


-----------------------
--  Check functions  --
-----------------------
checkFuncs[11] = function(uId)
	return CheckInteractDistance(uId, 2)
end


checkFuncs[10] = function(uId)
	return CheckInteractDistance(uId, 3)
end

checkFuncs[28] = function(uId)
	return CheckInteractDistance(uId, 4)
end


local getDistanceBetween
do
	local mapSizes = DBM.MapSizes

	function getDistanceBetween(uId, x, y)
		local startX, startY = GetPlayerMapPosition(uId)
		local mapName = GetMapInfo()
		local dims  = mapSizes[mapName] and mapSizes[mapName][GetCurrentMapDungeonLevel()]
		if not dims then
			return
		end
		local dX = (startX - x) * dims[1]
		local dY = (startY - y) * dims[2]
		return math.sqrt(dX * dX + dY * dY)
	end

	local function mapRangeCheck(uId, range)
		return getDistanceBetween(uId, GetPlayerMapPosition("player")) < range
	end

	function initRangeCheck(range)
		if checkFuncs[range] ~= mapRangeCheck then
			return true
		end
		local pX, pY = GetPlayerMapPosition("player")
		if pX == 0 and pY == 0 then
			SetMapToCurrentZone()
			pX, pY = GetPlayerMapPosition("player")
		end
		local levels = mapSizes[GetMapInfo()]
		if not levels then
			return false
		end
		local dims = levels[GetCurrentMapDungeonLevel()]
		if not dims and levels and GetCurrentMapDungeonLevel() == 0 then -- we are in a known zone but the dungeon level seems to be wrong
			SetMapToCurrentZone() -- fixes the dungeon level
			dims = levels[GetCurrentMapDungeonLevel()] -- try again
			if not dims then -- there is actually a level 0 in this zone but we don't know about it...too bad :(
				return false
			end
		elseif not dims then
			return false
		end
		return true -- everything ok!
	end

	setmetatable(checkFuncs, {
		__index = function(t, k)
			return mapRangeCheck
		end
	})
end

do
	local bandages = {21991, 34721, 34722, 53049, 53050, 53051}  -- you should have one of these bandages in your cache

	checkFuncs[15] = function(uId)
		for i, v in ipairs(bandages) do
			if IsItemInRange(v, uId) == 1 then
				return true
			elseif IsItemInRange(v, uId) == 0 then
				return false
			end
		end
	end
end

---------------
--  Methods  --
---------------
-- function rangeCheck:Show(range, filter)
function rangeCheck:Show(...)
	local args,arg1,arg2,range,filter,numeral_arg
	args = {...}
	arg1, arg2 = ...
	
	SetMapToCurrentZone()--Set map to current zone before checking other stuff, work around annoying bug i hope?
	
	if type(arg1) == "function" then -- the first argument is optional
		return self:Show(nil, arg1)
	end
	
	if type(arg1) == "number" then -- old 1.4 functionality
		range = arg1
		filter = arg2
	else -- 2.0a functionality: We expect (string-kw-arg, value-arg) pairs in the argument list
		for i=1, #args/2 do -- go through all arg-pairs we got
			arg1 = table.remove(args, 1)
			arg2 = table.remove(args, 1)
			
			if arg1 == "range" then
				range = arg2
			elseif arg1 == "filter" then
				filter = arg2
			elseif arg1 == "numeral" then
				numeral_arg = arg2
			end
		end
	end
	
	if type(numeral_arg) == "table" then
		local x, y, i, c
		i=0
		for k,v in pairs(coord_numerals) do coord_numerals[k] = nil end -- clear old numeral settings
		coord_numerals["mapName"] =  numeral_arg["mapName"]  -- store new mapname
		coord_numerals["mapLevel"] = numeral_arg["mapLevel"] -- store new level
		coord_numerals["length"] = 0 -- default value
		
		for i=1,10  do -- get numeral coordinates (up to 10, cuz we have 10 numeral images)
			if not numeral_arg[i]then break end -- stop if less than 10
			coord_numerals[i] = numeral_arg[i]
			coord_numerals["length"] = i -- store current number of numeral coords
		end
	end
	
	-- unchanged 1.4 code
	local mapName = GetMapInfo()
	range = range or 10
	frame = frame or createFrame()
	radarFrame = radarFrame or createRadarFrame()
	frame.checkFunc = checkFuncs[range] or error(("Range \"%d yd\" is not supported."):format(range), 2)
	frame.range = range
	frame.filter = filter
	if DBM.Options.RangeFrameFrames == "text" or DBM.Options.RangeFrameFrames == "both" or DBM.MapSizes[mapName] == nil or (DBM.MapSizes[mapName] and DBM.MapSizes[mapName][GetCurrentMapDungeonLevel()] == nil) then
		frame:Show()
		frame:SetOwner(UIParent, "ANCHOR_PRESERVE")
		onUpdate(frame, 0)
	end
	if (DBM.Options.RangeFrameFrames == "radar" or DBM.Options.RangeFrameFrames == "both") and (DBM.MapSizes[mapName] and DBM.MapSizes[mapName][GetCurrentMapDungeonLevel()] ~= nil) then
		onUpdateRadar(radarFrame, 1)
	end
end

function rangeCheck:Hide()
	if frame then frame:Hide() end
	if radarFrame then radarFrame:Hide() end
end

function rangeCheck:IsShown()
	return frame and frame:IsShown() or radarFrame and radarFrame:IsShown()
end

function rangeCheck:GetDistance(...)
	if initRangeCheck() then
		return getDistanceBetween(...)
	end
end
