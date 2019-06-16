local garages = {
	{name="Garage", colour=3, id=357, x=215.124, y=-791.377, z=29.85},
    {name="Garage", colour=3, id=357, x=-334.685, y=289.773, z=84.905},
    {name="Garage", colour=3, id=357, x=-55.272, y=-1838.71, z=25.642},
    {name="Garage", colour=3, id=357, x=126.434, y=6610.04, z=31.00},
	{name="Garage", colour=3, id=357, x=1980.34118652344, y=3775.83911132813, z=31.1813316345215},
	{name="Garage", colour=3, id=357, x=-828.52, y=-749.75, z=22.22},
}

garageSelected = { {x= nil, y = nil, z = nil}, }
---------------------------------------------------------------------------
-- MAIN THREAD
---------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _, item in pairs(garages) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipAsShortRange(item.blip, true)
		SetBlipColour(item.blip, item.colour)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	end
	while true do
	for _, garage in pairs(garages) do
			DrawMarker(25, garage.x, garage.y, garage.z, 0, 0, 0, 0, 0, 0, 3.001, 3.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(garage.x, garage.y, garage.z, GetEntityCoords(GetPlayerPed(PlayerId()))) < 3 and IsPedInAnyVehicle(GetPlayerPed(PlayerId()), true) == false then
				drawTxt("Press ~g~E~s~ to open the garage system",0,1,0.5,0.8,0.6,255,255,255,255)
				if IsControlJustPressed(1, 86) then
					garageSelected.x = garage.x 
					garageSelected.y = garage.y
					garageSelected.z = garage.z
					TriggerServerEvent("DRP_Garages:RequestOpenMenu")
				end
			end
		end
		Citizen.Wait(0)
	end
end)
---------------------------------------------------------------------------
-- NUI TRIGGER EVENTS
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Garages:OpenGarageMenu")
AddEventHandler("DRP_Garages:OpenGarageMenu", function(vehicles)
	SetNuiFocus(true, true)
    SendNUIMessage({
        type = "open_garage_menu",
        vehicles = vehicles
    })
end)
---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Garages:CreatePersonalVehicle")
AddEventHandler("DRP_Garages:CreatePersonalVehicle", function(vehicleData)
	for _, v in pairs(vehicleData.data) do
		local vehdamage = tonumber(v.damage)
		local enginedamage = tonumber(v.enginedamage)
		local car = GetHashKey(v.model)
		local plate = v.plate
		local primarycolor = tonumber(v.primarycolor)
		local secondarycolor = tonumber(v.secondarycolor)
		local pearlescentcolor = tonumber(v.pearlescentColor)
		local wheelcolor = tonumber(v.wheelColor)
		local state = v.state
		-- All the aids mods that took ages to write
		local plateindex = tonumber(v.plateindex)
		local neoncolor = tonumber({v.neoncolor1, v.neoncolor2, v.neoncolor3})
		local windowtint = tonumber(v.windowtint)
		local wheeltype = tonumber(v.wheeltype)
		local mods0 = tonumber(v.mods0)
		local mods1 = tonumber(v.mods1)
		local mods2 = tonumber(v.mods2)
		local mods3 = tonumber(v.mods3)
		local mods4 = tonumber(v.mods4)
		local mods5 =tonumber(v.mods5)
		local mods6 = tonumber(v.mods6)
		local mods7 = tonumber(v.mods7)
		local mods8 = tonumber(v.mods8)
		local mods9 = tonumber(v.mods9)
		local mods10 = tonumber(v.mods10)
		local mods11 = tonumber(v.mods11)
		local mods12 = tonumber(v.mods12)
		local mods13 = tonumber(v.mods13)
		local mods14 = tonumber(v.mods14)
		local mods15 = tonumber(v.mods15)
		local mods16 = tonumber(v.mods16)
		local turbo = v.turbo
		local tiresmoke = v.tiresmoke
		local xenon = v.xenon
		local mods23 = tonumber(v.mods23)
		local mods24 = tonumber(v.mods24)
		local bulletproof = vehicleData.bulletproof
		local smokecolor1 = tonumber(v.smokecolor1)
		local smokecolor2 = tonumber(v.smokecolor2)
		local smokecolor3 = tonumber(v.smokecolor3)
		local variation = v.variation

	Citizen.CreateThread(function()
			Citizen.Wait(1000)

			local yourLocalGarage = GetClosestVehicle(garageSelected.x, garageSelected.y, garageSelected.z, 3.000, 0, 70)

			if DoesEntityExist(yourLocalGarage) then

				drawNotification("There is something blocking the garage!")

			else

				if state == "OUT" then
					drawNotification("Your Vehicle is out already!")
				else
					local mods = {}
					for i = 0, 24 do
						mods[i] = GetVehicleMod(veh, i)
					end
					RequestModel(car)
					while not HasModelLoaded(car) do
						Citizen.Wait(0)
					end
					veh = CreateVehicle(car, garageSelected.x, garageSelected.y, garageSelected.z, 0.0, true, false)

					local yeetingplz = tonumber(vehdamage + 0.0)

					if yeetingplz <= 900.0 then
						SmashVehicleWindow(veh, -1)
						SmashVehicleWindow(veh, 0)
						SmashVehicleWindow(veh, 1)
						local smegTyre = math.random(1,3)
						if smegTyre == 1 then
							SetVehicleTyreBurst(veh, 4, true, 1000.0)
						elseif smegTyre == 2 then
							SetVehicleTyreBurst(veh, 1, true, 1000.0)
							SetVehicleTyreBurst(veh, 2, true, 1000.0)
						elseif smegTyre == 3 then
							SetVehicleTyreBurst(veh, 1, true, 1000.0)
							SetVehicleTyreBurst(veh, 2, true, 1000.0)
							SetVehicleTyreBurst(veh, 3, true, 1000.0)
							SetVehicleTyreBurst(veh, 4, true, 1000.0)
						end
					end

					SetVehicleBodyHealth(veh, tonumber(yeetingplz))
					SetVehicleEngineHealth(veh, enginedamage + 0.0)
					SetVehicleNumberPlateText(veh, plate)
					SetVehicleOnGroundProperly(veh)
					SetVehicleHasBeenOwnedByPlayer(veh,true)
					local id = NetworkGetNetworkIdFromEntity(veh)
					SetNetworkIdCanMigrate(id, true)
					TriggerServerEvent("DRP_Garages:GiveKeys", id, plate)

					SetVehicleColours(veh, primarycolor, secondarycolor)
					SetVehicleExtraColours(veh, tonumber(pearlescentcolor), tonumber(wheelcolor))
					SetVehicleNumberPlateTextIndex(veh, plateindex)
					SetVehicleWindowTint(veh, tonumber(windowtint))
					SetVehicleWheelType(veh, tonumber(wheeltype))
					-- SetVehicleNeonLightsColour(veh,tonumber(neoncolor[1]),tonumber(neoncolor[2]),tonumber(neoncolor[3]))
					-- SetVehicleTyreSmokeColor(veh,tonumber(smokecolor1),tonumber(smokecolor2),tonumber(smokecolor3))
					SetVehicleModKit(veh,0)
					SetVehicleMod(veh, 0, mods0)
					SetVehicleMod(veh, 1, mods1)
					SetVehicleMod(veh, 2, mods2)
					SetVehicleMod(veh, 3, mods3)
					SetVehicleMod(veh, 4, mods4)
					SetVehicleMod(veh, 5, mods5)
					SetVehicleMod(veh, 6, mods6)
					SetVehicleMod(veh, 7, mods7)
					SetVehicleMod(veh, 8, mods8)
					SetVehicleMod(veh, 9, mods9)
					SetVehicleMod(veh, 10, mods10)
					SetVehicleMod(veh, 11, mods11)
					SetVehicleMod(veh, 12, mods12)
					SetVehicleMod(veh, 13, mods13)
					SetVehicleMod(veh, 14, mods14)
					SetVehicleMod(veh, 15, mods15)
					SetVehicleMod(veh, 16, mods16)
					if turbo == "on" then
						ToggleVehicleMod(veh, 18, true)
					else
						ToggleVehicleMod(veh, 18, false)
					end
					if tiresmoke == "on" then
						ToggleVehicleMod(veh, 20, true)
					else
						ToggleVehicleMod(veh, 20, false)
					end
					if xenon == "on" then
						ToggleVehicleMod(veh, 22, true)
					else
						ToggleVehicleMod(veh, 22, false)
					end
						SetVehicleWheelType(veh, tonumber(wheeltype))
						SetVehicleMod(veh, 23, mods23)
						SetVehicleMod(veh, 24, mods24)
					if neon0 == "on" then
						SetVehicleNeonLightEnabled(veh,0, true)
					else
						SetVehicleNeonLightEnabled(veh,0, false)
					end
					if neon1 == "on" then
						SetVehicleNeonLightEnabled(veh,1, true)
					else
						SetVehicleNeonLightEnabled(veh,1, false)
					end
					if neon2 == "on" then
						SetVehicleNeonLightEnabled(veh,2, true)
					else
						SetVehicleNeonLightEnabled(veh,2, false)
					end
					if neon3 == "on" then
						SetVehicleNeonLightEnabled(veh,3, true)
					else
						SetVehicleNeonLightEnabled(veh,3, false)
					end
					if bulletproof == "on" then
						SetVehicleTyresCanBurst(veh, false)
					else
						SetVehicleTyresCanBurst(veh, true)
					end
					SetEntityInvincible(veh, false) 
					TriggerServerEvent("DRP_Garages:StateChangeOut", plate)
				end
			end
		end)
	end
end)

function UpdateVehicle(veh)
	Citizen.CreateThread(function()
		if DoesEntityExist(veh) then
			local plate = GetVehicleNumberPlateText(veh)
			local colors = table.pack(GetVehicleColours(veh))
			local extra_colors = table.pack(GetVehicleExtraColours(veh))
			local neoncolor = table.pack(GetVehicleNeonLightsColour(veh))
			local mods = table.pack(GetVehicleMod(veh))
			local smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))
			local plate = GetVehicleNumberPlateText(veh)
			local plateindex = GetVehicleNumberPlateTextIndex(veh)
			local damage = GetVehicleBodyHealth(veh)
			local enginedamage = GetVehicleEngineHealth(veh)
			local primarycolor = colors[1]
			print(primarycolor)
			local secondarycolor = colors[2]
			print(secondarycolor)
			local pearlescentcolor = extra_colors[1]
			local wheelcolor = extra_colors[2]
			local neoncolor1 = neoncolor[1]
			local neoncolor2 = neoncolor[2]
			local neoncolor3 = neoncolor[3]
			local windowtint = GetVehicleWindowTint(veh)
			local wheeltype = GetVehicleWheelType(veh)
			local smokecolor1 = smokecolor[1]
			local smokecolor2 = smokecolor[2]
			local smokecolor3 = smokecolor[3]
			local mods0 = GetVehicleMod(veh, 0)
			local mods1 = GetVehicleMod(veh, 1)
			local mods2 = GetVehicleMod(veh, 2)
			local mods3 = GetVehicleMod(veh, 3)
			local mods4 = GetVehicleMod(veh, 4)
			local mods5 = GetVehicleMod(veh, 5)
			local mods6 = GetVehicleMod(veh, 6)
			local mods7 = GetVehicleMod(veh, 7)
			local mods8 = GetVehicleMod(veh, 8)
			local mods9 = GetVehicleMod(veh, 9)
			local mods10 = GetVehicleMod(veh, 10)
			local mods11 = GetVehicleMod(veh, 11)
			local mods12 = GetVehicleMod(veh, 12)
			local mods13 = GetVehicleMod(veh, 13)
			local mods14 = GetVehicleMod(veh, 14)
			local mods15 = GetVehicleMod(veh, 15)
			local mods16 = GetVehicleMod(veh, 16)
			local mods23 = GetVehicleMod(veh, 23)
			local mods24 = GetVehicleMod(veh, 24)
			if IsToggleModOn(veh,18) then
				turbo = "on"
				print("turboi on")
			else
				turbo = "off"
				print("turbo off")
			end
			if IsToggleModOn(veh,20) then
				tiresmoke = "on"
			else
				tiresmoke = "off"
			end
			if IsToggleModOn(veh,22) then
				xenon = "on"
				print("xenon on")
			else
				xenon = "off"
				print("xenon off")
			end
			if IsVehicleNeonLightEnabled(veh,0) then
				neon0 = "on"
			else
				neon0 = "off"
			end
			if IsVehicleNeonLightEnabled(veh,1) then
				neon1 = "on"
			else
				neon1 = "off"
			end
			if IsVehicleNeonLightEnabled(veh,2) then
				neon2 = "on"
			else
				neon2 = "off"
			end
			if IsVehicleNeonLightEnabled(veh,3) then
				neon3 = "on"
			else
				neon3 = "off"
			end
			if GetVehicleTyresCanBurst(veh) then
				bulletproof = "off"
			else
				bulletproof = "on"
			end
			if GetVehicleModVariation(veh,23) then
				variation = "on"
			else
				variation = "off"
			end
			TriggerServerEvent("DRP_Garages:UpdateVehicle", enginedamage, damage, plate, plateindex, primarycolor, secondarycolor, pearlescentcolor, wheelcolor, neoncolor1, neoncolor2, neoncolor3, windowtint, wheeltype, mods0, mods1, mods2, mods3, mods4, mods5, mods6, mods7, mods8, mods9, mods10, mods11, mods12, mods13, mods14, mods15, mods16, turbo, tiresmoke, xenon, mods23, mods24, neon0, neon1, neon2, neon3, bulletproof, smokecolor1, smokecolor2, smokecolor3, variation)
		else
			drawNotification("Can't update this Vehicle!")
		end
	end)
end

RegisterNetEvent("DRP_Garages:StoreVehicle")
AddEventHandler("DRP_Garages:StoreVehicle", function()
	Citizen.CreateThread(function()
		Citizen.Wait(1000)
		local vehicle = GetClosestVehicle(garageSelected.x, garageSelected.y, garageSelected.z, 10.000, 0, 70)
		SetEntityAsMissionEntity(vehicle, true, true)
		UpdateVehicle(vehicle)
		Citizen.Wait(300)
		deleteCar(vehicle)
		drawNotification("Vehicle Stored")
	end)
end)

RegisterNetEvent("DRP_Garages:StoreVehicleFalse")
AddEventHandler("DRP_Garages:StoreVehicleFalse", function()
	drawNotification("Vehicle Cant Be Stored")
end)
---------------------------------------------------------------------------
-- NUI CALLBACKS
---------------------------------------------------------------------------
RegisterNUICallback("close_garage", function(data, callback)
	SetNuiFocus(false, false)
	callback("ok")
end)

RegisterNUICallback("select_vehicle", function(data, callback)
	TriggerServerEvent("DRP_Garages:GetSelectedVehicleData", data.selectedVehicle)
	callback("ok")
end)

RegisterNUICallback("store_vehicle", function(data, callback)
	SetNuiFocus(false, false)
	storeVehicle()
	callback("ok")
end)
---------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------
function storeVehicle()
Citizen.CreateThread(function()
	local garage = GetClosestVehicle(garageSelected.x, garageSelected.y, garageSelected.z, 3.000, 0, 70)
	SetEntityAsMissionEntity(garage, true, true)
	local plate = GetVehicleNumberPlateText(garage)
		if DoesEntityExist(garage) then
			TriggerServerEvent("DRP_Garages:RequestStoreVehicle", plate)
		else
			drawNotification("Cannot find any vehicles near you!")
		end
	end)
end
---------------------------------------------------------------------------
function deleteCar( vehicle )
	Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( vehicle ) )
end
---------------------------------------------------------------------------
function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end
---------------------------------------------------------------------------
function GetVehicleInFront()
	local plyCoords = GetEntityCoords(GetPlayerPed(PlayerId()), false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 5.0, 0.0)
	local rayHandle = StartShapeTestCapsule(plyCoords.x, plyCoords.y, plyCoords.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 10, GetPlayerPed(PlayerId()), 7)
	local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end
---------------------------------------------------------------------------
function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
---------------------------------------------------------------------------
-- Commands
---------------------------------------------------------------------------
RegisterCommand("hood", function()
local ped = PlayerPedId()
local veh = GetVehiclePedIsIn(ped, false)
if veh ~= nil and veh ~= 0 and veh ~= 1 then
	if GetVehicleDoorAngleRatio(veh, 4) > 0 then
		SetVehicleDoorShut(veh, 4, false)
	else
		SetVehicleDoorOpen(veh, 4, false, false)
	end
end
end, false)
---------------------------------------------------------------------------
RegisterCommand("trunk", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
        if GetVehicleDoorAngleRatio(veh, 5) > 0 then
            SetVehicleDoorShut(veh, 5, false)
        else
            SetVehicleDoorOpen(veh, 5, false, false)
        end
    end
end, false)
