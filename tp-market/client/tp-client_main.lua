Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX, QBCore                          = nil, nil

local isPlayerDead, isBusy, inZone   = false, false, false

local currentMarket = ""

if Config.Framework == "ESX" then

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(30)
        end
    end)

end

if Config.Framework == "QBCore" then

    Citizen.CreateThread(function()
        while QBCore == nil do
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(30)
        end
    end)

end

AddEventHandler('esx:onPlayerDeath', function(data)
	isPlayerDead = true
    isBusy = false

    toggleUI(false)
	
end)

AddEventHandler('hospital:server:SetDeathStatus', function(data)
	isPlayerDead = true
    isBusy = false

	toggleUI(false)
end)

-- Supporting Disc-Death Script for player revive.
AddEventHandler('disc-death:onPlayerRevive', function(data)
    isPlayerDead = false
    isBusy = false
end)

AddEventHandler('playerSpawned', function()
    isPlayerDead = false
    isBusy = false
end)

RegisterNetEvent('tp-market:openSelectedMarket')
AddEventHandler('tp-market:openSelectedMarket', function()

	addMarketProducts(currentMarket)
		
	Wait(500)
	toggleUI(true)

end)

function openMarket(market)
	addMarketProducts(market)
		
	Wait(500)
	toggleUI(true)
end


RegisterNUICallback('closeUI', function()
	toggleUI(false)
end)

function addMarketProducts(type)
	if Config.Framework == "ESX" then

		ESX.TriggerServerCallback('tp-market:getProducts', function(marketProducts)
			if #marketProducts > 0 then

				SendNUIMessage({
					action = 'addMarketTitle',
					type = type
				})	

				-- Adding selected market all products.
				for k,v in pairs(marketProducts) do
	
					SendNUIMessage({
						action = 'addProduct',
						products_det = v
					})		
	
				end
			else
				sendNotification(Locales['store_is_empty'])
			end
	
		end,type)

	elseif Config.Framework == "QBCore" then

		QBCore.Functions.TriggerCallback('tp-market:server:getProducts', function(marketProducts)
			if #marketProducts > 0 then

				-- Adding selected market title.
				SendNUIMessage({
					action = 'addMarketTitle',
					type = type
				})	

				-- Adding selected market all products.
				for k,v in pairs(marketProducts) do
	
					SendNUIMessage({
						action = 'addProduct',
						products_det = v
					})		
	
				end
			else
				sendNotification(Locales['store_is_empty'])
			end
	
		end,type)

	end
end

RegisterNUICallback('buyProduct', function (data)
	local price = tonumber(data.price)
	
	if data.itemType == "weapon" then

		TriggerServerEvent('tp-market:buyWeapon', data.item, data.label, price, data.currency, data.currencyItemName)

    elseif data.itemType == "item" then

        if tonumber(data.amount) > 0 then

            TriggerServerEvent('tp-market:buyItem', data.item, data.label, tonumber(data.amount), tonumber(data.givenAmount), price, data.currency, data.currencyItemName)
        else
            sendNotification(Locales['invalid_amount'])
        end

	end 

end)

RegisterNUICallback('sendNotification', function(data)

    if Locales[data.message] then
        sendNotification(Locales[data.message])
    end
end)

-- Entering a market zone.
AddEventHandler('tp-market:hasEnteredZone', function(zone)
    inZone = true
end)

-- Leaving a market zone.
AddEventHandler('tp-market:hasExitedZone', function(zone)
    inZone = false
end)

-- Enter / Exit zone events
if Config.EnableMarketZones then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1250)

            local coords      = GetEntityCoords(PlayerPedId())
            local isInZone  = false
            local currentZone = nil
    
            for k,v in pairs(Config.MarketZones) do
                if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.ActionDistance + 1.0) then
                    isInZone       = true
                    currentZone    = k
                    id             = k

                    currentMarket  = v.Market

                    if v.AllowQTarget then
                        isUsingQTarget = true
                    else
                        isUsingQTarget = false
                    end
                end
            end
    
            if isInZone then
                HasAlreadyEnteredMarker = true
                LastZone                = currentZone
                TriggerEvent('tp-market:hasEnteredZone', currentZone)
            end
    
            if not isInZone then
                HasAlreadyEnteredMarker = false
                TriggerEvent('tp-market:hasExitedZone', LastZone)
            end
        end
    end)
end

if Config.EnableMarketZones then
    Citizen.CreateThread(function() -- Create NPC'S

        for _,v in pairs(Config.MarketZones) do
            
            if v.AllowPedSpawning then
                RequestModel(GetHashKey(v.Ped.Name))
                while not HasModelLoaded(GetHashKey(v.Ped.Name)) do
                  Wait(1)
                end
                
                v.ped =  CreatePed(4, v.Ped.Hash, v.Pos.x, v.Pos.y, v.Pos.z , 3374176, false, false)
                SetEntityHeading(v.ped, v.Pos.heading)
                StopPedSpeaking(v.ped,true)
                SetEntityInvincible(v.ped, true)
          
                if v.Ped.Weapon ~= nil then
                  GiveWeaponToPed(v.ped, v.Ped.Weapon, 2800, true, true)
                end
          
                DisablePedPainAudio(v.ped, true)
                FreezeEntityPosition(v.ped, true)
                SetBlockingOfNonTemporaryEvents(v.ped, true)
                
                SetEntityAsMissionEntity(v.ped, true)

                if v.AllowQTarget then

                    if Config.QTargetScript == "qtarget" then
                        exports.qtarget:AddTargetEntity(v.ped, {
                            options = {
                                {
                                    event = "tp-market:openSelectedMarket",
                                    icon = v.Target.TargetIcon,
                                    label = v.Target.TargetTitle,
                                    num = 1
                                },
                            },
                            distance = v.ActionDistance
                        })
                        
                    elseif Config.QTargetScript == "ox_target" then

                        exports.ox_target:addLocalEntity(v.ped, {
                            {
                                name = 'client',
                                event = "tp-market:openSelectedMarket",
                                icon = v.Target.TargetIcon,
                                label = v.Target.TargetTitle,
                                canInteract = function(entity, coords, distance)
                                    return v.ActionDistance
                                end
                            }
                        })

                    elseif Config.QTargetScript == "qb-target" then

                        exports['qb-target']:AddTargetEntity(v.ped, {
                            options = {
                                {
                                    type = "client",
                                    event = "tp-market:openSelectedMarket",
                                    icon = v.Target.TargetIcon,
                                    label = v.Target.TargetTitle,
                                },
                            },
                            distance = v.ActionDistance
                        })

                    end
                    
                end

            end
        end
    end)


    Citizen.CreateThread(function() -- Create Blips

        for _,v in pairs(Config.MarketZones) do
            
            if v.AllowBlip then
                v.blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
                SetBlipSprite(v.blip, v.BlipData.Id)
                SetBlipDisplay(v.blip, v.BlipData.Display)
                SetBlipScale(v.blip, v.BlipData.Scale)
                SetBlipColour(v.blip, v.BlipData.Colour)
                SetBlipAsShortRange(v.blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.BlipData.Title)
                EndTextCommandSetBlipName(v.blip)
            end
        end
    end)
end

function toggleUI(display)
	SetNuiFocus(display,display)

	inMenu = display

    SendNUIMessage({
        action = 'toggle',
		toggle = display
    })

end


RegisterNetEvent('tp-market:sendNotification')
AddEventHandler('tp-market:sendNotification', function(text, type)
    sendNotification(text)
end)

function sendNotification(text, type)
    if Config.NotificationScript == "mythic_notify" then

        if type == nil then
            exports['mythic_notify']:DoHudText('error', text)
        else
            exports['mythic_notify']:DoHudText(type, text)
        end

    elseif Config.NotificationScript == "pnotify" then

        if type == nil then
            exports.pNotify:SendNotification({
                text = text,
                type = "error",
                timeout = 2500,
                layout = "centerLeft",
                queue = "left"
            })
        else
            exports.pNotify:SendNotification({
                text = text,
                type = type,
                timeout = 2500,
                layout = "centerLeft",
                queue = "left"
            })
        end

    elseif Config.NotificationScript == 'okoknotify' then

        if type == nil then
            exports['okokNotify']:Alert('', text, 2500, 'error')
        else
            exports['okokNotify']:Alert('', text, 2500, type)
        end
        
    elseif Config.NotificationScript == "default" then
        
        if Config.Framework == "ESX" then
            ESX.ShowNotification(text)

        elseif Config.Framework == "QBCore" then
            QBCore.Notify(text)
        end

    end

end