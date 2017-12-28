function user_setup()
	-- Options: Override default values
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
	state.OffenseMode:options('None', 'Normal')
	state.IdleMode:options('Normal', 'PDT', 'TPEat','Regain','DTHippo')
	state.Moving  = M(false, "moving")

	gear.obi_cure_waist = "Witful Belt"
	gear.obi_low_nuke_waist = "Sekhmet Corset"
	gear.obi_high_nuke_waist = "Refoccilation Stone"
	set_lockstyle()

		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !\\\\ input /ja "Manawell" <me>')
	send_command('bind !` input /ma "Aspir III" <t>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f9 gs c cycle DeathMode')
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace input /ja "Enmity Douse" <t>')
	send_command('bind @backspace input /ja "Alacrity" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind @= input /ja "Addendum: White" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
    
	select_default_macro_book()
end

function init_gear_sets()

    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	sets.Weapons = {main=gear.weapons.BLM.magicstaff,sub="Niobid Strap"}
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {back=gear.jsecapes.amb.blm.mab,feet=gear.jse.empyrean.blm.feet}

    sets.precast.JA.Manafont = {body=gear.jse.relic.blm.body} 
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}
	
	sets.Adoulin = {
        body="Councilor's Garb",
    }

    sets.MoveSpeed = {
        feet ="Herald's Gaiters",
    }


    -- Fast cast sets for spells

    sets.precast.FC = {
		main="Marin Staff +1",
		sub="Clerisy Strap +1",
		ammo=gear.ammo.fc,                                                 
        head=gear.MerlinicHood.MAB,
		neck=gear.neck.fc,
		ear1=gear.ears.fc_left,
        ear2=gear.ears.fc_right, 
        body=gear.body.mage_fc,
		hands=gear.hands.mage_fc,
		gear.ring.fc_left,
		gear.ring.fc_right,
        back=gear.jsecapes.amb.blm.fc,
		waist=gear.waist.fc,
		legs=gear.legs.mage_fc,
		feet=gear.feet.mage_fc}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash",
		back="Perimede Cape",})
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Barkaro. Earring", waist="Channeler's Stone"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		main="Serenity",
		sub="Clerisy Strap +1",
		body="Heka's Kalasiris",
		legs="Doyen pants", 
		back="Pahtli Cape"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

	sets.precast.FC.Death = {
		main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Strobilus",
		ammo="Impatiens",
		head="Pixie Hairpin +1",
		body=gear.AmalricDoublet.A, --10
		hands=gear.AmalricGages.A, --(5)
		legs=gear.AmalricSlops.A,
		feet=gear.MerlinicCrackows.MACC, --11
		neck="Mizu. Kubikazari", --10
		ear1="Barkaro. Earring",
		ear2="Static Earring", --5
		ring1="Mephitas's Ring +1",
		ring2="Archon Ring",
		back=gear.jsecapes.amb.blm.fc, --5
		waist="Eschan Stone"}
		
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Dosis Tathlum",
		head="Pixie Hairpin +1",
		body="Weather. Robe +1",
		hands=gear.TelchineGloves.Enh,
		legs=gear.AmalricSlops.A,
		feet="Medium's Sabots",
		neck="Orunmila's Torque",
		ear1="Etiolation Earring",
		ear2="Loquacious Earring",
		ring1="Mephitas's Ring +1",
		ring2="Mephitas's Ring",
		back=gear.jsecapes.blm,
		waist="Shinjutsu-no-Obi +1",}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {
--		ammo="Dosis Tathlum",
--		head="Hagondes Hat +1",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
--		body="Zendik Robe",hands="Hagondes Cuffs +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
--		back="Taranus's Cape",waist="Fotia Belt",legs="Hagondes Pants +1",feet=gear.merlinic_nuke_feet
}

    sets.precast.WS['Myrkr'] = {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body="Weather. Robe +1",
		hands=gear.TelchineGloves.Enh,
		legs=gear.AmalricSlops.A,
		feet="Medium's Sabots",
		neck="Orunmila's Torque",
		ear1="Etiolation Earring",
		ear2="Loquacious Earring",
		ring1="Mephitas's Ring +1",
		ring2="Mephitas's Ring",
		back=gear.jsecapes.blm,
		waist="Shinjutsu-no-Obi +1",}
    
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
		ammo="Hasty Pinion +1",
		head="Nahtirah Hat",
		neck=gear.neck.fc,
		ear1="Enchntr. Earring +1",
		ear2="Loquacious Earring",
		body="Zendik Robe",
		hands=gear.MerlinicDastanas.FST,
		ring1="Weather. Ring",
		ring2="Kishar Ring",
		back="Swith Cape +1",
		waist="Witful Belt",
		legs=gear.MerlinicShalwar.MB,
		feet="Regal Pumps +1"}

    sets.midcast.Cure = {
		main="Serenity",
		sub="Curatio Grip",
		ammo="Hasty Pinion +1",
        head="Nahtirah Hat",
		neck="Incanter's Torque",
		ear1="Gifted Earring",
		ear2="Etiolation Earring",
        body="Zendik Robe",
		hands=gear.TelchineGloves.Enh,
		ring1="Sirona's Ring",
		ring2="Haoma's Ring",
        back="Oretan. Cape +1",
		waist="Bishop's Sash",
		legs="Gyve Trousers",
		feet="Medium's Sabots"}
		
    sets.midcast.LightWeatherCure = {
		main="Chatoyant Staff",
		sub="Curatio Grip",
		ammo="Hasty Pinion +1",
        head="Nahtirah Hat",
		neck="Phalaina Locket",
		ear1="Gifted Earring",
		ear2="Etiolation Earring",
        body="Heka's Kalasiris",
		hands=gear.TelchineGloves.Enh,
		ring1="Sirona's Ring",
		ring2="Lebeche Ring",
        back="Twilight Cape",
		waist="Hachirin-no-Obi",
		legs=gear.psycloth.legs.B,
		feet=gear.vanya.feet.B}
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {
		main="Serenity",
		sub="Curatio Grip",
		ammo="Hasty Pinion +1",
        head="Nahtirah Hat",
		neck="Phalaina Locket",
		ear1="Gifted Earring",
		ear2="Etiolation Earring",
        body="Zendik Robe",
		hands=gear.TelchineGloves.Enh,
		ring1="Sirona's Ring",
		ring2="Lebeche Ring",
        back="Twilight Cape",
		waist="Hachirin-no-Obi",
		legs=gear.psycloth.legs.B,
		feet=gear.vanya.feet.B
 }

    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",ring1="Haoma's Ring",ring2="Haoma's Ring"})
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Marin Staff +1",sub="Clemency Grip"})

	sets.midcast['Enhancing Magic'] = {
		main="Gada",
		sub="Sors Shield",
		ammo="Hasty Pinion +1",
		head=gear.TelchineCap.ES,
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Augment. Earring",
		body=gear.TelchineChasuble.Enh,
		hands=gear.TelchineGloves.Enh,
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back="Fi Follet Cape +1",
		waist="Olympus Sash",
		legs=gear.TelchineBraconi.ES,
		feet=gear.TelchinePigaches.ES}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
		head=gear.AmalricCoif.C,
		feet="Inspirited Boots",
		waist="Gishdubar Sash",
		back="Grapevine Cape"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head="Amalric Coif",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})

    sets.midcast['Enfeebling Magic'] = {
		main="Oranyan",
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
        head="Befouled Crown",
		neck="Sanctity Necklace",
		ear1="Digni. Earring",
		ear2="Enchntr. Earring +1",
        body=gear.MerlinicJubbah.MAB,
		hands="Jhakri Cuffs +1",
		ring1="Kishar Ring",
		ring2="Stikini Ring",
        back=gear.jsecapes.amb.blm.mab,
		waist="Luminary Sash",
		legs=gear.psycloth.legs.D,
		feet="Medium's Sabots"}
		
    sets.midcast['Enfeebling Magic'].Resistant = {
	    main="Oranyan",
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
        head="Befouled Crown",
		neck="Sanctity Necklace",
		ear1="Digni. Earring",
		ear2="Enchntr. Earring +1",
        body=gear.MerlinicJubbah.MAB,
		hands="Jhakri Cuffs +1",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
        back=gear.jsecapes.amb.blm.mab,
		waist="Luminary Sash",
		legs=gear.psycloth.legs.D,
		feet="Skaoi Boots"}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head=gear.AmalricCoif.C,waist="Acuity Belt +1"})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",waist="Acuity Belt +1"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head=gear.AmalricCoif.C,ear1="Barkaro. Earring",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",ear1="Barkaro. Earring",waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

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
        back=gear.jsecapes.amb.blm.fc,
		waist="Yamabuki-no-Obi",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MB}

    sets.midcast.Drain = {
		main="Rubicundity",
		sub="Culminus",
		ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
		neck="Sanctity Necklace",
		ear1="Barkaro. Earring",
		ear2="Digni. Earring",
        body="Helios Jacket",
		hands=gear.AmalricGages.D,
		ring1="Evanescence Ring",
		ring2="Archon Ring",
        back=gear.jsecapes.amb.blm.mab,
		waist="Fucho-no-obi",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MB}
    
    sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast.Aspir.Death = {
		main=gear.weapons.BLM.magicstaff,
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
		neck="Sanctity Necklace",
		ear1="Barkaro. Earring",
		ear2="Friomisi Earring",
        body="Helios Jacket",
		hands=gear.AmalricGages.A,
		ring1="Evanescence Ring",
		ring2="Archon Ring",
        back=gear.jsecapes.amb.blm.mab,
		waist="Fucho-no-obi",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MAB,}
	
	sets.midcast.Death = {
		main=gear.weapons.BLM.magicstaff,
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
		neck="Mizu. Kubikazari",
		ear1="Barkaro. Earring",
		ear2="Etiolation Earring",
        body=gear.MerlinicJubbah.MAB,
		hands=gear.AmalricGages.A,
		ring1="Mujin Band",
		ring2="Archon Ring",
        back=gear.jsecapes.amb.blm.mab,
		waist="Eschan Stone",
		legs="Merlinic Shalwar",
		feet=gear.merlinic_nuke_feet}

		
    sets.midcast.Stun = {
		main="Oranyan",
		sub="Enki Strap",
		ammo="Hasty Pinion +1",
        head="Nahtirah Hat",
		neck=gear.neck.fc,
		ear1="Enchntr. Earring +1",
		ear2="Loquacious Earring",
        body="Zendik Robe",
		hands=gear.hands.mage_fc,
		ring1="Stikini Ring",
		ring2="Stikini Ring",
        back=gear.jsecapes.amb.blm.fc,
		waist="Witful Belt",
		legs=gear.psycloth.legs.D,
		feet="Regal Pumps +1"}
		
    sets.midcast.Stun.Resistant = {
		main="Rubicundity",
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
        head="Nahtirah Hat",
		neck=gear.neck.fc,
		ear1="Barkaro. Earring",
		ear2="Friomisi Earring",
        body="Zendik Robe",
		hands=gear.hands.mage_fc,
		ring1="Stikini Ring",
		ring2="Stikini Ring",
        back=gear.jsecapes.amb.blm.fc,
		waist="Witful Belt",
		legs=gear.psycloth.legs.D,
		feet="Regal Pumps +1"}

    sets.midcast.BardSong = {
		main="Oranyan",
		sub="Clerisy Strap +1",
		ammo="Dosis Tathlum",
        head=gear.AmalricCoif.C,
		neck="Sanctity Necklace",
		ear1="Digni. Earring",
		ear2="Gwati Earring",
        body="Zendik Robe",
		hands="Lurid Mitts",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
        back=gear.jsecapes.amb.blm.fc,
		waist="Luminary Sash",
		legs=gear.MerlinicShalwar.MB,
		feet="Medium's Sabots"}
		
	sets.midcast.Impact = {
		main="Oranyan",
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head=empty,
		neck="Sanctity Necklace",
		ear1="Barkaro. Earring",
		ear2="Enchntr. Earring +1",
		body="Twilight Cloak",
		hands="Lurid Mitts",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back=gear.jsecapes.amb.blm.mab,
		waist="Acuity Belt +1",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MAB}

    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
		main=gear.weapons.BLM.magicstaff,
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,
		neck="Sanctity Necklace",
		ear1="Barkaro. Earring",
		ear2="Friomisi Earring",
        body=gear.MerlinicJubbah.MAB,
		hands=gear.AmalricGages.A,
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
        back=gear.jsecapes.amb.blm.mab,
		waist="Eschan Stone",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MAB}

    sets.midcast['Elemental Magic'].Resistant = {
		main=gear.weapons.BLM.magicstaff,
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,
		neck="Sanctity Necklace",
		ear1="Barkaro. Earring",
		ear2="Friomisi Earring",
        body=gear.MerlinicJubbah.MAB,
		hands=gear.AmalricGages.A,
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
        back=gear.jsecapes.amb.blm.mab,
		waist="Eschan Stone",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MAB}
		
    sets.midcast['Elemental Magic'].Fodder = {main=gear.weapons.BLM.magicstaff,
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
        head=gear.MerlinicHood.MAB,
		neck="Sanctity Necklace",
		ear1="Barkaro. Earring",
		ear2="Friomisi Earring",
        body=gear.MerlinicJubbah.MAB,
		hands=gear.AmalricGages.A,
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
        back=gear.jsecapes.amb.blm.mab,
		waist="Eschan Stone",
		legs=gear.MerlinicShalwar.MB,
		feet=gear.MerlinicCrackows.MAB}

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Niobid Strap",ammo="Pemphredo Tathlum",ear1="Barkaro. Earring",hands=gear.AmalricGages.A,back=gear.jsecapes.amb.blm.mab,feet=gear.MerlinicCrackows.MAB})
	sets.midcast['Elemental Magic'].Resistant.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Resistant, {sub="Niobid Strap",ammo="Pemphredo Tathlum",ear1="Barkaro. Earring",hands=gear.AmalricGages.A,back=gear.jsecapes.amb.blm.mab})
	sets.midcast['Elemental Magic'].Fodder.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Fodder, {ammo="Pemphredo Tathlum",ear1="Barkaro. Earring",hands=gear.AmalricGages.A,back=gear.jsecapes.amb.blm.mab,feet=gear.MerlinicCrackows.MAB})
	
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant
		
		-- Minimal damage gear, maximum recast gear for procs.
    sets.midcast['Elemental Magic'].Proc = {
		main=empty, sub=empty,
		ammo="Impatiens",
        head="Nahtirah Hat",
		neck="Loricate Torque +1",
		ear1="Gifted Earring",
		ear2="Loquacious Earring",
        body="Spaekona's Coat +1",
		hands="Hagondes Cuffs +1",
		ring1="Kishar Ring",
		ring2="Prolix Ring",
        back="Swith Cape +1",
		waist="Witful Belt",
		legs="Assid. Pants +1",
		feet="Regal Pumps +1"}
	
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
		main="Chatoyant Staff",
		sub="Oneiros Grip",
		head="Befouled Crown",
		neck="Chrys. Torque",
		ear1="Ethereal Earring",
		ear2="Sanare Earring",
		body="Vrikodara Jupon",
		hands=gear.AmalricGages.A,
		ring1="Defending Ring",
		ring2=gear.ring.regen_right,
		back="Umbra Cape",
		waist="Refoccilation Stone",
		legs="Assid. Pants +1",
		feet="Psycloth Boots"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {
		main={name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Oneiros Grip",
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body=gear.body.mage_idle,
		hands=gear.AmalricGages.A,
		legs=gear.AmalricSlops.A,
		feet="Psycloth Boots",
		neck="Sanctity Necklace",
		waist=gear.waist.mage_idle,
		ear1="Evans Earring",
		ear2="Loquac. Earring",
		ring1="Bifrost Ring",
		ring2="Sangoma Ring",
		back=gear.jsecapes.amb.blm.fc}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {main="Terra's Staff",sub="Oneiros Grip",ammo="Staunch Tathlum",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Hearty Earring",ear2="Etiolation Earring",
        body="Vrikodara Jupon",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Repulse Mantle",waist="Flax Sash",legs="Assid. Pants +1",feet="Mallquis Clogs +1"}
		
    sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque"})
	sets.idle.Regain = set_combine(sets.idle, {--ring2="Karieyh Ring"
	})
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {feet="Hippo. Socks +1"})

	sets.idle.Death = {main=gear.grioavolr_nuke_staff,sub="Niobid Strap",ammo="Staunch Tathlum",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Gifted Earring",ear2="Etiolation Earring",
		body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Umbra Cape",waist="Fucho-no-obi",legs="Assid. Pants +1",feet=gear.merlinic_refresh_feet}

    sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Etiolation Earring",
		body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,ring1="Defending Ring",ring2=gear.ring.regen_right,
		back="Umbra Cape",waist="Flax Sash",legs="Assid. Pants +1",feet=gear.merlinic_refresh_feet}

    -- Defense sets

    sets.defense.PDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Staunch Tathlum",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Hearty Earring",ear2="Etiolation Earring",
        body="Mallquis Saio +1",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Repulse Mantle",waist="Flax Sash",legs="Hagondes Pants +1",feet="Mallquis Clogs +1"}

    sets.defense.MDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Staunch Tathlum",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Hearty Earring",ear2="Etiolation Earring",
        body="Mallquis Saio +1",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Shadow Ring",
        back="Solemnity Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Mallquis Clogs +1"}
		
    sets.defense.MEVA = {main="Terra's Staff",sub="Enki Strap",ammo="Staunch Tathlum",
        head=gear.merlinic_nuke_head,neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Etiolation Earring",
		body="Merlinic Jubbah",hands="Amalric Gages",ring1="Vengeful Ring",ring2="Purity Ring",
        back="Taranus's Cape",waist="Luminary Sash",legs="Hagondes Pants +1",feet=gear.merlinic_nuke_feet}

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	
	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",legs="Shedir Seraweels",feet="Jhakri Pigaches +1"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff['Mana Wall'] = {back="Taranus's Cape",feet="Wicce Sabots +1"}
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Spaekona's Coat +1"}
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {neck="Mizu. Kubikazari",hands=gear.AmalricGages.A,ring1="Mujin Band",ring2="Locus Ring"}
	sets.RecoverBurst = {neck="Mizu. Kubikazari",body="Spaekona's Coat +1",hands=gear.AmalricGages.A,ring1="Mujin Band",ring2="Locus Ring",feet="Jhakri Pigaches +1"}
	
	-- Gear for specific elemental nukes.
	sets.element.Wind = {main="Marin Staff +1"}
	sets.element.Ice = {main="Ngqoqwanb"}
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.element.Earth = {neck="Quanpur Necklace"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Dosis Tathlum",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Sanare Earring",
		body="Vanya Robe",hands=gear.merlinic_refresh_hands,ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Refoccilation Stone",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}

	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 3)
end

function user_job_precast(spell, spellMap, eventArgs)
	if spell.english == "Impact" then
		local abil_recasts = windower.ffxi.get_ability_recasts()

		if abil_recasts[35] == 0 and not buffactive['amnesia'] then
			cancel_spell()
			send_command('@input /ja "Manawell" <me>;wait 1;input /ma Impact '..spell.target.raw..'')
			return
		end
	end
end
function set_lockstyle()
	send_command('wait 2; input /lockstyleset 8')
end

	moving = false
windower.raw_register_event('prerender',function()
    mov.counter = mov.counter + 1;
	if buffactive['Mana Wall'] then
		moving = false
    elseif mov.counter>15 then
        local pl = windower.ffxi.get_mob_by_index(player.index)
        if pl and pl.x and mov.x then
            dist = math.sqrt( (pl.x-mov.x)^2 + (pl.y-mov.y)^2 + (pl.z-mov.z)^2 )
            if dist > 1 and not moving then
                state.Moving.value = true
                send_command('gs c update')
                send_command('gs equip sets.MoveSpeed')
                if world.area:contains("Adoulin") then
                    send_command('gs equip sets.Adoulin')
                end

        moving = true

            elseif dist < 1 and moving then
                state.Moving.value = false
                send_command('gs c update')
                moving = false
            end
        end
        if pl and pl.x then
            mov.x = pl.x
            mov.y = pl.y
            mov.z = pl.z
        end
        mov.counter = 0
    end
end)
