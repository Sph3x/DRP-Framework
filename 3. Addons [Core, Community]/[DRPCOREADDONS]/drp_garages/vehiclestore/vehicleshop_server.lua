---------------------------------------------------------------------------
-- VEHICLE SHOP EVENTS START
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Garages:CheckMoneyForVehicle")
AddEventHandler("DRP_Garages:CheckMoneyForVehicle", function(vehicle, price)
	local src = source
	print("this getting triggered?")
	TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
		TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
			if characterMoney.data[1].bank >= tonumber(price) then
			Wait(555)
			TriggerClientEvent("DRP_Garages:FinishMoneyCheckForVeh", src, vehicle, price)
			print(vehicle)
		else
			TriggerClientEvent("DRP_Core:Error", src, "Vehicle Store", "You do not have enough money for this Vehicle", 2500, false, "leftCenter")
			end
		end)
	end)
end)


RegisterServerEvent("DRP_Garages:PurchaseVehicle")
AddEventHandler("DRP_Garages:PurchaseVehicle", function(price, model, plate, currentVhl )
	local src = source
	print(json.encode(currentVhl))
	TriggerEvent("DRP_ID:GetCharacterData", src, function(CharacterData)
		TriggerEvent("DRP_Bank:GetCharacterMoney", CharacterData.charid, function(characterMoney)
			TriggerEvent("DRP_Bank:RemoveBankMoney", src, price)
			local vehicle = vehicle
			local plate = plate
			local primarycolor = primarycolor
			local secondarycolor = secondarycolor
			local pearlescentcolor = pearlescentcolor
			local wheelcolor = wheelcolor
			local state = "OUT"
			if price == 0 or price == 1 then
				TriggerEvent("ISRP_Admin:ManualBan", src, cheatengine, true)
			else
					exports["externalsql"]:DBAsyncQuery({
						string = [[
						INSERT INTO vehicles
						(`model`, `plate`, `primarycolor`, `secondarycolor`, `pearlescentColor`, `wheelColor`, `state`, `charactername`, `char_id`)
						VALUES
						(:model, :plate, :primarycolor, :secondarycolor, :pearlescentcolor, :wheelcolor, :state, :charactername, :charid)
						]],
						data = {
							model = model,
							plate = plate,
							primarycolor = currentVhl.primary_type,
							secondarycolor = currentVhl.secondary_type,
							pearlescentcolor = 1,
							wheelcolor = currentVhl.wheelcolor,
							state = "OUT",
							charactername = CharacterData.name,
							charid = CharacterData.charid
						}
					}, function(vehicleAdd)
				end)
			end
		end)
	end)
end)
---------------------------------------------------------------------------
-- VEHICLE SHOP EVENTS END
---------------------------------------------------------------------------