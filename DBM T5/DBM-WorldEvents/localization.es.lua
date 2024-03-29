﻿if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

-------------------
-- Coren Direbrew --
-------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Coren Cerveza Temible"
})

L:SetWarningLocalization({
	specWarnBrew			= "¡Bebete la cerveza antes de que lanze otra!",
	specWarnBrewStun		= "SUGERENCIA: ¡Te han dado! ¡Acuerdate de beber la cerveza si te han lanzado!"
})

L:SetOptionLocalization({
	specWarnBrew			= "Mostrar aviso especial para $spell:47376",
	specWarnBrewStun		= "Mostrar aviso especial para $spell:47340",
	YellOnBarrel			= "Avisar si $spell:51413"
})

L:SetMiscLocalization({
	YellBarrel				= "¡Tengo el Barril!"
})

-------------------
-- Headless Horseman --
-------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "El Jinete decapitado"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers		= "Vienen las Calabazas con pulso!",
	specWarnHorsemanHead		= "Sale la cabeza - cambia de objetivo"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers		= "Mostrar aviso a la llegada de Calabazas con pulso",
	specWarnHorsemanHead		= "Mostrar un aviso especial cuando salga la cabeza"
})

L:SetMiscLocalization({
	HorsemanHead				= "¡Ven aquí, idiota!",  -- Attention, espace avant la virgule
	HorsemanSoldiers			= "¡Soldados alzáos soldados, tomad vuestro acero! Dad la victoria a este deshonrado caballero!",
	SayCombatEnd				= "Este final a mí me suena. Veamos qué nueva me espera."
})

-----------------------
--  Apothecary Trio  --
-----------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name = "Los Tres Boticarios"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization{
	HummelActive	= "Hummel se activa",
	BaxterActive	= "Baxter se activa",
	FryeActive		= "Frye se activa"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Mostrar tiempo para que los Boticarios se activen"
})

L:SetMiscLocalization({
	SayCombatStart		= "¿Se han molestado en decirte quién soy y por qué estoy haciendo esto?"
})

-----------------------
--  Lord Ahune  --
-----------------------
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	-- name = "Ahune"
	name = "Señor de la Escarcha Ahune"
})

L:SetWarningLocalization({
	Submerged		= "Ahune se sumerge",
	Emerged			= "Ahune emerge",
	specWarnAttack	= "Ahune es vulnerable ¡Ataca ahora!"
})

L:SetTimerLocalization{
	SubmergTimer	= "Se sumerge",
	EmergeTimer		= "Emerge",
	TimerCombat		= "Inicio del combate"
}

L:SetOptionLocalization({
	Submerged		= "Mostrar aviso cuando Ahune se sumerge",
	Emerged			= "Mostrar aviso cuando Ahune emerge",
	specWarnAttack	= "Mostrar aviso especial cuando Ahune es vulnerable",
	SubmergTimer	= "Mostrar tiempo para sumersión",
	EmergeTimer		= "Mostrar tiempo para emersión",
	TimerCombat		= "Mostrar tiempo para inicio del combate",
})

L:SetMiscLocalization({
	-- Pull			= "¡La piedra de hielo se ha derretido!"
	Pull			= '¡La piedra de hielo se ha derretido!',	-- Trinity 24895
	Pull_2			= '¡Ahune, tu fuerza ya no aumenta!',	-- Trinity 24893
	Pull_3			= '¡Tu reino helado no tendrá lugar!',	-- Trinity 24894
	EmoteSubmerge	= 'Ahune se retira. Sus defensas disminuyen.',	-- Trinity 24931
	EmoteEmergeSoon	= 'Ahune pronto volverá a la superficie.'	-- Trinity 24932
})