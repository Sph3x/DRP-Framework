---------------------------------------
DRPInventory = {}
---------------------------------------
DRPInventory.MaxInventorySlots = 20
---------------------------------------
DRPInventory.UseableFunctions = {
    ["water"] = "drink",
    ["burger"] = "eat",
    ["lockpick"] = "lockpicking",
    ["rawcocaine"] = "drug",
    ["cocaine"] = "drug",
    ["marijuana"] = "drug",
    ["weed"] = "drug"
}

DRPInventory.Weapons = {

	{
		name = 'WEAPON_KNIFE',
		label = 'weapon_knife',
		components = {}
	},

	{
		name = 'WEAPON_NIGHTSTICK',
		label = 'weapon_nightstick',
		components = {}
	},

	{
		name = 'WEAPON_HAMMER',
		label = 'weapon_hammer',
		components = {}
	},

	{
		name = 'WEAPON_BAT',
		label = 'weapon_bat',
		components = {}
	},

	{
		name = 'WEAPON_GOLFCLUB',
		label = 'weapon_golfclub',
		components = {}
	},

	{
		name = 'WEAPON_CROWBAR',
		label = 'weapon_crowbar',
		components = {}
	},

	{
		name = 'WEAPON_PISTOL',
		label = 'weapon_pistol',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_PISTOL_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_PISTOL_CLIP_02' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_PI_FLSH' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_PI_SUPP_02' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_PISTOL_VARMOD_LUXE' }
		}
	},

	{
		name = 'WEAPON_COMBATPISTOL',
		label = 'weapon_combatpistol',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_COMBATPISTOL_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_COMBATPISTOL_CLIP_02' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_PI_FLSH' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_PI_SUPP' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER' }
		}
	},

	{
		name = 'WEAPON_APPISTOL',
		label = 'weapon_appistol',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_APPISTOL_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_APPISTOL_CLIP_02' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_PI_FLSH' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_PI_SUPP' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_APPISTOL_VARMOD_LUXE' }
		}
	},

	{
		name = 'WEAPON_PISTOL50',
		label = 'weapon_pistol50',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_PISTOL50_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_PISTOL50_CLIP_02' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_PI_FLSH' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_AR_SUPP_02' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_PISTOL50_VARMOD_LUXE' }
		}
	},

	{
		name = 'WEAPON_REVOLVER',
		label = 'weapon_revolver',
		components = {}
	},

	{
		name = 'WEAPON_SNSPISTOL',
		label = 'weapon_snspistol',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_SNSPISTOL_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_SNSPISTOL_CLIP_02' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_SNSPISTOL_VARMOD_LOWRIDER' }
		}
	},

	{
		name = 'WEAPON_HEAVYPISTOL',
		label = 'weapon_heavypistol',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_HEAVYPISTOL_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_HEAVYPISTOL_CLIP_02' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_PI_FLSH' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_PI_SUPP' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_HEAVYPISTOL_VARMOD_LUXE' }
		}
	},

	{
		name = 'WEAPON_VINTAGEPISTOL',
		label = 'weapon_vintagepistol',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_VINTAGEPISTOL_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_VINTAGEPISTOL_CLIP_02' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_PI_SUPP' }
		}
	},

	{
		name = 'WEAPON_MICROSMG',
		label = 'weapon_microsmg',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_MICROSMG_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_MICROSMG_CLIP_02' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_PI_FLSH' },
			{ name = 'scope', label = 'component_scope', hash = GetHashKey'COMPONENT_AT_SCOPE_MACRO' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_AR_SUPP_02' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_MICROSMG_VARMOD_LUXE' }
		}
	},

	{
		name = 'WEAPON_SMG',
		label = 'weapon_smg',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_SMG_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_SMG_CLIP_02' },
			{ name = 'clip_drum', label = 'component_clip_drum', hash = GetHashKey'COMPONENT_SMG_CLIP_03' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_AR_FLSH' },
			{ name = 'scope', label = 'component_scope', hash = GetHashKey'COMPONENT_AT_SCOPE_MACRO_02' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_PI_SUPP' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_SMG_VARMOD_LUXE' }
		}
	},

	{
		name = 'WEAPON_ASSAULTSMG',
		label = 'weapon_assaultsmg',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_ASSAULTSMG_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_ASSAULTSMG_CLIP_02' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_AR_FLSH' },
			{ name = 'scope', label = 'component_scope', hash = GetHashKey'COMPONENT_AT_SCOPE_MACRO' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_AR_SUPP_02' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER' }
		}
	},

	{
		name = 'WEAPON_MINISMG',
		label = 'weapon_minismg',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_MINISMG_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_MINISMG_CLIP_02' }
		}
	},

	{
		name = 'WEAPON_MACHINEPISTOL',
		label = 'weapon_machinepistol',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_MACHINEPISTOL_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_MACHINEPISTOL_CLIP_02' },
			{ name = 'clip_drum', label = 'component_clip_drum', hash = GetHashKey'COMPONENT_MACHINEPISTOL_CLIP_03' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_PI_SUPP' }
		}
	},

	{
		name = 'WEAPON_COMBATPDW',
		label = 'weapon_combatpdw',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_COMBATPDW_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_COMBATPDW_CLIP_02' },
			{ name = 'clip_drum', label = 'component_clip_drum', hash = GetHashKey'COMPONENT_COMBATPDW_CLIP_03' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_AR_FLSH' },
			{ name = 'grip', label = 'component_grip', hash = GetHashKey'COMPONENT_AT_AR_AFGRIP' },
			{ name = 'scope', label = 'component_scope', hash = GetHashKey'COMPONENT_AT_SCOPE_SMALL' }
		}
	},
	
	{
		name = 'WEAPON_PUMPSHOTGUN',
		label = 'weapon_pumpshotgun',
		components = {
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_AR_FLSH' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_SR_SUPP' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER' }
		}
	},

	{
		name = 'WEAPON_SAWNOFFSHOTGUN',
		label = 'weapon_sawnoffshotgun',
		components = {
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE' }
		}
	},

	{
		name = 'WEAPON_ASSAULTSHOTGUN',
		label = 'weapon_assaultshotgun',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_ASSAULTSHOTGUN_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_ASSAULTSHOTGUN_CLIP_02' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_AR_FLSH' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_AR_SUPP' },
			{ name = 'grip', label = 'component_grip', hash = GetHashKey'COMPONENT_AT_AR_AFGRIP' }
		}
	},

	{
		name = 'WEAPON_BULLPUPSHOTGUN',
		label = 'weapon_bullpupshotgun',
		components = {
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_AR_FLSH' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_AR_SUPP_02' },
			{ name = 'grip', label = 'component_grip', hash = GetHashKey'COMPONENT_AT_AR_AFGRIP' }
		}
	},

	{
		name = 'WEAPON_HEAVYSHOTGUN',
		label = 'weapon_heavyshotgun',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_HEAVYSHOTGUN_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_HEAVYSHOTGUN_CLIP_02' },
			{ name = 'clip_drum', label = 'component_clip_drum', hash = GetHashKey'COMPONENT_HEAVYSHOTGUN_CLIP_03' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_AR_FLSH' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_AR_SUPP_02' },
			{ name = 'grip', label = 'component_grip', hash = GetHashKey'COMPONENT_AT_AR_AFGRIP' }
		}
	},

	{
		name = 'WEAPON_ASSAULTRIFLE',
		label = 'weapon_assaultrifle',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_ASSAULTRIFLE_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_ASSAULTRIFLE_CLIP_02' },
			{ name = 'clip_drum', label = 'component_clip_drum', hash = GetHashKey'COMPONENT_ASSAULTRIFLE_CLIP_03' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_AR_FLSH' },
			{ name = 'scope', label = 'component_scope', hash = GetHashKey'COMPONENT_AT_SCOPE_MACRO' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_AR_SUPP_02' },
			{ name = 'grip', label = 'component_grip', hash = GetHashKey'COMPONENT_AT_AR_AFGRIP' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_ASSAULTRIFLE_VARMOD_LUXE' }
		}
	},

	{
		name = 'WEAPON_CARBINERIFLE',
		label = 'weapon_carbinerifle',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_CARBINERIFLE_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_CARBINERIFLE_CLIP_02' },
			{ name = 'clip_box', label = 'component_clip_box', hash = GetHashKey'COMPONENT_CARBINERIFLE_CLIP_03' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_AR_FLSH' },
			{ name = 'scope', label = 'component_scope', hash = GetHashKey'COMPONENT_AT_SCOPE_MEDIUM' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_AR_SUPP' },
			{ name = 'grip', label = 'component_grip', hash = GetHashKey'COMPONENT_AT_AR_AFGRIP' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_CARBINERIFLE_VARMOD_LUXE' }
		}
	},

	{
		name = 'WEAPON_ADVANCEDRIFLE',
		label = 'weapon_advancedrifle',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_ADVANCEDRIFLE_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_ADVANCEDRIFLE_CLIP_02' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_AR_FLSH' },
			{ name = 'scope', label = 'component_scope', hash = GetHashKey'COMPONENT_AT_SCOPE_SMALL' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_AR_SUPP' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE' }
		}
	},

	{
		name = 'WEAPON_SPECIALCARBINE',
		label = 'weapon_specialcarbine',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_SPECIALCARBINE_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_SPECIALCARBINE_CLIP_02' },
			{ name = 'clip_drum', label = 'component_clip_drum', hash = GetHashKey'COMPONENT_SPECIALCARBINE_CLIP_03' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_AR_FLSH' },
			{ name = 'scope', label = 'component_scope', hash = GetHashKey'COMPONENT_AT_SCOPE_MEDIUM' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_AR_SUPP_02' },
			{ name = 'grip', label = 'component_grip', hash = GetHashKey'COMPONENT_AT_AR_AFGRIP' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER' }
		}
	},

	{
		name = 'WEAPON_BULLPUPRIFLE',
		label = 'weapon_bullpuprifle',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_BULLPUPRIFLE_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_BULLPUPRIFLE_CLIP_02' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_AR_FLSH' },
			{ name = 'scope', label = 'component_scope', hash = GetHashKey'COMPONENT_AT_SCOPE_SMALL' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_AR_SUPP' },
			{ name = 'grip', label = 'component_grip', hash = GetHashKey'COMPONENT_AT_AR_AFGRIP' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_BULLPUPRIFLE_VARMOD_LOW' }
		}
	},

	{
		name = 'WEAPON_COMPACTRIFLE',
		label = 'weapon_compactrifle',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_COMPACTRIFLE_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_COMPACTRIFLE_CLIP_02' },
			{ name = 'clip_drum', label = 'component_clip_drum', hash = GetHashKey'COMPONENT_COMPACTRIFLE_CLIP_03' }
		}
	},

	{
		name = 'WEAPON_MG',
		label = 'weapon_mg',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_MG_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_MG_CLIP_02' },
			{ name = 'scope', label = 'component_scope', hash = GetHashKey'COMPONENT_AT_SCOPE_SMALL_02' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_MG_VARMOD_LOWRIDER' }
		}
	},

	{
		name = 'WEAPON_COMBATMG',
		label = 'weapon_combatmg',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_COMBATMG_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_COMBATMG_CLIP_02' },
			{ name = 'scope', label = 'component_scope', hash = GetHashKey'COMPONENT_AT_SCOPE_MEDIUM' },
			{ name = 'grip', label = 'component_grip', hash = GetHashKey'COMPONENT_AT_AR_AFGRIP' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_COMBATMG_VARMOD_LOWRIDER' }
		}
	},

	{
		name = 'WEAPON_GUSENBERG',
		label = 'weapon_gusenberg',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_GUSENBERG_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_GUSENBERG_CLIP_02' },
		}
	},

	{
		name = 'WEAPON_SNIPERRIFLE',
		label = 'weapon_sniperrifle',
		components = {
			{ name = 'scope', label = 'component_scope', hash = GetHashKey'COMPONENT_AT_SCOPE_LARGE' },
			{ name = 'scope_advanced', label = 'component_scope_advanced', hash = GetHashKey'COMPONENT_AT_SCOPE_MAX' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_AR_SUPP_02' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_SNIPERRIFLE_VARMOD_LUXE' }
		}
	},

	{
		name = 'WEAPON_HEAVYSNIPER',
		label = 'weapon_heavysniper',
		components = {
			{ name = 'scope', label = 'component_scope', hash = GetHashKey'COMPONENT_AT_SCOPE_LARGE' },
			{ name = 'scope_advanced', label = 'component_scope_advanced', hash = GetHashKey'COMPONENT_AT_SCOPE_MAX' }
		}
	},

	{
		name = 'WEAPON_MARKSMANRIFLE',
		label = 'weapon_marksmanrifle',
		components = {
			{ name = 'clip_default', label = 'component_clip_default', hash = GetHashKey'COMPONENT_MARKSMANRIFLE_CLIP_01' },
			{ name = 'clip_extended', label = 'component_clip_extended', hash = GetHashKey'COMPONENT_MARKSMANRIFLE_CLIP_02' },
			{ name = 'flashlight', label = 'component_flashlight', hash = GetHashKey'COMPONENT_AT_AR_FLSH' },
			{ name = 'scope', label = 'component_scope', hash = GetHashKey'COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM' },
			{ name = 'suppressor', label = 'component_suppressor', hash = GetHashKey'COMPONENT_AT_AR_SUPP' },
			{ name = 'grip', label = 'component_grip', hash = GetHashKey'COMPONENT_AT_AR_AFGRIP' },
			{ name = 'luxary_finish', label = 'component_luxary_finish', hash = GetHashKey'COMPONENT_MARKSMANRIFLE_VARMOD_LUXE' }
		}
	},

	{
		name = 'WEAPON_GRENADELAUNCHER',
		label = 'weapon_grenadelauncher',
		components = {}
	},

	{
		name = 'WEAPON_RPG',
		label = 'weapon_rpg',
		components = {}
	},

	{
		name = 'WEAPON_STINGER',
		label = 'weapon_stinger',
		components = {}
	},

	{
		name = 'WEAPON_MINIGUN',
		label = 'weapon_minigun',
		components = {}
	},

	{
		name = 'WEAPON_GRENADE',
		label = 'weapon_grenade',
		components = {}
	},

	{
		name = 'WEAPON_STICKYBOMB',
		label = 'weapon_stickybomb',
		components = {}
	},

	{
		name = 'WEAPON_SMOKEGRENADE',
		label = 'weapon_smokegrenade',
		components = {}
	},

	{
		name = 'WEAPON_BZGAS',
		label = 'weapon_bzgas',
		components = {}
	},

	{
		name = 'WEAPON_MOLOTOV',
		label = 'weapon_molotov',
		components = {}
	},

	{
		name = 'WEAPON_FIREEXTINGUISHER',
		label = 'weapon_fireextinguisher',
		components = {}
	},

	{
		name = 'WEAPON_PETROLCAN',
		label = 'weapon_petrolcan',
		components = {}
	},

	{
		name = 'WEAPON_DIGISCANNER',
		label = 'weapon_digiscanner',
		components = {}
	},

	{
		name = 'WEAPON_BALL',
		label = 'weapon_ball',
		components = {}
	},

	{
		name = 'WEAPON_BOTTLE',
		label = 'weapon_bottle',
		components = {}
	},

	{
		name = 'WEAPON_DAGGER',
		label = 'weapon_dagger',
		components = {}
	},

	{
		name = 'WEAPON_FIREWORK',
		label = 'weapon_firework',
		components = {}
	},

	{
		name = 'WEAPON_MUSKET',
		label = 'weapon_musket',
		components = {}
	},

	{
		name = 'WEAPON_STUNGUN',
		label = 'weapon_stungun',
		components = {}
	},

	{
		name = 'WEAPON_HOMINGLAUNCHER',
		label = 'weapon_hominglauncher',
		components = {}
	},

	{
		name = 'WEAPON_PROXMINE',
		label = 'weapon_proxmine',
		components = {}
	},

	{
		name = 'WEAPON_SNOWBALL',
		label = 'weapon_snowball',
		components = {}
	},

	{
		name = 'WEAPON_FLAREGUN',
		label = 'weapon_flaregun',
		components = {}
	},

	{
		name = 'WEAPON_GARBAGEBAG',
		label = 'weapon_garbagebag',
		components = {}
	},

	{
		name = 'WEAPON_HANDCUFFS',
		label = 'weapon_handcuffs',
		components = {}
	},

	{
		name = 'WEAPON_MARKSMANPISTOL',
		label = 'weapon_marksmanpistol',
		components = {}
	},

	{
		name = 'WEAPON_KNUCKLE',
		label = 'weapon_knuckle',
		components = {}
	},

	{
		name = 'WEAPON_HATCHET',
		label = 'weapon_hatchet',
		components = {}
	},

	{
		name = 'WEAPON_RAILGUN',
		label = 'weapon_railgun',
		components = {}
	},

	{
		name = 'WEAPON_MACHETE',
		label = 'weapon_machete',
		components = {}
	},

	{
		name = 'WEAPON_SWITCHBLADE',
		label = 'weapon_switchblade',
		components = {}
	},

	{
		name = 'WEAPON_DBSHOTGUN',
		label = 'weapon_dbshotgun',
		components = {}
	},

	{
		name = 'WEAPON_AUTOSHOTGUN',
		label = 'weapon_autoshotgun',
		components = {}
	},

	{
		name = 'WEAPON_BATTLEAXE',
		label = 'weapon_battleaxe',
		components = {}
	},

	{
		name = 'WEAPON_COMPACTLAUNCHER',
		label = 'weapon_compactlauncher',
		components = {}
	},

	{
		name = 'WEAPON_PIPEBOMB',
		label = 'weapon_pipebomb',
		components = {}
	},

	{
		name = 'WEAPON_POOLCUE',
		label = 'weapon_poolcue',
		components = {}
	},

	{
		name = 'WEAPON_WRENCH',
		label = 'weapon_wrench',
		components = {}
	},

	{
		name = 'WEAPON_FLASHLIGHT',
		label = 'weapon_flashlight',
		components = {}
	},

	{
		name = 'GADGET_NIGHTVISION',
		label = 'gadget_nightvision',
		components = {}
	},

	{
		name = 'GADGET_PARACHUTE',
		label = 'gadget_parachute',
		components = {}
	},

	{
		name = 'WEAPON_FLARE',
		label = 'weapon_flare',
		components = {}
	},

	{
		name = 'WEAPON_DOUBLEACTION',
		label = 'weapon_doubleaction',
		components = {}
	}

}
