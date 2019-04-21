local spawnedPlants = 0
local pickingUpWeed = false
local removingPlantsAllowed = false
local plants = {}
---------------------------------------------------------------------------
-- Main Threads
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    for _, item in pairs(DRPDrugsConfig.WeedLocations) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, 496)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Weed Field")
        EndTextCommandSetBlipName(item.blip)
	end
	for _, item in pairs(DRPDrugsConfig.WeedProcessingLocations) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, 496)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Weed Processing Field")
        EndTextCommandSetBlipName(item.blip)
	end
    while true do
		local ped = GetPlayerPed(PlayerId())
        local coords = GetEntityCoords(ped)
        for a = 1, #DRPDrugsConfig.WeedLocations do
        local distance = Vdist(coords.x, coords.y, coords.z, DRPDrugsConfig.WeedLocations[a].x, DRPDrugsConfig.WeedLocations[a].y, DRPDrugsConfig.WeedLocations[a].z)
            if distance <= 55.0 then
                spawnPlants()
                Citizen.Wait(700)
            else
                Citizen.Wait(700)
			end
			if spawnedPlants > 5 and distance >= 250.0 and removingPlantsAllowed then
				table.remove(plants, a)
				removingPlantsAllowed = false
			end
		end
		Citizen.Wait(1)
    end
end)
---------------------------------------------------------------------------
Citizen.CreateThread(function()
	local dict = "pickup_object"
    local ped = GetPlayerPed(PlayerId())
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
	while true do
		local ped = GetPlayerPed(PlayerId())
		local coords = GetEntityCoords(ped, false)
		nearbyObj, nearbyId = nil

		for a = 1, #plants do 
			local distance = Vdist(coords, GetEntityCoords(plants[a]), false)
				if distance <= 1.5 then
					nearbyObj, nearbyId = plants[a], a
				end
			end

		if nearbyObj and IsPedOnFoot(ped) then
			if not pickingUpWeed then
				exports["drp_core"]:drawText('Press ~b~E~s~ to Collect this Weed Plant',0,1,0.5,0.8,0.6,255,255,255,255)
				if IsControlJustPressed(1, 38) then
					pickingUpWeed = true
					TriggerServerEvent("DRP_Inventory:CheckInventorySpace")
				end
			end
		end
		for b = 1, #DRPDrugsConfig.WeedProcessingLocations do
			local distance = Vdist(coords.x, coords.y, coords.z, DRPDrugsConfig.WeedProcessingLocations[b].x, DRPDrugsConfig.WeedProcessingLocations[b].y, DRPDrugsConfig.WeedProcessingLocations[b].z)
			if distance <= 5.0 then
				exports["drp_core"]:drawText('Press ~b~E~s~ to Process your Weed',0,1,0.5,0.8,0.6,255,255,255,255)
				if IsControlJustPressed(1, 86) then
					TaskPlayAnim(GetPlayerPed(PlayerId()), dict, "pickup_low", 6.0, 4.0, -1, 100, 0, false, false, false)
					Citizen.Wait(2000)
					ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
					TriggerServerEvent("DRP_Drugs:ProcessItem", "marijuana")
				end
			end
		end
		Citizen.Wait(1)
	end
end)
---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Drugs:GiveWeed")
AddEventHandler("DRP_Drugs:GiveWeed", function()
	local ped = GetPlayerPed(PlayerId())
	TaskStartScenarioInPlace(ped, 'world_human_gardener_plant', 0, false)

	Citizen.Wait(3500)
	ClearPedTasks(ped)
	ClearPedTasksImmediately(ped)
	Citizen.Wait(500)
	deleteObject(nearbyObj)

	table.remove(plants, nearbyId)
	spawnedPlants = spawnedPlants - 1
	TriggerServerEvent("DRP_Inventory:AddItem", "weed")

	pickingUpWeed = false
end)
---------------------------------------------------------------------------
-- Functions
---------------------------------------------------------------------------
function spawnPlants()
	while spawnedPlants < 35 do
		removingPlantsAllowed = true
		Citizen.Wait(88)
        local weedCoords = GenerateWeedCoords()
		exports["drp_inventory"]:CreateLocalPickupObject('prop_weed_02', {
            x = weedCoords.x,
            y = weedCoords.y,
            z = weedCoords.z,
        }, function(obj)

			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			SetEntityCollision(obj, false, true)

			table.insert(plants, obj)
			spawnedPlants = spawnedPlants + 1
		end)
	end
end
---------------------------------------------------------------------------
function GenerateWeedCoords()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		local modX = math.random(-90, 90)
		Citizen.Wait(100)
		local modY = math.random(-90, 90)

        for a = 1, #DRPDrugsConfig.WeedLocations do
            weedCoordX = DRPDrugsConfig.WeedLocations[a].x + modX
            weedCoordY = DRPDrugsConfig.WeedLocations[a].y + modY
        end

		local coordZ = GetCoordZ(weedCoordX, weedCoordY)
		local coord = {x = weedCoordX, y = weedCoordY, z = coordZ}

		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end
---------------------------------------------------------------------------
function ValidateWeedCoord(plantCoord)
	if spawnedPlants > 0 then
		local validate = true

        for a = 1, #plants do
            local distance = Vdist(plantCoord.x, plantCoord.y, plantCoord.z, GetEntityCoords(plants[a]))
			if distance <= 5.0 then
				validate = false
				break
			end
        end

        for a = 1, #DRPDrugsConfig.WeedLocations do
        local distance = Vdist(DRPDrugsConfig.WeedLocations[a].x, DRPDrugsConfig.WeedLocations[a].y, DRPDrugsConfig.WeedLocations[a].z, plantCoord.x, plantCoord.y, plantCoord.z)
            if distance <= 55.0 then
				validate = false
				break
            end
        end
		return validate
	else
		return true
	end
end
---------------------------------------------------------------------------
function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
        local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
        
		if foundGround then
			return z
		end
	end

	return 43.0
end
---------------------------------------------------------------------------
function deleteObject(plants)
	SetEntityAsMissionEntity(plants, false, true)
	DeleteObject(plants)
end
---------------------------------------------------------------------------
function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end
---------------------------------------------------------------------------
-- Handlers
---------------------------------------------------------------------------
RegisterCommand("myCoords", function()	
	local ped = GetPlayerPed(PlayerId())
	local coords = GetEntityCoords(ped, false)
	print(coords)
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(plants) do
			deleteObject(v)
		end
	end
end)