QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-fishing:server:RemoveBait', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if exports['qb-inventory']:RemoveItem(Player.PlayerData.source, 'fishingbait', 1, false) then
        TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items['fishingbait'], 'remove', 1)
    end
end)

RegisterNetEvent('qb-fishing:server:ReceiveFish', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local random = math.random(100) -- Random number from 1 to 100
    local item

    if random >= 1 and random <= 40 then -- 30%
        item = 'fish'
    elseif random >= 40 and random <= 52 then -- 12%
        item = 'catfish'
    elseif random >= 52 and random <= 61 then -- 9%
        item = 'goldfish'
    elseif random >= 61 and random <= 70 then -- 9%
        item = 'largemouthbass'
    elseif random >= 70 and random <= 79 then -- 9%
        item = 'redfish'
    elseif random >= 79 and random <= 88 then -- 9%
        item = 'salmon'
    elseif random >= 88 and random <= 91 then -- 3%
        item = 'stingray'
    elseif random >= 91 and random <= 94 then -- 3%
        item = 'stripedbass'
    elseif random >= 94 and random <= 97 then -- 3%
        item = 'whale'
    elseif random >= 97 and random <= 100 then -- 3%
        item = 'whale2'
    end

    if exports['qb-inventory']:AddItem(Player.PlayerData.source, item, 1, false) then
        TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items[item], 'add', 1)
        TriggerEvent('qb-log:server:CreateLog', 'fishing', 'Received Fish', 'blue', "**"..Player.PlayerData.name .. " (citizenid: "..Player.PlayerData.citizenid.." | id: "..Player.PlayerData.source..")** received 1x "..QBCore.Shared.Items[item].label)
    else
        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, 'Your inventory is full already..', 'error', 2500)
    end
end)

QBCore.Functions.CreateUseableItem('fishingrod', function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not Player.Functions.GetItemByName('fishingrod') then return end
    TriggerClientEvent('qb-fishing:client:FishingRod', src)
end)
