-- SetEntityCoords(GetPlayerPed(PlayerId()), 152.2605, -1004.471, -98.99999)
local motelRoomLocations = {}
local insideMotel = false
local characterId = nil
local ped = GetPlayerPed(PlayerId())
SetEntityCoords(ped, 120.19280000, -1009.42200000, -136.84560000)

RegisterNetEvent("DRP_Housing:UpdateClientHousing")
AddEventHandler("DRP_Housing:UpdateClientHousing", function(motelData)
    motelRoomLocations = motelData
    print(json.encode(motelRoomLocations))
end)

RegisterNetEvent("DRP_Housing:SpawnPlayerInsideMotelRoom")
AddEventHandler("DRP_Housing:SpawnPlayerInsideMotelRoom", function(charid)
    if charid ~= false or charid ~= nil then
        characterId = charid
        for a = 1, #motelRoomLocations do
            if motelRoomLocations[a].ownerid ~= 0 then
                if motelRoomLocations[a].ownerid == characterId then
                    SetEntityCoords(GetPlayerPed(PlayerId()), motelRoomLocations[a].x, motelRoomLocations[a].y, motelRoomLocations[a].z)
                    insideMotel = true
                end
            end
        end
    else
        print("something is broke contact the devs")
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(PlayerId())
        local coords = GetEntityCoords(ped, false)
            for a = 1, #motelRoomLocations do
                if motelRoomLocations[a].ownerid ~= 0 then
                    if motelRoomLocations[a].ownerid == characterId then
                    local distance = Vdist(coords.x, coords.y, coords.z, motelRoomLocations[a].x, motelRoomLocations[a].y, motelRoomLocations[a].z)
                        if distance <= 5.0 then
                            DrawText3Ds(motelRoomLocations[a].x, motelRoomLocations[a].y, motelRoomLocations[a].z, tostring("~b~[E]~w~ To Exit"))
                            if IsControlJustPressed(1, 86) then
                                DoScreenFadeOut(1)
                                SetEntityCoords(ped, motelRoomLocations[a].enterCoords[1], motelRoomLocations[a].enterCoords[2], motelRoomLocations[a].enterCoords[3])
                                insideMotel = false
                                DoScreenFadeIn(1000)
                            end
                        end
                        local distance2 = Vdist(coords.x, coords.y, coords.z, motelRoomLocations[a].enterCoords[1], motelRoomLocations[a].enterCoords[2], motelRoomLocations[a].enterCoords[3])
                        if distance2 <= 20.0 then
                            DrawMarker(20, motelRoomLocations[a].enterCoords[1], motelRoomLocations[a].enterCoords[2], motelRoomLocations[a].enterCoords[3], 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0, 155, 255, 200, 0, 0, 0, 0)
                            if distance2 <= 5.0 then
                                DrawText3Ds(motelRoomLocations[a].enterCoords[1], motelRoomLocations[a].enterCoords[2], motelRoomLocations[a].enterCoords[3], tostring("~b~[E]~w~ To Enter Apartment"))
                                if IsControlJustPressed(1, 86) then
                                    DoScreenFadeOut(1)
                                    SetEntityCoords(ped, motelRoomLocations[a].x, motelRoomLocations[a].y, motelRoomLocations[a].z)
                                    insideMotel = true
                                    DoScreenFadeIn(1000)
                                end
                            end
                        end
                    end
                end
            end
        -- if insideMotel then
        --     DisplayRadar(false)
        -- end
        Citizen.Wait(0)
    end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end