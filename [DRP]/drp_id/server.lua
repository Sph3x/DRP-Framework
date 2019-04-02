character = {}
---------------------------------------------------------------------------
-- UI Events START
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:RequestOpenMenu")
AddEventHandler("DRP_ID:RequestOpenMenu", function()
	local src = source
	TriggerEvent("DRP_Core:GetPlayerData", src, function(results)
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
	TriggerEvent("DRP_Core:GetPlayerData", player, function(results)
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
	TriggerEvent("DRP_Core:GetPlayerData", src, function(playerData)
		exports["externalsql"]:DBAsyncQuery({
			string = "SELECT * FROM `characters` WHERE `playerid` = :playerid",
			data = {
				playerid = playerData.playerid
			}
		}, function(characters)
			
			local characterCount = #characters["data"]
			if characterCount < DRPCharacters.MaxCharacters then
				exports["externalsql"]:DBAsyncQuery({
					string = [[
						INSERT INTO characters
						(`name`, `age`, `gender`, `model`, `tattoos`, `cash`, `bank`, `licenses`, `playerid`)
						VALUES
						(:name, :age, :gender, :model, :tattoos, :cash, :bank, :licenses, :playerid)
					]],
					data = {
						name = newCharacterData.name,
						age = newCharacterData.age,
						gender = newCharacterData.gender,
						model = "",
						tattoos = json.encode({}),
						cash = DRPCharacters.StarterCash,
						bank = DRPCharacters.StarterBank,
						licenses = json.encode({}),
						playerid = playerData.playerid
					}
				}, function(createdResults)
					TriggerEvent("DRP_ID:UpdateCharactersInUI", src)
				end)
			else
				-- TriggerClientEvent("ISRP_Notification:Error", src, "ISRP Characters", "You have reached the maximum amount of characters allowed", 7500, false, "rightCenter")
				print("no more space")
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
	local playerModelIfNil = ""
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
			local spawn = DRPCharacters.SpawnLocations[math.random(1, #DRPCharacters.SpawnLocations)]
			TriggerClientEvent("DRP_ID:LoadSelectedCharacter", src, characterInfo.data[1].model, spawn)
		else
			local playerGender = characterInfo["data"][1].gender
			if playerGender == "Male" then
				playerModelIfNil = "mp_m_freemode_01"
			elseif playerGender == "Female" then
				playerModelIfNil = "mp_f_freemode_01"
			end
			TriggerEvent("DRP_ID:GetCharacterData", src, function(characterId)
				exports["externalsql"]:DBAsyncQuery({
					string = "UPDATE characters SET `model` = :model WHERE `id` = :char_id",
					data = {
						model = playerModelIfNil,
						char_id = characterId.charid
					}
				}, function(updatedModel)
				end)
			end)
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
	TriggerEvent("DRP_ID:GetCharacterData", src, function(characterId)
		exports["externalsql"]:DBAsyncQuery({
			string = "UPDATE characters SET `model` = :model, `clothing` = :clothing, `tattoos` = :tattoos WHERE `id` = :char_id",
			data = {
				model = characterData.model,
				clothing = json.encode(characterData.clothing),
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

AddEventHandler("DRP_ID:GetCharacterData", function(id, callback)
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