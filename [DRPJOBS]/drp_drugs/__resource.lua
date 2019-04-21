resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependencies {
    "externalsql",
    "drp_inventory"
}

client_script "config.lua"
client_script "jobs/weed.lua"
client_script "selltonpc.lua"
server_script "config.lua"
server_script "server.lua"