if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L


----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Leviatán de llamas"
}

L:SetTimerLocalization{
}
	
L:SetMiscLocalization{
	YellPull	= "Entidades hostiles detectadas. Protocolo de evaluación de amenaza activado. Objetivo principal fijado. Tiempo restante para re-evaluación: 30 segundos.",
	Emote		= "%%s persigue a (%S+)%."
}

L:SetWarningLocalization{
	PursueWarn	    = "Persigue a >%s<!",
	warnNextPursueSoon	    = "Cambiara de objetivo en 5 seg",
	SpecialPursueWarnYou	= "¡Te persigue a ti!",
	-- SystemOverload			= "Kernüberladung",
	warnWardofLife			= "Sale un Guarda de Vida"
}

L:SetOptionLocalization{
	-- SystemOverload			= "Zeige Spezialwarnung für Kernüberladung",
	SpecialPursueWarnYou	= "Mostrar aviso especial cuando te persiga a ti.",
	PursueWarn				= "Mostrar aviso a quien persigue.",
	warnNextPursueSoon		= "Mostrar cuando va cambiar de objetivo.",
	warnWardofLife			= "Mostrar aviso cuando salga un Guarda de Vida"
}

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis el Maestro de la Caldera"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	-- WarningSlagPot			= "Schlackentopf auf >%s<",
	-- SpecWarnJetsCast		= "Flammenstrahlen - Stoppe Zauber"
}

L:SetOptionLocalization{
	-- SpecWarnJetsCast		= "Zeige Spezialwarnung für Flammenstrahlen-Zauber",
	-- WarningSlagPot			= "Verkünde Schlackentopf-Ziele",
	SlagPotIcon				= "Mostrar icono a quien agarró"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Tajoescama"
}

L:SetWarningLocalization{	
	-- SpecWarnDevouringFlame     = "Verschlingende Flamme - LAUF RAUS",
	warnTurretsReadySoon		= "La torreta estara lista en 20 segundos",
	warnTurretsReady		    = "La torreta esta LISTA",
	SpecWarnDevouringFlameCast	= "Llava devoradora en Ti",
	WarnDevouringFlameCast		= "Llama devoradora en >%s<" 
}

L:SetTimerLocalization{
	timerTurret1			    = "Torreta 1",
	timerTurret2			    = "Torreta 2",
	timerTurret3			    = "Torreta 3",
	timerTurret4			    = "Torreta 4",
	timerGrounded		    = "En el suelo"
}

L:SetOptionLocalization{
	PlaySoundOnDevouringFlame	= "Mostrar aviso por sonido si pisas la Llama devoradora.",
	warnTurretsReadySoon		= "Mostrar aviso antes de que las torretas esten listas",
	warnTurretsReady		    = "Mostrar aviso si estan listas las torretas.",
	SpecWarnDevouringFlameCast	= "Mostrar aviso especial cuando $spell:64733 se lanze a ti.",
	timerTurret1			    = "Mostrar aviso para Torreta 1",
	timerTurret2			    = "Mostrar aviso para Torreta 2",
	timerTurret3			    = "Mostrar aviso para Torreta 3 ( solo en banda 25 ).",
	timerTurret4			    = "Mostrar aviso para Torreta 4 ( solo en banda 25 ).",
	OptionDevouringFlame		= "Mostrar aviso a quien lanza la Llama devoradora ( poco fiable )",
	timerGrounded		    = "Mostrar cuanto durara en el suelo."
}

L:SetMiscLocalization{
	YellAggro			= "¡Cuidado! Pronto saldrán a la superficie máquinas topo con esos desagradables enanos férreos a bordo!",	-- 1603038
	YellExtinguish		= "¡Llamas extintas! ¡Reconstruyamos esas torretas!",	-- 1603042
	-- YellAir				= "Danos un momento para que nos preparemos para construir las torretas.",
	-- YellAir2			= "Listos para salir, ¡impedid que esos enanos se peguen a nuestra espalda!!", -- 1603039 (for some reason - it should also be 1603042)
	YellGround			= "¡Moveros! ¡No seguira mucho mas en el suelo!",
	EmotePhase2			= "¡%%s ha aterrizado permanentemente!",
	FlamecastUnknown	= DBM_CORE_UNKNOWN
}

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "Desarmador XA-002"
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
	SetIconOnLightBombTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(65121),
	SetIconOnGravityBombTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(64234)
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "La Asamblea de Hierro"
}

L:SetWarningLocalization{
	-- WarningSupercharge			= "Superladung auf Boss"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	-- WarningSupercharge			= "Zeige Warnung wenn Superladung",
	PlaySoundLightningTendrils		= "Sonido para Zarcillos de relampagos",
	SetIconOnOverwhelmingPower	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(61888),
	SetIconOnStaticDisruption	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(61912),
	AlwaysWarnOnOverload			= "Siempre avisar Sobrecarga",
	PlaySoundOnOverload			= "Reproducir sonido para Sobrecarga",
	PlaySoundDeathRune			= "Reproducir sonido para Runa de muerte"
}

L:SetMiscLocalization{
	Steelbreaker		= "Rompeacero",
	RunemasterMolgeim	= "Maestro de runas Molgeim",
	StormcallerBrundir 	= "Clamatormentas Brundir",
}

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon el Observador"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Siguiente Estrella en colapso",
	PossibleNextCosmicSmash	= "Posible siguiente Machaque cósmico",
	TimerCombatStart		= "Empieza el combate"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "Cambiar de fase en >%s< - Stack %d",
	WarningCosmicSmash 		= "Machaque cósmico - Explosion en 4 segundos",
	WarnPhase2Soon			= "Fase 2 pronto",
	warnStarLow				= "Estrella en colapso a punto de morir"
}

L:SetOptionLocalization{
	WarningPhasePunch		= "Anunciar objetivos de Cambiar de fase",
	NextCollapsingStar		= "Mostrar tiempo para siguiente Estrella en colapso",
	WarningCosmicSmash 		= "Mostrar aviso para Machaque cósmico",
	PossibleNextCosmicSmash	= "Mostrar tiempo para posible siguiente Machaque cósmico",
	TimerCombatStart		= "Mostrar tiempo para el inicio del combate",
	WarnPhase2Soon			= "Mostrar pre-aviso para Fase 2 (al ~23%)",
	warnStarLow				= "Mostrar aviso especial cuando una Estrella en colapso esté a punto de morir (al ~25%)"
}

L:SetMiscLocalization{
	YellPull				= "Vuestros actos carecen de lógica. Se ha calculado cualquier posible resultado de este encuentro. El Panteón recibirá el mensaje del Observador sean cuales sean las consecuencias.",
	YellKill				= "I have seen worlds bathed in the Makers' flames. Their denizens fading without so much as a whimper. Entire planetary systems born and raised in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart, devoid of emotion... of empathy. I... have... felt... NOTHING! A million, million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?",--translate
	Emote_CollapsingStar	= "¡%s comienza a invocar estrellas en colapso!",
	Phase2					= "¡Observad las herramientas de la creación!",
	PullCheck				= "Tiempo hasta que Algalon transmita la señal de auxilio= (%d+) min."
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetWarningLocalization{
	-- SpecialWarningEyebeam		= "Augenstrahl auf dir - Lauf",
	-- WarningEyebeam				= "Augenstrahl auf >%s<",
	-- WarnGrip					= "Steinerner Griff auf >%s<",
	-- SpecWarnCrunchArmor2	= "Rüstung zermalmen >%d< auf dir"
}

L:SetTimerLocalization{
	timerLeftArm			= "Reaparición del brazo izquierdo",
	timerRightArm			= "Reaparición del brazo derecho",
	achievementDisarmed		= "Tiempo para desarmar"
}

L:SetOptionLocalization{
	-- SpecialWarningEyebeam	= "Zeige Spezialwarnung wenn von Fokussierter Augenstrahl betroffen",
	-- SpecWarnCrunchArmor2	= "Zeige Spezialwarnung für Rüstung zermalmen (>=2 Stacks)",
	-- WarningEyeBeam			= "Verkünde Augenstrahl-Ziele",
	timerLeftArm			= "Mostrar tiempo para Brazo izquierdo",
	timerRightArm			= "Mostrar tiempo para Brazo derecho",
	-- achievementDisarmed		= "Mostrar tiempo para el logro Desarmar",
	achievementDisarmed		= DBM_CORE_AUTO_TIMER_OPTIONS["achievement"]:format(GetAchievementLink(2953):gsub("%[(.+)%]", "%1")),
	-- WarnGrip				= "Verkünde Ziele von Steinerner Griff",
	SetIconOnGripTarget		= "Poner icono a los objetivos de Agarrar",
	SetIconOnEyebeamTarget	= "Poner iconos en objetivos de Haz ocular (luna)",
	PlaySoundOnEyebeam		= "Reproducir sonido al ser ojetivo de Haz ocular",
	YellOnBeam				= "Gritar cuando tengas $spell:63346",
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "¡No es más que un arañazo!",
	Yell_Trigger_arm_right	= "¡No es más que un arañazo!",
	Health_Body				= "Kologarn",
	Health_Right_Arm		= "Brazo derecho",
	Health_Left_Arm			= "Brazo izquierdo",
	FocusedEyebeam			= "sus ojos en ti",
	YellBeam				= "¡Haz ocular enfocado en mi!"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender = "Defensor feral (%d)",
	YellPull = "¡Es mejor dejar ciertas cosas tal como están!"
}

L:SetTimerLocalization{
	timerDefender	= "Se activa Defensor feral"
}

L:SetWarningLocalization{
	SpecWarnBlast		= "Explosión de centinela - Interrumpe!",
	-- SpecWarnVoid		= "Sickernde wilde Essenz - lauf!",
	WarnCatDied 		= "Defensor feral muerto (Le quedan %d vidas)",
	WarnCatDiedOne 		= "Defensor feral muerto (Le queda 1 vida)" --,
	-- WarnFearSoon 		= "Nächstes Schreckliches Kreischen gleich"
}

L:SetOptionLocalization{
	SpecWarnBlast		= "Mostrar aviso especial para Explosión de centinela",
	-- SpecWarnVoid		= "Zeige Spezialwarnung wenn von Sickernde wilde Essenz betroffen",
	-- WarnFearSoon		= "Zeige Vorwarnung für Schreckliches Kreischen",
	WarnCatDied			= "Mostrar aviso cuando Defensor Feral muere",
	WarnCatDiedOne		= "Mostrar aviso cuando Defensor Feral muere",
	timerDefender		= "Mostrar tiempo para activación de Defensor feral"
}

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetWarningLocalization{
	-- WarningFlashFreeze	= "Blitzeis",
	-- specWarnBitingCold	= "Beißende Kälte - beweg dich"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	-- WarningFlashFreeze	= "Zeige Spezialwarnung für Blitzeis",
	PlaySoundOnFlashFreeze	= "Reproducir sonido cuando castee Congelación apresurada",
	YellOnStormCloud		= "Gritar cuando tengas Nube tormentosa",
	SetIconOnStormCloud		= "Poner iconos en los objetivos de Nube tormentosa" --,
	-- specWarnBitingCold		= "Zeige Spezialwarnung wenn du von Beißende Kälte betroffen bist"
}

L:SetMiscLocalization{
	YellKill	= "Estoy... estoy libre de sus garras... al fin.",
	YellCloud	= "Nube tormentosa en mi!"
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
	-- LightningOrb			= "Blitzladung auf dir, lauf weg!"
}

L:SetTimerLocalization{
	TimerHardmode	= "Hard mode"
}

L:SetOptionLocalization{
	TimerHardmode	= "Mostrar tiempo para hard mode",
	RangeFrame		= "Mostrar distancia",
	AnnounceFails	= "Anunciar los fallos de Cargar relámpago en el chat de banda\n(require 'anunciar' habilitado y líder o ayudante de banda)" --,
	-- LightningOrb	= "Zeige Spezialwarnung für Blitzschock"
}

L:SetMiscLocalization{
	YellPhase1	= "¡Intrusos! Vosotros, mortales que osáis interferir en mi diversión, pagareis... Un momento...",
	YellPhase2	= "Gusanos impertinentes, ¿cómo osáis desafiarme en mi pedestal? ¡Os machacaré con mis propias manos!",
	YellKill	= "¡Guardad las armas! ¡Me rindo!",
	ChargeOn	= "Cargar relámpago: %s",
	Charge		= "Fallos de Cargar relámpago (este try): %s" 
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell	= "¡Hijos, ayudadme!",
	WaterSpirit	= "Espíritu de agua antiguo",
	Snaplasher	= "Quiebrazotador",
	StormLasher	= "Azotador de tormenta",
	YellKill	= "Su control sobre mí se disipa. Vuelvo a ver con claridad. Gracias, héroes.",
	TrashRespawnTimer	= "Reaparicion de Adds de Freya",
	
	conservator_trigger = "¡Eonar, tus sirvientes requieren tu ayuda!",
	detonate_trigger    = "¡El azote de los elementos podrá con vosotros!",
	elementals_trigger  = "¡Hijos, ayudadme!",
	tree_trigger        = "|cFF00FFFFDon de Eonar|r",  --"¡El |cFF00FFFFDon de Eonar|r empieza a brotar!" -- verificar
	conservator_message = "¡Conservador!",
	detonate_message    = "¡Azotadores detonantes!",
	elementals_message  = "¡Elementales!",
	
	tree      = "Don de Eonar",
	tree_desc = "Alerta cuando Freya invoca un Don de Eonar."
}

L:SetWarningLocalization{
	WarnSimulKill		= "Primer add muerto - Resurrección en ~12 seg",
	SpecWarnFury		= "¡Furia de la naturaleza sobre ti!",	-- deepl.com translation
	WarningTremor		= "¡Tremor terrenal - dejar de lanzar hechizos!",	-- deepl.com translation
	WarnRoots			= "Raíces férreas sobre >%s<",	-- deepl.com translation
	UnstableEnergy		= "Energía inestable - ¡Muévete!",
	SpecWarnEonarsGift  = "Don de Eonar"
}

L:SetTimerLocalization{
	TimerSimulKill		= "Resurrección",
}

L:SetOptionLocalization{
	WarnSimulKill		= "Anunciar primer mob muerto",
	WarnRoots			= "Mostrar aviso para  $spell:62438",
	SpecWarnFury		= "Mostrar aviso especial para $spell:63571",
	WarningTremor		= "Mostrar aviso especial para $spell:62859",
	PlaySoundOnFury 	= "Reproducir sonido cuando te afecte $spell:63571",
	PlaySoundOnGroundTremor = DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(62859),
	TimerSimulKill		= "Mostrar resureccion de los mobs",
	UnstableEnergy		= "Mostrar aviso especial para $spell:62451",
	SpecWarnEonarsGift  = "Alerta cuando Freya invoca un Don de Eonar."
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Ancestros de Freya"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "Reaparicion de Adds de Freya"
}

L:SetWarningLocalization{
	SpecWarnGroundTremor	= "Tremor terrenal - dejar de lanzar hechizos!",
	SpecWarnFistOfStone		= "Puños de piedra",
	specWarnPetrifiedBark	= "Petrified Bark - Detener melé & Cazador"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone		= "Mostrar aviso especial para $spell:62344",
	SpecWarnGroundTremor	= "Mostrar aviso especial para $spell:62932",
	specWarnPetrifiedBark	= "Mostrar aviso especial para $spell:62933",
	PlaySoundOnFistOfStone	= "Reproducir sonido cuando castee $spell:62344",
	PlaySoundOnGroundTremor = DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(62932),
	PlaySoundOnPetrifiedBark	= "Reproducir sonido cuando castee $spell:62933",
	TrashRespawnTimer		= "Mostrar tiempo para reaparición de adds"
}

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	-- DarkGlare		= "Lasersalve",
	MagneticCore		= ">%s< tiene Núcleo magnético",
	WarningShockBlast	= "¡Explosión de choque! ¡Muévete!",
	WarnBombSpawn		= "Robot bum sale"
}

L:SetTimerLocalization{
	TimerHardmode		= "Modo Difícil - Autodestrucción",
	TimeToPhase1		= "Fase 1",
	TimeToPhase2		= "Fase 2",
	TimeToPhase3		= "Fase 3",
	TimeToPhase4		= "Fase 4"
}

L:SetOptionLocalization{
	-- DarkGlare		= "Zeige Spezialwarnung für Lasersalve",
	TimeToPhase1			= "Mostrar tiempo para Fase 1",
	TimeToPhase2			= "Mostrar tiempo para Fase 2",
	TimeToPhase3			= "Mostrar tiempo para Fase 3",
	TimeToPhase4			= "Mostrar tiempo para Fase 4",
	MagneticCore			= "Anunciar quen lootea Núcleo magnético",
	HealthFramePhase4		= "Mostrar barra de vida en la fase 4",
	AutoChangeLootToFFA		= "Canviar el loot a Botín Libre en la fase 3",
	WarnBombSpawn			= "Mostrar aviso para Robot bum",
	TimerHardmode			= "Mostrar tiempo para Modo Difícil",
	PlaySoundOnShockBlast	= "Reproducir sonido en Explosión de choque",
	PlaySoundOnDarkGlare	= "Reproducir sonido en Tromba de láseres",
	ShockBlastWarningInP1	= "Mostrar aviso especial para Explosión de choque en Fase 1",
	ShockBlastWarningInP4	= "Mostrar aviso especial para Explosión de choque en Fase 4",
	RangeFrame				= "Mostrar distáncia en Fase 1 (6 yardas)",
	SetIconOnNapalm			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(65026),
	SetIconOnPlasmaBlast	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(62997)
}

L:SetMiscLocalization{
	MobPhase1		= "Mk II de leviatán",
	MobPhase2		= "VX-001",
	MobPhase3		= "Unidad de mando aérea",
	YellPull		= "¡No tenemos mucho tiempo, amigos! Vais a ayudarme a probar mi última y mayor creación. Ahora, antes de que cambiéis de parecer, recordad que en cierta forma, me lo debéis después del desastre que causasteis con el XA-002.",	-- `entry`=-1603179
	YellHardPull	= 'Veamos, ¿cómo se os ocurre hacer algo así? ¿No habéis visto la señal que dice "NO PULSAR ESTE BOTÓN"? ¿Cómo vamos a acabar la prueba con el mecanismo de autodestrucción activado?',	-- `entry`=-1603177
	YellPhase2		= '¡ESTUPENDO! ¡Unos resultados definitivamente maravillosos! ¡La integridad del casco al 98,9 %! ¡Apenas un rasguño! ¡Adelante!',	-- `entry`=-1603182
	YellPhase3		= "¡Gracias amigos! ¡Vuestros esfuerzos me han proporcionado unos datos fantásticos! Veamos, ¿dónde puse?...ah, ahí está.",	-- entry=-1603186
	YellPhase4		= "Fase de prueba preliminar completada. ¡Ahora comienza la verdadera prueba!",	-- entry=-1603190
	LootMsg			= "([^%s]+).*Hitem:(%d+)",
	
	YellComputerHM	= "Secuencia de autodestrucción iniciada.",	-- `entry`=-1603248
	YellComputerTimer10	= "Esta zona se autodestruirá en diez minutos",	-- `entry`=-1603249
	YellComputerTimer9	= "Esta zona se autodestruirá en nueve minutos",	-- `entry`=-1603250
	YellComputerTimer8	= "Esta zona se autodestruirá en ocho minutos",	-- `entry`=-1603251
	YellComputerTimer7	= "Esta zona se autodestruirá en siete minutos",	-- `entry`=-1603252
	YellComputerTimer6	= "Esta zona se autodestruirá en seis minutos",	-- `entry`=-1603253
	YellComputerTimer5	= "Esta zona se autodestruirá en cinco minutos",	-- `entry`=-1603254
	YellComputerTimer4	= "Esta zona se autodestruirá en cuatro minutos",	-- `entry`=-1603255
	YellComputerTimer3	= "Esta zona se autodestruirá en tres minutos",	-- `entry`=-1603256
	YellComputerTimer2	= "Esta zona se autodestruirá en dos minutos",	-- `entry`=-1603257
	YellComputerTimer1	= "Esta zona se autodestruirá en un minuto",	-- `entry`=-1603258
	YellDefeat		= "Parece que me he equivocado en los cálculos. Permití que el demonio de la prisión corrompiera mi mente y se sobrepusiera a mi directiva principal. Ahora parece que todos los sistemas funcionan. Evidente.",	-- `entry`=-1603194
	
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
	hardmodeSpawn = "Animus de saronita sale"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "¡Fragor de sombra en ti! ¡Muévete!",
	-- SpecialWarningSurgeDarkness	= "Sog der Dunkelheit",
	-- WarningShadowCrash		= "Schattengeschoss auf >%s<",
	SpecialWarningShadowCrashNear	= "Fragor de sombra cerca de ti!",
	-- WarningLeechLife		= "Mal der Gesichtslosen auf >%s<",
	-- SpecialWarningLLYou		= "Mal der Gesichtslosen auf dir!",
	SpecialWarningLLNear			= "Drenar vida en %s cerca de ti"
}

L:SetOptionLocalization{
	-- WarningShadowCrash		= "Verkünde Ziele von Schattengeschoss",
	SetIconOnShadowCrash			= "Poner iconos en los objetivos de $spell:62660 (calavera)",
	SetIconOnLifeLeach				= "Poner iconos en los objetivos de $spell:63276 (cruz)",
	-- SpecialWarningSurgeDarkness	= "Zeige Spezialwarnung für Sog der Dunkelheit",
	SpecialWarningShadowCrash		= "Mostrar aviso especial para $spell:62660/n(Tiene que ser el objetivo o el foco de al menos un personaje de la banda)",
	SpecialWarningShadowCrashNear	= "Mostrar aviso especial para $spell:62660 cerca de ti",
	-- SpecialWarningLLYou		= "Zeige Spezialwarnung für Mal der Gesichtslosen (Lebensentzug) auf DIR",
	SpecialWarningLLNear			= "Mostrar aviso especial para $spell:63276 cerca de ti",
	-- CrashWhisper			= "Flüstere Spieler an, die das Ziel von Schattengeschoss sind",
	YellOnLifeLeech					= "Gritar si tienes $spell:63276",
	YellOnShadowCrash				= "Gritar si eres objetivo de $spell:62660",
	-- WarningLeechLife				= "Verkünde Ziele von Mal der Gesichtslosen (Lebensentzug)",
	hardmodeSpawn					= "Mostrar tiempo para salida de Animus de saronita (Modo Difícil)",
	CrashArrow						= "Mostrar una flecha cuando $spell:62660 va a caer cerca de ti",
	BypassLatencyCheck				= "No usar la comprobación de sincronización basada en latencia para $spell:62660\n(sólo usar esta opción si tienes problemas de otro modo)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "¡Cerca se forma una nube de vapores de saronita!",
	-- CrashWhisper			= "Schattengeschoss auf dir - lauf weg!",
	YellLeech			= "¡Drenar vida en mi!",
	YellCrash			= "¡Fragor de sombra en mi!"
}

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 			= "^¡Pronto llegará la hora de golpear la cabeza del monstruo", -- trinity 34346	
	YellPhase2 			= "¡INCLINAOS ANTE EL DIOS DE LA MUERTE!",	-- trinity 34357
	YellPhase3 			= "^¡Observad el auténtico rostro de la muerte y descubrid",	-- trinity 34360
	Sara 				= "Sara",
	WarningYellSqueeze	= "¡Tentáculo constrictor! ¡Ayudadme!"
	-- WarningYellSqueeze	= "¡Exprimir en mi! ¡Ayudadme!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Guardián %d sale",
	WarningCrusherTentacleSpawned	= "Tentáculo triturador sale",
	-- SpecWarnBrainLink 				= "Gehirnverbindung auf dir!",
	WarningSanity 					= "%d Cordura restante",
	SpecWarnSanity 					= "%d Cordura restante",
	SpecWarnGuardianLow				= "Deja de atacar a este Guardián",
	SpecWarnMadnessOutNow			= "Inducir a la locura terminando. Muévete!",
	WarnBrainPortalSoon				= "Portal cerebral en 3 segundos",
	SpecWarnFervor					= "Fervor de Sara en ti",
	SpecWarnFervorCast				= "Fervor de Sara esta siendo casteado en ti",
	-- WarnEmpowerSoon					= "Machtvolle Schatten bald",
	SpecWarnMaladyNear				= "Mal de la mente en %s cerca de ti",
	specWarnMaladyCast				= "Mal de la mente esta siendo casteado en ti",
	-- SpecWarnDeafeningRoar			= "Ohrenbetäubendes Gebrüll",
	specWarnBrainPortalSoon			= "Portal cerebral pronto"
}

L:SetTimerLocalization{
	NextPortal	= "Portal cerebral"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "Mostrar aviso cuando salga Guardián",
	-- WarningCrusherTentacleSpawned	= "Mostrar aviso cuando salga Tentáculo triturador",
	WarningCrusherTentacleSpawned	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(64145, "salga Tentáculo triturador"),
	-- WarningBrainLink				= "Verkünde Ziele von Gehirnverbindung",
	-- SpecWarnBrainLink				= "Zeige Spezialwarnung wenn von Gehirnverbindung betroffen",
	WarningSanity					= "Mostrar aviso cuando tengas poca $spell:63050",
	SpecWarnSanity					= "Mostrar aviso especial cuando tengas muy poca $spell:63050",
	SpecWarnGuardianLow				= "Mostrar aviso especial cuando el Guardián esté a punto de morir (Fase 1)",
	WarnBrainPortalSoon				= "Mostrar pre-aviso para Portal cerebral",
	SpecWarnMadnessOutNow			= "Mostrar aviso especial poco antes de que $spell:64059 termine",
	-- SetIconOnMaladyTarget				= "Poner iconos en los objetivos de $spell:63881", -- default EN handles this
	-- SpecWarnFervor					= "Zeige Spezialwarnung wenn du von Saras Eifer betroffen bist",
	SpecWarnFervorCast				= "Mostrar aviso especial cuando $spell:63138 esté siendo casteado en ti (Sara tiene que ser el objetivo o el foco de al menos un personaje de la banda)",
	specWarnBrainPortalSoon			= "Mostrar aviso especial para siguiente Portal cerebral",
	-- WarningSqueeze					= "Gritar si te afecta Exprimir",
	WarningSqueeze					= "Grita si te atrapa Tentáculo constrictor ($spell:64125)", 	-- deepl.com (npc name from trinity locales: 33983)
	NextPortal						= "Mostrar tiempo para siguiente Portal cerebral",
	-- SetIconOnFervorTarget			= "Poner iconos en los objetivos de $spell:63138", -- default EN handles this
	-- SetIconOnMCTarget				= "Setze Zeichen auf Spieler mit Gedanken beherrschen",
	ShowSaraHealth					= "Mostrar barra de vida de Sara en Fase 1 (Sara tiene que ser el objetivo o el foco de al menos un personaje de la banda)",
	-- WarnEmpowerSoon					= "Zeige Vorwarnung für Machtvolle Schatten",
	SpecWarnMaladyNear				= "Mostrar aviso especial para $spell:63881 cerca de ti",
	specWarnMaladyCast				= "Mostrar aviso especial cuando $spell:63881 esté siendo casteado en ti (Sara tiene que ser el objetivo o el foco de al menos un personaje de la banda)",
	-- SpecWarnDeafeningRoar			= "Zeige Spezialwarnung wenn Ohrenbetäubendes Gebrüll gezaubert wird (Stille und für Vala'nyr)",				
	-- SetIconOnBrainLinkTarget		= "Poner iconos en los objetivos de $spell:63802", -- default EN handles this
	MaladyArrow						= "Mostrar flecha cuando $spell:63881 está cerca de ti",
	RangeFramePortal25				= "Mostrar marco de distancia para posición de portal (25 jugadores)"	-- 1.4a (deepl.com translation)
}

