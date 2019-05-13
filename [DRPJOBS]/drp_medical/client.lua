RegisterNUICallback("revive", function(data, cb)
    local target, distance = GetClosestPlayer()
        if distance ~= -1 and distance < 3 then
        TriggerServerEvent("ISRP_Interactions:CheckRevive", GetPlayerServerId(target))
        cb("ok")
    end
end)

RegisterNUICallback("heal", function(data, cb)
    local target, distance = GetClosestPlayer()
        if distance ~= -1 and distance < 3 then
        TriggerServerEvent("ISRP_Interactions:CheckHeal", GetPlayerServerId(target))
    cb("ok")
    end
end)