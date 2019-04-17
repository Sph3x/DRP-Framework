local atm_models = {"prop_fleeca_atm", "prop_atm_01", "prop_atm_02", "prop_atm_03"}
local atmOpen = false
local banks = {
  {name="Bank", id=108, x=150.266, y=-1040.203, z=29.374},
  {name="Bank", id=108, x=-1212.980, y=-330.841, z=37.787},
  {name="Bank", id=108, x=-2962.582, y=482.627, z=15.703},
  {name="Bank", id=108, x=-112.202, y=6469.295, z=31.626},
  {name="Bank", id=108, x=314.187, y=-278.621, z=54.170},
  {name="Bank", id=108, x=-351.534, y=-49.529, z=49.042},
  {name="Bank", id=108, x=241.727, y=220.706, z=106.286},
}

-- Display Map Blips
Citizen.CreateThread(function()
    for _, item in pairs(banks) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, item.id)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(item.name)
        EndTextCommandSetBlipName(item.blip)
    end
end)
---------------------------------------------------------------------------
-- Triggers ATM menu to open
---------------------------------------------------------------------------
RegisterNetEvent("DRP_Bank:OpenMenu")
AddEventHandler("DRP_Bank:OpenMenu", function(name, balance, cash)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "open_atm_menu",
        name = name,
        balance = balance,
        cash = cash
    })
end)

---------------------------------------------------------------------------
-- Closes ATM menu and cancels animation
---------------------------------------------------------------------------
RegisterNUICallback("closeatm", function(data, callback)
    SetNuiFocus(false, false)
    local pedPos = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local pedHead = GetEntityHeading(GetPlayerPed(PlayerId()))
    TaskStartScenarioAtPosition(GetPlayerPed(PlayerId()), "PROP_HUMAN_ATM", pedPos.x, pedPos.y, pedPos.z + 1.0, pedHead, 0, 0, 0)
    atmOpen = false
    callback("ok")
    Citizen.Wait(5000)
    ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
end)

---------------------------------------------------------------------------
-- Handles distance to atm models with offset position
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(PlayerId())
        local pedPos = GetEntityCoords(ped, false)
        for a = 1, #atm_models do
            local atm = GetClosestObjectOfType(pedPos.x, pedPos.y, pedPos.z, 5.0, GetHashKey(atm_models[a]), false, 1, 1)
            if atm ~= 0 and not atmOpen then

                local atmOffset = GetOffsetFromEntityInWorldCoords(atm, 0.0, -0.7, 0.0)
                local atmHeading = GetEntityHeading(atm)
                local distance = Vdist(pedPos.x, pedPos.y, pedPos.z, atmOffset.x, atmOffset.y, atmOffset.z)
                DrawMarker(29, atmOffset.x, atmOffset.y, atmOffset.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 30, 144, 255, 0.8, 1, 0, 0, 1, 0, 0, 0)
                
                if distance <= 1.2 then
                    textDisplay("Press ~INPUT_PICKUP~ to use the ATM")
                    if IsControlJustPressed(1, 38) then
                        TaskStartScenarioAtPosition(ped, "PROP_HUMAN_ATM", atmOffset.x, atmOffset.y, atmOffset.z + 1.0, atmHeading, -1, 0, 0)
                        Citizen.Wait(5000)
                        Citizen.Trace("opening bank menu")
                            TriggerServerEvent("DRP_Bank:RequestATMInfo")
                        atmOpen = true
                    end
                end
            end
        end
        Citizen.Wait(1)
    end
end)


---------------------------------------------------------------------------
-- NUI Functions
---------------------------------------------------------------------------
RegisterNUICallback("depositatm", function(data, cb)
    TriggerServerEvent("DRP_Bank:DepositMoney", data.amount)
    cb("ok")
end)

RegisterNUICallback("withdrawatm", function(data, cb)
    TriggerServerEvent("DRP_Bank:WithdrawMoney", data.amount)
    cb("ok")
end)

RegisterNetEvent("DRP_Bank:ActionCallback")
AddEventHandler("DRP_Bank:ActionCallback", function(status, message, balance, cash)
    SendNUIMessage({
        type = "update_atm_menu",
        status = status,
        message = message,
        balance = balance,
        cash = cash
    })
    if status == false then
        TriggerEvent("DRP_Core:Error", "The Bank", message, 5000, false, "leftCenter")
    end
end)


function textDisplay(string)
    SetTextComponentFormat("STRING")
    AddTextComponentString(string)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end