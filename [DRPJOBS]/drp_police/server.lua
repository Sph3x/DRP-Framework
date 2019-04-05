RegisterServerEvent("DRP_PoliceJobs:SignOnDuty")
AddEventHandler("DRP_PoliceJobs:SignOnDuty", function(jobTitle)
    local src = source
    local characterInfo = exports["drp_id"]:GetCharacterData(src)
    local job = jobTitle
    local jobLabel = DRPPoliceJob.PoliceJobLabels[job] -- Gets The Job Label To Display In The Notifications
    local jobRequirement = DRPPoliceJob.Requirements[job] -- Gets If You Are Enabled To Do This Job
    local currentPlayerJob = exports["drp_jobcore"]:GetPlayerJob(src)
    if currentPlayerJob.job == job then
        TriggerClientEvent("DRP_Core:Error", src, "Job Manager", tostring("You are already on duty"), 2500, false, "leftCenter")
    else
    if exports["drp_jobcore"]:DoesJobExist(job) then
        if jobRequirement ~= false then
            exports["externalsql"]:DBAsyncQuery({
                string = "SELECT * FROM `" .. jobRequirement .. "` WHERE `char_id` = :charid",
                data = {
                    charid = characterInfo.charid
                }
            }, function(jobResults)
                if jobResults.data[1] ~= nil then
                    exports["drp_jobcore"]:SetPlayerJob(src, job, jobLabel, {
                        rank = jobResults.data[1].rank,
                        division = jobResults.data[1].division
                    })
                    -- Time For Some Discusting Code!
                    local policeJobTitle = ""
                    if jobResults.data[1].division == "Police" then
                        policeJobTitle = "Police Officer"
                    elseif jobResults.data[1].division == "Sheriff" then 
                        policeJobTitle = "Sheriff Deputy"
                    elseif jobResults.data[1].division == "State" then
                        policeJobTitle = "State Trooper"
                    end
                    TriggerClientEvent("DRP_Core:Info", src, "Job Manager", tostring("Welcome "..policeJobTitle.." "..characterInfo.name..""), 2500, false, "leftCenter")
                    PoliceAbilities(src, jobLabel)
                else
                    TriggerClientEvent("DRP_Core:Error", src, "Job Manager", "You are not registered for this Job!", 5500, false, "leftCenter")
                end
            end)
        else
            exports["drp_jobcore"]:SetPlayerJob(src, job, jobLabel, false)
            end
        end
    end
end)

RegisterServerEvent("DRP_PoliceJobs:SignOffDuty")
AddEventHandler("DRP_PoliceJobs:SignOffDuty", function()
    local src = source
    local player = exports["drp_core"]:GetPlayerData(src)
    local job = "UNEMPLOYED"
    local jobLabel = "Unemployed"
    exports["drp_jobcore"]:SetPlayerJob(src, job, jobLabel)
    TriggerClientEvent("DRP_Core:Info", src, "Job Manager", tostring("You are now a "..exports["drp_jobcore"]:GetPlayerJob(src).jobLabel), 2500, false, "leftCenter")
end)


function PoliceAbilities(player, label)
    local jobLoadouts = DRPPoliceJob.LockerRooms[label]
     if jobLoadouts ~= nil then
        TriggerClientEvent("DRP_PoliceJob:SetLoadoutMarkerBlips", player, jobLoadouts.MarkerData, jobLoadouts.BlipData, jobLoadouts.Locations)
    else
        TriggerClientEvent("DRP_PoliceJob:SetLoadoutMarkerBlips", player, {}, {}, {})
    end
end