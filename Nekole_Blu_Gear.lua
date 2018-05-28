function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Fodder','Normal','MinAcc','SomeAcc','Acc','HighAcc','FullAcc')
	state.HybridMode:options('Normal','DTLite','PDT','MDT')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','HighAcc','FullAcc','Fodder')
    state.CastingMode:options('Normal','Resistant','Fodder')
    state.IdleMode:options('Normal','Sphere','PDT','DTHippo')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Tizalmace','Sequence','None','Almace','MagicWeapons','MeleeClubs','MaccWeapons','HybridWeapons')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'MP','SuppaBrutal', 'DWEarrings','DWMax'}
	
--	gear.da_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
--	gear.stp_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
--	gear.crit_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
--	gear.wsd_jse_back = {name="Rosmerta's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
--	gear.mab_jse_back = {name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	
	gear.obi_cure_waist = "Luminary Sash"
	gear.obi_nuke_waist = "Eschan Stone"
	set_lockstyle()
	
	-- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
	send_command('bind @` input /ja "Efflux" <me>')
	send_command('bind !` input /ja "Burst Affinity" <me>')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind ^backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Mighty Guard" <me>')
	send_command('bind !backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Carcharian Verve" <me>')
	send_command('bind @backspace input /ja "Convergence" <me>')
    send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @f10 gs c toggle LearningMode')
	send_command('bind ^@!` gs c cycle MagicBurstMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !@^f7 gs c toggle AutoWSMode')
	send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons Almace;gs c update')
	send_command('bind !q gs c weapons HybridWeapons;gs c update')

	update_combat_form()
	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.buff['Burst Affinity'] = {hands=gear.AmalricGages.D,back="Aurist's Cape +1",ring1="Mujin Band",ring2="Locus Ring",feet=gear.jse.empyrean.blu.feet}
	sets.buff['Chain Affinity'] = {head=gear.jse.empyrean.blu.head, feet=gear.jse.artifact.blu.feet}
	sets.buff.Convergence = {head=gear.jse.relic.blu.head}
	sets.buff.Diffusion = {feet=gear.jse.relic.blu.feet}
	sets.buff.Enchainment = {body=gear.jse.relic.blu.body}
	sets.buff.Efflux = {back=gear.da_jse_back,legs=gear.jse.relic.blu.legs}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	sets.HPDown = {
		head=gear.head.dark_magic,
		ear1="Mendicant's Earring",
		ear2="Evans Earring",
		body=gear.ambuscade.jhakri.body,
		hands=gear.ambuscade.jhakri.hands,
		ring1="Mephitas's Ring +1",
		ring2="Mephitas's Ring",
		back="Swith Cape +1",
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.ambuscade.jhakri.feet}
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {hands=gear.jse.relic.blu.hands}


	-- Waltz set (chr and vit)
--	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
--	sets.precast.Waltz['Healing Waltz'] = {}
	
--	sets.precast.Step = {
--					ammo="Falcon Eye",
--					head="Dampening Tam",neck="Combatant's Torque",ear1="Regal Earring",ear2="Telos Earring",
--					body=gear.jse.artifact.blu.body,hands=gear.jse.artifact.blu.hands,ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
--					back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.HerculeanBoots.WS
--}
				
--	sets.precast.Flourish1 = {
--					ammo="Falcon Eye",
--			       head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Digni. Earring",
 --                  body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring2="Stikini Ring",
--			       back=gear.jsecapes.blu,waist="Olseni Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"
--}

	-- Fast cast sets for spells

	sets.precast.FC = {
		main="Vampirism",
		sub="Vampirism",
		ammo=gear.ammo.fc,
        head=gear.CarmineMask.D,
		neck="Orunmila's Torque",
		ear1=gear.ears.fc_left,
        ear2=gear.ears.fc_right,
        body="Vrikodara Jupon",
        hands=gear.hands.melee_fc,
        ring1=gear.ring.fc_left,
        ring2=gear.ring.fc_right,
        back=gear.back.fc,
        waist=gear.waist.fc,
        legs=gear.LengoPants.FC,
        feet=gear.carmine.feet.D}
		
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
--	body="Passion Jacket"
	})
		
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body=gear.jse.empyrean.blu.body})

	   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Ginsen",
		head=gear.AdhemarBonnet.B,
		neck=gear.neck.ws,
		ear1="Cessance Earring",
		ear2="Brutal Earring",
        body=gear.AdhemarJacket.Bplus,
		hands=gear.ambuscade.jhakri.hands,
		ring2="Apate Ring",
        ring1="Epona's Ring",
        back=gear.jsecapes.amb.blu.ws,
        waist=gear.waist.ws,
		legs=gear.SamnuhaTights.TP,
		feet="Thereoid Greaves"}
-- gear.herculean_ta_feet = {name="Herculean Boots",augments={'Accuracy+19 Attack+19','"Triple Atk."+4','DEX+5','Accuracy+8','Attack+11',}}

	sets.precast.WS.SomeAcc = {
		ammo="Ginsen",
		head="Dampening Tam",
		neck=gear.neck.ws,
		ear1="Cessance Earring",
		ear2="Brutal Earring",
        body=gear.AdhemarJacket.Bplus,
		hands=gear.ambuscade.jhakri.hands,
		ring2="Apate Ring",
        ring1="Epona's Ring",
        back=gear.jsecapes.amb.blu.ws,
        waist=gear.waist.ws,
		legs=gear.SamnuhaTights.TP,
		feet="Thereoid Greaves"}
				  
	sets.precast.WS.Acc = {
		ammo="Falcon Eye",
		head=gear.CarmineMask.B,
		neck=gear.neck.ws,
		ear1="Regal Earring",
		ear2="Telos Earring",
		body=gear.jse.artifact.blu.body,
		hands=gear.jse.artifact.blu.hands,
		ring2="Ilabrat Ring",
		ring1="Epona's Ring",
		back=gear.jsecapes.amb.blu.ws,
		waist=gear.waist.ws,
		legs=gear.carmine.legs.D,
		feet=gear.HerculeanBoots.WS}
				  
	sets.precast.WS.HighAcc = {
		ammo="Falcon Eye",
		head=gear.CarmineMask.B,
		neck=gear.neck.ws,
		ear1="Regal Earring",
		ear2="Telos Earring",
		body=gear.jse.artifact.blu.body,
		hands=gear.jse.artifact.blu.hands,
		ring1="Ilabrat Ring",
		ring2="Ramuh Ring +1",
		back=gear.jsecapes.amb.blu.ws,
		waist=gear.waist.ws,
		legs=gear.carmine.legs.D,
		feet=gear.HerculeanBoots.WS}
				  
	sets.precast.WS.FullAcc = {
		ammo="Falcon Eye",
		head=gear.CarmineMask.B,
		neck="Combatant's Torque",
		ear1="Regal Earring",
		ear2="Telos Earring",
		body=gear.jse.artifact.blu.body,
		hands=gear.jse.artifact.blu.hands,
		ring1="Ramuh Ring +1",
		ring2="Ramuh Ring +1",
		back=gear.jsecapes.amb.blu.ws,
		waist="Olseni Belt",
		legs=gear.carmine.legs.D,
		feet=gear.HerculeanBoots.WS}
-- gear.herculean_acc_feet = {name="Herculean Boots",augments={'Accuracy+25 Attack+25','Crit. hit damage +1%','DEX+10','Accuracy+14','Attack+1',}}
		
	sets.precast.WS.Fodder = {
		ammo="Ginsen",
		head="Lilitu Headpiece",
		neck="Fotia Gorget",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
        body=gear.AdhemarJacket.Bplus,
		hands=gear.ambuscade.jhakri.hands,
		ring1="Epona's Ring",
		ring2="Apate Ring",
		back=gear.jsecapes.amb.blu.ws,
		waist="Fotia Belt",
		legs="Samnuha Tights",
		feet=gear.HerculeanBoots.WS}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		ammo="Quartz Tathlum +1",
		head=gear.ambuscade.jhakri.head,
		ear1="Regal Earring",
		body=gear.ambuscade.jhakri.body,
		ring2="Rufescent Ring",
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.ambuscade.jhakri.feet})
	sets.precast.WS['Requiescat'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {
		ammo="Quartz Tathlum +1",
		head=gear.ambuscade.jhakri.head,
		ear1="Regal Earring",
		ear2="Telos Earring",
		body=gear.ambuscade.jhakri.body,
		ring2="Rufescent Ring",
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.ambuscade.jhakri.feet})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {
		ammo="Quartz Tathlum +1",
		head=gear.ambuscade.jhakri.head,
		ear1="Regal Earring",
		ear2="Telos Earring",
		body=gear.ambuscade.jhakri.body,
		ring2="Rufescent Ring",
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.ambuscade.jhakri.feet})
	sets.precast.WS['Requiescat'].HighAcc = set_combine(sets.precast.WS.HighAcc, {ring2="Rufescent Ring",feet="Jhakri Pigaches +2"})
	sets.precast.WS['Requiescat'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS['Requiescat'], {})
	
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {
		ammo="Quartz Tathlum +1",
		head=gear.ambuscade.jhakri.head,
		ear1="Regal Earring",
		body=gear.ambuscade.jhakri.body,
		ring2="Rufescent Ring",
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.ambuscade.jhakri.feet})
	sets.precast.WS['Realmrazer'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {
		ammo="Quartz Tathlum +1",
		head=gear.ambuscade.jhakri.head,
		ear1="Regal Earring",
		ear2="Telos Earring",
		body=gear.ambuscade.jhakri.body,
		ring2="Rufescent Ring",
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.ambuscade.jhakri.feet})
	sets.precast.WS['Realmrazer'].Acc = set_combine(sets.precast.WS.Acc, {
		ammo="Quartz Tathlum +1",
		head=gear.ambuscade.jhakri.head,
		ear1="Regal Earring",
		ear2="Telos Earring",
		body=gear.ambuscade.jhakri.body,
		ring2="Rufescent Ring",
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.ambuscade.jhakri.feet})
	sets.precast.WS['Realmrazer'].HighAcc = set_combine(sets.precast.WS.HighAcc, {ring2="Rufescent Ring",feet="Jhakri Pigaches +2"})
	sets.precast.WS['Realmrazer'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Realmrazer'].Fodder = set_combine(sets.precast.WS['Realmrazer'], {})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
		ammo="Falcon Eye",
		head=gear.AdhemarBonnet.B,
		ear1="Moonshade Earring",
		body="Abnoba Kaftan",
		hands=gear.AdhemarHands.B,
		ring2="Begrudging Ring",
		back=gear.jsecapes.amb.blu.ws,
		feet="Thereoid Greaves"})
	sets.precast.WS['Chant du Cygne'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {
		ammo="Falcon Eye",
		ear1="Moonshade Earring",
		ear2="Cessance Earring",
		body="Abnoba Kaftan",
		hands=gear.AdhemarHands.B,
		ring2="Begrudging Ring",
		back=gear.jsecapes.amb.blu.ws})
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {ear2="Moonshade Earring",ring2="Begrudging Ring",back=gear.jsecapes.amb.blu.ws,legs=gear.carmine.legs.D})
	sets.precast.WS['Chant du Cygne'].HighAcc = set_combine(sets.precast.WS.HighAcc, {})
	sets.precast.WS['Chant du Cygne'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Chant du Cygne'].Fodder = set_combine(sets.precast.WS['Chant du Cygne'], {})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		head="Lilitu Headpiece",
		neck="Caro Necklace",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		body=gear.jse.artifact.blu.body,
		hands=gear.ambuscade.jhakri.hands,
		ring1="Ifrit Ring +1",
		ring2="Rufescent Ring",
		back=gear.jsecapes.amb.blu.ws,
		waist="Grunfeld Rope",
		legs=gear.HerculeanTrousers.WS,
		feet=gear.HerculeanBoots.WS})
	sets.precast.WS['Savage Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {
		head=gear.CarmineMask.D,
		neck="Caro Necklace",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		body=gear.jse.artifact.blu.body,
		hands=gear.ambuscade.jhakri.hands,
		ring1="Ifrit Ring +1",
		ring2="Rufescent Ring",
		back=gear.jsecapes.amb.blu.ws,
		waist="Grunfeld Rope",
		legs=gear.HerculeanTrousers.WS,
		feet=gear.HerculeanBoots.WS})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {
		ear2="Moonshade Earring",
		hands=gear.ambuscade.jhakri.hands,
		back=gear.jsecapes.amb.blu.ws,
		waist="Grunfeld Rope",
		legs=gear.carmine.legs.D,
		feet=gear.HerculeanBoots.WS})
	sets.precast.WS['Savage Blade'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
		ear2="Moonshade Earring",
		hands=gear.ambuscade.jhakri.hands,
		ring1="Rufescent Ring",
		ring2="Ilabrat Ring",
		back=gear.jsecapes.amb.blu.ws,
		waist="Grunfeld Rope",
		feet=gear.HerculeanBoots.WS})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {})
	
	sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Vorpal Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
	sets.precast.WS['Vorpal Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Vorpal Blade'].HighAcc = set_combine(sets.precast.WS.HighAcc, {})
	sets.precast.WS['Vorpal Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Vorpal Blade'].Fodder = set_combine(sets.precast.WS['Vorpal Blade'], {})
	
	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Expiacion'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
	sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Expiacion'].HighAcc = set_combine(sets.precast.WS.HighAcc, {})
	sets.precast.WS['Expiacion'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Expiacion'].Fodder = set_combine(sets.precast.WS['Expiacion'], {})


	sets.precast.WS['Sanguine Blade'] = {}
					 
	sets.precast.WS['Flash Nova'] = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring"}
	sets.precast.AccMaxTP = {ear1="Regal Earring",ear2="Telos Earring"}
	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		ammo="Hasty Pinion +1",
		head=gear.CarmineMask.D,
		ear1="Enchntr. Earring +1",
		ear2="Loquacious Earring",
		body="Vrikodara Jupon",
		hands=gear.Leyline.FC,
		ring1="Kishar Ring",
		ring2="Prolix Ring",
		back="Swith Cape +1",
		waist="Witful Belt",
		legs="Psycloth Lappas",
		feet=gear.carmine.feet.D}
		
	sets.midcast['Blue Magic'] = {}
	
	-- Physical Spells --
	
	sets.midcast['Blue Magic'].Physical = {
		main="Vampirism",
		sub="Vampirism",
		ammo="Mavi Tathlum",
        head="Lilitu Headpiece",
		neck="Caro Necklace",
		ear1="Suppanomimi",
		ear2="Telos Earring",
        body=gear.ambuscade.jhakri.body,
		hands=gear.ambuscade.jhakri.hands,
		ring1="Ifrit Ring +1",
		ring2="Ilabrat Ring",
        back=gear.jsecapes.amb.blu.ws,
		waist="Grunfeld Rope", 
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.HerculeanBoots.TA}

	sets.midcast['Blue Magic'].Physical.Resistant = {
		main="Sequence",
		sub="Almace",
		ammo="Falcon Eye",
		head=gear.ambuscade.jhakri.head,
		neck="Combatant's Torque",
		ear1="Regal Earring",
		ear2="Telos Earring",
	    body=gear.jse.artifact.blu.body,
		hands=gear.jse.artifact.blu.hands,
		ring1=gear.ring.dex1,
		ring2=gear.ring.dex2,
	    back=gear.jsecapes.amb.blu.tp,
		waist="Grunfeld Rope",
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.ambuscade.jhakri.feet}
		
	sets.midcast['Blue Magic'].Physical.Fodder = {
		main="Sequence",
		sub="Almace",
		ammo="Mavi Tathlum",
		head=gear.jse.relic.blu.head,
		neck="Caro Necklace",
		ear1="Suppanomimi",
		ear2="Telos Earring",
		body=gear.jse.artifact.blu.body,
		hands=gear.ambuscade.jhakri.hands,
		ring1="Ifrit Ring +1",
		ring2="Ilabrat Ring",
		back=gear.jsecapes.blu,
		waist="Grunfeld Rope",
		legs=gear.jse.empyrean.blu.legs,
		feet=gear.jse.relic.blu.feet}
		
	sets.midcast['Blue Magic'].PhysicalAcc = {
		main="Sequence",
		sub="Almace",
		ammo="Falcon Eye",
		head=gear.ambuscade.jhakri.head,
		neck="Combatant's Torque",
		ear1="Regal Earring",
		ear2="Telos Earring",
	    body=gear.jse.artifact.blu.body,
		hands=gear.ambuscade.jhakri.hands,
		ring1=gear.ring.dex1,
		ring2="Ilabrat Ring",
	    back=gear.jsecapes.blu,
		waist="Grunfeld Rope",
		legs=gear.ambuscade.jhakri.legs}

	sets.midcast['Blue Magic'].PhysicalAcc.Resistant = set_combine(sets.midcast['Blue Magic'].PhysicalAcc, {})
	sets.midcast['Blue Magic'].PhysicalAcc.Fodder = sets.midcast['Blue Magic'].Fodder
		
	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalStr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalStr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
		ear2=gear.ears.melee_right,
		ring1=gear.ring.dex1,
		ring2=gear.ring.dex2,
		back=gear.jsecapes.amb.blu.ws})
	sets.midcast['Blue Magic'].PhysicalDex.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalDex.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalVit.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalVit.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {
		ring1=gear.ring.agi1,
		ring2=gear.ring.agi2})
	sets.midcast['Blue Magic'].PhysicalAgi.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {
		ear1="Psystorm Earring",
		hands=gear.jse.artifact.blu.hands,
		ring1=gear.ring.int1,
		ring2=gear.ring.int2,
		waist="Wanion Belt",
		back="Toro Cape",
		feet="Battlecast Gaiters"})
	sets.midcast['Blue Magic'].PhysicalInt.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalInt.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {
		ear1="Lifestorm Earring",
		hands=gear.jse.artifact.blu.hands,
		back="Pahtli Cape",
		ring1=gear.ring.mnd1,
		ring2=gear.ring.mnd})
	sets.midcast['Blue Magic'].PhysicalMnd.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalChr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalChr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalHP.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalHP.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})


	-- Magical Spells --
	
	sets.midcast['Blue Magic'].Magical = {
		ammo="Pemphredo Tathlum",
		head=gear.ambuscade.jhakri.head,
		neck="Sanctity Necklace",
		ear1="Regal Earring",
		ear2="Friomisi Earring",
		body=gear.ambuscade.jhakri.body,
		hands=gear.AmalricGages.D,
		ring1=gear.ring.int1,
		ring2=gear.ring.int2,
		back=gear.jsecapes.blu,
		waist="Eschan Stone",
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.ambuscade.jhakri.feet}
					 
	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
		{neck="Sanctity Necklace",hands=gear.ambuscade.jhakri.hands,ring1="Stikini Ring",ring2="Stikini Ring",legs=gear.ambuscade.jhakri.legs,waist="Eschan Stone"})
		
	sets.midcast['Blue Magic'].Magical.Fodder = {
		ammo="Pemphredo Tathlum",
		head=gear.ambuscade.jhakri.head,
		neck="Sanctity Necklace",
		ear1="Regal Earring",
		ear2="Friomisi Earring",
		body=gear.ambuscade.jhakri.body,
		hands=gear.AmalricGages.D,
		ring1=gear.ring.int1,
		ring2=gear.ring.int2,
		back=gear.jsecapes.blu,
		waist="Eschan Stone",
		legs=gear.AmalricSlops.A,
		feet=gear.AmalricNails.A}
	
	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {
		neck="Sanctity Necklace",
		hands=gear.ambuscade.jhakri.hands,
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		legs=gear.ambuscade.jhakri.legs,
		waist="Eschan Stone"})
	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})
	
	sets.midcast['Blue Magic'].MagicAccuracy = {
		main="Iris",
		sub="Iris",
		ammo="Pemphredo Tathlum",
		head=gear.ambuscade.jhakri.head,
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Digni. Earring",
		body=gear.ambuscade.jhakri.body,
		hands=gear.ambuscade.jhakri.hands,
--		hands="Regal Cuffs",
		ring1="Stikini Ring",
		ring1="Stikini Ring",
		back=gear.jsecapes.blu,
		waist="Luminary Sash",
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.ambuscade.jhakri.feet}

	sets.midcast['Enfeebling Magic'] = {
		main="Iris",
		sub="Iris",
		ammo="Pemphredo Tathlum",
		head=gear.ambuscade.jhakri.head,
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Digni. Earring",
		body=gear.ambuscade.jhakri.body,
		hands=gear.ambuscade.jhakri.hands,
--		hands="Regal Cuffs",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back=gear.jsecapes.blu,
		waist="Luminary Sash",
		legs=gear.psycloth.legs.D,
		feet="Skaoi Boots"}

	sets.midcast['Dark Magic'] = {
		main="Iris",
		sub="Iris",
		ammo="Pemphredo Tathlum",
		head=gear.ambuscade.jhakri.head,
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Digni. Earring",
		body=gear.ambuscade.jhakri.body,
		hands=gear.ambuscade.jhakri.hands,
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back=gear.jsecapes.blu,
		waist="Luminary Sash",
		legs=gear.psycloth.legs.D,
		feet="Skaoi Boots"}
					
	sets.midcast['Enhancing Magic'] = {
		main="Vampirism", 
		sub="Vampirism",
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
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head=gear.AmalricCoif.C,waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	sets.midcast['Divine Magic'] = {
		main="Vampirism", 
		sub="Vampirism",
		ammo="Pemphredo Tathlum",
		head=gear.ambuscade.jhakri.head,
		body=gear.ambuscade.jhakri.body,
		hands=gear.ambuscade.jhakri.hands,
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.ambuscade.jhakri.feet,
		neck="Sanctity Necklace",
		ear1="Regal Earring",
		ear2="Digni. Earring",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back=gear.jsecapes.blu,
		waist="Luminary Sash"
}
					
	sets.midcast['Elemental Magic'] = {
		main="Vampirism", 
		sub="Vampirism",
		ammo="Dosis Tathlum",
		head=gear.ambuscade.jhakri.head,
		body=gear.ambuscade.jhakri.body,
		hands=gear.ambuscade.jhakri.hands,
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.ambuscade.jhakri.feet,
		neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
		back=gear.jsecapes.blu,
		waist="Luminary Sash"}

	sets.midcast['Elemental Magic'].Resistant = {
		ammo="Mavi Tathlum",
		ear1="Enchanter Earring +1",
		ear2="Gwati Earring",
		head=gear.CarmineMask.D,
		body=gear.jse.empyrean.blu.body,
		hands=gear.Leyline.FC,
		ring1="Weatherspoon Ring",
		legs=gear.psycloth.legs.D,
		feet=gear.jse.empyrean.blu.feet}
					 
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Fodder
	
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.element.Earth = {neck="Quanpur Necklace"}
	sets.element.Light = {ring2="Weatherspoon Ring"} 
					 
	sets.midcast.Cure = {
		ammo="Pemphredo Tathlum",
		head=gear.CarmineMask.D, 
		body="Vrikodara Jupon", -- 13
		hands=gear.TelchineGloves.CurePot, -- 10
		feet="Medium's Sabots", -- 12
		neck="Incanter's Torque",
		ear1="Calamitous Earring",
		ear2="Mendi. Earring", -- 5
		ring1="Lebeche Ring", -- 3
		ring2="Haoma's Ring",
		back="Solemnity Cape", -- 7
		waist="Bishop's Sash"}
					
	-- Breath Spells --
	
	sets.midcast['Blue Magic'].Breath = {
		ammo="Mavi Tathlum",
        neck="Sanctity Necklace",
		head=gear.jse.relic.blu.head,
		ear1="Regal Earring",
		ear2="Digni. Earring",
		body=gear.jse.artifact.blu.body,
        hands=gear.jse.relic.blu.hands,
		ring1="Kunaji Ring",
		ring2="Meridian Ring",
		back=gear.jsecapes.blu,
		legs=gear.jse.empyrean.blu.legs,
		feet=gear.jse.relic.blu.feet}

	-- Physical Added Effect Spells most notably "Stun" spells --
	
	sets.midcast['Blue Magic'].Stun = {
		main="Iris",
		sub="Iris",
		ammo="Pemphredo Tathlum",
		head=gear.ambuscade.jhakri.head,
		neck="Sanctity Necklace",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Digni. Earring",
        body=gear.ambuscade.jhakri.body,
		hands=gear.ambuscade.jhakri.hands,
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back=gear.jsecapes.blu,
		waist="Luminary Sash",
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.ambuscade.jhakri.feet}
				   
	sets.midcast['Blue Magic'].Stun.Resistant = {
		main="Iris",
		sub="Iris",
		ammo="Falcon Eye",
		head=gear.ambuscade.jhakri.head,
		neck="Sanctity Necklace",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Digni. Earring",
        body=gear.ambuscade.jhakri.body,
		hands=gear.ambuscade.jhakri.hands,
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back=gear.jsecapes.blu,
		waist="Olseni Belt",
		legs=gear.ambuscade.jhakri.legs,
		feet=gear.ambuscade.jhakri.feet}
				   
	sets.midcast['Blue Magic'].Stun.Fodder = sets.midcast['Blue Magic'].Stun

	-- Other Specific Spells --
	
	sets.midcast['Blue Magic']['White Wind'] = {
		ammo="Mavi Tathlum",
		head=gear.CarmineMask.D,
		neck="Phalaina Locket",
		ear1="Gifted Earring",
		ear2="Loquac. Earring",
		body="Vrikodara Jupon",
		hands=gear.TelchineGloves.Enh,
		ring1="Asklepian Ring",
		ring2="Lebeche Ring",
		back=gear.jsecapes.blu,
		waist="Oneiros Belt",
		legs="Gyve Trousers",
		feet="Medium's Sabots"}

	sets.midcast['Blue Magic'].Healing = {
		ammo="Staunch Tathlum",
		head=gear.CarmineMask.D, 
		body="Vrikodara Jupon", -- 13
		hands=gear.TelchineGloves.CurePot, -- 10
		legs=gear.carmine.legs.D,
		feet="Medium's Sabots", -- 12
		neck="Incanter's Torque",
		ear1="Etiolation Earring",
		ear2="Mendi. Earring", -- 5
		ring1="Lebeche Ring", -- 3
		ring2="Haoma's Ring",
		back="Solemnity Cape", -- 7
		waist="Bishop's Sash"}
					
	--Overwrite certain spells with these peices even if the day matches, because of resource inconsistancies.
	sets.NonElementalCure = {back="Tempered Cape +1",waist="Luminary Sash"}

	sets.midcast['Blue Magic'].SkillBasedBuff = {
		main="Iris",
		sub="Iris",
		ammo="Mavi Tathlum",
        head=gear.jse.relic.blu.head,
		neck="Incanter's Torque",
		ear1="Gifted Earring",
		ear2="Loquac. Earring",
        body=gear.jse.artifact.blu.body,
		hands=gear.jse.empyrean.blu.hands,
		ring1=gear.ring.ms_left,
		ring2=gear.ring.ms_right,
        back=gear.jsecapes.blu,
		waist="Witful Belt",
		legs=gear.jse.empyrean.blu.legs,
		feet=gear.jse.relic.blu.feet}

	sets.midcast['Blue Magic'].Buff = {
		main="Vampirism",
		sub="Vampirism",
		ammo="Mavi Tathlum",
        head=gear.jse.relic.blu.head,
		neck="Incanter's Torque",
        body=gear.jse.artifact.blu.body,
		hands=gear.jse.empyrean.blu.hands,
		ring1=gear.ring.ms_left,
		ring2=gear.ring.fc_left,
        back="Aurist's Cape +1",
		waist="Witful Belt",
		legs=gear.jse.empyrean.blu.legs,
		feet=gear.jse.relic.blu.feet}

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {head=gear.AmalricCoif.C,back="Grapevine Cape",waist="Gishdubar Sash"})
	
	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {head=gear.AmalricCoif.C,waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	sets.midcast.Protect = {ring2="Sheltered Ring"}
	sets.midcast.Protectra = {ring2="Sheltered Ring"}
	sets.midcast.Shell = {ring2="Sheltered Ring"}
	sets.midcast.Shellra = {ring2="Sheltered Ring"}
	

	
	
	-- Sets to return to when not performing an action.

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {
		ammo="Mavi Tathlum",
		head=gear.jse.relic.blu.head,
		body=gear.jse.artifact.blu.body,
		hands=gear.jse.artifact.blu.hands,
	    neck="Incanter's Torque",
		back=gear.jsecapes.blu,
		legs=gear.jse.empyrean.blu.legs,
		feet=gear.jse.relic.blu.feet}

	-- Resting sets
	sets.resting = {
		head="Rawhide Mask",
		neck="Loricate Torque +1",
		ear1="Relaxing Earring",
		body=gear.ambuscade.jhakri.body,
        feet="Chelona Boots +1",
		ring1="Sheltered Ring",
		ring2="Paguroidea Ring",
		legs="Lengo Pants"}

	-- Idle sets
	sets.idle = {
        ammo=gear.ammo.dt,
        head=gear.RawhideMask.A,
        neck="Loricate Torque +1",
        ear2=gear.ears.regen,
        ear1="Telos Earring",
        body="Mekosuchinae Harness",
		hands=gear.HerculeanGloves.Ref,
 --       hands="Serpentes Cuffs",
        ring1=gear.ring.regen_left,
        ring2=gear.ring.regen_right,
        back="Moonbeam Cape",
        waist=gear.waist.pdt,
        legs=gear.carmine.legs.D,
--		feet="Serpentes Sabots"}
        feet=gear.HerculeanBoots.Ref}
	
	sets.idle.Sphere = {body="Mekosu. Harness"}

	sets.idle.PDT = {
--	main="Terra's Staff",sub="Umbra Strap",ammo="Staunch Tathlum",
--				head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Genmei Earring",
--		        body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Dark Ring",
--				back="Moonbeam Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet
}
				
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {legs=gear.carmine.legs.D,feet="Hippo. Socks +1"})
				  
	-- Defense sets
	sets.defense.PDT = {
		ammo="Staunch Tathlum",
		head=gear.iuitl.head,
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Sanare Earring",
		body="Onca Suit",
		ring1="Defending Ring",
		ring2="Gelatinous Ring +1",
		back="Umbra Cape",
		waist="Flume Belt +1"}

	sets.defense.MDT = {
		ammo="Demonry Stone",
        head="Telchine Cap",
		neck="Loricate Torque +1",
		ear1="Sanare Earring",
		ear2="Etiolation Earring",
        body=gear.AmalricDoublet.A,
		hands=gear.AmalricGages.D,
		ring1="Defending Ring",
		ring2="Shadow Ring",
        back="Reiki Cloak", --need
		waist="Flume Belt +1",
		legs=gear.AmalricSlops.A,
		feet=gear.AmalricNails.A}
				
    sets.defense.MEVA = {
--	main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum",
 --       head="Amalric Coif",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
--		body="Hashishin Mintan +1",hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
 --       back=gear.mab_jse_back,waist="Luminary Sash",legs="Telchine Braconi",feet="Ahosi Leggings"
 }
				
	sets.defense.NukeLock = sets.midcast['Blue Magic'].Magical

	sets.Kiting = {legs=gear.carmine.legs.D}
	
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
    sets.MP = {waist="Flume Belt +1",ear1="Suppanomimi", ear2="Ethereal Earring"}
    sets.MP_Knockback = {}
	sets.SuppaBrutal = {ear1="Suppanomimi", ear2="Brutal Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body=gear.AdhemarJacket.B,waist="Shetal Stone"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Assault = {ring1="Balrahn's Ring"}
	
	-- Weapons sets	
	sets.weapons.Tizalmace = {main="Sequence",sub="Almace"}
	sets.weapons.MeleeClubs = {main="Nehushtan",sub="Nehushtan"}
	sets.weapons.Almace = {main="Almace",sub="Sequence"}
	sets.weapons.Sequence = {main="Sequence",sub="Almace"}
	sets.weapons.MagicWeapons = {main="Nibiru Cudgel",sub="Nibiru Cudgel"}
	sets.weapons.MaccWeapons = {main="Iris",sub="Iris"}
	sets.weapons.HybridWeapons = {main="Vampirism",sub="Vampirism"}
	
	-- Engaged sets

	
	sets.engaged = {
		ammo="Ginsen",
        head=gear.AdhemarBonnet.B,
        neck="Asperity Necklace",
        ear1="Telos Earring",
        ear2="Suppanomimi",
        body=gear.AdhemarJacket.Bplus,
        hands=gear.AdhemarHands.B,
--		hands=gear.HerculeanGloves.TA,
        ring1="Hetairoi Ring",
		ring2="Epona's Ring",
        back=gear.jsecapes.amb.blu.tp,
        waist=gear.waist.nohaste,
        legs=gear.SamnuhaTights.TP,
        feet=gear.HerculeanBoots.TA}
				
	sets.engaged.AM = {
		ammo="Ginsen",
		head="Dampening Tam",
		neck="Asperity Necklace",
		ear1="Cessance Earring",
		ear2="Telos Earring",
		body=gear.AdhemarJacket.Bplus,
		hands=gear.AdhemarHands.B,
		ring1="Epona's Ring",
		ring2="Petrov Ring",
--		back=gear.stp_jse_back,
		back=gear.jsecapes.amb.blu.tp,
		waist="Windbuffet Belt +1",
		legs=gear.SamnuhaTights.TP,
		feet=gear.HerculeanBoots.TA
}
				
	sets.engaged.MinAcc = {
		ammo="Ginsen",
		head="Dampening Tam",
		neck="Combatant's Torque",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
		body=gear.AdhemarJacket.Bplus,
		hands=gear.AdhemarHands.B,
		ring1="Epona's Ring",
		ring2="Petrov Ring",
		back=gear.jsecapes.amb.blu.tp,
		waist="Windbuffet Belt +1",
		legs=gear.SamnuhaTights.TP,
		feet=gear.HerculeanBoots.TA}
				
	sets.engaged.MinAcc.AM = {
		ammo="Ginsen",
--			    head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Telos Earring",
--			    body=gear.AdhemarJacket.Bplus,hands=gear.AdhemarHands.B,ring1="Epona's Ring",ring2="Petrov Ring",
--			    back=gear.jsecapes.amb.blu.tp,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Carmine Greaves +1"
}
				
	sets.engaged.SomeAcc = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Telos Earring",
				body=gear.AdhemarJacket.Bplus,hands=gear.AdhemarHands.A,ring1="Epona's Ring",ring2="Petrov Ring",
				back=gear.jsecapes.amb.blu.tp,waist="Windbuffet Belt +1",legs="Adhemar Kecks",feet=gear.HerculeanBoots.TA}

	sets.engaged.SomeAcc.AM = {ammo="Ginsen",
			    head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Telos Earring",
			    body=gear.AdhemarJacket.Bplus,hands=gear.AdhemarHands.B,ring1="Epona's Ring",ring2="Ilabrat Ring",
			    back=gear.jsecapes.amb.blu.tp,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Carmine Greaves +1"}
				
	sets.engaged.Acc = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Telos Earring",
				body="Ayanmo Corazza +1",hands=gear.AdhemarHands.A,ring1="Epona's Ring",ring2="Petrov Ring",
				back=gear.da_jse_back,waist="Reiki Yotai",legs="Adhemar Kecks",feet=gear.HerculeanBoots.TA}
				
	sets.engaged.Acc.AM = {ammo="Falcon Eye",
			    head="Dampening Tam",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands=gear.AdhemarHands.A,ring1="Epona's Ring",ring2="Ilabrat Ring",
			    back=gear.stp_jse_back,waist="Reiki Yotai",legs="Adhemar Kecks",feet=gear.HerculeanBoots.TA}
				
	sets.engaged.HighAcc = {ammo="Falcon Eye",
				head="Carmine Mask +1",neck="Combatant's Torque",ear1="Regal Earring",ear2="Telos Earring",
				body=gear.jse.artifact.blu.body,hands=gear.jse.artifact.blu.hands,ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
				back=gear.da_jse_back,waist="Reiki Yotai",legs="Carmine Cuisses +1",feet=gear.HerculeanBoots.TA}
				
	sets.engaged.HighAcc.AM = {ammo="Falcon Eye",
			    head="Carmine Mask +1",neck="Combatant's Torque",ear1="Regal Earring",ear2="Telos Earring",
			    body=gear.jse.artifact.blu.body,hands=gear.jse.artifact.blu.hands,ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
			    back=gear.stp_jse_back,waist="Reiki Yotai",legs="Carmine Cuisses +1",feet=gear.HerculeanBoots.TA}
				
	sets.engaged.FullAcc = {ammo="Falcon Eye",
				head="Carmine Mask +1",neck="Combatant's Torque",ear1="Regal Earring",ear2="Telos Earring",
				body=gear.jse.artifact.blu.body,hands=gear.jse.artifact.blu.hands,ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
				back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.HerculeanBoots.TA}
				
	sets.engaged.FullAcc.AM = {ammo="Falcon Eye",
			    head="Carmine Mask +1",neck="Combatant's Torque",ear1="Regal Earring",ear2="Telos Earring",
			    body=gear.jse.artifact.blu.body,hands=gear.jse.artifact.blu.hands,ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
			    back=gear.stp_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.HerculeanBoots.TA}

	sets.engaged.Fodder = {
		ammo="Ginsen",
        head=gear.AdhemarBonnet.B,
        neck="Asperity Necklace",
        ear1="Telos Earring",
        ear2="Suppanomimi",
        body=gear.AdhemarJacket.Bplus,
        hands=gear.AdhemarHands.B,
--		hands=gear.HerculeanGloves.TA,
        ring1="Hetairoi Ring",
		ring2="Epona's Ring",
        back=gear.jsecapes.amb.blu.tp,
        waist=gear.waist.nohaste,
        legs=gear.SamnuhaTights.TP,
        feet=gear.HerculeanBoots.TA}
				
	sets.engaged.Fodder.AM = {ammo="Ginsen",
			    head="Dampening Tam",neck="Ainia Collar",ear1="Dedition Earring",ear2="Telos Earring",
			    body=gear.AdhemarJacket.Bplus,hands=gear.AdhemarHands.B,ring1="Epona's Ring",ring2="Petrov Ring",
			    back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Carmine Greaves +1"}
	
	sets.engaged.DTLite = {ammo="Ginsen",
			    head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
			    body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +1",feet="Ahosi Leggings"}
				
	sets.engaged.DTLite.AM = {ammo="Ginsen",
			    head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +1",feet="Ahosi Leggings"}
				
	sets.engaged.PDT = {
		ammo="Falcon Eye",
		head=gear.iuitl.head,
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Suppanomimi",
		body="Onca Suit",
		ring1="Defending Ring",
		ring2="Gelatinous Ring +1",
		back="Umbra Cape",
		waist="Flume Belt +1"}

	sets.engaged.MinAcc.DTLite = {
--		ammo="Ginsen",
--			    head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
--			    body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
--			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +1",feet="Ahosi Leggings"
}

	sets.engaged.MinAcc.PDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
		        body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
				back="Moonbeam Cape",waist="Flume Belt +1",legs=gear.herculean_dt_legs,feet="Ahosi Leggings"}
				
	sets.engaged.SomeAcc.DTLite = {ammo="Ginsen",
			    head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +1",feet="Ahosi Leggings"}
				
	sets.engaged.SomeAcc.PDT = {ammo="Ginsen",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
		        body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
				back="Moonbeam Cape",waist="Flume Belt +1",legs=gear.herculean_dt_legs,feet="Ahosi Leggings"}

	sets.engaged.Acc.DTLite = {ammo="Falcon Eye",
			    head="Dampening Tam",neck="Loricate Torque +1",ear1="Digni. Earring",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +1",feet="Ahosi Leggings"}
				
	sets.engaged.Acc.PDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
				body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
				back="Moonbeam Cape",waist="Flume Belt +1",legs="Aya. Cosciales +1",feet="Ahosi Leggings"}
				
	sets.engaged.HighAcc.DTLite = {ammo="Falcon Eye",
			    head="Carmine Mask +1",neck="Loricate Torque +1",ear1="Digni. Earring",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +1",feet="Ahosi Leggings"}
				
	sets.engaged.HighAcc.PDT = {ammo="Falcon Eye",
				head="Carmine Mask +1",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
				body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
				back="Moonbeam Cape",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Ahosi Leggings"}
				
	sets.engaged.FullAcc.DTLite = {ammo="Falcon Eye",
			    head="Carmine Mask +1",neck="Loricate Torque +1",ear1="Regal Earring",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +1",feet=gear.HerculeanBoots.WS}
				
	sets.engaged.FullAcc.PDT = {ammo="Falcon Eye",
				head="Carmine Mask +1",neck="Loricate Torque +1",ear1="Regal Earring",ear2="Telos Earring",
		        body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
				back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.HerculeanBoots.WS}
				
	sets.engaged.Fodder.DTLite = {ammo="Ginsen",
			    head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Brutal Earring",
			    body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet="Ahosi Leggings"}
				
	sets.engaged.Fodder.DTLite.AM = {ammo="Ginsen",
			    head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet="Ahosi Leggings"}
				
	sets.engaged.Fodder.PDT = {ammo="Staunch Tathlum",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Brutal Earring",
		        body="Ayanmo Corazza +1",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Patricius Ring",
				back="Moonbeam Cape",waist="Windbuffet Belt +1",legs=gear.herculean_dt_legs,feet="Ahosi Leggings"}
				
	sets.engaged.MDT = {ammo="Ginsen",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
		        body="Adhemar Jacket",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet="Ahosi Leggings"}

	sets.engaged.MinAcc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
		        body="Adhemar Jacket",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet="Ahosi Leggings"}
				
	sets.engaged.SomeAcc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi", ear2="Telos Earring",
		        body="Adhemar Jacket",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Ahosi Leggings"}
			
	sets.engaged.Acc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi", ear2="Telos Earring",
		        body="Adhemar Jacket",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Olseni Belt",legs="Samnuha Tights",feet="Ahosi Leggings"}
				
	sets.engaged.HighAcc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi", ear2="Telos Earring",
		        body="Adhemar Jacket",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Ahosi Leggings"}
				
	sets.engaged.FullAcc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi", ear2="Telos Earring",
		        body="Adhemar Jacket",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Dark Ring",
				back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.HerculeanBoots.WS}
				
	sets.engaged.Fodder.MDT = {ammo="Ginsen",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi", ear2="Telos Earring",
		        body="Adhemar Jacket",hands=gear.jse.artifact.blu.hands,ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet="Ahosi Leggings"}

	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",legs="Gyve Trousers",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Healing_Club = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Healing_DWClub = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Healing_Club = {}
	sets.Healing_DWClub = {}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
	sets.MagicBurst = {body="Samnuha Coat",ring1="Mujin Band",ring2="Locus Ring"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 16)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 16)
	elseif player.sub_job == 'WAR' then
		set_macro_page(1, 16)
	elseif player.sub_job == 'RUN' then
		set_macro_page(1, 16)
	elseif player.sub_job == 'THF' then
		set_macro_page(1, 16)
	else
		set_macro_page(1, 16)
	end
end

--Dynamis Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[980] == 0 and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = 1100
					return true
				elseif spell_recasts[952] == 0 and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = 1100
					return true
				elseif spell_recasts[967] == 0 and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = 1100
					return true
				elseif spell_recasts[914] == 0 and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = 1100
					return true
				elseif spell_recasts[979] == 0 and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
					tickdelay = 1100
					return true
				else
					return false
				end
			end
		end
	end
	return false
end
function set_lockstyle()
	send_command('wait 2; input /lockstyleset 17')
end
