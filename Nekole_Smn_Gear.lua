-- Setup vars that are user-dependent.  Can override this function in a sidecar file.

function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'TPEat', 'Regain')
	
	gear.perp_staff = {name=gear.weapons.smn.bpmagicstaff}

	
    send_command('bind !` input /ja "Release" <me>')
	send_command('bind @` gs c cycle MagicBurst')
	send_command('bind ^` gs c toggle PactSpamMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.merlinic_treasure_feet})
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = {head=gear.jse.relic.smn.head}
    
    sets.precast.JA['Elemental Siphon'] = {
		main=gear.weapons.smn.smnskillstaff,
		sub="Vox Grip",
		ammo="Esper Stone +1",
		head=gear.TelchineCap.ES,
		body=gear.TelchineChasuble.ES,
		hands=gear.TelchineGloves.ES,
		legs=gear.TelchineBraconi.ES,
		feet=gear.jse.empyrean.smn.feet,
		neck="Incanter's Torque",
		waist="Lucidity Sash",
		ear1="Gifted Earring",
		ear1="Andoaa earring",
		ring1="Stikini Ring",
		ring2="Evoker's Ring",
		back=gear.jsecapes.smn}

    sets.precast.JA['Mana Cede'] = {hands=gear.jse.empyrean.smn.hands}

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = {
		main=gear.weapons.smn.smnskillstaff, --II -2
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head=gear.jse.empyrean.smn.head,-- 3 Favor
		neck="Incanter's Torque",
		body="Shomonjijoe +1", --8
		hands=gear.jse.relic.smn.hands,--6
		legs=gear.jse.relic.smn.legs,
		ear1="Andoaa Earring",
		ear2="Evans Earring",
		ring1="Evoker's Ring",
		ring2="Stikini Ring",
		back=gear.jsecapes.smn, --II -2
		feet="Baayami Sabots"}

    sets.precast.BloodPactRage = sets.precast.BloodPactWard

    -- Fast cast sets for spells
    
    sets.precast.FC = {main="Oranyan", --7
		sub="Clerisy Strap +1", --3
		head=gear.vanya.head.A,
		neck="Orunmila's Torque",--5
		ear1="Enchntr. Earring +1",--2
		ear2="Loquacious earring",--2
		hands=gear.TelchineGloves.FCandEnh,
--		body="Inyanga Jubbah +1", --13
		body="Zendik Robe",
		ring1={name="Mephitas's Ring +1",priority=3},
		ring2="Weather. Ring", -- 5 FC 3 QC
		waist="Witful belt", --3
		legs=gear.psycloth.legs.D, --7
		feet="Regal Pumps +1",
		back="Swith cape +1", --4
		}

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity",sub="Clerisy Strap +1"})
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {
		main="Nirvana",
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head=gear.ApogeeCrown.B,
		body="Beck. Doublet +1",
		hands="Lamassu mitts +1",
		legs="Beck. Spats +1",
		feet=gear.ApogeePumps.A,
		neck="Sanctity Necklace",
		waist="Shinjutsu-no-Obi +1",
		ear1="Etiolation Earring",
		ear2=gear.ears.ws,
		ring1="Mephitas's Ring",
		ring2="Mephitas's Ring +1",
		back=gear.jsecapes.smn}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
		main="Oranyan",
		sub="Clerisy Strap +1",
		head=gear.vanya.head.A,
		neck="Orunmila's Torque",
		ear1="Enchntr. Earring +1",
		ear2="Loquacious Earring",
		body="Inyanga Jubbah +1",
		hands=gear.TelchineGloves.FCandEnh,
		ring1="Weather. Ring",
		ring2="Prolix Ring",
		back="Swith Cape +1",
		waist="Witful Belt",
		legs="Lengo Pants",
		feet="Regal Pumps +1"}
	
    sets.midcast.Cure = {
		main="Serenity",
		sub="Curatio Grip",
		head=gear.vanya.head.A,--10%
		body=gear.vanya.body.C,
		hands="Reveal. Mitts +1",--14%
	    legs="Gyve Trousers",
		feet=gear.vanya.feet.D,--5%
		ear1="Mendicant's Earring",--5%
		ear2="Roundel Earring",--5%
	--right_ring="Sirona's Ring",
		ring1="Lebeche Ring",--3%, -5 enmity
		ring2={name="Mephitas's Ring +1",priority=3},
		neck="Nodens Gorget",--5%
		waist="Witful Belt",
		back="Thaumaturge's Cape"}
		
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		ring1="Haoma's Ring",ring2="Haoma's Ring", back="Tempered Cape +1",waist="Witful Belt"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Oranyan",sub="Clemency Grip"})

	sets.midcast['Elemental Magic'] = {
		main=gear.weapons.BLM.magicstaff,
		sub="Zuuxowu Grip",
        head=gear.MerlinicHood.MAB,
		neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
        body=gear.MerlinicJubbah.MAB,
		hands=gear.AmalricGages.D,
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
		back="Toro Cape",
		waist="Sekhmet Corset",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MB}
		
	sets.midcast['Elemental Magic'].Resistant = {
		main=gear.weapons.BLM.magicstaff,
		sub="Zuuxowu Grip",
        head=gear.MerlinicHood.MAB,
		neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
        body=gear.MerlinicJubbah.MAB,
		hands=gear.AmalricGages.D,
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
		back="Toro Cape",
		waist="Sekhmet Corset",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MB}

    sets.midcast['Divine Magic'] = {
		main="Oranyan",
		sub="Zuuxowu Grip",
        head=gear.MerlinicHood.MAB,
		neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
        body=gear.MerlinicJubbah.MAB,
		hands=gear.AmalricGages.D,
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
		back="Toro Cape",
		waist="Sekhmet Corset",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MB}
		
    sets.midcast['Dark Magic'] = {
		main="Rubicundity",
		sub="Culminus",
        neck="Incanter's Torque",
		head=gear.AmalricCoif.C,
		ear1="Digni. Earring",
		ear2="Gwati Earring",
        body=gear.MerlinicJubbah.MAB,
		hands=gear.AmalricGages.D,
		ring1="Stikini Ring",
		ring2="Stikini Ring",
        back="Seshaw Cape",
		waist="Yamabuki-no-Obi",
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
        back="Seshaw Cape",
		waist="Fucho-no-obi",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MB}
    
    sets.midcast.Aspir = sets.midcast.Drain
		
    sets.midcast.Stun = {
		main="Oranyan",
		sub="Clerisy Strap +1",
		head=gear.AmalricCoif.C,
		neck="Orunmila's Torque",
		ear1="Enchntr. Earring +1",
		ear2="Loquacious Earring",
		body="Inyanga Jubbah +1",
		hands="Helios Gloves",
--		ring1="Kishar Ring",
		ring2="Stikini Ring",
		back="Swith Cape +1",
		waist="Witful Belt",
		legs=gear.psycloth.legs.D,
		feet="Regal Pumps +1"}
		
    sets.midcast.Stun.Resistant = {
		main="Oranyan",
		sub="Clerisy Strap +1",
		head=gear.AmalricCoif.C,
		neck="Orunmila's Torque",
		ear1="Enchntr. Earring +1",
		ear2="Loquacious Earring",
		body="Inyanga Jubbah +1",
		hands="Helios Gloves",
--		ring1="Kishar Ring",
		ring2="Stikini Ring",
		back="Swith Cape +1",
		waist="Witful Belt",
		legs=gear.psycloth.legs.D,
		feet="Regal Pumps +1"}
		
	sets.midcast['Enfeebling Magic'] = {
		main="Oranyan",
		sub="Enki Strap",
		head="Befouled Crown",
		neck="Imbodla Necklace",
		ear1="Digni. Earring",
		ear2="Gwati Earring",
		body=gear.MerlinicJubbah.MAB,
		hands="Lurid Mitts",
--		ring1="Kishar Ring",
		ring2="Stikini Ring",
		back="Seshaw Cape",
		waist="Luminary Sash",
		legs=gear.psycloth.legs.D,
		feet="Uk'uxkaj Boots"}
		
	sets.midcast['Enfeebling Magic'].Resistant = {
		main="Oranyan",
		sub="Clerisy Strap +1",
		head="Befouled Crown",
		neck="Imbodla Necklace",
		ear1="Digni. Earring",
		ear2="Gwati Earring",
		body=gear.MerlinicJubbah.MAB,
		hands="Lurid Mitts",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
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
		main="Gada",
		sub="Culminus",
		ammo="Hasty Pinion +1",
		head=gear.TelchineCap.ES,
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Gifted Earring",
		body=gear.TelchineChasuble.Enh,
		hands=gear.TelchineGloves.Enh,
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back="Perimede Cape",
		waist="Olympus Sash",
		legs=gear.TelchineBraconi.ES,
		feet=gear.TelchinePigaches.ES}
		
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head=gear.AmalricCoif.C})
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head=gear.AmalricCoif.C,waist="Emphatikos Rope",legs="Shedir Seraweels"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})


    -- Avatar pact sets.  All pacts are Ability type.
    
    sets.midcast.Pet.BloodPactWard = {
		main=gear.weapons.smn.smnskillstaff,
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head=gear.jse.empyrean.smn.head,
		body=gear.jse.empyrean.smn.body,
		hands="Lamassu Mitts +1",
		legs=gear.jse.empyrean.smn.legs,
		feet="Baayami Sabots",
		neck="Incanter's Torque",
--	waist="Kobo Obi",  Need
		waist="Lucidity Sash",
		ear1="Summoning earring",
		ear2="Andoaa earring",
		ring1="Stikini Ring",
		ring2="Evoker's ring",
		back=gear.jsecapes.smn}

    sets.midcast.Pet.DebuffBloodPactWard = {
		main=gear.weapons.smn.smnskillstaff,
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head="Tali'ah Turban +1",
		neck="Deino Collar",
		ear1="Andoaa Earring",
--		ear2="Enmerkar Earring",
        body="Tali'ah Manteel +1",
		hands=gear.ApogeeMitts.Dplus,
		ring1="Evoker's Ring",
		ring2="Stikini Ring",
        back=gear.jsecapes.amb.smn.magic,
		waist="Incarnation Sash",
		legs="Tali'ah Sera. +1",
		feet="Tali'ah Crackows +1"}
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.DebuffBloodPactWard
    
    sets.midcast.Pet.PhysicalBloodPactRage = {
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head=gear.ApogeeCrown.B,
		body="Convoker's Doublet +1",
		hands=gear.MerlinicDastanas.MAB,
		legs=gear.ApogeeSlacks.D,
		neck="Empath necklace",
		waist="Incarnation Sash",
		ear1="Gelos Earring",
		ear2="Esper earring",
		ring1={name="Varar Ring",priority=3},
		ring2={name="Varar Ring",priority=3},
		back=gear.jsecapes.amb.smn.att,
		feet=gear.ApogeePumps.Bplus,}
		
    sets.midcast.Pet.PhysicalBloodPactRage.Acc = sets.midcast.Pet.PhysicalBloodPactRage

    sets.midcast.Pet.MagicalBloodPactRage = {
		main=gear.weapons.smn.smnskillstaff,
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
        head=gear.ApogeeCrown.Aplus,
		neck="Empath necklace",
		ear1="Gelos Earring",
		ear2="Esper Earring",
        body="Convoker's Doublet +1",
		hands=gear.MerlinicDastanas.MAB,
		ring1="Varar Ring",
		ring2="Varar Ring",
        back=gear.jsecapes.amb.smn.magic,
		waist="Incarnation Sash",
		legs="Enticer's Pants",
		feet="Con. Pigaches +1"}

    sets.midcast.Pet.MagicalBloodPactRage.Acc = sets.midcast.Pet.MagicalBloodPactRage

    -- Spirits cast magic spells, which can be identified in standard ways.
    
    sets.midcast.Pet.WhiteMagic = {} --legs="Summoner's Spats"
    
    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {}) --legs="Summoner's Spats"

    sets.midcast.Pet['Elemental Magic'].Resistant = {}
    
	sets.midcast.Pet['Flaming Crush'] = {
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
        head=gear.ApogeeCrown.Aplus,
		neck="Empath necklace",
		ear1="Gelos Earring",
		ear2="Esper Earring",
        body="Con. Doublet +1",
		hands=gear.ApogeeDalmatica.B,
		ring1="Varar Ring",
		ring2="Varar Ring",
        back=gear.jsecapes.amb.smn.att,
		waist="Incarnation Sash",
		legs=gear.ApogeeSlacks.D,
		feet=gear.ApogeePumps.Bplus}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {
		main="Chatoyant Staff",
        head="Beckoner's Horn +1",
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
        head=gear.ApogeeCrown.Aplus,
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Ethereal Earring",
        body=gear.ApogeeDalmatica.Aplus,
		hands=gear.ApogeeMitts.Dplus,
		ring1="Defending Ring",
		ring2="Gelatinous Ring +1",
        back=gear.jsecapes.amb.smn.pidle,
		waist="Fucho-no-obi",
		legs=gear.ApogeeSlacks.Aplus,
		feet="Baayami Sabots"}

    sets.idle.PDT = {
--		main="Mafic Cudgel", --10
		sub="Genmei Shield", --10
		ring1="Defending Ring",--10
		ring2="Gelatinous Ring +1",--6
		ear1="Etiolation Earring", --3mdt
--		ear2="Genmei Earring",
		neck="Loricate Torque +1", --6
		head="Blistering sallet +1",
		body="Onca Suit", --10
		hands="",
		legs="",
		feet="",
		back="Solemnity Cape"--4
		}
		
	sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque"})
	sets.idle.Regain = set_combine(sets.idle, {})

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
        head="Beckoner's Horn +1",
		neck="Caller's Pendant",
		ear1="Andoaa Earring",
		ear2="Evans earring",
        body=gear.ApogeeDalmatica.Aplus,
		hands="Asteria Mitts +1",
		ring1="Evoker's Ring",
		ring2="Mephitas's Ring +1",
        back=gear.jsecapes.amb.smn.pidle,
		waist="Fucho-no-Obi",
		legs="Assid. Pants +1",
		feet="Con. Pigaches +1"}
		
    sets.idle.PDT.Avatar = {main="Terra's Staff",sub="Oneiros Grip",ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Evans Earring",
        body="Shomonjijoe +1",hands="Asteria Mitts +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Umbra Cape",waist="Lucidity Sash",legs="Assid. Pants +1",feet="Con. Pigaches +1"}

    sets.idle.Spirit = {
		main="Nirvana",
		sub="Oneiros Grip",
		ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",
		neck="Caller's Pendant",
		ear1="Andoaa Earring",
		ear2="Evans earring",
        body=gear.ApogeeDalmatica.Aplus,
		hands="Asteria Mitts +1",
		ring1="Evoker's Ring",
		ring2="Mephitas's Ring +1",
        back=gear.jsecapes.amb.smn.pidle,
		waist="Fucho-no-Obi",
		legs="Assid. Pants +1",
		feet="Con. Pigaches +1"}
		
    sets.idle.PDT.Spirit = {main="Terra's Staff",sub="Oneiros Grip",ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Evans Earring",
        body="Shomonjijoe +1",hands="Asteria Mitts +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Umbra Cape",waist="Lucidity Sash",legs="Assid. Pants +1",feet="Battlecast Gaiters"}
		
	sets.idle.TPEat.Avatar = set_combine(sets.idle.Avatar, {neck="Chrys. Torque"})
	sets.idle.Regain.Avatar = set_combine(sets.idle.Avatar, {})
		
	--Favor always up and head is best in slot idle so no specific items here at the moment.
    sets.idle.Avatar.Favor = {}
    sets.idle.Avatar.Melee = {}
	
	sets.idle.Avatar.Melee.Carbuncle = {}
	sets.idle.Avatar.Melee['Cait Sith'] = {hands="Lamassu Mitts +1"}
        
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
		main="Terra's Staff",sub="Umbra Strap",ammo="Sancus Sachet +1",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Handler's Earring +1", --ear2="Enmerkar Earring",
        body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Umbra Cape",waist="Slipor Sash",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}

    sets.defense.MDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Sancus Sachet +1",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Etiolation Earring",--ear2="Lugalbanda Earring",
        body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Umbra Cape",waist="Slipor Sash",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}

    sets.defense.MEVA = {main="Terra's Staff",sub="Enki Strap",ammo="Sancus Sachet +1",
        head="Amalric Coif",neck="Warder's Charm +1",ear1="Sanare Earring",--ear2="Lugalbanda Earring",
		body="Inyanga Jubbah +1",hands="Telchine Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
        back="Seshaw Cape",waist="Luminary Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.HPDown = {head="Apogee Crown",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Seidr Cotehardie",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",legs="Shedir Seraweels",feet="Herald's Gaiters"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Sacrifice Torque"}
	sets.Weapons = {main="Gridarvor", sub="Elan Strap +1"}
    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
    sets.engaged = {main="Gridarvor",sub="Bloodrain Strap",ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Shulmanu Collar",ear1="Digni. Earring",ear2="Telos Earring",
        body="Con. Doublet +1",hands=gear.merlinic_refresh_hands,ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.phys_jse_back,waist="Olseni Belt",legs="Assid. Pants +1",feet="Con. Pigaches +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
    
    -- Default macro set/book
    set_macro_page(1, 15)
end
