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
RegisterNetEvent("DRP_PoliceJob:SetGarageMarkerBlips")
AddEventHandler("DRP_PoliceJob:SetGarageMarkerBlips", function(markerD, blipD, locations)
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
-- Garage Menu
---------------------------------------------------------------------------
RegisterNetEvent("DRP_PoliceJob:OpenGarage")
AddEventHandler("DRP_PoliceJob:OpenGarage", function(allVehicles)
    local menuPool = NativeUI.CreatePool()
    local mainMenu = NativeUI.CreateMenu('DRP Police Garage', 'Pick Your Vehicle')
    mainMenu:Visible(not mainMenu:Visible())

    for id, v in pairs(allVehicles) do
        v.item = NativeUI.CreateItem(v.label, "Select This Vehicle")
        mainMenu:AddItem(v.item)
    end

    mainMenu.OnItemSelect = function(sender, item, index)
        for id, v in pairs(allVehicles) do
            if v.item == item then
                CreateThread(function()
                    SpawnVehicle(v.model, v.livery, v.extras)
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

function SpawnVehicle(model, livery, extras)
    for a = 1, #jobMarkerBlips.locations do
        local plyCoords = GetEntityCoords(GetPlayerPed(PlayerId()), false)
        local position = jobMarkerBlips.locations[a]
        local distance = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position.x, position.y, position.z)
        local colors = false
        if distance <= 5.0 then
            for b = 1, #jobMarkerBlips.locations[a].spawnpoints do
                local rayHandle = StartShapeTestCapsule(jobMarkerBlips.locations[a].spawnpoints[b].x, jobMarkerBlips.locations[a].spawnpoints[b].y, jobMarkerBlips.locations[a].spawnpoints[b].z, jobMarkerBlips.locations[a].spawnpoints[b].x, jobMarkerBlips.locations[a].spawnpoints[b].y, jobMarkerBlips.locations[a].spawnpoints[b].z, 2.0, 10, GetPlayerPed(PlayerId()), 7)
                local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
                if vehicle == 0 then
                    TriggerEvent("DRP_PoliceJob:SpawnServiceVehicle", model, {
                        x = jobMarkerBlips.locations[a].spawnpoints[b].x,
                        y = jobMarkerBlips.locations[a].spawnpoints[b].y,
                        z = jobMarkerBlips.locations[a].spawnpoints[b].z + 0.5,
                        h = jobMarkerBlips.locations[a].spawnpoints[b].h
                    }, false, false)
                    return
                end
            end
        end
    end
end


RegisterNetEvent("DRP_PoliceJob:SpawnServiceVehicle")
AddEventHandler("DRP_PoliceJob:SpawnServiceVehicle", function(model, location, colors, livery)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Citizen.Wait(100)
    end

    local spawned = CreateVehicle(GetHashKey(model), location.x, location.y, location.z, location.h, 1, 1)
    local id = NetworkGetNetworkIdFromEntity(spawned)
    local plate = GetVehicleNumberPlateText(spawned)
    TriggerServerEvent("DRP_Garages:GiveKeys", id, plate)

    if colors ~= false then SetVehicleColours(spawned, colors.p, colors.s) end
    if livery ~= false then SetVehicleLivery(spawned, livery) end
    SetEntityAsMissionEntity(spawned, 1, 1)
    SetEntityAsNoLongerNeeded(spawned)
end)
---------------------------------------------------------------------------
-- Main Thread
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
                        TriggerServerEvent("DRP_PoliceJob:GetJobGarages")
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)