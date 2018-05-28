--- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','DTLite','PDT','Reraise')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder','Proc')
    state.RangedMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT','PDTReraise')
	state.MagicalDefenseMode:options('MDT','MDTReraise')
	state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal', 'Reraise')
	state.Weapons:options('Dojikiri','ProcWeapon','Bow')
--	state.Weapons:options('Amanomurakumo','ProcWeapon','Bow')
	
	set_lockstyle()	
    update_combat_form()
	
--	gear.ws_jse_back = {name="Smertrios's Mantle",augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
--	gear.stp_jse_back = {name="Smertrios's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}

-- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind !backspace input /ja "Third Eye" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !@^` gs c cycle Stance')
	send_command('bind !r gs c weapons MultiWeapon;gs c set WeaponskillMode Proc;gs c update')
	send_command('bind ^r gs c weapons;gs c set WeaponskillMode Normal;gs c update')
	send_command('bind ^q gs c weapons Bow;gs c update')

    select_default_macro_book()
	set_lockstyle()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head=gear.jse.artifact.sam.head,hands=gear.jse.relic.sam.hands,back=gear.jsecapes.amb.sam.ws}
    sets.precast.JA['Warding Circle'] = {head=gear.jse.artifact.sam.head}
    sets.precast.JA['Blade Bash'] = {hands=gear.jse.relic.sam.hands}
	sets.precast.JA['Sekkanoki'] = {hands=gear.jse.empyrean.sam.hands}
	sets.precast.JA['Sengikori'] = {feet=gear.jse.empyrean.sam.feet}
	
    sets.precast.Step = {
        head=gear.ambuscade.flamma.head,
		neck="Moonbeam Nodowa",
		ear1="Zennaroi Earring",
		ear2="Telos Earring",
        body="Tartarus Platemail",
		hands="Acro Gauntlets",
		ring1="Ramuh Ring +1",
		ring2="Ramuh Ring +1",
        back=gear.jsecapes.amb.sam.tp,
		waist="Olseni Belt",
		legs="Acro Breeches",
		feet="Founder's Greaves"}
    sets.precast.JA['Violent Flourish'] = {
        head="Founder's Corona",
		neck="Sanctity Necklace",
		ear1="Gwati Earring",
		ear2="Telos Earring",
        body="Found. Breastplate",
		hands="Leyline Gloves",
		ring1="Stikini Ring",
		ring2="Ramuh Ring +1",
        back=gear.jsecapes.amb.sam.tp,waist="Olseni Belt",legs="Acro Breeches",feet="Founder's Greaves"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head=gear.ambuscade.flamma.head,
        body="Tartarus Platemail",hands="Acro Gauntlets",ring1="Asklepian Ring",ring2="Valseur's Ring",
        waist="Chaac Belt",legs="Acro Breeches",feet="Sak. Sune-Ate +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring"}
	   
    -- Ranged snapshot gear
    sets.precast.RA = {}
	   
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
        head=gear.ValorousMask.WSD,
		neck="Fotia Gorget",
		ear1="Lugra Earring +1",
		ear2="Moonshade Earring",
 --       body="Phorcys Korazin",
		body=gear.ValorousMail.WSD,
		hands=gear.ValorousMitts.WSD,
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
        back=gear.jsecapes.amb.sam.ws,
		waist="Fotia Belt",
		legs=gear.ambuscade.hizamaru.legs,
		feet=gear.ValorousGreaves.WSD}
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {ear1="Cessance Earring",body=gear.ambuscade.hizamaru.body})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {head=gear.jse.artifact.sam.head,ear1="Cessance Earring",body=gear.ambuscade.hizamaru.body})
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {head=gear.jse.artifact.sam.head,neck="Moonbeam Nodowa",ear1="Zennaroi Earring",ear2="Telos Earring",body=gear.ambuscade.hizamaru.body,ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",})
    sets.precast.WS.Fodder = set_combine(sets.precast.WS, {ring2="Apate Ring"})
	
	sets.precast.WS.Proc = {ammo="Hasty Pinion +1",
        head=gear.ambuscade.flamma.head,neck="Moonbeam Nodowa",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Tartarus Platemail",hands=gear.ambuscade.flamma.hands,ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.jsecapes.amb.sam.tp,waist="Olseni Belt",legs="Acro Breeches",feet=gear.ambuscade.flamma.feet}
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Fudo'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Fudo'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Fudo'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Shoha'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Shoha'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Shoha'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Rana'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Rana'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Rana'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Kasha'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Kasha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Kasha'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Kasha'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Gekko'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Gekko'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Gekko'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Gekko'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Yukikaze'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Yukikaze'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Yukikaze'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Yukikaze'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Ageha'] = {ammo="Pemphredo Tathlum",
        head=gear.ambuscade.flamma.head,neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Moonshade Earring",
        body=gear.ambuscade.flamma.body,hands=gear.ambuscade.flamma.hands,ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.jsecapes.amb.sam.ws,waist="Eschan Stone",legs=gear.ambuscade.flamma.legs,feet=gear.ambuscade.flamma.feet}
		
    sets.precast.WS['Tachi: Hobaku'] = {ammo="Pemphredo Tathlum",
        head=gear.ambuscade.flamma.head,neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Moonshade Earring",
        body=gear.ambuscade.flamma.body,hands=gear.ambuscade.flamma.hands,ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.jsecapes.amb.sam.ws,waist="Eschan Stone",legs=gear.ambuscade.flamma.legs,feet=gear.ambuscade.flamma.feet}
		
    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {head=gear.ValorousMask.WSD,ear1="Friomisi Earring",body="Found. Breastplate",hands="Founder's Gauntlets",feet="Founder's Greaves"})

    sets.precast.WS['Apex Arrow'] = {
        head=gear.jse.artifact.sam.head,neck="Fotia Gorget",ear1="Clearview Earring",ear2="Moonshade Earring",
        body="Kyujutsugi",hands="Buremte Gloves",ring1="Ilabrat Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.sam.ws,waist="Fotia Belt",legs=gear.jse.artifact.sam.legs,feet=gear.jse.artifact.sam.feet}
		
    sets.precast.WS['Apex Arrow'].SomeAcc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Apex Arrow'].FullAcc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Apex Arrow'].Fodder = set_combine(sets.precast.WS['Apex Arrow'], {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Cessance Earring",ear2="Lugra Earring +1",}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Zennaroi Earring",ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Ishvara Earring",ear2="Cessance Earring",}
	sets.AccDayWSEars = {ear1="Zennaroi Earring",ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Ishvara Earring",ear2="Moonshade Earring",}
	
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Loess Barbuta +1",neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Tartarus Platemail",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
        back="Moonbeam Cape",waist="Tempus Fugit",legs=gear.ambuscade.hizamaru.legs,feet="Amm Greaves"}
		
    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
	
		
    -- Ranged gear
    sets.midcast.RA = {
        head=gear.ambuscade.flamma.head,neck="Ocachi Gorget",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Kyujutsugi",hands="Buremte Gloves",ring1="Ilabrat Ring",ring2="Regal Ring",
        back="Buquwik Cape",waist="Flax Sash",legs="Acro Breeches",feet=gear.jse.artifact.sam.feet}

    sets.midcast.RA.Acc = {
        head=gear.ambuscade.flamma.head,neck="Combatant's Torque",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Kyujutsugi",hands="Buremte Gloves",ring1="Ilabrat Ring",ring2="Regal Ring",
        back="Buquwik Cape",waist="Flax Sash",legs="Acro Breeches",feet=gear.jse.artifact.sam.feet}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {ammo="Staunch Tathlum",
        head=gear.ValorousMask.WSD,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body=gear.ambuscade.hizamaru.body,hands=gear.jse.relic.sam.hands,ring1="Defending Ring",ring2=gear.ring.regen_right,
        back="Solemnity Cape",waist="Flume Belt +1",legs=gear.ambuscade.hizamaru.legs,feet=gear.ambuscade.flamma.feet}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	
	sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {}
	
    sets.idle = {
		ammo="Staunch Tathlum",
		sub="Utu Grip",
        head="Ken. Jinpachi +1",
		neck="Loricate Torque +1",
		ear1="Cessance Earring",
		ear2="Telos Earring",
        body="Kendatsuba Samue +1",
		hands="Ken. Tekko +1",
		ring1="Defending Ring",
		ring2="Sheltered Ring",
        back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1"}
		
    sets.idle.Reraise = set_combine(sets.idle, sets.Reraise)

    sets.idle.Weak = {ammo="Staunch Tathlum",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Twilight Mail",hands=gear.jse.relic.sam.hands,ring1="Defending Ring",ring2=gear.ring.regen_right,
        back="Solemnity Cape",waist="Flume Belt +1",legs=gear.ambuscade.flamma.legs,feet="Danzo Sune-ate"}
		
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
	
	sets.DayIdle = {}
	sets.NightIdle = {}
    
    -- Defense sets
    sets.defense.PDT = {ammo="Staunch Tathlum",
        head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Tartarus Platemail",hands=gear.ValorousMitts.WSD,ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Ioskeha Belt",legs=gear.ambuscade.hizamaru.legs,feet="Amm Greaves"}

    sets.defense.PDTReraise = set_combine(sets.defense.PDT, sets.Reraise)
		
    sets.defense.MDT = {ammo="Staunch Tathlum",
        head="Loess Barbuta +1",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Engulfer Cape +1",waist="Flax Sash",legs=gear.ambuscade.hizamaru.legs,feet="Amm Greaves"}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, sets.Reraise)
	
    sets.defense.MEVA = {ammo="Staunch Tathlum",
        head="Ken. Jinpachi +1",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Vengeful Ring",Ring2="Purity Ring",
        back="Engulfer Cape +1",waist="Flax Sash",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {
		ammo="Ginsen",
 --       head=gear.ambuscade.flamma.head,
		head="Ken. Jinpachi +1",
		neck="Moonbeam Nodowa",
		ear1="Cessance Earring",
		ear2="Telos Earring",
        body="Ken. Samue +1",
--		hands=gear.ValorousMitts.WSD,
		hands="Ken. Tekko +1",
		ring1="Niqmaddu Ring",
--		ring2="Petrov Ring",
		ring2="Ilabrat Ring",
        back=gear.jsecapes.amb.sam.tp,
		waist="Ioskeha Belt",
--		legs="Acro Breeches",
		legs="Ken. Hakama +1",
--		feet=gear.ambuscade.flamma.feet}
		feet="Ken. Sune-Ate +1"}
    sets.engaged.SomeAcc = {ammo="Ginsen",
        head=gear.ambuscade.flamma.head,neck="Moonbeam Nodowa",ear1="Cessance Earring",ear2="Brutal Earring",
        body=gear.jse.empyrean.sam.body,hands=gear.valorous_wsd_hands,ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.jsecapes.amb.sam.tp,waist="Ioskeha Belt",legs="Acro Breeches",feet=gear.ambuscade.flamma.feet}
    sets.engaged.Acc = {ammo="Ginsen",
        head=gear.ambuscade.flamma.head,neck="Moonbeam Nodowa",ear1="Digni. Earring",ear2="Telos Earring",
        body=gear.jse.empyrean.sam.body,hands=gear.valorous_wsd_hands,ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.jsecapes.amb.sam.tp,waist="Ioskeha Belt",legs="Acro Breeches",feet=gear.ambuscade.flamma.feet}
    sets.engaged.FullAcc = {ammo="Ginsen",
        head=gear.ambuscade.flamma.head,neck="Moonbeam Nodowa",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.jsecapes.amb.sam.tp,waist="Olseni Belt",legs=gear.ambuscade.hizamaru.legs,feet=gear.ambuscade.flamma.feet}
    sets.engaged.Fodder = {ammo="Ginsen",
        head=gear.ambuscade.flamma.head,neck="Moonbeam Nodowa",ear1="Cessance Earring",ear2="Brutal Earring",
        body=gear.jse.empyrean.sam.body,hands=gear.valorous_wsd_hands,ring1="Niqmaddu Ring",ring2="Petrov Ring",
        back=gear.jsecapes.amb.sam.tp,waist="Ioskeha Belt",legs="Acro Breeches",feet=gear.ambuscade.flamma.feet}
    sets.engaged.PDT = {ammo="Staunch Tathlum",
        head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Ioskeha Belt",legs=gear.ambuscade.hizamaru.legs,feet="Amm Greaves"}
    sets.engaged.SomeAcc.PDT = {ammo="Staunch Tathlum",
        head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Ioskeha Belt",legs=gear.ambuscade.hizamaru.legs,feet="Amm Greaves"}
    sets.engaged.Acc.PDT = {ammo="Staunch Tathlum",
        head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Ioskeha Belt",legs=gear.ambuscade.hizamaru.legs,feet="Amm Greaves"}
    sets.engaged.FullAcc.PDT = {ammo="Staunch Tathlum",
        head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Ioskeha Belt",legs=gear.ambuscade.hizamaru.legs,feet="Amm Greaves"}
    sets.engaged.Fodder.PDT = {ammo="Staunch Tathlum",
        head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Ioskeha Belt",legs=gear.ambuscade.hizamaru.legs,feet="Amm Greaves"}
	sets.engaged.DTLite = {ammo="Staunch Tathlum",
        head="Ynglinga Sallet",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back=gear.jsecapes.amb.sam.tp,waist="Ioskeha Belt",legs="Acro Breeches",feet="Amm Greaves"}	
    sets.engaged.SomeAcc.DTLite = {ammo="Staunch Tathlum",
        head="Ynglinga Sallet",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back=gear.jsecapes.amb.sam.tp,waist="Ioskeha Belt",legs="Acro Breeches",feet="Amm Greaves"}		
    sets.engaged.Acc.DTLite = {ammo="Staunch Tathlum",
        head="Ynglinga Sallet",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back=gear.jsecapes.amb.sam.tp,waist="Ioskeha Belt",legs="Acro Breeches",feet="Amm Greaves"}	
    sets.engaged.FullAcc.DTLite = {ammo="Staunch Tathlum",
        head="Ynglinga Sallet",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back=gear.jsecapes.amb.sam.tp,waist="Ioskeha Belt",legs="Acro Breeches",feet="Amm Greaves"}	
    sets.engaged.Fodder.DTLite = {ammo="Staunch Tathlum",
        head=gear.ambuscade.flamma.head,neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back=gear.jsecapes.amb.sam.tp,waist="Ioskeha Belt",legs="Acro Breeches",feet="Amm Greaves"}	

    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)		
    sets.engaged.SomeAcc.Reraise = set_combine(sets.engaged.SomeAcc, sets.Reraise)		
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)		
    sets.engaged.FullAcc.Reraise = set_combine(sets.engaged.FullAcc, sets.Reraise)		
    sets.engaged.Fodder.Reraise = set_combine(sets.engaged.Fodder, sets.Reraise)		
        
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
--[[Right now Adoulin sets are the same as non-Adoulin.
	sets.engaged.Adoulin = {ammo="Ginsen",
        head=gear.ambuscade.flamma.head,neck="Moonbeam Nodowa",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Kasuga Domaru +1",hands=gear.valorous_wsd_hands,ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.jsecapes.amb.sam.tp,waist="Ioskeha Belt",legs="Acro Breeches",feet=gear.ambuscade.flamma.feet}
    sets.engaged.Adoulin.SomeAcc = {ammo="Ginsen",
        head=gear.ambuscade.flamma.head,neck="Combatant's Torque",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Kasuga Domaru +1",hands="Acro Gauntlets",ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.jsecapes.amb.sam.tp,waist="Windbuffet Belt +1",legs="Acro Breeches",feet="Amm Greaves"}
	sets.engaged.Adoulin.Acc = {ammo="Ginsen",
        head=gear.ambuscade.flamma.head,neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Kasuga Domaru +1",hands="Acro Gauntlets",ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.jsecapes.amb.sam.tp,waist="Olseni Belt",legs="Acro Breeches",feet="Amm Greaves"}
    sets.engaged.Adoulin.FullAcc = {ammo="Ginsen",
        head=gear.ambuscade.flamma.head,neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Kasuga Domaru +1",hands="Acro Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.jsecapes.amb.sam.tp,waist="Olseni Belt",legs="Acro Breeches",feet=gear.ambuscade.flamma.feet}
    sets.engaged.Adoulin.Fodder = {ammo="Ginsen",
        head=gear.ambuscade.flamma.head,neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Kasuga Domaru +1",hands="Acro Gauntlets",ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.jsecapes.amb.sam.tp,waist="Windbuffet Belt +1",legs="Acro Breeches",feet=gear.ambuscade.flamma.feet}
    sets.engaged.Adoulin.PDT = {ammo="Staunch Tathlum",
        head=gear.ambuscade.flamma.head,neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Hiza. Hizayoroi +2",feet="Amm Greaves"}
    sets.engaged.Adoulin.SomeAcc.PDT = {ammo="Staunch Tathlum",
        head=gear.ambuscade.flamma.head,neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Hiza. Hizayoroi +2",feet="Amm Greaves"}	
		sets.engaged.Adoulin.Acc.PDT = {ammo="Staunch Tathlum",
        head=gear.ambuscade.flamma.head,neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Olseni Belt",legs="Hiza. Hizayoroi +2",feet="Amm Greaves"}
    sets.engaged.Adoulin.FullAcc.PDT = {ammo="Staunch Tathlum",
        head=gear.ambuscade.flamma.head,neck="Loricate Torque +1",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back="Letalis Mantle",waist="Olseni Belt",legs="Hiza. Hizayoroi +2",feet="Amm Greaves"}
    sets.engaged.Adoulin.Fodder.PDT = {ammo="Staunch Tathlum",
        head=gear.ambuscade.flamma.head,neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Hiza. Hizayoroi +2",feet="Amm Greaves"}
		
	sets.engaged.Adoulin.DTLite = sets.engaged.DTLite
    sets.engaged.Adoulin.SomeAcc.DTLite = sets.engaged.SomeAcc.DTLite
    sets.engaged.Adoulin.Acc.DTLite = sets.engaged.Acc.DTLite
    sets.engaged.Adoulin.FullAcc.DTLite = sets.engaged.FullAcc.DTLite
    sets.engaged.Adoulin.Fodder.DTLite = sets.engaged.Fodder.DTLite
    sets.engaged.Adoulin.Reraise = set_combine(sets.engaged.Adoulin, sets.Reraise)		
    sets.engaged.Adoulin.SomeAcc.Reraise = set_combine(sets.engaged.Adoulin.SomeAcc, sets.Reraise)		
    sets.engaged.Adoulin.Acc.Reraise = set_combine(sets.engaged.Adoulin.Acc, sets.Reraise)		
    sets.engaged.Adoulin.FullAcc.Reraise = set_combine(sets.engaged.Adoulin.FullAcc, sets.Reraise)		
    sets.engaged.Adoulin.Fodder.Reraise = set_combine(sets.engaged.Adoulin.Fodder, sets.Reraise)
]]--Right now Adoulin sets are the same as non-Adoulin.

--	sets.weapons.Dojikiri = {main="Amanomurakumo",sub="Utu Grip"}
	sets.weapons.Dojikiri = {main="Dojikiri Yasutsuna",sub="Utu Grip"}
	sets.weapons.ProcWeapon = {main="Norifusa +1",sub="Bloodrain Strap"}
	sets.weapons.Bow = {main="Norifusa +1",sub="Utu Grip",range="Cibitshavore",ammo="Eminent Arrow"}

	sets.Cure_Recieved = {hands="Buremte Gloves",legs=gear.ambuscade.flamma.legs}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque +1"}
	sets.buff.Hasso = {legs=gear.jse.empyrean.sam.legs}
    sets.buff.Sekkanoki = {hands=gear.jse.empyrean.sam.hands}
    sets.buff.Sengikori = {feet=gear.jse.empyrean.sam.feet}
    sets.buff['Meikyo Shisui'] = {feet=gear.jse.relic.sam.feet}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 7)
    else
        set_macro_page(1, 7)
    end
end
function set_lockstyle()
	send_command('wait 5; input /lockstyleset 12')
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[980] == 0 and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = 250
					return true
				elseif spell_recasts[952] == 0 and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = 250
					return true
				elseif spell_recasts[967] == 0 and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = 250
					return true
				elseif spell_recasts[914] == 0 and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = 250
					return true
				elseif spell_recasts[979] == 0 and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
					tickdelay = 250
					return true
				else
					return false
				end
			end
		end
	end
	return false
end