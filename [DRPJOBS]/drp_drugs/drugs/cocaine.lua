---------------------------------------------------------------------------
-- Variables
---------------------------------------------------------------------------
local isCollecting = false
local isProcessing = false
dealerCoords = nil
---------------------------------------------------------------------------
-- Table Coords
---------------------------------------------------------------------------
local cocaineOutsideEntryDoorLocation = { 
    {x = 2855.637, y = 4446.728, z = 48.53489}
}
local cocaineInsideExitDoorLocation = {
    {x = 1088.679, y = -3187.655 , z = -38.99344}
}
local cocainePickingLocation = {
    {x = -50.57299, y = 1911.137, z = 195.5058}
}
local cocainePackingAndCuttingLocations = {
    {x = 3559.748, y = 3672.202, z = 28.12189}
}
local dealerPed = {
   {model="s_m_m_ammucountry", x=157.5191, y=-1929.713, z=19.79195, a=218.535} 
}
---------------------------------------------------------------------------
-- Map Blips
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    for _, item in pairs(cocainePickingLocation) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, 501)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Raw Cocaine Collecting")
        EndTextCommandSetBlipName(item.blip)
	end
    for _, item in pairs(cocaineOutsideEntryDoorLocation) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, 497)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Cocaine Processing")
        EndTextCommandSetBlipName(item.blip)
	end
end)
---------------------------------------------------------------------------
-- Main Thread (This Needs A Big Clean Up And To Be Optimized In The Near Future)
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do 
        local ped = GetPlayerPed(PlayerId())
        local coords = GetEntityCoords(ped, false)
        for a = 1, #cocainePickingLocation do
        local distance = Vdist(coords.x, coords.y, coords.z, cocainePickingLocation[a].x, cocainePickingLocation[a].y, cocainePickingLocation[a].z)
            if distance <= 5.0 then
                exports['drp_core']:DrawText3Ds(cocainePickingLocation[a].x, cocainePickingLocation[a].y, cocainePickingLocation[a].z + 0.3, tostring("~r~[E]~w~ - Purchase Raw Cocaine $"..DRPDrugsConfig.DrugPrices.rawcocaine..""))
                if IsControlJustPressed(1, 86) then
                    TriggerServerEvent("DRP_Drugs:CheckPurchaseRawCocaine")
                end
            end
        end
        for b = 1, #DRPDrugsConfig.CocaineLocations do
            local distance = Vdist(coords.x, coords.y, coords.z, DRPDrugsConfig.CocaineLocations[b].x, DRPDrugsConfig.CocaineLocations[b].y, DRPDrugsConfig.CocaineLocations[b].z)
            if distance <= 3.0 then
                exports['drp_core']:DrawText3Ds(DRPDrugsConfig.CocaineLocations[b].x, DRPDrugsConfig.CocaineLocations[b].y, DRPDrugsConfig.CocaineLocations[b].z + 0.3, tostring("~r~[E]~w~ - Process your Raw Cocaine"))
                if IsControlJustPressed(1, 86) then
                    TriggerServerEvent("DRP_Drugs:ProcessItem", "rawcocaine", "cocaine")
                end
            end
        end
        for c = 1, #cocainePackingAndCuttingLocations do
            local distance = Vdist(coords.x, coords.y, coords.z, cocainePackingAndCuttingLocations[c].x, cocainePackingAndCuttingLocations[c].y, cocainePackingAndCuttingLocations[c].z)
            if distance <= 3.0 then
                exports['drp_core']:DrawText3Ds(cocainePackingAndCuttingLocations[c].x, cocainePackingAndCuttingLocations[c].y, cocainePackingAndCuttingLocations[c].z + 0.3, tostring("~r~[E]~w~ - Cut and Package your Cocaine"))
                if IsControlJustPressed(1, 86) then
                    TriggerServerEvent("DRP_Drugs:CutAndPackageCocaine")
                end
            end
        end
        for d = 1, #dealerPed do
            local distance = Vdist(coords.x, coords.y, coords.z, dealerPed[d].x, dealerPed[d].y, dealerPed[d].z)
                if distance <= 30.0 then 
                    if not DoesEntityExist(dealerNPC) then
                    modelHash = dealerPed[d].model
                    RequestModel(modelHash)

                    while not HasModelLoaded(modelHash) do
                        Wait(0)
                    end

                    dealerNPC = CreatePed(4, modelHash, dealerPed[d].x, dealerPed[d].y, dealerPed[d].z -1, dealerPed[d].a, false, false)
                    SetEntityHeading(dealerNPC, dealerPed[d].a)
                    
                    SetBlockingOfNonTemporaryEvents(dealerNPC, true)
                    SetPedFleeAttributes(dealerNPC, 0, 0)
                    SetEntityInvincible(dealerNPC, true)

                    SetModelAsNoLongerNeeded(modelHash)
                end
            else
                if DoesEntityExist(dealerNPC) then
                    DeleteEntity(dealerNPC)
                end
            end
            dealerCoords = GetEntityCoords(dealerNPC, false)
            local closeToDealer = Vdist(dealerCoords.x, dealerCoords.y, dealerCoords.z, coords.x, coords.y, coords.z)
            if closeToDealer <= 3.0 then
                exports['drp_core']:DrawText3Ds(dealerCoords.x, dealerCoords.y, dealerCoords.z + 0.3, tostring("~r~[E]~w~ - To Sell Your Cocaine Bricks"))
                if IsControlJustPressed(1, 86) then
                    Wait(500)
                    TriggerServerEvent("DRP_Drugs:SellCocaineBrick")
                end
            end
        end
        Citizen.Wait(1)
    end
end)
---------------------------------------------------------------------------
-- Entering The Processing Location
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(PlayerId())
        local coords = GetEntityCoords(ped, false)
        for a = 1, #cocaineOutsideEntryDoorLocation do
            local outsideDistance = Vdist(coords.x, coords.y, coords.z, cocaineOutsideEntryDoorLocation[a].x, cocaineOutsideEntryDoorLocation[a].y, cocaineOutsideEntryDoorLocation[a].z)
            if outsideDistance <= 5.0 then
                if not isCollecting or isProcessing then
                    if IsPedOnFoot(ped) then
                        exports['drp_core']:DrawText3Ds(cocaineOutsideEntryDoorLocation[a].x, cocaineOutsideEntryDoorLocation[a].y, cocaineOutsideEntryDoorLocation[a].z + 0.3, tostring("~r~[E]~w~ - Enter This Premises"))
                        if IsControlJustPressed(1, 86) then
                            Citizen.Wait(500)
                            SetEntityCoords(ped, 1088.514, -3187.744, -38.99)
                        end
                    end
                end
            end
        end
        for b = 1, #cocaineInsideExitDoorLocation do
            local insideDistance = Vdist(coords.x, coords.y, coords.z, cocaineInsideExitDoorLocation[b].x, cocaineInsideExitDoorLocation[b].y, cocaineInsideExitDoorLocation[b].z)
            if insideDistance <= 5.0 then
                if not isCollecting or isProcessing then
                    if IsPedOnFoot(ped) then
                        exports['drp_core']:DrawText3Ds(cocaineInsideExitDoorLocation[b].x, cocaineInsideExitDoorLocation[b].y, cocaineInsideExitDoorLocation[b].z + 0.3, tostring("~r~[E]~w~ - Exit This Premises"))
                        if IsControlJustPressed(1, 86) then
                            Citizen.Wait(500)
                            SetEntityCoords(ped, 2855.637, 4446.728, 48.53489)
                        end
                    end
                end
            end
        end
        Citizen.Wait(1)
    end
end)

RegisterNetEvent("DRP_Drugs:StartCollectingRawCocaine")
AddEventHandler("DRP_Drugs:StartCollectingRawCocaine", function()
    Citizen.Wait(1000)
    TriggerServerEvent("DRP_Inventory:AddItem", "rawcocaine")
end)