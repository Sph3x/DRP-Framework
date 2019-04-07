local doors = DRPDoorsConfig.Doors

RegisterServerEvent("DRP_Doors:StartSync")
AddEventHandler("DRP_Doors:StartSync", function()
    local src = source
    TriggerClientEvent("DRP_Doors:DoorSync", src, doors)
end)

RegisterServerEvent("DRP_Doors:UpdateDoorStatus")
AddEventHandler("DRP_Doors:UpdateDoorStatus", function(newDoorsStatus)
    doors = newDoorsStatus
    TriggerClientEvent("DRP_Doors:DoorSync", -1, doors)
end)