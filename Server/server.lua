ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('bd_crafting:iniziaCrafting')
AddEventHandler('bd_crafting:iniziaCrafting', function(craftingId, ricettaId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local crafting = Config.Craftings[craftingId]
    local ricetta = crafting.ricette[ricettaId]
    
    if crafting.job and xPlayer.job.name ~= crafting.job then
        return
    end
    
    for _, ingrediente in pairs(ricetta.ingredienti) do
        local item = exports.ox_inventory:GetItem(source, ingrediente.item)
        if not item or item.count < ingrediente.quantita then
            return
        end
    end
    
    for _, ingrediente in pairs(ricetta.ingredienti) do
        exports.ox_inventory:RemoveItem(source, ingrediente.item, ingrediente.quantita)
    end
    
    exports.ox_inventory:AddItem(source, ricetta.risultato.item, ricetta.risultato.quantita)
end)
