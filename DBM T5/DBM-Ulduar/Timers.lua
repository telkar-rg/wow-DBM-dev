local _, TableShared = ...

local Timers = {}

Timers["FlameLeviathan"] = {
    ["Pursued"]        = 35,
}


Timers["Ignis"] = {
    ["FlameJetsCooldown"] = 35, -- 28
    ["ScorchCooldown"] = 25, -- 22
    ["SpeedKill"]      = 240,
}


Timers["Razorscale"] = {
    ["enrage"]   = 900,
    ["DeepBreathCooldown"] = 21, -- 20
    ["Turret1"]  = 53,
    ["Turret2"]  = 73,
    ["Turret3"]  = 93, 
    ["Turret4"]  = 113, 
    ["Grounded"] = 45, 
}


Timers["XT002"] = {
    ["enrage"]      = 600,
    ["TympanicTantrumCD"] = 60, -- 72
    ["SpeedKill"]   = 205,
}


Timers["IronCouncil"] = {
    ["enrage"]      = 900,
    ["LightningTendrils"] = 27, -- 35
    ["RuneofDeathDura"] = 30, -- 25
}


Timers["Kologarn"] = {
    ["NextShockwave"]   = 18,
    ["RespawnLeftArm"]  = 48, -- 40
    ["RespawnRightArm"] = 48, -- 40
}


Timers["Auriaya"] = {
    ["enrage"]    = 600,
    ["Defender"]  = 35, -- 34.8
    ["NextFear"]  = 35.5,
    ["NextSwarm"] = 36, -- 26
    ["NextSonic"] = 27, -- 21
}


Timers["Mimiron"] = {
    ["enrage"]        = 900,
    ["timerHardmode"] = 610,
    ["timerNextFlamesPull"] = 6,
    ["timerNextFlames"] = 27.5,
    ["timerNextFlamesP4"] = 18,
    ["timerP1toP2"]   = 43,
    ["timerP2toP3"]   = 32, -- 33
    ["timerP3toP4"]   = 25,
    ["timerProximityMines"] = 35,
    ["timerNextDarkGlare"]  = 41,
    ["timerNextShockblast"] = 34,
    ["timerPlasmaBlastCD"]  = 30,
}


TableShared.Timers = Timers
-- "Klingenschuppe",[^,]+,[^,]+,[^,]+,[^,]+,[^,]+,"Flammenatem"