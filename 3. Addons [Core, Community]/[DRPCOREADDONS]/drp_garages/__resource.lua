--[[
   Scripted By: Xander1998 (X. Cross)
--]]

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependencies {
	"externalsql"
}

ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/libraries/axios.min.js",
    "ui/libraries/vue.min.js",
    "ui/libraries/vuetify.css",
    "ui/libraries/vuetify.js",
    "ui/style.css",
    "ui/script.js"
}

client_script "client.lua"
client_script "carwash.lua"
client_script "vehiclestore/vehicleshop.lua"
client_script "damagesystem/config.lua"
client_script "damagesystem/client.lua"

server_script "damagesystem/config.lua"
server_script "damagesystem/server.lua"
server_script "vehiclestore/vehicleshop_server.lua"
server_script "server.lua"