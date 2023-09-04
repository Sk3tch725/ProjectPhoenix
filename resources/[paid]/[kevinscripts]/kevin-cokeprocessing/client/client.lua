local QBCore = exports['qb-core']:GetCoreObject()

local data = {}
local notOnJob = false
local crate = nil
local destBlip = nil
local crateAmount = 0
local collectedCrates = 0

CreateThread(function()
    local pedHash = Config.CokePed.hash
    local pedCoords = Config.CokePed.location
    QBCore.Functions.LoadModel(pedHash)
    local cokePed = CreatePed(0, pedHash, pedCoords.x, pedCoords.y, pedCoords.z-1.0, pedCoords.w, false, false)
	TaskStartScenarioInPlace(cokePed, Config.CokePed.scenario, -1, true)
	FreezeEntityPosition(cokePed, true)
	SetEntityInvincible(cokePed, true)
	SetBlockingOfNonTemporaryEvents(cokePed, true)

    exports['qb-target']:AddTargetEntity(cokePed, {
        options = {
            {
                icon = 'fas fa-circle',
                label = 'Take Task',
                canInteract = function()
                    return not notOnJob
                end,
                action = function()
                    TriggerServerEvent('kevin-cokeprocessing:checkstatus')
                end,
            },
        },
        distance = 2.0
    })

    if not Config.SellerPed.use then return end
    local sellerHash = Config.SellerPed.hash
    local sellerCoords = Config.SellerPed.location
    QBCore.Functions.LoadModel(sellerHash)
    local sellerPed = CreatePed(0, sellerHash, sellerCoords.x, sellerCoords.y, sellerCoords.z-1.0, sellerCoords.w, false, false)
	TaskStartScenarioInPlace(sellerPed, Config.SellerPed.scenario, -1, true)
	FreezeEntityPosition(sellerPed, true)
	SetEntityInvincible(sellerPed, true)
	SetBlockingOfNonTemporaryEvents(sellerPed, true)

    exports['qb-target']:AddTargetEntity(sellerPed, {
        options = {
            {
                icon = 'fas fa-circle',
                label = 'Sell Product',
                action = function()
                    SellerMenu()
                end,
            },
        },
        distance = 2.0
    })
end)

function SellerMenu()
    local sellMenu = {
        id = 'item-menu',
        title = 'Sellable Products',
        options = {}
    }
    local options = {}
    for itemName, v in pairs(Config.SellerPed.buyerableitems) do
        local item = QBCore.Functions.HasItem(itemName)
        if item then
            options[#options+1] = {
                title = QBCore.Shared.Items[itemName]['label'],
                description = 'Cost: $'..v.price..' per',
                serverEvent = 'kevin-cokeprocessing:sellproducts',
                args = {
                    item = QBCore.Shared.Items[itemName]['name'],
                    price = v.price
                }
            }
        end
    end
    sellMenu['options'] = options
    lib.registerContext(sellMenu)
    lib.showContext('item-menu')
end

-- TEST COMMAD HERE --
--
--
RegisterCommand('spawnb', function ()
    TriggerServerEvent('kevin-cokeprocessing:checkstatus')
end, false)

RegisterNetEvent('kevin-cokeprocessing:startcokejob', function (crateAmt)
    data = Config.LocationData[math.random(#Config.LocationData)]
    crateAmount = crateAmt
    local phone = QBCore.Functions.HasItem(Config.PhoneItemName)
    local title = 'TASK NOTIFICATION'
    local content = 'Go to the location marked on your map'
    if phone then
        if Config.Phone == 'qb' then
            TriggerEvent('qb-phone:client:CustomNotification', title, content, 'fas fa-bars', '#c07ef2', 8500)
        elseif Config.Phone == 'gks' then
            TriggerEvent('gksphone:notifi', {title = title, message = content, img= '/html/static/img/icons/messages.png'})
        elseif Config.Phone == 'qs' then
            TriggerEvent('qs-smartphone:client:notify', {title = title, text = content, icon = './img/apps/whatsapp.png', timeout = 5500})
        end
    else
        QBCore.Functions.Notify(content, 'primary', 4000)
    end

    destBlip = AddBlipForRadius(data.cratepos.x, data.cratepos.y, data.cratepos.z, 80.0)
    SetBlipAlpha(destBlip, 65)
    SetBlipColour(destBlip, 43)
    SetBlipFlashes(destBlip, true)

    CheckDistance()
end)

local maxDistance = 150.0
function CheckDistance()
    CreateThread(function ()
        while not DoesEntityExist(crate) do
            local player = PlayerPedId()
            local pos = GetEntityCoords(player)
            local dist = #(pos - vector3(data.cratepos.x, data.cratepos.y, data.cratepos.z))
            if dist <= maxDistance then
                RemoveBlip(destBlip)
                CreateCrate()
            elseif dist > maxDistance and DoesEntityExist(crate) then
                DeleteEntity(crate)
                if DoesEntityExist(shark) then
                    ClearPedTasks(shark)
                    SetPedAsNoLongerNeeded(shark)
                end
                notOnJob = false
                destBlip = nil
                crateAmount = 0
                collectedCrates = 0
            end
            Wait(1000)
        end
    end)
end

function SpawnShark()
    local sharkHashes = { `a_c_sharkhammer`, `a_c_sharktiger`, }
    local sharkModel = sharkHashes[math.random(#sharkHashes)]
    QBCore.Functions.LoadModel(sharkModel)
    
    local coords = GetEntityCoords(crate)
    local heading = GetEntityHeading(crate)
    shark = CreatePed(0, sharkModel, coords.x, coords.y + math.random(10, 25), coords.z, heading, true, true)
    if DoesEntityExist(shark) then
        SetEntityHealth(shark, Config.SharkData.health)
        SetPedRelationshipGroupHash(shark, `HATES_PLAYER`)
        SetPedAsEnemy(shark, true)
        SetEntityAsMissionEntity(shark, true, true)
        ClearPedTasks(shark)
    end
end

function CreateCrate()
    local randomX = math.random(60, 100)
    local randomY = math.random(60, 100)
    ClearAreaOfEverything(data.cratepos.x + randomX, data.cratepos.y + randomY, data.cratepos.z, 40.0, false, false, false, false)
    Wait(250)
    QBCore.Functions.LoadModel(data.cratehash)
    crate = CreateObject(data.cratehash, data.cratepos.x + randomX, data.cratepos.y + randomY, data.cratepos.z, true, true, false)
    if DoesEntityExist(crate) then
        ActivatePhysics(crate)
        local crateBlip = AddBlipForEntity(crate)
        SetBlipSprite(crateBlip, 478)
        SetBlipColour(crateBlip, 43)
        SetBlipScale(crateBlip, 0.65)
        SetBlipFlashes(crateBlip, true)

        if Config.SharkData.use then
            local chance = math.random(1, 100)
            if chance <= Config.SharkData.chance then
                if not DoesEntityExist(shark) then
                    SpawnShark()
                end
            end
        end
    end

    exports['qb-target']:AddTargetEntity(crate, {
        options = {
            {
                icon = 'fas fa-circle',
                label = 'Grab Goods',
                canInteract = function()
                    return CheckOnBoatOrVehicleOrWater()
                end,
                action = function(entity)
                    local id = NetworkGetNetworkIdFromEntity(entity)
                    TriggerServerEvent('kevin-cokeprocessing:givecraterewards', id)
                end,
            },
        },
        distance = 2.0
    })
end

function CheckOnBoatOrVehicleOrWater()
    local player = PlayerPedId()
    if IsPedOnVehicle(player) or IsPedInAnyBoat(player) then
        return false
    end
    local isPlayerInWater = IsEntityInWater(player)
    if isPlayerInWater then
        return true
    end
    return false
end

RegisterNetEvent('kevin-cokeprocessing:deletepallet', function ()
    SetModelAsNoLongerNeeded(crate)
    DeleteEntity(crate)
    collectedCrates = collectedCrates + 1
    if collectedCrates < crateAmount then
        CreateCrate()
    else
        notOnJob = false
        destBlip = nil
        crateAmount = 0
        collectedCrates = 0
    end
end)