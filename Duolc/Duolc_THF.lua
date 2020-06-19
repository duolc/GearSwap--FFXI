-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:

    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
-- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack']	or false
    state.Buff['Trick Attack'] = buffactive['trick attack']	or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
    include('Mote-TreasureHunter')

-- For th_action_check():
-- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

--Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Accuracy', 'Trivial', 'Domain', 'JobPoint')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Accuracy')
    state.WeaponskillMode:options('Normal', 'Accuracy', 'Trivial')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')


--  gear.default.weaponskill_neck = "Asperity Necklace"
--  gear.default.weaponskill_waist = "Caudata Belt"
--  gear.AugQuiahuiz = {name="Quiahuiz Trousers", augments={'Haste+2','"Snapshot"+2','STR+8'}}

--Additional local binds
--  send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
--  send_command('bind !- gs c cycle targetmode')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
--------------------------------------
-- Special sets (required by rules)
--------------------------------------

    sets.TreasureHunter = {
		hands = "Assassin's Armlets"
	}

    sets.ExtraRegen = {}

	sets.Kiting = {
		feet = "Areion boots"
	}

    sets.buff['Sneak Attack'] = {
		back = { name="Toutatis's Cape", augments={'Weapon skill damage +10%'}}
	}

	sets.buff['Trick Attack'] = {}

-- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


--------------------------------------
-- Precast sets
--------------------------------------

-- Precast sets to enhance JAs
	sets.precast.JA['Collaborator'] = {}
	
	sets.precast.JA['Accomplice'] = {}
	
	sets.precast.JA['Flee'] = {
        feet = "Rogue's Poulaines"
    }
	
	sets.precast.JA['Hide'] = {
		body = "Rogue's Vest"
	}
	
	sets.precast.JA['Conspirator'] = {}
	
	sets.precast.JA['Steal'] = {
        head = "Rogue's Bonnet",
        neck = "Pentagalus Charm",
        hands = "Rogue's Armlets",
        legs = "Assassin's Culottes",
        feet = "Rogue's Poulaines"
	}
	
	sets.precast.JA['Mug'] = {
        head = "Assassin's Bonnet"
    }
	
	sets.precast.JA['Despoil'] = {}
	
	sets.precast.JA['Perfect Dodge'] = {}
	
	sets.precast.JA['Feint'] = {} 

	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


-- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head = "Wayfarer Circlet",
        body = "Wayfarer Robe",
        waist = "Mrc.Cpt. Belt",
        neck = "Bird Whistle",
        legs = "Wayfarer Slops",
		feet = "Wayfarer Clogs",
		ear1 = "Enchanter's earring"
    }

-- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

-- Fast cast sets for spells
    sets.precast.FC = {}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

-- Ranged snapshot gear
    sets.precast.RA = {
		neck = "Spectacles",
		back = "Amemet Mantle +1",
		waist = "Aquiline Belt"
	}

-- Weaponskill sets

-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		back = { name="Toutatis's Cape", augments={'Weapon skill damage +10%',},
		neck = "Moepapa Medal"}
	}

    sets.precast.WS.Accuracy = set_combine(sets.precast.WS, {
	})

-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
--------------------------------------
--Exenterator
--------------------------------------	
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS,{
		waist = "Soil Belt",
		ring1 = "Garuda Ring",
		ring2 = "Garuda Ring",
		ear1 = "Tati Earring",
		ear2 = "Drone Earring"
	})

    sets.precast.WS['Exenterator'].Accuracy = set_combine(sets.precast.WS['Exenterator'],{
		waist = "Dynamic Belt",
		neck = "Spectacles"
	})

    sets.precast.WS['Exenterator'].Trivial = set_combine(sets.precast.WS['Exenterator'], {
	})

    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Trivial, {
	})

    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Trivial, {
	})

	sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Trivial, {
	})

--------------------------------------
--Evisceration
--------------------------------------
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		ring1 = "Ramuh Ring",
		ring2 = "Ramuh Ring",
		ear1 = "Mache Earring",
		ear2 = "Odr Earring",
		waist = "Soil Belt"
	})

    sets.precast.WS['Evisceration'].Accuracy = set_combine(sets.precast.WS['Evisceration'], {
	    waist = "Dynamic Belt",
		neck = "Spectacles"	
	})

    sets.precast.WS['Evisceration'].Trivial = set_combine(sets.precast.WS['Evisceration'], {
	})

    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Trivial, {
	})

    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Trivial, {
	})

	sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Trivial, {
	})


--------------------------------------
--Rudra's Storm
--------------------------------------
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
	})

    sets.precast.WS["Rudra's Storm"].Accuracy = set_combine(sets.precast.WS["Rudra's Storm"], {
	})

    sets.precast.WS["Rudra's Storm"].Trivial = set_combine(sets.precast.WS["Rudra's Storm"], {
	})

    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Trivial, {
	})

    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Trivial, {
	})

    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Trivial, {
	})

--------------------------------------
--Shark Bite
--------------------------------------
    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
		ring1 = "Ramuh Ring",
		ring2 = "Garuda Ring",
		ear1 = "Mache Earring",
		ear2 = "Odr Earring",
		waist = "Warwolf Belt",
		head="Imp. Wing Hair. +1"
	})

    sets.precast.WS['Shark Bite'].Accuracy = set_combine(sets.precast.WS['Shark Bite'], {
	})

    sets.precast.WS['Shark Bite'].Trivial = set_combine(sets.precast.WS['Shark Bite'], {
	})

    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Trivial, {
	})

    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Trivial, {
	})
	
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Trivial, {
	})

--------------------------------------
--Aeolian Edge
--------------------------------------
    sets.precast.WS['Aeolian Edge'] = {
		ring1 = "Ramuh Ring",
		ring2 = "Spiral Ring",
	}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)


--------------------------------------
-- Midcast sets
--------------------------------------
--Fast Cast 
    sets.midcast.FastRecast = {
	}

-- Utsusemi
    sets.midcast.Utsusemi = {
	}

-- Ranged gear Default
    sets.midcast.RA = {
	}
-- Ranged Accuracy Gear
    sets.midcast.RA.Accuracy = {
	}



--------------------------------------
-- Resting sets
--------------------------------------
    sets.resting = {
	}

--------------------------------------
-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
--------------------------------------

    sets.idle = {
	}

    sets.idle.Town = {
	}

    sets.idle.Weak = {
	}


--------------------------------------
-- Defense sets
--------------------------------------
--Evasion
	sets.defense.Evasion = {
	}

--Physical Defense
    sets.defense.PDT = {
	}

--Magical Defense
    sets.defense.MDT = {
	}


--------------------------------------
-- Melee sets
--------------------------------------

-- Normal melee group
    sets.engaged = {
		head = "Meghanada Visor +1",
        body = "Meg. Cuirie +2",
        hands = "Meg. Gloves +1",
        legs = "Meg. Chausses +1",
        feet = "Meg. Jam. +1",
		neck = "Chivalrous Chain",
		waist="Sailfi Belt",
        ring1 = "Meghanada Ring",
        ring2 = "Rajas Ring",
        ear1 = "Odr Earring",
        ear2 = "Mache Earring",
        back = "Bleating Mantle"
	}

-- Normal melee Accuracy Bonus
    sets.engaged.Accuracy = set_combine(sets.engaged, {
		waist = "Dynamic Belt",
        neck = "Spectacles",
        ring1 = "Keen Ring"
	})
        
-- Trivial mobs
    sets.engaged.Trivial = set_combine(sets.engaged, {
	})

--Evasion Set		
    sets.engaged.Evasion = set_combine(sets.engaged, {
		head="Imp. Wing Hair. +1",
		body = "Heidrek Harness",
		hands = "Heidrek Gloves",
		legs = "Heidrek Brais",
		feet = "Heidrek Boots",
		back = { name = "Toutatis's Cape", augments = {'Weapon skill damage +10%',}},
		neck = "Pentagalus Charm"
	})

--Non Evasion Tank
    sets.engaged.PDT = set_combine(sets.engaged, {
	})

--Domain Invasion Set
	sets.engaged.Domain = set_combine(sets.engaged, {
		head = "Heidrek Mask",
		body = "Heidrek Harness",
		hands = "Heidrek Gloves",
		legs = "Heidrek Brais",
		feet = "Heidrek Boots"
	})

--Job Point Boost
	sets.engaged.JobPoint = set_combine(sets.engaged, {
		back = "Aptitude Mantle"
})
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
-- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
-- If Feint is active, put that gear set on on top of regular gear.
-- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

-- Check for SATA when equipping gear.  If either is active, equip
-- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
	if 		player.equipment.range ~= 'empty' then disable('range', 'ammo')
    else enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
-- Default macro set/book
    if		player.sub_job == 'DNC' then set_macro_page(1, 2)
	elseif	player.sub_job == 'WAR' then set_macro_page(2, 2)
	elseif	player.sub_job == 'NIN' then set_macro_page(3, 2)
	else set_macro_page(1, 3)
    end
end


