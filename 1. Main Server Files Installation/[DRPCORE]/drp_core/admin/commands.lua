---------------------------------------------------------------------------
--- Get Admin Rank
---------------------------------------------------------------------------
RegisterCommand("admin", function(source, args, raw)
    local src = source
    local player = GetPlayerData(src)
    TriggerClientEvent("chatMessage", src, tostring("^2Your Permission Rank is: ^1"..player.rank))
end, false)
---------------------------------------------------------------------------
--- Set The Time USAGE: /time HOUR MINUTE fuck off spelling ree.
---------------------------------------------------------------------------
RegisterCommand("time", function(source, args, raw)
    local src = source
    local player = GetPlayerData(src)
    if player ~= false then
        if DoesRankHavePerms(player.rank, "time") then
            local hours = tonumber(args[1])
            local minutes = tonumber(args[2])
            if hours ~= nil and minutes ~= nil then
                if type(hours) ~= "number" then return end
                if type(minutes) ~= "number" then return end
                local results = RemoteSetTime(minutes, hours)
                TriggerClientEvent("chatMessage", src, tostring(results.msg))
            end
        else
            TriggerClientEvent("chatMessage", src, tostring("You do not have permissions to set the Time"))
        end
    end
end, false)
---------------------------------------------------------------------------
--- Set The Weather USAGE: /weather weathertochangetoo
---------------------------------------------------------------------------
RegisterCommand("weather", function(source, args, raw)
    local src = source
    local player = GetPlayerData(src)
    if player ~= false then
        if DoesRankHavePerms(player.rank, "weather") then
            local newWeather = string.upper(args[1])
            if newWeather ~= nil then
                ManualWeatherSet(newWeather)
                TriggerClientEvent("chatMessage", src, tostring("You have set the Weather"))
            end
        end
    else
        TriggerClientEvent("chatMessage", src, tostring("You do not have permissions to set the Weather"))
    end
end, false)
---------------------------------------------------------------------------
--- Heal Yourself USAGE: /heal
---------------------------------------------------------------------------
RegisterCommand("heal", function(source, args, raw)
    local src = source
    local player = GetPlayerData(src)
    if player ~= nil then 
        if DoesRankHavePerms(player.rank, "heal") then
            TriggerClientEvent("DRP_Core:HealCharacter", src)
        end
    end
end, false)
---------------------------------------------------------------------------
--- Set Yourself Or Others In Police Force USAGE: /adminaddcop id
---------------------------------------------------------------------------
RegisterCommand("adminaddcop", function(source, args, raw)
    -- Usage = /adminaddcop id ONLY WORKS WHEN YOU ARE A JOB YOURSELF IN THE DATABASE!
    local src = source
    local player = GetPlayerData(src)
    local newCopID = args[1]
    --Check If This Person Is Even In The Database
    if player ~= false then
        if DoesRankHavePerms(player.rank, "adminaddcop") then
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
        end
    end
end, false)

RegisterCommand("addgroup", function(source, args, raw)
    local src = source
    local player = GetPlayerData(src)
    local adminid = args[1]
    local groups = args[2]
    if player ~= false then
        if adminid ~= nil then
            print(adminid)
            if groups ~= nil then
                print(groups)
                if DoesRankHavePerms(player.rank, "addgroup") then
                    exports["externalsql"]:DBAsyncQuery({
                        string = "UPDATE `users` SET `rank` = :group WHERE `id` = :sid",
                        data = {
                            sid = adminid,
                            group = groups
                        }
                    }, function(esteadmin)
                        TriggerClientEvent("DRP_Core:Info", src, "Admin System", tostring("I-ai dat gradul de : '"..groups.."' lui : "..adminid), 2500, false, "leftCenter")
                        TriggerClientEvent("DRP_Core:Info", src, "Admin System", tostring("Ai primit gradul de : '"..groups.."' de la : "..src), 2500, false, "leftCenter")
                    end)
                else
                    TriggerClientEvent("DRP_Core:Info", src, "Admin System", tostring("Nu ai permisiunea de a da grade"), 2500, false, "leftCenter")
                end
            end
        end
    end
end, false)
