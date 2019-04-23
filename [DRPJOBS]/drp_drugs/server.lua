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
        elseif inventory[1].name == "marijuana" then
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
    local marijuana = 0
    local cocaine = 0
    local meth = 0
    TriggerEvent("DRP_Inventory:GetCharacterInventory", src, function(inventory)
        for a = 1, #inventory do -- Could be cleaned up
            if inventory[a].name == "marijuana" then
                marijuana = inventory[a].quantity
            elseif inventory[a].name == "cocaine" then
                cocaine = inventory[a].quantity
            elseif inventory[a].name == "meth" then
                meth = inventory[a].quantity 
            end
        end
        local marijuanaPrice = DRPDrugsConfig.DrugPrices.marijuana
        local cocainePrice = DRPDrugsConfig.DrugPrices.cocaine
        local methPrice = DRPDrugsConfig.DrugPrices.meth
        if marijuana >= 1 and successful then
            TriggerClientEvent("DRP_Core:Info", src, "Inventory", "You sold one baggie of Marijuana for $"..marijuanaPrice.."", 6000, false, "leftCenter")
            TriggerEvent("DRP_Inventory:RemoveItemFromInventory", src, "marijuana", 1)
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
        elseif marijuana <= 0 then
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

RegisterServerEvent("DRP_Drugs:ProcessItem")
AddEventHandler("DRP_Drugs:ProcessItem", function(itemname)
    local src = source
    TriggerEvent("DRP_Inventory:CheckForItemOwnershipByName", src, "weed", function(Ownership)
        if json.encode(Ownership) == "[]" then
            TriggerClientEvent("DRP_Core:Error", src, "Drugs", "You do not have any of this!", 7500, false, "leftCenter")
        else
            TriggerEvent("DRP_Drugs:RemoveThenAdd", src, itemname)
        end
    end)
end)

AddEventHandler("DRP_Drugs:RemoveThenAdd", function(source, itemname)
    local src = source
    local character = exports["drp_id"]:GetCharacterData(src)
    local itemToChange = nil
    -- Remove Item First Then Add New One
    if itemname == "marijuana" then 
        itemToChange = "weed"
    end
    TriggerEvent("DRP_Inventory:CheckForItemOwnershipByName", src, itemToChange, function(Ownership)
        local quantity = Ownership[1].quantity
        local newquantity = quantity - 1
        if newquantity ~= 0 then
            exports["externalsql"]:DBAsyncQuery({
                string = "UPDATE character_inventory SET `quantity` = :newamount WHERE `charid` = :char_id and `name` = :itemname",
                data = {
                    newamount = newquantity,
                    char_id = character.charid,
                    itemname = itemToChange
                }
            }, function(yeet)
            end)
        else
            exports["externalsql"]:DBAsyncQuery({
                string = "DELETE FROM `character_inventory` WHERE `charid` = :char_id and `name` = :itemname",
                data = {
                    char_id = character.charid,
                    itemname = itemToChange
                }
            }, function(yeeting)
            end)
        end
    end)
    -- Add New Item
    exports["drp_inventory"]:AddItem(src, itemname, 1)
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