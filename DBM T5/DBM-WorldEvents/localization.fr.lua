if GetLocale() ~= "frFR" then return end

local L

-------------------
-- Coren Direbrew --
-------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Coren Navrebière"
})

L:SetWarningLocalization({
	warnBarrel			= "Tonneau sur >%s<", 
	specwarnDisarm		= "Désarmement. Bougez !",
	specWarnBrew		= "Débarrassez-vous de la bière avant qu'elle ne vous en lance une autre !",
	specWarnBrewStun	= "Vous avez reçu un coup sur la tête. La prochaine fois, videz votre verre !"
})

L:SetOptionLocalization({
	warnBarrel			= "Annonce la cible du Tonneau.",
	specwarnDisarm		= "Montre une alerte spéciale pour le désarmement",
	specWarnBrew		= "Montre une alerte spéciale pour la Sombrebière de la vierge",
	specWarnBrewStun	= "Montre une alerte spéciale pour l'Etourdir de la vierge bierrière",
	PlaySoundOnDisarm	= "Joue un son pour le désarmement",
	YellOnBarrel		= "Crie quand vous avez un Tonneau sur vous"
})

L:SetMiscLocalization({
	YellBarrel			= "Tonneau sur moi !"
})

-------------------
-- Headless Horseman --
-------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Cavalier sans tête"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers		= "Arrivée des Citrouilles vibrantes !",
	specWarnHorsemanHead		= "Tapez la Tête du Cavalier"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers		= "Montre une alerte pour l'arrivée des Citrouilles vibrantes",
	specWarnHorsemanHead		= "Montre une alerte spéciale pour l'arrivée de la Tête du Cavalier"
})

L:SetMiscLocalization({
	HorsemanHead				= "Viens donc ici , sombre abruti !",  -- Attention, espace avant la virgule
	HorsemanSoldiers			= "Levez-vous, mes recrues ! Au combat sans surseoir ! Au chevalier déchu, donnez enfin victoire !",
	SayCombatEnd				= "Je la connais trop bien, cette fin importune. Que faut-il au destin pour changer ma fortune ?"
})

-----------------------
--  Apothecary Trio  --
-----------------------
-- L = DBM:GetModLocalization("ApothecaryTrio")

-- L:SetGeneralLocalization({
	-- name = "Apothecary Trio"
-- })

-- L:SetWarningLocalization({
-- })

-- L:SetTimerLocalization{
	-- HummelActive	= "Hummel becomes active",
	-- BaxterActive	= "Baxter becomes active",
	-- FryeActive		= "Frye becomes active"
-- }

-- L:SetOptionLocalization({
	-- TrioActiveTimer		= "Show timers for when Apothecary Trio becomes active"
-- })

-- L:SetMiscLocalization({
	-- SayCombatStart		= "Did they bother to tell you who I am and why I am doing this?",
	-- SayCombatStart2		= "...or are they just using you like they do everybody else?",
	-- SayCombatStart3		= "But what does it matter. It is time for this to end."
-- })

-------------
--  Ahune  --
-------------
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	-- name = "Ahune"
	name = "Seigneur du Givre Ahune"
})

L:SetWarningLocalization({
	Submerged		= "Ahune est immergé",
	Emerged			= "Ahune a émergé",
	specWarnAttack	= "Ahune est vulnérable - Attaquez maintenant !"
})

L:SetTimerLocalization{
	SubmergTimer	= "Immerger",
	EmergeTimer		= "Emerger",
	TimerCombat		= "Début du combat dans"
}

L:SetOptionLocalization({
	Submerged		= "Afficher l'alerte lorsque Ahune est immergé",
	Emerged			= "Afficher l'alerter lorsque Ahune a émergé",
	specWarnAttack	= "Afficher une alerter spécial lorsque Ahune devient vulnérable",
	SubmergeTimer	= "Afficher le timer pour l'immersion",
	EmergeTimer		= "Afficher le timer pour l'émersion",
	TimerCombat		= "Afficher le timer du début du combat"
})

L:SetMiscLocalization({
	-- Pull			= "Le glaçon a fondu!"
	Pull			= "La pierre de glace a fondu !",	-- Trinity 24895
	Pull_2			= "Ahune, ta puissance ne grandira plus !",	-- Trinity 24893
	Pull_3			= "Tu ne règneras pas de ta main de glace !",	-- Trinity 24894
	EmoteSubmerge	= 'Ahune bat en retraite. Ses défenses s\'affaiblissent.',	-- Trinity 24931
	EmoteEmergeSoon	= 'Ahune ne va pas tarder à réapparaître.'	-- Trinity 24932
})