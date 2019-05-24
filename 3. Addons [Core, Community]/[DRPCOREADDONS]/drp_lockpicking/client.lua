Citizen.CreateThread(function()
    while true do
        if IsControlJustPressed(1, 86) then
            local vehicleFront = GetVehicleInFront()
            if vehicleFront ~= 0 then
            local vehNet = NetworkGetNetworkIdFromEntity(vehicleFront)
            local plate = GetVehicleNumberPlateText(vehicleFront)
                if vehNet ~= 0 then
                    TriggerServerEvent("DRP_Garages:CheckLockPicking", vehNet, plate)
                end
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("DRP_LockPicking:HasKeys")
AddEventHandler("DRP_LockPicking:HasKeys", function(netid, hasKeys)
    local vehicle = NetworkGetEntityFromNetworkId(netid)
    Citizen.CreateThread(function()
        while true do
            local vehicleCoords = GetEntityCoords(vehicle, false)
            local coords = GetEntityCoords(GetPlayerPed(PlayerId()), false)
            local distance = Vdist(vehicleCoords, coords)
            if not IsEntityDead(vehicle) then
                if distance <= 5.0 then
                    if hasKeys then
                        TriggerEvent("DRP_Core:Warning", "Lockpicking", "You already have keys for this", 2000, false, "leftCenter")
                    else
                        exports['drp_core']:DrawText3Ds(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, tostring("~g~[L]~w~ Use Lockpick to break in ~r~[G]~w~ Attempt to break in with your hands"))
                        if IsControlJustPressed(1, 182) then
                            TriggerServerEvent("DRP_LockPicking:UseLockPickOnVehicle")
                        end
                    end
                end
            end
            Citizen.Wait(0)
        end
    end)
end)

function GetVehicleInFront()
	local plyCoords = GetEntityCoords(GetPlayerPed(PlayerId()), false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 5.0, 0.0)
	local rayHandle = StartShapeTestCapsule(plyCoords.x, plyCoords.y, plyCoords.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 10, GetPlayerPed(PlayerId()), 7)
	local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end