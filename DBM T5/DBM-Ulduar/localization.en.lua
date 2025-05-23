local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Flame Leviathan"
}

L:SetTimerLocalization{
}
	
L:SetMiscLocalization{
	YellPull	= "Hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus 30 seconds to re-evaluation.",
	Emote		= "%%s pursues (%S+)%."
}

L:SetWarningLocalization{
	PursueWarn				= "Pursuing >%s<",
	warnNextPursueSoon		= "Target change in 5 seconds",
	SpecialPursueWarnYou	= "You are being pursued - Run away",
	warnWardofLife			= "Ward of Life spawned"
}

L:SetOptionLocalization{
	SpecialPursueWarnYou	= "Show special warning when you are being $spell:62374",
	PursueWarn				= "Announce $spell:62374 targets",
	warnNextPursueSoon		= "Show pre-warning for next $spell:62374",
	warnWardofLife			= "Show special warning for Ward of Life spawn"
}

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis the Furnace Master"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	SlagPotIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(63477) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:16|t)"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Razorscale"
}

L:SetWarningLocalization{	
	warnTurretsReadySoon		= "Last turret ready in 20 seconds",
	warnTurretsReady			= "Last turret ready",
	SpecWarnDevouringFlameCast	= "Devouring Flame on you",
	WarnDevouringFlameCast		= "Devouring Flame on >%s<" 
}

L:SetTimerLocalization{
	timerTurret1	= "Turret 1",
	timerTurret2	= "Turret 2",
	timerTurret3	= "Turret 3",
	timerTurret4	= "Turret 4",
	timerGrounded	= "On the ground"
}

L:SetOptionLocalization{
	PlaySoundOnDevouringFlame	= "Play sound when you are affected by $spell:64733",
	warnTurretsReadySoon		= "Show pre-warning for turrets",
	warnTurretsReady			= "Show warning for turrets",
	SpecWarnDevouringFlameCast	= "Show special warning when $spell:64733 is cast on you",
	timerTurret1				= "Show timer for turret 1",
	timerTurret2				= "Show timer for turret 2",
	timerTurret3				= "Show timer for turret 3 (25 player)",
	timerTurret4				= "Show timer for turret 4 (25 player)",
	OptionDevouringFlame		= "Announce $spell:64733 targets (unreliable)",
	timerGrounded			    = "Show timer for ground phase duration"
}

L:SetMiscLocalization{
	YellAggro			= "Be on the lookout! Mole machines will be surfacing soon with those nasty Iron dwarves aboard!",	-- 1603038
	YellExtinguish		= "Fires out! Let's rebuild those turrets!",	-- 1603042
	-- YellAir				= "Give us a moment to prepare to build the turrets.",
	-- YellAir2			= "Fires out! Let's rebuild those turrets!",
	YellGround			= "Move quickly! She won't remain grounded for long!",
	EmotePhase2			= "%%s grounded permanently!",
	FlamecastUnknown	= DBM_CORE_UNKNOWN
}

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002 Deconstructor"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	SetIconOnLightBombTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(65121) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:16|t)",
	SetIconOnGravityBombTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(64234) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:16|t)"
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Iron Council"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	PlaySoundLightningTendrils	= "Play sound on $spell:63486",
	SetIconOnOverwhelmingPower	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(61888) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:16|t)",
	SetIconOnStaticDisruption	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(61912) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:16|t - |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:16|t)",
	AlwaysWarnOnOverload		= "Always warn on $spell:63481 (otherwise, only when targeted)",
	PlaySoundOnOverload			= "Play sound on $spell:63481",
	PlaySoundDeathRune			= "Play sound on $spell:63490"
}

L:SetMiscLocalization{
	Steelbreaker		= "Steelbreaker",
	RunemasterMolgeim	= "Runemaster Molgeim",
	StormcallerBrundir 	= "Stormcaller Brundir"
}

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon the Observer"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Next Collapsing Star",
	PossibleNextCosmicSmash	= "Next possible Cosmic Smash",
	TimerCombatStart		= "Combat starts"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "Phase Punch on >%s< - Stack %d",
	WarningCosmicSmash 		= "Cosmic Smash - Explosion in 4 seconds",
	WarnPhase2Soon			= "Phase 2 soon",
	warnStarLow				= "Collapsing Star is low"
}

L:SetOptionLocalization{
	SetIconOnCollapsingStar	= format("Set icons on |cFF%s%s|r (|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:16|t -  |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:16|t)", "ff8040", "Collapsing Star", 8, 5),
	WarningPhasePunch		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(64412, GetSpellInfo(64412) or "Phase Punch"),
	-- WarningPhasePunch		= "Announce Phase Punch targets",
	NextCollapsingStar		= "Show timer for next Collapsing Star",
	WarningCosmicSmash 		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(62311, GetSpellInfo(62311) or "Cosmic Smash"),
	-- WarningCosmicSmash 		= "Show warning for Cosmic Smash",
	PossibleNextCosmicSmash	= "Show timer for next possible $spell:62311",
	TimerCombatStart		= "Show timer for start of combat",
	WarnPhase2Soon			= "Show pre-warning for Phase 2 (at ~23%)",
	warnStarLow				= format("Show special warning when |cFF%s%s|r is low (at ~25%%)", "ff8040", "Collapsing Star")
	-- warnStarLow				= "Show special warning when Collapsing Star is low (at ~25%)"
}

L:SetMiscLocalization{
	YellPull				= "Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer's message regardless of outcome.",
	YellKill				= "I have seen worlds bathed in the Makers' flames, their denizens fading without as much as a whimper. Entire planetary systems born and razed in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart devoid of emotion... of empathy. I. Have. Felt. Nothing. A million-million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?",
	Emote_CollapsingStar	= "%s begins to Summon Collapsing Stars!",
	Phase2					= "Behold the tools of creation",
	PullCheck				= "Time until Algalon transmits distress signal= (%d+) min."
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	timerLeftArm		= "Left Arm respawn",
	timerRightArm		= "Right Arm respawn",
	achievementDisarmed	= "Timer for Disarm"
}

L:SetOptionLocalization{
	timerLeftArm			= "Show timer for Left Arm respawn",
	timerRightArm			= "Show timer for Right Arm respawn",
	-- achievementDisarmed		= "Show timer for Disarm achievement",
	achievementDisarmed		= DBM_CORE_AUTO_TIMER_OPTIONS["achievement"]:format(GetAchievementLink(2953):gsub("%[(.+)%]", "%1")),
	SetIconOnGripTarget		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(64292) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:16|t)",
	SetIconOnEyebeamTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(63346) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:16|t)",
	PlaySoundOnEyebeam		= DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(63346),
	YellOnBeam				= "Yell on $spell:63346"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "Just a scratch!",
	Yell_Trigger_arm_right	= "Only a flesh wound!",
	Health_Body				= "Kologarn Body",
	Health_Right_Arm		= "Right Arm",
	Health_Left_Arm			= "Left Arm",
	FocusedEyebeam			= "his eyes on you",
	YellBeam				= "Focused Eyebeam on me!"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender = "Feral Defender (%d)",
	YellPull = "Some things are better left alone!"
}

L:SetTimerLocalization{
	timerDefender	= "Feral Defender activates"
}

L:SetWarningLocalization{
	SpecWarnBlast	= "Sentinel Blast - Interrupt now",
	WarnCatDied		= "Feral Defender down (%d lives remaining)",
	WarnCatDiedOne	= "Feral Defender down (1 life remaining)",
}

L:SetOptionLocalization{
	SpecWarnBlast	= "Show special warning for $spell:64389 (to interrupt)",
	WarnCatDied		= "Show warning when Feral Defender dies",
	WarnCatDiedOne	= "Show warning when Feral Defender has 1 life remaining",
	timerDefender	= "Show timer for when Feral Defender is activated"
}

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	PlaySoundOnFlashFreeze	= DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(61968),
	YellOnStormCloud		= "Yell when $spell:65133 on you",
	-- SetIconOnStormCloud		= "Set icons on $spell:65133 targets"
	SetIconOnStormCloud		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(65133) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:16|t)",
	SetIconOnFreeze			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(62469) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:16|t)"
}

L:SetMiscLocalization{
	YellKill	= "I... I am released from his grasp... at last.",
	YellCloud	= "Storm Cloud on me!"
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	TimerHardmode	= "Hard mode"
}

L:SetOptionLocalization{
	TimerHardmode	= "Show timer for hard mode",
	RangeFrame		= "Show range frame",
	AnnounceFails	= "Post player fails for $spell:62017 to raid chat\n(requires announce to be enabled and leader/promoted status)"
}

L:SetMiscLocalization{
	YellPhase1	= "Interlopers! You mortals who dare to interfere with my sport will pay.... Wait--you...",
	YellPhase2	= "Impertinent whelps, you dare challenge me atop my pedestal? I will crush you myself!",
	YellKill	= "Stay your arms! I yield!",
	ChargeOn	= "Lightning Charge: %s",
	Charge		= "Lightning Charge fails (this try): %s" 
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell          = "Children, assist me!",
	WaterSpirit        = "Ancient Water Spirit",
	Snaplasher         = "Snaplasher",
	StormLasher        = "Storm Lasher",
	YellKill           = "His hold on me dissipates. I can see clearly once more. Thank you, heroes.",
	TrashRespawnTimer  = "Freya trash respawn",
	
	conservator_trigger = "Eonar, your servant requires aid!", -- from bigwigs mod
	detonate_trigger    = "The swarm of the elements shall overtake you!",
	elementals_trigger  = "Children, assist me!",
	tree_trigger        = "A |cFF00FFFFLifebinder's Gift|r begins to grow!",
	conservator_message = "Conservator!",
	detonate_message    = "Detonating lashers!",
	elementals_message  = "Elementals!",
	
	tree         = "Eonar's Gift",
	tree_desc    = "Alert when Freya spawns a Eonar's Gift."
}

L:SetWarningLocalization{
	WarnSimulKill		= "First add down - Resurrection in ~12 seconds",
	SpecWarnFury		= "Nature's Fury on you!",
	WarningTremor		= "Ground Tremor - stop casting!",
	WarnRoots			= "Iron Roots on >%s<",
	UnstableEnergy		= "Unstable Energy - run!",
	SpecWarnEonarsGift  = "Eonar's Gift"
}

L:SetTimerLocalization{
	TimerSimulKill		= "Resurrection"
}

L:SetOptionLocalization{
	WarnSimulKill		= "Announce first mob down",
	WarnRoots			= "Show warning for $spell:62438",
	SpecWarnFury		= "Show special warning for $spell:63571",
	WarningTremor		= "Show special warning for $spell:62859",
	PlaySoundOnFury 	= "Play sound when you are affected by $spell:63571",
	PlaySoundOnGroundTremor = DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(62859),
	PlaySoundOnEonarsGift = DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(62584),
	TimerSimulKill		= "Show timer for mob resurrection",
	UnstableEnergy		= "Show special warning for $spell:62451",
	SpecWarnEonarsGift  = "Alert when Freya spawns a Eonar's Gift.",
	SetIconOnNaturesFury = DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(63571) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:16|t)",
	SetIconOnIronRoots	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(62861) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:16|t)",
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freya's Elders"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "Freya trash respawn"
}

L:SetWarningLocalization{
	SpecWarnGroundTremor	= "Ground Tremor - Stop Casting!",
	SpecWarnFistOfStone		= "Fist Of Stone",
	specWarnPetrifiedBark	= "Petrified Bark - Stop Melee & Hunter"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone		= "Show special warning for $spell:62344",
	SpecWarnGroundTremor	= "Show special warning for $spell:62932",
	specWarnPetrifiedBark	= "Show special warning for $spell:62933",
	PlaySoundOnFistOfStone	= "Play sound on $spell:62344",
	PlaySoundOnGroundTremor = DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(62932),
	PlaySoundOnPetrifiedBark	= "Play sound on $spell:62933",
	TrashRespawnTimer		= "Show timer for trash respawn"
}

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	MagneticCore		= ">%s< has Magnetic Core",
	WarningShockBlast	= "Shock Blast - Run away",
	WarnBombSpawn		= "Bomb Bot spawned",
	WarnPlasmaBlastSoon = "! Overheal Tank in 3 seconds !"
}

L:SetTimerLocalization{
	TimerHardmode	= "Hard mode - Self-destruct",
	TimeToPhase1	= "Phase 1 in",
	TimeToPhase2	= "Phase 2 in",
	TimeToPhase3	= "Phase 3 in",
	TimeToPhase4	= "Phase 4 in"
}

L:SetOptionLocalization{
	TimeToPhase1			= "Show timer for Phase 1",
	TimeToPhase2			= "Show timer for Phase 2",
	TimeToPhase3			= "Show timer for Phase 3",
	TimeToPhase4			= "Show timer for Phase 4",
	MagneticCore			= "Announce Magnetic Core looters",
	HealthFramePhase4		= "Show health frame in Phase 4",
	AutoChangeLootToFFA		= "Switch loot mode to Free for All in Phase 3",
	WarnBombSpawn			= "Show warning for Bomb Bots",
	TimerHardmode			= "Show timer for hard mode",
	PlaySoundOnShockBlast	= DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(63631),--"Play sound on $spell:63631",
	PlaySoundOnDarkGlare	= DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(63414),--"Play sound on $spell:63414",
	ShockBlastWarningInP1	= "Show special warning for $spell:63631 in Phase 1",
	ShockBlastWarningInP4	= "Show special warning for $spell:63631 in Phase 4",
	RangeFrame				= "Show range frame in Phase 1 (6 yards)",
	SetIconOnNapalm			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(65026) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:16|t - |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:16|t)",
	SetIconOnPlasmaBlast	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(62997) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:16|t)",
	WarnPlasmaBlastSoon		= "Show 3 second pre-warning for $spell:64529 (overheal the tank)"
}

L:SetMiscLocalization{
	MobPhase1		= "Leviathan Mk II",
	MobPhase2		= "VX-001",
	MobPhase3		= "Aerial Command Unit",
	YellPull		= "We haven't much time, friends! You're going to help me test out my latest and greatest creation. Now, before you change your minds, remember that you kind of owe it to me after the mess you made with the XT-002.",	-- `entry`=-1603179	
	YellHardPull	= "^Now why would you go and do something like that? Didn't you see the sign that said",	-- `entry`=-1603177
	YellPhase2		= "WONDERFUL! Positively marvelous results! Hull integrity at 98.9 percent! Barely a dent! Moving right along.",	-- `entry`=-1603182
	YellPhase3		= "Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put-- oh, there it is.",	-- entry=-1603186
	YellPhase4		= "Preliminary testing phase complete. Now comes the true test!",	-- entry=-1603190
	LootMsg			= "([^%s]+).*Hitem:(%d+)",
	
	YellComputerHM	= "Self-destruct sequence initiated.",	-- `entry`=-1603248
	YellComputerTimer10	= "This area will self-destruct in ten minutes.",	-- `entry`=-1603249
	YellComputerTimer9	= "This area will self-destruct in nine minutes.",	-- `entry`=-1603250
	YellComputerTimer8	= "This area will self-destruct in eight minutes.",	-- `entry`=-1603251
	YellComputerTimer7	= "This area will self-destruct in seven minutes.",	-- `entry`=-1603252
	YellComputerTimer6	= "This area will self-destruct in six minutes.",	-- `entry`=-1603253
	YellComputerTimer5	= "This area will self-destruct in five minutes.",	-- `entry`=-1603254
	YellComputerTimer4	= "This area will self-destruct in four minutes.",	-- `entry`=-1603255
	YellComputerTimer3	= "This area will self-destruct in three minutes.",	-- `entry`=-1603256
	YellComputerTimer2	= "This area will self-destruct in two minutes.",	-- `entry`=-1603257
	YellComputerTimer1	= "This area will self-destruct in one minute.",	-- `entry`=-1603258
	YellDefeat		= "^It would appear that I've made a slight miscalculation.",	-- `entry`=-1603194
	
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
	hardmodeSpawn = "Saronite Animus spawn"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "Shadow Crash on you - Move away",
	SpecialWarningShadowCrashNear	= "Shadow Crash near you - Watch out",
	SpecialWarningLLNear			= "Mark of the Faceless on %s near you"
}

L:SetOptionLocalization{
	-- SetIconOnShadowCrash			= "Set icons on $spell:62660 targets (skull)",
	SetIconOnShadowCrash			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(62660) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:16|t)",
	-- SetIconOnLifeLeach				= "Set icons on $spell:63276 targets (cross)",
	SetIconOnLifeLeach				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(63276) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:16|t)",
	SpecialWarningShadowCrash		= "Show special warning for $spell:62660 (must be targeted or focused by at least one raid member)",
	SpecialWarningShadowCrashNear	= "Show special warning for $spell:62660 near you",
	SpecialWarningLLNear			= "Show special warning for $spell:63276 near you",
	YellOnLifeLeech					= "Yell on $spell:63276",
	YellOnShadowCrash				= "Yell on $spell:62660",
	hardmodeSpawn					= "Show timer for Saronite Animus spawn (hard mode)",
	CrashArrow						= "Show DBM arrow when $spell:62660 is near you",
	BypassLatencyCheck				= "Don't use latency based sync check for $spell:62660 (only use this if you're having problems otherwise)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "A cloud of saronite vapors coalesces nearby!",
	YellLeech			= "Mark of the Faceless on me!",
	YellCrash			= "Shadow Crash on me!"
}

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 			= "The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!",	-- trinity 34346
	YellPhase2 			= "BOW DOWN BEFORE THE GOD OF DEATH!",	-- trinity 34357
	YellPhase3	 		= "^Look upon the true face of death, and know that your end comes soon",	-- trinity 34360
	Sara 				= "Sara",
	WarningYellSqueeze	= "Constrictor Tentacle! Help me!"
	-- WarningYellSqueeze	= "Squeeze on me! Help me!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Guardian %d spawned",
	WarningCrusherTentacleSpawned	= "Crusher Tentacle spawned",
	WarningSanity 					= "%d Sanity remaining",
	SpecWarnSanity 					= "%d Sanity remaining",
	SpecWarnGuardianLow				= "Stop attacking this Guardian",
	SpecWarnMadnessOutNow			= "Induce Madness ending - Move out",
	WarnBrainPortalSoon				= "Brain Portal in 3 seconds",	
	SpecWarnFervor					= "Sara's Fervor on you",
	SpecWarnFervorCast				= "Sara's Fervor is being cast on you",
	SpecWarnMaladyNear				= "Malady of the Mind on %s near you",
	specWarnMaladyCast				= "Malady of the Mind is being cast on you",
	specWarnBrainPortalSoon			= "Brain Portal soon"
}

L:SetTimerLocalization{
	NextPortal	= "Brain Portal",
	timerCastDeafeningRoar	= "Roar",
	timerNextDeafeningRoar	= format(DBM_CORE_AUTO_TIMER_TEXTS.next, "Roar")
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= format("Show warning for new |c%s%s|r", "ffff8040", "Guardian of Yogg-Saron"),
	WarningCrusherTentacleSpawned	= format("Show warning when next |c%s%s|r spawns", "ffff8040", "Crusher Tentacle"),
	WarningSanity					= "Show warning when $spell:63050 is low",
	SpecWarnSanity					= "Show special warning when $spell:63050 is very low",
	SpecWarnGuardianLow				= format("Show special warning when |c%s%s|r is low (for DDs)", "ffff8040", "Guardian of Yogg-Saron"),
	WarnBrainPortalSoon				= format("Show pre-warning for |c%s%s|r", "ff40ff80", "Brain Portals"),
	SpecWarnMadnessOutNow			= "Show special warning shortly before $spell:64059 ends",
	-- SetIconOnMaladyTarget			= "Set icons on $spell:63881 targets",
	SetIconOnMaladyTarget			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(63830) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:16|t)",
	
	SpecWarnFervorCast				= format("Show special warning when $spell:63138 is being cast on you (|c%s%s|r must be target/focus of a raid member)", "ffff8040", "Sara"),
	specWarnBrainPortalSoon			= format("Show special warning for next |c%s%s|r", "ff40ff80", "Brain Portals"),
	-- WarningSqueeze					= "Yell on Squeeze",
	WarningSqueeze					= format("Yell when you get caught by |c%s%s|r", "ffff8040", "Constrictor Tentacle"),
	warnSqueezeTarget				= format("Announce targets of |c%s%s|r ($spell:64125)", "ffff8040", "Constrictor Tentacle"),
	NextPortal						= format("Show timer for next |c%s%s|r", "ff40ff80", "Brain Portals"),
	-- SetIconOnFervorTarget			= "Set icons on $spell:63138 targets",
	SetIconOnFervorTarget			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(63138) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:16|t)",
	SetIconOnEldestGuardian			= format("Set icons on eldest |c%s%s|r (must be target of raid members)", "ffff8040", "Guardian of Yogg-Saron") .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:16|t)",
	
	ShowSaraHealth					= format("Show health frame for |c%s%s|r in Phase 1 (|c%s%s|r must be target/focus of a raid member)", "ffff8040", "Sara", "ffff8040", "Sara"),
	SpecWarnMaladyNear				= "Show special warning for $spell:63881 near you",
	specWarnMaladyCast				= format("Show special warning when $spell:63830 is being cast on you (|c%s%s|r must be target/focus of a raid member)", "ffff8040", "Sara"),
	-- SetIconOnBrainLinkTarget		= "Set icons on $spell:63802 targets",
	SetIconOnBrainLinkTarget		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(63802) .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:16|t)",
	
	SetIconOnConstrictorTarget		= format("Set icons on targets of |c%s%s|r", "ffff8040", "Constrictor Tentacle") .. " ( |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:16|t)",
	
	MaladyArrow						= "Show DBM arrow when $spell:63881 is near you",
	RangeFramePortal25				= format("Show range frame for |c%s%s|r (25 players)", "ff40ff80", "portal positions"),
	-- ttsLunaticGazeCountdown			= "Play countdown sound for $spell:64163"
	ttsLunaticGazeCountdown			= DBM_CORE_AUTO_SOUND_OPTION_TEXT3:format(64163),
	
	PlaySoundOnCrusher					= format("Play sound when next |c%s%s|r spawns", "ffff8040", "Crusher Tentacle"),
	-- ttsSpawnConstrictor				= format("Play sound when next |c%s%s|r spawns", "ffff8040", "Constrictor Tentacle")
	PlaySoundOnConstrictor			= format("Play sound when next |c%s%s|r spawns", "ffff8040", "Constrictor Tentacle"),
	
	ttsPortalIn10					= format("Play sound as %s pre-warning for |c%s%s|r", SecondsToTime(10), "ff40ff80", "Brain Portal"),
	ttsPortalCountdown				= format("5-second audio countdown to |c%s%s|r", "ff40ff80", "Brain Portal"),
	-- "5-second audio countdown to $spell:%d"
	
	PingConstrictorSelf 			= format("|cffffffffPing|r the minimap when |c%s%s|r grabs you", "ffff8040", "Constrictor Tentacle")
}
