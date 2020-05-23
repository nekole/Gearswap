-- Setup vars that are user-dependent.  Can override this function in a sidecar file..
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant','OccultAcumen')
    state.IdleMode:options('Normal','PDT')
	state.Weapons:options('None','Gridarvor','Nirvana','Khatvanga')
	
	gear.perp_staff = {name=gear.weapons.smn.bpmagicstaff}

	
    send_command('bind !` input /ja "Release" <me>')
	send_command('bind @` gs c cycle MagicBurst')
	send_command('bind ^` gs c toggle PactSpamMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
	send_command('bind !q gs c weapons default;gs c reset CastingMode')
	
    select_default_macro_book()
	set_lockstyle()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = {head=gear.jse.relic.smn.head}
    
    sets.precast.JA['Elemental Siphon'] = {
		main="Espiritus",
		sub="Vox Grip",
		ammo="Esper Stone +1",
		head=gear.TelchineCap.ES,
		body=gear.TelchineChasuble.ES,
		hands="Baayami Cuffs",
		legs=gear.TelchineBraconi.ES,
		feet=gear.jse.empyrean.smn.feet,
		neck="Incanter's Torque",
		waist="Kobo Obi",
		ear1="Cath Palug Earring",
        ear2="Lodurr Earring",
		ring1="Stikini Ring +1",
		ring2="Evoker's Ring",
		back=gear.jsecapes.smn}

    sets.precast.JA['Mana Cede'] = {hands=gear.jse.empyrean.smn.hands}

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = {
		main="Espiritus", 
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head=gear.jse.empyrean.smn.head,
		neck="Incanter's Torque",
		body=gear.jse.artifact.smn.body, 
		hands="Baayami Cuffs",
		legs="Baayami Slops",
		ear1="Cath Palug Earring",
        ear2="Lodurr Earring",
		ring1="Evoker's Ring",
		ring2="Stikini Ring +1",
		back=gear.jsecapes.smn, 
		waist="Kobo Obi",
		feet="Baayami Sabots"}

    sets.precast.BloodPactRage = sets.precast.BloodPactWard

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		main=gear.grioavolr_fc_staff, --7
		sub="Clerisy Strap +1", --3
		ammo="Impatiens",
		head=gear.AmalricCoif.DPlus,
		neck="Orunmila's Torque",--5
		ear1="Enchntr. Earring +1",--2
		ear2="Malignance Earring",--2
		hands=gear.TelchineGloves.FCandEnh,
		body=gear.ambuscade.inyanga.body, --13
		ring1="Kishar Ring",
		ring2="Lebeche Ring", -- 5 FC 3 QC
		waist="Witful belt", --3
		legs=gear.psycloth.legs.D, --7
		feet="Regal Pumps +1",
		back="Swith cape +1", --4
		}

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity",sub="Clerisy Strap +1"})
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {
--	head=empty,body="Twilight Cloak"
})       
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {
		ammo="Sancus Sachet +1",
		head=gear.ApogeeCrown.B,
		body=gear.jse.artifact.smn.body,
		hands="Lamassu mitts +1",
		legs="Beck. Spats +1",
		feet=gear.ApogeePumps.A,
		neck="Sanctity Necklace",
		waist="Luminary Sash",
		ear1="Etiolation Earring",
		ear2="Gifted Earring",
		ring1="Mephitas's Ring",
		ring2="Mephitas's Ring +1",
		back=gear.jsecapes.smn}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
		main=gear.grioavolr_fc_staff,
		sub="Clerisy Strap +1",
		ammo="Hasty Pinion +1",
		head=gear.AmalricCoif.DPlus,
		neck="Orunmila's Torque",
		ear1="Enchntr. Earring +1",
		ear2="Malignance Earring",
		body=gear.ambuscade.inyanga.body,
		hands=gear.TelchineGloves.FCandEnh,
		ring1="Kishar Ring",
		ring2="Prolix Ring",
		back="Swith Cape +1",
		waist="Witful Belt",
		legs="Lengo Pants",
		feet="Regal Pumps +1"}
	
    sets.midcast.Cure = {
		main="Serenity",
		sub="Curatio Grip",
		ammo="Hasty Pinion +1",
		head=gear.vanya.head.A,--10%
		body="Vrikodara Jupon",
		hands=gear.TelchineGloves.PetRegen,
	    legs="Gyve Trousers",
		feet=gear.vanya.feet.D,--5%
		ear1="Mendicant's Earring",--5%
		ear2="Gifted Earring",--5%
		ring1="Janniston Ring +1",
		ring2="Menelaus's Ring",
		neck="Nodens Gorget",--5%
		waist="Austerity Belt +1",
		back="Tempered Cape +1"}
		
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		ring1="Haoma's Ring",ring2="Menelaus's Ring", back="Tempered Cape +1",waist="Witful Belt"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Oranyan",sub="Clemency Grip"})

	sets.midcast['Elemental Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Dosis Tathlum",
        head="Cath Palug Crown",
		neck="Baetyl Pendant",
		ear1="Malignance Earring",
		ear2="Friomisi Earring",
        body=gear.MerlinicJubbah.MAB,
		hands=gear.AmalricGages.D,
		ring1="Freke Ring",
		ring2="Shiva Ring +1",
		back="Toro Cape",
		waist="Sekhmet Corset",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MB}
		
	sets.midcast['Elemental Magic'].Resistant = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Dosis Tathlum",
        head=gear.MerlinicHood.MAB,
		neck="Baetyl Pendant",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
        body=gear.MerlinicJubbah.MAB,
		hands=gear.AmalricGages.D,
		ring1="Shiva Ring +1",
		ring2="Freke Ring",
		back="Toro Cape",
		waist="Sekhmet Corset",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MB}

    sets.midcast['Divine Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Dosis Tathlum",
        head=gear.MerlinicHood.MAB,
		neck="Baetyl Pendant",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
        body=gear.MerlinicJubbah.MAB,
		hands=gear.AmalricGages.D,
		ring1="Shiva Ring +1",
		ring2="Freke Ring",
		back="Toro Cape",
		waist="Sekhmet Corset",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MB}
		
    sets.midcast['Dark Magic'] = {
		main="Rubicundity",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
        neck="Incanter's Torque",
		head=gear.AmalricCoif.C,
		ear1="Digni. Earring",
		ear2="Gwati Earring",
        body=gear.MerlinicJubbah.MAB,
		hands=gear.AmalricGages.D,
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
        back="Aurist's Cape +1",
		waist="Refoccilation Stone",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MB}
	
	sets.midcast.Drain = {
		main="Rubicundity",
		sub="Culminus",
        head="Pixie Hairpin +1",
		neck="Incanter's Torque",
		ear1="Digni. Earring",
		ear2="Gwati Earring",
        body=gear.MerlinicJubbah.MAB,
		hands=gear.AmalricGages.D,
		ring1="Archon Ring",
		ring2="Evanescence Ring",
        back="Aurist's Cape +1",
		waist="Fucho-no-obi",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MB}
    
    sets.midcast.Aspir = sets.midcast.Drain
		
    sets.midcast.Stun = {
		main=gear.grioavolr_fc_staff,
		sub="Clerisy Strap +1",
		ammo="Hasty Pinion +1",
		head=gear.AmalricCoif.C,
		neck="Orunmila's Torque",
		ear1="Enchntr. Earring +1",
		ear2="Malignance Earring",
		body=gear.ambuscade.inyanga.body,
		hands=gear.AmalricGages.D,
		ring1="Kishar Ring",
		ring2="Stikini Ring +1",
		back="Swith Cape +1",
		waist="Witful Belt",
		legs=gear.psycloth.legs.D,
		feet="Regal Pumps +1"}
		
    sets.midcast.Stun.Resistant = {
		main="Daybreak",
		sub="Ammurapi Shield",
		head=gear.AmalricCoif.C,
		neck="Orunmila's Torque",
		ear1="Enchntr. Earring +1",
		ear2="Gwati Earring",
		body=gear.ambuscade.inyanga.body,
		hands=gear.AmalricGages.D,
		ring1="Kishar Ring",
		ring2="Stikini Ring +1",
		back="Aurist's Cape +1",
		waist="Witful Belt",
		legs=gear.psycloth.legs.D,
		feet="Regal Pumps +1"}
		
	sets.midcast['Enfeebling Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Befouled Crown",
		neck="Erra Pendant",
		ear1="Digni. Earring",
		ear2="Gwati Earring",
		body=gear.MerlinicJubbah.MAB,
		hands="Lurid Mitts",
		ring1="Kishar Ring",
		ring2="Stikini Ring +1",
		back="Aurist's Cape +1",
		waist="Luminary Sash",
		legs=gear.psycloth.legs.D,
		feet="Uk'uxkaj Boots"}
		
	sets.midcast['Enfeebling Magic'].Resistant = {
		main="Daybreak",
		sub="Ammurapi Shield",
		head="Befouled Crown",
		neck="Imbodla Necklace",
		ear1="Digni. Earring",
		ear2="Gwati Earring",
		body=gear.MerlinicJubbah.MAB,
		hands="Lurid Mitts",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
		back=gear.jsecapes.amb.smn.magic,
		waist="Luminary Sash",
		legs=gear.psycloth.legs.D,
		feet="Skaoi Boots"}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
		
	sets.midcast['Enhancing Magic'] = {
		main=gear.weapons.whm.enh,
		sub="Culminus",
		ammo="Hasty Pinion +1",
		head=gear.TelchineCap.ES,
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Gifted Earring",
		body=gear.TelchineChasuble.Enh,
		hands=gear.TelchineGloves.Enh,
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Perimede Cape",
		waist="Embla Sash",
		legs=gear.TelchineBraconi.ES,
		feet=gear.TelchinePigaches.ES}
		
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head=gear.AmalricCoif.C,waist="Gishdubar Sash"})
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Gada",sub="Genmei Shield"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",hands="Carapacho Cuffs"})
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})


    -- Avatar pact sets.  All pacts are Ability type.
    
    sets.midcast.Pet.BloodPactWard = {
		main=gear.weapons.smn.smnskillstaff,
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head=gear.jse.empyrean.smn.head,
		body=gear.jse.empyrean.smn.body,
		hands="Lamassu Mitts +1",
		legs="Baayami Slops",
		feet="Baayami Sabots",
		neck="Incanter's Torque",
		waist="Kobo Obi", 
		ear1="Lodurr Earring",
		ear2="Andoaa earring",
		ring1="Evoker's Ring",
		ring2="Stikini Ring +1",
		back=gear.jsecapes.smn}

    sets.midcast.Pet.DebuffBloodPactWard = {
		main=gear.weapons.smn.smnskillstaff,
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head=gear.ambuscade.taliah.head,
		neck="Adad Amulet",
		ear1="Andoaa Earring",
		ear2="Enmerkar Earring",
        body=gear.ambuscade.taliah.body,
		hands=gear.ApogeeMitts.Dplus,
		ring1="Evoker's Ring",
		ring2="Stikini Ring +1",
        back=gear.jsecapes.amb.smn.magic,
		waist="Incarnation Sash",
		legs=gear.ambuscade.taliah.legs,
		feet=gear.ambuscade.taliah.feet}
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.DebuffBloodPactWard
    
    sets.midcast.Pet.PhysicalBloodPactRage = {
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="Cath Palug Crown",
		body=gear.jse.relic.smn.body,
		hands=gear.MerlinicDastanas.BPD,
		legs=gear.ApogeeSlacks.D,
		neck="Summoner's Collar +2",
		waist="Incarnation Sash",
		ear1="Kyrene's Earring",
		ear2="Lugalbanda Earring",
		ring1="Cath Palug Ring",
		ring2="Varar Ring +1",
		back=gear.jsecapes.amb.smn.att,
		feet=gear.ApogeePumps.Bplus,}
		
    sets.midcast.Pet.PhysicalBloodPactRage.Acc = {feet=gear.jse.artifact.smn.feet}

    sets.midcast.Pet.MagicalBloodPactRage = {
		main=gear.weapons.smn.bpmagicstaff,
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
        head=gear.ApogeeCrown.Aplus,
		neck="Summoner's Collar +2",
		ear1="Gelos Earring",
		ear2="Lugalbanda Earring",
        body=gear.jse.artifact.smn.body,
		hands=gear.MerlinicDastanas.MAB,
		ring1="Varar Ring +1",
		ring2="Varar Ring +1",
        back=gear.jsecapes.amb.smn.magic,
		waist="Regal Belt",
		legs="Enticer's Pants",
--		legs=gear.ApogeeSlacks.Aplus,
		feet=gear.jse.artifact.smn.feet}

    sets.midcast.Pet.MagicalBloodPactRage.Acc = {feet=gear.jse.artifact.smn.feet}

    -- Spirits cast magic spells, which can be identified in standard ways.
    
    sets.midcast.Pet.WhiteMagic = {} --legs="Summoner's Spats"
    
    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {}) --legs="Summoner's Spats"

    sets.midcast.Pet['Elemental Magic'].Resistant = {}
    
	sets.midcast.Pet['Flaming Crush'] = {
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
        head="Cath Palug Crown",
		neck="Summoner's Collar +2",
		ear1="Gelos Earring",
		ear2="Lugalbanda Earring",
        body=gear.jse.artifact.smn.body,
		hands=gear.MerlinicDastanas.MAB,
		ring1="Varar Ring +1",
		ring2="Varar Ring +1",
        back=gear.jsecapes.amb.smn.att,
		waist="Regal Belt",
		legs=gear.ApogeeSlacks.Aplus,
		feet=gear.jse.artifact.smn.feet}
		
	sets.midcast.Pet['Flaming Crush'].Acc = {feet=gear.jse.artifact.smn.feet}
	
	sets.midcast.Pet['Mountain Buster'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Mountain Buster'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})
	sets.midcast.Pet['Rock Buster'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Rock Buster'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})
	sets.midcast.Pet['Crescent Fang'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Crescent Fang'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})
	sets.midcast.Pet['Eclipse Bite'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Eclipse Bite'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})
	sets.midcast.Pet['Blindside'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {legs="Enticer's Pants"})
	sets.midcast.Pet['Blindside'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc, {legs="Enticer's Pants"})

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {
		main="Chatoyant Staff",
        head=gear.jse.empyrean.smn.head,
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Ethereal Earring",
        body="Shomonjijoe +1",
		ring1="Defending Ring",
		ring2="Sheltered Ring",
        back="Umbra Cape",
		waist="Fucho-no-obi",
		legs="Assid. Pants +1",
		feet="Baayami Sabots"}
    
    -- Idle sets
    sets.idle = {
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
        head="Cath Palug Crown",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Cath Palug Earring",
        body="Udug Jacket",
		hands=gear.ApogeeMitts.Dplus,
		ring1="Defending Ring",
		ring2="Gelatinous Ring +1",
        back=gear.jsecapes.amb.smn.pidle,
		waist="Regal Belt",
		legs="Assid. Pants +1",
		feet="Baayami Sabots"}

    sets.idle.PDT = {
		main="Malignance Pole",
		sub="Oneiros Grip",
		ammo="Staunch Tathlum",
		ring1="Defending Ring",--10
		ring2="Gelatinous Ring +1",--6
		ear1="Etiolation Earring", --3mdt
--		ear2="Genmei Earring",
		neck="Loricate Torque +1", --6
		head="Blistering sallet +1",
		body="Udug Jacket", --10
		hands=gear.MerlinicDastanas.BPD,
		legs="Assiduity Pants +1",
		feet="Battlecast Gaiters",
		waist="Regal Belt",
		back="Solemnity Cape"--4
		}

    -- perp costs:
    -- spirits: 7
    -- carby: 11 (5 with mitts)
    -- fenrir: 13
    -- others: 15
    -- avatar's favor: -4/tick
    
    -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
    -- Aim for -14 perp, and refresh in other slots.
    
    -- -perp gear:
    -- Gridarvor: -5
    -- Glyphic Horn: -4
    -- Caller's Doublet +2/Glyphic Doublet: -4
    -- Evoker's Ring: -1
    -- Con. Pigaches +1: -4
    -- total: -18
    
    -- Can make due without either the head or the body, and use +refresh items in those slots.
    
    sets.idle.Avatar = {
		main="Nirvana",
		sub="Oneiros Grip",
		ammo="Sancus Sachet +1",
        head=gear.jse.empyrean.smn.head,
		neck="Summoner's Collar +2",
		ear1="Cath Palug Earring",
		ear2="Evans earring",
        body=gear.ApogeeDalmatica.Aplus,
		hands="Asteria Mitts +1",
		ring1="Evoker's Ring",
		ring2="Mephitas's Ring +1",
        back=gear.jsecapes.amb.smn.pidle,
		waist="Isa Belt",
		legs="Assid. Pants +1",
		feet=gear.jse.artifact.smn.feet}
		
    sets.idle.PDT.Avatar = {main="Malignance Pole",sub="Oneiros Grip",ammo="Sancus Sachet +1",
        head=gear.jse.empyrean.smn.head,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Evans Earring",
        body="Shomonjijoe +1",hands="Asteria Mitts +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Umbra Cape",waist="Regal Belt",legs="Assid. Pants +1",feet=gear.jse.artifact.smn.feet}

    sets.idle.Spirit = {
		main="Nirvana",
		sub="Oneiros Grip",
		ammo="Sancus Sachet +1",
        head=gear.jse.empyrean.smn.head,
		neck="Caller's Pendant",
		ear1="Cath Palug Earring",
		ear2="Evans earring",
        body=gear.ApogeeDalmatica.Aplus,
		hands="Asteria Mitts +1",
		ring1="Evoker's Ring",
		ring2="Mephitas's Ring +1",
        back=gear.jsecapes.amb.smn.pidle,
		waist="Fucho-no-Obi",
		legs="Assid. Pants +1",
		feet=gear.jse.artifact.smn.feet}
		
    sets.idle.PDT.Spirit = {main="Malignance Pole",sub="Oneiros Grip",ammo="Sancus Sachet +1",
        head=gear.jse.empyrean.smn.head,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Evans Earring",
        body="Shomonjijoe +1",hands="Asteria Mitts +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Umbra Cape",waist="Lucidity Sash",legs="Assid. Pants +1",feet="Battlecast Gaiters"}
		
	--Favor always up and head is best in slot idle so no specific items here at the moment.
    sets.idle.Avatar.Favor = {}
    sets.idle.Avatar.Engaged = {}
	
	sets.idle.Avatar.Engaged.Carbuncle = {}
	sets.idle.Avatar.Engaged['Cait Sith'] = {hands="Lamassu Mitts +1"}
        
    sets.perp = {}
    -- Caller's Bracer's halve the perp cost after other costs are accounted for.
    -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
    -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
    -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
    sets.perp.Day = {}
    sets.perp.Weather = {}
	
	sets.perp.Carbuncle = {hands="Asteria Mitts +1"}
    sets.perp.Diabolos = {}
    sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

	-- Not really used anymore, was for the days of specific staves for specific avatars.
    sets.perp.staff_and_grip = {}
    
    -- Defense sets
    sets.defense.PDT = {
		main="Malignance Pole",sub="Umbra Strap",ammo="Sancus Sachet +1",
        head=gear.jse.empyrean.smn.head,neck="Loricate Torque +1",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
        body="Shomonjijoe +1",hands=gear.MerlinicDastanas.BPD,ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Moonbeam Cape",waist="Regal Belt",legs="Assid. Pants +1",feet="Baayami Sabots"}

    sets.defense.MDT = {main="Malignance Pole",sub="Umbra Strap",ammo="Sancus Sachet +1",
        head=gear.jse.empyrean.smn.head,neck="Loricate Torque +1",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
        body="Shomonjijoe +1",hands=gear.MerlinicDastanas.BPD,ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Moonbeam Cape",waist="Regal Belt",legs="Assid. Pants +1",feet="Baayami Sabots"}

    sets.defense.MEVA = {main="Malignance Pole",sub="Enki Strap",ammo="Sancus Sachet +1",
        head=gear.AmalricCoif.C,neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Lugalbanda Earring",
		body=gear.ambuscade.inyanga.body,hands=gear.TelchineGloves.PetRegen,ring1="Vengeful Ring",Ring2="Purity Ring",
        back="Aurist's Cape +1",waist="Luminary Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
    sets.Kiting = {feet="Crier's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.HPDown = {head=gear.ApogeeCrown.Aplus,ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Seidr Cotehardie",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",legs=gear.ApogeeSlacks.Aplus,feet=gear.ApogeePumps.Bplus}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Sacrifice Torque"}
	
	sets.weapons.Nirvana = {main="Nirvana", sub="Elan Strap +1"}
	sets.weapons.Gridarvor = {main="Gridarvor", sub="Elan Strap +1"}
	sets.weapons.Khatvanga = {main="Khatvanga",sub="Bloodrain Strap"}
	
	sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
    sets.engaged = {main="Gridarvor",sub="Bloodrain Strap",ammo="Sancus Sachet +1",
        head=gear.jse.empyrean.smn.head,neck="Shulmanu Collar",ear1="Digni. Earring",ear2="Telos Earring",
        body=gear.jse.artifact.smn.body,hands="Gazu Bracelet +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.phys_jse_back,waist="Olseni Belt",legs="Assid. Pants +1",feet=gear.jse.artifact.smn.feet}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
    
    -- Default macro set/book
    set_macro_page(1, 15)
end
function set_lockstyle()
	send_command('wait 2; input /lockstyleset 9')
end
