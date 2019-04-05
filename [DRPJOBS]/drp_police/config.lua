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

DRPPoliceJob.LockerRooms["Police Officer"] = {
    BlipData = {label = "Police Department Locker Room", sprite = 366, color = 77, scale = 1.0},
    MarkerData = {label = "Police Department Locker Room", markerType = 1, color = {0, 0, 255}, scale = 1.0},
    Locations = {
        {x = 458.60, y = -992.55, z = 30.68}
    }
}