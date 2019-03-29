AddEventHandler("onClientMapStart", function()
    exports["spawnmanager"]:spawnPlayer()
    exports["spawnmanager"]:setAutoSpawn(false)

    for a = 1, 15 do
        EnableDispatchService(a, false)
    end
end)