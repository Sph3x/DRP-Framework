local copsCalled = false
local successful = false
local notIntrested = false
local selling = false
---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Drugs:CheckForDrugs")
AddEventHandler("DRP_Drugs:CheckForDrugs", function()
    local src = source
    local selling = true
    TriggerEvent("DRP_Inventory:GetCharacterInventory", src, function(inventory)
        if json.encode(inventory) == "[]" then
            TriggerClientEvent("DRP_Drugs:HasDrugsOnPerson", src, false)
        elseif inventory[1].name == "weed" then
            TriggerClientEvent("DRP_Drugs:HasDrugsOnPerson", src, true)
        else 
            TriggerClientEvent("DRP_Drugs:HasDrugsOnPerson", src, false)
        end
    end)
end)
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Drugs:SellCoreStart")
AddEventHandler("DRP_Drugs:SellCoreStart", function()
    local src = source
    TriggerClientEvent("DRP_Core:Info", src, "Inventory", "Negotiating to sell drugs to this person", 3500, false, "leftCenter")
    passFail()
end)
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Drugs:Sell")
AddEventHandler("DRP_Drugs:Sell", function()
    local src = source
    local weed = 0
    local cocaine = 0
    local meth = 0
    TriggerEvent("DRP_Inventory:GetCharacterInventory", src, function(inventory)
        for a = 1, #inventory do -- Could be cleaned up
            if inventory[a].name == "weed" then
                weed = inventory[a].quantity
            elseif inventory[a].name == "cocaine" then
                cocaine = inventory[a].quantity
            elseif inventory[a].name == "meth" then
                meth = inventory[a].quantity 
            end
        end
        local weedPrice = DRPDrugsConfig.DrugPrices.weed
        local cocainePrice = DRPDrugsConfig.DrugPrices.cocaine
        local methPrice = DRPDrugsConfig.DrugPrices.meth
        if weed >= 1 and successful then
            TriggerClientEvent("DRP_Core:Info", src, "Inventory", "You sold one bag of weed for $"..weedPrice.."", 6000, false, "leftCenter")
            TriggerEvent("DRP_Inventory:RemoveItemFromInventory", src, "weed", 1)
            TriggerClientEvent("DRP_Drugs:Animation", src)
            selling = false
        elseif cocaine >= 1 and successful then
            TriggerClientEvent("DRP_Core:Info", src, "Inventory", "You sold one bag of Cocaine for $"..cocainePrice.."", 6000, false, "leftCenter")
            TriggerEvent("DRP_Inventory:RemoveItemFromInventory", src, "cocaine", 1)
            TriggerClientEvent("DRP_Drugs:Animation", src)
            selling = false
        elseif meth >= 1 and successful then
            TriggerClientEvent("DRP_Core:Info", src, "Inventory", "You sold one bag of Meth for $"..methPrice.."", 6000, false, "leftCenter")
            TriggerEvent("DRP_Inventory:RemoveItemFromInventory", src, "meth", 1)
            TriggerClientEvent("DRP_Drugs:Animation", src)
            selling = false
        elseif weed <= 0 then
            TriggerClientEvent("DRP_Core:Info", src, "Inventory", "You do not have any weed", 6000, false, "leftCenter")
        elseif cocaine <= 0 then
            TriggerClientEvent("DRP_Core:Info", src, "Inventory", "You do not have any Cocaine", 6000, false, "leftCenter")
        elseif meth <= 0 then
            TriggerClientEvent("DRP_Core:Info", src, "Inventory", "You do not have any Meth", 6000, false, "leftCenter")  
        else
            TriggerClientEvent("DRP_Core:Info", src, "Inventory", "You do not have any drugs", 6000, false, "leftCenter")
        end
    end)
end)
---------------------------------------------------------------------------
-- Functions
---------------------------------------------------------------------------
function passFail() -- Re do this ASAP
    local percent = math.random(1, 11)
    if percent == 7 or percent == 8 or percent == 9 then
        successful = false
        notIntrested = true
    elseif percent ~= 8 and percent ~= 9 and percent ~= 10 and percent ~= 7 then
        successful = true
        notIntrested = false
    else
        notIntrested = false
        successful = false
        copsCalled = true
    end
end