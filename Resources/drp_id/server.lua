character = {}
---------------------------------------------------------------------------
-- UI Events START
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:RequestOpenMenu")
AddEventHandler("DRP_ID:RequestOpenMenu", function()
	local src = source
	TriggerEvent("ISRP_Admin:GetPlayerData", src, function(results)
		exports["externalsql"]:DBAsyncQuery({
			string = "SELECT * FROM `characters` WHERE `playerid` = :playerid",
			data = {playerid = results.playerid}
		}, function(characters)
			local characters = characters["data"]
			TriggerClientEvent("DRP_ID:OpenMenu", src, characters)
		end)
	end)
end)

AddEventHandler("DRP_ID:UpdateCharactersInUI", function(player)
	TriggerEvent("ISRP_Admin:GetPlayerData", player, function(results)
		exports["externalsql"]:DBAsyncQuery({
			string = "SELECT * FROM `characters` WHERE `playerid` = :playerid",
			data = {playerid = results.playerid}
		}, function(characters)
			local characters = characters["data"]
			TriggerClientEvent("DRP_ID:UpdateMenuCharacters", player, characters)
		end)
	end)
end)
---------------------------------------------------------------------------
-- CREATE CHARACTER EVENT
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:CreateCharacter")
AddEventHandler("DRP_ID:CreateCharacter", function(newCharacterData)
	local src = source
	TriggerEvent("ISRP_Admin:GetPlayerData", src, function(playerData)
		exports["externalsql"]:DBAsyncQuery({
			string = "SELECT * FROM `characters` WHERE `playerid` = :playerid",
			data = {
				playerid = playerData.playerid
			}
		}, function(characters)
			
			local characterCount = #characters["data"]
			if characterCount < ISRPCharactersConfig.MaxCharacters then
				exports["externalsql"]:DBAsyncQuery({
					string = [[
						INSERT INTO characters
						(`name`, `age`, `gender`, `model`, `clothing`, `props`, `tattoos`, `weapons`, `inventory`, `cash`, `bank`, `licenses`, `playerid`)
						VALUES
						(:name, :age, :gender, :model, :clothing, :props, :tattoos, :weapons, :inventory, :cash, :bank, :licenses, :playerid)
					]],
					data = {
						name = newCharacterData.name,
						age = newCharacterData.age,
						gender = newCharacterData.gender,
						model = "",
						clothing = json.encode({}),
						props = json.encode({}),
						tattoos = json.encode({}),
						weapons = "",
						inventory = json.encode({}),
						cash = ISRPCharactersConfig.StarterCash,
						bank = ISRPCharactersConfig.StarterBank,
						licenses = json.encode({}),
						playerid = playerData.playerid
					}
				}, function(createdResults)
					TriggerEvent("DRP_ID:UpdateCharactersInUI", src)
				end)
			else
				TriggerClientEvent("ISRP_Notification:Error", src, "ISRP Characters", "You have reached the maximum amount of characters allowed", 7500, false, "rightCenter")
			end
		end)
	end)
end)
---------------------------------------------------------------------------
-- SELECT CHARACTER EVENT
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:SelectCharacter")
AddEventHandler("DRP_ID:SelectCharacter", function(character_id)
	local src = source
	exports["externalsql"]:DBAsyncQuery({
		string = "SELECT * FROM `characters` WHERE `id` = :character_id",
		data = {
			character_id = character_id
		}
	}, function(characterInfo)

		table.insert(character, {id = src, charid = character_id, playerid = characterInfo.data[1].playerid, gender = characterInfo.data[1].gender, name = characterInfo.data[1].name, age = characterInfo.data[1].age})

		local model = #characterInfo["data"][1].model
		if model > 0 then
			math.randomseed(os.time())
			print("Found data, now spawning...")
			local spawn = ISRPCharactersConfig.SpawnLocations[math.random(1, #ISRPCharactersConfig.SpawnLocations)]
			TriggerClientEvent("DRP_ID:LoadSelectedCharacter", src, characterInfo.data[1].model, characterInfo.data[1].clothing, spawn)
		else
			print("No data found, opening character modifier!")
			local models = ISRPCharactersConfig.Models[characterInfo.data[1].gender]
			local gender = characterInfo.data[1].gender
			TriggerClientEvent("DRP_ID:OpenCreator", src, models, gender)
		end
	end)
end)

---------------------------------------------------------------------------
-- DELETE CHARACTER EVENT
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:DeleteCharacter")
AddEventHandler("DRP_ID:DeleteCharacter", function(character_id)
	local src = source
	exports["externalsql"]:DBAsyncQuery({
		string = "DELETE FROM `characters` WHERE `id` = :character_id",
		data = {
			character_id = character_id
		}
	}, function(results)
		TriggerEvent("DRP_ID:UpdateCharactersInUI", src)
	end)
end)

---------------------------------------------------------------------------
-- CHARACTER CREATOR SAVE EVENTS
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:SaveCharacter")
AddEventHandler("DRP_ID:SaveCharacter", function(characterData)
	local src = source
	print(json.encode(characterData))
	TriggerEvent("ISRP_Characters:GetCharacterData", src, function(characterId)
		exports["externalsql"]:DBAsyncQuery({
			string = "UPDATE characters SET `model` = :model, `clothing` = :clothing, `props` = :props, `tattoos` = :tattoos WHERE `id` = :char_id",
			data = {
				model = characterData.model,
				clothing = json.encode(characterData.clothing),
				props = json.encode({}),
				tattoos = json.encode({}),
				char_id = characterId.charid
			}
		}, function(results)

			local spawn = DRPCharacters.SpawnLocations[math.random(1, #DRPCharacters.SpawnLocations)]
			TriggerClientEvent("DRP_ID:LoadSelectedCharacter", src, characterData.model, json.encode(characterData.clothing), spawn)
		end)
	end)
end)

function GetCharacterData(id)
	for a = 1, #character do
		if character[a].id == id then
			return(character[a])
		end
	end
	return false
end

function GetCharacterName(id)
	for a = 1, #character do
		if character[a].id == id then
			return(character[a].name)
		end
	end
	return false
end

AddEventHandler("ISRP_Characters:GetCharacterData", function(id, callback)
		for a = 1, #character do
			if character[a].id == id then
				callback(character[a])
				return
			end
		end
	callback(false)
end)

AddEventHandler("playerDropped", function()
    for a = 1, #character do
        if character[a].id == id then
            table.remove(character, a)
            break
        end
    end
end)