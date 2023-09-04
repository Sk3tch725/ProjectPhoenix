local QBCore = exports['qb-core']:GetCoreObject()

local coolDown = false
local availRuns = 0

function CoolDown()
	CreateThread(function ()
		Wait(Config.CoolDown * 60000)
		coolDown = false
	end)
end

RegisterNetEvent('kevin-cokeprocessing:checkstatus', function ()
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if availRuns < Config.AvailableRuns then
        if not coolDown then
            availRuns = availRuns + 1
            coolDown = true
            CoolDown()
            local crates = math.random(Config.SpawnedCrates.min, Config.SpawnedCrates.max)
            TriggerClientEvent('kevin-cokeprocessing:startcokejob', PlayerId, crates)
        else
            TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('warning.not_available'), 'error', 4000)
        end
    else
        TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('warning.not_available'), 'error', 4000)
    end
end)

RegisterNetEvent('kevin-cokeprocessing:givecraterewards', function (id)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if not id then return end
    local chance = math.random(1, 100)
    local seedItem = Config.Items.seeditem.item
    local crateAmount = math.random(Config.Items.seeditem.crateamount.min, Config.Items.seeditem.crateamount.max)
    if Player.Functions.AddItem(seedItem, crateAmount, false) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[seedItem], 'add', crateAmount)
        TriggerClientEvent('kevin-cokeprocessing:deletepallet', PlayerId)
    end

    if chance < Config.Items.extra.chance then
        local selectedExtraItem = Config.Items.extra.item[math.random(#Config.Items.extra.item)]
        local extraAmount = math.random(Config.Items.extra.itemamount.min, Config.Items.extra.itemamount.max)
        if Player.Functions.AddItem(selectedExtraItem, extraAmount, false) then
            TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[selectedExtraItem], 'add', extraAmount)
        end
    end
end)

RegisterNetEvent('kevin-cokeprocessing:sellproducts', function (data)
    local PlayerId = source
	local Player = QBCore.Functions.GetPlayer(PlayerId)
	if data == nil then return end
    local PlayerCoords = GetEntityCoords(GetPlayerPed(PlayerId))
	local dist = #(PlayerCoords - vector3(Config.SellerPed.location.x, Config.SellerPed.location.y, Config.SellerPed.location.z))
	if dist < 10.0 then
		if Player.Functions.RemoveItem(data.item, 1, false) then
			TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items[data.item], 'remove')
			Player.Functions.AddMoney(Config.SellerPed.paymenttype, data.price, 'Organ Payment')

			TriggerEvent('qb-log:server:CreateLog', 'cokeprocessing', 'Coke Buyer', 'white',
            '**'..'Player: '..GetPlayerName(Player.PlayerData.source)..'**\n'..
            '**'..'Citizen Id: '..Player.PlayerData.citizenid..'**\n'..
            '**'..'Player Id: '..Player.PlayerData.source..'**\n'..
            'Item Sold: '..data.item..'\n'..
            'Sold for: $'..data.price..'\n')
		end
	end
end)

RegisterNetEvent('kevin-cokeprocessing:removeplants', function ()
    local PlayerId = source
	local Player = QBCore.Functions.GetPlayer(PlayerId)

    local plantItem = Planting.PlantItem
    local plantsNeeded = Processing.PlantsBreakDown.plantsneeded
    if Player.Functions.RemoveItem(plantItem, plantsNeeded, false) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[plantItem], 'remove', plantsNeeded)
        TriggerClientEvent('kevin-cokeprocessing:addgas', PlayerId, true)
    else
        TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('warning.insufficent_plants'), 'error', 4000)
    end
end)

RegisterNetEvent('kevin-processing:setgascontainerfull', function (gotVehicle)
    local PlayerId = source
	local Player = QBCore.Functions.GetPlayer(PlayerId)
    if not gotVehicle then return end
    local item = Player.Functions.GetItemByName(Processing.GasContainerItem)
    if not item.info.gasfilled then
        Player.PlayerData.items[item.slot].info.gasfilled = true
        Player.Functions.SetInventory(Player.PlayerData.items)
    else
        TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('warning.container_full'), 'error', 4000)
    end
end)

RegisterNetEvent('kevin-cokeprocessing:removegas', function ()
    local PlayerId = source
	local Player = QBCore.Functions.GetPlayer(PlayerId)

    local item = Player.Functions.GetItemByName(Processing.GasContainerItem)
    if item then
        if item.info.gasfilled then
            if Player.Functions.RemoveItem(item.name, 1, false) then
                TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item.name], 'remove', 1)
                TriggerClientEvent('kevin-cokeprocessing:showmenu', PlayerId)
            else
                TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('warning.no_container'), 'error', 4000)
            end
        else
            TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('warning.container_empty'), 'error', 4000)
        end
    else
        TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('warning.no_container'), 'error', 4000)
    end
end)

RegisterNetEvent('kevin-cokeprocessing:givebrick', function (data)
    local PlayerId = source
	local Player = QBCore.Functions.GetPlayer(PlayerId)

    local item = data.item
    local amount = data.brickgiven
    if Player.Functions.AddItem(item, amount, false) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item], 'add', amount)
    end
end)

RegisterNetEvent('kevin-cokeprocessing:givebaggys', function (data)
    local PlayerId = source
	local Player = QBCore.Functions.GetPlayer(PlayerId)

    local item = data.item
    local amount = data.amount
    if not Player.Functions.RemoveItem(data.removeitem, 1, false) then return end
    TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[data.removeitem], 'remove', 1)
    if Player.Functions.AddItem(item, amount, false) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item], 'add', amount)
    end
end)

