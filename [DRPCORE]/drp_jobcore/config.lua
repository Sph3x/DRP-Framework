JobsCoreConfig = {}
JobsCoreConfig.Jobs = {}
JobsCoreConfig.Requirements = {}
---------------------------------------------------------------------------
JobsCoreConfig.Jobs = {"UNEMPLOYED", "POLICE", "STATE", "SHERIFF"}
---------------------------------------------------------------------------
---------------------------------------------------------------------------
-- Custom Jobs Config Edit To Your Requirements (false = no, true = yes)
---------------------------------------------------------------------------
JobsCoreConfig.PoliceJob = false
---------------------------------------------------------------------------
JobsCoreConfig.MedicalJob = false
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- Static Jobs
---------------------------------------------------------------------------
JobsCoreConfig.StaticJobLabels = {}

JobsCoreConfig.StaticJobLabels["UNEMPLOYED"] = "Unemployed"

---------------------------------------------------------------------------
-- Police Job Config (If enabled)
---------------------------------------------------------------------------
---------------------------------------------------------------------------
-- Police Job Config, edit to your requirements
---------------------------------------------------------------------------
JobsCoreConfig.PoliceJobLabels = {}
---------------------------------------------------------------------------
JobsCoreConfig.PoliceJobLabels["POLICE"] = "Police Officer"
JobsCoreConfig.PoliceJobLabels["STATE"] = "State Trooper"
JobsCoreConfig.PoliceJobLabels["SHERIFF"] = "Sheriff Deputy"
---------------------------------------------------------------------------
JobsCoreConfig.Requirements["POLICE"] = "police" -- Database Table Name
JobsCoreConfig.Requirements["STATE"] = "state" -- Database Table Name
JobsCoreConfig.Requirements["SHERIFF"] = "sheriff" -- Database Table Name
