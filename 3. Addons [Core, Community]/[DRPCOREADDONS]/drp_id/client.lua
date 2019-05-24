local characterSpawnedIn = false
local firstSpawn = true
---------------------------------------------------------------------------
-- NUI EVENTS
---------------------------------------------------------------------------
RegisterNetEvent("DRP_ID:OpenMenu")
AddEventHandler("DRP_ID:OpenMenu", function(characters)
	SetNuiFocus(true, true)
	Citizen.Wait(2500)
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
	characterSpawnedIn = true
	exports["spawnmanager"]:spawnPlayer({x = spawn[1], y = spawn[2], z = spawn[3], heading = 0.0, model = ped})
	Citizen.Wait(4000)
	local ped = GetPlayerPed(PlayerId())
    SetPlayerInvisibleLocally(PlayerId(), false)
    SetEntityVisible(ped, true)
	SetPlayerInvincible(PlayerId(), false)
	SetPedDefaultComponentVariation(ped)
	---------------------------------------------------------------------------
	TriggerEvent("DRP_ID:StopSkyCamera")
	TriggerEvent("DRP_ID:StopCreatorCamera") -- If using this system
	TriggerServerEvent("DRP_Clothing:FirstSpawn") -- If Clothing Is Installed
	TriggerServerEvent("DRP_Death:GetDeathStatus")
	TriggerServerEvent("DRP_Doors:StartSync") -- If Doors is Installed
	TriggerServerEvent("DRP_Tattoos:GetTattoos") -- If Tattoos is Installed
	---------------------------------------------------------------------------
end)
---------------------------------------------------------------------------
-- MAIN THREAD
---------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = GetPlayerPed(PlayerId())
		local pedCoords = GetEntityCoords(ped, false)
		for a = 1, #DRPCharacters.ChangeCharacterLocations do 
			local distance = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, DRPCharacters.ChangeCharacterLocations[a].x, DRPCharacters.ChangeCharacterLocations[a].y, DRPCharacters.ChangeCharacterLocations[a].z)
			if distance <= 7.0 then
				exports['drp_core']:DrawText3Ds(DRPCharacters.ChangeCharacterLocations[a].x, DRPCharacters.ChangeCharacterLocations[a].y, DRPCharacters.ChangeCharacterLocations[a].z, tostring("~b~[E]~w~ To Change Character"))
				if IsControlJustPressed(1, 86) then 
					TriggerServerEvent("DRP_ID:RequestChangeCharacter")
					characterSpawnedIn = false
				end
			end
		end
		Citizen.Wait(0)
	end
end)
---------------------------------------------------------------------------
-- SAVE CHARACTERS LOCATION THREAD
---------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(20000)
		if characterSpawnedIn then
			local ped = GetPlayerPed(PlayerId())
			local coords = GetEntityCoords(ped)
			TriggerServerEvent("DRP_ID:SaveCharacterLocation", coords.x, coords.y, coords.z)
		else
			Citizen.Trace("You have not spawned in yet, not saving location...")
		end
    end
end)

function SpawnedInAndLoaded()
	return characterSpawnedIn
end