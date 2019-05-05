DRPPoliceJob = {}
DRPPoliceJob.SignOnAndOff = {}
DRPPoliceJob.PoliceJobLabels = {}
DRPPoliceJob.Requirements = {}
DRPPoliceJob.LockerRooms = {}
DRPPoliceJob.SignOnAndOff = {
    {x = 441.02, y = -974.94, z = 30.54} -- Mission Row Behind Desk In Lobby
}
---------------------------------------------------------------------------
-- Police Job Config, edit to your requirements
-- Ranks
-- Chief Of Police = 8
-- Captain = 7
-- Lieutenant = 6
-- Staff Sergeant = 5 
-- Sergeant = 4
-- Senior Police Officer = 3
-- Police Officer = 2
-- Cadet = 1
---------------------------------------------------------------------------
DRPPoliceJob.RankAllowedToAddCop = 4
DRPPoliceJob.RankAllowedToRemoveCop = 5
DRPPoliceJob.RankAllowedToPromoteUpToSPO = 4
---------------------------------------------------------------------------
DRPPoliceJob.PoliceJobLabels["POLICE"] = "Police Officer"
DRPPoliceJob.PoliceJobLabels["STATE"] = "State Trooper"
DRPPoliceJob.PoliceJobLabels["SHERIFF"] = "Sheriff Deputy"
---------------------------------------------------------------------------
DRPPoliceJob.Requirements["POLICE"] = "police" -- Database Table Name
DRPPoliceJob.Requirements["STATE"] = "state" -- Database Table Name
DRPPoliceJob.Requirements["SHERIFF"] = "sheriff" -- Database Table Name

-- Police Officer Uniforms and Loadouts
DRPPoliceJob.LockerRooms["Police Officer"] = {
    BlipData = {label = "Police Department Locker Room", sprite = 366, color = 77, scale = 1.0},
    MarkerData = {label = "~b~[E]~w~ Police Department Locker Room", markerType = 1, color = {0, 0, 255}, scale = 1.0},
    Loadouts = {
        {
            minrank = 1,
            gender = "Male",
            division = "police",
            label = "Standard Uniform [Male]",
            model = "s_m_y_cop_01",
            clothing = {
                {component = 3, drawable = 14, texture = 0}, -- Shirt
                {component = 8, drawable = 58, texture = 0}, -- Night stick shit
                {component = 4, drawable = 34, texture = 0},  -- Pants
                {component = 6, drawable = 29, texture = 0} -- Shoes
            },
            props = {
                {component = 1, drawable = 11, texture = 3}
            },
            weapons = {
                {model = "weapon_pistol_mk2", ammo = 120, attachments = {"COMPONENT_AT_PI_FLSH_02"}},
                {model = "weapon_flashlight", ammo = -1, attachments = {}},
                {model = "weapon_stungun", ammo = -1, attachments = {}},
                {model = "weapon_nightstick", ammo = -1, attachments = {}}
            },
        },
        -- Captain Uniform
        {
            minrank = 7,
            gender = "Male",
            division = "police",
            label = "Captain Uniform [Male]",
            model = "lspdofficer_01",
            clothing = {
                {component = 1, drawable = 2, texture = 0}, -- Shirt
                {component = 1, drawable = 2, texture = 0}, -- Night stick shit
                {component = 4, drawable = 2, texture = 0},  -- Pants
                {component = 6, drawable = 1, texture = 0} -- Shoes
            },
            props = {
                {component = 1, drawable = 11, texture = 3}
            },
            weapons = {
                {model = "weapon_pistol_mk2", ammo = 120, attachments = {"COMPONENT_AT_PI_FLSH_02"}},
                {model = "weapon_flashlight", ammo = -1, attachments = {}},
                {model = "weapon_stungun", ammo = -1, attachments = {}},
                {model = "weapon_nightstick", ammo = -1, attachments = {}}
            },
        },
        {
            minrank = 7,
            gender = "Male",
            division = "sheriff",
            label = "Sheriff Uniform [Male]",
            model = "s_m_y_hwaycop_01",
            clothing = {
                {component = 1, drawable = 2, texture = 0}, -- Shirt
                {component = 1, drawable = 2, texture = 0}, -- Night stick shit
                {component = 0, drawable = 0, texture = 0},  -- Pants
                {component = 0, drawable = 0, texture = 0} -- Shoes
            },
            props = {
                {component = 1, drawable = 11, texture = 3}
            },
            weapons = {
                {model = "weapon_pistol_mk2", ammo = 120, attachments = {"COMPONENT_AT_PI_FLSH_02"}},
                {model = "weapon_flashlight", ammo = -1, attachments = {}},
                {model = "weapon_stungun", ammo = -1, attachments = {}},
                {model = "weapon_nightstick", ammo = -1, attachments = {}}
            },
        },
        -- FEMALE CLOTHING --
        {
            minrank = 1,
            gender = "Female",
            division = "police",
            label = "Standard Uniform [Female]",
            model = "s_f_y_cop_01",
            clothing = {
                {component = 3, drawable = 14, texture = 0}, -- Shirt
                {component = 8, drawable = 58, texture = 0}, -- Night stick shit
                {component = 4, drawable = 34, texture = 0},  -- Pants
                {component = 6, drawable = 29, texture = 0} -- Shoes
            },
            props = {
                {component = 1, drawable = 11, texture = 3}
            },
            weapons = {
                {model = "weapon_pistol_mk2", ammo = 120, attachments = {"COMPONENT_AT_PI_FLSH_02"}},
                {model = "weapon_flashlight", ammo = -1, attachments = {}},
                {model = "weapon_stungun", ammo = -1, attachments = {}},
                {model = "weapon_nightstick", ammo = -1, attachments = {}}
            },
        },
    },
    Locations = {
        {x = 458.60, y = -992.55, z = 30.68}
    }
}