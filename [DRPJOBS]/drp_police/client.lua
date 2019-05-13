---------------------------------------------------------------------------
-- Blip Code
---------------------------------------------------------------------------
local jobMarkerBlips = {
    markerData = {},
    blipData = {},
    locations = {}
}
local drawBlips = {}
---------------------------------------------------------------------------
RegisterNetEvent("DRP_PoliceJob:SetLoadoutMarkerBlips")
AddEventHandler("DRP_PoliceJob:SetLoadoutMarkerBlips", function(markerD, blipD, locations)
    jobMarkerBlips.markerData = markerD
    jobMarkerBlips.locations = locations
    jobMarkerBlips.blipData = blipD
    for a = 1, #drawBlips do
        RemoveBlip(drawBlips[a])
    end
    drawBlips = {}
    for b = 1, #jobMarkerBlips.locations do
        local blip = AddBlipForCoord(jobMarkerBlips.locations[b].x, jobMarkerBlips.locations[b].y, jobMarkerBlips.locations[b].z)
        SetBlipSprite(blip, jobMarkerBlips.blipData.sprite)
        SetBlipColour(blip, jobMarkerBlips.blipData.color)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, jobMarkerBlips.blipData.scale)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(jobMarkerBlips.blipData.label)
        EndTextCommandSetBlipName(blip)
        table.insert(drawBlips, blip)
    end
end)
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
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        for a = 1, #jobMarkerBlips.locations do
            local playercoords = GetEntityCoords(GetPlayerPed(PlayerId()), false)
            local distance = Vdist(playercoords.x, playercoords.y, playercoords.z, jobMarkerBlips.locations[a].x, jobMarkerBlips.locations[a].y, jobMarkerBlips.locations[a].z)
            if distance <= 50.0 then
                DrawMarker(
                    jobMarkerBlips.markerData.markerType,
                    jobMarkerBlips.locations[a].x,
                    jobMarkerBlips.locations[a].y,
                    jobMarkerBlips.locations[a].z - 1.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    jobMarkerBlips.markerData.scale,
                    jobMarkerBlips.markerData.scale,
                    jobMarkerBlips.markerData.scale,
                    jobMarkerBlips.markerData.color[1],
                    jobMarkerBlips.markerData.color[2],
                    jobMarkerBlips.markerData.color[3],
                    1.0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0
                )
                if distance <= 1.0 then
                    exports['drp_core']:DrawText3Ds(jobMarkerBlips.locations[a].x, jobMarkerBlips.locations[a].y, jobMarkerBlips.locations[a].z, jobMarkerBlips.markerData.label)
                    if IsControlJustPressed(1, 38) then
                        TriggerServerEvent("DRP_PoliceJob:GetJobLoadouts")
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)
---------------------------------------------------------------------------
-- Locker Room Stuff
---------------------------------------------------------------------------
RegisterNetEvent("DRP_PoliceJob:OpenJobLoadout")
AddEventHandler("DRP_PoliceJob:OpenJobLoadout", function(loadouts)
    local menuPool = NativeUI.CreatePool()
    local mainMenu = NativeUI.CreateMenu('DRP Police Job', 'Pick Your Clothing')
    -- local subMenu = menuPool:AddSubMenu(mainMenu, "chicken")
    mainMenu:Visible(not mainMenu:Visible())

    for id, outfit in pairs(loadouts) do
        outfit.item = NativeUI.CreateItem(outfit.name, "Select This Outfit")
        mainMenu:AddItem(outfit.item)
    end

    mainMenu.OnItemSelect = function(sender, item, index)
        for id, outfit in pairs(loadouts) do
            if outfit.item == item then
                CreateThread(function()
                    setOutfit(outfit)
                end)
            end
        end
    end

    menuPool:Add(mainMenu)

    menuPool:RefreshIndex()

    CreateThread(function()
        while true do
            Wait(0)
            menuPool:ProcessMenus()
        end
    end)
end)

local allInServiceBlips = {}
local blipsOn = false

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

function RemoveAnyExistingEmergencyBlips()
	for src, info in pairs(allInServiceBlips) do
		local possible_blip = GetBlipFromEntity(GetPlayerPed(GetPlayerFromServerId(src)))
		if possible_blip ~= 0 then
			RemoveBlip(possible_blip)
			allInServiceBlips[src] = nil
		end
	end
end

-----------------------------------------------------
-- Watch for emergency personnel to show blips for --
-----------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if blipsOn then
			for src, info in pairs(allInServiceBlips) do
                local player = GetPlayerFromServerId(src)
				local ped = GetPlayerPed(player)
				if GetPlayerPed(-1) ~= ped then
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
		Wait(1)
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