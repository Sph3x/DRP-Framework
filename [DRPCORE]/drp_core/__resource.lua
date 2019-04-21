--[[
   Scripted By: Darkzy
--]]

resource_type 'gametype' { name = 'DarkRP' }

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependencies {
    "externalsql"
}

ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/libraries/vue.min.js",
    "ui/libraries/axios.min.js",
    "ui/libraries/material.css",
    "ui/libraries/vue-snotify.min.js",
    "ui/script.js"
}

client_script "fivem.lua"
client_script "notifications/notifications.lua"
client_script "client.lua"
client_script "config.lua"
client_script "weaponsonback.lua"
client_script "managers/voip.lua"
client_script "managers/managers.lua"
client_script "debug/client.lua"

server_script "config.lua"
server_script "server.lua"

export "DrawText3Ds"
export "getRealWeapons"
export "drawText"
server_export "GetPlayerData"