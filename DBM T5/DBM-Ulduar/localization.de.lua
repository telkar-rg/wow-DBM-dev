if GetLocale() ~= "deDE" then return end

-- fehlende Übersetzungen:
--
-- General Vezax (Hard Mode)
-- Yogg-Saron
-- Algalon

local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Flammenleviathan"
}

L:SetTimerLocalization{
}
	
L:SetMiscLocalization{
	YellPull		= "Feindeinheiten erkannt. Bedrohungsbewertung aktiv. Hauptziel erfasst. Neubewertung in T minus 30 Sekunden.",
	Emote			= "%%s verfolgt (%S+)%."
}

L:SetWarningLocalization{
	PursueWarn				= "Verfolgt >%s<!",
	-- warnNextPursueSoon		= "Zielwechsel in 5 Sek",
	SpecialPursueWarnYou	= "Du wirst verfolgt - lauf weg",
	-- SystemOverload			= "Kernüberladung", -- not needed, spell=62475
	warnWardofLife			= "Zauberschutz des Lebens erscheint"
}

L:SetOptionLocalization{
	-- SystemOverload			= "Zeige Spezialwarnung für Kernüberladung", -- not needed, spell=62475
	SpecialPursueWarnYou	= "Zeige Spezialwarnung bei Verfolgung",
	-- PursueWarn				= "Verkünde Verfolgung eines Spielers",
	warnNextPursueSoon		= "Zeige Vorwarnung vor nächstem Verfolgen",
	warnWardofLife			= "Zeige Spezialwarnung für Erscheinen von Zauberschutz des Lebens"
}

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis, Meister des Eisenwerks"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	-- WarningSlagPot			= "Schlackentopf auf >%s<", -- not needed, NewTargetAnnounce(63477, 3)
	-- SpecWarnJetsCast		= "Flammenstrahlen - Stoppe Zauber" -- not needed, NewSpecialWarningCast(63472)
}

L:SetOptionLocalization{
	-- SpecWarnJetsCast		= "Zeige Spezialwarnung für Flammenstrahlen-Zauber", -- not needed, NewSpecialWarningCast(63472)
	-- WarningSlagPot			= "Verkünde Schlackentopf-Ziele", -- not needed, NewTargetAnnounce(63477, 3)
	-- SlagPotIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(63477) 	-- en handles this
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Klingenschuppe"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame     = "Verschlingende Flamme - LAUF RAUS",
	warnTurretsReadySoon       = "letzer Turm bereit in 20 Sek",
	warnTurretsReady           = "letzer Turm bereit",
	SpecWarnDevouringFlameCast = "Verschlingende Flamme auf dir",
	WarnDevouringFlameCast     = "Verschlingende Flamme auf >%s<" 
}

L:SetTimerLocalization{
	timerTurret1  = "Turm 1",
	timerTurret2  = "Turm 2",
	timerTurret3  = "Turm 3",
	timerTurret4  = "Turm 4",
	timerGrounded = "auf dem Boden"
}

L:SetOptionLocalization{
	-- SpecWarnDevouringFlame     = "Zeige Spezialwarnung wenn in einer Verschlingende Flamme", -- automatic locale
	-- PlaySoundOnDevouringFlame  = "Spiele Sound wenn betroffen durch Verschlingende Flamme",
	warnTurretsReadySoon       = "Zeige Vorwarnung für Turmfertigstellung",
	warnTurretsReady           = "Zeige Warnung für fertige Türme",
	SpecWarnDevouringFlameCast = "Zeige Spezialwarnung wenn $spell:64733 auf dich gezaubert wird",
	timerTurret1         = "Zeige Timer für Turm 1",
	timerTurret2         = "Zeige Timer für Turm 2",
	timerTurret3         = "Zeige Timer für Turm 3 (25 Spieler)",
	timerTurret4         = "Zeige Timer für Turm 4 (25 Spieler)",
	OptionDevouringFlame = "Verkünde Ziel der Verschlingenden Flamme (nicht verlässlich)",
	timerGrounded        = "Zeige Timer für Dauer der Bodenphase"
}

L:SetMiscLocalization{
	YellAggro			= "Haltet die Augen offen! Bald werden Maulwurfmaschinen mit diesen widerlichen Eisenzwergen auftauchen!",	-- 1603038
	YellExtinguish		= "Feuer gelöscht! Lasst uns diese Geschütze reparieren!",	-- 1603042
		-- YellAir			= "Gebt uns einen Moment, damit wir uns auf den Bau der Geschütze vorbereiten können.",
			-- YellAir2		= "Feuer einstellen! Lasst uns diese Geschütze reparieren!",
			-- YellAir2		= "Feuer gelöscht! Lasst uns diese Geschütze reparieren!",
	YellGround			= "Beeilt Euch! Sie wird nicht lange am Boden bleiben!", 
	-- EmotePhase2			= "%%s grounded permanently!",
	EmotePhase2			= "%%s ist dauerhaft an den Boden gebunden!",
	FlamecastUnknown	= DBM_CORE_UNKNOWN
}

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002 Dekonstruktor"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	-- SpecialWarningLightBomb 	= "Lichtbombe auf dir!",
	-- SpecialWarningGravityBomb	= "Graviationsbombe auf DIR",
	-- specWarnConsumption			= "Verzehrung - Lauf weg"
}

L:SetOptionLocalization{
	-- SpecialWarningLightBomb		= "Zeige Spezialwarnung bei Lichtbombe auf dir",
	-- SpecialWarningGravityBomb	= "Zeige Spezialwarnung bei Graviationsbombe auf dir",
	-- specWarnConsumption			= "Zeige Spezialwarnung, wenn du von Verzehrung betroffen bist",
	-- SetIconOnLightBombTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(65121), 	-- en handles this
	-- SetIconOnGravityBombTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(64234) 	-- en handles this
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Versammlung des Eisens"
}

L:SetWarningLocalization{
	WarningSupercharge			= "Superladung auf Boss"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarningSupercharge			= "Zeige Warnung wenn Superladung",
	PlaySoundLightningTendrils		= "Spiele Sound bei Blitzranken",
	-- SetIconOnOverwhelmingPower	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(61888), 	-- en handles this
	-- SetIconOnStaticDisruption	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(61912), 	-- en handles this
	AlwaysWarnOnOverload			= "Warne immer bei Überladen (ansonsten nur wenn Boss im Ziel)",
	PlaySoundOnOverload			= "Spiele Sound bei Überladen",
	PlaySoundDeathRune			= "Spiele Sound bei Rune des Todes"
}

L:SetMiscLocalization{
	Steelbreaker		= "Stahlbrecher",
	RunemasterMolgeim	= "Runenmeister Molgeim",
	StormcallerBrundir	= "Sturmrufer Brundir"
}

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon der Beobachter"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Neue kollabierende Sterne",
	PossibleNextCosmicSmash	= "Nächster möglicher Kosmischer Schlag",
	TimerCombatStart		= "Kampf beginnt"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "Phasenschlag auf >%s< - %d mal",
	WarningCosmicSmash 		= "Kosmischer Schlag - Explosion in 4 Sek",
	WarnPhase2Soon			= "Phase 2 bald",
	warnStarLow				= "Kollabierender Stern stirbt bald"
}

L:SetOptionLocalization{
	SetIconOnCollapsingStar	= format("Setze Zeichen auf |c%s%s|r (|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:16|t -  |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:16|t)", "ffff8040", "Kollabierender Stern", 8, 5),
	-- WarningPhasePunch		= "Zeige Warnung bei Phasenschlag",
	NextCollapsingStar		= format("Zeige Timer für neue |c%s%s|r", "ffff8040", "Kollabierender Stern"),
	-- NextCollapsingStar		= "Zeige Timer für neue kollabierende Sterne",
	-- WarningCosmicSmash 		= "Zeige Warnung bei Kosmischem Schlag",
	PossibleNextCosmicSmash	= "Zeige Timer für nächsten möglichen $spell:62311",
	TimerCombatStart		= "Zeige Timer für Kampfbeginn",
	WarnPhase2Soon			= "Zeige Vorwarnung für Phase 2 (bei ~23%)",
	warnStarLow				= format("Zeige Spezialwarnung wenn |c%s%s|r bald stirbt (bei ~25%%)", "ffff8040", "Kollabierender Stern")
	-- warnStarLow				= "Zeige Spezialwarnung wenn Kollabierender Stern bald stirbt (bei ~25%)"
}

L:SetMiscLocalization{
	YellPull				= "Euer Handeln ist unlogisch. Alle Möglichkeiten dieser Begegnung wurden berechnet. Das Pantheon wird die Nachricht des Beobachters erhalten, ungeachtet des Ausgangs.",
	YellKill				= "Ich sah Welten umhüllt von den Flammen der Schöpfer, sah ohne einen Hauch von Trauer ihre Bewohner vergehen. Ganze Planetensysteme geboren und vernichtet, während Eure sterblichen Herzen nur einmal schlagen. Doch immer war mein Herz kalt... ohne Mitgefühl. Ich - habe - nichts - gefühlt. Millionen, Milliarden Leben verschwendet. Trugen sie alle dieselbe Beharrlichkeit in sich, wie Ihr? Liebten sie alle das Leben so sehr, wie Ihr es tut?",
	Emote_CollapsingStar	= "%s beginnt damit, kollabierende Sterne zu beschwören!!",
	Phase2					= "Erblicket die Instrumente der Schöpfung!",
	PullCheck				= "Zeit, bis Algalon mit dem Uplink beginnt= (%d+) min."
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam		= "Augenstrahl auf dir - Lauf",
	WarningEyebeam				= "Augenstrahl auf >%s<",
	WarnGrip					= "Steinerner Griff auf >%s<",
	SpecWarnCrunchArmor2	= "Rüstung zermalmen >%d< auf dir"
}

L:SetTimerLocalization{
	timerLeftArm			= "Nachwachsen linker Arm",
	timerRightArm			= "Nachwachsen rechter Arm",
	achievementDisarmed		= "Zeit für Arm-ab-Erfolg"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam	= "Zeige Spezialwarnung wenn von Fokussierter Augenstrahl betroffen",
	SpecWarnCrunchArmor2	= "Zeige Spezialwarnung für Rüstung zermalmen (>=2 Stacks)",
	WarningEyeBeam			= "Verkünde Augenstrahl-Ziele",
	timerLeftArm			= "Zeige Timer für Arm-Nachwachsen (links)",
	timerRightArm			= "Zeige Timer für Arm-Nachwachsen (rechts)",
	-- achievementDisarmed		= "Zeige Timer für Erfolg 'Arm dran, weil Arm ab'",
	achievementDisarmed		= DBM_CORE_AUTO_TIMER_OPTIONS["achievement"]:format(GetAchievementLink(2953):gsub("%[(.+)%]", "%1")),
			-- spellName = select(2, GetAchievementInfo(spellId))
	WarnGrip				= "Verkünde Ziele von Steinerner Griff",
	-- SetIconOnGripTarget		= "Setze Zeichen auf Steinerner-Griff-Ziele",
	-- SetIconOnGripTarget		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(64292), 	-- en handles this
	-- SetIconOnEyebeamTarget	= "Setze Zeichen auf Ziele von Fokussierter Augenstrahl (Mond)", 	-- en handles this
	-- PlaySoundOnEyebeam		= "Spiele Sound bei Fokussiertem Augenstrahl" 	-- en handles this
	YellOnBeam				= "Schreie wenn $spell:63346 auf dir"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "Das ist nur ein Kratzer!",	
	Yell_Trigger_arm_right		= "Ist nur 'ne Fleischwunde!",
	Health_Body			= "Kologarn",
	Health_Right_Arm		= "Rechter Arm",
	Health_Left_Arm			= "Linker Arm",
	FocusedEyebeam			= "fokussiert seinen Blick auf Euch",
	YellBeam				= "Fokussierter Augenstrahl auf mir!"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender 		= "Wilder Verteidiger (%d)",
	YellPull = "In manche Dinge mischt man sich besser nicht ein!"
}

L:SetTimerLocalization{
	timerDefender	= "Wilder Verteidiger wird aktiviert"
}

L:SetWarningLocalization{
	SpecWarnBlast		= "Schildwachenschlag - Unterbrechen!",
	SpecWarnVoid		= "Sickernde wilde Essenz - lauf!",
	WarnCatDied 		= "Wilder Verteidiger tot (%d Leben übrig)",
	WarnCatDiedOne	 	= "Wilder Verteidiger tot (1 Leben übrig)",
	WarnFearSoon 		= "Nächstes Schreckliches Kreischen gleich"
}

L:SetOptionLocalization{
	SpecWarnBlast		= "Zeige Spezialwarnung bei $spell:64389 (zum Unterbrechen)",
	SpecWarnVoid		= "Zeige Spezialwarnung wenn von Sickernde wilde Essenz betroffen",
	WarnFearSoon		= "Zeige Vorwarnung für Schreckliches Kreischen",
	WarnCatDied		= "Zeige Warnung wenn ein Wilder Verteidiger stirbt",
	WarnCatDiedOne	= "Zeige Warnung wenn Wilder Verteidiger 1 Leben übrig hat",
	timerDefender	= "Zeige Timer für Aktivierung des Wilden Verteidigers"
}

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetWarningLocalization{
	WarningFlashFreeze	= "Blitzeis",
	specWarnBitingCold	= "Beißende Kälte - beweg dich"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	-- WarningFlashFreeze	= "Zeige Spezialwarnung für Blitzeis",
	-- PlaySoundOnFlashFreeze	= "Spiele Sound bei Blitzeis-Zauber",
	-- PlaySoundOnFlashFreeze	= DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(61968), 	-- en handles this
	YellOnStormCloud	= "Schreie bei $spell:65133 auf dir",
	-- SetIconOnStormCloud	= "Setze Zeichen auf Spieler mit Sturmwolke",
	-- SetIconOnStormCloud		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(65133) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:16|t)", 	-- en handles this
	-- SetIconOnFreeze			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(62469) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:16|t)" 	-- en handles this
	-- specWarnBitingCold		= "Zeige Spezialwarnung wenn du von Beißende Kälte betroffen bist"
}

L:SetMiscLocalization{
	YellKill		= "Ich... bin von ihm befreit... endlich.", 
	YellCloud		= "Sturmwolke auf mir!"
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
	LightningOrb			= "Blitzladung auf dir, lauf weg!"
}

L:SetTimerLocalization{
	TimerHardmode			= "Hard Mode"
}

L:SetOptionLocalization{
	TimerHardmode			= "Zeige Timer für Hard Mode",
	RangeFrame			= "Zeige Abstandsfenster (10 m)",
	AnnounceFails	= "Poste Spielerfehler für Blitzladung in Raidchat\n(benötigt aktivierte Ankündigungen und (L)- oder (A)-Status)",
	LightningOrb	= "Zeige Spezialwarnung für Blitzschock"
}

L:SetMiscLocalization{
	YellPhase1		= " Eindringlinge! Ihr Sterblichen, die Ihr es wagt, Euch in mein Vergnügen einzumischen, werdet... Wartet... Ihr...",
	YellPhase2		= "Ihr unverschämtes Geschmeiß! Ihr wagt es, mich in meinem Refugium herauszufordern? Ich werde Euch eigenhändig zerschmettern!",
	YellKill		= "Senkt Eure Waffen! Ich ergebe mich!",
	ChargeOn		= "Blitzladung: %s",
	Charge			= "Blitzladung-Fehler (dieser Versuch): %s" 
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell		= "Helft mir, Kinder!",
	WaterSpirit		= "Uralter Wassergeist",
	Snaplasher		= "Knallpeitscher",
	StormLasher		= "Sturmpeitscher",
	YellKill		= "Seine Macht über mich beginnt zu schwinden. Endlich kann ich wieder klar sehen. Ich danke Euch, Helden.",
	TrashRespawnTimer	= "Freya-Trash-Respawn",
	
	conservator_trigger = "Eonar, Eure Dienerin braucht Hilfe!",
	detonate_trigger    = "Der Schwarm der Elemente soll über Euch kommen!",
	elementals_trigger  = "Helft mir, Kinder!",
	tree_trigger        = "Ein |cFF00FFFFGeschenk der Lebensbinderin|r fängt an zu wachsen!",
	conservator_message = "Konservator!",
	detonate_message    = "Explosionspeitscher!",
	elementals_message  = "Elementare!",
	
	tree      = "Eonars Geschenk",
	tree_desc = "Warnt, wenn Eonars Geschenk auftaucht."
}

L:SetWarningLocalization{
	WarnSimulKill		= "Erster tot - Wiederbelebung in ~12 sec",
	SpecWarnFury		= "Furor der Natur auf dir!",
	WarningTremor		= "Bebende Erde - nicht mehr zaubern!",
	WarnRoots			= "Eiserne Wurzeln auf >%s<",
	UnstableEnergy		= "Instabile Energie - lauf!",
	SpecWarnEonarsGift  = "Eonars Geschenk"
}

L:SetTimerLocalization{
	TimerSimulKill		= "Wiederbelebung",
}

L:SetOptionLocalization{
	WarnSimulKill		= "Verkünde Tod des Ersten der Dreiergruppe",
	WarnRoots			= "Warnung für $spell:62438",
	SpecWarnFury		= "Zeige Spezialwarnung für $spell:63571",
	WarningTremor		= "Zeige Spezialwarnung für $spell:62859",
	-- PlaySoundOnFury 	= "Spiele Sound wenn du von $spell:63571 betroffen bist",
	PlaySoundOnFury 	= DBM_CORE_AUTO_SOUND_OPTION_TEXT_YOU:format(63571),
	-- PlaySoundOnGroundTremor = "Spiele Sound bei $spell:62859",
	PlaySoundOnGroundTremor = DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(62859),
	TimerSimulKill		= "Zeige Timer für Gegner-Wiederbelebung",
	UnstableEnergy		= "Zeige Spezialwarnung für $spell:62451",
	SpecWarnEonarsGift  = "Warnt, wenn Eonars Geschenk auftaucht."
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freyas Älteste"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "Freya-Trash-Respawn"
}

L:SetWarningLocalization{
	SpecWarnGroundTremor	= "Bebende Erde - Stoppe Zauber",
	SpecWarnFistOfStone		= "Fäuste aus Stein",
	specWarnPetrifiedBark	= "Versteinerte Rinde - Stoppe Nahkampf & Jäger"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone		= "Zeige Spezialwarnung für $spell:62344",
	SpecWarnGroundTremor	= "Zeige Spezialwarnung für $spell:62932",
	specWarnPetrifiedBark	= "Zeige Spezialwarnung für $spell:62933",
	PlaySoundOnFistOfStone	= "Spiele Sound bei $spell:62344",
	PlaySoundOnGroundTremor = DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(62932),
	PlaySoundOnPetrifiedBark	= "Spiele Sound bei $spell:62933",
	TrashRespawnTimer		= "Zeige Timer für Trash-Respawn"
}

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	DarkGlare			= "Lasersalve",
	MagneticCore		= ">%s< hat Magnetischen Kern",
	WarningShockBlast	= "Schockschlag - LAUF WEG",
	WarnBombSpawn		= "neuer Bombenbot",
	WarnPlasmaBlastSoon = "! Overheal Tank in 3 Sekunden !"
}

L:SetTimerLocalization{
	TimerHardmode	= "Hard Mode - Selbstzerstörung",
	TimeToPhase1	= "Phase 1 in",
	TimeToPhase2	= "Phase 2 in",
	TimeToPhase3	= "Phase 3 in",
	TimeToPhase4	= "Phase 4 in"
}

L:SetOptionLocalization{
	TimeToPhase1		= "Zeige Timer für Beginn der 1. Phase",
	TimeToPhase2		= "Zeige Timer für Beginn der 2. Phase",
	TimeToPhase3		= "Zeige Timer für Beginn der 3. Phase",
	TimeToPhase4		= "Zeige Timer für Beginn der 4. Phase",
	MagneticCore		= "Verkünde Looter des Magnetischen Kerns",
	HealthFramePhase4	= "Zeige Lebensanzeige in Phase 4",
	AutoChangeLootToFFA	= "Automatisch in Phase 3 Plündern auf 'Jeder gegen jeden' einstellen",
	WarnBombSpawn		= "Zeige Warnung für Bombenbot",
	TimerHardmode		= "Zeige Timer für Hard Mode",
	-- PlaySoundOnShockBlast	= "Spiele Sound bei Schockschlag",
	-- PlaySoundOnDarkGlare	= "Spiele Sound bei Lasersalve",
	ShockBlastWarningInP1	= "Zeige Spezialwarnung für $spell:63631 in Phase 1",
	ShockBlastWarningInP4	= "Zeige Spezialwarnung für $spell:63631 in Phase 4",
	RangeFrame				= "Zeige Abstandsfenster in Phase 1 (6 m)",
	-- SetIconOnNapalm			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(65026),
	-- SetIconOnPlasmaBlast	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(62997),
	WarnPlasmaBlastSoon		= "Zeige 3-Sekunden Vorwarnung für $spell:64529 (Overheal auf Tank)"
}

L:SetMiscLocalization{
	MobPhase1		= "Leviathan Mk II",
	MobPhase2		= "VX-001",
	MobPhase3		= "Luftkommandoeinheit",
	YellPull		= "Wir haben nicht viel Zeit, Freunde! Ihr werdet mir dabei helfen, meine neueste und großartigste Kreation zu testen. Bevor Ihr nun Eure Meinung ändert, denkt daran, dass Ihr mir etwas schuldig seid, nach dem Unfug, den Ihr mit dem XT-002 angestellt habt",	-- `entry`=-1603179
	YellHardPull		= "Warum habt Ihr das denn jetzt gemacht? Habt Ihr das Schild nicht gesehen, auf dem steht \"DIESEN KNOPF NICHT DRÜCKEN!\"? Wie sollen wir die Tests abschließen, solange der Selbstzerstörungsmechanismus aktiv ist?",	-- `entry`=-1603177
	YellPhase2		= "WUNDERBAR! Das sind Ergebnisse nach meinem Geschmack! Integrität der Hülle bei 98,9 Prozent! So gut wie keine Dellen! Und weiter geht's.",	-- `entry`=-1603182
	YellPhase3		= "Danke Euch, Freunde! Eure Anstrengungen haben fantastische Daten geliefert! So, wo habe ich noch gleich... Ah, hier ist…",	-- entry=-1603186
	YellPhase4		= "Vorversuchsphase abgeschlossen. Jetzt kommt der eigentliche Test!",	-- entry=-1603190
	LootMsg			= "([^%s]+).*Hitem:(%d+)",
	
	YellComputerHM	= "Selbstzerstörungssequenz eingeleitet.",	-- `entry`=-1603248
	YellComputerTimer10	= "Diese Zone wird sich in ZEHN Minuten selbst zerstören.",	-- `entry`=-1603249
	YellComputerTimer9	= "Diese Zone wird sich in NEUN Minuten selbst zerstören.",	-- `entry`=-1603250
	YellComputerTimer8	= "Diese Zone wird sich in ACHT Minuten selbst zerstören.",	-- `entry`=-1603251
	YellComputerTimer7	= "Diese Zone wird sich in SIEBEN Minuten selbst zerstören.",	-- `entry`=-1603252
	YellComputerTimer6	= "Diese Zone wird sich in SECHS Minuten selbst zerstören.",	-- `entry`=-1603253
	YellComputerTimer5	= "Diese Zone wird sich in FÜNF Minuten selbst zerstören.",	-- `entry`=-1603254
	YellComputerTimer4	= "Diese Zone wird sich in VIER Minuten selbst zerstören.",	-- `entry`=-1603255
	YellComputerTimer3	= "Diese Zone wird sich in DREI Minuten selbst zerstören.",	-- `entry`=-1603256
	YellComputerTimer2	= "Diese Zone wird sich in ZWEI Minuten selbst zerstören.",	-- `entry`=-1603257
	YellComputerTimer1	= "Diese Zone wird sich in EINER Minute selbst zerstören.",	-- `entry`=-1603258
	YellDefeat		= "Es scheint, als wäre mir eine klitzekleine Fehlkalkulation unterlaufen. Ich habe zugelassen, dass das Scheusal im Gefängnis meine Primärdirektive überschreibt. Alle Systeme nun funktionstüchtig.",	-- `entry`=-1603194
	
	MiscTemp		= "MiscTemp"
}

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "General Vezax"
}

L:SetTimerLocalization{
	hardmodeSpawn = "Saronitanimus erscheint"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash	= "Schattengeschoss auf dir",
	SpecialWarningSurgeDarkness	= "Sog der Dunkelheit",
	WarningShadowCrash		= "Schattengeschoss auf >%s<",
	SpecialWarningShadowCrashNear	= "Schattengeschoss in deiner Nähe!",
	WarningLeechLife		= "Mal der Gesichtslosen auf >%s<",
	SpecialWarningLLYou		= "Mal der Gesichtslosen auf dir!",
	SpecialWarningLLNear		= "Mal der Gesichtslosen auf >%s< in deiner Nähe!"
}

L:SetOptionLocalization{
	-- WarningShadowCrash			= "Verkünde Ziele von Schattengeschoss",
	-- SetIconOnShadowCrash		= "Setze Zeichen auf Ziele von Schattengeschoss (Totenkopf)",
	-- SetIconOnLifeLeach			= "Setze Zeichen auf Ziele von Mal der Gesichtslosen (Lebensentzug) (Kreuz)",
	-- SpecialWarningSurgeDarkness	= "1 Zeige Spezialwarnung für Sog der Dunkelheit",
	SpecialWarningShadowCrash	= "Zeige Spezialwarnung für $spell:62660 (muss anvisiert oder im Fokus eines Schlachtzugmitglieds sein)",
	SpecialWarningShadowCrashNear	= "Zeige Spezialwarnung bei $spell:62660 in deiner Nähe",
	-- SpecialWarningLLYou		= "4 Zeige Spezialwarnung für $spell:63276 auf DIR",
	SpecialWarningLLNear		= "Zeige Spezialwarnung für $spell:63276 in deiner Nähe",
	-- CrashWhisper				= "Flüstere Spieler an, die das Ziel von Schattengeschoss sind",
	YellOnLifeLeech				= "Schreie bei $spell:63276",
	YellOnShadowCrash			= "Schreie bei $spell:62660",
	-- WarningLeechLife			= "Verkünde Ziele von Mal der Gesichtslosen (Lebensentzug)",
	hardmodeSpawn				= "Zeige Timer für Spawn des Saronitanimus (Hard Mode)" --,
	-- CrashArrow					= "Mostrar una flecha cuando $spell:62660 va a caer cerca de ti",
	-- BypassLatencyCheck			= "No usar la comprobación de sincronización basada en latencia para $spell:62660\n(sólo usar esta opción si tienes problemas de otro modo)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "Eine Wolke Saronitdämpfe bildet sich in der Nähe!",
	CrashWhisper			= "Schattengeschoss auf dir - lauf weg!",
	YellLeech			= "Mal der Gesichtslosen auf mir!",
	YellCrash			= "Schattengeschoss auf mir!"
}

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 			= "Bald ist die Zeit gekommen, dem Untier den Kopf abzuschlagen! Konzentriert Euren Zorn und Euren Hass auf seine Diener!",	-- trinity 34346
	YellPhase2			= "KNIET NIEDER VOR DEM GOTT DES TODES!",	-- trinity 34357
	YellPhase3 			= "^Erblickt das wahre Antlitz des Todes und wisset",	-- trinity 34360
	Sara 				= "Sara",
	WarningYellSqueeze	= "Würgetentakel! Helft mir!"
	-- WarningYellSqueeze	= "Quetschen auf mir! Hilfe!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "neuer Wächter (%d)",
	WarningCrusherTentacleSpawned	= "neues Schmettertentakel",
	SpecWarnBrainLink 				= "Gehirnverbindung auf dir!",
	WarningSanity 					= "%d Geistige Gesundheit übrig",
	SpecWarnSanity 					= "%d Geistige Gesundheit übrig",
	SpecWarnGuardianLow 			= "Wächter nicht mehr angreifen!",
	SpecWarnMadnessOutNow			= "Wahnsinn hervorrufen - LAUF RAUS",
	WarnBrainPortalSoon				= "Gehirnportale in 3 Sek",	
	SpecWarnFervor					= "Saras Eifer auf dir!",
	SpecWarnFervorCast				= "Saras Eifer wird auf dich gezaubert",
	WarnEmpowerSoon					= "Machtvolle Schatten bald",
	SpecWarnMaladyNear				= "Geisteskrankheit auf %s in deiner Nähe",
	specWarnMaladyCast				= "Geisteskrankheit wird auf dich gezaubert",
	SpecWarnDeafeningRoar			= "Ohrenbetäubendes Gebrüll",
	specWarnBrainPortalSoon			= "Gehirnportale bald"
}

L:SetTimerLocalization{
	NextPortal	= "Gehirnportale"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= format("Zeige Warnung für neue |c%s%s|r", "ffff8040", "Wächter des Yogg-Saron"),
	-- WarningCrusherTentacleSpawned	= "Zeige Warnung für neue Schmettertentakel",
	WarningCrusherTentacleSpawned	= format("Zeige Warnung für neue |c%s%s|r", "ffff8040", "Schmettertentakel"),
	-- WarningBrainLink					= "Verkünde Ziele von Gehirnverbindung",
	-- SpecWarnBrainLink				= "Zeige Spezialwarnung wenn von Gehirnverbindung betroffen",
	WarningSanity					= "Zeige Warnung wenn $spell:63050 niedrig ist",
	SpecWarnSanity					= "Zeige Spezialwarnung wenn $spell:63050 sehr niedrig ist",
	SpecWarnGuardianLow				= format("Zeige Spezialwarnung wenn |c%s%s|r fast tot ist (für DDs)", "ffff8040", "Wächter des Yogg-Saron"),
	-- SpecWarnGuardianLow				= "Zeige Spezialwarnung wenn Wächter fast tot ist (für DDs)",
	WarnBrainPortalSoon				= format("Zeige Vorwarnung für |c%s%s|r", "ff40ff80", "Gehirnportale"),
	SpecWarnMadnessOutNow			= "Zeige Spezialwarnung kurz vor Ende von $spell:64059",
	-- SetIconOnMaladyTarget			= "Setze Zeichen auf Ziele von Geisteskrankheit", -- default EN handles this
	-- SpecWarnFervor					= "Zeige Spezialwarnung wenn du von $spell:63138 betroffen bist",
	SpecWarnFervorCast				= format("Zeige Spezialwarnung wenn $spell:63138 auf dich gezaubert wird (|c%s%s|r muss Ziel/Fokus eines Schlachtzugmitglieds sein)", "ffff8040", "Sara"),
	specWarnBrainPortalSoon			= format("Zeige Spezialwarnung für nächste |c%s%s|r", "ff40ff80", "Gehirnportale"),
	-- WarningSqueeze					= "Schreie bei Quetschen",
	WarningSqueeze					= format("Schreie wenn du von |c%s%s|r gefasst wirst", "ffff8040", "Würgetentakel"),
	warnSqueezeTarget				= format("Ziele von |c%s%s|r ($spell:64125) ansagen", "ffff8040", "Würgetentakel"),
	NextPortal						= format("Zeige Timer für nächste |c%s%s|r", "ff40ff80", "Gehirnportale"),
	-- SetIconOnFervorTarget			= "Setze Zeichen auf Spieler mit Saras Eifer", -- default EN handles this
	-- SetIconOnMCTarget				= "Setze Zeichen auf Spieler mit Gedanken beherrschen",
	ShowSaraHealth					= format("Zeige Lebensanzeige für |c%s%s|r in Phase 1 (|c%s%s|r muss Ziel/Fokus eines Schlachtzugmitglieds sein)", "ffff8040", "Sara", "ffff8040", "Sara"),
	-- WarnEmpowerSoon					= "Zeige Vorwarnung für Machtvolle Schatten",
	SpecWarnMaladyNear				= "Zeige Spezialwarnung für $spell:63881 in deiner Nähe",
	specWarnMaladyCast				= format("Zeige Spezialwarnung wenn $spell:63830 auf dich gezaubert wird (|c%s%s|r muss Ziel/Fokus eines Schlachtzugmitglieds sein)", "ffff8040", "Sara"),
	-- SpecWarnDeafeningRoar			= "Zeige Spezialwarnung wenn Ohrenbetäubendes Gebrüll gezaubert wird (Stille und für Vala'nyr)",
	-- SetIconOnBrainLinkTarget			= "Setze Zeichen auf Ziele von Gehirnverbindung", -- default EN handles this
	
	SetIconOnConstrictorTarget		= format("Setze Zeichen auf Ziele von |c%s%s|r", "ffff8040", "Würgetentakel") .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:16|t)",
	
	MaladyArrow						= "Zeige DBM Pfeil wenn $spell:63881 in deiner Nähe ist",
	RangeFramePortal25				= format("Zeige Abstandsfenster für |c%s%s|r (25 Spieler)", "ff40ff80", "Portal Positionen"),
	
	PlaySoundOnCrusher					= format("Spiele Sound für neue |c%s%s|r", "ffff8040", "Schmettertentakel"),
	-- ttsSpawnConstrictor				= format("Spiele Sound für neue |c%s%s|r", "ffff8040", "Würgetentakel"),
	PlaySoundOnConstrictor			= format("Spiele Sound für neue |c%s%s|r", "ffff8040", "Würgetentakel"),
	
	ttsPortalIn10					= format("Spiele Sound als %s Vorwarnung für |c%s%s|r", SecondsToTime(10), "ff40ff80", "Gehirnportale"),
	ttsPortalCountdown				= format("5-Sekunden-Audio-Countdown bis |c%s%s|r", "ff40ff80", "Gehirnportale"),
	-- "5-second audio countdown to $spell:%d"
	
	PingConstrictorSelf 			= format("|cffffffffPing|r die Minimap wenn |c%s%s|r dich ergreift", "ffff8040", "Würgetentakel")
}

