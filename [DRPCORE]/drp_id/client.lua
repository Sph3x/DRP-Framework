---------------------------------------------------------------------------
-- NUI EVENTS
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:OpenMenu")
AddEventHandler("DRP_ID:OpenMenu", function(characters)
	SetNuiFocus(true, true)
	TriggerEvent("DRP_ID:StartSkyCamera")
	Citizen.Wait(2200)
	SendNUIMessage({
		type = "open_character_menu",
		characters = characters
	})
end)
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:UpdateMenuCharacters")
AddEventHandler("DRP_ID:UpdateMenuCharacters", function(characters)
	SendNUIMessage({
		type = "update_character_menu",
		characters = characters
	})
end)
---------------------------------------------------------------------------
-- NUI CALLBACKS
---------------------------------------------------------------------------
RegisterNUICallback("CloseMenu", function(data, callback)
	SetNuiFocus(false, false)
	callback("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("SelectYourCharacter", function(data, callback)
	SetNuiFocus(false, false)
	TriggerServerEvent("DRP_ID:SelectCharacter", data.character_selected)
	callback("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("CreateCharacter", function(data, callback)
	TriggerServerEvent("DRP_ID:CreateCharacter", {name = data.name, age = data.age, gender = data.gender})
	callback("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("DeleteCharacter", function(data, callback)
	print(tostring("You Just Deleted Character ID: "..data.character_id))
	TriggerServerEvent("DRP_ID:DeleteCharacter", data.character_id)
	callback("ok")
end)
---------------------------------------------------------------------------
RegisterNUICallback("DisconnectMe", function(callback)
	TriggerServerEvent("DRP_ID:Disconnect")
	callback("ok")
end)
---------------------------------------------------------------------------
-- LOAD CHARACTER FROM SELECTER
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:LoadSelectedCharacter")
AddEventHandler("DRP_ID:LoadSelectedCharacter", function(ped, spawn)
	exports["spawnmanager"]:spawnPlayer({x = spawn.x, y = spawn.y, z = spawn.z, heading = spawn.h, model = ped})
	Citizen.Wait(4000)
	print("loading characters")
	TriggerEvent("DRP_ID:StopSkyCamera")
	TriggerEvent("DRP_ID:StopCreatorCamera")
	TriggerServerEvent("DRP_Death:GetDeathStatus")
	-- TriggerServerEvent("clothing_shop:SpawnPlayer_server")
	-- Add Your Spawn In Stuff Here
	local ped = GetPlayerPed(PlayerId())
	SetPedDefaultComponentVariation(ped)
    SetPlayerInvisibleLocally(PlayerId(), false)
    SetEntityVisible(ped, true)
	SetPlayerInvincible(PlayerId(), false)
end)