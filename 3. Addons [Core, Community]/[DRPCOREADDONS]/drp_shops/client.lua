local messageDisplaying = 0.10
Citizen.CreateThread(function()
    for k,v in ipairs(DRPShops.FoodStoresAssistant) do
		RequestModel(GetHashKey(v.model))
		while not HasModelLoaded(GetHashKey(v.model)) do
			Wait(0)
		end

		local storePed = CreatePed(4, GetHashKey(v.model), v.x, v.y, v.z, v.a, false, false)
		SetBlockingOfNonTemporaryEvents(storePed, true)
		SetAmbientVoiceName(storePed, v.voice)
		TaskStartScenarioInPlace(storePed, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, 0)

		SetModelAsNoLongerNeeded(GetHashKey(v.model))
	end
    while true do
        local ped = GetPlayerPed(PlayerId())
        local coords = GetEntityCoords(ped, false)
        for a = 1, #DRPShops.ShopLocations do
            local distance = Vdist(coords.x, coords.y, coords.z, DRPShops.ShopLocations[a].x, DRPShops.ShopLocations[a].y, DRPShops.ShopLocations[a].z)
            if distance <= 10.0 then
                DrawMarker(25, DRPShops.ShopLocations[a].x, DRPShops.ShopLocations[a].y, DRPShops.ShopLocations[a].z - 1.0, 0, 0, 0, 0, 0, 0, 3.001, 3.0001, 0.5001, 0, 100, 255, 200, 0, 0, 0, 0)
                if distance <= 3.0 then
					exports['drp_core']:DrawText3Ds(DRPShops.ShopLocations[a].x, DRPShops.ShopLocations[a].y, DRPShops.ShopLocations[a].z + 0.3, tostring("Press ~b~[E]~w~ to open shop menu"))
					if IsControlJustPressed(1, 86) then
						TriggerEvent("DRP_Shops:OpenShopMenu")
					end
				end
            end
        end
        Citizen.Wait(1)
    end
end)

RegisterNetEvent("DRP_Shops:OpenShopMenu")
AddEventHandler("DRP_Shops:OpenShopMenu", function()
	print("opened shop menu")
	SetNuiFocus(true, true)
    SendNUIMessage({
        type = "open_shop_menu"
    })
end)

RegisterNUICallback("close_shop", function(data, callback)
	SetNuiFocus(false, false)
end)

RegisterNUICallback("purchase_bandage", function(data, callback)
	local itemid = 14
	local price = 35
	-- TriggerServerEvent("ISRP_Inventory:CheckBeforeAdding", itemid)
	TriggerServerEvent("ISRP_Shop:CheckMoney", price, itemid)
end)

RegisterNUICallback("purchase_lockpick", function(data, callback)
	local itemid = 16
	local price = 200
	-- TriggerServerEvent("ISRP_Inventory:CheckBeforeAdding", itemid)
	TriggerServerEvent("ISRP_Shop:CheckMoney", price, itemid)
end)

RegisterNUICallback("purchase_repairkit", function(data, callback)
	local itemid = 15
	local price = 100
	-- TriggerServerEvent("ISRP_Inventory:CheckBeforeAdding", itemid)
	TriggerServerEvent("ISRP_Shop:CheckMoney", price, itemid)
end)

RegisterNetEvent("WhyClientAndBackIScuffedIt")
AddEventHandler("WhyClientAndBackIScuffedIt", function(itemid)
	TriggerServerEvent("ISRP_Inventory:CheckBeforeAdding", itemid)
end)

RegisterNetEvent("3dtextcoolness")
AddEventHandler("3dtextcoolness", function(message, offset)
	meTimer = true
	Citizen.CreateThread(function()
		Wait(5000)
		meTimer = false
	end)
	Citizen.CreateThread(function()
		messageDisplaying = messageDisplaying + 1
		while meTimer do
			Wait(0)
			local coords = GetEntityCoords(GetPlayerPed(pid), false)
			DrawText3Ds(coords['x'], coords['y'], coords['z']+offset, message)
		end
		messageDisplaying = messageDisplaying - 1
	end)
end)