local jobMarkerBlips = {
    markerData = {},
    blipData = {},
    locations = {}
}
local drawBlips = {}

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
                    local jobName = "POLICE"
                    TriggerServerEvent("DRP_PoliceJobs:SignOnDuty", jobName)
                end
                if IsControlJustPressed(1, 74) then
                    TriggerServerEvent("DRP_PoliceJobs:SignOffDuty")
                end
            end
        end
    end
end)