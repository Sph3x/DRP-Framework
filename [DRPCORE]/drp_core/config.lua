DRPCoreConfig = {}
DRPCoreConfig.StaffRanks = {}
DRPCoreConfig.Locations = {}

DRPCoreConfig.Whitelisted = true -- true or false if you want to add the whitelist system
DRPCoreConfig.Debug = false

DRPCoreConfig.CommunityName = "DRP Framework"

DRPCoreConfig.StaffRanks.ranks = {"User", "Moderator", "Administrator", "Developer", "Founder"}
DRPCoreConfig.StaffRanks.perms = {
    ["User"] = {},
    ["Moderator"] = {""},
    ["Administrator"] = {""},
    ["Developer"] = {""},
    ["Founder"] = {""}
}

DRPCoreConfig.Locations = {
	{name = "Mission Row Police Station", id = 60, blipSize = 1.0, colour = 4, x = 428.21, y = -981.13, z = 30.71},
	{name = "Sandy Shores Sheriff Department", id = 60, blipSize = 1.0, colour = 4, x = 1857.0, y = 3680.51, z = 33.9},
	{name = "Paleto Bay Sheriff Department", id = 60, blipSize = 1.0, colour = 4, x = -443.37, y = 6016.27, z = 31.71},
	{name = "State Police Department", id = 60, blipSize = 1.0, colour = 4, x = 2521.95, y = -384.09, z = 92.99},
	{name = "Davis Medical Center", id = 61, blipSize = 1.0, colour = 4, x = 303.78, y = -1443.58, z = 29.79},
	{name = "Pillbox Medical Center", id = 61, blipSize = 1.0, colour = 4, x = 325.97, y = -580.67, z = 44.35},
	{name = "Mt. Zonah Medical Center", id = 61, blipSize = 1.0, colour = 4, x = -473.48, y = -339.86, z = 35.2},
	{name = "Capital Blvd Medical Center", id = 61, blipSize = 1.0, colour = 4, x = 1149.5, y = -1495.27, z = 34.69},
	{name = "Sandy Shore Medical Center", id = 61, blipSize = 1.0, colour = 4, x = 1840.4, y = 3670.41, z = 33.77},
	{name = "Paleto Bay Medical Center", id = 61, blipSize = 1.0, colour = 4, x = -232.73, y = 6316.16, z = 31.48},
	{name = "Taxi Depot", id = 56, colour = 46, blipSize = 1.0, x = 894.4, y = -181.55, z = 74.7},
	-- {name = "Bus Depot", id = 513, colour = 18, blipSize = 0.7, x = 452.42, y = -633.37, z = 28.53},
	{name = "GoPostal", id = 478, colour = 21, blipSize = 1.0, x = 72.75, y = 107.16, z = 79.2},
	{name = "RON Deliveries", id = 477, colour = 64, blipSize = 1.0, x = -69.2, y = -2517.23, z = 5.14},
	{name = "Yellow Jack", id = 93, colour = 50, blipSize = 1.0, x = 1985.68, y = 3052.05, z = 47.22},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 263.69, y = -1259.66, z = 36.14},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 172.45, y = -1560.21, z = 35.71},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = -310.48, y = -1467.69, z = 37.19},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = -523.95, y = -1210.99, z = 18.18},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = -724.13, y = -935.68, z = 23.98},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 815.99, y = -1027.2, z = 26.38},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 1211.14, y = -1404.96, z = 43.83},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 1181.2, y = -331.35, z = 69.32},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 620.4, y = 268.45, z = 103.09},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = -2096.35, y = -317.24, z = 13.02},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = -1799.97, y = 802.39, z = 138.65},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 2581.23, y = 361.5, z = 108.47},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = -2555.02, y = 2334.12, z = 33.08},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 264.62, y = 2608.07, z = 44.84}, -- Old Tiny Fuel Station
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = -1436.64, y = -276.85, z = 46.21},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 1206.6, y = 2662.45, z = 37.9}, -- Old Tiny Fuel Station by Sandy Customs
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 1785.86, y = 3331.43, z = 41.36}, -- Old Tiny Fuel Station by Airfield
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 2005.36, y = 3772.86, z = 32.18},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 2680.21, y = 3263.73, z = 55.24},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 1689.43, y = 4928.38, z = 42.23},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 1701.92, y = 6417.2, z = 32.76},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 180.0, y = 6603.07, z = 31.87},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = -94.28, y = 6419.79, z = 31.49},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = 48.24, y = 2779.1, z = 58.04},
	-- {name = "Fuel Station", id = 361, blipSize = 0.75, colour = 1, x = -69.94, y = -1762.01, z = 29.53},
}

-- 'bone' use bonetag https://pastebin.com/D7JMnX1g
DRPCoreConfig.RealWeapons = {
	--{name = 'WEAPON_NIGHTSTICK', hash = "", 			bone = 58271, x = -0.20, y = 0.1,  z = -0.10, xRot = -55.0,  yRot = 90.00, zRot = 5.0, category = 'melee', 		model = 'w_me_nightstick'},
	{name = 'WEAPON_HAMMER', hash = "", 				bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 265.0, zRot = 0.0, category = 'melee', 		model = 'prop_tool_hammer'},
	{name = 'WEAPON_BAT', hash = "", 				bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 265.0, zRot = 0.0, 		category = 'melee', 		model = 'w_me_bat'},
	{name = 'WEAPON_GOLFCLUB', hash = "", 			bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 265.0, zRot = 0.0, category = 'melee', 		model = 'w_me_gclub'},
	{name = 'WEAPON_HATCHET', hash = "", 				bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 265.0, zRot = 0.0, category = 'melee', 		model = 'w_me_hatchet'},
	{name = 'WEAPON_MACHETE', hash = "", 				bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 265.0, zRot = 0.0, category = 'melee', 		model = 'prop_ld_w_me_machette'},
	{name = 'WEAPON_SMG_MK2', hash = "", 			bone = 24818, x = 0.10,    y = -0.15, 	z = 0.0,     xRot = 10.0, yRot = 50.0, zRot = 0.0, category = 'machine', 	model = 'w_sb_smgmk2'},
	{name = 'WEAPON_SMG', hash = "", 				bone = 24818, x = 0.10,    y = -0.15, 	z = 0.0,     xRot = 10.0, yRot = 50.0, zRot = 0.0, category = 'machine', 	model = 'w_sb_smg'},
	{name = 'WEAPON_MG', hash = "", 				bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = 'w_mg_mg'},
	{name = 'WEAPON_COMBATMG', hash = "", 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = 'w_mg_combatmg'},
	{name = 'WEAPON_GUSENBERG', hash = "", 		bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = 'w_sb_gusenberg'},
	{name = 'WEAPON_COMBATPDW', hash = "", 		bone = 24818, x = 0.10,    y = -0.15, 	z = 0.0,     xRot = 10.0, yRot = 50.0, zRot = 0.0, category = 'machine', 	model = 'w_sb_pdw'},
	{name = 'WEAPON_ASSAULTSMG', hash = "", 		bone = 24818, x = 0.10,    y = -0.15, 	z = 0.0,     xRot = 10.0, yRot = 50.0, zRot = 0.0, category = 'machine', 	model = 'w_sb_assaultsmg'},
	{name = 'WEAPON_MINISMG', hash = "", 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = 'wb_sb_minismg'},
	{name = 'WEAPON_ASSAULTRIFLE', hash = "", 		bone = 24818, x = 0.10,    y = -0.15, 	z = 0.0,     xRot = 10.0, yRot = 50.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_assaultrifle'},
	{name = 'WEAPON_CARBINERIFLE', hash = "", 		bone = 24818, x = 0.1,    y = -0.15, 	z = 0.0,     xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_carbinerifle'},
	{name = 'WEAPON_CARBINERIFLE_Mk2', hash = "", 	bone = 24818, x = 0.1,    y = -0.15, 	z = 0.0,     xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_carbineriflemk2'},
	{name = 'WEAPON_ADVANCEDRIFLE', hash = "", 	bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_advancedrifle'},
	{name = 'WEAPON_SPECIALCARBINE', hash = "", 	bone = 24818, x = 0.10, y = -0.15,     z = 0.0,     xRot = 0.0, yRot = 50.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_specialcarbine'},
	{name = 'WEAPON_BULLPUPRIFLE', hash = "", 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_bullpuprifle'},
	{name = 'WEAPON_COMPACTRIFLE', hash = "", 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'assault', 	model = 'wr_ar_compact'},
	{name = 'WEAPON_SPECIALCARBINE_Mk2', hash = "", bone = 24818, x = 0.10, y = -0.15,     z = 0.0,     xRot = 0.0, yRot = 50.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_specialcarbinemk2'},
	{name = 'WEAPON_PUMPSHOTGUN', hash = "", 		bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'shotgun', 	model = 'w_sg_pumpshotgun'},
	{name = 'WEAPON_BULLPUPSHOTGUN', hash = "", 	bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'shotgun', 	model = 'w_sg_bullpupshotgun'},
	{name = 'WEAPON_ASSAULTSHOTGUN', hash = "", 	bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'shotgun', 	model = 'w_sg_assaultshotgun'},
	{name = 'WEAPON_MUSKET', hash = "", 			bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'shotgun', 	model = 'w_ar_musket'},
	{name = 'WEAPON_HEAVYSHOTGUN', hash = "", 		bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 225.0, zRot = 0.0, category = 'shotgun', 	model = 'w_sg_heavyshotgun'},
	{name = 'WEAPON_SNIPERRIFLE', hash = "", 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'sniper', 	model = 'w_sr_sniperrifle'},
	{name = 'WEAPON_HEAVYSNIPER', hash = "", 		bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'sniper', 	model = 'w_sr_heavysniper'},
	{name = 'WEAPON_MARKSMANRIFLE', hash = "", 	bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'sniper', 	model = 'w_sr_marksmanrifle'},
	{name = 'WEAPON_FIREEXTINGUISHER', hash = "", bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'thrown', 	model = 'w_am_fire_exting'},
	{name = 'WEAPON_PETROLCAN', hash = "", 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'thrown', 	model = 'w_am_jerrycan'},
	{name = 'WEAPON_HANDCUFFS', hash = "", 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'others', 	model = ''}
}

DRPWeatherConfig = {

    -- Least time for the weather to change
    leastTime = 10,

    -- Max time for the weather to change
    maxTime = 25,

    -- Would you like the weather to be snowing???
    isWinter = false,

    -- Regular Weather Types
    regularWeatherTypes = {
        "CLEAR",
        "EXTRASUNNY",
        "CLOUDS",
        "OVERCAST",
        "RAIN",
        "CLEARING",
        "THUNDER",
        "SMOG",
        "FOGGY"
    },

    -- Winter Weather Types
    winterWeatherTypes = {"XMAS"}
}

DRPTimeConfig = {
    -- Time it takes for one minute to pass
    SecPerMin = 10,

    -- If true it doesn't allow the time to change
    FreezeTime = false,
}
---------------------------------------------------------------------------
function getRealWeapons()
	local weapons = {}
	for i=1, #DRPCoreConfig.RealWeapons do
		table.insert(weapons, DRPCoreConfig.RealWeapons[i].name)
	end
	return weapons
end
---------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i=1, #DRPCoreConfig.RealWeapons do
		DRPCoreConfig.RealWeapons[i].hash = GetHashKey(DRPCoreConfig.RealWeapons[i].name)
	end
end)