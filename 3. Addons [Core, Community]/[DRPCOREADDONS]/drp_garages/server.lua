vehicles = {}
vehicleKeys = {}

RegisterServerEvent("DRP_Garages:RequestOpenMenu")
AddEventHandler("DRP_Garages:RequestOpenMenu", function()
	local src = source
	TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
		exports["externalsql"]:DBAsyncQuery({
			string = "SELECT * FROM `vehicles` WHERE `char_id` = :charid",
			data = {charid = CharacterData.charid}
		}, function(vehicleData)
			local characterVehicles = vehicleData["data"]
			TriggerClientEvent("DRP_Garages:OpenGarageMenu", src, characterVehicles)
		end)
	end)
end)

RegisterServerEvent("DRP_Garages:GetSelectedVehicleData")
AddEventHandler("DRP_Garages:GetSelectedVehicleData", function(vehicle_id)
	local src = source
		exports["externalsql"]:DBAsyncQuery({
			string = "SELECT * FROM `vehicles` WHERE `id` = :vehicleid",
			data = {vehicleid = vehicle_id}
		}, function(selectedVehicleData)
		TriggerClientEvent("DRP_Garages:CreatePersonalVehicle", src, selectedVehicleData)
	end)
end)

RegisterServerEvent("DRP_Garages:RequestStoreVehicle")
AddEventHandler("DRP_Garages:RequestStoreVehicle", function(plate)
 local src = source
 TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
	exports["externalsql"]:DBAsyncQuery({
		string = "SELECT plate FROM `vehicles` WHERE `char_id` = :charid AND `plate` = :plate",
		data = {
			plate = plate, 
			charid = CharacterData.charid
		}
	}, function(selectedVehiclePlate)
			Wait(1000)
			local vehicleOwnership = #selectedVehiclePlate["data"]
			if vehicleOwnership >= 1 then
				TriggerEvent("DRP_Garages:StateChangeIn", plate)
				TriggerClientEvent("DRP_Garages:StoreVehicle", src)
			else
				TriggerClientEvent("DRP_Garages:StoreVehicleFalse", src)
			end
		end)
	end)
end)


--  THESE ARE DONE     enginedamage, damage, plate, plateindex, primarycolor, secondarycolor, pearlescentcolor, wheelcolor, neoncolor1, neoncolor2, neoncolor3, windowtint, xenon, turbo, mods0, mods1, mods2, mods3, mods4, mods5, mods6, mods7, mods8, mods9, mods10, mods11, mods12, mods13, mods14, mods15, mods16, 

--  THESE NEED DOING,, neon0, neon1, neon2, neon3, bulletproof, smokecolor1, smokecolor2, smokecolor3, variation

RegisterServerEvent("DRP_Garages:UpdateVehicle")
AddEventHandler("DRP_Garages:UpdateVehicle", function(enginedamage, damage, plate, plateindex, primarycolor, secondarycolor, pearlescentcolor, wheelcolor, neoncolor1, neoncolor2, neoncolor3, windowtint, wheeltype, mods0, mods1, mods2, mods3, mods4, mods5, mods6, mods7, mods8, mods9, mods10, mods11, mods12, mods13, mods14, mods15, mods16, turbo, tiresmoke, xenon, mods23, mods24, neon0, neon1, neon2, neon3, bulletproof, smokecolor1, smokecolor2, smokecolor3, variation)
	local src = source
	exports["externalsql"]:DBAsyncQuery({
		string = "UPDATE vehicles SET `enginedamage` = :enginedamage, `damage` = :damage, `plate` = :plate, `plateindex` = :plateindex, `primarycolor` = :primarycolor, `secondarycolor` = :secondarycolor, `pearlescentColor` = :pearlescentcolor, `wheelColor` = :wheelcolor, `neoncolor1` = :neoncolor1, `neoncolor2` = :neoncolor2, `neoncolor3` = :neoncolor3, `windowtint` = :windowtint, `wheeltype` = :wheeltype, `turbo` = :turbo, `xenon` = :xenon, `mods0` = :mods0, `mods1` = :mods1, `mods2` = :mods2, `mods3` = :mods3, `mods4` = :mods4, `mods5` = :mods5, `mods6` = :mods6, `mods7` = :mods7, `mods8` = :mods8, `mods9` = :mods9, `mods10` = :mods10, `mods11` = :mods11, `mods12` = :mods12, `mods13` = :mods13, `mods14` = :mods14, `mods15` = :mods15, `mods16` = :mods16, `tiresmoke` = :tiresmoke, `mods23` = :mods23, mods24 = :mods24, `neon0` = :neon0, `neon1` = :neon1, `neon2`= :neon2, `neon3` = :neon3, `bulletproof` = :bulletproof, `smokecolor1` = :smokecolor1, `smokecolor2` = :smokecolor2, `smokecolor3` = :smokecolor3, `variation` = :variation WHERE `plate` = :plate",
		data = {
			enginedamage = enginedamage,
			damage = damage,
			plate = plate,
			plateindex = plateindex, 
			primarycolor = primarycolor, 
			secondarycolor = secondarycolor, 
			pearlescentcolor = pearlescentcolor, 
			wheelcolor = wheelcolor, 
			neoncolor1 = neoncolor1,
			neoncolor2 = neoncolor2, 
			neoncolor3 = neoncolor3, 
			windowtint = windowtint, 
			wheeltype = wheeltype,
			turbo = turbo,
			xenon = xenon,
			mods0 = mods0,
			mods1 = mods1,
			mods2 = mods2, 
			mods3 = mods3, 
			mods4 = mods4,
			mods5 = mods5,
			mods6 = mods6,
			mods7 = mods7, 
			mods8 = mods8,
			mods9 = mods9, 
			mods10 = mods10, 
			mods11 = mods11,
			mods12 = mods12, 
			mods13 = mods13,
			mods14 = mods14, 
			mods15 = mods15,
			mods16 = mods16,
			tiresmoke = tiresmoke,
			mods23 = mods23, 
			mods24 = mods24,
			neon0 = neon0,
			neon1 = neon1,
			neon2 = neon2,
			neon3 = neon3, 
			bulletproof = bulletproof,
			smokecolor1 = smokecolor1,
			smokecolor2 = smokecolor2,
			smokecolor3 = smokecolor3,
			variation = variation

		}
	}, function(results)
		print(json.encode(results))
	end)
end)


RegisterServerEvent("DRP_Garages:StateChangeIn")
AddEventHandler("DRP_Garages:StateChangeIn", function(vehPlate)
	local src = source
	TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
		exports["externalsql"]:DBAsyncQuery({
            string = "UPDATE vehicles SET `state` = :state WHERE `plate` = :plate",
            data = {
                plate = vehPlate,
                state = "IN"
            }
        }, function(results)
		end)
	end)
end)

RegisterServerEvent("DRP_Garages:StateChangeOut")
AddEventHandler("DRP_Garages:StateChangeOut", function(vehPlate)
	local src = source
	TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
		exports["externalsql"]:DBAsyncQuery({
            string = "UPDATE vehicles SET `state` = :state WHERE `plate` = :plate",
            data = {
                plate = vehPlate,
                state = "OUT"
            }
        }, function(results)
		end)
	end)
end)

AddEventHandler("playerDropped", function()
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
	exports["externalsql"]:DBAsyncQuery({
		string = "UPDATE vehicles SET `state` = :state WHERE `char_id` = :charid",
			data = {
				charid = character.charid,
				state = "IN"
			}
		}, function(results)
		print("Player left, now changing vehicles to go back into your Garage!")
	end)
end)

RegisterServerEvent("DRP_CarWash:CheckMoney")
AddEventHandler("DRP_CarWash:CheckMoney", function(cost)
    local src = source
    TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
        TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
            local carWashCost = cost
            if tonumber(characterMoney.data[1].cash) >= tonumber(carWashCost) then
				TriggerClientEvent("DRP_CarWash:YesCleanCar", src)
                TriggerClientEvent("DRP_Core:Info", src, "Car Wash", tostring("Car has been Washed!"), 2500, false, "leftCenter")
                TriggerEvent("DRP_Bank:RemoveCashMoney", src, carWashCost)
            else
                TriggerClientEvent("DRP_Core:Error", src, "Car Wash", tostring("You don't have enough Cash!"), 2500, false, "leftCenter")
            end
        end)
    end)
end)

function GetAllCharacterVehicles(charid)
	for a = 1, #vehicles do 
		if vehicles[a].char_id == charid then
			return(vehicles[a])
		end
	end
	return false
end
