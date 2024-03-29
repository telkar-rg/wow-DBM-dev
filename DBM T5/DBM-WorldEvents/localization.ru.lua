﻿if GetLocale() ~= "ruRU" then return end

local L

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Корен Худовар"
})

L:SetWarningLocalization({
	specWarnBrew		= "Избавьтесь от варева прежде, чем она бросит вам другое!",
	specWarnBrewStun	= "СОВЕТ: Вы получили удар, не забудьте выпить варево в следующий раз!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Спец-предупреждение для $spell:47376",
	specWarnBrewStun	= "Спец-предупреждение для $spell:47340",
	YellOnBarrel		= "Кричать, когда на вас $spell:51413"
})

L:SetMiscLocalization({
	YellBarrel	= "Бочка на мне!"
})

-------------------------
--  Headless Horseman  --
-------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Всадник без головы"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers	= "Призыв Пульсирующих тыкв",
	specWarnHorsemanHead	= "Вихрь - переключитесь на голову"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers	= "Предупреждать о призыве Пульсирующих тыкв",
	specWarnHorsemanHead	= "Спец-предупреждение для Вихря (призыв 2ой и следующей головы)"
})

L:SetMiscLocalization({
	HorsemanHead		= "Не надоело еще убегать?",
	HorsemanSoldiers	= "Восстаньте слуги, устремитесь в бой! Пусть павший рыцарь обретет покой!",
	SayCombatEnd		= "Со смертью мы давно уже друзья...Что ждет теперь на пустоши меня?"
})

-----------------------
--  Apothecary Trio  --
-----------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name = "Трое аптекарей"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization{
	HummelActive	= "Хаммел вступает в бой",
	BaxterActive	= "Бакстер вступает в бой",
	FryeActive		= "Фрай вступает в бой"
}

L:SetOptionLocalization({
	TrioActiveTimer		= "Отсчет времени до вступления Троих аптекарей в бой"
})

L:SetMiscLocalization({
	SayCombatStart		= "Тебе хоть сказали, кто я и чем занимаюсь?"
})

-------------
--  Ahune  --
-------------
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	-- name = "Ахун"
	name = "Повелитель Холода Ахун"
})

L:SetWarningLocalization({
	Submerged		= "Ахун исчез",
	Emerged			= "Ахун появился",
	specWarnAttack	= "Ахун уязвим - атакуйте сейчас!"
})

L:SetTimerLocalization{
	SubmergTimer	= "Исчезновение",
	EmergeTimer		= "Появление",
	TimerCombat		= "Начало боя"
}

L:SetOptionLocalization({
	Submerged		= "Предупреждение, когда Ахун исчезает",
	Emerged			= "Предупреждение, когда Ахун появляется",
	specWarnAttack	= "Спец-предупреждение, когда Ахун становится уязвим",
	SubmergTimer	= "Отсчет времени до исчезновения",
	EmergeTimer		= "Отсчет времени до появления",
	TimerCombat		= "Отсчет времени до начала боя",
})

L:SetMiscLocalization({
	-- Pull			= "Камень Льда растаял!"
	Pull			= 'Камень Льда растаял!',	-- Trinity 24895
	Pull_2			= 'Ахун, твоя сила больше не возрастает!',	-- Trinity 24893
	Pull_3			= 'Твоему ледяному царству придет конец!',	-- Trinity 24894
	EmoteSubmerge	= 'Ахун отступает. Его оборона слабеет.',	-- Trinity 24931
	EmoteEmergeSoon	= 'Ахун скоро вернется.'	-- Trinity 24932
})