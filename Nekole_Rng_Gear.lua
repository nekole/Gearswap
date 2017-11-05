-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.IdleMode:options('Normal', 'PDT')
	
	DefaultAmmo = {['Annihilator'] = "Eradicating bullet"}
	U_Shot_Ammo = {['Annihilator'] = "Eradicating bullet"}
	
	    -- Additional local binds
    send_command('bind !` input /ra <t>')
	send_command('bind !backspace input /ja "Bounty Shot" <t>')
	send_command('bind @f7 gs c toggle AutoShootMode')
	send_command('bind @` gs c cycle SkillchainMode')
	
	select_default_macro_book()

end

-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {hands=gear.jse.empyrean.rng.hands})
	sets.precast.JA['Camouflage'] = {body=gear.jse.artifact.rng.body}
	sets.precast.JA['Scavenge'] = {feet=gear.jse.artifact.rng.feet}
	sets.precast.JA['Shadowbind'] = {hands=gear.jse.artifact.rng.hands}
	sets.precast.JA['Sharpshot'] = {legs=gear.jse.artifact.rng.legs}


	-- Fast cast sets for spells

	sets.precast.FC = {
		head=gear.herculean_fc_head,
		neck="Orunmila's Torque",
		ear1="Enchntr. Earring +1",
		ear2="Loquacious Earring",
		body="Dread Jupon",
		hands="Leyline Gloves",
		ring1="Lebeche Ring", 
		ring2="Prolix Ring",
		legs="Blood Cuisses"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		head=gear.jse.empyrean.rng.head,
		body=gear.jse.relic.rng.body,
		back=gear.jsecapes.rng,
		waist="Impulse Belt",
		legs=gear.AdhemarKecks.C,
		feet="Amini Bottillons"}


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		neck="Fotia Gorget",
		head="Meghanada Visor +1",
		body="Abnoba Kaftan",
		hands="Meghanada Gloves +1",
		left_ear=gear.ears.melee_acc_right,
		right_ear="Ishvara Earring",
		left_ring=gear.ring.agi1,
		right_ring=gear.ring.agi2,
		legs="Meg. Chausses +1",
		waist="Fotia Belt",
		back=gear.jsecapes.amb.rng.ws,
		feet="Meg. Jam. +1"}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ring2="Hajduk Ring +1",hands="Floral Gauntlets",legs="Orion Braccae +1"})
		
	sets.precast.WS["Jishnu's Radiance"] = {
		head="Adhemar Bonnet",
		neck="Fotia Gorget",
		ear1="Jupiter's Pearl",
		ear2="Moonshade Earring",
		body="Amini Caban +1",
		hands="Amini Glovelettes",
		ring1="Apate Ring",
		ring2="Rajas Ring",
		back="Rancorous Mantle",
		waist="Fotia Belt",
		legs="Amini Brague",
		feet="Orion Socks +1" }
		
	sets.precast.WS["Jishnu's Radiance"].Acc = set_combine(sets.precast.WS["Jishnu's Radiance"], {head="Mummu Bonnet +1",ear1="Enervating Earring",hands="Floral Gauntlets",ring2="Hajduk Ring +1",legs="Orion Braccae +1"})
	
	sets.precast.WS["Empyreal Arrow"] = {
		head="Mummu Bonnet +1",neck="Fotia Gorget",ear1="Enervating Earring",ear2="Moonshade Earring",
		body="Amini Caban +1",hands="Amini Glovelettes",ring1="Apate Ring",ring2="Rajas Ring",
		back="Lutian Cape",waist="Fotia Belt",legs="Amini Brague",feet="Orion Socks +1" }
		
	sets.precast.WS["Empyreal Arrow"].Acc = set_combine(sets.precast.WS["Empyreal Arrow"], {hands="Floral Gauntlets",ring2="Hajduk Ring +1", legs="Orion Braccae +1"})
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Enervating Earring",ear2="Neritic Earring"}
	sets.precast.AccMaxTP = {ear1="Enervating Earring",ear2="Neritic Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	sets.midcast.FastRecast = {
		head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear1="Loquacious Earring",
		body="Amini Caban +1",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
		waist="Hurch'lan Sash",legs="Orion Braccae +1",feet="Orion Socks +1"}
		
	-- Ranged sets

	sets.midcast.RA = {
		head=gear.jse.relic.rng.head,
		neck="Erudition Necklace",
		hands=gear.carmine.hands.D,
		--body= Caban +1,
		body="Mummu Jacket +1",
		left_ring="Rajas Ring",
		right_ring="Apate Ring",
		ear1="Dedition Earring",
		ear2="Cessance Earring",
		legs=gear.AdhemarKecks.C,
		feet=gear.AdhemarGamashes.D,
		waist="Yemaya Belt",  -- need
		back=gear.jsecapes.amb.rng.tp}
	
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA,
		{head="Mummu Bonnet +1",neck="Combatant's Torque",hands="Floral Gauntlets",waist="Flax Sash",legs="Orion Braccae +1"})
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {ring1="Defending Ring",ring2="Sheltered Ring"}

	-- Idle sets
	sets.idle = {
		main="Kustawi +1",
		sub="Kustawi",
		range="Annihilator",
		ammo="Eradicating Bullet",
		head=gear.AdhemarBonnet.B,--5PDT
		neck="Loricate Torque +1",--6
		body="Kyujutsugi",
		hands=gear.carmine.hands.D,
		ring1="Defending Ring",
		ring2="Paguroidea Ring",
		ear1="Dedition Earring",
		ear2="Infused Earring",
		legs=gear.carmine.legs.D,
		waist="Flume Belt +1",--4PDT
		back="Solemnity Cape",
		feet="Skd. Jambeaux +1"}
		
	sets.idle.PDT = {
		head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Orion Jerkin +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
		back="Moonbeam Cape",waist="Flume Belt +1",legs=gear.herculean_dt_legs,feet="Orion Socks +1"}
	
	-- Defense sets
	sets.defense.PDT = {
		head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Orion Jerkin +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
		back="Moonbeam Cape",waist="Flume Belt +1",legs=gear.herculean_dt_legs,feet="Orion Socks +1"}

	sets.defense.MDT = {
		head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Orion Jerkin +1",hands="Floral Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonbeam Cape",waist="Flax Sash",legs=gear.herculean_dt_legs,feet="Orion Socks +1"}
		
	sets.defense.MEVA = {ammo="Staunch Tathlum",
		head=empty,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Respite Cloak",hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Shadow Ring",
		back="Toro Cape",waist="Luminary Sash",legs="Meg. Chausses +1",feet=gear.herculean_acc_feet}

	sets.Kiting = {back="Solemnity Cape",feet="Skd. Jambeaux +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Weapons = {main="Kustawi +1",sub="Kustawi",range="Annihilator",ammo="Eradicating bullet"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = {
--		head="Dampening Tam",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
--		body="Adhemar Jacket", hands="Floral Gauntlets", ring1="Epona's Ring",ring2="Rajas Ring",
--		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Meg. Chausses +1",feet=gear.herculean_acc_feet
		head=gear.AdhemarBonnet.B,
        neck="Asperity Necklace",
        ear1=gear.ears.melee_dex,
        ear2="Suppanomimi",
        body=gear.AdhemarJacket.B,
        hands=gear.AdhemarHands.B,
--		hands=gear.HerculeanGloves.TA,
        ring1="Hetairoi Ring",
		ring2="Epona's Ring",
        back="Bleating Mantle",
        waist=gear.waist.nohaste,
        legs=gear.SamnuhaTights.TP,
        feet=gear.HerculeanBoots.TA}

	sets.engaged.Acc = {
		head="Dampening Tam",
		neck="Combatant's Torque",
		ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mekosu. Harness", 
		hands="Floral Gauntlets", 
		ring1="Epona's Ring",
		ring2="Rajas Ring",
		back="Ground. Mantle +1",
		waist="Olseni Belt",
		legs="Meg. Chausses +1",
		feet=gear.HerculeanBoots.TA}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = set_combine(sets.midcast.RA.Acc, {hands="Orion Bracers +1"})
	sets.buff.Camouflage = {body="Orion Jerkin +1"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 8)
end
