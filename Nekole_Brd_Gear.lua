-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant')
    state.IdleMode:options('Normal','PDT')
	state.Weapons:options('None','Aeneas','DualWeapons','DualSwords','DualNukeWeapons')

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 4
	
	-- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')
    set_lockstyle()
	
	-- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !q gs c weapons NukeWeapons;gs c update')
	send_command('bind ^q gs c weapons Swords;gs c update')

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Weapons sets
	sets.weapons.Aeneas = {main="Aeneas",sub="Genmei Shield"}
	sets.weapons.DualWeapons = {main="Aeneas",sub="Twashtar"}
	sets.weapons.DualSwords = {main="Vampirism",sub="Vampirism"}
	sets.weapons.DualNukeWeapons = {main="Malevolence",sub="Malevolence"}

	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {main="Marin Staff +1",sub="Clerisy Strap +1",ammo="Impatiens",
		head="Nahtirah Hat",neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body=gear.ambuscade.inyanga.body,hands=gear.gendewitha.hands.pdt,ring1="Kishar Ring",ring2="Lebeche Ring",
		back=gear.jsecapes.amb.brd.fc,waist="Witful Belt",legs=gear.ambuscade.ayanmo.legs,feet="Gende. Galosh. +1"}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet=gear.vanya.feet.B})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	
	sets.precast.FC.BardSong = {main=gear.weapons.brd.skill,sub="Ammurapi Shield",range="Gjallarhorn",ammo=empty,
		head=gear.jse.empyrean.brd.head,neck="Aoidos' Matinee",ear1="Aoidos' Earring",ear2="Etiolation Earring",
		body=gear.ambuscade.inyanga.body,hands=gear.gendewitha.hands.pdt,ring1="Kishar Ring",ring2="Defending Ring",
		back=gear.jsecapes.amb.brd.fc,waist="Flume Belt +1",legs=gear.ambuscade.ayanmo.legs,feet=gear.TelchinePigaches.Song}
		
	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC['Magic Finale'] = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC['Horde Lullaby'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Horde Lullaby'].Resistant = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC['Horde Lullaby'].AoE = set_combine(sets.precast.FC.BardSong,{range="Daurdabla"})
	sets.precast.FC['Horde Lullaby II'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Horde Lullaby II'].Resistant = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC['Horde Lullaby II'].AoE = set_combine(sets.precast.FC.BardSong,{range="Daurdabla"})	
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong, {range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong, {range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet=gear.jse.relic.brd.feet}
	sets.precast.JA.Troubadour = {body=gear.jse.relic.brd.body}
	sets.precast.JA['Soul Voice'] = {legs=gear.jse.relic.brd.legs}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {range=gear.range.ws,ammo=empty,
		head=gear.ambuscade.ayanmo.head,neck="Bard's Charm +1",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body=gear.ambuscade.ayanmo.body,hands=gear.ambuscade.ayanmo.hands,ring1="Shukuyu Ring",ring2="Ilabrat Ring",
		back=gear.jsecapes.amb.brd.ws,waist="Grunfeld Rope",legs="Jokushu Haidate",feet=gear.ambuscade.ayanmo.feet}
		
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {neck="Fotia Gorget", waist="Fotia Belt"})
    sets.precast.WS['Rudras Storm'] = set_combine(sets.precast.WS)
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {neck="Fotia Gorget", waist="Fotia Belt"})
    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS)
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}
	sets.AccMaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {main="Marin Staff +1",sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Nahtirah Hat",neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body=gear.ambuscade.inyanga.body,hands=gear.gendewitha.hands.pdt,ring1="Kishar Ring",ring2="Lebeche Ring",
		back=gear.jsecapes.amb.brd.fc,waist="Witful Belt",legs=gear.ambuscade.ayanmo.legs,feet="Gende. Galosh. +1"}

	-- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.	
	sets.midcast.Ballad = {legs=gear.jse.empyrean.brd.legs}
	sets.midcast.Lullaby = {hands=gear.jse.artifact.brd.hands}
	sets.midcast['Horde Lullaby'] = {range="Marsyas"}
	sets.midcast['Horde Lullaby'].Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby'].AoE = {range="Daurdabla"}
	sets.midcast['Horde Lullaby II'] = {range="Marsyas"}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby II'].AoE = {range="Daurdabla"}
	sets.midcast.Madrigal = {head=gear.jse.empyrean.brd.head,gear.jsecapes.amb.brd.fc}
	sets.midcast.Paeon = {}
	sets.midcast.March = {hands=gear.jse.empyrean.brd.hands}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{hands="Fili Manchettes +1",range="Marsyas"})
	sets.midcast.Minuet = {body=gear.jse.empyrean.brd.body}
	sets.midcast.Minne = {}
	sets.midcast.Carol = {range="Daurdabla"}
	sets.midcast["Sentinel's Scherzo"] = {feet=gear.jse.empyrean.brd.feet} 
	sets.midcast['Magic Finale'] = {neck="Sanctity Necklace",waist="Luminary Sash",legs=gear.jse.empyrean.brd.legs,range="Gjallarhorn"}
	sets.midcast.Mazurka = {range="Marsyas"}
	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {main=gear.weapons.brd.skill,sub="Ammurapi Shield",range="Gjallarhorn",ammo=empty,
		head=gear.jse.empyrean.brd.head,neck="Moonbow Whistle +1",ear1="Etiolation Earring",ear2="Aoidos' Earring",
		body=gear.jse.empyrean.brd.body,hands=gear.jse.empyrean.brd.hands,ring1=gear.ring.ms_left,ring2=gear.ring.ms_right,
		back=gear.jsecapes.amb.brd.fc,waist="Flume Belt +1",legs=gear.ambuscade.inyanga.legs,feet=gear.jse.artifact.brd.feet}
		
	sets.midcast.SongEffect.DW = {}

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {main="Daybreak",sub="Ammurapi Shield",range="Gjallarhorn",ammo=empty,
		head=gear.ambuscade.ayanmo.head,neck="Moonbow Whistle +1",ear1="Regal Earring",ear2="Digni. Earring",
		body=gear.jse.empyrean.brd.body,hands=gear.ambuscade.inyanga.hands,ring1=gear.ring.ms_left,ring2=gear.ring.ms_right,
		back=gear.jsecapes.amb.brd.fc,waist="Luminary Sash",legs=gear.ambuscade.inyanga.legs,feet=gear.jse.relic.brd.feet}

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.ResistantSongDebuff = {main=gear.weapons.brd.skill,sub="Ammurapi Shield",range="Gjallarhorn",ammo=empty,
		head=gear.ambuscade.ayanmo.head,neck="Moonbow Whistle +1",ear1="Regal Earring",ear2="Digni. Earring",
		body=gear.jse.empyrean.brd.body,hands=gear.ambuscade.inyanga.hands,ring1=gear.ring.ms_left,ring2=gear.ring.ms_right,
		back=gear.jsecapes.amb.brd.fc,waist="Luminary Sash",legs=gear.ambuscade.inyanga.legs,feet=gear.jse.relic.brd.feet}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {main=gear.weapons.brd.skill,sub="Ammurapi Shield",range="Daurdabla",ammo=empty,
		head=gear.jse.empyrean.brd.head,neck="Aoidos' Matinee",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body=gear.ambuscade.inyanga.body,hands="Gendewitha Gages +1",ring1="Kishar Ring",ring2="Prolix Ring",
		back=gear.jsecapes.amb.brd.fc,waist="Witful Belt",legs=gear.jse.empyrean.brd.legs,feet=gear.ambuscade.ayanmo.feet}

	-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	sets.midcast.Cure = {main="Serenity",sub="Curatio Grip",ammo="Pemphredo Tathlum",
        head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Mendi. Earring",
        body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Weather. Ring",ring2="Sirona's Ring",
        back=gear.jsecapes.amb.brd.fc,waist="Luminary Sash",legs="Gyve Trousers",feet="Kaykaus Boots"}
		
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
		
	sets.midcast['Enhancing Magic'] = {main="Serenity",sub="Fulcio Grip",ammo="Hasty Pinion +1",
		head=gear.TelchineCap.ES,neck="Orunmila's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body=gear.TelchineChasuble.Enh,hands=gear.TelchineGloves.Enh,ring1=gear.ring.ms_left,ring2=gear.ring.ms_right,
		back=gear.jsecapes.amb.brd.fc,waist="Witful Belt",legs=gear.TelchineBraconi.ES,feet=gear.TelchinePigaches.ES}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash"})
		
	sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Chironic Doublet",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Sekhmet Corset",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
		
	sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Chironic Doublet",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Yamabuki-no-Obi",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",
		ring1="Haoma's Ring",ring2="Haoma's Ring",waist="Witful Belt"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {sub="Clemency Grip"})

	-- Resting sets
	sets.resting = {}
	
	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {main="Daybreak",sub="Ammurapi Shield",range=gear.range.idle,
		head=gear.ambuscade.inyanga.head,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body=gear.ambuscade.inyanga.body,hands=gear.ambuscade.inyanga.hands,ring1="Defending Ring",ring2="Inyanga Ring",
		back="Moonbeam Cape",waist="Flume Belt +1",legs=gear.jse.relic.brd.legs,feet=gear.jse.empyrean.brd.feet}

	sets.idle.PDT = {main="Terra's Staff",sub="Oneiros Grip",ammo="Staunch Tathlum",
		head=empty,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Respite Cloak",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Umbra Cape",waist="Flume Belt +1",legs="Assid. Pants +1",feet=gear.jse.empyrean.brd.feet}
	
	-- Defense sets

	sets.defense.PDT = {main="Terra's Staff", sub="Umbra Strap",ammo="Staunch Tathlum",
		head=empty,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Respite Cloak",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Umbra Cape",waist="Flume Belt +1",legs="Assid. Pants +1",feet=gear.jse.empyrean.brd.feet}

	sets.defense.MDT = {main="Terra's Staff", sub="Umbra Strap",ammo="Staunch Tathlum",
		head=empty,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Respite Cloak",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Umbra Cape",waist="Flume Belt +1",legs="Assid. Pants +1",feet=gear.jse.empyrean.brd.feet}

	sets.Kiting = {feet=gear.jse.empyrean.brd.feet}

	
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {main="Aeneas",sub="Genmei Shield",range=gear.range.ws,ammo=empty,
		head=gear.ambuscade.ayanmo.head,neck="Bard's Charm +1",ear1="Cessance Earring",ear2="Telos Earring",
		body=gear.ambuscade.ayanmo.body,hands=gear.ambuscade.ayanmo.hands,ring1="Hetairoi Ring",ring2="Ilabrat Ring",
		back=gear.jsecapes.amb.brd.ws,waist="Windbuffet Belt +1",legs=gear.ambuscade.ayanmo.legs,feet="Battlecast Gaiters"}
	sets.engaged.Acc = {main="Aeneas",sub="Genmei Shield",range=gear.range.ws,ammo=empty,
		head=gear.ambuscade.ayanmo.head,neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
		body=gear.ambuscade.ayanmo.body,hands=gear.ambuscade.ayanmo.hands,ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
		back=gear.jsecapes.amb.brd.ws,waist="Dynamic Belt +1",legs=gear.ambuscade.ayanmo.legs,feet="Aya. Gambieras +1"}
	sets.engaged.DW = {main="Aeneas",sub="Twashtar",range=gear.range.ws,ammo=empty,
		head=gear.ambuscade.ayanmo.head,neck="Bard's Charm +1",ear1="Suppanomimi",ear2="Telos Earring",
		body=gear.ambuscade.ayanmo.body,hands=gear.ambuscade.ayanmo.hands,ring1="Hetairoi Ring",ring2="Ilabrat Ring",
		back=gear.jsecapes.amb.brd.ws,waist="Reiki Yotai",legs=gear.ambuscade.ayanmo.legs,feet="Battlecast Gaiters"}
	sets.engaged.DW.Acc = {main="Aeneas",sub="Twashtar",range=gear.range.ws,ammo=empty,
		head=gear.ambuscade.ayanmo.head,neck="Combatant's Torque",ear1="Suppanomimi",ear2="Telos Earring",
		body=gear.ambuscade.ayanmo.body,hands=gear.ambuscade.ayanmo.hands,ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
		back=gear.jsecapes.amb.brd.ws,waist="Reiki Yotai",legs=gear.ambuscade.ayanmo.legs,feet="Battlecast Gaiters"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 12)
end
function set_lockstyle()
	send_command('wait 2; input /lockstyleset 2')
end