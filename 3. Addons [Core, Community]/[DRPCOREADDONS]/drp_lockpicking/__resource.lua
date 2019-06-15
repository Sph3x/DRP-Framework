resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependencies {
    "drp_core",
    "drp_inventory"
}

client_script "client.lua"
client_script "keyrobbing/npcrobbing.lua"
client_script "config.lua"

server_script "config.lua"
server_script "server.lua"