ESX, QBCore = nil, nil

if Config.Framework == "ESX" then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
end

function getMoney(s, currency, itemName)
    local _source = s
    local xMoney  = 0

    if Config.Framework == "ESX" then
        local xPlayer   = ESX.GetPlayerFromId(_source)

        if currency == "money" then
            xMoney = xPlayer.getMoney()

        elseif currency == "bank" then
            xMoney = xPlayer.getAccount('bank').money

        elseif currency == "black_money" then
            xMoney = xPlayer.getAccount('black_money').money

        elseif currency == 'item' then

            local targetItem = xPlayer.getInventoryItem(itemName)

            if targetItem == nil or targetItem.count == nil then
                xMoney = 0
            else
                xMoney = targetItem.count
            end

        end

    elseif Config.Framework == "QBCore" then
        local xPlayer  = QBCore.Functions.GetPlayer(_source)

        if currency == "money" then
            xMoney = xPlayer.Functions.GetMoney('cash')

        elseif currency == "bank" then
            xMoney = xPlayer.Functions.GetMoney('bank')

        elseif currency == "black_money" then
            xMoney = xPlayer.Functions.GetMoney('black_money')

        elseif currency == "item" then

            local targetItem = xPlayer.Functions.GetItemByName(itemName)

            if targetItem == nil or targetItem.amount == nil then
                xMoney = 0
            else
                xMoney = targetItem.amount
            end

        end
    end

    return xMoney
end

function removeMoney(s, currency, price, itemName)
    local _source = s

    if Config.Framework == "ESX" then
        local xPlayer   = ESX.GetPlayerFromId(_source)

        if currency == "money" then                    
            xPlayer.removeMoney(price)
    
        elseif currency == "bank" then
            xPlayer.removeAccountMoney('bank', price)
    
        elseif currency == "black_money" then
            xPlayer.removeAccountMoney('black_money', price)

        elseif currency == "item" then
            xPlayer.removeInventoryItem(itemName, price)
        end

    elseif Config.Framework == "QBCore" then
        local xPlayer  = QBCore.Functions.GetPlayer(_source)

        if currency == "money" then
            Player.Functions.RemoveMoney('cash', price) 
    
        elseif currency == "bank" then
            xPlayer.Functions.RemoveMoney('bank', price)

        elseif currency == "black_money" then
            xPlayer.Functions.RemoveMoney('black_money', price)

        elseif currency == "item" then
            xPlayer.Functions.RemoveItem(itemName, price)
        end

    end

end