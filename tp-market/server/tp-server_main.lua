ESX, QBCore = nil, nil

if Config.Framework == "ESX" then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
end


RegisterServerEvent("tp-market:buyItem")
AddEventHandler("tp-market:buyItem", function (itemName, label, amount, givenAmount, price, currency, currencyItemName)
    local _source = source
    local xMoney = getMoney(_source, currency, currencyItemName)

    if Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer then

            --local xItem = xPlayer.getInventoryItem(itemName)
    
            if xMoney >= price then
                --local canCarry

                --if Config.ESXVersion == "1.1" then
                --    canCarry = xItem.limit ~= -1 and xItem.limit - xItem.count >= amount or xItem.limit ~= -1

                --elseif Config.ESXVersion == "1.2" or Config.ESXVersion == "legacy" then
                --    print(itemName, amount)
                --    canCarry = xPlayer.canCarryItem(itemName, amount)
                --    print(canCarry)
                --end

                --if canCarry then

                    removeMoney(_source, currency, price, currencyItemName)
                    xPlayer.addInventoryItem(itemName, amount * givenAmount)
        
                    TriggerClientEvent('tp-market:sendNotification', _source, Locales['successfully_bought'] .. amount * givenAmount .. " " .. label, "success")
                --else
                --    TriggerClientEvent('tp-market:sendNotification', _source, Locales['not_enough_space'])
               -- end
            else
                TriggerClientEvent('tp-market:sendNotification', _source, Locales['not_enough_money'])
            end

        end

    elseif Config.Framework == "QBCore" then
        local xPlayer  = QBCore.Functions.GetPlayer(_source)

        if xPlayer then

            if xMoney >= price then

                removeMoney(_source, currency, price, currencyItemName)
                xPlayer.Functions.AddItem(itemName)

                TriggerClientEvent('tp-market:sendNotification', _source, Locales['successfully_bought'] .. amount .. " " .. label, "success")
            else
                TriggerClientEvent('tp-market:sendNotification', _source, Locales['not_enough_money'])
            end

        end
    end

end)

RegisterServerEvent("tp-market:buyWeapon")
AddEventHandler("tp-market:buyWeapon", function (weaponName, label, price, currency, currencyItemName)
    local _source = source

    local xMoney = getMoney(_source, currency, currencyItemName)

    if Config.Framework == "ESX" then

        local xPlayer   = ESX.GetPlayerFromId(_source)

        if xPlayer then

            local hasWeapon = xPlayer.getWeapon(weaponName)
        
            if xMoney >= price then
                if not hasWeapon then
    
                    removeMoney(_source, currency, price, currencyItemName)
                    xPlayer.addWeapon(weaponName, 1)
        
                    TriggerClientEvent('tp-market:sendNotification', _source, Locales['successfully_bought'] .. "1 " .. label, "success")
                else
                    TriggerClientEvent('tp-market:sendNotification', _source, Locales['already_carrying'])
                end
            else
                TriggerClientEvent('tp-market:sendNotification', _source, Locales['not_enough_money'])
            end
        end

    elseif Config.Framework == "QBCore" then
        local xPlayer  = QBCore.Functions.GetPlayer(_source)

        if xPlayer then

            if xMoney >= price then

                local PlayerInventory = xPlayer.PlayerData.items
                local hasWeapon = false

                for k, v in pairs(PlayerInventory) do
                    if v.name == weaponName then
                        hasWeapon = true
                    end
                end

                Wait(250)

                if not hasWeapon then
    
                    removeMoney(_source, currency, price, currencyItemName)
                    xPlayer.Functions.AddItem(weaponName)
        
                    TriggerClientEvent('tp-market:sendNotification', _source, Locales['successfully_bought'] .. "1 " .. label, "success")
                else
                    TriggerClientEvent('tp-market:sendNotification', _source, Locales['already_carrying'])
                end

            else
                TriggerClientEvent('tp-market:sendNotification', _source, Locales['not_enough_money'])
            end

        end

    end
end)


if Config.Framework == "ESX" then
    ESX.RegisterServerCallback('tp-market:getProducts', function(source,cb,supermarket_type)
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)

        local products_table = {}

        if xPlayer then
    
            for k,v in pairs(Config.Markets[supermarket_type]) do
                if v.type == 'item' then
                    table.insert(products_table,{
                        item = v.item,
                        label = v.label,
                        price = v.price,
                        description = v.description,
                        amount = v.givenAmount,
                        type = 'item',

                        paymentType = v.paymentType,
                        paymentItem = v.paymentItem,

                    })
                elseif v.type == 'weapon' then
                    table.insert(products_table,{
                        item = v.item,
                        label = v.label,
                        price = v.price,
                        description = v.description,
                        amount = 1,
                        type = 'weapon',

                        paymentType = v.paymentType,
                        paymentItem = v.paymentItem,
                    })
                end
            end

        end

        cb(products_table)
    end)
end


if Config.Framework == "QBCore" then

    QBCore.Functions.CreateCallback('tp-market:server:getProducts', function(source,cb,supermarket_type)
        local _source = source
        local xPlayer = QBCore.Functions.GetPlayer(_source)

        local products_table = {}

        if xPlayer then

            for k,v in pairs(Config.Markets[supermarket_type]) do
                if v.type == 'item' then
                    table.insert(products_table,{
                        item = v.item,
                        label = v.label,
                        price = v.price,
                        description = v.description,
                        amount = v.givenAmount,
                        type = 'item',

                        paymentType = v.paymentType,
                        paymentItem = v.paymentItem,
                    })
                elseif v.type == 'weapon' then
                    table.insert(products_table,{
                        item = v.item,
                        label = v.label,
                        price = v.price,
                        description = v.description,
                        amount = 1,
                        type = 'weapon',

                        paymentType = v.paymentType,
                        paymentItem = v.paymentItem,
                    })
                end
            end

        end
        
        cb(products_table)
    end)

end