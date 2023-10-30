local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('browns_reload:GetAmount', function(source, cb, types) -- Passing the amount of ammo the player has to the client
    local src = source 
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local ammo_type = nil
    local ammo_amounts = nil
    local has_ammo = nil
    if types == 'AMMO_PISTOL' then 
        ammo_type = 'pistol_ammo'
    elseif types == 'AMMO_SMG' then 
        ammo_type = 'smg_ammo'
    elseif types == 'AMMO_SHOTGUN' then 
        ammo_type = 'shotgun_ammo'
    elseif types == 'AMMO_RIFLE' then 
        ammo_type = 'rifle_ammo'
    elseif types == 'AMMO_MG' then 
        ammo_type = 'mg_ammo'
    elseif types == 'AMMO_SNIPER' then 
        ammo_type = 'snp_ammo'
    end
    if ammo_type ~= nil then 
        has_ammo = exports[tostring(config.inventory)]:HasItem(src, tostring(ammo_type), 1)
    end
    if has_ammo then 
        local ammo_items = exports[tostring(config.inventory)]:GetItemByName(src, tostring(ammo_type))
        ammo_amounts = ammo_items.amount 
    end
    cb(ammo_amounts, ammo_type)
end)

RegisterNetEvent('browns_reload:RemoveAmmoItem', function(ammo, counts) -- Removing reloaded ammo items from the player
    local src = source 
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.RemoveItem(ammo, counts)
end)
