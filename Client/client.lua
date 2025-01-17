ESX = exports['es_extended']:getSharedObject()

function controllaIngredienti(ingredienti)
    for _, ingrediente in pairs(ingredienti) do
        local count = exports.ox_inventory:Search('count', ingrediente.item)
        if count < ingrediente.quantita then
            return false
        end
    end
    return true
end


function ApriMenuCrafting(craftingId)
    local crafting = Config.Craftings[craftingId]
    
    if crafting.job then
        local job = ESX.GetPlayerData().job.name
        if job ~= crafting.job then
            ESX.ShowNotification('Non hai il lavoro richiesto')
            return
        end
    end
    
    SetNuiFocus(true, true)
    SendNUIMessage({
        tipo = 'apriMenu',
        crafting = crafting,
        craftingId = craftingId
    })
end

Citizen.CreateThread(function()
    Wait(500)
    for craftingId, crafting in pairs(Config.Craftings) do
        TriggerEvent('gridsystem:registerMarker', {
            name = 'crafting_' .. craftingId,
            pos = crafting.posizione,
            scale = vector3(0.8, 0.8, 0.8),
            msg = 'CRAFTING',
            control = 'E',
            type = Config.TipoMarker,
            texture = crafting.texture,
            color = Config.ColoreMarker,
            action = function()
                ApriMenuCrafting(craftingId)
            end
        })
    end
    
end)
RegisterNUICallback('iniziaCrafting', function(data, cb)
    local crafting = Config.Craftings[data.craftingId]
    local ricetta = crafting.ricette[data.ricettaId]
    
    if not controllaIngredienti(ricetta.ingredienti) then
        ESX.ShowNotification('Non hai abbastanza materiali per craftare questo item')
        cb('ok')
        return
    end
    
    SetNuiFocus(false, false)
    SendNUIMessage({
        tipo = 'chiudiMenu'
    })
    
    exports.rprogress:Custom({
        Async = true,
        canCancel = true,
        cancelKey = 178,
        x = 0.5,
        y = 0.5,
        From = 0,
        To = 100,
        Duration = ricetta.tempo,
        Radius = 60,
        Stroke = 10,
        Cap = 'round',
        Padding = 0,
        MaxAngle = 360,
        Rotation = 0,
        Width = 300,
        Height = 40,
        ShowTimer = true,
        ShowProgress = true,
        Easing = "easeLinear",
        Label = "Crafting in corso...",
        LabelPosition = "right",
        Color = "rgba(0, 153, 255, 1.0)",
        BGColor = "rgba(0, 0, 0, 0.4)",
        ZoneColor = 1,
        Animation = {
            animationDictionary = "mini@repair",
            animationName = "fixing_a_ped",
        },
        DisableControls = {
            Mouse = true,
            Player = true,
            Vehicle = true
        },
        onComplete = function(cancelled)
            if not cancelled then
                TriggerServerEvent('bd_crafting:iniziaCrafting', data.craftingId, data.ricettaId)
            end
            ClearPedTasks(PlayerPedId())
        end
    })
    
    cb('ok')
end)

RegisterNUICallback('chiudiMenu', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)