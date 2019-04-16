local doors = DRPDoorsConfig.Doors

RegisterServerEvent("DRP_Doors:StartSync")
AddEventHandler("DRP_Doors:StartSync", function()
    local src = source
    local job = exports["drp_jobcore"]:GetPlayerJob(src)
    TriggerClientEvent("DRP_Doors:DoorSync", src, doors)
    TriggerClientEvent("DRP_Doors:RankSync", src, job)
end)

RegisterServerEvent("DRP_Doors:UpdateDoorStatus")
AddEventHandler("DRP_Doors:UpdateDoorStatus", function(newDoorsStatus)
    doors = newDoorsStatus
    TriggerClientEvent("DRP_Doors:DoorSync", -1, doors)
end)

RegisterServerEvent("DRP_Doors:UpdatePlayerJob")
AddEventHandler("DRP_Doors:UpdatePlayerJob", function(source)
    local src = source
    local job = exports["drp_jobcore"]:GetPlayerJob(src)
    TriggerClientEvent("DRP_Doors:RankSync", src, job)
    print("THIS IS WEREADAWJDAWJDJ")
end)