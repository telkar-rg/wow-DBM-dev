# DBM T5
DBM: modified development for WotLK

## [Downloads](https://github.com/telkar-rg/wow-DBM-dev/releases)
### (DBM T5.013 alpha)
- Halls of Reflection
  - fixed Speed-Run achievement timer
  - added Roleplay timer
- Ulduar
  - Algalon
    - changed star marking algorithm (no longer uses mouseover to mark)
  - General Vezax
    - fixed detection of Shadow Crash Target
  - Thorim
    - added CD timer for Chain Lightning (7.5...15s)
### (DBM T5.012 alpha)
- Trial of the Champions
  - added Combat Start Timer to the Champions and the Black Knight
- Trial of the Crusader
  - added Yell on freeze flash (tank)
  - stun timer removed / reworked
- Ulduar
  - added Space to differentiate between phases in Ulduar
  - general localization
  - Yogg-Saron
    - pull localization fixed
    - constrictor and crusher now have their own SFX
    - Ping Minimap if Constrictor on you
    - fixed deafening roar timer
    - added "portal in 10" TTS audio for Brain Portals
    - added 5 sec count down to Brain Portals
    - added icon to mark the target of a constrictor tentacle
### DBM T5.011 alpha
- Ulduar
  - Kologarn: Added CD-Timer for "Overhead Smash" (Silence Ability)
  - Mimiron: Reduced timer for first Flames in HM by 0.5s
### DBM T5.010 alpha
- Reduced amplitude of TTS sound file warning for Yogg-Sarons "Lunatic Gaze"
### DBM T5.009 alpha
- Removed Debug Messages
### DBM T5.008 alpha
- GUI: Fixed automatic line break in Button texts for usage of Icons
- Icecrown Citadel
  - Putricide: Tear Gas timer fixed (20s)
  - Blood Prince Council: incomplete implementation of "SPMFrame" removed
  - Sindragosa: added Combat Start timer
- Ulduar
  - Mimiron: Added timer for start of Phase 1
  - Freya: Added option to set Icons on Players (was always performed)
  - Hodir: Added Icon for the target of "Freeze"
  - Mimiron: Some timers fixed, Added additional Warning for PlasmaBlastSoon
  - Algalon: Automatic setting of icons on mouseover on Collapsing Stars
  - Iron Council: fixed CD of Rune of Death
  - Localization: added icons to options text
- Tempest Keep: fixed syntax error
### DBM T5.007 alpha
- Ulduar / FlameLeviathan
  - fixed "Pursued" timer of FlameLeviathan (35s)
- Tempest Keep / Kael'thas Sunstrider
  - fixed deDE NPC name of "Lord Sanguinar" (was "Fürst Blutdurst") and various YELL locales
  - fixed detection of "Bellowing Roar" spell (cast by "Lord Sanguinar")
  - fixed some Phase transition timers
### DBM T5.006 alpha
- Yogg-Saron Rework
  - added TTS countdown to Lunatic Gaze cast
  - fixed detection of Crusher Tentacles (testing)
  - added detection Malady of the Mind casting from Sara (testing)
  - fixed icon setting/resetting of raid-targets for Brain Link (testing)
  - reworked Phase transtion detection for P2 and P3
### DBM T5.005 alpha (Hotfix 2)
- Fix for Frostlord Ahune (detection of encounter start and sub/emerge)
### DBM T5.04 alpha
- Fixes in Ulduar (Mimiron timer)
### DBM T5.03 alpha
- Fixes in Ulduar (Flame Leviathan timer, Razorscale locales/timer, new warning sound file for Freya)
### DBM T5.02 alpha
- Adds checkbos to Options to en/disable auto-clearing of CombatLog
### DBM T5.01 alpha
- Adds position of brain portals to range radar in Yogg-Saron encounter
### [DBM v1.4 by Vargoth@RG](https://github.com/telkar-rg/wow-DBM-dev/releases/tag/v1.4)
- Adds RangeRadar to WotLK instances
- Only contains changed files. Must be added to / overwrite complete DBM addon (DBM-4.52-r4442)
### [DBM-4.52-r4442](https://github.com/telkar-rg/wow-DBM-dev/releases/tag/base)
- Last DBM release for 3.3.5a retail
