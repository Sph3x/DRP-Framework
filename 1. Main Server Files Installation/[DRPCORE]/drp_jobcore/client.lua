---------------------------------------------------------------------------
-- Job Core Events (DO NOT TOUCH!)
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    TriggerServerEvent("DRP_JobCore:StartUp")
end)
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if exports["drp_id"]:SpawnedInAndLoaded() then
            TriggerServerEvent("DRP_JobCore:Salary")
        end
        Citizen.Wait(JobsCoreConfig.SalaryRecieveTimer)
    end
end)