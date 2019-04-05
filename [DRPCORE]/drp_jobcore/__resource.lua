--[[
   Scripted By: Darkzy
--]]
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependencies {
    "externalsql"
}

client_script "client.lua"
client_script "config.lua"
server_script "config.lua"
server_script "server.lua"


server_export "SetPlayerJob"
server_export "GetPlayerJob"
server_export "DoesJobExist"