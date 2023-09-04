local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CreateThread(function()
            local plants = MySQL.Sync.fetchAll('SELECT * FROM kevin_coke_plants WHERE plantdead = 1', {})
            for _, plant in ipairs(plants) do
                local plantId = plant.id
                local deletePlants = MySQL.Sync.execute('DELETE FROM kevin_coke_plants WHERE id = ?', {plantId})
                if deletePlants then
                    print('PlantId '..plantId..' has been deleted from database')
                end
            end
        end)
    end
end)

QBCore.Functions.CreateUseableItem(Config.Items.seeditem.item, function(source, item)
    local PlayerId = source
    TriggerClientEvent('kevin-cokeprocessing:usecocaseed', PlayerId, itemName)
end)

QBCore.Functions.CreateUseableItem(Planting.WaterCanItem, function(source, item)
    local PlayerId = source
    TriggerClientEvent('kevin-cokeprocessing:usewatercan', PlayerId, item)
end)

RegisterNetEvent('kevin-cokeprocessing:refillcan', function (item)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    local setUses = Planting.WaterCanUses
    if not item then return end
    if item.info.uses < setUses then
        Player.PlayerData.items[item.slot].info.uses = setUses
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

-- Threads 
CreateThread(function()
    while true do
        local plants = MySQL.Sync.fetchAll('SELECT * FROM kevin_coke_plants', {})
        for k, v in pairs(plants) do
            local plantDead = plants[k].plantDead
            local plantFood = plants[k].food
            local plantWater = plants[k].water
            local plantHealth = plants[k].health
            local plantId = plants[k].id
            
            if not plantDead and plantFood >= 50 then
                MySQL.Sync.execute('UPDATE kevin_coke_plants SET food = ?, water = ? WHERE id = ?', {plantFood - 1, plantWater - 1, plantId})
                if plantHealth + 1 < 100 then
                    MySQL.Sync.execute('UPDATE kevin_coke_plants SET health = ? WHERE id = ?', {plantHealth + 1, plantId})
                end
            end

            if plantFood < 50 then
                if plantFood - 1 >= 0 then
                    MySQL.Sync.execute('UPDATE kevin_coke_plants SET food = ?, water = ? WHERE id = ?', {plantFood - 1, plantWater - 1, plantId})
                end
                if plantHealth - 1 >= 0 then
                    MySQL.Sync.execute('UPDATE kevin_coke_plants SET health = ? WHERE id = ?', {plantHealth - 1, plantId})
                end
            end
        end
        TriggerClientEvent('kevin-cokeprocessing:refreshplants', -1)
        Wait(Planting.FoodWaterRefreshTime * 60000)
    end
end)

CreateThread(function()
    while true do
        local plants = MySQL.Sync.fetchAll('SELECT * FROM kevin_coke_plants', {})
        for k, v in pairs(plants) do
            local plantFood = plants[k].food
            local plantWater = plants[k].water
            local plantHealth = plants[k].health
            local plantStage = plants[k].stage
            local plantId = plants[k].id
            local plantProgress = plants[k].progress

            local stageB = Planting.Plants.stage.stage_b
            local stageC = Planting.Plants.stage.stage_c
            local stageD = Planting.Plants.stage.stage_d
            local stageE = Planting.Plants.stage.stage_e
            local stageF = Planting.Plants.stage.stage_f

            if plantHealth > 50 then
                local growthIncrease = 2
                if plantProgress + growthIncrease < 100 or plantStage == 'stage_f' then
                    local newProgress = plantProgress + growthIncrease
                    if plantStage == 'stage_f' and newProgress > 100 then newProgress = 100 end
                    MySQL.Sync.execute('UPDATE kevin_coke_plants SET progress = ? WHERE id = ?', {newProgress, plantId})
                elseif plantStage ~= Planting.Plants.stage.stage_f then
                    if plantStage == 'stage_a' then
                        MySQL.Sync.execute('UPDATE kevin_coke_plants SET stage = ?, plantmodel = ? WHERE id = ?', {'stage_b', stageB, plantId})
                    elseif plantStage == 'stage_b' then
                        MySQL.Sync.execute('UPDATE kevin_coke_plants SET stage = ?, plantmodel = ? WHERE id = ?', {'stage_c', stageC, plantId})
                    elseif plantStage == 'stage_c' then
                        MySQL.Sync.execute('UPDATE kevin_coke_plants SET stage = ?, plantmodel = ? WHERE id = ?', {'stage_d', stageD, plantId})
                    elseif plantStage == 'stage_d' then
                        MySQL.Sync.execute('UPDATE kevin_coke_plants SET stage = ?, plantmodel = ? WHERE id = ?', {'stage_e', stageE, plantId})
                    elseif plantStage == 'stage_e' then
                        MySQL.Sync.execute('UPDATE kevin_coke_plants SET stage = ?, plantmodel = ? WHERE id = ?', {'stage_f', stageF, plantId})
                    end
                    MySQL.Sync.execute('UPDATE kevin_coke_plants SET progress = ? WHERE id = ?', {0, plantId})
                end

                if plantStage == 'stage_f' and plantProgress == 100 then
                    MySQL.Sync.execute('UPDATE kevin_coke_plants SET harvestable = ? WHERE id = ?', {true, plantId})
                end
            else
                if plantHealth == 0 and plantFood == 0 and plantWater == 0 then
                    MySQL.Sync.execute('UPDATE kevin_coke_plants SET plantdead = ? WHERE id = ?', {true, plantId})
                end
            end
        end

        TriggerClientEvent('kevin-cokeprocessing:refreshplants', -1)
        Wait(Planting.GrowthRefreshTime * 60000)
    end
end)
-- 
-- 

-- Did 2 events just incase i feel the need to add something extra for either of the feeding events
RegisterNetEvent('kevin-cokeprocessing:waterplant', function (plant)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if not plant then return end
    local item = Player.Functions.GetItemByName(Planting.WaterCanItem)
    local itemUses = Player.PlayerData.items[item.slot].info.uses
    if itemUses and itemUses > 0 then
        itemUses -= 1
        Player.Functions.SetInventory(Player.PlayerData.items)
        local plantId = plant.id
        local plantWater = plant.water
        local waterAmount = plantWater + 10
        if plantWater + 10 > 100 then
            MySQL.Sync.execute('UPDATE kevin_coke_plants SET water = ? WHERE id = ?', {100, plantId})
        else
            MySQL.Sync.execute('UPDATE kevin_coke_plants SET water = ? WHERE id = ?', {waterAmount, plantId})
        end
        TriggerClientEvent('kevin-cokeprocessing:refreshplants', -1)
        TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('success.watered'), 'success', 4000)
    else
        TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('warning.can_empty'), 'error', 4000)
    end
end)

RegisterNetEvent('kevin-cokeprocessing:fertilizeplant', function (plant)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if not plant then return end
    if Player.Functions.RemoveItem(Planting.FertilizerItem, 1, false) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[Planting.FertilizerItem], "remove")
        
        local plantId = plant.id
        local plantFood = plant.food
        local foodAmount = plantFood + 10
        if foodAmount + 10 > 100 then
            MySQL.Sync.execute('UPDATE kevin_coke_plants SET food = ? WHERE id = ?', {100, plantId})
        else
            MySQL.Sync.execute('UPDATE kevin_coke_plants SET food = ? WHERE id = ?', {foodAmount, plantId})
        end
        TriggerClientEvent('kevin-cokeprocessing:refreshplants', -1)
        TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('success.fertilized'), 'success', 4000)
    end
end)

RegisterServerEvent('kevin-cokeprocessing:placePlant', function(coords, zone)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if Player.Functions.RemoveItem('coca_seed', 1) then
        local plantmodel = Planting.Plants.stage.stage_a
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items['coca_seed'], 'remove')
        MySQL.Sync.insert('INSERT INTO kevin_coke_plants (plantmodel, coords, harvestable, plantdead) VALUES (?, ?, ?, ?) ', {plantmodel, coords, false, false})
        TriggerClientEvent('kevin-cokeprocessing:refreshplants', -1)
    end
end)

QBCore.Functions.CreateCallback('kevin-cokeprocessing:getplants', function(source, cb)
    local plants = MySQL.Sync.fetchAll('SELECT * FROM kevin_coke_plants', {})
    cb(plants)
end)

RegisterNetEvent('kevin-cokeprocessing:deleteplant', function(copsBurn, plant)
    local player = GetPlayerPed(source)
    local coords = QBCore.Functions.GetCoords(player)
    local plantCoords = plant.coords
    if #(plantCoords - vector3(coords)) < 10.0 then
        local id = tostring(plant.id)

        local plant = MySQL.Sync.fetchAll('DELETE FROM kevin_coke_plants WHERE id = ?', { id })
        if plant then
            TriggerClientEvent('kevin-cokeprocessing:deleteplant', -1, copsBurn, plantCoords, id)
        end
    end
end)

RegisterNetEvent('kevin-cokeprocessing:harvestplayerplants', function (plant)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if not plant then return end
    local id = tostring(plant.id)
    local item = 'coca_plant'
    amount = math.random(Planting.HarvestAmount.min, Planting.HarvestAmount.max)
    if Player.Functions.AddItem(item, amount, false) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item], 'add', amount)
    end
    local plant = MySQL.Sync.fetchAll('DELETE FROM kevin_coke_plants WHERE id = ?', { id })
    if plant then
        TriggerClientEvent('kevin-cokeprocessing:deleteplant', -1, false, plant.coords, id)
    end
end)

RegisterNetEvent('kevin-cokeprocessing:blocktarget', function (plant)
    local PlayerId = source
    local id = tostring(plant.id)
    TriggerClientEvent('kevin-cokeprocessing:changebool', -1, id)
end)