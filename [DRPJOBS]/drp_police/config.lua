DRPPoliceJob = {}
DRPPoliceJob.SignOnAndOff = {}
DRPPoliceJob.PoliceJobLabels = {}
DRPPoliceJob.Requirements = {}

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