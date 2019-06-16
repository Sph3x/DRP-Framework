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
-- Check Vehicle Owner
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
---------------------------------------------------------------------------
-- Random Reward
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Rob:RandomReward")
AddEventHandler("DRP_Rob:RandomReward", function()
    local src = source
    math.randomseed(os.time())
    local itemRewards = math.random(1,3)
    local random1 = math.random(1, #DRPRob.Rewards)
    local random2 = math.random(1, #DRPRob.Rewards)
    local random3 = math.random(1, #DRPRob.Rewards)
    local reward1 = DRPRob.Rewards[random1]
    local reward2 = DRPRob.Rewards[random2]
    local reward3 = DRPRob.Rewards[random3]
    if itemRewards == 1 then
        print(reward1)
        exports["drp_inventory"]:AddItem(src, reward1, 1)
    elseif itemRewards == 2 then
        print(reward2)
        exports["drp_inventory"]:AddItem(src, reward1, 1)
        Wait(100)
        exports["drp_inventory"]:AddItem(src, reward2, 1)
    elseif itemRewards == 3 then
        print(reward3)
        exports["drp_inventory"]:AddItem(src, reward1, 1)
        Wait(100)
        exports["drp_inventory"]:AddItem(src, reward2, 1)
        Wait(100)
        exports["drp_inventory"]:AddItem(src, reward3, 1)
    end
end)