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