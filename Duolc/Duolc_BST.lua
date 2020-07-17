-- NOTE: I do not play bst, so this will not be maintained for 'active' use. 
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.

-- Credit to Quetzalcoatl.Falkirk for most of the original work.

--[[
    Custom commands:
    
    Ctrl-F8 : Cycle through available pet food options.
    Alt-F8 : Cycle through correlation modes for pet attacks.
]]

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function job_setup()
    -- Set up Reward Modes and keybind Ctrl-F8
    state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Zeta', 'Eta'}
    RewardFood = {name="Pet Food Theta"}
    send_command('bind ^f8 gs c cycle RewardMode')

    -- Set up Monster Correlation Modes and keybind Alt-F8
    state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral','Favorable'}
    send_command('bind !f8 gs c cycle CorrelationMode')
    
    -- Custom pet modes for engaged gear
    state.PetMode = M{['description']='Pet Mode', 'Normal', 'PetStance', 'PetTank'}


    ready_moves_to_check = S{'Sic','Whirl Claws','Dust Cloud','Foot Kick','Sheep Song','Sheep Charge','Lamb Chop',
        'Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang',
        'Roar','Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Venom','Geist Wall','Toxic Spit',
        'Numbing Noise','Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Power Attack',
        'Hi-Freq Field','Sandpit','Sandblast','Venom Spray','Mandibular Bite','Metallic Body','Bubble Shower',
        'Bubble Curtain','Scissor Guard','Big Scissors','Grapple','Spinning Top','Double Claw','Filamented Hold',
        'Frog Kick','Queasyshroom','Silence Gas','Numbshroom','Spore','Dark Spore','Shakeshroom','Blockhead',
        'Secretion','Fireball','Tail Blow','Plague Breath','Brain Crush','Infrasonics','1000 Needles',
        'Needleshot','Chaotic Eye','Blaster','Scythe Tail','Ripper Fang','Chomp Rush','Intimidate','Recoil Dive',
        'Water Wall','Snow Cloud','Wild Carrot','Sudden Lunge','Spiral Spin','Noisome Powder','Wing Slap',
        'Beak Lunge','Suction','Drainkiss','Acid Mist','TP Drainkiss','Back Heel','Jettatura','Choke Breath',
        'Fantod','Charged Whisker','Purulent Ooze','Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath',
        'Sensilla Blades','Tegmina Buffet','Molting Plumage','Swooping Frenzy','Pentapeck','Sweeping Gouge',
        'Zealous Snort'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'Refresh', 'Reraise')
    state.PhysicalDefenseMode:options('PDT', 'Hybrid', 'Killer')

    update_combat_form()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    -- Unbinds the Reward and Correlation hotkeys.
    send_command('unbind ^f8')
    send_command('unbind !f8')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    sets.precast.JA['Killer Instinct'] = {
	}

    sets.precast.JA['Feral Howl'] = {
	}

    sets.precast.JA['Call Beast'] = {		
	}

    sets.precast.JA['Familiar'] = {		
	}

    sets.precast.JA['Tame'] = {		
	}

    sets.precast.JA['Spur'] = {
	}

    sets.precast.JA['Reward'] = {		
	}

    sets.precast.JA['Charm'] = {
		main = "Monster Signa",
		head = "Noble's ribbon",
		ring1 = "Hope ring",
		ring2 = "Hope ring",
		neck = "Bird whistle"
	}

    -- CURING WALTZ
    sets.precast.Waltz = {
	}

    -- HEALING WALTZ
    sets.precast.Waltz['Healing Waltz'] = {
	}

    -- STEPS
    sets.precast.Step = {		
	}

    -- VIOLENT FLOURISH
    sets.precast.Flourish1 = {
	}

    sets.precast.Flourish1['Violent Flourish'] = {		
	}

    sets.precast.FC = {		
	}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		
	})

    -- WEAPONSKILLS
    -- Default weaponskill set.
    sets.precast.WS = {		
	}

    sets.precast.WS.WSAcc = {		
	}

    -- Specific weaponskill sets.
    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {
	})

    sets.precast.WS['Ruinator'].WSAcc = set_combine(sets.precast.WS.WSAcc, {
	})

    sets.precast.WS['Ruinator'].Mekira = set_combine(sets.precast.WS['Ruinator'], {
	})

    sets.precast.WS['Onslaught'] = set_combine(sets.precast.WS, {
	})

    sets.precast.WS['Onslaught'].WSAcc = set_combine(sets.precast.WSAcc, {
	})

    sets.precast.WS['Primal Rend'] = {
	}

    sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'], {
	})

	sets.precast.WS['Rampage'] = {
		neck = "Spike necklace",
		ring1 = "Rajas ring",
		ear1 = "Cassie earing",
		feet = "Mettle leggings",
		waist = "Life belt"
	}

    --------------------------------------
    -- Midcast sets
    --------------------------------------
    
    sets.midcast.FastRecast = {
	}

    sets.midcast.Utsusemi = sets.midcast.FastRecast

    -- PET SIC & READY MOVES
    sets.midcast.Pet.WS = {
	}

    sets.midcast.Pet.WS.Unleash = set_combine(sets.midcast.Pet.WS, {
	})

    sets.midcast.Pet.Neutral = {
	}

    sets.midcast.Pet.Favorable = {
	}


    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- RESTING
    sets.resting = {
	}

    -- IDLE SETS
    sets.idle = {
	}

    sets.idle.Refresh = {
	}

    sets.idle.Reraise = set_combine(sets.idle, {
	})

    sets.idle.Pet = sets.idle

    sets.idle.Pet.Engaged = {
	}

    -- DEFENSE SETS
    sets.defense.PDT = {
	}

    sets.defense.Hybrid = set_combine(sets.defense.PDT, {
	})

    sets.defense.Killer = set_combine(sets.defense.Hybrid, {
	})

    sets.defense.MDT = set_combine(sets.defense.PDT, {
	})

    sets.Kiting = {
	}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {
		main = "Juggernaut",
		sub = "Hard Shield",
		head = "Perle Salade",
		neck = "Chivalrous Chain",
		body = "Perle Hauberk",
		hands = "Perle Moufles",
		legs = "Perle Brayettes",
		feet = "Perle Sollerets",
		waist="Headlong belt",
		ring1 = "Rajas ring",
		ring2 = "Strigoi ring",
		ear1 = "Beetle earring +1",
		ear2 = "Beetle earring +1",
          back = "Amemet mantle +1"
	}

    sets.engaged.Acc = {
	}

    sets.engaged.Killer = set_combine(sets.engaged, {
	})

    sets.engaged.Killer.Acc = set_combine(sets.engaged.Acc, {
	})
    
    
    -- EXAMPLE SETS WITH PET MODES
    --[[
    sets.engaged.PetStance = {}
    sets.engaged.PetStance.Acc = {}
    sets.engaged.PetTank = {}
    sets.engaged.PetTank.Acc = {}
    sets.engaged.PetStance.Killer = {}
    sets.engaged.PetStance.Killer.Acc = {}
    sets.engaged.PetTank.Killer = {}
    sets.engaged.PetTank.Killer.Acc = {}
    ]]
    -- MORE EXAMPLE SETS WITH EXPANDED COMBAT FORMS
    --[[
    sets.engaged.DW.PetStance = {}
    sets.engaged.DW.PetStance.Acc = {}
    sets.engaged.DW.PetTank = {}
    sets.engaged.DW.PetTank.Acc = {}
    sets.engaged.KillerDW.PetStance = {}
    sets.engaged.KillerDW.PetStance.Acc = {}
    sets.engaged.KillerDW.PetTank= {}
    sets.engaged.KillerDW.PetTank.Acc = {}
    ]]
    
    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff['Killer Instinct'] = {
	}
    
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    -- Define class for Sic and Ready moves.
    if ready_moves_to_check:contains(spell.english) and pet.status == 'Engaged' then
        classes.CustomClass = "WS"
    end
end


function job_post_precast(spell, action, spellMap, eventArgs)
    -- If Killer Instinct is active during WS, equip Ferine Gausape +2.
    if spell.type:lower() == 'weaponskill' and buffactive['Killer Instinct'] then
        equip(sets.buff['Killer Instinct'])
    end
end


function job_pet_post_midcast(spell, action, spellMap, eventArgs)
    -- Equip monster correlation gear, as appropriate
    equip(sets.midcast.Pet[state.CorrelationMode.value])
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
    if buff == 'Killer Instinct' then
        update_combat_form()
        handle_equipping_gear(player.status)
    end
end

-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Reward Mode' then
        -- Thena, Zeta or Eta
        RewardFood.name = "Pet Food " .. newValue
    elseif stateField == 'Pet Mode' then
        state.CombatWeapon:set(newValue)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    if defaut_wsmode == 'Normal' then
        if spell.english == "Ruinator" and (world.day_element == 'Water' or world.day_element == 'Wind' or world.day_element == 'Ice') then
            return 'Mekira'
        end
    end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
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
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    msg = msg .. ', Reward: '..state.RewardMode.value..', Correlation: '..state.CorrelationMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if buffactive['Killer Instinct'] then
        if (player.sub_job == 'NIN' or player.sub_job == 'DNC') and player.equipment.sub:endswith('Axe') then
            state.CombatForm:set('KillerDW')
        else
            state.CombatForm:set('Killer')
        end
    elseif (player.sub_job == 'NIN' or player.sub_job == 'DNC') and player.equipment.sub:endswith('Axe') then
        state.CombatForm:set('DW')
    else
        state.CombatForm:reset()
    end
end