local QBCore = exports['qb-core']:GetCoreObject() -- Import QBCore

local weaponData = nil -- Initially Define Weapon Data as "nothing" until weapon data is passed from the below Event Handler

local no_return = { -- List of weapons that dont take ammo (Cant Be Reloaded)
    {weapon = 'weapon_stickybomb'},
    {weapon = 'weapon_pipebomb'},
    {weapon = 'weapon_smokegrenade'},
    {weapon = 'weapon_flare'},
    {weapon = 'weapon_proxmine'},
    {weapon = 'weapon_ball'},
    {weapon = 'weapon_molotov'},
    {weapon = 'weapon_grenade'},
    {weapon = 'weapon_bzgas'},
    {weapon = 'weapon_snowball'},
    {weapon = 'weapon_unarmed'}
}

RegisterNetEvent('inventory:client:UseWeapon') -- Add Event Handler to event that is triggered when player uses a weapon
AddEventHandler('inventory:client:UseWeapon', function(data)
    local weaponName = tostring(data.name)
    for _, cant_reload in ipairs(no_return) do 
        if weaponName == tostring(cant_reload.weapon) then 
            weaponData = nil 
            break 
        else
            weaponData = data -- Redefine weaponData with the data of the weapon if the weapon takes ammo
        end
    end
end)

RegisterCommand('browns_reload', function(source) -- Creating the reloading functionality 
    local ped = PlayerPedId()
    if weaponData ~= nil and GetSelectedPedWeapon(ped) ~= `WEAPON_UNARMED` then 
        local weapons = GetSelectedPedWeapon(ped)
        local total = GetAmmoInPedWeapon(ped, weapons)
        local maxAmmo = GetMaxAmmoInClip(ped, weapons, 1)
        local sum = tonumber(maxAmmo) - tonumber(total)
        if total < maxAmmo then
            QBCore.Functions.TriggerCallback('browns_reload:GetAmount', function(count, item) -- Getting the Amount of ammo the player has from the server
                if count ~= nil and item ~= nil then 
                    sum = tonumber(sum)
                    item = tostring(item)
                    if count ~= nil and count ~= false then 
                        count = tonumber(count)
                        if count > 0 then 
                            if count > sum then 
                                local new_total = GetAmmoInPedWeapon(ped, weapons)
                                SetAmmoInClip(ped, weapons, 0)
                                AddAmmoToPed(ped, weapons, sum + new_total)
                                TriggerServerEvent("weapons:server:UpdateWeaponAmmo", weaponData, sum + new_total)
                                TriggerServerEvent('browns_reload:RemoveAmmoItem', item, sum)
                                TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[item], "remove")
                            else
                                local new_total = GetAmmoInPedWeapon(ped, weapons)
                                SetAmmoInClip(ped, weapons, 0)
                                AddAmmoToPed(ped, weapons, count + new_total)
                                TriggerServerEvent("weapons:server:UpdateWeaponAmmo", weaponData, count + new_total)
                                TriggerServerEvent('browns_reload:RemoveAmmoItem', item, count)
                                TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[item], "remove")
                            end
                        end
                    end
                end
            end, QBCore.Shared.Weapons[weapons]["ammotype"])
        end
    end
end)

function ReloadWeapon() -- the reload function to create an export
    ExecuteCommand('browns_reload')
end

exports('ReloadWeapon', ReloadWeapon) -- export to use reload function in other scripts

RegisterKeyMapping('browns_reload', 'reload your weapon', 'keyboard', 'R')  -- Registering the 'R' key as the button to do reload functionality
