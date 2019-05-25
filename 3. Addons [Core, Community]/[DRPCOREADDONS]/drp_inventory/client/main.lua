local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
---------------------------------------------------------------------------
-- Listener
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlJustPressed(0, Keys['Y']) then
            TriggerServerEvent("DRP_Inventory:GetInventory")
            Citizen.Wait(500)
        end
    end
end)
---------------------------------------------------------------------------
-- Open NUI
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Inventory:OpenInventory")
AddEventHandler("DRP_Inventory:OpenInventory", function(inventory, cash, bank, dirty, jobLabel)
    inventoryLoader(inventory, cash, bank, dirty, jobLabel)
    SendNUIMessage({
        action = "open",
        array = source
    })
    SetNuiFocus(true, true)
    SendNUIMessage({
        cash = cash,
        bank = bank,
        dirty = dirty,
        label = jobLabel
    })
end)
---------------------------------------------------------------------------
-- Get Inventory Function
---------------------------------------------------------------------------
function inventoryLoader(inventory)
    local item = {
        ["name"] = "test", ["quantity"] = 2
    }

    for a = 1, #inventory do
        if inventory[a].quantity >= 1 then
            table.insert(item, {inventory[a].name, inventory[a].quantity})
        end
    end
    SendNUIMessage({
        items = item
    })
    local item = {}
end
---------------------------------------------------------------------------
-- NUI Callbacks
---------------------------------------------------------------------------
RegisterNUICallback('NUIFocusOff', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('notenoughitems', function(data)
    TriggerEvent("DRP_Core:Error", "Inventory", "You dont have that many "..data.item.."(s) to drop", 5500, false, "centerBottom")
end)

RegisterNUICallback("drop", function(data)
    print(data.item, data.count)
    TriggerServerEvent("DRP_Inventory:RemoveItem", data.item, data.count)
end)

RegisterNUICallback('use', function(data)
    SetNuiFocus(false, false)
    print(json.encode(data.item))
    TriggerEvent("DRP_Inventory:CheckItemsUse", data.item)
end)
