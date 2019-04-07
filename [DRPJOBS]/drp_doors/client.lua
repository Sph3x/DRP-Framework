local allDoors = {}
local jobDoors = {}
---------------------------------------------------------------------------
-- Sync Start
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    TriggerServerEvent("DRP_Doors:StartSync")
end)
---------------------------------------------------------------------------
-- Door Events
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Doors:DoorSync")
AddEventHandler("DRP_Doors:DoorSync", function(doors)
    allDoors = doors
end)

-- ADD JOB DOORS
---------------------------------------------------------------------------
-- Threads
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(PlayerId())
        local pedPos = GetEntityCoords(ped, false)
            for a = 1, #allDoors do
                local distance = Vdist(pedPos.x, pedPos.y, pedPos.z, allDoors[a].x,allDoors[a].y,allDoors[a].z)
                local lockedDoor = allDoors[a].isLocked
                if distance <= 2.5 then
                    if lockedDoor then
                        exports['drp_core']:DrawText3Ds(allDoors[a].x, allDoors[a].y, allDoors[a].z + 0.3, tostring("~b~[E] - ~r~[LOCKED]"))
                    else
                        exports['drp_core']:DrawText3Ds(allDoors[a].x, allDoors[a].y, allDoors[a].z + 0.3, tostring("~b~[E] - ~g~[UNLOCKED]"))
                    end
                    local door = GetClosestObjectOfType(allDoors[a].x, allDoors[a].y, allDoors[a].z, 5.0, GetHashKey(allDoors[a].model), false, false, false)
                    if allDoors[a].isLocked then
                        FreezeEntityPosition(door, true)
                    else
                        FreezeEntityPosition(door, false)
                    end
                    if IsControlJustPressed(1, 86) and distance <= 1.0 then
                        allDoors[a].isLocked = not lockedDoor
                        TriggerServerEvent("DRP_Doors:UpdateDoorStatus", allDoors)
                        -- doorAnimation()
                    end
                end
            end
        Citizen.Wait(1)
    end
end)
---------------------------------------------------------------------------
-- Door Functions
---------------------------------------------------------------------------