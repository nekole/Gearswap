-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal','Acc')
	state.RangedMode:options('Normal','Acc')
	state.WeaponskillMode:options('Match','Normal', 'Acc')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('Default','DualWeapons','DualMagicWeapons')
	
	set_lockstyle()	
	DefaultAmmo = {['Fomalhaut']="Chrono Bullet"}
	U_Shot_Ammo = {['Fomalhaut']="Animkii Bullet"}
	
	    -- Additional local binds
    send_command('bind !` input /ra <t>')
	send_command('bind !backspace input /ja "Bounty Shot" <t>')
	send_command('bind @f7 gs c toggle RngHelper')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind ^q gs c weapons SingleWeapon;gs c update')
	
	select_default_macro_book()

end

-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	
	
	-- Precast sets to enhance JAs
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {hands=gear.jse.empyrean.rng.hands})
	sets.precast.JA['Camouflage'] = {body=gear.jse.artifact.rng.body}
	sets.precast.JA['Scavenge'] = {feet=gear.jse.artifact.rng.feet}
	sets.precast.JA['Shadowbind'] = {hands=gear.jse.artifact.rng.hands}
	sets.precast.JA['Sharpshot'] = {legs=gear.jse.artifact.rng.legs}
	sets.precast.JA['Double Shot'] = {back=gear.jsecapes.amb.rng.tp}


	-- Fast cast sets for spells

	sets.precast.FC = {
		head=gear.CarmineMask.D,
		neck="Orunmila's Torque",
		ear1="Enchntr. Earring +1",
		ear2="Loquacious Earring",
		body="Dread Jupon",
		hands="Leyline Gloves",
		ring1="Lebeche Ring", 
		ring2="Prolix Ring",
		legs=gear.RawhideTrousers.D,
		feet=gear.carmine.feet.D}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
--		neck="Magoraga Beads",
--		body="Passion Jacket"
		})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		head=gear.jse.empyrean.rng.head,
		body=gear.jse.relic.rng.body,
		back=gear.jsecapes.rng,
		hands=gear.carmine.hands.D,
		waist="Impulse Belt",
		legs=gear.AdhemarKecks.C,
		feet=gear.ambuscade.meghanada.feet}
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {waist="Yemaya Belt"})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		neck="Fotia Gorget",
		head=gear.ambuscade.meghanada.head,
		body="Abnoba Kaftan",
		hands=gear.ambuscade.meghanada.hands,
		ear1="Moonshade Earring",
		ear2="Telos Earring",
		ring1="Regal Ring",
		ring2="Dingir Ring",
		legs=gear.ambuscade.meghanada.legs,
		waist="Fotia Belt",
		back=gear.jsecapes.amb.rng.ws,
		feet=gear.ambuscade.meghanada.feet}
		
	sets.precast.WS.Acc = {
        head="Meghanada Visor +2",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Telos Earring",
        body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.wsd_ranger_jse_back,waist="Fotia Belt",legs="Meg. Chausses +2",feet="Meg. Jam. +2"}

    sets.precast.WS['Wildfire'] = {ammo="Orichalc. Bullet",
        head="Meghanada Visor +2",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Samnuha Coat",hands="Carmine Fin. Ga. +1",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.wsd_ranger_jse_back,waist="Eschan Stone",legs="Gyve Trousers",feet="Meg. Jam. +2"}

    sets.precast.WS['Wildfire'].Acc = {ammo="Orichalc. Bullet",
        head="Meghanada Visor +2",neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.wsd_ranger_jse_back,waist="Eschan Stone",legs="Gyve Trousers",feet="Meg. Jam. +2"}
		
    sets.precast.WS['Trueflight'] = {ammo="Orichalc. Bullet",
        head="Meghanada Visor +2",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Samnuha Coat",hands="Carmine Fin. Ga. +1",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.wsd_ranger_jse_back,waist="Eschan Stone",legs="Gyve Trousers",feet="Meg. Jam. +2"}

    sets.precast.WS['Trueflight'].Acc = {ammo="Orichalc. Bullet",
        head="Meghanada Visor +2",neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.wsd_ranger_jse_back,waist="Eschan Stone",legs="Gyve Trousers",feet="Meg. Jam. +2"}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Enervating Earring",ear2="Neritic Earring"}
	sets.precast.AccMaxTP = {ear1="Enervating Earring",ear2="Neritic Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	sets.midcast.FastRecast = {
		head=gear.CarmineMask.D,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear1="Loquacious Earring",
		body="Dread Jupon",hands=gear.Leyline.FC,ring1="Kishar Ring",ring2="Lebeche Ring",
		waist="Flume Belt +1",legs="Orion Braccae +1",feet="Orion Socks +1"}
		
	-- Ranged sets

	sets.midcast.RA = {
		head=gear.jse.relic.rng.head,
		neck="Iskur Gorget",
		hands=gear.carmine.hands.D,
		body=gear.ambuscade.mummu.body,
		ring1="Regal Ring",
		ring2="Dingir Ring",
		ear1="Enervating Earring",
		ear2="Telos Earring",
		legs=gear.AdhemarKecks.C,
		feet="Malignance Boots",
		waist="Yemaya Belt", 
		back=gear.jsecapes.amb.rng.tp}
	
	sets.midcast.RA.Acc = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.tp_ranger_jse_back,waist="Yemaya Belt",legs="Meg. Chausses +2",feet="Malignance Boots"}

	--These sets will overlay based on accuracy level, regardless of other options.
	sets.buff.Camouflage = {body=gear.jse.artifact.rng.body}
	sets.buff.Camouflage.Acc = {}		
	sets.buff['Double Shot'] = {back=gear.tp_ranger_jse_back}
	sets.buff['Double Shot'].Acc = {}
	sets.buff.Barrage = {hands=gear.jse.artifact.rng.hands}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {ring1="Defending Ring",ring2="Sheltered Ring"}

	-- Idle sets
	sets.idle = {
		head=gear.AdhemarBonnet.B,--5PDT
		neck="Loricate Torque +1",--6
		body="Kyujutsugi",
		hands=gear.carmine.hands.D,
		ring1="Defending Ring",
		ring2="Paguroidea Ring",
		ear1="Genmei Earring",
		ear2="Sanare Earring",
		legs=gear.carmine.legs.D,
		waist="Flume Belt +1",--4PDT
		back="Moonbeam Cape",
		feet="Malignance Boots"}
		
	sets.idle.PDT = {
		head=gear.AdhemarBonnet.B,--5PDT
		neck="Loricate Torque +1",--6
		body="Kyujutsugi",
		hands=gear.carmine.hands.D,
		ring1="Defending Ring",
		ring2="Paguroidea Ring",
		ear1="Genmei Earring",
		ear2="Sanare Earring",
		legs=gear.carmine.legs.D,
		waist="Flume Belt +1",--4PDT
		back="Moonbeam Cape",
		feet="Malignance Boots"}
	
	-- Defense sets
	sets.defense.PDT = {
		head=gear.AdhemarBonnet.B,--5PDT
		neck="Loricate Torque +1",--6
		body="Kyujutsugi",
		hands=gear.carmine.hands.D,
		ring1="Defending Ring",
		ring2="Paguroidea Ring",
		ear1="Genmei Earring",
		ear2="Sanare Earring",
		legs=gear.carmine.legs.D,
		waist="Flume Belt +1",--4PDT
		back="Moonbeam Cape",
		feet="Malignance Boots"}

	sets.defense.MDT = {
		head=gear.AdhemarBonnet.B,--5PDT
		neck="Loricate Torque +1",--6
		body="Kyujutsugi",
		hands=gear.carmine.hands.D,
		ring1="Defending Ring",
		ring2="Paguroidea Ring",
		ear1="Genmei Earring",
		ear2="Sanare Earring",
		legs=gear.carmine.legs.D,
		waist="Flume Belt +1",--4PDT
		back="Moonbeam Cape",
		feet="Malignance Boots"}
		
	sets.defense.MEVA = {ammo="Staunch Tathlum",
		head=gear.AdhemarBonnet.B,--5PDT
		neck="Loricate Torque +1",--6
		body="Kyujutsugi",
		hands=gear.carmine.hands.D,
		ring1="Defending Ring",
		ring2="Paguroidea Ring",
		ear1="Genmei Earring",
		ear2="Sanare Earring",
		legs=gear.carmine.legs.D,
		waist="Flume Belt +1",--4PDT
		back="Moonbeam Cape",
		feet="Malignance Boots"}

	sets.Kiting = {legs=gear.carmine.legs.D}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
		-- Weapons sets
	sets.weapons.DualWeapons = {main="Kustawi +1",sub="Kustawi",range="Fomalhaut"}
	sets.weapons.Default = {main="Kustawi +1",sub="Nusku Shield",range="Fomalhaut"}
	sets.weapons.DualMagicWeapons = {main="Malevolence",sub="Malevolence",range="Fomalhaut"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = {
		head=gear.AdhemarBonnet.B,
        neck="Iskur Gorget",
        ear1="Cessance Earring",
        ear2="Suppanomimi",
        body="Meg. Cuirie +2",
        hands=gear.AdhemarHands.B,
        ring1="Hetairoi Ring",
		ring2="Epona's Ring",
        back=gear.jsecapes.amb.rng.tp,
        waist="Windbuffet Belt +1",
        legs=gear.SamnuhaTights.TP,
        feet="Malignance Boots"}

	sets.engaged.Acc = {
		head="Dampening Tam",
		neck="Combatant's Torque",
		ear1="Cessance Earring",
		ear2="Telos Earring",
		body="Mekosu. Harness", 
		hands=gear.AdhemarHands.B, 
		ring1="Epona's Ring",
		ring2="Petrov Ring",
		back=gear.jsecapes.amb.rng.tp,
		waist="Olseni Belt",
		legs="Samnuha Tights",
		feet=gear.HerculeanBoots.TA}
		
	sets.engaged.DW = {
		head="Dampening Tam",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body=gear.AdhemarJacket.Bplus,hands="Floral Gauntlets",ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.jsecapes.amb.rng.tp,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.HerculeanBoots.TA}
    
    sets.engaged.DW.Acc = {
		head="Dampening Tam",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
		body=gear.AdhemarJacket.Bplus,hands="Floral Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back=gear.jsecapes.amb.rng.tp,waist="Olseni Belt",legs="Meg. Chausses +2",feet="Malignance Boots"}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 8)
end
function set_lockstyle()
	send_command('wait 2; input /lockstyleset 19')
end
