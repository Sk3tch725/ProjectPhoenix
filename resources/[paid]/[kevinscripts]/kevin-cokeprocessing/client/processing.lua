local QBCore = exports['qb-core']:GetCoreObject()

local stage = 0

CreateThread(function ()
    for id, data in pairs(Processing.TargetProperties) do
        exports['qb-target']:AddBoxZone('coke'..id, data.tabletarget.coords, data.tabletarget.length, data.tabletarget.width, {
            name='coke'..id,
            heading= data.tabletarget.heading,
            debugPoly= Processing.DebugPolyZones,
            minZ= data.tabletarget.minZ,
            maxZ= data.tabletarget.maxZ,
            }, {
                options = {
                    {
                        icon = data.targeticon,
                        label = data.targetlabel,
                        action = function ()
                            TriggerEvent(data.targetevent, id, data)
                        end
                    },
                },
            distance = 2.0
        })
    end

    local bones = {
		'petroltank',
		'petroltank_l',
		'petroltank_r',
		'wheel_rf',
		'wheel_rr',
		'petrolcap ',
		'seat_dside_r',
		'engine',
	}
	exports['qb-target']:AddTargetBone(bones, {
		options = {
			{
				type = 'client',
				icon = 'fas fa-circle',
				label = Lang:t('target.siphon_gas'),
				canInteract = function()
					return QBCore.Functions.HasItem(Processing.GasContainerItem)
				end,
                action = function (entity)
                    TriggerEvent('kevin-cokeprocessing:siphongas', entity)
                end
			}
		},
		distance = 1.5,
	})
end)

RegisterNetEvent('kevin-cokeprocessing:teleport', function (id, data)
    local player = PlayerPedId()
    local coords
    if id == 3 then
        coords = vector4(data.coords.x, data.coords.y, data.coords.z, data.coords.w)
    else
        coords = vector4(data.coords.x, data.coords.y, data.coords.z, data.coords.w)
    end

    DoScreenFadeOut(800)
    Wait(800)
    SetEntityCoords(player, coords.x, coords.y, coords.z)
    SetEntityHeading(player, coords.w)
    Wait(800)
    DoScreenFadeIn(800)
end)

RegisterNetEvent('kevin-cokeprocessing:siphongas', function (vehicle)
    local vehicleGas = GetVehicleFuelLevel(vehicle)
    if vehicleGas >= Processing.VehicleGasLevel then
        QBCore.Functions.Progressbar('coke_process', Lang:t('progressbar.process_plants'), 8000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'weapon@w_sp_jerrycan',
            anim = 'fire',
            flags = 49,
        }, {}, {}, function() -- Done
            ClearPedTasks(player)
            exports[Processing.FuelScript]:SetFuel(vehicle, Processing.RemainingFuel)
            TriggerServerEvent('kevin-processing:setgascontainerfull', vehicle)
        end, function() -- Cancel
            ClearPedTasks(player)
            QBCore.Functions.Notify(Lang:t('cancel.cancelled'), 'error')
        end)
    else
        QBCore.Functions.Notify('Vehicle doesnt seem to have enough fuel', 'error')
    end
end)

RegisterNetEvent('kevin-cokeprocessing:processplants', function()
    local player = PlayerPedId()
    if stage == 0 then
        QBCore.Functions.Progressbar('coke_process', Lang:t('progressbar.process_plants'), 8000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'missmechanic',
            anim = 'work_out',
            flags = 49,
        }, {}, {}, function() -- Done
            ClearPedTasks(player)
            TriggerServerEvent('kevin-cokeprocessing:removeplants')
        end, function() -- Cancel
            ClearPedTasks(player)
            QBCore.Functions.Notify(Lang:t('cancel.cancelled'), 'error')
        end)
    else
        TriggerEvent('kevin-cokeprocessing:addgas')
    end
end)

RegisterNetEvent('kevin-cokeprocessing:addgas', function (bool)
    if bool then stage = 1 end
    local player = PlayerPedId()
    QBCore.Functions.Progressbar('coke_process', Lang:t('progressbar.add_gas'), 8000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'weapon@w_sp_jerrycan',
        anim = 'fire',
        flags = 49,
    }, {}, {}, function() -- Done
        ClearPedTasks(player)
        TriggerServerEvent('kevin-cokeprocessing:removegas')
    end, function() -- Cancel
        ClearPedTasks(player)
        QBCore.Functions.Notify(Lang:t('cancel.cancelled'), 'error')
    end)
end)

RegisterNetEvent('kevin-cokeprocessing:showmenu', function ()
    stage = 0
    local brickMenu = {
        id = 'brick-menu',
        title = 'Choose Brick',
        options = {}
    }
    local options = {}
    for itemName, v in pairs(Processing.PlantsBreakDown.brickitem) do
        options[#options+1] = {
            title = QBCore.Shared.Items[itemName]['label'],
            description = 'Baggy Amount: '..v.baggyamount,
            serverEvent = 'kevin-cokeprocessing:givebrick',
            args = {
                item = QBCore.Shared.Items[itemName]['name'],
                amount = v.brickgiven
            }
        }
    end
    brickMenu['options'] = options
    lib.registerContext(brickMenu)
    lib.showContext('brick-menu')
end)

RegisterNetEvent('kevin-cokeprocessing:breakbricks', function ()
    local brickMenu = {
        id = 'brick-menu',
        title = 'Choose Brick',
        options = {}
    }
    local options = {}
    for itemName, v in pairs(Processing.PlantsBreakDown.brickitem) do
        local item = QBCore.Functions.HasItem(itemName)
        if item then
            options[#options+1] = {
                title = QBCore.Shared.Items[itemName]['label'],
                description = 'Baggy Amount: '..v.baggyamount,
                event = 'kevin-cokeprocessing:doanim',
                args = {
                    item = Processing.PlantsBreakDown.baggyitem,
                    removeitem = QBCore.Shared.Items[itemName]['name'],
                    amount = v.baggyamount
                }
            }
        end
    end
    brickMenu['options'] = options
    lib.registerContext(brickMenu)
    lib.showContext('brick-menu')
end)

RegisterNetEvent('kevin-cokeprocessing:doanim', function (data)
    QBCore.Functions.Progressbar('coke_process', Lang:t('progressbar.breaking_down'), 8000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@heists@money_grab@briefcase',
        anim = 'put_down_case',
        flags = 49,
    }, {}, {}, function() -- Done
        TriggerServerEvent('kevin-cokeprocessing:givebaggys', data)
    end, function() -- Cancel
        ClearPedTasks(player)
        QBCore.Functions.Notify(Lang:t('cancel.cancelled'), 'error')
    end)
end)