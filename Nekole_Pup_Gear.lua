-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc','FullAcc','Fodder')
    state.HybridMode:options('Pet','DT','Normal')
    state.WeaponskillMode:options('Match','Normal','Acc','FullAcc','Fodder')
    state.PhysicalDefenseMode:options('PDT')
	state.IdleMode:options('Normal','PDT','Refresh')
	state.Weapons:options('None','Godhands','PetWeapons')

	set_lockstyle()
    -- Default maneuvers 1, 2, 3 and 4 for each pet mode.
     -- Default/Automatic maneuvers for each pet mode.  Define at least 3.
	defaultManeuvers = {
		Melee = {
			{Name='Fire Maneuver', 	  Amount=1},
			{Name='Thunder Maneuver', Amount=1},
			{Name='Wind Maneuver', 	  Amount=1},
			{Name='Light Maneuver',	  Amount=0},
		},
		Ranged = {
			{Name='Wind Maneuver', 	  Amount=3},
			{Name='Fire Maneuver',	  Amount=0},
			{Name='Light Maneuver',	  Amount=0},
			{Name='Thunder Maneuver', Amount=0},
		},
		HybridRanged = {
			{Name='Wind Maneuver', 	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Thunder Maneuver', Amount=0},
		},
		Tank = {
			{Name='Earth Maneuver',	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=0},
		},
		LightTank = {
			{Name='Earth Maneuver',	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=0},
		},
		Magic = {
			{Name='Light Maneuver',	  Amount=1},
			{Name='Ice Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Earth Maneuver',	  Amount=0},
		},
		Heal = {
			{Name='Light Maneuver',	  Amount=2},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Earth Maneuver',	  Amount=0},
		},
		Nuke = {
			{Name='Ice Maneuver',	  Amount=2},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Earth Maneuver',	  Amount=0},
		},
	}

	deactivatehpp = 85

    select_default_macro_book()
	
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f8 gs c toggle AutoPuppetMode')
	send_command('bind @f7 gs c toggle AutoRepairMode')
end

-- Define sets used by this job file.
function init_gear_sets()
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
	head=gear.herculean_fc_head,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
	body="Zendik Robe",hands=gear.herculean_dt_hands,ring1="Lebeche Ring",ring2="Prolix Ring",
	back="Perimede Cape",waist="Isa Belt",legs="Rawhide Trousers",feet="Regal Pumps +1"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    
    -- Precast sets to enhance JAs
    sets.precast.JA['Tactical Switch'] = {feet="Cirque Scarpe +2"}
    sets.precast.JA['Repair'] = {ammo="Automat. Oil +3"} --feet="Foire Babouches"
	sets.precast.JA['Maintenance'] = {ammo="Automat. Oil +3"}

    sets.precast.JA.Maneuver = {main="Midnights",back=gear.jsecapes.amb.pup.tp} --neck="Buffoon's Collar",hands="Foire Dastanas",body="Cirque Farsetto +2",

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head=gear.HerculeanHelm.TP,neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Handler's Earring +1",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
        back="Moonbeam Cape",waist="Chaac Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.herculean_waltz_feet}
        
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head=gear.HerculeanHelm.TP,neck="Rancor Collar",ear1="Moonshade Earring",ear2="Brutal Earring",
        body=gear.HerculeanBody.Crit,hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.ws,waist="Moonbow Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.WS}
	sets.precast.WS.Acc = {
        head=gear.HerculeanHelm.TP,neck="Rancor Collar",ear1="Moonshade Earring",ear2="Telos Earring",
        body=gear.HerculeanBody.Crit,hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.ws,waist="Moonbow Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.WS}
	sets.precast.WS.FullAcc = {
        head=gear.HerculeanHelm.TP,neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
        body=gear.HerculeanBody.Crit,hands="Ryuo Tekko",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.jsecapes.amb.pup.ws,waist="Olseni Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.WS}
	sets.precast.WS.Fodder = {
        head=gear.HerculeanHelm.TP,neck="Rancor Collar",ear1="Moonshade Earring",ear2="Brutal Earring",
        body=gear.HerculeanBody.Crit,hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.ws,waist="Moonbow Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.WS}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {body="Abnoba Kaftan"})
    sets.precast.WS['Victory Smite'].Acc = set_combine(sets.precast.WS.Acc, {body="Sayadio's Kaftan"})
	sets.precast.WS['Victory Smite'].FullAcc = set_combine(sets.precast.WS.FullAcc, {body="Sayadio's Kaftan"})
	sets.precast.WS['Victory Smite'].Fodder = set_combine(sets.precast.WS.Fodder, {body="Abnoba Kaftan"})
	
    sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {body="Abnoba Kaftan"})
    sets.precast.WS['Stringing Pummel'].Acc = set_combine(sets.precast.WS.FullAcc, {body="Sayadio's Kaftan"})
	sets.precast.WS['Stringing Pummel'].FullAcc = set_combine(sets.precast.WS.FullAcc, {body="Sayadio's Kaftan"})
	sets.precast.WS['Stringing Pummel'].Fodder = set_combine(sets.precast.WS.Fodder, {body="Abnoba Kaftan"})

    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shijin Spiral'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Shijin Spiral'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Shijin Spiral'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Asuran Fists'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Asuran Fists'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dragon Kick'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Dragon Kick'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Dragon Kick'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tornado Kick'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Tornado Kick'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Tornado Kick'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Asuran Fists'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Asuran Fists'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Raging Fists'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Raging Fists'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Raging Fists'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Howling Fist'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Howling Fist'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Howling Fist'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Backhand Blow'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Backhand Blow'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Backhand Blow'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Backhand Blow'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Spinning Attack'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Spinning Attack'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Spinning Attack'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Shoulder Tackle'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shoulder Tackle'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Shoulder Tackle'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Shoulder Tackle'].Fodder = set_combine(sets.precast.WS.Fodder, {})
    -- Midcast Sets

    sets.midcast.FastRecast = {
	head=gear.herculean_fc_head,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
	body="Zendik Robe",hands=gear.herculean_dt_hands,ring1="Lebeche Ring",ring2="Prolix Ring",
	back="Perimede Cape",waist="Isa Belt",legs="Rawhide Trousers",feet="Regal Pumps +1"}
        
	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
		
    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {}
	sets.midcast.Pet['Enfeebling Magic'] = {neck="Adad Amulet",ear1="Enmerkar Earring",ear2="Handler's Earring +1",body="Taeon Tabard",hands="Regimen Mittens",ring1="Varar Ring +1",ring2="Varar Ring +1",waist="Incarnation Sash",legs=gear.ambuscade.taliah.legs}
    sets.midcast.Pet['Elemental Magic'] = {neck="Adad Amulet",ear1="Enmerkar Earring",ear2="Handler's Earring +1",body="Taeon Tabard",hands="Regimen Mittens",ring1="Varar Ring +1",ring2="Varar Ring +1",waist="Incarnation Sash",legs=gear.ambuscade.taliah.legs}
	sets.midcast.Pet.PetWSGear = {neck="Shulmanu Collar",ear1="Enmerkar Earring",ear2="Handler's Earring +1",body="Taeon Tabard",hands="Regimen Mittens",ring1="Varar Ring +1",ring2="Varar Ring +1",back="Dispersal Mantle",waist="Incarnation Sash",legs=gear.ambuscade.taliah.legs}
	
    sets.midcast.Pet.PetWSGear.Ranged = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Melee = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Tank = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.LightTank = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Magic = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Heal = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Nuke = set_combine(sets.midcast.Pet.PetWSGear, {})
    
	-- Currently broken, preserved in case of future functionality.
	sets.midcast.Pet.WeaponSkill = {}
	

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets

    sets.idle = {
        head=gear.RawhideMask.A,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body=gear.ambuscade.hizamaru.body,hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonbeam Cape",waist="Fucho-no-Obi",legs=gear.SamnuhaTights.TP,feet="Hippo. Socks +1"}
		
	sets.idle.Refresh = {
        head=gear.RawhideMask.A,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Vrikodara Jupon",hands=gear.herculean_refresh_hands,ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonbeam Cape",waist="Fucho-no-Obi",legs=gear.RawhideTrousers.D,feet="Hippo. Socks +1"}
		
    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = {
        head=gear.RawhideMask.A,neck="Loricate Torque +1",ear1="Enmerkar Earring",ear2="Handler's Earring +1",
        body="Taeon Tabard",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonbeam Cape",waist="Isa Belt",legs=gear.ambuscade.taliah.legs,feet="Hippo. Socks +1"}

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {
        head="Anwig Salade",neck="Shulmanu Collar",ear1="Enmerkar Earring",ear2="Handler's Earring +1",
        body="Taeon Tabard",hands="Regimen Mittens",ring1="Varar Ring +1",ring2="Varar Ring +1",
        back=gear.jsecapes.amb.pup.tp,waist="Klouskap Sash",legs=gear.ambuscade.taliah.legs,feet=gear.ambuscade.taliah.feet}

    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Melee = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Tank = set_combine(sets.idle.Pet.Engaged, {waist="Isa Belt"})
	sets.idle.Pet.Engaged.LightTank = set_combine(sets.idle.Pet.Engaged, {waist="Isa Belt"})
    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Heal = sets.idle.Pet.Engaged.Magic
	sets.idle.Pet.Engaged.Nuke = sets.idle.Pet.Engaged.Magic


    -- Defense sets

    sets.defense.PDT = {
        head="Blistering Sallet",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Vrikodara Jupon",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonbeam Cape",waist="Isa Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}

    sets.defense.MDT = {
        head="Blistering Sallet",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Vrikodara Jupon",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonbeam Cape",waist="Isa Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}
		
    sets.defense.MEVA = {
        head="Blistering Sallet",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Vrikodara Jupon",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonbeam Cape",waist="Isa Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}

    sets.Kiting = {feet="Hermes' Sandals"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head=gear.ambuscade.taliah.head,neck="Shulmanu Collar",ear1="Cessance Earring",ear2="Telos Earring",
        body="Sayadio's Kaftan",hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.tp,waist="Moonbow Belt",legs=gear.SamnuhaTights.TP,feet=gear.HerculeanBoots.TA}
    sets.engaged.Acc = {
        head=gear.HerculeanHelm.TP,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body=gear.herculean_wsd_body,hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.tp,waist="Grunfeld Rope",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.TA}
    sets.engaged.FullAcc = {
        head=gear.HerculeanHelm.TP,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body=gear.herculean_wsd_body,hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.tp,waist="Grunfeld Rope",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.TA}
	sets.engaged.Fodder = {
        head=gear.HerculeanHelm.TP,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body=gear.herculean_wsd_body,hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.tp,waist="Moonbow Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.TA}
    sets.engaged.DT = {
        head=gear.HerculeanHelm.TP,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body=gear.herculean_wsd_body,hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.tp,waist="Moonbow Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.TA}
    sets.engaged.Acc.DT = {
        head=gear.HerculeanHelm.TP,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body=gear.herculean_wsd_body,hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.tp,waist="Moonbow Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.TA}
    sets.engaged.FullAcc.DT = {
        head=gear.HerculeanHelm.TP,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body=gear.herculean_wsd_body,hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.tp,waist="Moonbow Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.TA}
    sets.engaged.Fodder.DT = {
        head=gear.HerculeanHelm.TP,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body=gear.herculean_wsd_body,hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.tp,waist="Moonbow Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.TA}
    sets.engaged.Pet = {
        head=gear.HerculeanHelm.TP,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body=gear.herculean_wsd_body,hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.tp,waist="Moonbow Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.TA}
    sets.engaged.Acc.Pet = {
        head=gear.HerculeanHelm.TP,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body=gear.herculean_wsd_body,hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.tp,waist="Moonbow Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.TA}
    sets.engaged.FullAcc.Pet = {
        head=gear.HerculeanHelm.TP,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body=gear.herculean_wsd_body,hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.tp,waist="Moonbow Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.TA}
    sets.engaged.Fodder.Pet = {
        head=gear.HerculeanHelm.TP,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body=gear.herculean_wsd_body,hands="Ryuo Tekko",ring1="Niqmaddu Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.pup.tp,waist="Moonbow Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.HerculeanBoots.TA}
		
	-- Weapons sets
	sets.weapons.PetWeapons = {main="Ohtas",range="Animator P +1",}
	sets.weapons.Godhands = {main="Godhands",range="Animator P +1",}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 18)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 18)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 18)
    else
        set_macro_page(2, 18)
    end
end
function set_lockstyle()
	send_command('wait 2; input /lockstyleset 10')
end

------------------------------------------------------------------------------------------------------------------------
--------------------------------- DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU ARE DOING ---------------------------------
------------------------------------------------------------------------------------------------------------------------

-------------------------------
--------Global Variables-------
-------------------------------

Current_Maneuver = 0
OverCount = 0
NextWS = ""

Master_State = "Idle"
Pet_State = "Idle"
Hybrid_State = "Idle"
Flashbulb_Timer = 45
Strobe_Timer = 30
Strobe_Recast = 0
Flashbulb_Recast = 0
Flashbulb_Time = 0
Strobe_Time = 0

d_mode = false

time_start = os.time()

--Constants in case we decide to change names down the road, will be much easier
const_dd = "DD"
const_tank = "TANK"
const_mage = "MAGE"
const_PetModeCycle = "PetModeCycle"
const_PetStyleCycle = "PetStyleCycle"
const_stateIdle = "Idle"
const_stateHybrid = "Pet+Master"
const_stateEngaged = "Engaged"
const_stateOverdrive = "Overdrive"
const_petOnly = "Pet Only"
const_masterOnly = "Master Only"

--- SKILLCHAIN TABLE
SC = {}
SC["Valoredge Frame"] = {}
SC["Sharpshot Frame"] = {}
SC["Harlequin Frame"] = {}
SC["Stormwaker Frame"] = {}

SC["Valoredge Frame"]["Stringing Pummel"] = "String Shredder"
SC["Valoredge Frame"]["Victory Smite"] = "String Shredder"
SC["Valoredge Frame"]["Shijin Spiral"] = "Bone Crusher"
SC["Valoredge Frame"]["Howling Fist"] = "String Shredder"

SC["Sharpshot Frame"]["Stringing Pummel"] = "Armor Shatterer"
SC["Sharpshot Frame"]["Victory Smite"] = "Armor Shatterer"
SC["Sharpshot Frame"]["Shijin Spiral"] = "Armor Piercer"
SC["Sharpshot Frame"]["Howling Fist"] = "Arcuballista"
SC["Sharpshot Frame"]["Dragon Kick"] = "Armor Shatterer"
SC["Sharpshot Frame"]["One Inch Punch"] = "Daze"
SC["Sharpshot Frame"]["Spinning Attack"] = "Armor Shatterer"
SC["Sharpshot Frame"]["Base"] = "Arcuballista"

SC["Harlequin Frame"]["Stringing Pummel"] = "Slapstick"
SC["Harlequin Frame"]["Victory Smite"] = "Magic Mortar"
SC["Harlequin Frame"]["Shijin Spiral"] = "Slapstick"
SC["Harlequin Frame"]["Howling Fist"] = "Knockout"

SC["Stormwaker Frame"]["Stringing Pummel"] = "Slapstick"
SC["Stormwaker Frame"]["Victory Smite"] = "Magic Mortar"
SC["Stormwaker Frame"]["Shijin Spiral"] = "Slapstick"
SC["Stormwaker Frame"]["Howling Fist"] = "Knockout"


------------------------------------
------------Text Window-------------
------------------------------------

--Default To Set Up the Text Window
function setupTextWindow(pos_x, pos_y)
    tb_name = "pup_gs_helper"
    bg_visible = true
    textinbox = " "

    windower.text.create(tb_name)
    -- table_name, x, y
    windower.text.set_location(tb_name, pos_x, pos_y)
    -- transparency, rgb
    windower.text.set_bg_color(tb_name, 200, 40, 40, 55)
    windower.text.set_color(tb_name, 255, 147, 161, 161)
    windower.text.set_font(tb_name, "Arial")
    windower.text.set_font_size(tb_name, 11)
    windower.text.set_bold(tb_name, true)
    windower.text.set_italic(tb_name, false)
    windower.text.set_text(tb_name, textinbox)
    windower.text.set_bg_visibility(tb_name, bg_visible)
    windower.text.set_visibility(tb_name, true)
end

--Hanldles refreshing the current text window
function refreshWindow()
    textinbox = " "
    textColorNewLine = "\\cr \n"
    textColorEnd = " \\cr"
    textColor = "\\cs(125, 125, 0)"

    --Testing with this variable can ignore for now, works as intended
    test = state.textHideHUB.value

    if state.textHideHUB.value == true then
        textinbox = ''
        windower.text.set_text(tb_name, textinbox)
        return
    end

    if pet.isvalid then
        drawPetInfo()
        drawPetSkills()
    end

    if not state.textHideState.value then
        textinbox = textinbox .. drawTitle("    State    ")
        textinbox = textinbox .. textColor .. "Pet Mode " .. ternary(state.Keybinds.value, "(ALT+F7)", "") .. " : " .. state.PetModeCycle.value .. textColorNewLine
        textinbox = textinbox .. textColor .. "Pet Style " .. ternary(state.Keybinds.value, "(ALT+F8)", "") .. " : " .. state.PetStyleCycle.value .. textColorNewLine
        -- textinbox = textinbox .. textColor .. "Master : " .. Master_State .. textColorNewLine
        -- textinbox = textinbox .. textColor .. "Pet : " .. Pet_State .. textColorNewLine
        textinbox = textinbox .. textColor .. "Hybrid : " .. Hybrid_State .. textColorNewLine
    end

    if not state.textHideMode.value then
        textinbox = textinbox .. drawTitle("     Mode     ")
        textinbox = textinbox .. textColor .. "Idle Mode " .. ternary(state.Keybinds.value, "(CTRL+F12)", "") .. " : " .. tostring(state.IdleMode.current) .. textColorNewLine
        textinbox = textinbox .. textColor .. "Offense Mode " .. ternary(state.Keybinds.value, "(F9)", "") .. " : " .. tostring(state.OffenseMode.current) .. textColorNewLine
        textinbox = textinbox .. textColor .. "Physical Mode " .. ternary(state.Keybinds.value, "(CTRL-F10)", "") .. " : " .. tostring(state.PhysicalDefenseMode.current) .. textColorNewLine
        textinbox = textinbox .. textColor .. "Hybrid Mode " .. ternary(state.Keybinds.value, "(CTRL-F9)", "") .. " : " .. tostring(state.HybridMode.current) .. textColorNewLine    
    end

    if not state.textHideOptions.value then
        textinbox = textinbox .. drawTitle("  Options  ")
        textinbox =
            textinbox .. textColor .. "Auto Maneuver " .. ternary(state.Keybinds.value, "(ALT+E)", "") .. " : " .. ternary(state.AutoMan.value, "ON", "OFF") .. textColorNewLine
        textinbox = textinbox .. textColor .. "Lock Pet DT Set " .. ternary(state.Keybinds.value, "(ALT+D)", "") .. " : " .. ternary(state.LockPetDT.value, "ON", "OFF") .. textColorNewLine
        textinbox = textinbox .. textColor .. "Lock Weapon " .. ternary(state.Keybinds.value, "(ALT+~)", "") .. " : " .. ternary(state.LockWeapon.value, "ON", "OFF") .. textColorNewLine
        textinbox = textinbox .. textColor .. "Weaponskill FTP: " .. ternary(state.SetFTP.value, "ON", "OFF") .. textColorNewLine
        textinbox = textinbox .. textColor .. "Custom Gear Lock: " .. ternary(state.CustomGearLock.value, "ON", "OFF") .. textColorNewLine
    end
    
    --Debug Variables that are used for testing
    if d_mode then
        textinbox = textinbox .. drawTitle("DEBUG")
        textinbox = textinbox .. textColor .. "Last State : " .. tostring(lastStateActivated) .. textColorNewLine
        textinbox = textinbox .. textColor .. "Last State : " .. ternary(justFinishedWeaponSkill, "TRUE", "FALSE") .. textColorNewLine
        textinbox = textinbox .. textColor .. "Master State : " .. Master_State .. textColorNewLine
        textinbox = textinbox .. textColor .. "Pet State : " .. Pet_State .. textColorNewLine

    end

    windower.text.set_text(tb_name, textinbox)
end

--Handles drawing the Pet Info for the Text Box
function drawPetInfo()
    textinbox = textinbox .. drawTitle("   Pet Info   ")
    textinbox = textinbox .. "- \\cs(0, 0, 125)HP : " .. pet.hp .. "/" .. pet.max_hp .. textColorNewLine
    textinbox = textinbox .. "- \\cs(0, 125, 0)MP : " .. pet.mp .. "/" .. pet.max_mp .. textColorNewLine
    textinbox = textinbox .. "- \\cs(255, 0, 0)TP : " .. tostring(pet.tp) ..textColorNewLine
    textinbox = textinbox .. "- \\cs(255, 0, 0)WS Gear Lock : " .. ternary(startedPetWeaponSkillTimer and petWeaponSkillRecast <= 0 , "On", "Off") .. " ( " .. petWeaponSkillRecast .. " )" ..textColorNewLine
end

--This handles drawing the Pet Skills for the text box
function drawPetSkills()
    --- Recast for enmity gears

    textinbox = textinbox .. drawTitle("  Pet Skills  ")
    -- Strobe recast
    if Strobe_Recast == 0 and (pet.attachments.strobe or pet.attachments["strobe II"]) then
        if buffactive["Fire Maneuver"] then
            textinbox = textinbox .. "\\cs(125, 125, 125)-\\cr \\cs(125,0,0)Strobe\\cr \n"
        else
            textinbox = textinbox .. "\\cs(125, 125, 125)- Strobe\\cr \n"
        end
    elseif pet.attachments.strobe or pet.attachments["strobe II"] then
        textinbox = textinbox .. "\\cs(125, 125, 125)- Strobe (" .. Strobe_Recast .. ")\\cr \n"
    end

    -- Flashbulb recast
    if Flashbulb_Recast == 0 and pet.attachments.flashbulb then
        if buffactive["Light Maneuver"] then
            textinbox = textinbox .. "\\cs(125, 125, 125)-\\cr \\cs(255,255,255)Flashbulb\\cr \n"
        else
            textinbox = textinbox .. "\\cs(125, 125, 125)- Flashbulb\\cr \n"
        end
    elseif pet.attachments.flashbulb ~= nil then
        textinbox = textinbox .. "\\cs(125, 125, 125)- Flashbulb (" .. Flashbulb_Recast .. ")\\cr \n"
    end

    if not pet.attachments.strobe and not pet.attachments["strobe II"] and not pet.attachments.flashbulb then
        textinbox = textinbox .. "\\cs(125, 125, 125)-No Skills To Track\\cr \n"
    end
end

--Creates the Title for a section in the Text Screen
function drawTitle(title)
    return "\\cs(255, 115, 0)" .. pad(tostring(title), 6, "=") .. "\\cr \n"
end

function msg(str)
    send_command("@input /echo *-*-*-*-*-*-*-*-* " .. str .. " *-*-*-*-*-*-*-*-*")
end

------------------------------------
----------Utility Functions---------
------------------------------------

--Used to calculate the Hybrid State of you and your pet
function TotalSCalc()
    if state.PetModeCycle.current == const_dd then
        if buffactive["Overdrive"] then
            Hybrid_State = const_stateOverdrive
        elseif Master_State == const_stateIdle and Pet_State == const_stateIdle then
            Hybrid_State = const_stateIdle

        elseif Master_State == const_stateIdle and Pet_State == const_stateEngaged then
            Hybrid_State = const_petOnly

        elseif Master_State == const_stateEngaged and Pet_State == const_stateEngaged then
            Hybrid_State = const_stateHybrid

        elseif Master_State == const_stateEngaged and Pet_State == const_stateIdle then
            Hybrid_State = const_masterOnly
            
        end
    elseif state.PetModeCycle.current == const_tank then
        if Pet_State == const_stateIdle then
            Hybrid_State = const_stateIdle
        elseif state.PetStyleCycle.value ~= "DD" and state.PetStyleCycle.value ~= 'SPAM' then
            Hybrid_State = const_tank
            handle_set({'IdleMode', 'Idle'})
            handle_set({'HybridMode', 'DT'})
        end
    elseif state.PetModeCycle.current == const_mage then
        if Master_State == const_stateIdle then
            Hybrid_State = const_stateIdle
        else
            Hybrid_State = const_masterOnly
            handle_set({"OffenseMode", 'Master'})
        end
    end
end

--Attempts to determine the Puppet Mode and Style
function determinePuppetType()
    local head = pet.head
    local frame = pet.frame

    local ValHead = "Valoredge Head"
    local ValFrame = "Valoredge Frame"

    local HarHead = "Harlequin Head"
    local HarFrame = "Harlequin Frame"

    local SharpHead = "Sharpshot Head"
    local SharpFrame = "Sharpshot Frame"

    local StormHead = "Stormwaker Head"
    local StormFrame = "Stormwaker Frame"

    local SoulHead = "Soulsoother Head"
    local SpiritHead = "Spiritreaver Head"

    --This is based mostly off of the frames from String Theory
    --https://www.bg-wiki.com/bg/String_Theory#Automaton_Frame_Setups

    --Determine Head first, then further determine by body and attachments
    if head == HarHead then --Harlequin Predictions
        if frame == HarFrame and (pet.attachments.strobe == true or pet.attachments.flashbulb == true) then --Magic Tank
            handle_set({const_PetModeCycle, const_tank})
            handle_set({const_PetStyleCycle, "MAGIC"})
        elseif frame == HarFrame then -- Default
            handle_set({const_PetModeCycle, const_dd})
            handle_set({const_PetStyleCycle, "NORMAL"})
        else
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
    elseif head == ValHead then --Valoredge Predictions
        if frame == SharpFrame then
            if (pet.attachments.strobe == true or pet.attachments.flashbulb == true) then -- DD Tank
                handle_set({const_PetModeCycle, const_tank})
                handle_set({const_PetStyleCycle, const_dd})
            else -- Default
                handle_set({const_PetModeCycle, const_dd})
                handle_set({const_PetStyleCycle, "NORMAL"})
            end
        elseif frame == ValFrame then -- Default Standard Tank
            handle_set({const_PetModeCycle, const_tank})
            handle_set({const_PetStyleCycle, "NORMAL"})
        else
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
    elseif head == SharpHead then -- Sharpshooter Prediction
        if frame == SharpFrame then -- SPAM DD
            if (pet.attachments.inhibitor == true or pet.attachments["inhibitor II"] == true) then
                handle_set({const_PetModeCycle, const_dd})
                handle_set({const_PetStyleCycle, "NORMAL"})
            else
                handle_set({const_PetModeCycle, const_dd})
                handle_set({const_PetStyleCycle, "SPAM"})
            end
        else
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
    elseif head == StormHead then --Stormwaker Prediction
        if frame == StormFrame then -- RDM
            handle_set({const_PetModeCycle, const_mage})
            handle_set({const_PetStyleCycle, "SUPPORT"})
        else
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
    elseif head == SoulHead then -- Soulsoother Prediction
        if frame == StormFrame then -- WHM
            handle_set({const_PetModeCycle, const_mage})
            handle_set({const_PetStyleCycle, "HEAL"})
        elseif frame == ValFrame then -- Turtle Tank
            handle_set({const_PetModeCycle, const_tank})
            handle_set({const_PetStyleCycle, "NORMAL"})
        else
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
    elseif head == SpiritHead then -- Spiritweaver Prediction
        if frame == StormFrame then -- BLM
            handle_set({const_PetModeCycle, const_mage})
            handle_set({const_PetStyleCycle, const_dd})
        else
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
    end
end

--Various Timers that get reset when you zone
function reset_timers()
    state.AutoMan:reset()
    Current_Maneuver = 0
    refreshWindow()
end

--Traverses a table to see if it contains the given element
function table.contains(table, element)
    for _, value in pairs(table) do
        if string.lower(value) == string.lower(element) then
            return true
        end
    end
    return false
end

--Pads a given chara on both sides (centering with left justification)
function pad(s, l, c)
    local srep = string.rep
    local c = c or " "

    local res1 = srep(c, l) .. s -- pad to half-length s
    local res2 = res1 .. srep(c, l) -- right-pad our left-padded string to the full length

    return res2
end

--Takes a condition and returns a given value based on if it is true or false
function ternary(cond, T, F)
    if cond then
        return T
    else
        return F
    end
end

----------------------------------------------------
----------Windower Hooks/Custom Gearswap------------
----------------------------------------------------

function user_customize_idle_set(idleSet)
    --Custom Idle Group when Pet is Engaged and Master is Idle
    if Master_State:lower() == const_stateIdle:lower() and Pet_State:lower() == const_stateEngaged:lower() then
        if state.HybridMode.current == "Normal" then
            return idleSet
        else
            idleSet = sets.idle.Pet.Engaged[state.HybridMode.current]
            return idleSet
        end
    else
        return idleSet
    end
end

function job_precast(spell, action, spellMap, eventArgs)

    if spell.english == "Activate" or spell.english == "Deus Ex Automata" then
        TotalSCalc()
        determinePuppetType()
    elseif string.find(spell.english, "Maneuver") then
        equip(sets.precast.JA.Maneuver)
    elseif sets.precast.JA[spell.english] then
        equip(sets.precast.JA[spell.english])
    elseif sets.precast.WS[spell.english] then
        equip(sets.precast.WS[spell.english])
    elseif pet.isvalid then
        if spell.english == "Deploy" and pet.tp >= 950 then
            equip(sets.midcast.Pet.WSNoFTP)
            eventArgs.handled = true
        end
    end

end

function job_midcast(spell, action, spellMap, eventArgs)
end

--Puppet Weaponskill Modifiers
Modifier = {}

Modifier["String Shredder"] = "VIT"
Modifier["Bone Crusher"] = "VIT"
Modifier["Armor Shatterer"] = "DEX"
Modifier["Armor Piercer"] = "DEX"
Modifier["Arcuballista"] = "DEXFTP"
Modifier["Daze"] = "DEXFTP"
Modifier["Slapstick"] = "DEX"
Modifier["Knockout"] = "AGI"

function job_aftercast(spell, action, spellMap, eventArgs)
    if pet.isvalid then
        if SC[pet.frame][spell.english] and pet.tp >= 850 and Pet_State == 'Engaged' then
            ws = SC[pet.frame][spell.english]
            modif = Modifier[ws]

            --If its a valid modif
            if modif then
                equip(sets.midcast.Pet.WS[modif])
                
                add_to_chat(
                    392,
                    "*-*-*-*-*-*-*-*-* [ " .. pet.name .. " is about to " .. ws .. " (" .. modif .. ") ] *-*-*-*-*-*-*-*-*"
                )
            else --Otherwise equip the default Weapon Skill Set
                equip(sets.midcast.Pet.WSNoFTP)
            end

            --Since this will be a new Weapon Skill we just performed best to reset any current timers
            resetWeaponSkillPetTimer()
            --Begin the count down until we may lock out the pet weapon skill set
            startWeaponSkillPetTimer()
            eventArgs.handled = true
        else
            handle_equipping_gear(player.status, Pet_State)
        end

    else
        handle_equipping_gear(player.status, Pet_State)
    end
end

function job_status_change(new, old)
    if new == "Engaged" then
        Master_State = const_stateEngaged
        TotalSCalc()
    else
        Master_State = const_stateIdle
        TotalSCalc()
    end

    handle_equipping_gear(player.status, Pet_State)
end

function job_pet_status_change(new, old)
    if new == "Engaged" then
        Pet_State = const_stateEngaged
        TotalSCalc()
        add_to_chat(392, "*-*-*-*-*-*-*-*-* [ Pet Engaged ] *-*-*-*-*-*-*-*-*")
    else
        Pet_State = const_stateIdle
        TotalSCalc()
        add_to_chat(392, "*-*-*-*-*-*-*-*-* [ Pet Idle ] *-*-*-*-*-*-*-*-*")
    end

    handle_equipping_gear(player.status, Pet_State)
end

AutomatonWeaponSkills = T{"Slapstick", "Knockout", "Magic Mortar", "Chimera Ripper", "String Clipper", "Cannibal Blade", "Bone Crusher", "String Shredder", "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}

function job_pet_aftercast(spell)

    if table.contains(AutomatonWeaponSkills, spell.name) then
        justFinishedWeaponSkill = true
    end

    handle_equipping_gear(player.status, pet.status)
end

--Anytime you change equipment you need to set eventArgs.handled or else you may get overwritten
function job_buff_change(status, gain_or_loss, eventArgs)
    if status == "sleep" and gain_or_loss then
        equip(set_combine(sets.defense.PDT, {neck = "Opo-opo Necklace"}))
        eventArgs.handled = true
    elseif status == "doom" and gain_or_loss then
        send_command("input /p I have befallen to ~~~DOOM~~~ may my end not come to quickly.")
    elseif status == "doom" and gain_or_loss == false then
        send_command("input /p I have avoided the grips of ~~~DOOM~~~ may Altana be praised! ")
    end

    --When you are at 3 Maneuvers and you use the ability you will temporarily go to 4
    --This helps prevent you from trying to cast on losing a buff
    if status:contains("Maneuver") and gain_or_loss then
        Current_Maneuver = Current_Maneuver + 1
        refreshWindow()
    elseif Current_Maneuver > 0 then -- We don't want to see a negative count
        Current_Maneuver = Current_Maneuver - 1
        refreshWindow()
    end

    --Now we can turn on and off the functionailty of automatically maintaining manuevers
    --Also, make sure your not dead, so we don't attempt to recast Maneuvers
    if state.AutoMan.value and player.hp > 0 and pet.isvalid then
        if status:contains("Maneuver") and gain_or_loss == false and Current_Maneuver < 3 then
            send_command('input /ja "' .. status .. '" <me>')
        end
    end

    if status == const_stateOverdrive then
        if gain_or_loss then
            OverCount = 1
            equip(sets.midcast.Pet.WSFTP)
            eventArgs.handled = true
        else
            OverCount = 0
            equip(sets.midcast.Pet.WSNoFTP)
            eventArgs.handled = true
        end
    end
end

-- Toggles -- SE Macros: /console gs c "command"
function job_self_command(command, eventArgs)
    if command[1]:lower() == "automan" then
        state.AutoMan:toggle()
        refreshWindow()
    elseif command[1]:lower() == "debug" then
        d_mode = not d_mode
        debug('Debug Mode is now on!')
        refreshWindow()
    elseif command[1]:lower() == "predict" then
        determinePuppetType()
        refreshWindow()
    elseif command[1]:lower() == "hide" then

        if command[2]:lower() == 'mode' then
            state.textHideMode:toggle()
            refreshWindow()
        elseif command[2]:lower() == 'state' then
            state.textHideState:toggle()
            refreshWindow()    
        elseif command[2]:lower() == 'hub' then
            state.textHideHUB:toggle()
            refreshWindow()
        elseif command[2]:lower() == 'keybinds' then
            state.Keybinds:toggle()
            refreshWindow()
        elseif command[2]:lower() == 'options' then
            state.textHideOptions:toggle()
            refreshWindow()
        end
    elseif command[1]:lower() == 'setftp' then
        state.SetFTP:toggle()
        refreshWindow()
    elseif command[1]:lower() == 'customgearlock' then
        state.CustomGearLock:toggle()
        refreshWindow()
    end

end


--Defaults
DefaultPetWeaponSkillLockOutTimer = 8 -- This will be the time that is changeable by the player
justFinishedWeaponSkill = false
petWeaponSkillLock = false
startedPetWeaponSkillTimer = false
petWeaponSkillRecast = 0
petWeaponSkillTime = 0

windower.register_event(
    "prerender",
    function()
        --Items we want to check every second
        if os.time() > time_start then
            time_start = os.time()

            if pet.isvalid and player.hpp > 0 then
                --Double check current Pet Status and Player Status
                --In some cases Mote's doesn't recognize a pet's status change
                Pet_State = pet.status
                Master_State = player.status

                --We only want this to activate if we are actually running the timer for the pet weapon skill

                if pet.tp >= 1000 and petWeaponSkillRecast <= 0 and startedPetWeaponSkillTimer == true then
                    --We have passed the allowed time without the puppet using a weapon skill, locking till next round
                    petWeaponSkillRecast = 0
                    petWeaponSkillLock = true
                    handle_equipping_gear(player.status, pet.status)
                elseif pet.tp < 1000 or Pet_State == "Idle" then
                    resetWeaponSkillPetTimer()
                end
            end

            --This reads if pet is active and 
            --pet style is SPAM or DD
            --Otherwise this is handled for when the player is fighting with pet in job_aftercast
            if pet.isvalid and 
            (state.PetStyleCycle.value:lower() == "spam" or state.PetStyleCycle.value:lower() == "dd")
            and Master_State:lower() == "idle" then
                --Now if pet has more than 1000 tp and pet is engaged and didn't just finish a weaponskill and we have not locked the pet out this set
                if pet.tp >= 1000 and Pet_State == const_stateEngaged and justFinishedWeaponSkill == false and petWeaponSkillLock == false then
                    if state.SetFTP.value then
                        equip(set_combine(sets.midcast.Pet.WSFTP,{main="Ohtas"}))
                    else
                        equip(set_combine(sets.midcast.Pet.WSFTP,{main="Ohtas"}))
                    end
                    
                    startWeaponSkillPetTimer()
                end
            end

            if state.PetModeCycle.value == const_tank and Pet_State == const_stateEngaged then
                if buffactive["Fire Maneuver"] and (pet.attachments.strobe or pet.attachments["strobe II"]) then
                    if Strobe_Recast <= 2 then
                        equip(sets.pet.Enmity)
                    end
                end

                if buffactive["Light Maneuver"] and pet.attachments.flashbulb == true then
                    if Flashbulb_Recast <= 2 then
                        equip(sets.pet.Enmity)
                    end
                end
            end

            if Strobe_Recast > 0 then
                Strobe_Recast = Strobe_Timer - (os.time() - Strobe_Time)
            end

            if Flashbulb_Recast > 0 then
                Flashbulb_Recast = Flashbulb_Timer - (os.time() - Flashbulb_Time)
            end

            if petWeaponSkillRecast > 0 and startedPetWeaponSkillTimer == true then
                --Count down the timer if it has started
                petWeaponSkillRecast = DefaultPetWeaponSkillLockOutTimer - (os.time() - petWeaponSkillTime)
            end

            refreshWindow()
        end
    end
)

function startWeaponSkillPetTimer()
    if petWeaponSkillRecast <= 0 and startedPetWeaponSkillTimer == false then
        petWeaponSkillRecast = DefaultPetWeaponSkillLockOutTimer
        petWeaponSkillTime = os.time()
        startedPetWeaponSkillTimer = true
    end
end

function resetWeaponSkillPetTimer()
    petWeaponSkillRecast = 0
    justFinishedWeaponSkill = false
    petWeaponSkillLock = false
    startedPetWeaponSkillTimer = false
end

windower.register_event(
    "incoming text",
    function(original, modified, mode)

        -- OVERDRIVE OPTIMIZER
        --I believe the original intent for this was if the player was not engaged and
        --the pet is fighting on its own in Overdrive.
        --With that thought this now activates when the master is not engaged 
        --or if the master is engaged
        --and the PetStyleCycle is set to SPAM then it will also activate
            if buffactive["Overdrive"] and (Master_State:lower() ~= const_stateEngaged:lower() or state.PetStyleCycle.value:lower() == "spam") then
                if original:contains(pet.name) and original:contains("Daze") then
                    equip(sets.midcast.Pet.WSFTP)
                    add_to_chat(204, "*-*-*-*-*-*-*-*-* [ " .. "Daze" .. " done ] *-*-*-*-*-*-*-*-*")
                    OverCount = 2
                elseif original:contains(pet.name) and original:contains("Arcuballista") then
                    equip(sets.midcast.Pet.WSNoFTP)
                    add_to_chat(204, "*-*-*-*-*-*-*-*-* [ " .. "Arcuballista" .. " done ] *-*-*-*-*-*-*-*-*")
                    OverCount = 3
                elseif original:contains(pet.name) and original:contains("Armor Shatterer") then
                    equip(sets.midcast.Pet.WSNoFTP)
                    add_to_chat(204, "*-*-*-*-*-*-*-*-* [ " .. "Armor Shatterer" .. " done ] *-*-*-*-*-*-*-*-*")
                    OverCount = 4
                elseif original:contains(pet.name) and original:contains("Armor Piercer") then
                    equip(sets.midcast.Pet.WSFTP)
                    add_to_chat(204, "*-*-*-*-*-*-*-*-* [ " .. "Armor Piercer" .. " done ] *-*-*-*-*-*-*-*-*")
                    OverCount = 1
                end
            end

        -- Checking timer for enmity sets
        if buffactive["Fire Maneuver"] then
            if original:contains(pet.name) and original:contains("Provoke") then
                add_to_chat(204, "*-*-*-*-*-*-*-*-* [ Strobe done ] *-*-*-*-*-*-*-*-*")
                Strobe_Time = os.time()
                Strobe_Recast = Strobe_Timer
                handle_equipping_gear(player.status, pet.status)
                refreshWindow()
            end
        end

        if buffactive["Light Maneuver"] then
            if original:contains(pet.name) and original:contains("Flashbulb") then
                add_to_chat(204, "*-*-*-*-*-*-*-*-* [ Flashbulb done ] *-*-*-*-*-*-*-*-*")
                Flashbulb_Time = os.time()
                Flashbulb_Recast = Flashbulb_Timer
                handle_equipping_gear(player.status, pet.status)
                refreshWindow()
            end
        end

        return modified, mode
    end
)

--Passes state changes for cycle commands
--handle_update is always called when a job state is changed
--Best to adjust gear in job_handle_update which is an override for the job file
lastStateActivated = ""
function job_state_change(stateField, newValue, oldValue)
    lastStateActivated = stateField

    if stateField == const_PetModeCycle then
        if newValue == const_tank then
            state.PetStyleCycle = state.PetStyleCycleTank
        elseif newValue == const_dd then
            state.PetStyleCycle = state.PetStyleCycleDD
        elseif newValue == const_mage then
            state.PetStyleCycle = state.PetStyleCycleMage
        else
            msg("No Style found for: " .. newValue)
        end

        handle_equipping_gear(player.status, Pet_State)
        refreshWindow()
    elseif stateField == const_PetStyleCycle then
        refreshWindow()
    elseif stateField == "Auto Maneuver" then
        refreshWindow()
    elseif stateField == "Lock Pet DT" then
        --This command overrides everything and blocks all gear changes
        --Will lock until turned off or Pet is disengaged
        if newValue == true then
            equip(sets.pet.EmergencyDT)
            disable(
                "main",
                "sub",
                "range",
                "ammo",
                "head",
                "neck",
                "lear",
                "rear",
                "body",
                "hands",
                "lring",
                "rring",
                "back",
                "waist",
                "legs",
                "feet"
            )
        else
            enable(
                "main",
                "sub",
                "range",
                "ammo",
                "head",
                "neck",
                "lear",
                "rear",
                "body",
                "hands",
                "lring",
                "rring",
                "back",
                "waist",
                "legs",
                "feet"
            )
        end
        refreshWindow()
    elseif stateField == "Lock Weapon" then
        if newValue == true then
            disable("main")
        else
            enable("main")
        end
        refreshWindow()
    elseif stateField == "Custom Gear Lock" then
        if newValue == true then
            disable(customGearLock)
        else
            enable(customGearLock)
            handle_equipping_gear(player.status, Pet_State)
        end
    end

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ""

    if state.PetModeCycle.value ~= "None" then
        msg = msg .. "Pet Mode: (" .. state.PetModeCycle.value .. ")"
    end

    if state.PetStyleCycle.value ~= "None" then
        msg = msg .. ", Pet Style: (" .. state.PetStyleCycle.value .. ")"
    end

    TotalSCalc()
    determinePuppetType()
    handle_equipping_gear(player.status, Pet_State)

    add_to_chat(122, msg)
end

function sub_job_change(new, old)
    determinePuppetType()
end

windower.raw_register_event("zone change", reset_timers)

--Special Debug Code that prints out to a file
function debug(message)
    if not d_mode then
        return
    end
    
    --Default location ..\PlayOnline\SquareEnix\FINAL FANTASY XI
    --Are welcome to add a custom path to the front for example C:\\users\\puppet_debug.log
    debug_file = io.open("puppet_debug.log", "a")

    io.output(debug_file)
    
    io.write('['..os.date()..'] - Debug - '..message..'\n')
    
    io.close(debug_file)

end

--Dump the contents of a table
function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o..'\n')
    end
 end