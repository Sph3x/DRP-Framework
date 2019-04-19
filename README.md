# DRP-Framework
FiveM Public Framework by: OfficalDarkzy

Backend Built Using Xander1998's DatabaseAPI Resource

# Discord Server
Please join my Discord server for live updates when I make changes and join the FiveM Dev Labs :D

https://discord.gg/hc78sSK

# Installation Guide

## Step 1
Have a standard working FXServer

Go into the DatabaseAPI resource and edit the config.js file to connect to your Database using the login details!

Then go into the externalsql resource and edit the config.lua file to connect your details from the DatabaseAPI config to the externalsql resource

## Step 2
Remove start FiveM from your server.cfg because we don't need any of the code from that anymore as we are overiding this in the drp_core 

Go into your Fivem-Map-Skater resource and go into the __resource.lua file

You will see something like this in there
```resource_type 'map' { gameTypes = { fivem = true } }```

Then Change it to this:
```resource_type 'map' { gameTypes = { drp_core = true } }```

## Step 3
Drag the two Folders named [DRP] and [DRPDATABASE] into your resource folder in your FXServer. Then add these file names to your server.cfg in this order

```
start DatabaseAPI
start externalsql
start NativeUI

start drp_core
start drp_death
start drp_id
start drp_jobcore

start drp_doors
start drp_police
start drp_medical
```

## Step 4 
Export the Database dump into your Database Tool of choice to load all the tables required

And that should be it, let me know of any issues

# The Aim
To create a free framework, that is easy to use and fully functional for anyone to use, using a custom DatabaseAPI created by Xander1998


## Credits
ToxicBacon For allowing me to use the Front end code for the inventory.

Xander1998 For the DatabaseAPI and ExternalSQL resource

SEND YOUR CUSTOM RESOURCES TO ME AND ILL ADD IT TO THE COMMUNITY RELEASES