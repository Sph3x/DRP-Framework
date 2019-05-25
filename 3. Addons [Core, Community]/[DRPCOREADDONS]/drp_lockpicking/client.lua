local lockpickingVehicle = false
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
	end
end)

Citizen.CreateThread(function()
	while true do
		local ped = GetPlayerPed(PlayerId())
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) then
        	local veh = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
			local lock = GetVehicleDoorLockStatus(veh)
	        if lock == 4 then
	        	ClearPedTasks(ped)
	        end
        end
		Citizen.Wait(0)
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

AddEventHandler("DRP_Inventory:lockpicking", function()
	local ped = GetPlayerPed(PlayerId())
    local vehicle = GetVehicleInFront()
	if vehicle ~= nil then
		local vehNet = NetworkGetNetworkIdFromEntity(vehicle)
		local plate = GetVehicleNumberPlateText(vehicle)
		local lock = GetVehicleDoorLockStatus(vehicle)
		print(lock)
		if lock == 4 or lock == 2 or lock == 7 then
			if vehNet ~= 0 then
				TriggerServerEvent("DRP_Inventory:UsedItem", "lockpick")
				lockpickingVehicle = true
				TriggerEvent("playanimation")
				lockpickVehicle()
				if lockpickVehicle then
					TriggerEvent("DRP_Core:Success", "Vehicle", "You have lockpicked this Vehicle", 2000, false, "leftCenter")
					SetVehicleDoorsLocked(vehicle, 0)
				else
					TriggerEvent("DRP_Core:Error", "Vehicle", "You have not lockpicked this Vehicle", 2000, false, "leftCenter")
				end
			end
		else
			TriggerEvent("DRP_Core:Success", "Vehicle", "This Vehicles doors are already open", 2000, false, "leftCenter")
		end
    end
end)

RegisterNetEvent("playanimation")
AddEventHandler("playanimation", function()
	local ped = GetPlayerPed(PlayerId())
	RequestAnimDict("veh@break_in@0h@p_m_one@")
	while not HasAnimDictLoaded("veh@break_in@0h@p_m_one@") do
		Citizen.Wait(0)
	end
	while lockpickingVehicle do
		if not IsEntityPlayingAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3) then
			TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
			Citizen.Wait(1500)
			ClearPedTasks(GetPlayerPed(-1))
		end
		Citizen.Wait(1)
	end
	ClearPedTasks(ped)
end)

function lockpickVehicle()
	local random = math.random(1,5)
	print("result is: "..random)
	Citizen.Wait(8000, 18000)
	if random == 1 then
		lockpickingVehicle = false
		return true
	end
	lockpickingVehicle = false
	return false
end


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