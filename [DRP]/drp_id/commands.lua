---------------------------------------------------------------------------
-- Put on a hat!
---------------------------------------------------------------------------
RegisterCommand("haton", function(source, args, raw)
	local src = source
	local hat = SetPedComponentVariation(ped, ISRPCharactersConfig.PedComponents["HEAD"], clothing["HEAD"].draw, clothing["HEAD"].text, 0)
    TriggerClientEvent("chatMessage", src, tostring("You do not have permissions to open the admin menu."))
end, false)

RegisterCommand("hatoff", function(source, args, raw)
	local src = source
	local hat = ISRPCharactersConfig.PedComponents["HEAD"]
    TriggerClientEvent("chatMessage", src, tostring("You do not have permissions to open the admin menu."))
end, false)