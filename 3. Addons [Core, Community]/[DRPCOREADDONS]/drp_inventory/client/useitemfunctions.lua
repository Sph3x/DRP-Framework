local playingAnimation = false

AddEventHandler("DRP_Inventory:eat", function()
	if not playingAnimation then
		local propName = "prop_cs_burger_01"
		playingAnimation = true
		TriggerServerEvent("DRP_Inventory:UsedItem", "burger")
		Citizen.CreateThread(function()
			local ped = GetPlayerPed(PlayerId())
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local prop = CreateObject(GetHashKey(propName), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(ped, 18905)
			AttachEntityToEntity(prop, ped, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			RequestAnimDict('mp_player_inteat@burger')
			while not HasAnimDictLoaded('mp_player_inteat@burger') do
            	Citizen.Wait(0)
        	end
			TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 1.0, -1.0, 2000, 0, 1, true, true, true)

			Citizen.Wait(3000)
			playingAnimation = false
			ClearPedSecondaryTask(ped)
			DeleteObject(prop)
		end)
	end
end)

AddEventHandler("DRP_Inventory:drink", function()
	if not playingAnimation then
		local propName = "prop_ld_flow_bottle"
		playingAnimation = true
		TriggerServerEvent("DRP_Inventory:UsedItem", "water")
		Citizen.CreateThread(function()
			local ped = GetPlayerPed(PlayerId())
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local prop = CreateObject(GetHashKey(propName), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(ped, 18905)
			AttachEntityToEntity(prop, ped, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			RequestAnimDict('mp_player_intdrink')
			while not HasAnimDictLoaded('mp_player_intdrink') do
            	Citizen.Wait(0)
        	end
			TaskPlayAnim(ped, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

			Citizen.Wait(3000)
			playingAnimation = false
			ClearPedSecondaryTask(ped)
			DeleteObject(prop)
		end)
	end
end)

AddEventHandler("DRP_Inventory:drug", function()
	print("ayhdhawdnawhd")
end)