---------------------------------------------------------------------------
-- Variables
---------------------------------------------------------------------------
local copsCalled = false
local successful = false
local notIntrested = false
local selling = false
---------------------------------------------------------------------------
-- Check For Drugs On Player
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Drugs:CheckForDrugs")
AddEventHandler("DRP_Drugs:CheckForDrugs", function()
    local src = source
    selling = true
    TriggerEvent("DRP_Inventory:GetCharacterInventory", src, function(inventory)
        if json.encode(inventory) == "[]" then
            selling = false
            TriggerClientEvent("DRP_Drugs:HasDrugsOnPerson", src, false)
        elseif inventory[1].name == "marijuana" then
            TriggerClientEvent("DRP_Drugs:HasDrugsOnPerson", src, true)
        elseif inventory[1].name == "cocaine" then
            TriggerClientEvent("DRP_Drugs:HasDrugsOnPerson", src, true)
        elseif inventory[1].name == "meth" then
            TriggerClientEvent("DRP_Drugs:HasDrugsOnPerson", src, true)
        else
            selling = false
            TriggerClientEvent("DRP_Drugs:HasDrugsOnPerson", src, false)
        end
    end)
end)
---------------------------------------------------------------------------
-- Check Money Before Purchasing Raw Cocaine
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Drugs:CheckPurchaseRawCocaine")
AddEventHandler("DRP_Drugs:CheckPurchaseRawCocaine", function()
    local src = source
    local character = exports["drp_id"]:GetCharacterData(src)
    local price = DRPDrugsConfig.DrugPrices.rawcocaine
    TriggerEvent("DRP_Bank:GetCharacterMoney", character.charid, function(characterMoney)
        if characterMoney.data[1].cash >= price then
            TriggerClientEvent("DRP_Drugs:StartCollectingRawCocaine", src)
            TriggerEvent("DRP_Bank:RemoveCashMoney", src, price)
        else
            TriggerClientEvent("DRP_Core:Error", src, "Cocaine Dealer", "You do not have enough Money for this", 6000, false, "leftCenter")
        end
    end)
end)
---------------------------------------------------------------------------
-- Check What Drug The NPC Wants To Buy
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Drugs:SellCoreStart")
AddEventHandler("DRP_Drugs:SellCoreStart", function()
    local src = source
    TriggerClientEvent("DRP_Core:Info", src, "Inventory", "Negotiating what drug they want to buy", 3500, false, "leftCenter")
    passFail()
end)
---------------------------------------------------------------------------
-- Sell The Drugs To NPCS with a chance of calling the cops (to be added)
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
        local bonus = 0
        TriggerEvent("DRP_Police:CopsOnlineChecker", function(copsOnlineBonus)
            if copsOnlineBonus == 0 then
                bonus = 0
            elseif copsOnlineBonus == 2 then
                bonus = 10
            elseif copsOnlineBonus == 4 then
                bonus = 20
            elseif copsOnlineBonus == 6 then
                bonus = 40
            elseif copsOnlineBonus >= 7 then
                bonus = 55
            end
            if marijuana >= 1 and successful then
                TriggerClientEvent("DRP_Core:Info", src, "Inventory", "You sold one baggie of Marijuana for $"..marijuanaPrice.."", 6000, false, "leftCenter")
                TriggerEvent("DRP_Inventory:RemoveItemFromInventory", src, "marijuana", 1)
                TriggerEvent("DRP_Bank:AddCashMoney", src, marijuanaPrice + bonus)
                TriggerClientEvent("DRP_Drugs:Animation", src)
                selling = false
            elseif cocaine >= 1 and successful then
                TriggerClientEvent("DRP_Core:Info", src, "Inventory", "You sold one bag of Cocaine for $"..cocainePrice.."", 6000, false, "leftCenter")
                TriggerEvent("DRP_Inventory:RemoveItemFromInventory", src, "cocaine", 1)
                TriggerEvent("DRP_Bank:AddCashMoney", src, cocainePrice + bonus)
                TriggerClientEvent("DRP_Drugs:Animation", src)
                selling = false
            elseif meth >= 1 and successful then
                TriggerClientEvent("DRP_Core:Info", src, "Inventory", "You sold one bag of Meth for $"..methPrice.."", 6000, false, "leftCenter")
                TriggerEvent("DRP_Inventory:RemoveItemFromInventory", src, "meth", 1)
                TriggerEvent("DRP_Bank:AddCashMoney", src, methPrice + bonus)
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
end)
---------------------------------------------------------------------------
-- Sell Cocaine Bricks To Custom NPC Dealer
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Drugs:SellCocaineBrick")
AddEventHandler("DRP_Drugs:SellCocaineBrick", function()
    local src = source
    local cocaineBrickQuantity = nil
    local cocaineBrickPrice = DRPDrugsConfig.DrugPrices.cocainebrick
    TriggerEvent("DRP_Inventory:GetCharacterInventory", src, function(inventory)
        if inventory ~= nil then
            for a = 1, #inventory do
                if inventory[a].name == "cocainebrick" then
                    cocaineBrickQuantity = inventory[a].quantity
                    break
                end
            end
        end
        if cocaineBrickQuantity == nil then
            TriggerClientEvent("DRP_Core:Error", src, "Inventory", "You do not have any Cocaine Brick(s)", 6000, false, "leftCenter")
        elseif cocaineBrickQuantity >= 1 then
            TriggerClientEvent("DRP_Core:Info", src, "Inventory", "You sold one brick of Cocaine for $"..cocaineBrickPrice.."", 6000, false, "leftCenter")
            TriggerEvent("DRP_Inventory:RemoveItemFromInventory", src, "cocainebrick", 1)
            TriggerEvent("DRP_Bank:AddCashMoney", src, cocaineBrickPrice)
        end
    end)
end)
---------------------------------------------------------------------------
-- Process Drug From One To The Other
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Drugs:ProcessItem")
AddEventHandler("DRP_Drugs:ProcessItem", function(itemtoremove, itemtoadd)
    local src = source
    TriggerEvent("DRP_Inventory:CheckForItemOwnershipByName", src, itemtoremove, function(Ownership)
        if json.encode(Ownership) == "[]" then
            TriggerClientEvent("DRP_Core:Error", src, "Drugs", "You do not have any of this!", 7500, false, "leftCenter")
        else
            TriggerEvent("DRP_Drugs:RemoveThenAdd", src, itemtoadd)
        end
    end)
end)
---------------------------------------------------------------------------
-- Cutting And Packaging Cocaine Inventory Checker
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Drugs:CutAndPackageCocaine")
AddEventHandler("DRP_Drugs:CutAndPackageCocaine", function()
    local src = source
    TriggerEvent("DRP_Inventory:CheckForItemOwnershipByName", src, "cocaine", function(Ownership)
        if json.encode(Ownership) == "[]" then
            TriggerClientEvent("DRP_Core:Error", src, "Drugs", "You do not have any of this!", 7500, false, "leftCenter")
        elseif Ownership[1].quantity < 5 then
            TriggerClientEvent("DRP_Core:Error", src, "Drugs", "You need a total of 5 to package this", 7500, false, "leftCenter")
        elseif Ownership[1].quantity >= 5 then
            TriggerEvent("DRP_Drugs:CuttingAndPacking", src, "cocaine")
        end
    end)
end)
---------------------------------------------------------------------------
-- Cutting And Then Packing Cocaine Into A Brick :D
---------------------------------------------------------------------------
AddEventHandler("DRP_Drugs:CuttingAndPacking", function(source, itemname)
    local src = source
    local character = exports["drp_id"]:GetCharacterData(src)
    local itemToChange = nil
    -- Remove Item First Then Add New One
    TriggerEvent("DRP_Inventory:CheckForItemOwnershipByName", src, "cocaine", function(Ownership)
        local quantity = Ownership[1].quantity
        local newquantity = quantity - 5
        if newquantity ~= 0 then
            exports["externalsql"]:DBAsyncQuery({
                string = "UPDATE character_inventory SET `quantity` = :newamount WHERE `charid` = :char_id and `name` = :itemname",
                data = {
                    newamount = newquantity,
                    char_id = character.charid,
                    itemname = itemname
                }
            }, function(yeet)
            end)
        else
            exports["externalsql"]:DBAsyncQuery({
                string = "DELETE FROM `character_inventory` WHERE `charid` = :char_id and `name` = :itemname",
                data = {
                    char_id = character.charid,
                    itemname = itemname
                }
            }, function(yeeting)
            end)
        end
        Wait(250)
    -- Add New Item
        exports["drp_inventory"]:AddItem(src, "cocainebrick", 1)
    end)
end)
---------------------------------------------------------------------------
-- Remove The Drug And Then Replace With
---------------------------------------------------------------------------
AddEventHandler("DRP_Drugs:RemoveThenAdd", function(source, itemname)
    local src = source
    local character = exports["drp_id"]:GetCharacterData(src)
    local itemToChange = nil
    -- Remove Item First Then Add New One
    if itemname == "marijuana" then 
        itemToChange = "weed"
    elseif itemname == "cocaine" then
        itemToChange = "rawcocaine"
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
        Wait(250)
    -- Add New Item
        exports["drp_inventory"]:AddItem(src, itemname, 1)
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