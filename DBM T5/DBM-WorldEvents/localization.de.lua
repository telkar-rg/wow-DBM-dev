if GetLocale() ~= "deDE" then return end

-- fehlende Übersetzungen:
--
-- PdC: Großchampions, Der Schwarze Ritter
-- HdR: Lichkönig-Event (Horde)

local L

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Coren Düsterbräu"
})

L:SetWarningLocalization({
	specWarnBrew		= "Werde das Bier los, bevor sie dir ein neues zuwirft!",
	specWarnBrewStun	= "HINWEIS: Du wurdest betäubt. Nächstes Mal, trink das Bier!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Zeige Spezialwarnung für $spell:47376",
	specWarnBrewStun	= "Zeige Spezialwarnung für $spell:47340",
	YellOnBarrel		= "Schreie bei $spell:51413"
})

L:SetMiscLocalization({
	YellBarrel	= "Fass auf mir!"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Der kopflose Reiter"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers	= "neuer Pulsierender Kürbis",
	specWarnHorsemanHead	= "Wirbelwind - Wechsel auf den Kopf"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers	= "Zeige Warnung wenn Pulsierender Kürbnis erscheint",
	specWarnHorsemanHead	= "Zeige Spezialwarnung für Wirbelwind (ab der zweiten Kopfphase)"
})

L:SetMiscLocalization({
	HorsemanHead		= "Komm hierher, du Idiot!",	-- Trinity 22415
	HorsemanSoldiers	= "Soldaten, erhebt Euch und kämpft immer weiter. Bringt endlich den Sieg zum gefallenen Reiter!",	-- Trinity 23861
	SayCombatEnd		= "Dieses Ende ist mir schon bekannt. Welch neue Abenteuer hat das Schicksal zur Hand?"	-- Trinity 23455
})

-----------------------
--  Apothecary Trio  --
-----------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name = "Apotheker-Trio"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization{
	HummelActive	= "Hummel wird aktiv",
	BaxterActive	= "Baxter wird aktiv",
	FryeActive		= "Frye wird aktiv"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Zeige Timer für wann die Apotheker aktiv werden"
})

L:SetMiscLocalization({
	SayCombatStart		= "Haben sie sich die Mühe gemacht und Euch gesagt, wer ich bin und warum ich das hier tue?",
	SayCombatStart2		= "... oder benutzen sie Euch nur, so wie sie alle anderen benutzen?",
	SayCombatStart3		= "Doch was macht das? Es ist an der Zeit, dass das hier endet."
})

-----------------------
--  Lord Ahune  --
-----------------------
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	name = "Fürst Ahune"
	-- name = "Ahune <Der Frostfürst>"
})

L:SetWarningLocalization({
	Submerged		= "Ahune untergetaucht",
	Emerged			= "Ahune aufgetaucht",
	specWarnAttack	= "Ahune ist verwundbar - Angriff!"
})

L:SetTimerLocalization{
	SubmergTimer	= "Untertauchen",
	EmergeTimer		= "Auftauchen",
	TimerCombat		= "Kampfbeginn"
}

L:SetOptionLocalization({
	Submerged		= "Zeige Warnung wenn Ahune untertaucht",
	Emerged			= "Zeige Warnung wenn Ahune auftaucht",
	specWarnAttack	= "Zeige Spezialwarnun wenn Ahune verwundbar wird",
	SubmergTimer	= "Zeige Timer für Untertauchen",
	EmergeTimer		= "Zeige Timer für Auftauchen",
	TimerCombat		= "Zeige Timer für Kampfbeginn"
})

L:SetMiscLocalization({
	Pull			= "Der Eisbrocken ist geschmolzen!",	-- Trinity 24895
	Pull_2			= "Ahune, stärker sollst du nicht mehr werden!",	-- Trinity 24893
	Pull_3			= "Niemals wird Kälte herrschen!",	-- Trinity 24894
	EmoteSubmerge	= "Ahune zieht sich zurück. Seine Verteidigung lässt nach.",	-- Trinity 24931
	EmoteEmergeSoon	= "Ahune wird bald wieder auftauchen."	-- Trinity 24932
})