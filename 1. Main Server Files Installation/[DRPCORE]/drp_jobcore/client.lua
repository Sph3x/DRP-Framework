---------------------------------------------------------------------------
-- Job Core Events (DO NOT TOUCH!)
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    TriggerServerEvent("DRP_JobCore:StartUp")
end)
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if SpawnedInAndLoaded() then
            TriggerServerEvent("DRP_JobCore:Salary")
        end
        Citizen.Wait(SalaryRecieveTimer)
    end
end)