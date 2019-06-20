resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

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
client_script "config.lua"

server_script "config.lua"
server_script "server.lua"