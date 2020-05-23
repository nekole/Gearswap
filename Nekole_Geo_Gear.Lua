function user_setup()

	-- Options: Override default values
    state.OffenseMode:options('Normal')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'TPEat')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','Nehushtan','DualWeapons')
	
	set_lockstyle()

	gear.nuke_jse_back = {name="Nantosuelta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10'}}
	gear.idle_jse_back = {name="Nantosuelta's Cape",augments={'MP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10'}}
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = gear.nuke_jse_back
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	gear.obi_high_nuke_back = gear.nuke_jse_back
	gear.obi_high_nuke_waist = "Refoccilation Stone"
	
	autoindi = "Haste"
	autogeo = "Frailty"

	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` input /ja "Full Circle" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^backspace input /ja "Entrust" <me>')
	send_command('bind !backspace input /ja "Life Cycle" <me>')
	send_command('bind @backspace input /ma "Sleep II" <t>')
	send_command('bind ^delete input /ma "Aspir III" <t>')
	send_command('bind @delete input /ma "Sleep" <t>')
	
	indi_duration = 290
	
	select_default_macro_book()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body=gear.jse.relic.geo.body}
	sets.precast.JA['Life Cycle'] = {body=gear.jse.artifact.geo.body,back=gear.idle_jse_back}
	sets.precast.JA['Radial Arcana'] = {feet=gear.jse.relic.geo.feet}
	sets.precast.JA['Mending Halation'] = {legs=gear.jse.relic.geo.legs}
	sets.precast.JA['Full Circle'] = {head=gear.jse.empyrean.geo.head,hands=gear.jse.relic.geo.hands}
	
	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {}
	
		-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {}
	
	-- Fast cast sets for spells

	sets.precast.FC = {
		main="Oranyan", --7
		sub="Clerisy Strap +1", --3
		range="Dunna", --3
		head=gear.AmalricCoif.C, --10
		body=gear.body.mage_fc, --8
		hands=gear.hands.mage_fc, --6
		legs=gear.jse.artifact.geo.legs, --11
		feet="Regal Pumps +1", --7
		neck="Orunmila's Torque", --5
		ear1=gear.ears.fc_left,
        ear2=gear.ears.fc_right,
		ring1=gear.ring.fc_left,
		ring2=gear.ring.fc_right,
		back="Perimede Cape", --7
		waist=gear.waist.fc}

	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {range="Dunna",ammo=empty})
	
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear2="Barkaro. Earring",waist="Channeler's Stone",hands=gear.jse.relic.geo.hands})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		main="Serenity",
		sub="Clerisy Strap +1",
		legs="Doyen Pants", --15
		ear1="Mendi. Earring", --5
		ring1="Lebeche Ring", --(2)
		back="Perimede Cape" --(4)
		})
		
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC.Impact = {
		head=empty,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Twilight Cloak",hands="Helios Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Lifestream Cape",waist="Witful Belt",legs=gear.jse.artifact.geo.legs,feet="Regal Pumps +1"}
		
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {
		main="Oranyan",
		sub="Clerisy Strap +1",
		sub="Genmei Shield",
		head=gear.AmalricCoif.C,
		neck="Orunmila's Torque",
		ear1="Enchntr. Earring +1",
		ear2="Etiolation Earring",
		body="Zendik Robe",
		hands="Helios Gloves",
		ring1="Kishar Ring",
		ring2="Prolix Ring",
		back="Lifestream Cape",
		waist="Witful Belt",
		legs=gear.jse.artifact.geo.legs,
		feet="Regal Pumps +1"}

	sets.midcast.Geomancy = {
		main="Idris",
		sub="Ammurapi Shield",
		range="Dunna",
		head=gear.jse.empyrean.geo.head,
		body="Azimuth Coat +1",
		hands="Azimuth Gloves +1",
		legs="Azimuth Tights +1",
		feet="Azimuth Gaiters +1",
		neck="Incanter's Torque",
		ear1="Gifted Earring",
		ear2="Calamitous Earring",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back="Lifestream Cape",
		waist="Austerity Belt +1"}


	--Extra Indi duration on any slot you can't get skill on here.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {back=gear.idle_jse_back,legs="Bagua Pants +1",feet="Azimuth Gaiters +1"})
		
    sets.midcast.Cure = {
		main="Tamaxchi", --22/(-10)
		sub="Sors Shield", --3/(-5)
		hands=gear.TelchineGloves.Enh, --10
		legs="Gyve Trousers", --10
		feet="Medium's Sabots", --12
		neck="Incanter's Torque",
		ear1="Mendi. Earring", --5
		ear2="Loquacious Earring",
		ring1="Lebeche Ring", --3/(-5)
		ring2="Haoma's Ring",
		back="Oretan. Cape +1", --6
		waist="Bishop's Sash"}
		
    sets.midcast.LightWeatherCure = {main="Chatoyant Staff",sub="Curatio Grip",
        head="Nahtirah Hat",neck="Phalaina Locket",ear1="Gifted Earring",ear2="Etiolation Earring",
        body="Heka's Kalasiris",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Lebeche Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs=gear.jse.artifact.geo.legs,feet="Vanya Clogs"}
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {main="Serenity",sub="Curatio Grip",
        head="Nahtirah Hat",neck="Phalaina Locket",ear1="Gifted Earring",ear2="Etiolation Earring",
        body="Vanir Cotehardie",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Lebeche Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs=gear.jse.artifact.geo.legs,feet="Vanya Clogs"}

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {main="Daybreak",sub="Sors Shield"})

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",ring1="Haoma's Ring",ring2="Haoma's Ring"})
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Oranyan",sub="Clemency Grip"})
	
    sets.midcast['Elemental Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Dosis Tathlum",
		head= gear.MerlinicHood.MAB,
		body="Shamash Robe",
		hands=gear.AmalricGages.A,
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MACC,
		neck="Mizu. Kubikazari",
		ear1="Barkaro. Earring",
		ear2="Friomisi Earring",
		ring1=gear.ring.int2,
		ring2=gear.ring.int1,
		back=gear.jsecapes.amb.geo.magic,
		waist="Refoccilation Stone"}

    sets.midcast['Elemental Magic'].Resistant = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head= gear.MerlinicHood.MAB,
		body="Shamash Robe",
		hands=gear.AmalricGages.A,
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MACC,
		neck="Sanctity Necklace",
		ear1="Barkaro. Earring",
		ear2="Friomisi Earring",
		ring1=gear.ring.int2,
		ring2=gear.ring.int1,
		back=gear.jsecapes.amb.geo.magic,
		waist="Eschan Stone"}
		
	sets.midcast['Elemental Magic'].Proc = {main=empty,sub=empty,ammo="Impatiens",
        head="Nahtirah Hat",neck="Loricate Torque +1",ear1="Gifted Earring",ear2="Loquacious Earring",
        body="Seidr Cotehardie",hands="Hagondes Cuffs +1",ring1="Kishar Ring",ring2="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Assid. Pants +1",feet="Regal Pumps +1"}
		
    sets.midcast['Elemental Magic'].Fodder = {
--		main=gear.grioavolr_nuke_staff,sub="Zuuxowu Grip",ammo="Dosis Tathlum",
--        head=gear.merlinic_nuke_head,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
--        body="Merlinic Jubbah",hands="Mallquis Cuffs +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
--        back=gear.nuke_jse_back,waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet
}

	sets.midcast['Elemental Magic'].HighTierNuke = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		ear1="Friomisi Earring",
		ear2="Barkaro. Earring",
		body="Shamash Robe",
		ring1="Metamor. Ring +1",
		ring2="Freke Ring",
		back=gear.jsecapes.amb.geo.magic,
		hands="Amalric Gages"}
	
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head=gear.merlinic_nuke_head,neck="Baetyl Pendant",ear1="Regal Earring",ear2="Malignance Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Metamor. Ring +1",ring2="Freke Ring",
        back=gear.nuke_jse_back,waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head=gear.merlinic_nuke_head,neck="Saevus Pendant +1",ear1="Regal Earring",ear2="Malignance Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Metamor. Ring +1",ring2="Freke Ring",
        back=gear.nuke_jse_back,waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",
        head=gear.merlinic_nuke_head,neck="Erra Pendant",ear1="Regal Earring",ear2="Barkaro. Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
        back=gear.nuke_jse_back,waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}
		
    sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Barkaro. Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Archon Ring",ring2="Evanescence Ring",
        back=gear.nuke_jse_back,waist="Fucho-no-obi",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}
    
    sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Amalric Coif",neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Zendik Robe",hands="Helios Gloves",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back="Lifestream Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
	sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Amalric Coif",neck="Erra Pendant",ear1="Regal Earring",ear2="Barkaro. Earring",
		body="Zendik Robe",hands="Amalric Gages",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}
		
	sets.midcast.Impact = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=empty,neck="Erra Pendant",ear1="Regal Earring",ear2="Barkaro. Earring",
		body="Twilight Cloak",hands="Lurid Mitts",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
	sets.midcast.Dispel = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Amalric Coif",neck="Erra Pendant",ear1="Regal Earring",ear2="Barkaro. Earring",
		body="Zendik Robe",hands="Amalric Gages",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}
		
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {main="Daybreak",sub="Ammurapi Shield"})

		
	sets.midcast['Enfeebling Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Merlinic Jubbah",hands="Lurid Mitts",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Luminary Sash",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"}
		
	sets.midcast['Enfeebling Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Merlinic Jubbah",hands="Lurid Mitts",ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Luminary Sash",legs="Psycloth Lappas",feet="Skaoi Boots"}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",ear2="Barkaro. Earring",waist="Acuity Belt +1"})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",ear2="Barkaro. Earring",waist="Acuity Belt +1"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",ear2="Barkaro. Earring",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",ear2="Barkaro. Earring",waist="Acuity Belt +1"})
	
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {range=empty,ring1="Stikini Ring"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {range=empty,ring1="Stikini Ring"})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {ring1="Stikini Ring +1"})
		
	sets.midcast['Enhancing Magic'] = {
		main="Oranyan",
		sub="Clerisy Strap +1",
		head=gear.TelchineCap.ES,
		body=gear.TelchineChasuble.Enh,
		hands=gear.TelchineGloves.Enh,
		legs=gear.TelchineBraconi.ES,
		feet=gear.TelchinePigaches.ES,
		neck="Incanter's Torque",
		ear2="Andoaa Earring",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back="Fi Follet Cape +1",
		waist="Olympus Sash"}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head="Amalric Coif",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Resting sets
	sets.resting = {
		main="Chatoyant Staff",
		sub="Oneiros Grip",
		head="Befouled Crown",
		neck="Chrys. Torque",
		ear1="Etiolation Earring",
		ear2="Ethereal Earring",
		body="Shamash Robe",
		hands="Bagua Mitaines +1",
		ring1="Defending Ring",
		ring2="Dark Ring",
		waist="Shinjutsu-no-Obi +1",
		back="Umbra Cape",
		legs="Assid. Pants +1",
		feet=gear.jse.artifact.geo.feet}

	-- Idle sets

	sets.idle = {
		main="Idris",
		sub="Genmei Shield",
		range="Dunna",
		head="Befouled Crown",
		body="Shamash Robe",
		hands="Bagua Mitaines +1",
		legs="Assid. Pants +1",
		feet=gear.jse.artifact.geo.feet,
		neck="Sanctity Necklace",
		ear1="Genmei Earring",
		ear2="Infused Earring",
		ring1="Paguroidea Ring",
		ring2="Sheltered Ring",
		back=gear.jsecapes.amb.geo.pet,
		waist="Flax Sash"}
		
	sets.idle.PDT = {
		main="Malignance Pole",
		sub="Umbra Strap",
		head="Hagondes Hat +1",
		neck="Loricate Torque +1",
		ear1="Genmei Earring",
		ear2="Ethereal Earring",
		body="Shamash Robe",
		hands="Hagondes Cuffs +1",
		ring1="Defending Ring",ring2="Shadow Ring",
		back="Repulse Mantle",
		waist="Flax Sash",
		legs="Hagondes Pants +1",
		feet="Mallquis Clogs +1"}
		
	sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque",ring2="Karieyh Ring"})

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = {
		main="Idris", --3/3
		sub="Genmei Shield",
		range="Dunna", --5/0
		head="Azimuth Hood +1", --0/3
		neck="Loricate Torque +1",
		body="Shamash Robe", --0/3
		hands=gear.jse.artifact.geo.hands, --11/0
		legs=gear.TelchineBraconi.PetRegen, --0/3
		feet=gear.TelchinePigaches.PetRegen, --0/3
		ear1="Handler's Earring", --3*/0
		ear2="Handler's Earring +1", --4*/0
		back=gear.jsecapes.amb.geo.pet, --0/10
		waist="Isa Belt" --3/1
		}

	sets.idle.PDT.Pet = {
		main="Malignance Pole",
		sub="Umbra Strap",
		range="Dunna",
		head="Azimuth Hood +1",
		neck="Loricate Torque +1",
		ear1="Handler's Earring",
		ear2="Handler's Earring +1",
		body=gear.ambuscade.jhakri.body,
		hands=gear.jse.artifact.geo.hands,
		ring1="Defending Ring",
		ring2="Sheltered Ring",
		back=gear.jsecapes.amb.geo.pet,
		waist="Isa Belt",
		legs="Hagondes Pants +1",
		feet="Bagua Sandals +1"}

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {}) 
	sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {}) 
	sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})

	sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body=gear.ambuscade.jhakri.body,hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Flax Sash",legs="Assid. Pants +1",feet="Azimuth Gaiters +1"}

	-- Defense sets
	
	sets.defense.PDT = {main="Malignance Pole",sub="Umbra Strap",
		head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Handler's Earring +1",
		body="Shamash Robe",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Azimuth Gaiters +1"}

	sets.defense.MDT = {main="Malignance Pole",sub="Umbra Strap",
		head="Azimuth Hood +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Handler's Earring +1",
		body="Shamash Robe",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Azimuth Gaiters +1"}
		
    sets.defense.MEVA = {main="Malignance Pole",sub="Enki Strap",
        head="Azimuth Hood +1",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Shamash Robe",hands="Telchine Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
        back=gear.idle_jse_back,waist="Luminary Sash",legs="Telchine Braconi",feet="Azimuth Gaiters +1"}
		
	sets.defense.PetPDT = sets.idle.PDT.Pet
		
	sets.defense.NukeLock = sets.midcast['Elemental Magic']
	
	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

	sets.Kiting = {feet="Crier's Gaiters"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})
	
	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body=gear.ambuscade.jhakri.body,hands=gear.ambuscade.jhakri.hands,ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",legs="Shedir Seraweels",feet=gear.ambuscade.jhakri.feet}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {
		head="Befouled Crown",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Shamash Robe",hands="Lurid Mitts",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back="Rancorous Mantle",waist="Witful Belt",legs="Assid. Pants +1",feet="Battlecast Gaiters"}
		
	sets.engaged.DW = {
		head="Befouled Crown",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Shamash Robe",hands="Lurid Mitts",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back="Rancorous Mantle",waist="Witful Belt",legs="Assid. Pants +1",feet="Battlecast Gaiters"}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {
		head="Ea Hat",
		body="Ea Houppelande",
		hands=gear.AmalricGages.A,
		legs="Ea Slops",
		feet=gear.ambuscade.jhakri.feet,
		neck="Mizu. Kubikazari", --10
		ring1="Mujin Band", --(5)
		back=gear.jsecapes.amb.geo.magic}
	sets.RecoverBurst = {
		head="Ea Hat",
		neck="Mizu. Kubikazari",
		body="Seidr Cotehardie",
		hands="Ea Cuffs",
		ring1="Mujin Band",
		legs="Ea Slops",
		feet=gear.ambuscade.jhakri.feet}
		
		-- Weapons sets
	sets.weapons.Idris = {main='Idris',sub='Genmei Shield'}
	sets.weapons.DualWeapons = {main='Idris',sub='Nehushtan'}

end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(3, 20)
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 13')
end