# Browns QB Reload Weapons by Brown Development
# NOW WORKS WITH qb, ps, & lj inventory!!!
# Preview Video: https://youtu.be/TLSnJvRJPEI


IF YOU LIKE THIS SCRIPT THEN CHECK OUT MY TEBEX FOR MORE DOPE STUFF: https://brown-development.tebex.io/

Personal Discord: bwobrown
Discord Server: https://discord.gg/dGRHNbX5xc

[EXPORTS] (Reloads Weapon, CLIENT SIDED)

exports['Browns-QBWeaponReload']:ReloadWeapon() 

[INSTALLATION] (IF YOU NEED HELP SETTING UP, OR FEEL LIKE YOU MAY BREAK SOMETHING CONTACT ME AT MY DISCORD ABOVE)

# STEP 1:

backup your qb-weapons (not because something may break but just because its a good habit to backup vital scripts like qb-weapons before modifying)

# STEP 2: 

go to qb-weapons > client > main.lua 

# STEP 3: 

find the 'weapons:client:AddAmmo' event (should be at around line 77) then DELETE THE ENTIRE EVENT

# STEP 4: 

go to qb-weapons > server > main.lua 

# STEP 5: 

delete all of the QBCore.Functions.CreateUsableItem functions (FOR AMMO ONLY) (Should be at about line: 304) 

THE ONES THAT YOU WANT TO DELETE SHOULD LOOK LIKE THIS:

QBCore.Functions.CreateUseableItem('pistol_ammo', function(source, item)
    TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_PISTOL', 12, item)
end)

QBCore.Functions.CreateUseableItem('rifle_ammo', function(source, item)
    TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_RIFLE', 30, item)
end)

QBCore.Functions.CreateUseableItem('smg_ammo', function(source, item)
    TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_SMG', 20, item)
end)

QBCore.Functions.CreateUseableItem('shotgun_ammo', function(source, item)
    TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_SHOTGUN', 10, item)
end)

QBCore.Functions.CreateUseableItem('mg_ammo', function(source, item)
    TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_MG', 30, item)
end)

QBCore.Functions.CreateUseableItem('snp_ammo', function(source, item)
    TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_SNIPER', 10, item)
end)

QBCore.Functions.CreateUseableItem('emp_ammo', function(source, item)
    TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_EMPLAUNCHER', 10, item)
end)
