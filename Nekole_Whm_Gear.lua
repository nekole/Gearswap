-- Setup vars that are user-dependent.  Can override this function in a sidecar file..
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant')
    state.IdleMode:options('Normal','PDT','TPEat')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','MeleeWeapons','DualWeapons')
	
	set_lockstyle()
	gear.obi_cure_waist = "Austerity Belt +1"
	gear.obi_cure_back = gear.jsecapes.amb.whm.ws

	gear.obi_nuke_waist = "Sekhmet Corset"
	gear.obi_high_nuke_waist = "Yamabuki-no-Obi"
	gear.obi_nuke_back = "Toro Cape"

		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

	-- Weapons sets
	sets.weapons.MeleeWeapons = {main="Tishtrya",sub="Ammurapi Shield"}
	sets.weapons.DualWeapons = {main="Tishtrya",sub="Izcalli"}
	
	sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
	
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
		main=gear.grioavolr_fc_staff, --7
		sub="Clerisy Strap +1", --3
		ammo="Impatiens", --2
		head="Nahtirah Hat",
		body=gear.ambuscade.inyanga.body, --13
		hands="Gende. Gages +1", --7
		legs="Kaykaus Tights", --6
		feet="Regal Pumps +1", --7
		neck="Cleric's Torque +1", --5
		ear1="Enchntr. Earring +1",
		ear2="Malignance Earring",
		ring1="Kishar Ring",
		ring2="Lebeche Ring",
		back=gear.jsecapes.amb.whm.fc, --10
		waist="Witful Belt", --3/(2)
		}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs=gear.jse.empyrean.whm.legs})

    sets.precast.FC.StatusRemoval = set_combine(sets.precast.FC['Healing Magic'], {main="Yagrush",sub="Genmei Shield"})
	
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {feet="Hygieia Clogs +1"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {})
	
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})

    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body=gear.jse.relic.whm.body}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Nahtirah Hat",
		ear1="Roundel Earring",
		body=gear.jse.relic.whm.body,
		hands=gear.TelchineGloves.Enh,
		waist="Chaac Belt",
		back="Aurist's Cape +1"}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Hasty Pinion +1",
		head="Befouled Crown",
		neck="Asperity Necklace",
		ear1="Moonshade Earring",
		ear2="Brutal Earring",
		body="Kaykaus Bliaut",
		hands=gear.TelchineGloves.Enh,
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Buquwik Cape",
		waist="Fotia Belt",
		legs="Assid. Pants +1",
		feet=gear.gendewitha.feet.pdt}
		
	   sets.precast.WS.Dagan = {ammo="Hasty Pinion +1",
		head="Befouled Crown",neck="Asperity Necklace",ear1="Etiolation Earring",ear2="Moonshade Earring",
		body="Kaykaus Bliaut",hands=gear.TelchineGloves.Enh,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Buquwik Cape",waist="Fotia Belt",legs="Assid. Pants +1",feet="Gende. Galosh. +1"}
		
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring"}
	sets.MaxTP.Dagan = {ear1="Etiolation Earring",ear2="Evans Earring"}

    --sets.precast.WS['Flash Nova'] = {}

    --sets.precast.WS['Mystic Boon'] = {}

    -- Midcast Sets

    sets.Kiting = {feet="Crier's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.DayIdle = {}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.NightIdle = {back="Umbra Cape"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}

	-- Conserve Mp set for spells that don't need anything else, for set_combine.
	
	sets.ConserveMP = {
		main=gear.grioavolr_fc_staff,
		sub="Umbra Strap",
		ammo="Hasty Pinion +1",
		head=gear.vanya.head.A,
		neck="Incanter's Torque",
		ear1="Gifted Earring",
		ear2="Gwati Earring",
		body="Vedic Coat",
		hands="Fanatic Gloves",
		ring1="Kishar Ring",
		ring2="Prolix Ring",
		back="Solemnity Cape",
		waist="Austerity Belt +1",
		legs=gear.vanya.legs.C,
		feet="Medium's Sabots"}
		
	sets.midcast.Teleport = sets.ConserveMP
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {main=gear.weapons.BLM.magicstaff,sub="Enki Strap",neck="Mizu. Kubikazari",ring1="Mujin Band",ring2="Locus Ring"}
	
    sets.midcast.FastRecast = {
		main=gear.grioavolr_fc_staff,
		sub="Clerisy Strap +1",
		ammo="Hasty Pinion +1",
		head="Nahtirah Hat",
		neck="Orunmila's Torque",
		ear1="Enchntr. Earring +1",
		ear2="Malignance Earring",
		body=gear.ambuscade.inyanga.body,
		hands=gear.gendewitha.hands.pdt,
		ring1="Kishar Ring",
		ring2="Prolix Ring",
		back="Swith Cape +1",
		waist="Witful Belt",
		legs="Lengo Pants",
		feet="Regal Pumps +1"}

    -- Cure sets

	sets.midcast['Full Cure'] = sets.midcast.FastRecast
	
	sets.midcast.Cure = {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Pemphredo Tathlum",
		head=gear.gendewitha.head.pdt,
		neck="Cleric's Torque +1",
		ear1="Regal Earring",
		ear2="Glorious Earring",
		body=gear.jse.artifact.whm.body,
		hands=gear.jse.artifact.whm.hands,
		ring1="Janniston Ring +1",
		ring2="Menelaus's Ring",
		back=gear.jsecapes.amb.whm.ws,
		waist="Luminary Sash",
		legs=gear.jse.empyrean.whm.legs,
		feet="Kaykaus Boots"}
		
	sets.midcast.CureSolace = {
		main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		head=gear.gendewitha.head.pdt,neck="Cleric's Torque +1",ear1="Regal Earring",ear2="Glorious Earring",
		body=gear.jse.artifact.whm.body,hands=gear.jse.artifact.whm.hands,ring1="Janniston Ring +1",ring2="Menelaus's Ring",
		back=gear.jsecapes.amb.whm.ws,waist="Luminary Sash",legs=gear.jse.empyrean.whm.legs,feet="Kaykaus Boots"}

	sets.midcast.LightWeatherCure = {main="Chatoyant Staff",sub="Curatio Grip",ammo="Esper Stone +1",
		head=gear.gendewitha.head.pdt,neck="Cleric's Torque +1",ear1="Nourish. Earring +1",ear2="Glorious Earring",
		body="Kaykaus Bliaut",hands=gear.jse.artifact.whm.hands,ring1="Janniston Ring +1",ring2="Lebeche Ring",
		back=gear.jsecapes.amb.whm.ws,waist="Hachirin-no-Obi",legs=gear.jse.empyrean.whm.legs,feet="Kaykaus Boots"}

	sets.midcast.LightWeatherCureSolace = {main="Chatoyant Staff",sub="Curatio Grip",ammo="Esper Stone +1",
		head=gear.gendewitha.head.pdt,neck="Cleric's Torque +1",ear1="Regal Earring",ear2="Glorious Earring",
		body=gear.jse.empyrean.whm.body,hands=gear.jse.artifact.whm.hands,ring1="Janniston Ring +1",ring2="Lebeche Ring",
		back=gear.jsecapes.amb.whm.ws,waist="Hachirin-no-Obi",legs=gear.jse.empyrean.whm.legs,feet="Kaykaus Boots"}
		
	sets.midcast.LightDayCureSolace = {main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		head=gear.gendewitha.head.pdt,neck="Cleric's Torque +1",ear1="Regal Earring",ear2="Glorious Earring",
		body=gear.jse.empyrean.whm.body,hands=gear.jse.artifact.whm.hands,ring1="Janniston Ring +1",ring2="Menelaus's Ring",
		back=gear.jsecapes.amb.whm.ws,waist="Hachirin-no-Obi",legs=gear.jse.empyrean.whm.legs,feet="Kaykaus Boots"}

	sets.midcast.LightDayCure = {main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		head=gear.gendewitha.head.pdt,neck="Cleric's Torque +1",ear1="Nourish. Earring +1",ear2="Glorious Earring",
		body="Kaykaus Bliaut",hands=gear.jse.artifact.whm.hands,ring1="Janniston Ring +1",ring2="Menelaus's Ring",
		back=gear.jsecapes.amb.whm.ws,waist="Hachirin-no-Obi",legs=gear.jse.empyrean.whm.legs,feet="Kaykaus Boots"}

	sets.midcast.Curaga = {main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		head=gear.gendewitha.head.pdt,neck="Cleric's Torque +1",ear1="Regal Earring",ear2="Glorious Earring",
		body="Kaykaus Bliaut",hands=gear.jse.artifact.whm.hands,ring1="Janniston Ring +1",ring2="Menelaus's Ring",
		back=gear.jsecapes.amb.whm.ws,waist="Luminary Sash",legs=gear.jse.empyrean.whm.legs,feet="Kaykaus Boots"}
		
	sets.midcast.LightWeatherCuraga = {main="Chatoyant Staff",sub="Curatio Grip",ammo="Pemphredo Tathlum",
		head=gear.gendewitha.head.pdt,neck="Cleric's Torque +1",ear1="Nourish. Earring +1",ear2="Glorious Earring",
		body="Kaykaus Bliaut",hands=gear.jse.artifact.whm.hands,ring1="Janniston Ring +1",ring2="Lebeche Ring",
		back=gear.jsecapes.amb.whm.ws,waist="Hachirin-no-Obi",legs=gear.jse.empyrean.whm.legs,feet="Kaykaus Boots"}
		
	sets.midcast.LightDayCuraga = {main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		head=gear.gendewitha.head.pdt,neck="Cleric's Torque +1",ear1="Glorious Earring",ear2="Nourish. Earring +1",
		body="Kaykaus Bliaut",hands=gear.jse.artifact.whm.hands,ring1="Janniston Ring +1",ring2="Menelaus's Ring",
		back=gear.jsecapes.amb.whm.ws,waist="Hachirin-no-Obi",legs=gear.jse.empyrean.whm.legs,feet="Kaykaus Boots"}

	sets.midcast.Cure.DT = {main="Queller Rod",sub="Genmei Shield",ammo="Staunch Tathlum",
		head=gear.gendewitha.head.pdt,neck="Loricate Torque +1",ear1="Nourish. Earring +1",ear2="Glorious Earring",
		body="Kaykaus Bliaut",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Menelaus's Ring",
		back=gear.jsecapes.amb.whm.ws,waist="Luminary Sash",legs=gear.jse.empyrean.whm.legs,feet="Gende. Galosh. +1"}
		
	--Melee Curesets are used whenever your OffenseMode is set to anything but None.
	sets.midcast.MeleeCure = {ammo="Pemphredo Tathlum",
		head=gear.gendewitha.head.pdt,neck="Cleric's Torque +1",ear1="Regal Earring",ear2="Glorious Earring",
		body=gear.jse.artifact.whm.body,hands="Kaykaus Cuffs",ring1="Janniston Ring +1",ring2="Lebeche Ring",
		back=gear.jsecapes.amb.whm.ws,waist="Luminary Sash",legs=gear.jse.empyrean.whm.legs,feet="Kaykaus Boots"}
		
	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {body=gear.jse.empyrean.whm.body})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {body=gear.jse.empyrean.whm.body,waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {body=gear.jse.empyrean.whm.body,waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {body=gear.jse.empyrean.whm.body})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body=gear.jse.empyrean.whm.body,waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body=gear.jse.empyrean.whm.body,waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body=gear.jse.empyrean.whm.body})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body=gear.jse.empyrean.whm.body,waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body=gear.jse.empyrean.whm.body,waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})

	sets.midcast.Cursna = {main=gear.grioavolr_fc_staff,sub="Clemency Grip",ammo="Hasty Pinion +1",
		head=gear.jse.empyrean.whm.head,neck="Debilis Medallion",ear1="Meili Earring",ear2="Malignance Earring",
		body=gear.jse.empyrean.whm.body,hands="Fanatic Gloves",ring1="Haoma's Ring",ring2="Menelaus's Ring",
		back=gear.jsecapes.amb.whm.ws,waist="Witful Belt",legs=gear.jse.artifact.whm.legs,feet=gear.vanya.feet.B}

	sets.midcast.StatusRemoval = {main="Yagrush",sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head=gear.jse.empyrean.whm.head,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body=gear.ambuscade.inyanga.body,hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs=gear.jse.empyrean.whm.legs,feet="Regal Pumps +1"}
		
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque +1"})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = {main=gear.weapons.whm.enh,sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head=gear.TelchineCap.ES,neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body=gear.TelchineChasuble.Enh,hands=gear.TelchineGloves.Enh,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Mending Cape",waist="Embla Sash",legs=gear.TelchineBraconi.ES,feet=gear.jse.artifact.whm.feet}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash"})

	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet=gear.jse.relic.whm.feet})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {hands="Regal Cuffs",waist="Emphatikos Rope"})

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {body=gear.jse.artifact.whm.body,hands=gear.jse.empyrean.whm.hands,legs=gear.jse.artifact.whm.legs})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet=gear.jse.relic.whm.feet,ear1="Gifted Earring"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet=gear.jse.relic.whm.feet,ear1="Gifted Earring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",legs=gear.jse.relic.whm.legs,ear1="Gifted Earring"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",legs=gear.jse.relic.whm.legs,ear1="Gifted Earring"})
	
	sets.midcast.BarElement = {main="Beneficus",sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head=gear.jse.empyrean.whm.head,neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body=gear.jse.empyrean.whm.body,hands=gear.jse.empyrean.whm.hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back=gear.jsecapes.amb.whm.ws,waist="Olympus Sash",legs=gear.jse.relic.whm.legs,feet=gear.jse.relic.whm.feet}

	sets.midcast.Impact = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=gear.jse.empyrean.whm.head,neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body=gear.jse.empyrean.whm.body,ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back="Toro Cape",waist="Acuity Belt +1",gear.ChironicHose.MAB}
		
	sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
		neck="Baetyl Pendant",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Witching Robe",ring1="Metamor. Ring +1",ring2="Freke Ring",
		back="Toro Cape",waist=gear.ElementalObi,gear.ChironicHose.MAB}

	sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
		neck="Sanctity Necklace",ear1="Regal Earring",ear2="Friomisi Earring",
		ring1="Metamor. Ring +1",ring2="Freke Ring",back="Toro Cape"}

	sets.midcast['Divine Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Incanter's Torque",ear1="Regal Earring",ear2="Digni. Earring",
		body=gear.ambuscade.inyanga.body,hands="Fanatic Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Gyve Trousers",feet=gear.ChironicHose.MAB}
		
	sets.midcast.Holy = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Friomisi Earring",
		body="Witching Robe",hands="Fanatic Gloves",ring1="Metamor. Ring +1",ring2="Freke Ring",
		back="Toro Cape",waist=gear.ElementalObi,legs="Gyve Trousers",feet=gear.ChironicHose.MAB}

	sets.midcast['Dark Magic'] = {main="Daybreak", sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body=gear.ambuscade.inyanga.body,hands="Fanatic Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Gyve Trousers",feet=gear.ChironicHose.MAB}

    sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
        body=gear.ambuscade.inyanga.body,hands="Fanatic Gloves",ring1="Evanescence Ring",ring2="Archon Ring",
        back="Aurist's Cape +1",waist="Fucho-no-obi",legs="Gyve Trousers",feet=gear.ChironicHose.MAB}

    sets.midcast.Drain.Resistant = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
        body=gear.ambuscade.inyanga.body,hands="Fanatic Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Aurist's Cape +1",waist="Fucho-no-obi",legs="Gyve Trousers",feet=gear.ChironicHose.MAB}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Nahtirah Hat",neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body=gear.ambuscade.inyanga.body,hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}

	sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Nahtirah Hat",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body=gear.ambuscade.inyanga.body,hands="Fanatic Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Acuity Belt +1",legs=gear.ChironicHose.MAB,feet=gear.ChironicHose.MAB}
		
	sets.midcast.Dispel = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Nahtirah Hat",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Acuity Belt +1",legs=gear.ChironicHose.MAB,feet=gear.ChironicHose.MAB}
		
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {main="Daybreak",sub="Ammurapi Shield"})

	sets.midcast['Enfeebling Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body=gear.jse.artifact.whm.body,hands="Regal Cuffs",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Luminary Sash",legs=gear.ChironicHose.MAB,feet="Uk'uxkaj Boots"}

	sets.midcast['Enfeebling Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body=gear.jse.artifact.whm.body,hands="Regal Cuffs",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Luminary Sash",legs=gear.ChironicHose.MAB,feet=gear.jse.artifact.whm.feet}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {back=gear.jsecapes.amb.whm.ws})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {back=gear.jsecapes.amb.whm.ws,ring1="Stikini Ring +1"})

    -- Sets to return to when not performing an action.

    -- Resting sets
	sets.resting = {main="Chatoyant Staff",sub="Oneiros Grip",ammo="Homiliary",
		head="Befouled Crown",neck="Chrys. Torque",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body=gear.jse.empyrean.whm.body,hands=gear.ambuscade.inyanga.hands,ring1="Defending Ring",ring2="Sheltered Ring",
		back="Umbra Cape",waist="Fucho-no-obi",legs="Assid. Pants +1",feet=gear.ambuscade.inyanga.feet}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Befouled Crown",
		body="Shamash Robe",
		hands=gear.gendewitha.hands.pdt,
		legs="Assid. Pants +1",
		feet=gear.ambuscade.inyanga.feet,
		neck="Cleric's Torque +1",
		ear1="Etiolation Earring",
		ear2="Infused Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Solemnity Cape",
		waist="Austerity Belt +1",}

	sets.idle.PDT = {main="Terra's Staff", sub="Oneiros Grip",ammo="Staunch Tathlum",
		head=gear.gendewitha.head.pdt,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Shamash Robe",hands="Gende. Gages +1",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Umbra Cape",waist="Flax Sash",legs="Gende. Spats +1",feet=gear.ambuscade.inyanga.feet}
	
	sets.idle.MDT = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum",
		head="Gende. Caubeen +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Shamash Robe",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Stikini Ring +1",
		back="Moonbeam Cape",waist="Flax Sash",legs="Assid. Pants +1",feet=gear.ambuscade.inyanga.feet}

	sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Witching Robe",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Stikini Ring +1",
		back="Umbra Cape",waist="Witful Belt",legs="Assid. Pants +1",feet=gear.ambuscade.inyanga.feet}

    -- Defense sets

	sets.defense.PDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum",
		head=gear.gendewitha.head.pdt,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Shamash Robe",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Stikini Ring +1",
		back="Umbra Cape",waist="Flax Sash",legs="Gende. Spats +1",feet="Gende. Galosh. +1"}

	sets.defense.MDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum",
		head=gear.gendewitha.head.pdt,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Shamash Robe",hands=gear.chironic_refresh_hands,ring1="Defending Ring",ring2="Stikini Ring +1",
		back="Umbra Cape",waist="Flax Sash",legs="Gende. Spats +1",feet="Gende. Galosh. +1"}

    sets.defense.MEVA = {ammo="Staunch Tathlum",
        head=gear.gendewitha.head.pdt,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Shamash Robe",ring1="Vengeful Ring",ring2="Stikini Ring +1",
        back="Aurist's Cape +1",waist="Luminary Sash"}

		-- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {ammo="Staunch Tathlum",
        head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Aurist's Cape +1",waist="Windbuffet Belt +1",legs="Aya. Cosciales +2",feet="Battlecast Gaiters"}

    sets.engaged.Acc = {ammo="Hasty Pinion +1",
        head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Telos Earring",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Aurist's Cape +1",waist="Olseni Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}

	sets.engaged.DW = {ammo="Staunch Tathlum",
        head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Telos Earring",ear2="Suppanomimi",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Aurist's Cape +1",waist="Shetal Stone",legs="Aya. Cosciales +2",feet="Battlecast Gaiters"}

    sets.engaged.DW.Acc = {ammo="Hasty Pinion +1",
        head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Telos Earring",ear2="Suppanomimi",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Aurist's Cape +1",waist="Shetal Stone",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}

		-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",back="Mending Cape"}

	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Zendik Robe",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",waist="Flax Sash",feet=""}

	sets.HPCure = {main="Queller Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Blistering Sallet +1",neck="Nodens Gorget",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Kunaji Ring",
		back=gear.jsecapes.amb.whm.ws,waist="Eschan Stone",legs="Ebers Pant. +1",feet="Kaykaus Boots"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 5)
end
function set_lockstyle()
	send_command('wait 2; input /lockstyleset 15')
end