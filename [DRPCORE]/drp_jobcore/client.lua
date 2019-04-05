---------------------------------------------------------------------------
-- Job Core Events (DO NOT TOUCH!)
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    TriggerServerEvent("DRP_JobCore:StartUp")
end)