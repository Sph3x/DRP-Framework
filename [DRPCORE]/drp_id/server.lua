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

RegisterServerEvent("DRP_ID:RequestChangeCharacter")
AddEventHandler("DRP_ID:RequestChangeCharacter", function()
	local src = source
	local characterInfo = GetCharacterData(src)
	for a = 1, #character do
		if character[a].id == characterInfo.charid then
			table.remove(character, a)
		end
	end
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

---------------------------------------------------------------------------
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
	local modelToAdd = nil
	if newCharacterData.gender == "Male" then
	modelToAdd = "mp_m_freemode_01"
	elseif newCharacterData.gender == "Female" then
		modelToAdd = "mp_f_freemode_01"
	end
	TriggerEvent("DRP_Core:GetPlayerData", src, function(playerData)
		exports["externalsql"]:DBAsyncQuery({
			string = "SELECT * FROM `characters` WHERE `playerid` = :playerid",
			data = {
				playerid = playerData.playerid
			}
		}, function(characters)
			Wait(500)
			local characterCount = #characters["data"]
			if characterCount < DRPCharacters.MaxCharacters then
				exports["externalsql"]:DBAsyncQuery({
					string = [[
						INSERT INTO characters
						(`name`, `age`, `gender`, `model`, `cash`, `bank`, `licenses`, `playerid`)
						VALUES
						(:name, :age, :gender, :model, :cash, :bank, :licenses, :playerid)
					]],
					data = {
						name = newCharacterData.name,
						age = newCharacterData.age,
						gender = newCharacterData.gender,
						model = modelToAdd,
						cash = DRPCharacters.StarterCash,
						bank = DRPCharacters.StarterBank,
						licenses = json.encode({}),
						playerid = playerData.playerid
					}
				}, function(createdResults)
					TriggerEvent("DRP_ID:UpdateCharactersInUI", src)
				end)
			else
				TriggerClientEvent("DRP_Core:Error", src, "Characters", "You have ran out of Character spaces, the max is "..DRPCharacters.MaxCharacters.."", 2500, false, "leftCenter")
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
		local playerModel = characterInfo["data"][1].model
		table.insert(character, {id = src, charid = character_id, playerid = characterInfo.data[1].playerid, gender = characterInfo.data[1].gender, name = characterInfo.data[1].name, age = characterInfo.data[1].age})
				exports["externalsql"]:DBAsyncQuery({
					string = "SELECT * FROM `character_clothing` WHERE `char_id` = :charid",
					data = {
						charid = character_id
					}
				}, function(characterModel)
			if json.encode(characterModel["data"]) == "[]" then
				addNewCharacterClothing(src, character_id, characterInfo["data"][1].model, characterInfo["data"][1].lastLocation)
			else
				local spawn = json.decode(characterInfo["data"][1].lastLocation)
				TriggerClientEvent("DRP_ID:LoadSelectedCharacter", src, characterModel["data"][1].skin, spawn)
			end
		end)
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
			local spawn = json.decode(characterModel["data"][1].lastLocation)
			TriggerClientEvent("DRP_ID:LoadSelectedCharacter", src, characterData.model, spawn)
		end)
	end)
end)
---------------------------------------------------------------------------
-- Drop Player Function
---------------------------------------------------------------------------
RegisterServerEvent("DRP_ID:Disconnect")
AddEventHandler("DRP_ID:Disconnect", function()
	local src = source
	DropPlayer(src, "Disconnected From Server Using The Disconnect Button!")
end)

RegisterServerEvent("DRP_ID:SaveCharacterLocation")
AddEventHandler("DRP_ID:SaveCharacterLocation", function(x,y,z)
	local src = source
	local character = GetCharacterData(src)
	local lastPos = "{"..x..", "..y..", "..z.."}"
	exports["externalsql"]:DBAsyncQuery({
		string = "UPDATE characters SET `lastLocation` = :lastLocation WHERE `id` = :char_id",
		data = {
			lastLocation = lastPos,
			char_id = character.charid
		}
	}, function(results)
	end)
end)

function addNewCharacterClothing(source, characterId, model, spawnLocation)
	local model = model
	local spawn = spawnLocation
	local src = source
	exports["externalsql"]:DBAsyncQuery({
		string = "INSERT INTO `character_clothing` SET `skin` = :model, `char_id` = :charid",
		data = {
			model = model,
			charid = characterId
		}
	}, function(yeet)
		Wait(500)
		exports["externalsql"]:DBAsyncQuery({
			string = "SELECT * FROM `character_clothing` WHERE `char_id` = :charid",
			data = {
				charid = characterId
			}
		}, function(characterModel)
			TriggerClientEvent("DRP_ID:LoadSelectedCharacter", src, characterModel["data"][1].skin, spawn)
		end)
	end)
end
---------------------------------------------------------------------------
function GetCharacterData(id)
	for a = 1, #character do
		if character[a].id == id then
			return(character[a])
		end
	end
	return false
end
---------------------------------------------------------------------------
function GetCharacterName(id)
	for a = 1, #character do
		if character[a].id == id then
			return(character[a].name)
		end
	end
	return false
end
---------------------------------------------------------------------------
AddEventHandler("DRP_ID:GetCharacterData", function(id, callback)
		for a = 1, #character do
			if character[a].id == id then
				callback(character[a])
				return
			end
		end
	callback(false)
end)
---------------------------------------------------------------------------
AddEventHandler("playerDropped", function()
    for a = 1, #character do
        if character[a].id == id then
            table.remove(character, a)
            break
        end
    end
end)