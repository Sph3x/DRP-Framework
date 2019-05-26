local vehicleKeys = {}
---------------------------------------------------------------------------
-- Check 
---------------------------------------------------------------------------
RegisterServerEvent("DRP_LockPicking:CheckLockPicking")
AddEventHandler("DRP_LockPicking:CheckLockPicking", function()
	local src = source
    for a = 1, #vehicleKeys do
        if vehicleKeys[a].owner == src then
            TriggerClientEvent("DRP_LockPicking:HasKeys", src, stolenKeys)
            return
        end
	end
end)
---------------------------------------------------------------------------
-- 
---------------------------------------------------------------------------
RegisterServerEvent("DRP_LockPicking:Keys")
AddEventHandler("DRP_LockPicking:Keys", function(plate, netid)
    local src = source
    local plate = string.lower(plate)
    table.insert(vehicleKeys, {owner = src, networkid = netid, vehiclePlate = plate})
    print(json.encode(vehicleKeys))
    TriggerClientEvent("DRP_LockPicking:HasKeys", src, vehicleKeys)
end)
---------------------------------------------------------------------------
-- 
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Garages:GiveKeys")
AddEventHandler("DRP_Garages:GiveKeys", function(id, plate)
    local src = source
    local vehPlate = string.lower(plate)
    table.insert(vehicleKeys, {owner = src, net = id, vehiclePlate = vehPlate})
    print(json.encode(vehicleKeys))
end)
---------------------------------------------------------------------------
-- C
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Garages:CheckVehicleOwner")
AddEventHandler("DRP_Garages:CheckVehicleOwner", function(netid, plate)
    local src = source
    local plate = string.lower(plate)
    for a = 1, #vehicleKeys do
        if vehicleKeys[a].net == netid  then
            if vehicleKeys[a].owner == src then
                if vehicleKeys[a].vehiclePlate == plate then
                    TriggerClientEvent("DRP_Garages:ToggleExternalLock", src, netid, true)
                    return
                end
            end
        end
    end
    TriggerClientEvent("DRP_Garages:ToggleExternalLock", src, netid, false)
end)