--[[Info]]--


--[[Register]]--

RegisterServerEvent("clothing_shop:SetItems_server")
RegisterServerEvent("skin_customization:SpawnPlayer")
RegisterServerEvent("clothing_shop:SaveItem_server")
RegisterServerEvent("clothing_shop:GetSkin_server")
RegisterServerEvent("clothing_shop:WithDraw_server")

--[[Function]]--

function getPlayerID(source)
	return getIdentifiant(GetPlayerIdentifiers(source))
end

function getIdentifiant(id)
	for _, v in ipairs(id) do
		return v
	end
end

-- Gives you the column name for a collection and id given
-- collection can be "skin", valueId can be null)
-- 					 "component", requires a valueId
-- 					 "prop", requires a valueId
function giveColumnName(collection, valueId)
    local res = nil
    if (collection == "skin") then
        res = "skin"
    else
        local id = tonumber(valueId)
        if (collection == "component") then
        	if (id == 0) then
        	    res = "face"
        	end
        	if (id == 1) then
        	    res = "mask"
        	end
        	if (id == 2) then
        	    res = "hair"
        	end
        	if (id == 3) then
        	    res = "gloves"
        	end
        	if (id == 4) then
        	    res = "pants"
        	end
        	if (id == 5) then
        	    res = "bag"
        	end
        	if (id == 6) then
        	    res = "shoes"
        	end
        	if (id == 8) then
        	    res = "shirt"
        	end
        	if (id == 9) then
        	    res = "vest"
        	end
        	if (id == 11) then
        	    res = "jacket"
        	end
		else
			if (collection == "prop") then
				if (id == 0) then
					res = "hat"
				end
				if (id == 1) then
					res = "glasses"
				end
				if (id == 2) then
					res = "ears"
				end
			end
		end
	end
 	return res
end

function updatePlayerClothes1(source,values)
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
		exports["externalsql"]:DBAsyncQuery({
			string = "UPDATE character_clothing SET `skin` = :value WHERE `char_id` = :charid",
			data = {
				value = values,
				charid = character.charid
			}
		}, function(updatedSkin)
	end)
end

function updatePlayerClothes2(name,values,textures, source)
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
		exports["externalsql"]:DBAsyncQuery({
			string = "UPDATE character_clothing SET "..name.." = :value, "..name..'_texture'.." = :texture_value WHERE `char_id` = :charid",
			data = {
				value = values,
				texture_value = textures,
				charid = character.charid
			}
		}, function(updatedTextures)
	end)
end

-- function getSPlayerSkin(source)
-- 	local src = source
-- 	TriggerEvent("DRP_ID:GetCharacterData", src, function(characterId)
-- 		exports["externalsql"]:DBAsyncQuery({
-- 			string = "SELECT skin FROM `character_clothing` WHERE `char_id` = :character_id",
-- 			data = {
-- 				character_id = characterId
-- 			}
-- 		}, function(characterSkin)
-- 			return characterClothing["data"]
-- 		end)
-- 	end)
-- end

--[[Events]]--
RegisterServerEvent("clothing_shop:SpawnPlayer_server")
AddEventHandler("clothing_shop:SpawnPlayer_server", function()
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
		exports["externalsql"]:DBAsyncQuery({
			string = "SELECT * FROM `character_clothing` WHERE `char_id` = :charid",
			data = {
				charid = character.charid
			}
		}, function(characterClothing)
		if json.encode(characterClothing["data"]) == "[]" then
			print("need new stuff for moi")
			exports["externalsql"]:DBAsyncQuery({
				string = "INSERT INTO `character_clothing` SET `char_id` = :charid",
				data = {
					charid = character.charid
				}
			}, function(yeet)
			end)
			TriggerClientEvent("clothing_shop:loadItems_client", src, characterClothing["data"])
		else
			TriggerClientEvent("clothing_shop:loadItems_client", src, characterClothing["data"])
		end
	end)
end)

RegisterServerEvent("clothing_shop:ResetClothing")
AddEventHandler("clothing_shop:ResetClothing", function(source)
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
		exports["externalsql"]:DBAsyncQuery({
			string = "SELECT * FROM `character_clothing` WHERE `char_id` = :charid",
			data = {
				charid = character.charid
			}
		}, function(characterClothing)
		TriggerClientEvent("clothing_shop:reloadItems_client", src, characterClothing["data"])
	end)
end)

AddEventHandler("clothing_shop:SetItems_servers", function()
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
		exports["externalsql"]:DBAsyncQuery({
			string = "SELECT * FROM `character_clothing` WHERE `char_id` = :character_id",
			data = {
				character_id = character.charid
			}
		}, function(results)
		TriggerClientEvent("clothing_shop:loadItems_client", source, results["data"])
	end)
end)

AddEventHandler("clothing_shop:SaveItem_server", function(item, values)
	local src = source
	if (giveColumnName(item.collection, item.id) == "skin") then
		updatePlayerClothes1(src, values.value)
	else
		updatePlayerClothes2(giveColumnName(item.collection, item.id),values.value,values.texture_value, src)
	end
end)

AddEventHandler("clothing_shop:GetSkin_server",function()
	TriggerClientEvent("clothing_shop:getSkin_client", source, getSPlayerSkin())
end)