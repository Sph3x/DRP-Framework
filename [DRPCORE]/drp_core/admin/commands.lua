RegisterCommand("admin", function()
    local src = source
    local player = GetPlayerData(src)
    -- if DoesRankHavePerms(playerData.rank, "admin") then
    --     print("yeet")
    --     TriggerClientEvent("chatMessage", src, "My Permission Rank is: "..playerData.rank.."")
    -- end
end, false)

RegisterCommand("time", function(source, args, raw)
    local src = source
    local player = GetPlayerData(src)
    if player ~= false then
        if DoesRankHavePerms(player.rank, "time") then
            local hours = tonumber(args[1])
            local minutes = tonumber(args[2])
            if hours ~= nil and minutes ~= nil then
                if type(hours) ~= "number" then return end
                if type(minutes) ~= "number" then return end
                local results = RemoteSetTime(minutes, hours)
                TriggerClientEvent("chatMessage", src, tostring(results.msg))
            end
        else
            TriggerClientEvent("chatMessage", src, tostring("You do not have permissions to set the time."))
        end
    end
end, false)