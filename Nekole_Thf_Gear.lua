-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
	state.IdleMode:options('Normal', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'Suppa', 'DWEarrings', 'DWMax'}
	state.AmbushMode = M(false, 'Ambush Mode')
	set_lockstyle()
    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind !` input /ra <t>')
    send_command('bind !- gs c cycle targetmode')
	send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace gs equip sets.Throwing')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind !r gs equip sets.MagicWeapons;gs c update user')
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

--	include('Nekole-Items.lua')
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {hands=gear.jse.relic.thf.hands,feet=gear.jse.empyrean.thf.feet})
    sets.ExtraRegen = {}
    sets.Kiting = {feet="Skadi's Jambeaux +1"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
    sets.buff['Sneak Attack'] = {}
	sets.buff['Trick Attack'] = {}
		
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.Suppa = {ear1="Suppanomimi", ear2="Sherida Earring"}
	sets.Weapons = {main="Mandau",sub="Twashtar"}
	sets.MagicWeapons = {main="Malevolence",sub="Malevolence"}
	sets.Throwing = {range="Raider's Bmrng."}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body=gear.AdhemarJacket.Bplus,hands="Floral Gauntlets",waist="Shetal Stone"}
	sets.Ambush = {} --body="Plunderer's Vest +1"
	
    -- Actions we want to use to tag TH.
	sets.precast.Step = set_combine(sets.engaged.FullAcc, sets.TreasureHunter)
	sets.precast.JA['Violent Flourish'] = set_combine(sets.engaged.FullAcc, sets.TreasureHunter)
	sets.precast.JA.Provoke = sets.TreasureHunter

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head=gear.jse.empyrean.thf.head} --head="Skulker's Bonnet"
    sets.precast.JA['Accomplice'] = {head=gear.jse.empyrean.thf.head} --head="Skulker's Bonnet"
    sets.precast.JA['Flee'] = {feet=gear.jse.artifact.thf.feet} --feet="Pillager's Poulaines +1"
    sets.precast.JA['Hide'] = {body=gear.jse.artifact.thf.body} --body="Pillager's Vest +1"
    sets.precast.JA['Conspirator'] = {body=gear.jse.empyrean.thf.body} --body="Skulker's Vest"
    sets.precast.JA['Steal'] = {
		ammo="Barathrum",
		head=gear.jse.relic.thf.head,
		hands=gear.jse.artifact.thf.hands,
		legs=gear.jse.artifact.thf.legs,
		feet=gear.jse.artifact.thf.feet}
	sets.precast.JA['Mug'] = {}
    sets.precast.JA['Despoil'] = {
		ammo="Barathrum",
		legs=gear.jse.empyrean.thf.legs,
		feet=gear.jse.empyrean.thf.feet}
    sets.precast.JA['Perfect Dodge'] = {hands=gear.jse.relic.thf.hands}
    sets.precast.JA['Feint'] = {legs=gear.jse.relic.thf.legs} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
 --       head="Mummu Bonnet +1",neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Handler's Earring +1",
  --      body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
 --       back="Moonbeam Cape",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet
 }
		
	sets.Self_Waltz = {
--	head="Mummu Bonnet +1",body="Passion Jacket",ring1="Asklepian Ring"
}
		
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Sapience Orb",
		head=gear.HerculeanBody.Crit, --7
		body=gear.taeon.body.tp, --8
		hands=gear.Leyline.FC, --7
		legs=gear.RawhideTrousers.A, --5
		feet=gear.HerculeanBoots.MAB, --2
		neck="Orunmila's Torque", --5
		ear1="Loquacious Earring", --2
		ear2="Etiolation Earring", --1
		ring2="Weather. Ring", --5(3)
		waist="Ninurta's Sash"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


    -- Ranged snapshot gear
    sets.precast.RA = {legs="Adhemar Kecks"}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Focal Orb",
		head=gear.lustratio.head.A,
		body=gear.AdhemarJacket.Bplus,
		hands=gear.ambuscade.meghanada.hands,
		legs=gear.lustratio.legs.A,
		feet=gear.lustratio.feet.A,
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Sherida Earring",
		ring1="Rajas Ring",
        ring2="Ilabrat Ring",
		back=gear.jsecapes.amb.thf.ws,
		waist="Fotia Belt",}
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque",hands="Meg. Gloves +1"})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {neck="Combatant's Torque",ear1="Telos Earring",body=gear.ambuscade.meghanada.body,hands=gear.ambuscade.meghanada.hands,waist="Olseni Belt",legs=gear.ambuscade.meghanada.legs})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque",ear1="Telos Earring",body=gear.ambuscade.meghanada.body,hands=gear.ambuscade.meghanada.hands,waist="Olseni Belt",legs=gear.ambuscade.meghanada.legs})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		ammo="Mantoptera Eye",
        head=gear.lustratio.head.A,
        neck=gear.neck.ws,
        ear1="Brutal Earring",
        ear2=gear.ears.ws,
        body=gear.AdhemarJacket.Bplus,
        hands=gear.lustratio.hands.A,
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back=gear.jsecapes.amb.thf.ws,
        waist=gear.waist.ws,
        legs=gear.HerculeanTrousers.WS,
        feet=gear.lustratio.feet.A})
    sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +2",back=gear.ws_jse_back})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +2",back=gear.ws_jse_back})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.ws_jse_back})
    sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {body="Adhemar Jacket"})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet",body="Meg. Cuirie +1",legs="Darraigner's Brais"})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet",body="Meg. Cuirie +1",legs="Darraigner's Brais"})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet",body="Meg. Cuirie +1",legs="Darraigner's Brais"})
	
    sets.precast.WS["Mandalic Stab"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +2",back=gear.ws_jse_back})
    sets.precast.WS["Mandalic Stab"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +2",back=gear.ws_jse_back})
    sets.precast.WS["Mandalic Stab"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +2",back=gear.ws_jse_back})
	sets.precast.WS["Mandalic Stab"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.ws_jse_back})
    sets.precast.WS["Mandalic Stab"].Fodder = set_combine(sets.precast.WS["Mandalic Stab"], {})
    sets.precast.WS["Mandalic Stab"].SA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet",legs="Darraigner's Brais"})
    sets.precast.WS["Mandalic Stab"].TA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet",legs="Darraigner's Brais"})
    sets.precast.WS["Mandalic Stab"].SATA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet",legs="Darraigner's Brais"})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +2",ring1="Karieyh Ring",back=gear.ws_jse_back})
    sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +2",back=gear.ws_jse_back})
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +2",back=gear.ws_jse_back})
	sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.ws_jse_back})
    sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {})
    sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet",legs="Darraigner's Brais"})
    sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet",legs="Darraigner's Brais"})
    sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet",legs="Darraigner's Brais"})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Yetshila",head="Adhemar Bonnet",neck="Fotia Gorget",body="Abnoba Kaftan",hands="Mummu Wrists +1",ring1="Begrudging Ring",waist="Fotia Belt",legs="Darraigner's Brais",feet="Mummu Gamash. +1"})
    sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Adhemar Bonnet",neck="Fotia Gorget",body="Abnoba Kaftan",hands="Mummu Wrists +1",ring1="Begrudging Ring",waist="Fotia Belt",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {head="Mummu Bonnet +1",ring1="Begrudging Ring",neck="Fotia Gorget",body="Mummu Jacket +1",hands="Mummu Wrists +1",waist="Fotia Belt",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {head="Mummu Bonnet +1",body="Mummu Jacket +1",hands="Mummu Wrists +1",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})

    sets.precast.WS['Last Stand'] = {
        head="Mummu Bonnet +1",neck="Fotia Gorget",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Mummu Jacket +1",hands="Mummu Wrists +1",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.ws_jse_back,waist="Fotia Belt",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"}

    sets.precast.WS['Aeolian Edge'] = {
		ammo="Seeth. Bomblet +1",
		head=gear.HerculeanHelm.TP,
		body="Samnuha Coat",
		hands="Leyline Gloves",
		legs=gear.HerculeanTrousers.MAB,
        feet=gear.HerculeanBoots.MAB,
		neck=gear.neck.mab,
		ear1="Hecate's Earring",
		ear2="Friomisi Earring",
		ring1=gear.ring.int1,
		ring2=gear.ring.int2,
		back="Toro Cape",
		waist="Eschan Stone",}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Ishvara Earring",ear2="Sherida Earring"}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Sherida Earring"}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
        back="Moonbeam Cape",waist="Hurch'lan Sash",legs="Rawhide Trousers",}

    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

    -- Ranged gear

    sets.midcast.RA = {
        head="Mummu Bonnet +1",neck="Combatant's Torque",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Mummu Jacket +1",hands="Mummu Wrists +1",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.da_jse_back,waist="Chaac Belt",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"}

    sets.midcast.RA.Acc = {
        head="Mummu Bonnet +1",neck="Combatant's Torque",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Mummu Jacket +1",hands="Mummu Wrists +1",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.da_jse_back,waist="Chaac Belt",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"}

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
		main="Mandau",
		sub="Taming Sari",
		ammo="Ginsen",
		head="Dampening Tam",
		body="Mekosu. Harness",
		hands="Regal Gloves",
		legs="Samnuha Tights",
--		feet="Jute Boots +1",
		feet="Skd. Jambeaux +1",
		neck="Sanctity Necklace",
		ear1="Sherida Earring",
		ear2="Infused Earring",
		ring1="Paguroidea Ring",
		ring2="Ilabrat Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",}
		
    sets.idle.Sphere = set_combine(sets.idle, {body="Mekosu. Harness"})

    sets.idle.Weak = set_combine(sets.idle, {})

	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Defense sets

    sets.defense.PDT = {
--	ammo="Staunch Tathlum",
 --       head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
 --       body="Meg. Cuirie +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
 --       back="Repulse Mantle",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet
 }

    sets.defense.MDT = {ammo="Staunch Tathlum",
 --       head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
  --      body="Meg. Cuirie +1",hands="Floral Gauntlets",ring1="Defending Ring",ring2="Dark Ring",
  --      back="Engulfer Cape +1",waist="Engraved Belt",legs=gear.herculean_dt_legs,feet="Ahosi Leggings"
  }
		
	sets.defense.MEVA = {ammo="Staunch Tathlum",
--		head=gear.herculean_fc_head,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
--		body="Adhemar Jacket",hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
--		back="Mujin Mantle",waist="Engraved Belt",legs="Adhemar Kecks",feet="Ahosi Leggings"
}


    --------------------------------------
    -- Melee sets  
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
		ammo="Yamarang",
		head="Dampening Tam",
		body=gear.AdhemarJacket.Bplus, -- 5
		hands=gear.AdhemarHands.B,
		legs=gear.SamnuhaTights.TP,
		feet=gear.HerculeanBoots.TA, --9
		neck="Anu Torque",
		ear1="Eabani Earring", --4
		ear2="Sherida Earring", --5
		ring1="Petrov Ring",
		ring2="Epona's Ring",
		back=gear.jsecapes.amb.thf.tp, --4
		waist="Patentia Sash", --5
		}
		
    sets.engaged.SomeAcc = {
		ammo="Yamarang",
		neck="Combatant's Torque",
		ring1="Chirich Ring"}
    
	sets.engaged.Acc = {
		ring1="Ilabrat Ring",
		ring2=gear.ring.dex1,
		back=gear.jsecapes.amb.thf.tp,
		waist="Kentarch Belt +1",}
		
    sets.engaged.FullAcc = {
		legs=gear.HerculeanTrousers.WS,
		feet=gear.HerculeanBoots.TA,
		ear1="Cessance Earring",
		ear2="Telos Earring",
		ring1=gear.ring.dex1,
		waist="Olseni Belt",}

    sets.engaged.Fodder = {ammo="Yamarang",
        head="Dampening Tam",neck="Ainia Collar",ear1="Brutal Earring",ear2="Sherida Earring",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.da_jse_back,waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.herculean_ta_feet}

    sets.engaged.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Moonbeam Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +1",feet="Ahosi Leggings"}

    sets.engaged.SomeAcc.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +1",feet="Ahosi Leggings"}
		
    sets.engaged.Acc.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +1",feet="Ahosi Leggings"}

    sets.engaged.FullAcc.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Olseni Belt",legs="Meg. Chausses +1",feet="Ahosi Leggings"}
		
    sets.engaged.Fodder.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +2",ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +1",feet=gear.herculean_dt_feet}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
 		set_macro_page(1, 2)
	elseif player.sub_job == 'WAR' then
		set_macro_page(2, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(3, 2)
	else
		set_macro_page(1, 2)
    end
end
function set_lockstyle()
	send_command('wait 2; input /lockstyleset 7')
end

--Dynamis Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[936] == 0 and not have_trust("Karaha-Baruha") then
					windower.send_command('input /ma "Karaha-Baruha" <me>')
					return true
				elseif spell_recasts[952] == 0 and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					return true
				elseif spell_recasts[914] == 0 and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					return true
				elseif spell_recasts[989] == 0 and not have_trust("KingofHearts") then
					windower.send_command('input /ma "King of Hearts" <me>')
					return true
				elseif spell_recasts[968] == 0 and not have_trust("Adelheid") then
					windower.send_command('input /ma "Adelheid" <me>')
					return true
				else
					return false
				end
			end
		end
	end
	return false
end