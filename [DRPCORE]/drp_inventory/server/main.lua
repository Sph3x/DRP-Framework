DRP = {}
DRP.PickupId = 0
DRP.Pickups = {}
--------------------------------------------------------------
---------------------------------------------------------------------------
-- Get All Inventory Information
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Inventory:GetInventory")
AddEventHandler("DRP_Inventory:GetInventory", function()
    local src = source
    local characterInfo = exports["drp_id"]:GetCharacterData(src)
    local jobInfo = exports["drp_jobcore"]:GetPlayerJob(src)
    TriggerEvent("DRP_Bank:GetCharacterMoney", characterInfo.charid, function(bank)
        local bankInfo = bank["data"]
    exports["externalsql"]:DBAsyncQuery({
        string = "SELECT * FROM `character_inventory` WHERE `charid` = :char_id",
        data = {
            char_id = characterInfo.charid
        }
    }, function(inventoryResults)
    ------------------------------------------------------------------------------------
        TriggerClientEvent("DRP_Inventory:OpenInventory", src, inventoryResults["data"], bankInfo[1].cash, bankInfo[1].bank, bankInfo[1].dirtyCash, jobInfo.jobLabel)
      end)
    end)
end)
---------------------------------------------------------------------------
-- Add Item Event
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Inventory:AddItem")
AddEventHandler("DRP_Inventory:AddItem", function(itemname)
    print("this get triggered?")
    local src = source
    local itemname = string.lower(itemname)
    local character = exports["drp_id"]:GetCharacterData(src)
    TriggerEvent("DRP_Inventory:GetInventorySize", src, function(AmountOfSpace)
        if AmountOfSpace >= DRPInventory.MaxInventorySlots then
            TriggerClientEvent("DRP_Core:Error", src, "Inventory", "You have no Inventory space left", 2500, false, "leftCenter")
        else
            TriggerEvent("DRP_Inventory:CheckForItemOwnershipByName", src, itemname, function(Ownership)
                if json.encode(Ownership) == "[]" then
                    TriggerEvent("DRP_Inventory:PullItemData", itemname, function(itemInfoId)
                        exports["externalsql"]:DBAsyncQuery({
                            string = "INSERT INTO `character_inventory` SET `name` = :itemname, `quantity` = :amount, `itemid` = :itemid, `charid` = :charid",
                            data = {
                                itemname = itemname,
                                amount = 1,
                                itemid = itemInfoId,
                                charid = character.charid
                            }
                        }, function(createdPlayer)
                            TriggerClientEvent("DRP_Core:Info", src, "Inventory", "You have added 1 Weed to your inventory", 2500, false, "leftCenter")
                        end)
                    end)
                    else
                        local amountToAdd = Ownership[1].quantity + 1
                        exports["externalsql"]:DBAsyncQuery({
                            string = "UPDATE character_inventory SET `quantity` = :amount WHERE `charid` = :charid and `name` = :itemname",
                            data = {
                                amount = amountToAdd,
                                charid = character.charid,
                                itemname = itemname
                            }
                        }, function(updatedQuantity)
                            TriggerClientEvent("DRP_Core:Info", src, "Inventory", "You have added 1 Weed to your inventory", 2500, false, "leftCenter")
                    end)
                end
            end)
        end
    end)
end)
---------------------------------------------------------------------------
-- Remove Item ONLY FOR DROPPING IN THE INVENTORY
---------------------------------------------------------------------------
RegisterServerEvent("DRP_Inventory:RemoveItem")
AddEventHandler("DRP_Inventory:RemoveItem", function(itemname, count)
    local src = source
    local itemname = itemname
    local character = exports["drp_id"]:GetCharacterData(src)
    TriggerEvent("DRP_Inventory:CheckForItemOwnershipByName", src, itemname, function(Ownership)
    ------------------------------------------------------------------------------------
        local quantity = Ownership[1].quantity
        local newquantity = quantity - count
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
        ------------------------------------------------------------------------------------
        local pickupLabel = ('~b~%s~s~ [~b~%s~s~]'):format(itemname, count)
        CreatePickup(itemname, count, pickupLabel, src)
    end)
end)
---------------------------------------------------------------------------
-- Pickup Event
---------------------------------------------------------------------------
RegisterServerEvent('DRP_Inventory:Pickup')
AddEventHandler('DRP_Inventory:Pickup', function(id)
	local src = source
    local pickup  = DRP.Pickups[id]
    TriggerEvent("DRP_Inventory:GetInventorySize", src, function(AmountOfSpace)
        local item      = CheckForItemOwnershipByName(src, pickup.name)
        local canTake   = (DRPInventory.MaxInventorySlots - AmountOfSpace) or 0
        local total     = pickup.count < canTake and pickup.count or canTake
        local remaining = pickup.count - total
        ------------------------------------------------------------------------------------
        TriggerClientEvent('DRP_Inventory:removePickup', -1, id)
        
        if remaining > 0 then
            local pickupLabel = ('~b~%s~s~ [~b~%s~s~]'):format(pickup.name, remaining)
            CreatePickup(pickup.name, remaining, pickupLabel, src)
        end
        ------------------------------------------------------------------------------------
		if total > 0 then
            AddItem(src, pickup.name, total)
		end
    end)
end)

RegisterServerEvent("DRP_Inventory:CheckInventorySpace")
AddEventHandler("DRP_Inventory:CheckInventorySpace", function()
    local src = source
    TriggerEvent("DRP_Inventory:GetInventorySize", src, function(AmountOfSpace)
        local totalAmount = AmountOfSpace
        if totalAmount >= 20 then
            TriggerClientEvent("DRP_Core:Error", src, "Inventory", "You have no Inventory space left", 2500, false, "leftCenter")
        else
            TriggerClientEvent("DRP_Drugs:GiveWeed", src)
        end
    end)
end)    

AddEventHandler("DRP_Inventory:RemoveItemFromInventory", function(source, itemname)
    local src = source
    local itemname = itemname
    local character = exports["drp_id"]:GetCharacterData(src)
    TriggerEvent("DRP_Inventory:CheckForItemOwnershipByName", src, itemname, function(Ownership)
    ------------------------------------------------------------------------------------
        local quantity = Ownership[1].quantity
        local newquantity = quantity - 1
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
    end)
end)

---------------------------------------------------------------------------
-- Functions
---------------------------------------------------------------------------
function CreatePickup(name, count, label, player)
    local pickupId = (DRP.PickupId == 65635 and 0 or DRP.PickupId + 1)
	DRP.Pickups[pickupId] = {
		name  = name,
		count = count
    }
    ------------------------------------------------------------------------------------
    TriggerClientEvent('DRP_Inventory:CreatePickup', -1, pickupId, label, player)
	DRP.PickupId = pickupId
end