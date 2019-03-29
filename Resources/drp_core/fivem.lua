local firstSpawn = true
---------------------------------------------------------------------------
-- Spawning player into server.. Setup char menu etc..
---------------------------------------------------------------------------
AddEventHandler('playerSpawned', function()
    if firstSpawn then
        Citizen.Wait(250)
        TriggerServerEvent("DRP_ID:OpenMenu")
        firstSpawn = false
    end
end)