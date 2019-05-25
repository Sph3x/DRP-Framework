---------------------------------------------------------------------------
-- STOP PEOPLE FROM PULLING PEDS OUT OF VEHICLES AND STOP PEOPLE FROM SMASHING THE WINDOW IF THE CAR IS LOCKED
---------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed(-1)
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) then
			local veh = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
			local lock = GetVehicleDoorLockStatus(veh)
			if lock == 7 then
				SetVehicleDoorsLocked(veh, 2)
			end
			local pedd = GetPedInVehicleSeat(veh, -1)
			if pedd then
				SetPedCanBeDraggedOut(pedd, false)
			end
		end
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) then
        	local veh = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
	        local lock = GetVehicleDoorLockStatus(veh)
	        if lock == 4 then
	        	ClearPedTasks(ped)
	        end
        end
	end
end)

Citizen.CreateThread(function()
	while true do
		local ped = GetPlayerPed(PlayerId())
		local vehicle = GetVehiclePedIsIn(ped, false)
		if not IsEntityDead(vehicle) then
			if GetSeatPedIsSatIn(ped) == -1 then
				
			end
		end
		Citizen.Wait(0)
	end
end)

-- TriggerServerEvent("DRP_Garages:CheckLockPicking", vehNet, plate)

RegisterNetEvent("DRP_LockPicking:HasKeys")
AddEventHandler("DRP_LockPicking:HasKeys", function(netid, hasKeys)
	local vehicle = NetworkGetEntityFromNetworkId(netid)
	local ped = GetPlayerPed(PlayerId())
    
end)


function GetSeatPedIsSatIn(ped)
	local vehicle = GetVehiclePedIsIn(ped, false)
    local seatCount = GetVehicleModelNumberOfSeats(GetHashKey(vehicle))
    for a = -1, seatCount do
        local seatedPed = GetPedInVehicleSeat(vehicle, a)
        if seatedPed == ped then
            return a
        end
    end
end

function GetVehicleInFront()
	local plyCoords = GetEntityCoords(GetPlayerPed(PlayerId()), false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 5.0, 0.0)
	local rayHandle = StartShapeTestCapsule(plyCoords.x, plyCoords.y, plyCoords.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 10, GetPlayerPed(PlayerId()), 7)
	local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end