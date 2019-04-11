---------------------------------------------------------------------------
-- Event Handlers And Callbacks
---------------------------------------------------------------------------
AddEventHandler("DRP_Inventory:GetInventorySize", function(source, callback)
    local src = source
    local characterInfo = exports["drp_id"]:GetCharacterData(src)
    exports["externalsql"]:DBAsyncQuery({
        string = "SELECT * FROM `character_inventory` WHERE `charid` = :char_id",
        data = {
            char_id = characterInfo.charid
        }
    }, function(inventorySize)
        local results = inventorySize["data"]
        local maxQuantity = 20
        local quantityAmount = 0

        for a = 1, #results do
            quantityAmount = quantityAmount + results[a].quantity
        end

        print("Quantity Amount: " .. quantityAmount)
        callback(quantityAmount)
    end)
end)

AddEventHandler("DRP_Inventory:CheckForItemOwnershipById", function(source, itemid, callback)
    local src = source
    local characterInfo = exports["drp_id"]:GetCharacterData(src)
    exports["externalsql"]:DBAsyncQuery({
        string = "SELECT * FROM `character_inventory` WHERE `charid` = :char_id and `itemid` = :itemid",
        data = {
            char_id = characterInfo.charid,
            itemid = itemid
        }
    }, function(CheckForItemOwnership)
        callback(CheckForItemOwnership.data)
    end)
end)

AddEventHandler("DRP_Inventory:CheckForItemOwnershipByName", function(source, itemname, callback)
    local src = source
    local characterInfo = exports["drp_id"]:GetCharacterData(src)
    exports["externalsql"]:DBAsyncQuery({
        string = "SELECT * FROM `character_inventory` WHERE `charid` = :char_id and `name` = :itemname",
        data = {
            char_id = characterInfo.charid,
            itemname = itemname
        }
    }, function(CheckForItemOwnership)
        callback(CheckForItemOwnership.data)
    end)
end)

---------------------------------------------------------------------------
-- Manager Functions
---------------------------------------------------------------------------
function CheckForItemOwnershipByName(source, itemname)
    local src = source
    local characterInfo = exports["drp_id"]:GetCharacterData(src)
    exports["externalsql"]:DBAsyncQuery({
        string = "SELECT * FROM `character_inventory` WHERE `charid` = :char_id and `name` = :itemname",
        data = {
            char_id = characterInfo.charid,
            itemname = itemname
        }
    }, function(CheckForItemOwnership)
        return CheckForItemOwnership.data
    end)
end

function AddItem(source, itemname, amount)
    local src = source
    local itemname = string.lower(itemname)
    local character = exports["drp_id"]:GetCharacterData(src)
    TriggerEvent("DRP_Inventory:GetInventorySize", src, function(AmountOfSpace)
        if AmountOfSpace >= DRPInventory.MaxInventorySlots then
            print("no invent space left retard")
        else
            print("Adding item "..itemname.."")
                TriggerEvent("DRP_Inventory:CheckForItemOwnershipByName", src, itemname, function(Ownership)
                if json.encode(Ownership == "[]") then
                    local newItemData = pullItemData(itemname)
                    exports["externalsql"]:DBAsyncQuery({
                        string = "INSERT INTO `character_inventory` SET `name` = :itemname, `quantity` = :amount, `itemid` = :itemid, `charid` = :charid",
                        data = {
                            itemname = itemname,
                            amount = amount,
                            itemid = newItemData[1].id,
                            charid = character.charid
                        }
                    }, function(createdPlayer)
                    end)
                else
                    print("Adding More Of This"..itemname)
                end
            end)
        end
    end)
end

function pullItemData(itemname)
    exports["externalsql"]:DBAsyncQuery({
        string = "SELECT * FROM `inventory_items` WHERE `itemname` = :itemname",
        data = {
            itemname = itemname
        }
    }, function(allDataInfo)
        return allDataInfo.data
    end)
    return false
end