local firstSpawn = true
---------------------------------------------------------------------------
-- Spawning player into server.. Setup char menu etc..
---------------------------------------------------------------------------
AddEventHandler('playerSpawned', function()
    if firstSpawn then
        Citizen.Wait(250)
        TriggerServerEvent("DRP_ID:RequestOpenMenu")
        firstSpawn = false
    end
end)
---------------------------------------------------------------------------
AddEventHandler("onClientMapStart", function()
    exports["spawnmanager"]:spawnPlayer()
    exports["spawnmanager"]:setAutoSpawn(false)
    -- Remove Patrolling cars etc.
    for a = 1, 15 do
        EnableDispatchService(a, false)
    end
end)