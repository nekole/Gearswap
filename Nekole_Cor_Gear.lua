-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal', 'Acc','Proc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
	state.Weapons:options('Default','DualWeapons','SavageWeapons','DualRangedWeapons','LeadenWeapons','None')
	state.CompensatorMode:options('300','1000','Never','Always')

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Orichalc. Bullet" --For MAB WS, do not put single-use bullets here.
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15
	
	set_lockstyle()
--	gear.tp_ranger_jse_back = {}
--	gear.snapshot_jse_back = {name="Camulus's Mantle",augments={'"Snapshot"+10',}}
--	gear.tp_jse_back = {name="Camulus's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
--	gear.ranger_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
--	gear.magic_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
--	gear.str_wsd_jse_back = {name="Camulus's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

    -- Additional local binds
	send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c elemental quickdraw')
	
	send_command('bind ^backspace input /ja "Double-up" <me>')
	send_command('bind @backspace input /ja "Snake Eye" <me>')
	send_command('bind !backspace input /ja "Fold" <me>')
	send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')
	
	send_command('bind ^\\\\ input /ja "Random Deal" <me>')
    send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	send_command('bind @f7 gs c toggle RngHelper')

	send_command('bind !r gs c weapons SingleWeapon;gs c update')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons DualRangedWeapons;gs c update')
	send_command('bind !q gs c weapons SavageWeapons;gs c update')
	send_command('bind @pause roller roll')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Precast sets to enhance JAs
	
	sets.precast.JA['Triple Shot'] = {body=gear.jse.empyrean.cor.body}
    sets.precast.JA['Snake Eye'] = {legs=gear.jse.relic.cor.legs}
    sets.precast.JA['Wild Card'] = {feet=gear.jse.relic.cor.feet}
    sets.precast.JA['Random Deal'] = {body=gear.jse.relic.cor.body}
    sets.precast.FoldDoubleBust = {hands=gear.jse.relic.cor.hands}
    
    sets.precast.CorsairRoll = {range="Compensator",
        head=gear.jse.relic.cor.head,neck="Regal Necklace",ear1="Etiolation Earring",ear2="Sanare Earring",
        body=gear.jse.relic.cor.body,hands=gear.jse.empyrean.cor.hands,ring1="Defending Ring",ring2="Ilabrat Ring",
        back=gear.jsecapes.amb.cor.tp,waist="Flume Belt +1",legs="Desultor Tassets",feet=gear.jse.relic.cor.feet}
		
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs=gear.jse.empyrean.cor.legs})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet=gear.jse.empyrean.cor.feet})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head=gear.jse.empyrean.cor.head})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body=gear.jse.empyrean.cor.body})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands=gear.jse.empyrean.cor.hands})
    
    sets.precast.CorsairShot = {ammo=gear.QDbullet,
        head=gear.herculean_nuke_head,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Ilabrat Ring",
        back=gear.jsecapes.amb.cor.wsd,waist="Eschan Stone",legs=gear.ambuscade.mummu.legs,feet=gear.jse.empyrean.cor.feet}
	
    sets.precast.CorsairShot.Proc = {ammo=gear.RAbullet,
        head="Wh. Rarab Cap +1",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
        body="Emet Harness +1",hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",ring2="Ilabrat Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs=gear.carmine.legs.D,feet=gear.jse.empyrean.cor.feet}

    sets.precast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
        head=gear.CarmineMask.D,neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Telos Earring",
        body=gear.ambuscade.mummu.body,hands="Leyline Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
        back=gear.jsecapes.amb.cor.wsd,waist="Eschan Stone",legs=gear.ambuscade.mummu.legs,feet=gear.ambuscade.mummu.feet}

    sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {feet=gear.jse.empyrean.cor.feet})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head=gear.CarmineMask.D,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}
		
	sets.Self_Waltz = {head=gear.ambuscade.mummu.head,body="Passion Jacket",ring1="Asklepian Ring"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        head=gear.CarmineMask.D,neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Rawhide Trousers",feet=gear.carmine.feet.D}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear2="Mendi. Earring"})

    sets.precast.RA = {ammo=gear.RAbullet,
        head=gear.jse.empyrean.cor.head,
        body=gear.jse.artifact.cor.body,hands=gear.carmine.hands.D,
        back=gear.snapshot_jse_back,waist="Impulse Belt",legs=gear.jse.artifact.cor.legs,feet=gear.ambuscade.meghanada.feet}
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head=gear.ambuscade.meghanada.head,neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Telos Earring",
        body=gear.jse.artifact.cor.body,hands=gear.ambuscade.meghanada.hands,ring1="Regal Ring",ring2="Ifrit Ring +1",
        back=gear.str_wsd_jse_back,waist="Fotia Belt",legs=gear.ambuscade.meghanada.legs,feet=gear.ambuscade.meghanada.feet}
		
    sets.precast.WS.Acc = {
        head=gear.CarmineMask.D,neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
        body=gear.ambuscade.meghanada.body,hands=gear.ambuscade.meghanada.hands,ring1="Regal Ring",ring2="Ilabrat Ring",
        back=gear.str_wsd_jse_back,waist="Grunfeld Rope",legs=gear.carmine.legs.D,feet=gear.HerculeanBoots.WS}		
		
    sets.precast.WS.Proc = {
        head=gear.CarmineMask.D,neck="Combatant's Torque",ear1="Digni. Earring",ear2="Zennaroi Earring",
        body=gear.ambuscade.mummu.body,hands="Floral Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.jsecapes.amb.cor.tp,waist="Olseni Belt",legs=gear.carmine.legs.D,feet=gear.HerculeanBoots.WS}
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {head=gear.CarmineMask.D,ring2="Rufescent Ring",legs=gear.carmine.legs.D,feet=gear.carmine.feet.D})
	
	sets.precast.WS['Savage Blade'] = {ammo=gear.WSbullet,
        head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body=gear.jse.artifact.cor.body,hands=gear.ambuscade.meghanada.hands,ring1="Regal Ring",ring2="Ifrit Ring +1",
        back=gear.str_wsd_jse_back,waist="Grunfeld Rope",legs=gear.herculean_wsd_legs,feet=gear.herculean_wsd_feet}

    sets.precast.WS['Savage Blade'].Acc = {ammo=gear.WSbullet,
        head=gear.CarmineMask.D,neck="Caro Necklace",ear1="Moonshade Earring",ear2="Telos Earring",
        body=gear.ambuscade.meghanada.body,hands=gear.ambuscade.meghanada.hands,ring1="Regal Ring",ring2="Rufescent Ring",
        back=gear.str_wsd_jse_back,waist="Grunfeld Rope",legs=gear.carmine.legs.D,feet=gear.herculean_wsd_feet}
	
    sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet,
        head=gear.ambuscade.meghanada.head,neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Telos Earring",
        body=gear.jse.artifact.cor.body,hands=gear.ambuscade.meghanada.hands,ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.jsecapes.amb.cor.wsd,waist="Fotia Belt",legs=gear.ambuscade.meghanada.legs,feet=gear.ambuscade.meghanada.feet}

    sets.precast.WS['Last Stand'].Acc = {ammo=gear.WSbullet,
        head=gear.ambuscade.meghanada.head,neck="Iskur Gorget",ear1="Moonshade Earring",ear2="Telos Earring",
        body=gear.jse.artifact.cor.body,hands=gear.ambuscade.meghanada.hands,ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.jsecapes.amb.cor.wsd,waist="Fotia Belt",legs=gear.ambuscade.meghanada.legs,feet=gear.ambuscade.meghanada.feet}
		
    sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Detonator'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Slug Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Slug Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Numbing Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Numbing Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Sniper Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Sniper Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Split Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Split Shot'].Acc = sets.precast.WS['Last Stand'].Acc
	
    sets.precast.WS['Leaden Salute'] = {ammo=gear.MAbullet,
        head="Pixie Hairpin +1",neck="Baetyl Pendant",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body=gear.jse.artifact.cor.body,hands=gear.carmine.hands.D,ring1="Dingir Ring",ring2="Archon Ring",
        back=gear.jsecapes.amb.cor.mwsd,waist="Eschan Stone",legs=gear.jse.artifact.cor.legs,feet=gear.herculean_nuke_feet}

    sets.precast.WS['Leaden Salute'].Acc = {ammo=gear.MAbullet,
        head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body=gear.jse.artifact.cor.body,hands="Leyline Gloves",ring1="Dingir Ring",ring2="Archon Ring",
        back=gear.jsecapes.amb.cor.mwsd,waist="Eschan Stone",legs=gear.jse.artifact.cor.legs,feet=gear.herculean_nuke_feet}

    sets.precast.WS['Wildfire'] = {ammo=gear.MAbullet,
        head=gear.herculean_nuke_head,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body=gear.jse.artifact.cor.body,hands=gear.carmine.hands.D,ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.jsecapes.amb.cor.mwsd,waist="Eschan Stone",legs=gear.jse.artifact.cor.legs,feet=gear.herculean_nuke_feet}

    sets.precast.WS['Wildfire'].Acc = {ammo=gear.MAbullet,
        head=gear.herculean_nuke_head,neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
        body=gear.jse.artifact.cor.body,hands="Leyline Gloves",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.jsecapes.amb.cor.mwsd,waist="Eschan Stone",legs=gear.jse.artifact.cor.legs,feet=gear.herculean_nuke_feet}
		
    sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
    sets.precast.WS['Hot Shot'].Acc = sets.precast.WS['Wildfire'].Acc
		
		--Because omen skillchains.
    sets.precast.WS['Burning Blade'] = {ammo=gear.RAbullet,
        head=gear.ambuscade.meghanada.head,neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
        body=gear.ambuscade.meghanada.body,hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",ring2="Ilabrat Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs=gear.ambuscade.meghanada.legs,feet=gear.ambuscade.meghanada.feet}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
        
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head=gear.CarmineMask.D,neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Rawhide Trousers",feet=gear.carmine.feet.D}
        
    -- Specific spells

	sets.midcast.Cure = {
        head=gear.CarmineMask.D,neck="Phalaina Locket",ear1="Enchntr. Earring +1",ear2="Mendi. Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Janniston Ring",ring2="Lebeche Ring",
        back="Solemnity Cape",waist="Flume Belt +1",legs=gear.carmine.legs.D,feet=gear.carmine.feet.D}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
        head=gear.ambuscade.meghanada.head,neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body=gear.jse.artifact.cor.body,hands=gear.carmine.hands.D,ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.jsecapes.amb.cor.wsd,waist="Yemaya Belt",legs=gear.AdhemarKecks.C,feet=gear.ambuscade.meghanada.feet}

    sets.midcast.RA.Acc = {ammo=gear.RAbullet,
        head=gear.ambuscade.meghanada.head,neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body=gear.jse.artifact.cor.body,hands=gear.ambuscade.meghanada.hands,ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.jsecapes.amb.cor.wsd,waist="Yemaya Belt",legs=gear.ambuscade.meghanada.legs,feet=gear.ambuscade.meghanada.feet}
		
	sets.buff['Triple Shot'] = {body=gear.jse.empyrean.cor.body}
    
    -- Sets to return to when not performing an action.
	
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {ammo=gear.RAbullet,range="Fomalhaut",
        head=gear.ambuscade.meghanada.head,neck="Regal Necklace",ear1="Genmei Earring",ear2="Sanare Earring",
        body=gear.ambuscade.meghanada.body,hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",ring2="Ilabrat Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs=gear.carmine.legs.D,feet=gear.jse.relic.cor.feet}
		
    sets.idle.Refresh = {ammo=gear.RAbullet,range="Fomalhaut",
        head="Rawhide Mask",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Ethereal Earring",
        body="Mekosu. Harness",hands=gear.herculean_refresh_hands,ring1="Defending Ring",ring2="Ilabrat Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Rawhide Trousers",feet=gear.jse.relic.cor.feet}
    
    -- Defense sets
    sets.defense.PDT = {ammo=gear.RAbullet,
        head=gear.ambuscade.meghanada.head,neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Sanare Earring",
        body=gear.ambuscade.meghanada.body,hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",ring2="Ilabrat Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs=gear.ambuscade.meghanada.legs,feet=gear.jse.relic.cor.feet}

    sets.defense.MDT = {ammo=gear.RAbullet,
        head=gear.ambuscade.meghanada.head,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body=gear.ambuscade.meghanada.body,hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",ring2="Ilabrat Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs=gear.ambuscade.meghanada.legs,feet="Ahosi Leggings"}
		
    sets.defense.MEVA = {ammo=gear.RAbullet,
        head=gear.ambuscade.meghanada.head,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body=gear.ambuscade.meghanada.body,hands=gear.HerculeanGloves.PDT,ring1="Defending Ring",ring2="Ilabrat Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs=gear.ambuscade.meghanada.legs,feet="Ahosi Leggings"}

    sets.Kiting = {legs=gear.carmine.legs.D}
	
	sets.weapons.Default = {main="Fettering Blade",sub="Nusku Shield",range="Fomalhaut"}
	sets.weapons.DualWeapons = {main="Fettering Blade",sub="Blurred Knife +1",range="Fomalhaut"}
	sets.weapons.RollMeleeWeapons = {main="Hep. Sapara +1",sub="Blurred Knife +1",range="Compensator"}
	sets.weapons.RollRangedWeapons = {main="Fettering Blade",sub="Kustawi +1",range="Compensator"}
	sets.weapons.SavageWeapons = {main="Hep. Sapara +1",sub="Blurred Knife +1",range="Ataktos"}
	sets.weapons.DualRangedWeapons = {main="Fettering Blade",sub="Kustawi +1"}
	sets.weapons.LeadenWeapons = {main="Fettering Blade",sub="Atoyac",range="Fomalhaut"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body=gear.AdhemarJacket.Bplus,hands="Floral Gauntlets",waist="Reiki Yotai"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		head="Dampening Tam",neck="Iskur Gorget",ear1="Cessance Earring",ear2="Brutal Earring",
		body=gear.ambuscade.meghanada.body,hands=gear.AdhemarHands.B,ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.jsecapes.amb.cor.tp,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.HerculeanBoots.TA}
    
    sets.engaged.Acc = {
		head=gear.CarmineMask.D,neck="Combatant's Torque",ear1="Cessance Earring",ear2="Telos Earring",
		body=gear.ambuscade.meghanada.body,hands=gear.AdhemarHands.B,ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.jsecapes.amb.cor.tp,waist="Olseni Belt",legs=gear.carmine.legs.D,feet=gear.HerculeanBoots.TA}

    sets.engaged.DW = {
		head="Dampening Tam",neck="Iskur Gorget",ear1="Cessance Earring",ear2="Brutal Earring",
		body=gear.AdhemarJacket.Bplus,hands=gear.AdhemarHands.B,ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.jsecapes.amb.cor.tp,waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.HerculeanBoots.TA}
    
    sets.engaged.DW.Acc = {
		head=gear.CarmineMask.D,neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
		body=gear.ambuscade.meghanada.body,hands="Floral Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back=gear.jsecapes.amb.cor.tp,waist="Olseni Belt",legs=gear.carmine.legs.D,feet=gear.HerculeanBoots.TA}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(2, 17)
    elseif player.sub_job == 'DNC' then
		set_macro_page(1, 17)
    elseif player.sub_job == 'RNG' then
        set_macro_page(9, 17)
    else
        set_macro_page(1, 17)
    end   
end
function set_lockstyle()
	send_command('wait 2; input /lockstyleset 14')
end