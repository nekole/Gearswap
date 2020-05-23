-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder')
	state.IdleMode:options('Normal', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Aeneas','AccAeneas','Twashtar','TH','Savage','AccSavage','MagicWeapons','Evisceration','Throwing','SwordThrowing','Bow')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWEarrings','DWMax'}
	state.AmbushMode = M(false, 'Ambush Mode')
	set_lockstyle()
 
 -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind !` input /ra <t>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace gs c weapons Bow')
	send_command('bind ^q gs c weapons Throwing')
	send_command('bind !q gs c weapons SwordThrowing')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind !r gs c weapons MagicWeapons')
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

	sets.TreasureHunter = {hands=gear.jse.relic.thf.hands,waist="Chaac Belt",feet=gear.jse.empyrean.thf.feet}
    sets.ExtraRegen = {}
    sets.Kiting = {feet="Skadi's Jambeaux +1"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	
    sets.buff['Sneak Attack'] = {}
	sets.buff['Trick Attack'] = {}
		
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.Suppa = {ear1="Suppanomimi", ear2="Sherida Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body=gear.AdhemarJacket.Bplus,waist="Reiki Yotai"}
	sets.Parry = {hands="Turms Mittens",ring1="Defending Ring"}
	sets.Ambush = {} --body="Plunderer's Vest +1"
	
	sets.weapons.Aeneas = {main="Aeneas",sub="Twashtar"}
	sets.weapons.AccAeneas = {main="Aeneas",sub="Tauret"}
	sets.weapons.Twashtar = {main="Twashtar",sub="Aeneas"}
	sets.weapons.TH = {main="Taming Sari",sub="Aeneas"}
	sets.weapons.Savage = {main="Naegling",sub="Blurred Knife +1"}
	sets.weapons.AccSavage = {main="Naegling",sub="Tauret"}
	sets.weapons.MagicWeapons = {main="Malevolence",sub="Malevolence"}
	sets.weapons.Evisceration = {main="Tauret",sub="Blurred Knife +1"}
	sets.weapons.Throwing = {main="Aeneas",sub="Blurred Knife +1",range="Comet Tail",ammo=empty}
	sets.weapons.SwordThrowing = {main="Naegling",sub="Blurred Knife +1",range="Comet Tail",ammo=empty}
	sets.weapons.Bow = {main="Aeneas",sub="Twashtar",range="Ullr"}
	
    -- Actions we want to use to tag TH.
	sets.precast.Step = {ammo="C. Palug Stone",
        head="Malignance Chapeau",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Odr Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.jsecapes.amb.thf.tp,waist="Olseni Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
    sets.precast.JA['Violent Flourish'] = {ammo="C. Palug Stone",
        head="Malignance Chapeau",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Odr Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.jsecapes.amb.thf.tp,waist="Olseni Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head=gear.jse.empyrean.thf.head} 
    sets.precast.JA['Accomplice'] = {head=gear.jse.empyrean.thf.head} 
    sets.precast.JA['Flee'] = {} 
    sets.precast.JA['Hide'] = {body=gear.jse.artifact.thf.body} 
    sets.precast.JA['Conspirator'] = {body=gear.jse.empyrean.thf.body} 
    sets.precast.JA['Steal'] = {head=gear.jse.relic.thf.head}
	sets.precast.JA['Mug'] = {}
    sets.precast.JA['Despoil'] = {legs=gear.jse.empyrean.thf.legs,feet=gear.jse.empyrean.thf.feet}
    sets.precast.JA['Perfect Dodge'] = {hands=gear.jse.relic.thf.hands}
    sets.precast.JA['Feint'] = {legs=gear.jse.relic.thf.legs} 

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
 --       head="Mummu Bonnet +2",neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Handler's Earring +1",
  --      body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
 --       back="Moonbeam Cape",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet
 }
		
	sets.Self_Waltz = {
--	head="Mummu Bonnet +2",body="Passion Jacket",ring1="Asklepian Ring"
}
		
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Impatiens",
		head=gear.HerculeanHelm.TP, --7
		body=gear.taeon.body.tp, --8
		hands=gear.Leyline.FC, --7
		legs=gear.RawhideTrousers.A, --5
		feet=gear.HerculeanBoots.MAB, --2
		neck="Orunmila's Torque", --5
		ear1="Loquacious Earring", --2
		ear2="Enchntr. Earring +1", --1
		ring1="Prolix Ring",
		ring2="Lebeche Ring", --5(3)
		}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


    -- Ranged snapshot gear
    sets.precast.RA = {legs=gear.AdhemarKecks.C}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Seeth. Bomblet +1",
		head=gear.jse.artifact.thf.head,
		body=gear.AdhemarJacket.Bplus,
		hands=gear.ambuscade.meghanada.hands,
		legs="Samnuha Tights",
		feet=gear.HerculeanBoots.WS,
		neck="Caro Necklace",
		ear1="Brutal Earring",
		ear2="Sherida Earring",
		ring1="Regal Ring",
        ring2="Ilabrat Ring",
		back=gear.jsecapes.amb.thf.ws,
		waist="Sailfi Belt +1"}
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="C. Palug Stone",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Odr Earring",
	body=gear.ambuscade.meghanada.body,hands=gear.ambuscade.meghanada.hands,waist="Olseni Belt",legs=gear.ambuscade.meghanada.legs,feet="Malignance Boots"})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {ammo="C. Palug Stone",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Odr Earring",body=gear.ambuscade.meghanada.body,hands=gear.ambuscade.meghanada.hands,waist="Olseni Belt",legs=gear.ambuscade.meghanada.legs,feet="Malignance Boots"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		ammo="C. Palug Stone",
        head=gear.AdhemarBonnet.Aplus,
        neck="Asn. Gorget +1",
        ear1="Moonshade Earring",
		ear2="Ishvara Earring",
        back=gear.jsecapes.amb.thf.ws})
    sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head=gear.AdhemarBonnet.Aplus,neck="Caro Necklace",ear1="Moonshade Earring",body=gear.ambuscade.meghanada.body,hands=gear.ambuscade.meghanada.hands,back=gear.jsecapes.amb.thf.ws})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {head=gear.AdhemarBonnet.Aplus,neck="Caro Necklace",ear1="Moonshade Earring",body=gear.ambuscade.meghanada.body,hands=gear.ambuscade.meghanada.hands,back=gear.jsecapes.amb.thf.ws})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.jsecapes.amb.thf.ws})
    sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="C. Palug Stone",body=gear.AdhemarJacket.Bplus})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Yetshila +1",head=gear.AdhemarBonnet.Aplus,body=gear.ambuscade.meghanada.body,legs="Darraigner's Brais"})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Yetshila +1",head=gear.AdhemarBonnet.Aplus,body=gear.ambuscade.meghanada.body,legs="Darraigner's Brais"})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Yetshila +1",head=gear.AdhemarBonnet.Aplus,body=gear.ambuscade.meghanada.body,legs="Darraigner's Brais"})
	
    sets.precast.WS["Mandalic Stab"] = set_combine(sets.precast.WS, {head=gear.AdhemarBonnet.Aplus,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body=gear.ambuscade.meghanada.body,back=gear.jsecapes.amb.thf.ws})
    sets.precast.WS["Mandalic Stab"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head=gear.AdhemarBonnet.Aplus,neck="Caro Necklace",ear1="Moonshade Earring",body=gear.ambuscade.meghanada.body,hands="Meg. Gloves +2",back=gear.jsecapes.amb.thf.ws})
    sets.precast.WS["Mandalic Stab"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body=gear.ambuscade.meghanada.body,back=gear.jsecapes.amb.thf.ws})
	sets.precast.WS["Mandalic Stab"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.jsecapes.amb.thf.ws})
    sets.precast.WS["Mandalic Stab"].Fodder = set_combine(sets.precast.WS["Mandalic Stab"], {ammo="C. Palug Stone",body=gear.AdhemarJacket.Bplus})
    sets.precast.WS["Mandalic Stab"].SA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Yetshila +1",head=gear.AdhemarBonnet.Aplus,legs="Darraigner's Brais"})
    sets.precast.WS["Mandalic Stab"].TA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Yetshila +1",head=gear.AdhemarBonnet.Aplus,legs="Darraigner's Brais"})
    sets.precast.WS["Mandalic Stab"].SATA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Yetshila +1",head=gear.AdhemarBonnet.Aplus,legs="Darraigner's Brais"})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head=gear.AdhemarBonnet.Aplus,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body=gear.ambuscade.meghanada.body,back=gear.jsecapes.amb.thf.ws})
    sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head=gear.AdhemarBonnet.Aplus,neck="Caro Necklace",ear1="Moonshade Earring",body=gear.ambuscade.meghanada.body,back=gear.jsecapes.amb.thf.ws})
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body=gear.ambuscade.meghanada.body,hands="Meg. Gloves +2",back=gear.jsecapes.amb.thf.ws})
	sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.jsecapes.amb.thf.ws})
    sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {ammo="C. Palug Stone",body=gear.AdhemarJacket.Bplus})
    sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila +1",head=gear.AdhemarBonnet.Aplus,legs="Darraigner's Brais"})
    sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila +1",head=gear.AdhemarBonnet.Aplus,legs="Darraigner's Brais"})
    sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila +1",head=gear.AdhemarBonnet.Aplus,legs="Darraigner's Brais"})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Yetshila +1",head=gear.AdhemarBonnet.Aplus,neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Odr Earring",body="Abnoba Kaftan",hands="Mummu Wrists +2",ring1="Begrudging Ring",waist="Fotia Belt",legs="Darraigner's Brais",feet="Mummu Gamash. +2"})
    sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head=gear.AdhemarBonnet.Aplus,neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Odr Earring",body="Abnoba Kaftan",hands="Mummu Wrists +2",ring1="Begrudging Ring",waist="Fotia Belt",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {head="Mummu Bonnet +2",ring1="Begrudging Ring",neck="Fotia Gorget",body="Mummu Jacket +2",hands="Mummu Wrists +2",waist="Fotia Belt",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {head="Mummu Bonnet +2",body="Mummu Jacket +2",hands="Mummu Wrists +2",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
	
	sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS, {neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body=gear.AdhemarJacket.Bplus,back=gear.jsecapes.amb.thf.ws,waist="Sailfi Belt +1"})
    sets.precast.WS["Savage Blade"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {neck="Caro Necklace",ear1="Moonshade Earring",body="Meg. Cuirie +2",back=gear.jsecapes.amb.thf.ws})
    sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body="Meg. Cuirie +2",back=gear.jsecapes.amb.thf.ws})
	sets.precast.WS["Savage Blade"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.wsd_jse_back})
    sets.precast.WS["Savage Blade"].Fodder = set_combine(sets.precast.WS["Savage Blade"], {ammo="C. Palug Stone",body=gear.HerculeanBody.Crit,waist="Sailfi Belt +1"})
    sets.precast.WS["Savage Blade"].SA = set_combine(sets.precast.WS["Savage Blade"].Fodder, {ammo="Yetshila +1",body="Meg. Cuirie +2",legs="Darraigner's Brais"})
    sets.precast.WS["Savage Blade"].TA = set_combine(sets.precast.WS["Savage Blade"].Fodder, {ammo="Yetshila +1",body="Meg. Cuirie +2",legs="Darraigner's Brais"})
    sets.precast.WS["Savage Blade"].SATA = set_combine(sets.precast.WS["Savage Blade"].Fodder, {ammo="Yetshila +1",body="Meg. Cuirie +2",legs="Darraigner's Brais"})

    sets.precast.WS['Last Stand'] = {
        head=gear.jse.artifact.thf.head,neck="Fotia Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.thf.ws,waist="Fotia Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.precast.WS['Empyreal Arrow'] = {
        head=gear.jse.artifact.thf.head,neck="Fotia Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.wsd_jse_back,waist="Fotia Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.precast.WS['Aeolian Edge'] = {
		ammo="Seeth. Bomblet +1",
		head=gear.HerculeanHelm.TP,
		body="Samnuha Coat",
		hands="Leyline Gloves",
		legs=gear.HerculeanTrousers.MAB,
        feet=gear.HerculeanBoots.MAB,
		neck="Baetyl Pendant",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
		back=gear.jsecapes.amb.thf.ws,
		waist="Chaac Belt",}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Ishvara Earring",ear2="Sherida Earring"}
	sets.precast.AccMaxTP = {ear1="Mache Earring +1",ear2="Sherida Earring"}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Malignance Tabard",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
        back="Moonbeam Cape",legs="Malignance Boots"}

    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

    -- Ranged gear

    sets.midcast.RA = {
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.thf.ws,waist="Chaac Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.midcast.RA.Acc = {
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.thf.ws,waist="Chaac Belt",legs="Malignance Tights",feet="Malignance Boots"}


    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
		main="Mandau",
		sub="Taming Sari",
		ammo="Aurgelmir Orb +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Sanctity Necklace",
		ear1="Sherida Earring",
		ear2="Infused Earring",
		ring1="Paguroidea Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",}
		
    sets.idle.Sphere = set_combine(sets.idle, {body="Mekosu. Harness"})

    sets.idle.Weak = set_combine(sets.idle, {})

	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.ExtraRegen = {hands="Turms Mittens"}

    -- Defense sets
	
	sets.defense.PDT = {ammo="Staunch Tathlum",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Engulfer Cape +1",waist="Flume Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

    sets.defense.MDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +2",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Engulfer Cape +1",waist="Flume Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.defense.MEVA = {ammo="Staunch Tathlum",
		head="Dampening Tam",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body=gear.AdhemarJacket.Bplus,hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Gelatinous Ring +1",
		back="Engulfer Cape +1",waist="Flume Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

    --------------------------------------
    -- Melee sets  
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
		ammo="Aurgelmir Orb +1",
		head=gear.AdhemarBonnet.B,
		body=gear.jse.artifact.thf.body, -- 5
		hands=gear.AdhemarHands.B,
		legs=gear.SamnuhaTights.TP,
		feet=gear.HerculeanBoots.TA, --9
		neck="Asn. Gorget +1",
		ear1="Dedition Earring", --4
		ear2="Sherida Earring", --5
		ring1="Gere Ring",
		ring2="Epona's Ring",
		back=gear.jsecapes.amb.thf.tp, --4
		waist="Windbuffet Belt +1", --5
		}
    
	sets.engaged.SomeAcc = {ammo="Yamarang",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Brutal Earring",ear2="Sherida Earring",
        body=gear.AdhemarJacket.Bplus,hands="Adhemar Wrist. +1",ring1="Gere Ring",ring2="Epona's Ring",
        back=gear.jsecapes.amb.thf.tp,waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.HerculeanBoots.TA}
    
	sets.engaged.Acc = {ammo="Yamarang",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Suppanomimi",ear2="Telos Earring",
        body="Mummu Jacket +2",hands=gear.AdhemarHands.B,ring1="Ilabrat Ring",ring2="Regal Ring",
        back=gear.jsecapes.amb.thf.tp,waist="Olseni Belt",legs="Meg. Chausses +2",feet="Malignance Boots"}
		
    sets.engaged.FullAcc = {ammo="C. Palug Stone",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Odr Earring",ear2="Mache Earring +1",
        body="Mummu Jacket +2",hands=gear.AdhemarHands.B,ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.jsecapes.amb.thf.tp,waist="Olseni Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.engaged.Fodder = {ammo="Yamarang",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Brutal Earring",ear2="Sherida Earring",
        body=gear.AdhemarJacket.Bplus,hands="Adhemar Wrist. +1",ring1="Gere Ring",ring2="Epona's Ring",
        back=gear.jsecapes.amb.thf.tp,waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.HerculeanBoots.TA}

   sets.engaged.DT = {ammo="Yamarang",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Sherida Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Moonbeam Ring",
        back=gear.jsecapes.amb.thf.tp,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}

    sets.engaged.SomeAcc.DT = {ammo="Staunch Tathlum",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Sherida Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Moonbeam Ring",
        back="Moonbeam Cape",waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}
		
    sets.engaged.Acc.DT = {ammo="Staunch Tathlum",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Odr Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Moonbeam Ring",
        back="Moonbeam Cape",waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}

    sets.engaged.FullAcc.DT = {ammo="Staunch Tathlum",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Odr Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Moonbeam Ring",
        back="Moonbeam Cape",waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}
		
    sets.engaged.Fodder.DT = {ammo="Staunch Tathlum",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Sherida Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Moonbeam Ring",
        back="Moonbeam Cape",waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}
		
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
	send_command('wait 5; input /lockstyleset 7')
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