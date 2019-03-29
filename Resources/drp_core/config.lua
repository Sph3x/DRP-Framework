DRPCoreConfig = {}
DRPCoreConfig.StaffRanks = {}

DRPCoreConfig.Whitelisted = false -- true or false
DRPCoreConfig.CommunityName = "DRP Framework"

DRPCoreConfig.StaffRanks.ranks = {"User", "Moderator", "Administrator", "Developer", "Owner"}
DRPCoreConfig.StaffRanks.perms = {
    ["User"] = {},
    ["Moderator"] = {""},
    ["Administrator"] = {""},
    ["Developer"] = {""},
    ["Owner"] = {""}
}