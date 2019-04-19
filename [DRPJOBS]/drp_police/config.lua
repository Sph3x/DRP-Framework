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
---------------------------------------------------------------------------
---------------------------------------------------------------------------
DRPPoliceJob.PoliceJobLabels["POLICE"] = "Police Officer"
DRPPoliceJob.PoliceJobLabels["STATE"] = "State Trooper"
DRPPoliceJob.PoliceJobLabels["SHERIFF"] = "Sheriff Deputy"
---------------------------------------------------------------------------
DRPPoliceJob.Requirements["POLICE"] = "police" -- Database Table Name
DRPPoliceJob.Requirements["STATE"] = "state" -- Database Table Name
DRPPoliceJob.Requirements["SHERIFF"] = "sheriff" -- Database Table Name

-- Job Doors --
DRPPoliceJob.LockerRooms["Police Officer"] = {
    BlipData = {label = "Police Department Locker Room", sprite = 366, color = 77, scale = 1.0},
    MarkerData = {label = "Police Department Locker Room", markerType = 1, color = {0, 0, 255}, scale = 1.0},
    Loadouts = {
        {
            minrank = 1,
            gender = "Male",
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
        {
            minrank = 1,
            gender = "Female",
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