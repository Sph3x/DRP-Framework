# DRP-Framework
FiveM Public Framework by: OfficalDarkzy

Backend Built Using Xander1998's DatabaseAPI Resource

# Installation Guide

## Step 1
Have a standard working FXServer

Go into the DatabaseAPI resource and edit the config.js file to connect to your Database using the login details!

Then go into the externalsql resource and edit the config.lua file to connect your details from the DatabaseAPI config to the externalsql resource

## Step 2
Go into your Fivem-Map-Skater resource and go into the __resource.lua file

You will see something like this in there
### resource_type 'map' { gameTypes = { fivem = true } }

Then Change it to this:
### resource_type 'map' { gameTypes = { drp_core = true } }

## Step 3
Drag the two Folders named [DRP] and [DRPDATABASE] into your resource folder in your FXServer. Then add these file names to your server.cfg in this order

start DatabaseAPI
start externalsql
start drp_core
start drp_death
start drp_id

## Step 4 
Export the Database dump into your Database Tool of choice to load all the tables required

And that should be it, let me know of any issues

# The Aim
To create a free framework, that is easy to use and fully functional for anyone to use, using a custom DatabaseAPI created by Xander1998
