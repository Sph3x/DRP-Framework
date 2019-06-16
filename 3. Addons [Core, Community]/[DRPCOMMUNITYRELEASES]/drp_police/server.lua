AllCopsInService = {}
---------------------------------------------------------------------------
-- Sign On Duty Police Job
---------------------------------------------------------------------------
RegisterServerEvent("DRP_PoliceJobs:SignOnDuty")
AddEventHandler("DRP_PoliceJobs:SignOnDuty", function()
    local src = source
    TriggerEvent("DRP_Police:GetPoliceDepartment", src, function(myJobDepartment)
    local job = string.upper(myJobDepartment)
    local characterInfo = exports["drp_id"]:GetCharacterData(src)
    local jobLabel = DRPPoliceJob.PoliceJobLabels[job] -- Gets The Job Label To Display In The Notifications
    local jobRequirement = DRPPoliceJob.Requirements[job] -- Gets If You Are Enabled To Do This Job
    local currentPlayerJob = exports["drp_jobcore"]:GetPlayerJob(src)
    ---------------------------------------------------------------------------
        if currentPlayerJob.job == job then
            TriggerClientEvent("DRP_Core:Error", src, "Job Manager", tostring("You are already on duty"), 2500, true, "leftCenter")
        else
        if exports["drp_jobcore"]:DoesJobExist(job) then
            if jobRequirement ~= false then
                exports["externalsql"]:DBAsyncQuery({
                    string = "SELECT * FROM police WHERE `char_id` = :charid",
                    data = {
                        charid = characterInfo.charid
                    }
                }, function(jobResults)
                    if jobResults.data[1] ~= nil then
                        exports["drp_jobcore"]:SetPlayerJob(src, job, jobLabel, {
                            rank = jobResults.data[1].rank,
                            department = jobResults.data[1].department
                        })
                        -- Time For Some Discusting Code!
                        local policeJobTitle = ""
                        if jobResults.data[1].department == "police" then
                            policeJobTitle = "Police Officer"
                        elseif jobResults.data[1].department == "sheriff" then 
                            policeJobTitle = "Sheriff Deputy"
                        elseif jobResults.data[1].department == "state" then
                            policeJobTitle = "State Trooper"
                        end
                        TriggerClientEvent("DRP_Core:Info", src, "Government", tostring("Welcome "..policeJobTitle.." "..characterInfo.name..""), 2500, true, "leftCenter")
                        PoliceAbilities(src, jobLabel)
                        TriggerEvent("DRP_Doors:UpdatePlayerJob", src)
                        TriggerEvent("DRP_Police:CopsOnDutyData", src) -- Triggers the cop bonus counter to go up
                        TriggerEvent("DRP_Police:ServiceBlips", src)
                    end
                end)
            else
                exports["drp_jobcore"]:SetPlayerJob(src, job, jobLabel, false)
                end
            end
        end
    end)
end)
---------------------------------------------------------------------------
-- Sign Off Duty Police Job
---------------------------------------------------------------------------
RegisterServerEvent("DRP_PoliceJobs:SignOffDuty")
AddEventHandler("DRP_PoliceJobs:SignOffDuty", function()
    local src = source
    local player = exports["drp_core"]:GetPlayerData(src)
    local currentPlayerJob = exports["drp_jobcore"]:GetPlayerJob(src)
    local job = "UNEMPLOYED"
    local jobLabel = "Unemployed"
    ---------------------------------------------------------------------------
    if currentPlayerJob.jobLabel == jobLabel then
        TriggerClientEvent("DRP_Core:Error", src, "Job Manager", "You are already Unemployed", 5500, true, "leftCenter")
    else
        exports["drp_jobcore"]:SetPlayerJob(src, job, jobLabel)
        TriggerClientEvent("DRP_Core:Info", src, "Job Manager", tostring("You are now a "..exports["drp_jobcore"]:GetPlayerJob(src).jobLabel), 2500, true, "leftCenter")
        PoliceAbilities(src, jobLabel)
        TriggerEvent("DRP_Doors:UpdatePlayerJob", src)
        TriggerEvent("clothes:resetclothing", src)
        TriggerEvent("DRP_Police:CopsOnDutyDataRemove", src) -- Triggers the cop bonus counter to go down
    end
end)
---------------------------------------------------------------------------
-- Locker Room
---------------------------------------------------------------------------
RegisterServerEvent("DRP_PoliceJob:GetJobLoadouts")
AddEventHandler("DRP_PoliceJob:GetJobLoadouts", function()
    local src = source
    local rankedLoadouts = {}
    local job = exports["drp_jobcore"]:GetPlayerJob(src)
    local character = exports["drp_id"]:GetCharacterData(src)
    local rank = job.otherJobData.rank
    ---------------------------------------------------------------------------
    for k,lockerroom in ipairs(DRPPoliceJob.LockerRooms[job.jobLabel].Loadouts) do
        if lockerroom.minrank <= rank then
            if lockerroom.gender == character.gender then
                table.insert(rankedLoadouts, {
                    name = lockerroom.label,
                    model = lockerroom.model,
                    clothing = lockerroom.clothing,
                    props = lockerroom.props
                })
            end
        end
    end
    TriggerClientEvent("DRP_PoliceJob:OpenJobLoadout", src, rankedLoadouts)
    rankedLoadouts = {}
end)
---------------------------------------------------------------------------
-- Police Garages
---------------------------------------------------------------------------
RegisterServerEvent("DRP_PoliceJob:GetJobGarages")
AddEventHandler("DRP_PoliceJob:GetJobGarages", function()
    local src = source
    local rankedGarages = {}
    local job = exports["drp_jobcore"]:GetPlayerJob(src)
    local character = exports["drp_id"]:GetCharacterData(src)
    local rank = job.otherJobData.rank
    ---------------------------------------------------------------------------
    for k,garage in ipairs(DRPPoliceJob.Garages[job.jobLabel].Vehicles) do
        if garage.allowedRanks <= rank then
            table.insert(rankedGarages, {
                label = garage.label,
                model = garage.model,
                extras = garage.extras,
                livery = garage.livery
            })
        end
    end
    TriggerClientEvent("DRP_PoliceJob:OpenGarage", src, rankedGarages)
    rankedGarages = {}
end)
---------------------------------------------------------------------------
-- Police Call Handling
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Police:CallHandler")
AddEventHandler("DRP_Police:CallHandler", function(coords, information)
    local src = source
    local players = GetPlayers()
    local myCharacterName = exports["drp_id"]:GetCharacterName(src)
    ---------------------------------------------------------------------------
    for a = 0, #players do
        local playersJobs = exports["drp_jobcore"]:GetPlayerJob(tonumber(players[a]))
        if playersJobs ~= false then
            if playersJobs.job == "POLICE" or playersJobs.job == "SHERIFF" or playersJobs.job == "STATE" then
                TriggerClientEvent("DRP_Core:Info", src, "Call Handler", tostring("Thank you for your call, a unit will be contacted and we will get back to you"), 5000, false, "rightCenter")
                TriggerClientEvent("DRP_Core:Warning", tonumber(players[a]), "Police Call", tostring("A new call has come from "..information), 7500, false, "rightCenter")
                TriggerClientEvent("DRP_Police:AwaitingCall", tonumber(players[a]), coords)
            end
        end
    end
end)
---------------------------------------------------------------------------
-- Police Service Blips
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Police:ServiceBlips")
AddEventHandler("DRP_Police:ServiceBlips", function(source)
    local src = source
    ---------------------------------------------------------------------------
    for a = 1, #AllCopsInService do
        TriggerClientEvent("DRP_Police:BlipsUpdate", AllCopsInService[a].src, AllCopsInService)
    end
    TriggerClientEvent("DRP_Police:BlipToggle", src, true)
end)
---------------------------------------------------------------------------
-- Check If Police Menu Is Allowed
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Police:CheckIfMenuIsAllowed")
AddEventHandler("DRP_Police:CheckIfMenuIsAllowed", function()
    local src = source
    local job = exports["drp_jobcore"]:GetPlayerJob(src)
    ---------------------------------------------------------------------------
    if job.job == "POLICE" or job.job == "SHERIFF" or job.job == "STATE" then
        TriggerClientEvent("DRP_Interactions:OpenMenu", src)
    end
end)
---------------------------------------------------------------------------
-- HandCuff Toggle
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Police:CheckHandCuff")
AddEventHandler("DRP_Police:CheckHandCuff", function(targetPlayer)
    TriggerClientEvent("DRP_Police:HandCuffToggle", targetPlayer)
end)
---------------------------------------------------------------------------
-- Drag Player
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Police:CheckLEOEscort")
AddEventHandler("DRP_Police:CheckLEOEscort", function(targetPlayer)
    local src = source
    TriggerClientEvent("DRP_Police:EscortToggle", targetPlayer, src)
end)
---------------------------------------------------------------------------
-- Search 
---------------------------------------------------------------------------
RegisterServerEvent("DRP_PoliceJob:CheckLEOSearch")
AddEventHandler("DRP_PoliceJob:CheckLEOSearch", function(targetPlayer)
    local src = source
    local targetDataId = exports["drp_id"]:GetCharacterData(targetPlayer)
    exports["externalsql"]:DBAsyncQuery({
        string = "SELECT * FROM `character_inventory` WHERE `char_id` = :targetid",
        data = {
            targetid = targetDataId.charid
        }
    }, function(results)
        local targetInventory = results["data"]
        local stringResults = ""
        
        for a = 1, #targetInventory do
            if json.encode(targetInventory[a].quantity ~= "[]") then
                stringResults = stringResults ..targetInventory[a].name.." : "..targetInventory[a].quantity
            end
        end
        TriggerClientEvent("chatMessage", src, tostring("^0: "..stringResults..""))
        print("Target Quantity: ".. stringResults)
    end)
end)
---------------------------------------------------------------------------
-- Drag Player
---------------------------------------------------------------------------
RegisterServerEvent("DRP_PoliceJob:FinePlayer")
AddEventHandler("DRP_PoliceJob:FinePlayer", function(t, amount)
    local src = source
    TriggerClientEvent("DPR_Core:Info", src, "Government", tostring("You just fined this Person for: "..amount), 2500, false, "leftCenter")
    TriggerEvent("DRP_Bank:RemoveBankMoney", t, amount)
    TriggerClientEvent("DRP_Core:Info", t, "Government", tostring("You were fined: "..amount), 2500, true, "leftCenter")
    TriggerClientEvent("chatMessage", t, "Government", tostring("You were just fined: "..amount))
end)
---------------------------------------------------------------------------
-- Cops On Duty Counter and Source Id's
---------------------------------------------------------------------------
AddEventHandler("DRP_Police:CopsOnDutyData", function(source)
    local job = exports["drp_jobcore"]:GetPlayerJob(source)
    if job.job == "POLICE" or job.job == "SHERIFF" or job.job == "STATE" then
        table.insert(AllCopsInService, {src = source})
    end
end)
---------------------------------------------------------------------------
AddEventHandler("DRP_Police:CopsOnDutyDataRemove", function(source)
    for a = 1, #AllCopsInService do
        if AllCopsInService[a].src == source then
            table.remove(AllCopsInService, a)
            break
        end
    end
    TriggerClientEvent("DRP_Police:BlipToggle", source, false)
end)
---------------------------------------------------------------------------
-- Cops Online Callback
---------------------------------------------------------------------------
AddEventHandler("DRP_Police:CopsOnlineChecker", function(callback)
    callback(#AllCopsInService)
end)
---------------------------------------------------------------------------
-- Police Job Functions
---------------------------------------------------------------------------
function PoliceAbilities(source, label)
    local src = source
    local jobLoadouts = DRPPoliceJob.LockerRooms[label]
    local jobGarages = DRPPoliceJob.Garages[label]
    ---------------------------------------------------------------------------
    if jobLoadouts ~= nil then
        TriggerClientEvent("DRP_PoliceJob:SetLoadoutMarkerBlips", src, jobLoadouts.MarkerData, jobLoadouts.BlipData, jobLoadouts.Locations)
    else
        TriggerClientEvent("DRP_PoliceJob:SetLoadoutMarkerBlips", src, {}, {}, {})
    end
    if jobGarages ~= nil then
        TriggerClientEvent("DRP_PoliceJob:SetGarageMarkerBlips", src, jobGarages.GameStuff.MarkerData, jobGarages.GameStuff.BlipData, jobGarages.GameStuff.Locations)
    else
        TriggerClientEvent("DRP_PoliceJob:SetGarageMarkerBlips", src, {}, {}, {})
    end
end
---------------------------------------------------------------------------
-- Event Handlers
---------------------------------------------------------------------------
AddEventHandler("DRP_Police:GetPoliceDepartment", function(source, callback)
    local src = source
    local character = exports["drp_id"]:GetCharacterData(src)
    ---------------------------------------------------------------------------
    exports["externalsql"]:DBAsyncQuery({
        string = "SELECT department FROM `police` WHERE `char_id` = :charid",
        data = {
            charid = character.charid
        }
    }, function(department)
        if json.encode(department["data"]) == "[]" then
            TriggerClientEvent("DRP_Core:Error", src, "Government", "You are not registered for this Job!", 5500, false, "leftCenter")
        else
            callback(department["data"][1].department)
        end
    end)
end)
