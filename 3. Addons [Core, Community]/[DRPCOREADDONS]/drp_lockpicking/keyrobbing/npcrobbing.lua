lastrobbed = 0
local robbing = false
local currentrobbing = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if robbing then

        else  
        if IsPlayerFreeAiming(PlayerId()) then
            local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId())
                if IsPedArmed(GetPlayerPed(-1), 7) and IsPedArmed(GetPlayerPed(-1), 4) and not IsPedAPlayer(targetPed) and not IsEntityAMissionEntity(targetPed) then
                    if aiming then
                    local playerPed = GetPlayerPed(-1)
                    local pCoords = GetEntityCoords(playerPed, true)
                    local tCoords = GetEntityCoords(targetPed, true)
                        if DoesEntityExist(targetPed) and IsEntityAPed(targetPed) and not IsPedDeadOrDying(targetPed) then
                            if GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, tCoords.x, tCoords.y, tCoords.z, true) <= 5.0 then
                                if IsPedInAnyVehicle(targetPed, true) then
                                    local localvehicle = GetVehiclePedIsIn(targetPed, false)
                                    if IsVehicleStopped(localvehicle) then
                                        TaskLeaveVehicle(targetPed, localvehicle, 1)
                                        ClearPedTasks(targetPed)
                                        Citizen.Wait(1000)
                                        if not robbing then
                                            robNpc(targetPed)
                                        end
                                    end
                                elseif not robbing then
                                    robNpc(targetPed)
                                end
                            end
                        end    
                    end
                end
            end
        end  
    end
end)

function robNpc(targetPed)
    Citizen.CreateThread(function()
    local roblocalcoords = GetEntityCoords(targetPed)
    if not currentrobbing then 
        exports['drp_core']:DrawText3Ds(roblocalcoords.x, roblocalcoords.y, roblocalcoords.z, "[~g~E~s~] to Mug")
    elseif lasttargetPed == targetPed then
        exports['drp_core']:DrawText3Ds(roblocalcoords.x, roblocalcoords.y, roblocalcoords.z, "Already Mugged..")
    else
        exports['drp_core']:DrawText3Ds(roblocalcoords.x, roblocalcoords.y, roblocalcoords.z, "Mugging...")
    end
    TaskHandsUp(targetPed, 5500, 0, 0, true)
    
        if IsControlJustReleased(0, 38) then
            local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
            local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
            local street1 = GetStreetNameFromHashKey(s1)
            local street2 = GetStreetNameFromHashKey(s2)
            if not currentrobbing then
                if lasttargetPed == targetPed then
                    PlayAmbientSpeech1(targetPed, "GUN_BEG", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
                    currentrobbing = true
                    TaskHandsUp(targetPed, 1000, 0, 0, true)
                    Notify("Already Mugged this person.")
                    
                    TaskSmartFleePed(targetPed, GetPlayerPed(-1), -1, -1, true, true)
                    Citizen.Wait(3000)
                    robbing = false
                    currentrobbing = false
                else
                    PlayAmbientSpeech1(targetPed, "GUN_BEG", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
                    currentrobbing = true
                    TaskHandsUp(targetPed, Config.RobWaitTime * 1000, 0, 0, true)
                    Citizen.Wait(Config.RobWaitTime * 1000)
                    if not IsPedFleeing(targetPed) then
                       if not IsPedDeadOrDying(targetPed) then
                            TriggerServerEvent("esx_muggings:giveMoney")
                            randomact = math.random(1,10)
                            if randomact > 6 then
                                PlayAmbientSpeech1(targetPed, "GENERIC_INSULT_HIGH", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
                            elseif randomact > 3 then
                                PlayAmbientSpeech1(targetPed, "GENERIC_FRIGHTENED_HIGH", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
                            end
                            robbing = true
                            
                            TaskSmartFleePed(targetPed, GetPlayerPed(-1), -1, -1, true, true)
                            Citizen.Wait(3000)

                            lasttargetPed = targetPed
                            robbing = false
                            currentrobbing = false
                        else
                            robbing = false
                            currentrobbing = false
                        end
                    else
                        Notify("Target ran away")
                        robbing = false
                        currentrobbing = false
                    end
                end
            end
        end
    end)
end

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end