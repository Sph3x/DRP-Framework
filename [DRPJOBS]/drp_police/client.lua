local allInServiceBlips = {}
local blipsOn = false
---------------------------------------------------------------------------
-- Main Threads
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        for a = 1, #DRPPoliceJob.SignOnAndOff do
        local ped = GetPlayerPed(PlayerId())
        local pedPos = GetEntityCoords(ped, false)
        local distance = Vdist(pedPos.x, pedPos.y, pedPos.z, DRPPoliceJob.SignOnAndOff[a].x, DRPPoliceJob.SignOnAndOff[a].y, DRPPoliceJob.SignOnAndOff[a].z)
            if distance <= 5.0 then
                exports['drp_core']:DrawText3Ds(DRPPoliceJob.SignOnAndOff[a].x, DRPPoliceJob.SignOnAndOff[a].y, DRPPoliceJob.SignOnAndOff[a].z, tostring("~b~[E]~w~ to sign on duty or ~r~[H]~w~ to sign off duty"))
                if IsControlJustPressed(1, 86) then
                    TriggerServerEvent("DRP_PoliceJobs:SignOnDuty")
                end
                if IsControlJustPressed(1, 74) then
                    TriggerServerEvent("DRP_PoliceJobs:SignOffDuty")
                end
            end
        end
    end
end)
-----------------------------------------------------
-- Service Blips
-----------------------------------------------------
RegisterNetEvent("DRP_Police:BlipToggle")
AddEventHandler("DRP_Police:BlipToggle", function(bool)
    blipsOn = bool
    if not blipsOn then
        RemoveAnyExistingEmergencyBlips()
    end
end)

RegisterNetEvent("DRP_Police:BlipsUpdate")
AddEventHandler("DRP_Police:BlipsUpdate", function(persons)
    allInServiceBlips = persons
    print(json.encode(allInServiceBlips))
end)

-----------------------------------------------------
-- Service Blips Thread
-----------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if blipsOn then
			for src, info in pairs(allInServiceBlips) do
                local player = GetPlayerFromServerId(src)
				local ped = GetPlayerPed(player)
				if GetPlayerPed(PlayerId()) ~= ped then
					if GetBlipFromEntity(ped) == 0 then
						local blip = AddBlipForEntity(ped)
						SetBlipSprite(blip, 1)
						SetBlipColour(blip, info.color)
						SetBlipAsShortRange(blip, true)
						SetBlipDisplay(blip, 4)
						SetBlipShowCone(blip, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(info.name)
						EndTextCommandSetBlipName(blip)
					end
				end
			end
		end
		Citizen.Wait(1)
	end
end)
---------------------------------------------------------------------------
-- MAIN CALLBACKS
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Interactions:OpenMenu")
AddEventHandler("DRP_Interactions:OpenMenu", function()
    SetNuiFocus(true, true)
    print("triggered this")
    SendNUIMessage({
        type = "open_police_menu",
    })
end)

RegisterNUICallback("closeJobCenter", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
end)

---------------------------------------------------------------------------
-- Functions
---------------------------------------------------------------------------
function setOutfit(outfit)
    local ped = PlayerPedId()

    RequestModel(outfit.model)

    while not HasModelLoaded(outfit.model) do
        Wait(0)
    end

    if GetEntityModel(ped) ~= GetHashKey(outfit.model) then
        SetPlayerModel(PlayerId(), outfit.model)
    end

    ped = PlayerPedId()
    for _, comp in ipairs(outfit.clothing) do
        print(json.encode(comp))
       SetPedComponentVariation(ped, comp.component, comp.drawable - 1, comp.texture - 1, 0)
    end

    for _, comp in ipairs(outfit.props) do
        if comp.drawable == 0 then
            ClearPedProp(ped, comp.props)
        else
            SetPedPropIndex(ped, comp.component, comp.drawable - 1, comp.texture - 1, true)
        end
    end
end

function RemoveAnyExistingEmergencyBlips()
	for src, info in pairs(allInServiceBlips) do
		local possible_blip = GetBlipFromEntity(GetPlayerPed(GetPlayerFromServerId(src)))
		if possible_blip ~= 0 then
			RemoveBlip(possible_blip)
			allInServiceBlips[src] = nil
		end
	end
end