local playersJob = {}
---------------------------------------------------------------------------
-- Job Core Events (DO NOT TOUCH!)
---------------------------------------------------------------------------
RegisterServerEvent("DRP_JobCore:StartUp")
AddEventHandler("DRP_JobCore:StartUp", function()
    local src = source
    table.insert(playersJob, {source = src, job = "UNEMPLOYED", jobLabel = "Unemployed"})
end)

AddEventHandler("playerDropped", function()
    local src = source
    for a = 1, #playersJob do
        if playersJob[a].source == src then
            table.remove(playersJob, a)
            break
        end
    end
end)

---------------------------------------------------------------------------
-- Main Server Event To Change And Add People To Jobs
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Jobs:StartWork")
AddEventHandler("DRP_Jobs:StartWork", function(jobTitle)
    local src = source
    local characterInfo = exports["drp_id"]:GetCharacterData(src)
    local job = jobTitle
    local jobLabel = JobsCoreConfig.PoliceJobLabels[job] -- Gets The Job Label To Display In The Notifications
    local jobRequirement = JobsCoreConfig.Requirements[job] -- Gets If You Are Enabled To Do This Job
    local currentPlayerJob = GetPlayerJob(src)
    if currentPlayerJob.job == job then
        TriggerClientEvent("DRP_Core:Error", src, "Job Manager", tostring("You are already on duty"), 2500, false, "leftCenter")
    else
    if DoesJobExist(job) then
        if jobRequirement ~= false then
            exports["externalsql"]:DBAsyncQuery({
                string = "SELECT * FROM `" .. jobRequirement .. "` WHERE `char_id` = :charid",
                data = {
                    charid = characterInfo.charid
                }
            }, function(jobResults)
                if jobResults.data[1] ~= nil then
                    SetPlayerJob(src, job, jobLabel, {
                        rank = jobResults.data[1].rank,
                        callsign = jobResults.data[1].division
                    })
                    TriggerClientEvent("DRP_Core:Info", src, "Job Manager", tostring("You are now a "..GetPlayerJob(src).jobLabel), 2500, false, "leftCenter")
                else
                    TriggerClientEvent("DRP_Core:Info", src, "Job Manager", "You are not registered for this Job!", 2500, false, "leftCenter")
                end
            end)
        else
            SetPlayerJob(src, job, jobLabel)
            end
        end
    end
end)

---------------------------------------------------------------------------
-- Main Functions
---------------------------------------------------------------------------
function GetPlayerJob(player)
    for a = 1, #playersJob do
        if playersJob[a].source == player then
            return playersJob[a]
        end
    end
    return false
end

function DoesJobExist(job)
    for a = 1, #JobsCoreConfig.Jobs do
        if JobsCoreConfig.Jobs[a] == job then
            return true
        end
    end
    return false
end

function SetPlayerJob(player, job, label)
    for a = 1, #playersJob do
        if playersJob[a].source == player then
            playersJob[a].job = job
            playersJob[a].jobLabel = label
            break
        end
    end
end