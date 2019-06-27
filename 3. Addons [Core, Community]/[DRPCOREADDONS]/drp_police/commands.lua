---------------------------------------------------------------------------
-- Add Cop -- Will add them to the POLICE rank. You must be on duty for this to work aswell  USAGE: /addcop CHARID
---------------------------------------------------------------------------
RegisterCommand("addcop", function(source, args, raw)
    -- Usage = /addcop id ONLY WORKS WHEN YOU ARE A JOB YOURSELF IN THE DATABASE!
    local src = source
    local myJob = exports["drp_jobcore"]:GetPlayerJob(src)
    local newCopID = args[1]
    if myJob.job == "POLICE" or myJob.job == "SHERIFF" or myJob.job == "STATE" then
        if myJob.otherJobData.rank ~= false then
            if myJob.otherJobData.rank >= DRPPoliceJob.RankAllowedToAddCop then
                --Check If This Person Is Even In The Database
                exports["externalsql"]:DBAsyncQuery({
                    string = "SELECT * FROM `characters` WHERE `id` = :charid",
                    data = {
                        charid = newCopID
                    }
                }, function(doesPlayerExist)
                        if json.encode(doesPlayerExist["data"]) ~= "[]" then
                    --Check If That Person Is A Cop Already
                        exports["externalsql"]:DBAsyncQuery({
                            string = "SELECT * FROM `police` WHERE `char_id` = :charid",
                            data = {
                                charid = newCopID
                            }
                        }, function(isPoliceOfficer)
                            if json.encode(isPoliceOfficer["data"]) == "[]" then
                                -- Add This Person To Be A Cop
                                exports["externalsql"]:DBAsyncQuery({
                                    string = "INSERT INTO `police` SET `rank` = :rank, `char_id` = :charid",
                                    data = {
                                        rank = 1,
                                        charid = newCopID
                                    }
                                }, function(yeet)
                                    TriggerClientEvent("DRP_Core:Info", src, "Government", "This person has been added to the Police Employment Database", 5500, false, "leftCenter")
                                    TriggerClientEvent("DRP_Core:Info", newCopID, "Government", "You have been hired into the Police Force, Congratulations", 5500, false, "leftCenter")
                                end)
                            else
                                TriggerClientEvent("DRP_Core:Warning", src, "Government", "This Person is already a Cop, do not need to add them twice", 5500, false, "leftCenter")
                            end
                        end)
                    else
                        TriggerClientEvent("DRP_Core:Warning", src, "Government", "This Person does not exist in this County", 5500, false, "leftCenter")
                    end
                end)
            else
                TriggerClientEvent("DRP_Core:Error", src, "Government", "You are not the required Police Rank to do this!", 5500, false, "leftCenter")
            end
        end
    else    
        TriggerClientEvent("DRP_Core:Error", src, "Government", "You are not an Employee of the Police Force or you need to be on Duty", 5500, false, "leftCenter")
    end
end, false)
---------------------------------------------------------------------------
-- Remove Cop USAGE: /removecop CHARID
---------------------------------------------------------------------------
RegisterCommand("removecop", function(source, args, raw)
    local src = source
    local myJob = exports["drp_jobcore"]:GetPlayerJob(src)
    local removeCopID = args[1]
    if myJob.job == "POLICE" or myJob.job == "SHERIFF" or myJob.job == "STATE" then
        if myJob.otherJobData.rank ~= false then
            if myJob.otherJobData.rank >= DRPPoliceJob.RankAllowedToRemoveCop then
                exports["externalsql"]:DBAsyncQuery({
                    string = "SELECT * FROM `police` WHERE `char_id` = :charid",
                    data = {
                        charid = removeCopID
                    }
                }, function(isPoliceOfficer)
                    if json.encode(isPoliceOfficer["data"]) == "[]" then
                        TriggerClientEvent("DRP_Core:Info", src, "Government", "This person is not a Police Officer", 5500, false, "leftCenter")
                    else
                        exports["externalsql"]:DBAsyncQuery({
                            string = "DELETE FROM `police` WHERE `char_id` = :charid",
                            data = {
                                charid = removeCopID
                            }
                        }, function(removedOfficer)
                            TriggerClientEvent("DRP_Core:Info", src, "Government", "This person has been removed from the Force", 5500, false, "leftCenter")
                            TriggerClientEvent("DRP_Core:Error", removeCopID, "Government", "You have been removed from the Force", 5500, false, "leftCenter")
                        end)
                    end
                end)
            end
        end
    end
end, false)