local vehicleKeys = {}
---------------------------------------------------------------------------
-- VEHICLE CHECKER IF PLAYER HAS KEYS TO VEHICLES OR NOT ANY KEYS AT ALL
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
-- GIVE KEYS TO VEHICLE
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