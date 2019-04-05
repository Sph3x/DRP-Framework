local players = {}

-- BANDATA -- WHITELISTDATA
AddEventHandler("playerConnecting", function(playerName, kickReason, deferrals)
	local src = source
	local joinTime = os.time()
	deferrals.defer()
	deferrals.update("Checking Your Information, please wait...")
	SetTimeout(2500, function()
		exports["externalsql"]:DBAsyncQuery({
			string = "SELECT * FROM `users` WHERE `identifier` = :identifier",
			data = {
				identifier = PlayerIdentifier("license", src)
			}
		}, function(results)
			if #results["data"] >= 1 then
				local player = results["data"][1]
				local isBanned = json.decode(player.ban_data)
				local isWhitelisted = player.whitelisted
				if DRPCoreConfig.Whitelisted then
					if isWhitelisted == 0 then
						deferrals.done("["..DRPCoreConfig.CommunityName.."]: You are not whitelisted")
						return
					end
				end
				if isBanned.banned then
					if isBanned.perm == true then
						deferrals.done("["..DRPCoreConfig.CommunityName.."]: You have been banned for ( " .. isBanned.reason .. " ) by ( " .. isBanned.by .. " ) Duration - Permanent")
						return
					end

					local timeLeft = isBanned.time - joinTime
					local banString = ""
                    if math.floor(timeLeft / 60) <= 0 then -- REMOVE BAN
						exports["externalsql"]:DBAsyncQuery({
                            string = "UPDATE users SET `ban_data` = :bandata WHERE `identifier` = :identifier",
                            data = {
                                bandata = json.encode({banned = false, reason = "", by = "", time = 0, perm = false}),
                                identifier = PlayerIdentifier("license", src)
                            }
                        }, function(removeBan)
                            -- CHECKER
                        end)
                        banString = tostring("["..DRPCoreConfig.CommunityName.."]: Ban Removed Sucessfully, please reconnect!")
                    else
						banString = tostring("["..DRPCoreConfig.CommunityName.."]: You have been banned for ( " .. isBanned.reason .. " ) by ( " .. isBanned.by .. " ) Duration - ( " .. math.floor(timeLeft / 60) .. " ) minutes")
					end
					deferrals.done(banString)
					return
				end
				deferrals.done()
			else
				exports["externalsql"]:DBAsyncQuery({
					string = "INSERT INTO `users` SET `identifier` = :identifier, `name` = :name, `rank` = :rank, `ban_data` = :bandata, `whitelisted` = :whitelisted",
					data = {
						identifier = PlayerIdentifier("license", src),
						name = GetPlayerName(src),
						rank = DRPCoreConfig.StaffRanks.ranks[1],
						bandata = json.encode({banned = false, reason = "", by = "", time = 0, perm = false}),
						whitelisted = false
					}
				}, function(createdPlayer)
					if DRPCoreConfig.Whitelisted then
						deferrals.done("Please reconnect.. Your information has been saved and now ready to be whitelisted")
					else
						deferrals.done()
					end
				end)
			end
		end)
	end)
end)

AddEventHandler("chatMessage", function(source, color, message)
	local src = source
	local playerData = GetPlayerData(src)
	print(json.encode(playerData))
    args = stringsplit(message, " ")
    CancelEvent()
    if string.find(args[1], "/") then
        local cmd = args[1]
        table.remove(args, 1)
    end
end)

RegisterServerEvent("DRP_Core:AddPlayerToTable")
AddEventHandler("DRP_Core:AddPlayerToTable", function()
    local src = source
    exports["externalsql"]:DBAsyncQuery({
        string = "SELECT * FROM `users` WHERE `identifier` = :identifier",
        data = {
            identifier = PlayerIdentifier("license", src)
        }
    }, function(playerResults)
		table.insert(players, {id = src, rank = playerResults.data[1].rank, playerid = playerResults.data[1].id})
    end)
end)

---------------------------------------------------------------------------
-- Functions
---------------------------------------------------------------------------
function PlayerIdentifier(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)

    for a = 0, numIdentifiers do
        table.insert(identifiers, GetPlayerIdentifier(id, a))
    end

    for b = 1, #identifiers do
        if string.find(identifiers[b], type, 1) then
            return identifiers[b]
        end
    end
    return false
end

function GetPlayerData(id) -- Prob Wont Use This Much
    for a = 1, #players do
        if players[a].id == id then
            return players[a]
        end
    end
    return false
end

AddEventHandler("DRP_Core:GetPlayerData", function(id, callback)
	for a = 1, #players do
        if players[a].id == id then
			callback(players[a])
			return
        end
    end
    callback(false)
end)

function DoesRankHavePerms(rank, perm)
    local playerPerms = DRPCoreConfig.StaffRanks.perms[rank]
    for a = 1, #playerPerms do
        if playerPerms[a] == perm then
            return true
        end
    end
    return false
end

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end