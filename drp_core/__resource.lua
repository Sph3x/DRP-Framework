--[[
   Scripted By: Darkzy
--]]

resource_type 'gametype' { name = 'DRP' }

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependencies {
    "externalsql"
}

client_script "fivem.lua"
client_script "client.lua"
client_script "voip.lua"

--Death
client_script "death/client.lua"
client_script "death/config.lua"
server_script "death/config.lua"
server_script "death/server.lua"