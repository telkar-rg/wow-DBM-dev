if GetLocale() ~= "frFR" then return end

local L


----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Léviathan des flammes"
}

L:SetTimerLocalization{
}
	
L:SetMiscLocalization{
	YellPull		= "Entités hostiles détectées. Protocole d'estimation de menace actif. Acquisition de la cible primaire. Décompte avant réévaluation : 30 secondes.",
	Emote			= "%%s poursuit (%S+)%."
}

L:SetWarningLocalization{
	PursueWarn				= "Poursuit >%s<!",
	warnNextPursueSoon		= "Changement de cible dans 5 Sec",
	SpecialPursueWarnYou	= "Vous êtes poursuivi !",
	SystemOverload			= "Extinction des systèmes !",
	warnWardofLife			= "Gardien de Vie vient d'arriver",
	warnWrithingLasher		= "Flagellant frémissant viens d'arriver"
}

L:SetOptionLocalization{
	SystemOverload			= "Afficher l'avertissement spécial pour la surchage du système",
	SpecialPursueWarnYou	= "Afficher l'avertissement spécial quand un joueur est poursuivi",
	PursueWarn				= "Afficher l'avertissement quand vous êtes poursuivi",
	warnNextPursueSoon		= "Prévenir avant la prochaine poursuite",
	warnWardofLife			= "Montre une alerte quand un Gardien de Vie arrive",
	warnWrithingLasher		= "Montre une alerte quand un Flagellant frémissant arrive"
}

-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis le maître de la Fournaise"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarningSlagPot			= "Marmite de scories sur >%s<",
	SpecWarnJetsCast		= "Flots de flammes - Stop Incantation"
}

L:SetOptionLocalization{
	-- SpecWarnJetsCast		= "Activer l'avertissement spécial pour les Flots de flammes (contresort)", 	-- en handles this
	-- WarningSlagPot			= "Annoncer la cible de la Marmite de scories", 	-- en handles this
	-- SlagPotIcon				= "Mettre une icône sur la cible de la Marmite de scories" 	-- en handles this
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Tranchécaille"
}     

L:SetWarningLocalization{
	SpecWarnDevouringFlame		= "Flamme dévorante - BOUGEZ",
	warnTurretsReadySoon		= "Quatrième tourelle à harpon prête dans 20 Sec",
	warnTurretsReady			= "Quatrième tourelle à harpon prête",
	SpecWarnDevouringFlameCast	= "Flamme dévorante sur Vous",
	WarnDevouringFlameCast		= "Flamme dévorante sur >%s<" 
}

L:SetTimerLocalization{
	timerTurret1			= "Tourelle 1",
	timerTurret2			= "Tourelle 2",
	timerTurret3			= "Tourelle 3",
	timerTurret4			= "Tourelle 4",
	timerGrounded		= "Sur le sol"
}

L:SetOptionLocalization{
	SpecWarnDevouringFlame		= "Activer l'avertissement spécial pour les Flammes dévorantes",
	PlaySoundOnDevouringFlame	= "Jouer un son quand vous êtes affecté par la Flamme dévorante",
	warnTurretsReadySoon		= "Activer le pré-avertissement pour les tourelles",
	warnTurretsReady			= "Activer l'avertissement pour les tourelles",
	SpecWarnDevouringFlameCast	= "Montre une alerte spéciale quand les $spell:64733 sont cast sur Vous",
	timerTurret1				= "Montre le timer pour la tourelle 1",
	timerTurret2				= "Montre le timer pour la tourelle 2",
	timerTurret3				= "Montre le timer pour la tourelle 3 (Héroique)",
	timerTurret4				= "Montre le timer pour la tourelle 4 (Héroique)",
	OptionDevouringFlame		= "Annonce la cible des Flammes dévorantes (Incertain)",
	timerGrounded			= "Montre le timer pour la phase au sol"
}

L:SetMiscLocalization{
	YellAggro			= "Soyez sur vos gardes ! Des taupes mécaniques ne vont pas tarder à émerger, avec de vilains nains sombrefers à bord !",	-- 1603038
	YellExtinguish		= "Incendie éteint ! Reconstruisons les tourelles !",	-- 1603042
	-- YellAir 			= "Laissez un instant pour préparer la construction des tourelles.",
	-- YellAir2			= "Incendie éteint ! Reconstruisons les tourelles !",
	YellGround			= "Faites vite ! Elle va pas rester au sol très longtemps !",
	EmotePhase2			= "bloquée au sol",
	FlamecastUnknown	= DBM_CORE_UNKNOWN
}

-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "Déconstructeur XT-002"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "Bombe de lumière sur TOI",
	SpecialWarningGravityBomb	= "Bombe à gravité sur TOI",
	specWarnConsumption			= "Zone de Vide - BOUGEZ !"
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "Activer l'avertissement spécial quand vous êtes affecté par la bombe de lumière",
	SpecialWarningGravityBomb	= "Activer l'avertissement spécial quand vous êtes affecté par la bombe à gravité",
	specWarnConsumption			= "Montre une alerte spéciale quand vous subissez des dégats venant des Zone de Vide ( Hard-mode )",
	-- SetIconOnLightBombTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(65121), 	-- en handles this
	-- SetIconOnGravityBombTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(64234) 	-- en handles this
}

-------------------
--  IronCouncil  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Assemblée du Fer"
}

L:SetWarningLocalization{
	WarningSupercharge			= "Supercharge imminente",
	RuneofDeath					= "Rune de mort - BOUGEZ",
	LightningTendrils			= "Vrilles de foudre - COURREZ",
	Overload					= "Surchage - BOUGEZ"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarningSupercharge			= "Activer l'avertissement quand la Supercharge est incanté",
	LightningTendrils			= "Activer l'avertissement spécial pour les Vrilles d'éclair",
	PlaySoundLightningTendrils	= "Jouer un son pour les Vrilles d'éclair",
	RuneofDeath					= "Activer l'avertissement spécial pour les runes de mort",
	-- SetIconOnOverwhelmingPower	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(61888), 	-- en handles this
	-- SetIconOnStaticDisruption	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(61912), 	-- en handles this
	Overload					= "Montre une alerte spéciale pour la Surcharge",
	AlwaysWarnOnOverload		= "Toujours alerter pour la surcharge (sinon seulement quand ciblé)",
	PlaySoundOnOverload			= "Joue un son à la surcharge",
	PlaySoundDeathRune			= "Joue un son pour les runes de mort"
}

L:SetMiscLocalization{
	Steelbreaker		= "Brise-acier",
	RunemasterMolgeim	= "Maître des runes Molgeim",
	StormcallerBrundir 	= "Mande-foudre Brundir"
}

---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon l'Observateur"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Prochain choc cosmique",
	PossibleNextCosmicSmash	= "Prochain Choc cosmique possible",
	TimerCombatStart		= "Le combat débute dans"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "Coup de poing phasique sur >%s<",
	WarningBlackHole		= "Trou noir",
	SpecWarnBigBang			= "Big Bang",
	PreWarningBigBang		= "Big Bang dans ~10 sec",
	WarningCosmicSmash 		= "Choc cosmique - Explosion dans 4 sec",
	SpecWarnCosmicSmash 	= "Choc cosmique"
}

L:SetOptionLocalization{
	SpecWarnPhasePunch		= "Activer l'avertissement spécial quand vous êtes la cible du coup de poing phasique",
	PreWarningBigBang		= "Pré annonce le Big Bang",
	SpecWarnBigBang			= "Montre une alerte spéciale pour le Big Bang",
	WarningPhasePunch		= "Annoncer la cible du Coup de poing phasique",
	WarningBlackHole		= "Annoncer les trous noirs",
	NextCollapsingStar		= "Montre un timer pour le prochain choque cosmique",
	WarningCosmicSmash 		= "Annonce le Choc cosmique",
	SpecWarnCosmicSmash 	= "Montre une alerte spéciale pour le Choc cosmique",
	PossibleNextCosmicSmash	= "Montre le timer pour un possible Choc cosmique",
	TimerCombatStart		= "Montre le timer avant le début du combat"
}

L:SetMiscLocalization{
	YellPull				= "Vos actions sont illogiques. Tous les résultats possibles de cette rencontre ont été calculés. Le panthéon recevra le message de l'Observateur quelque soit l'issue.",
	Emote_CollapsingStar	= "commence à lancer un effondrement",
	PullCheck				= "Signal de détresse d'Algalon transmis dans= (%d+) min."
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam	= "Rayon de l'Œil sur TOI - ECARTE-TOI",
	WarningEyeBeam			= "Rayon de l'Œil sur >%s<",
	WarnGrip				= "Poigne sur >%s<",
	SpecWarnCrunchArmor2	= "Broie armure >%d< sur Vous"
}

L:SetTimerLocalization{
	timerLeftArm			= "Repop du bras gauche",
	timerRightArm			= "Repop du bras droit",
	achievementDisarmed		= "Temps pour Désarmement"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam	= "Activer l'avertissement spécial quand vous êtes la cible du Rayon de l'Œil",
	SpecWarnCrunchArmor2	= "Montre une alerte spéciale pour Broie armure (>=2 stacks)",
	WarningEyeBeam			= "Annoncer la cible du Rayon de l'Œil",
	timerLeftArm			= "Afficher un timer pour le repop du bras gauche",
	timerRightArm			= "Afficher un timer pour le repop du bras droit",
	-- achievementDisarmed		= "Afficher un timer pour le Haut Fait Désarmement",
	achievementDisarmed		= DBM_CORE_AUTO_TIMER_OPTIONS["achievement"]:format(GetAchievementLink(2953):gsub("%[(.+)%]", "%1")),
	WarnGrip				= "Annonce les cibles de la poigne",
	SetIconOnGripTarget		= "Met une icône sur les joueurs victimes du sort poigne"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "Juste une éraflure !",
	Yell_Trigger_arm_right	= "Une blessure superficielle !",
	Health_Body				= "Torse de Kologarn",
	Health_Right_Arm		= "Bras droit",
	Health_Left_Arm			= "Bras gauche",
	FocusedEyebeam			= "concentre son regard sur vous"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender 			= "Défenseur farouche (%d)",
	YellPull 			= "Certaines choses ne doivent pas être dérangées !"
}

L:SetTimerLocalization{
	timerDefender		= "Défenseur farouche activé"
}

L:SetWarningLocalization{
	SpecWarnBlast 		= "Déflagration du factionnaire - Interrompu!",
	SpecWarnVoid		= "Zone de Vide - BOUGEZ!",
	WarnCatDied 		= "Défenseur farouche mort (%d vies restantes)",
	WarnCatDiedOne 		= "Défenseur farouche mort (1 vie en moins)",
	WarnFearSoon 		= "Hurlement terrifiant imminent"
}

L:SetOptionLocalization{
	SpecWarnBlast 		= "Activer l'avertissement spécial pour les $spell:64389",
	SpecWarnVoid		= "Montre une alerte spéciale quand vous êtes dans une Zone de Vide",
	WarnFearSoon 		= "Activer l'avertissement pour le Hurlement terrifiant imminent",
	WarnCatDied 		= "Activer l'avertissement quand un défenseur farouche meurt",
	WarnCatDiedOne		= "Montre une alerte spéciale quand un Défenseur farouche meurt",
	timerDefender       = "Montre un timer quand le Défenseur farouche est activé"
}

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetWarningLocalization{
	WarningFlashFreeze	= "Gel instantané",
	specWarnBitingCold	= "Froid mordant - BOUGEZ"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarningFlashFreeze		= "Activer l'avertissement pour le gel instantané",
	-- PlaySoundOnFlashFreeze	= "Jouer un son lors de l'incantation du gel instantané",
	-- PlaySoundOnFlashFreeze	= DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(61968), 	-- en handles this
	YellOnStormCloud		= "Crie quand $spell:65133 sur vous",
	-- SetIconOnStormCloud		= "Met une icône sur la cible de la tempête de glace",
	-- SetIconOnStormCloud		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(65133) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:16|t)", 	-- en handles this
	-- SetIconOnFreeze			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(62469) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:16|t)" 	-- en handles this
	-- specWarnBitingCold		= "Montre une alerte spéciale quand vous êtes affecter par Froid mordant"
}

L:SetMiscLocalization{
	YellKill		= "Je suis... libéré de son emprise... enfin.",
	YellCloud		= "Tempête de glace sur moi!"
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
	LightningOrb 			= "Horion de foudre sur TOI! Bouge!"
}

L:SetTimerLocalization{
	TimerHardmode	= "Mode difficile"
}

L:SetOptionLocalization{
	TimerHardmode			= "Afficher le timer pour le mode difficile",
	RangeFrame				= "Afficher la fenêtre de portée",
	AnnounceFails			= "Affiche les joueurs qui n'ont pas évité les Charges de foudre (Nécessite l'activation des annonces et être promu ou leader)",
	LightningOrb			= "Montre une alerte spéciale pour les Charges de foudre"
}

L:SetMiscLocalization{
	YellPhase1		= "Des intrus ! Mortels, vous qui osez me déranger en plein divertissement allez pay -  Attendez, vous -",
	YellPhase2		= "Avortons impertinents, vous osez me défier sur mon piédestal ? Je vais vous écraser moi-même !",
	YellKill		= "Retenez vos coups ! Je me rends !",
	ChargeOn		= "Charge(s) de foudre: %s",
	Charge			= "Charge(s) de foudre non évitée(s) (cet essai): %s" 
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell 			= "Mes enfants, venez m'aider !",
	WaterSpirit 		= "Esprit de l'eau ancien",
	Snaplasher 			= "Flagellant mordant",
	StormLasher 		= "Flagellant des tempêtes",
	YellKill			= "Son emprise sur moi se dissipe. J'y vois à nouveau clair. Merci, héros.",
	TrashRespawnTimer	= "Respawn des Trashs de Freya",
	
	conservator_trigger = "Eonar, ta servante a besoin d'aide !",
	detonate_trigger    = "La nuée des éléments va vous submerger !",
	elementals_trigger  = "Mes enfants, venez m'aider !",
	tree_trigger        = "Un |cFF00FFFFdon de la Lieuse-de-vie|r commence à pousser !",
	conservator_message = "Ancien conservateur !",
	detonate_message    = "Flagellants explosifs !",
	elementals_message  = "Élémentaires !",
	
	tree      = "Cadeau d'Eonar",
	tree_desc = "Prévient quand Freya fait apparaître un Cadeau d'Eonar."
}

L:SetWarningLocalization{
	WarnSimulKill 		= "Premier add mort - Résurrection dans 1 minute",
	SpecWarnFury 		= "Fureur de la nature sur VOUS!",
	WarningTremor   	= "Tremblement de terre - Arretez d'incanter!",
	WarnRoots			= "Racines de fer sur >%s<",
	UnstableEnergy		= "Energie instable - BOUGEZ!",
	SpecWarnEonarsGift  = "Cadeau d'Eonar"
}

L:SetTimerLocalization{
	TimerSimulKill 		= "Résurrection"
}

L:SetOptionLocalization{
	WarnSimulKill		= "Annonce la mort du premier mob",
	WarnRoots			= "Annonce les cibles des $spell:62438",
	SpecWarnFury		= "Montre des alertes spéciales pour la $spell:63571",
	WarningTremor		= "Montre une alerte spéciale pour le $spell:62859 (Hard-Mode)",
	PlaySoundOnFury 	= "Joue un sons quand vous êtes affecter par la $spell:63571",
	PlaySoundOnGroundTremor = DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(62859),
	TimerSimulKill		= "Montre le timer de la résurrection des mobs",
	UnstableEnergy		= "Montre une alerte spéciale pour $spell:62451",
	SpecWarnEonarsGift  = "Prévient quand Freya fait apparaître un Cadeau d'Eonar."
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freya's Elders"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "Respawn des Trashs de Freya"
}

L:SetWarningLocalization{
	SpecWarnGroundTremor	= "Tremblement de terre - Arrêtez les sorts !",
	SpecWarnFistOfStone		= "Poings de pierre",
	specWarnPetrifiedBark	= "Ecorce pétrifiée - Terminer rapproché & Chasseur"	-- deepl.com translation
}

L:SetOptionLocalization{
	SpecWarnFistOfStone		= "Montre une alerte spéciale pour $spell:62344",
	SpecWarnGroundTremor	= "Montre une alerte spéciale pour $spell:62932",
	specWarnPetrifiedBark	= "Montre une alerte spéciale pour $spell:62933",
	PlaySoundOnFistOfStone	= "Joue un son à l'incantation des $spell:62344",
	PlaySoundOnGroundTremor = DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(62932),
	PlaySoundOnPetrifiedBark	= "Joue un son à l'incantation des $spell:62933",
	TrashRespawnTimer		= "Montre le timer du repop des trashs"
}

-------------------
--  Mimiron  --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	DarkGlare			= "Barrage laser",
	MagneticCore		= ">%s< vient de loot le Core Magnétique",
	WarningShockBlast	= "Horion explosif - BOUGEZ",
	WarnBombSpawn		= "Robot Bombe vient de pop"
}

L:SetTimerLocalization{
	TimerHardmode		= "Hard Mode - Autodestruction",
	TimeToPhase1		= "Phase 1",
	TimeToPhase2		= "Phase 2",
	TimeToPhase3		= "Phase 3",
	TimeToPhase4		= "Phase 4"
}

L:SetOptionLocalization{
	TimeToPhase1			= "Montre le timer pour la Phase 1",
	TimeToPhase2			= "Montre le timer pour la Phase 2",
	TimeToPhase3			= "Montre le timer pour la Phase 3",
	TimeToPhase4			= "Montre le timer pour la Phase 4",
	MagneticCore			= "Annonce qui a loot le Core Magnétique",
	HealthFramePhase4		= "Montre les barres de vie dans la phase 4",
	AutoChangeLootToFFA		= "Met le butin en accès libre durant la phase 3",
	WarnBombSpawn			= "Annonce les Robots Bombes",
	TimerHardmode			= "Montre le timer pour le Hard Mode",
	-- PlaySoundOnShockBlast	= "Joue un son lors des Horions explosifs",
	-- PlaySoundOnDarkGlare	= "Joue un son au Barrage laser",
	ShockBlastWarningInP1	= "Montre une alerte spéciale pour les $spell:63631 durant la Phase 1",
	ShockBlastWarningInP4	= "Montre une alerte spéciale pour les $spell:63631 durant la Phase 4",
	RangeFrame				= "Affiche la fenêtre de portée pour la phase 1"
}

L:SetMiscLocalization{
	MobPhase1		= "Léviathan Mod. II",
	MobPhase2		= "VX-001",
	MobPhase3		= "Unité de commandement aérien",
	YellPull		= "Nous n'avons pas beaucoup de temps, les amis ! Vous allez m'aider à tester ma dernière création en date, la plus grande de toutes. Avant de changer d'avis, n'oubliez pas que que vous me devez bien ça après m'avoir complètement déglingué le XT-002.",	-- `entry`=-1603179	
	YellHardPull	= 'Mais, pourquoi avez-vous été faire une chose pareille ? Vous n\'avez donc pas vu le panneau : « NE PAS APPUYER SUR CE BOUTON ! » ? Comment allons-nous finir les essais avec le mécanisme d\'autodestruction activé ?',	-- `entry`=-1603177
	YellPhase2		= "MERVEILLEUX ! Résultats parfaitement formidables !",	-- `entry`=-1603182
	YellPhase3		= "Merci, les amis !",	-- entry=-1603186
	YellPhase4		= "Fin de la phase d'essais préliminaires",	-- entry=-1603190
	LootMsg			= "([^%s]+).*Hitem:(%d+)",
	
	YellComputerHM	= 'Initialisation de la séquence d\'autodestruction.',	-- `entry`=-1603248
	YellComputerTimer10	= 'Cette section va s\'autodétruire dans 10 minutes.',	-- `entry`=-1603249
	YellComputerTimer9	= 'Cette section va s\'autodétruire dans neuf minutes.',	-- `entry`=-1603250
	YellComputerTimer8	= 'Cette section va s\'autodétruire dans huit minutes.',	-- `entry`=-1603251
	YellComputerTimer7	= 'Cette section va s\'autodétruire dans sept minutes.',	-- `entry`=-1603252
	YellComputerTimer6	= 'Cette section va s\'autodétruire dans six minutes.',	-- `entry`=-1603253
	YellComputerTimer5	= 'Cette section va s\'autodétruire dans cinq minutes.',	-- `entry`=-1603254
	YellComputerTimer4	= 'Cette section va s\'autodétruire dans quatre minutes.',	-- `entry`=-1603255
	YellComputerTimer3	= 'Cette section va s\'autodétruire dans trois minutes.',	-- `entry`=-1603256
	YellComputerTimer2	= 'Cette section va s\'autodétruire dans deux minutes.',	-- `entry`=-1603257
	YellComputerTimer1	= 'Cette section va s\'autodétruire dans une minute.',	-- `entry`=-1603258
	YellDefeat		= 'Il semblerait que j\'aie pu faire une minime erreur de calcul. J\'ai permis à mon esprit de se laisser corrompre par ce démon dans la prison qui a désactivé ma directive principale. Tous les systèmes fonctionnent à nouveau. Terminé.',	-- `entry`=-1603194
	
	MiscTemp		= "MiscTemp"
}


--------------------
--  General Vezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "Général Vezax"
}

L:SetTimerLocalization{
	hardmodeSpawn = "Arriver d'Animus de saronite"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "Déferlante d'ombre sur VOUS",
	SpecialWarningSurgeDarkness		= "Vague de ténèbres",
	WarningShadowCrash				= "Déferlante d'ombre sur >%s<",
	SpecialWarningShadowCrashNear	= "Déferlante d'ombre à côté de VOUS!",
	WarningLeechLife				= "Marque du Sans-visage sur >%s<",
	SpecialWarningLLYou				= "Marque du Sans-visage sur VOUS!",
	SpecialWarningLLNear			= "Marque du Sans-visage sur %s à côté de VOUS!"
}

L:SetOptionLocalization{
	WarningShadowCrash				= "Montre une alerte spéciale pour les Déferlante d'ombre",
	-- SetIconOnShadowCrash			= "met une icône sur la cible des Déferlante d'ombre ( Tête de mort )",
	-- SetIconOnLifeLeach				= "Met une icône sur la cible de la Marque du Sans-visage ( Croix )",
	SpecialWarningSurgeDarkness		= "Montre une alerte spéciale pour les Vague de ténèbres",
	SpecialWarningShadowCrash		= "Montre une alerte spéciale pour les Déferlante d'ombre",
	SpecialWarningShadowCrashNear	= "Montre une alerte spéciale quand la Déferlante d'ombre tombe à côté de vous",
	SpecialWarningLLYou				= "Montre une alerte spéciale quand la Marque du Sans-visage est sur Vous",
	SpecialWarningLLNear			= "Montre une alerte spéciale quand la Marque du Sans-visage est à côté de vous",
	CrashWhisper					= "Envoie un whisp à la cible de la Déferlante d'ombre",
	YellOnLifeLeech					= "Crie pour la Marque du Sans-visage",
	YellOnShadowCrash				= "Crie pour la Déferlante d'ombre",
	WarningLeechLife				= "Annonce la cible de la Marque du Sans-visage",
	hardmodeSpawn					= "Montre le timer pour l'arriver d'Animus de saronite (Hard Mode)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "nuage de vapeurs saronitiques",
	CrashWhisper		= "Déferlante d'ombre sur toi ! BOUGE !",
	YellLeech			= "Marque du Sans-visage sur moi !",
	YellCrash			= "Déferlante d'ombre sur moi !"
}

------------------
--  Yogg Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 			= "^Il sera bientôt temps de frapper la tête de la bête",	-- trinity 34346
	YellPhase2 			= "^À GENOUX DEVANT LE DIEU DE LA MORT",	-- trinity 34357
	YellPhase3	 		= "^Contemplez le vrai visage de la mort, et sachez que votre fin approche",	-- trinity 34360
	Sara 				= "Sara",
	WarningYellSqueeze	= "Tentacule constricteur ! Aidez-moi !"
	-- WarningYellSqueeze	= "Ecrasement sur moi ! Aidez-moi !"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Un gardien vient d'arriver",
	WarningCrusherTentacleSpawned	= "Une Tentacule écraseur vient d'arriver",
	WarningBrainLink 				= "Cerveaux liés sur >%s< et >%s<",
	SpecWarnBrainLink 				= "Cerveaux liés sur Vous!",
	WarningSanity 					= "%d de Santé mentale restant",
	SpecWarnSanity 					= "%d de Santé mentale restant",
	SpecWarnGuardianLow				= "Arretez d'attaquer ce gardien !",
	SpecWarnMadnessOutNow			= "Incantation de Susciter la folie fini - SORTEZ",
	WarnBrainPortalSoon				= "Portail dans 3 sec",	
	SpecWarnFervor					= "Ferveur de Sara sur VOUS",
	SpecWarnFervorCast				= "Ferveur de Sara commence a incanter sur vous",
	WarnEmpowerSoon					= "Renforcement des ombres Bientôt !",
	SpecWarnMaladyNear				= "Mal de la raison à côté de vous sur >%s<",
	SpecWarnMaladyCast				= "Mal de la raison commence a incanter sur vous",
	SpecWarnDeafeningRoar			= "Rugissement assourdissant",
	specWarnBrainPortalSoon			= "Portail bientôt"
}

L:SetTimerLocalization{
	NextPortal			= "Portail du Cerveau"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "Annonce l'arrivée des Gardiens",
	-- WarningCrusherTentacleSpawned	= "Annonce l'arrivée des Tentacules",
	WarningCrusherTentacleSpawned	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(64145, "nouveau Tentacule écraseur"),
	-- WarningBrainLink				= "Annonce les Cerveaux liés",
	-- SpecWarnBrainLink				= "Montre une alerte spéciale quand il y a des Cerveaux liés",
	WarningSanity					= "Montre une alerte quand la $spell:63050 est basse",
	SpecWarnSanity					= "Montre une alerte quand la $spell:63050 est très basse",
	SpecWarnGuardianLow				= "Montre une alerte spéciale quand les gardiens (P1) n'a plus beaucoup de vie",
	WarnBrainPortalSoon				= "Annonce les Portails",
	SpecWarnMadnessOutNow			= "Montre une alerte spéciale avant la fin du cast de $spell:64059",
	-- SetIconOnMaladyTarget				= "Met une icône sur la cible du fear", -- default EN handles this
	-- SpecWarnFervor					= "Montre une alerte spéciale pour la ferveur de Sara",
	SpecWarnFervorCast				= "Montre une alerte spéciale quand la $spell:63138 commence a cast sur vous (Sara doit être Target/Focus par au moins un membre du raid)",
	specWarnBrainPortalSoon			= "Annonce l'arrivée d'un portail",
	-- WarningSqueeze					= "Annonce la cible d'Ecrasement",
	WarningSqueeze					= "Crier si attrapé par Tentacule constricteur ($spell:64125)", 	-- deepl.com (npc name from trinity locales: 33983)
	NextPortal						= "Montre un timer avant le prochain portail",
	-- SetIconOnFervorTarget			= "Met une icône sur les cible de la ferveur de Sara", -- default EN handles this
	-- SetIconOnMCTarget				= "met une icône sur la cible du contrôle mental",
	ShowSaraHealth					= "Montre la vie de Sara durant la P1 (Sara doit être Target/Focus par au moins un membre du raid)",
	-- WarnEmpowerSoon					= "Alerte avant le Renforcement des ombres",
	SpecWarnMaladyNear				= "Montre une alerte spéciale si une personne à côté de vous est victime du $spell:63881",
	specWarnMaladyCast				= "Montre une alerte spéciale quand la $spell:63881 commence a cast sur vous (Sara doit être Target/Focus par au moins un membre du raid)",
	-- SpecWarnDeafeningRoar			= "Montre une alerte spéciale pour le Rugissement assourdissant (silence et haut-fait)",
	-- SetIconOnBrainLinkTarget		= "Met une icone sur la cible des Cerveaux liés", -- default EN handles this
	-- MaladyArrow						= "Zeige DBM Pfeil wenn $spell:63881 in deiner Nähe ist",
	RangeFramePortal25				= "Afficher le cadre de distance pour la position du portail (25 joueurs)"	-- 1.4a (deepl.com translation)
}

