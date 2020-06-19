include('organizer-lib')

--  Select Thief Macros    
send_command('input /macro book 2;wait .1') --;input /macro set 2')

function get_sets()
    TP_Index = 1
    Idle_Index = 1
   
    sets.weapons = {}

    sets.weapons[1] = {
        main="Kaja Knife",
        sub={ name="Shijo", augments={'DEX+15','"Dual Wield"+5','"Triple Atk."+2',}},
    }
    
    sets.JA = {}
    
    sets.JA.Steal = {
        head="Rogue's Bonnet",
        neck="Pentagalus Charm",
        hands="Rogue's Armlets",
        legs="Assassin's Culottes",
        feet="Rogue's Poulaines"
    }
    
    sets.JA.Flee = {
        feet="Rogue's Poulaines"
    }
    
    sets.JA.Mug = {
        head="Assassin's Bonnet"
    }
    
    sets.JA.Waltz = {
        head="Wayfarer Circlet",
        body="Wayfarer Robe",
        waist="Mrc.Cpt. Belt",
        neck="Bird Whistle",
        legs="Wayfarer Slops",
        feet="Wayfarer Clogs"
    }
    
--  sets.JA.Despoil = {}
--  sets.JA.Conspirator = {}
--  sets.JA.Accomplice = {}
--  sets.JA.Collaborator = {}
--  sets.JA['Perfect Dodge'] = {}
    
    sets.WS = {}
    sets.WS.SA = {}
    sets.WS.TA = {}
    sets.WS.SATA = {}
    
    sets.WS.SharkBite = {
        waist="Warwolf Belt",
        back={ name="Toutatis's Cape", augments={'Weapon skill damage +10%',}},
        neck="Moepapa Medal",
        left_ring="Ramuh Ring",
        right_ring="Garuda Ring",
    }
    
    sets.WS.Evisceration = {
        right_ring="Ramuh Ring",
        back={ name="Toutatis's Cape", augments={'Weapon skill damage +10%',}},
    }


--  sets.WS["Rudra's Storm"] = {}
--  sets.WS.SA["Shark Bite"] = set_combine(sets.WS["SharkBite"],{})
--  sets.WS.TA["Shark Bite"] = set_combine(sets.WS["SharkBite"],{})
--  sets.WS.Exenterator = {}
        
    TP_Set_Names = {"Standard","Evasion","TreasureHunter","Accuracy","CapacityPoint"}

    sets.TP = {}

    sets.TP['Standard'] = {
        head="Meghanada Visor +1",
        body="Meg. Cuirie +2",
        hands="Meg. Gloves +1",
        legs="Meg. Chausses +1",
        feet="Meg. Jam. +1",
        neck="Chivalrous Chain",
        right_ring="Meghanada Ring",
        left_ring="Rajas Ring",
        left_ear="Odr Earring",
        right_ear="Mache Earring",
        back="Bleating Mantle"
    }
    
    sets.TP.Evasion = set_combine(sets.TP['Standard'],{
        head="Imp. Wing Hairpin",
        body="Heidrek Harness",
        hands="Heidrek Gloves",
        legs="Heidrek Brais",
        feet="Heidrek Boots",
        back={ name="Toutatis's Cape", augments={'Weapon skill damage +10%',}},
        neck="Pentagalus Charm"
    })
        
    sets.TP['TreasureHunter'] = set_combine(sets.TP['Standard'],{
        hands="Assassin's Armlets"
    })
        
    sets.TP['Accuracy'] = set_combine(sets.TP['Standard'],{
        waist="Dynamic Belt",
        neck="Spectacles",
        left_ring="Keen Ring"
    })

    sets.TP['CapacityPoint'] = set_combine(sets.TP['Standard'],{
        back="Aptitude Mantle"
    })
        
--  sets.TP['Delay Cap'] = {}
--  sets.TP.DT = {}
    
    Idle_Set_Names = {'Normal','MDT',"STP"}

    sets.Idle = {}

    sets.Idle.Normal = {
        left_ring="Warp Ring"
    }           
    sets.Idle.MDT = {}
    sets.Idle['STP'] = {}
    
--  sets.FastCast = {}
--  sets.frenzy = {}
    
end

function precast(spell)
    if sets.JA[spell.english] then
        equip(sets.JA[spell.english])
    elseif spell.type=="WeaponSkill" then
        if sets.WS[spell.english] then equip(sets.WS[spell.english]) end
        if buffactive['sneak attack'] and buffactive['trick attack'] and sets.WS.SATA[spell.english] then equip(sets.WS.SATA[spell.english])
        elseif buffactive['sneak attack'] and sets.WS.SA[spell.english] then equip(sets.WS.SA[spell.english])
        elseif buffactive['trick attack'] and sets.WS.TA[spell.english] then equip(sets.WS.TA[spell.english]) end
    elseif string.find(spell.english,'Waltz') then
        equip(sets.JA.Waltz)
    elseif spell.action_type == "Magic" then
        equip(sets.FastCast)
    end
end

function aftercast(spell)
    if player.status=='Engaged' then
        equip(sets.TP[TP_Set_Names[TP_Index]])
    else
        equip(sets.Idle[Idle_Set_Names[Idle_Index]])
    end
end

function status_change(new,old)
    if T{'Idle','Resting'}:contains(new) then
        equip(sets.Idle[Idle_Set_Names[Idle_Index]])
    elseif new == 'Engaged' then
        equip(sets.TP[TP_Set_Names[TP_Index]])
    end
end

function buff_change(buff,gain_or_loss)
    if buff=="Sneak Attack" then
        soloSA = gain_or_loss
    elseif buff=="Trick Attack" then
        soloTA = gain_or_loss
    elseif gain_or_loss and buff == 'Sleep' and player.hp > 99 then
        print('putting on Frenzy sallet!')
        equip(sets.frenzy)
    end
end

function self_command(command)
    if command == 'toggle TP set' then
        TP_Index = TP_Index +1
        if TP_Index > #TP_Set_Names then TP_Index = 1 end
        send_command('@input /echo ----- TP Set changed to '..TP_Set_Names[TP_Index]..' -----')
        equip(sets.TP[TP_Set_Names[TP_Index]])
    elseif command == 'toggle Idle set' then
        Idle_Index = Idle_Index +1
        if Idle_Index > #Idle_Set_Names then Idle_Index = 1 end
        send_command('@input /echo ----- Idle Set changed to '..Idle_Set_Names[Idle_Index]..' -----')
        equip(sets.Idle[Idle_Set_Names[Idle_Index]])
    end
end

