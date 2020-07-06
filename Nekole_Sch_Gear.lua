-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal','Resistant','Proc','OccultAcumen','9k')
    state.IdleMode:options('Normal','PDT')
	state.HybridMode:options('Normal','PDT')
	state.Weapons:options('None','Akademos','Khatvanga')
	set_lockstyle()
	
	gear.nuke_jse_back = {name="Lugh's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10'}}
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_waist = "Refoccilation Stone"
	gear.obi_high_nuke_waist = "Refoccilation Stone"
	
		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c scholar power')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
	send_command('bind !q gs c weapons default;gs c reset CastingMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace gs c scholar speed')
	send_command('bind @backspace gs c scholar aoe')
	send_command('bind ^= input /ja "Dark Arts" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise III" <me>')
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs=gear.jse.relic.sch.legs}
	sets.precast.JA['Enlightenment'] = {body=gear.jse.relic.sch.body}

    -- Fast cast sets for spells

    sets.precast.FC = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Impatiens",
        head=gear.AmalricCoif.DPlus,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Zendik Robe",hands=gear.jse.artifact.sch.hands,ring1="Kishar Ring",ring2="Lebeche Ring",
		back=gear.jsecapes.amb.sch.fc,waist="Witful Belt",legs=gear.psycloth.legs.D,feet="Regal Pumps +1"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Malignance Earring"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity",sub="Clerisy Strap +1",body="Heka's Kalasiris"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS['Myrkr'] = {ammo="Staunch Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Evans Earring",ear2="Etiolation Earring",
		body=gear.AmalricDoublet.A,hands="Telchine Gloves",ring1="Mephitas's Ring",ring2="Mephitas's Ring +1",
		back="Aurist's Cape +1",waist="Yamabuki-no-Obi",legs="Psycloth Lappas",feet="Medium's Sabots"}

    -- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {main="Akademos",sub="Enki Strap",neck="Mizu. Kubikazari",hands=gear.AmalricGages.D,ring1="Mujin Band",ring2="Locus Ring",feet="Jhakri Pigaches +2"}
	
	-- Gear for specific elemental nukes.
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}

    sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head=gear.AmalricCoif.DPlus,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Zendik Robe",hands=gear.gendewitha.hands.pdt,ring1="Kishar Ring",ring2="Prolix Ring",
		back=gear.jsecapes.amb.sch.fc,waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    sets.midcast.Cure = {main="Serenity",sub="Curatio Grip",ammo="Hasty Pinion +1",
        head=gear.AmalricCoif.DPlus,neck="Incanter's Torque",ear1="Meili Earring",ear2="Malignance Earring",
        body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Janniston Ring +1",ring2="Lebeche Ring",
        back="Tempered Cape +1",waist="Luminary Sash",legs="Chironic Hose",feet="Kaykaus Boots"}

    sets.midcast.LightWeatherCure = {main="Chatoyant Staff",sub="Curatio Grip",ammo="Hasty Pinion +1",
        head=gear.AmalricCoif.DPlus,neck="Incanter's Torque",ear1="Meili Earring",ear2="Malignance Earring",
        body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Janniston Ring +1",ring2="Lebeche Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs="Chironic Hose",feet="Kaykaus Boots"}
		
    sets.midcast.LightDayCure = {main="Serenity",sub="Curatio Grip",ammo="Hasty Pinion +1",
        head=gear.AmalricCoif.DPlus,neck="Incanter's Torque",ear1="Meili Earring",ear2="Malignance Earring",
        body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Janniston Ring +1",ring2="Lebeche Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs="Chironic Hose",feet="Kaykaus Boots"}

    sets.midcast.Curaga = sets.midcast.Cure

	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
	
	sets.midcast.Cursna = {main=gear.grioavolr_fc_staff,sub="Clemency Grip",ammo="Hasty Pinion +1",
		head=gear.AmalricCoif.DPlus,neck="Debilis Medallion",ear1="Meili Earring",ear2="Malignance Earring",
		body="Zendik Robe",hands="Hieros Mittens",ring1="Haoma's Ring",ring2="Menelaus's Ring",
		back="Oretan. Cape +1",waist="Witful Belt",legs=gear.psycloth.legs.B,feet=gear.vanya.feet.B}
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	sets.midcast['Enhancing Magic'] = {main=gear.weapons.whm.enh,sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head=gear.TelchineCap.ES,neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body=gear.TelchineChasuble.Enh,hands=gear.TelchineGloves.Enh,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back=gear.jsecapes.amb.sch.fc,waist="Embla Sash",legs=gear.TelchineBraconi.ES,feet=gear.TelchinePigaches.ES}

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {back=gear.jsecapes.amb.sch.fc})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head=gear.AmalricCoif.DPlus})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head=gear.AmalricCoif.DPlus,hands="Regal Cuffs",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})

    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet=gear.jse.relic.sch.feet})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shellra = sets.midcast.Shell


    -- Custom spell classes

	sets.midcast['Enfeebling Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
        body="Chironic Doublet",hands="Regal Cuffs",ring1="Kishar Ring",ring2="Stikini Ring +1",
        back=gear.jsecapes.amb.sch.fc,waist="Luminary Sash",legs="Chironic Hose",feet="Uk'uxkaj Boots"}
	
	sets.midcast['Enfeebling Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
        body="Chironic Doublet",hands=gear.jse.artifact.sch.hands,ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
        back=gear.jsecapes.amb.sch.fc,waist="Luminary Sash",legs="Chironic Hose",feet="Medium's Sabots"}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head=gear.AmalricCoif.DPlus,ear2="Malignance Earring",back=gear.jsecapes.amb.sch.mab,waist="Acuity Belt +1"})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head=gear.AmalricCoif.DPlus,back=gear.jsecapes.amb.sch.mab,waist="Acuity Belt +1"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head=gear.AmalricCoif.DPlus,ear1="Malignance Earring",back=gear.jsecapes.amb.sch.mab,waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head=gear.AmalricCoif.DPlus,back=gear.jsecapes.amb.sch.mab,waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {ring1="Stikini Ring +1",feet=gear.ChironicHose.MAB})

    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head=gear.AmalricCoif.DPlus,neck="Incanter's Torque",ear1="Regal Earring",ear2="Malignance Earring",
        body="Chironic Doublet",hands=gear.AmalricGages.D,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.jsecapes.amb.sch.mab,waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.MerlinicCrackows.MAB}

    sets.midcast.Kaustra = {main="Akademos",sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Saevus Pendant +1",ear1="Crematio Earring",ear2="Barkaro. Earring",
        body=gear.MerlinicDastanas.MAB,hands=gear.AmalricGages.D,ring1="Freke Ring",ring2="Archon Ring",
        back=gear.jsecapes.amb.sch.mab,waist="Refoccilation Stone",legs=gear.MerlinicShalwar.MB,feet=gear.MerlinicCrackows.MAB}
		
    sets.midcast.Kaustra.Resistant = {main=gear.weapons.BLM.magicstaff,sub="Niobid Strap",ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,neck="Erra Pendant",ear1="Crematio Earring",ear2="Malignance Earring",
        body=gear.MerlinicDastanas.MAB,hands=gear.AmalricGages.D,ring1="Shiva Ring +1",ring2="Freke Ring",
        back=gear.jsecapes.amb.sch.mab,waist="Acuity Belt +1",legs=gear.MerlinicShalwar.MB,feet=gear.MerlinicCrackows.MAB}

    sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
        body="Chironic Doublet",hands=gear.AmalricGages.D,ring1="Evanescence Ring",ring2="Archon Ring",
        back=gear.jsecapes.amb.sch.mab,waist="Fucho-no-obi",legs="Chironic Hose",feet=gear.MerlinicCrackows.MAB}
		
    sets.midcast.Drain.Resistant = {main="Rubicundity",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head=gear.AmalricCoif.C,neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
        body="Chironic Doublet",hands=gear.AmalricGages.D,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.jsecapes.amb.sch.mab,waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.MerlinicCrackows.MAB}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

    sets.midcast.Stun = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
        head="Nahtirah Hat",neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
        body="Zendik Robe",hands=gear.gendewitha.hands.pdt,ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
        back=gear.jsecapes.amb.sch.mab,waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}

    sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head=gear.AmalricCoif.C,neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
        body="Zendik Robe",hands=gear.AmalricGages.D,ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
        back=gear.jsecapes.amb.sch.mab,waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.MerlinicCrackows.MAB}

    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
        head=gear.MerlinicHood.MAB,neck="Saevus Pendant +1",ear1="Crematio Earring",ear2="Friomisi Earring",
        body=gear.MerlinicDastanas.MAB,hands="Mallquis Cuffs +1",ring1="Shiva Ring +1",ring2="Freke Ring",
        back=gear.jsecapes.amb.sch.mab,waist=gear.ElementalObi,legs=gear.MerlinicShalwar.MB,feet=gear.MerlinicCrackows.MAB}

    sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Malignance Earring",
        body=gear.MerlinicDastanas.MAB,hands="Mallquis Cuffs +1",ring1="Shiva Ring +1",ring2="Freke Ring",
        back=gear.jsecapes.amb.sch.mab,waist=gear.ElementalObi,legs=gear.MerlinicShalwar.MB,feet=gear.MerlinicCrackows.MAB}
		
    sets.midcast['Elemental Magic'].Fodder = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
        head=gear.MerlinicHood.MAB,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body=gear.MerlinicDastanas.MAB,hands="Mallquis Cuffs +1",ring1="Shiva Ring +1",ring2="Freke Ring",
        back=gear.jsecapes.amb.sch.mab,waist=gear.ElementalObi,legs=gear.MerlinicShalwar.MB,feet=gear.MerlinicCrackows.MAB}
		
	sets.midcast['Elemental Magic']['9k'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,neck="Saevus Pendant +1",ear1="Crematio Earring",ear2="Malignance Earring",
        body=gear.MerlinicDastanas.MAB,hands="Mallquis Cuffs +2",ring1="Shiva Ring +1",ring2="Freke Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    sets.midcast['Elemental Magic'].Proc = {main=empty, sub=empty,ammo="Impatiens",
        head="Nahtirah Hat",neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
        body="Helios Jacket",hands=gear.gendewitha.hands.pdt,ring1="Kishar Ring",ring2="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
	 sets.midcast['Elemental Magic'].OccultAcumen = {main="Khatvanga",sub="Bloodrain Strap",ammo="Seraphic Ampulla",
        head="Mall. Chapeau +2",neck="Combatant's Torque",ear1="Dedition Earring",ear2="Telos Earring",
        body=gear.MerlinicDastanas.MAB,hands="Mallquis Cuffs +2",ring1="Rajas Ring",ring2="Petrov Ring",
        back=gear.jsecapes.amb.sch.mab,waist="Oneiros Rope",legs="Perdition Slops",feet=gear.MerlinicCrackows.OCC}
		
    -- Custom refinements for certain nuke tiers
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {ammo="Pemphredo Tathlum",ear1="Regal Earring",ear2="Malignance Earring",hands=gear.AmalricGages.D,ring1="Metamor. Ring +1"})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {ammo="Pemphredo Tathlum",ear1="Regal Earring",ear2="Malignance Earring",hands=gear.AmalricGages.D,ring1="Metamor. Ring +1"})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {ammo="Pemphredo Tathlum",ear1="Regal Earring",ear2="Malignance Earring",hands=gear.AmalricGages.D,ring1="Metamor. Ring +1"})

	sets.midcast.Helix = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
        head=gear.MerlinicHood.MAB,neck="Saevus Pendant +1",ear1="Crematio Earring",ear2="Friomisi Earring",
        body=gear.MerlinicDastanas.MAB,hands=gear.AmalricGages.D,ring1="Metamor. Ring +1",ring2="Freke Ring",
        back=gear.jsecapes.amb.sch.mab,waist="Refoccilation Stone",legs=gear.MerlinicShalwar.MB,feet=gear.MerlinicCrackows.MAB}
	
	sets.midcast.Helix.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
        head=gear.MerlinicHood.MAB,"Sanctity Necklace",ear1="Malignance Earring",ear2="Friomisi Earring",
        body=gear.MerlinicDastanas.MAB,hands=gear.AmalricGages.D,ring1="Metamor. Ring +1",ring2="Freke Ring",
        back=gear.jsecapes.amb.sch.mab,waist="Acuity Belt +1",legs=gear.MerlinicShalwar.MB,feet=gear.MerlinicCrackows.MAB}
		
	sets.midcast.Helix.Proc = {main=empty, sub=empty,ammo="Impatiens",
        head="Nahtirah Hat",neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
        body="Zendik Robe",hands=gear.gendewitha.hands.pdt,ring1="Kishar Ring",ring2="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}

	sets.midcast.Impact = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=empty,neck="Erra Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Twilight Cloak",hands=gear.AmalricGages.D,ring1="Metamor. Ring +1",ring2="Stikini Ring +1",
		back=gear.jsecapes.amb.sch.mab,waist="Acuity Belt +1",legs=gear.MerlinicShalwar.MB,feet=gear.MerlinicCrackows.MAB}

	sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {head=empty,body="Twilight Cloak"})

    -- Sets to return to when not performing an action.

     -- Resting sets
    sets.resting = {main="Chatoyant Staff",sub="Oneiros Grip",ammo="Homiliary",
		head="Befouled Crown",neck="Chrys. Torque",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body=gear.AmalricDoublet.A,hands=gear.AmalricGages.A,ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Fucho-no-obi",legs="Assid. Pants +1",feet="Regal Pumps +1"}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {main="Daybreak",
		sub="Ammurapi Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Malignance Earring",
        body="Shamash Robe",hands=gear.AmalricGages.A,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Umbra Cape",waist="Flax Sash",legs="Assid. Pants +1",feet="Psycloth Boots"}

    sets.idle.PDT = {main="Malignance Pole", sub="Oneiros Grip",ammo="Staunch Tathlum",
        head=gear.gendewitha.head.pdt,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Shamash Robe",hands=gear.gendewitha.hands.pdt,ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Assid. Pants +1",feet="Psycloth Boots"}
		
	sets.idle.Hippo = set_combine(sets.idle.PDT, {feet="Hippo. Socks +1"})

    sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Shamash Robe",hands=gear.AmalricGages.A,ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Assid. Pants +1",feet="Psycloth Boots"}
		
    sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque"})

    -- Defense sets

    sets.defense.PDT = {main="Malignance Pole",sub="Umbra Strap",ammo="Staunch Tathlum",
        head=gear.gendewitha.head.pdt,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Mallquis Saio +1",hands=gear.gendewitha.hands.pdt,ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}

    sets.defense.MDT = {main="Malignance Pole",sub="Umbra Strap",ammo="Staunch Tathlum",
        head=gear.gendewitha.head.pdt,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Mallquis Saio +1",hands=gear.gendewitha.hands.pdt,ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}
		
    sets.defense.MEVA = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum",
        head=gear.MerlinicHood.MAB,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body=gear.MerlinicDastanas.MAB,hands=gear.gendewitha.hands.pdt,ring1="Vengeful Ring",ring2="Purity Ring",
        back=gear.nuke_jse_back,waist="Acuity Belt +1",legs=gear.MerlinicShalwar.MB,feet=gear.MerlinicCrackows.MAB}
		
    sets.Kiting = {feet="Crier's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Jhakri Robe +2",hands=gear.gendewitha.hands.pdt,ring1="Defending Ring",ring2="Sheltered Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Assid. Pants +1",feet="Battlecast Gaiters"}
		
	sets.engaged.PDT = {main="Malignance Pole", sub="Oneiros Grip",ammo="Staunch Tathlum",
        head=gear.gendewitha.head.pdt,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Vrikodara Jupon",hands=gear.gendewitha.hands.pdt,ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = {head=gear.jse.empyrean.sch.head}
    sets.buff['Rapture'] = {head=gear.jse.empyrean.sch.head}
    sets.buff['Perpetuance'] = {hands=gear.jse.empyrean.sch.hands}
    sets.buff['Immanence'] = {hands=gear.jse.empyrean.sch.hands}
    sets.buff['Penury'] = {legs=gear.jse.empyrean.sch.legs}
    sets.buff['Parsimony'] = {legs=gear.jse.empyrean.sch.legs}
    sets.buff['Celerity'] = {feet=gear.jse.relic.sch.feet}
    sets.buff['Alacrity'] = {feet=gear.jse.relic.sch.feet}
    sets.buff['Klimaform'] = {feet=gear.jse.empyrean.sch.feet}
	
	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Zendik Robe",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",waist="Flax Sash",legs="Shedir Seraweels",feet=""}
		
	sets.HPCure = {main="Daybreak",sub="Sors Shield",range=empty,ammo="Hasty Pinion +1",
        head="Gende. Caubeen +1",neck="Unmoving Collar +1",ear1="Gifted Earring",ear2="Mendi. Earring",
        body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Gelatinous Ring +1",ring2="Meridian Ring",
        back="Moonlight Cape",waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Kaykaus Boots"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff['Light Arts'] = {legs=gear.jse.artifact.sch.legs} --legs="Academic's Pants +3"
	sets.buff['Dark Arts'] = {body=gear.jse.artifact.sch.body} --body="Academic's Gown +3"

   sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Weapons sets
	sets.weapons.Akademos = {main="Akademos",sub="Niobid Strap"}
	sets.weapons.Khatvanga = {main="Khatvanga",sub="Bloodrain Strap"}
	
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'RDM' then
		set_macro_page(1, 19)
	elseif player.sub_job == 'BLM' then
		set_macro_page(1, 19)
	elseif player.sub_job == 'WHM' then
		set_macro_page(1, 19)
	else
		set_macro_page(1, 19)
	end
end
function set_lockstyle()
	send_command('wait 2; input /lockstyleset 5')
end