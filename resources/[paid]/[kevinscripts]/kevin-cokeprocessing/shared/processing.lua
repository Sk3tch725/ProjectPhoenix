Processing = Processing or {}
-- 
-- 
-- 
-- NOTHING IS BALANCED FOR ANY SERVER RANDOM NUMBERS WERE USED FOR ITEMS NEEDED/GIVEN ETC FOR TESTING SO YOU NEED TO ADJUST FOR YOUR SERVER
-- 
-- 
--
Processing.UseQbEntrance = true -- if you are using the default teleports that come in qb for the coke processing ipl
Processing.FuelScript = 'ps-fuel' -- ps-fuel / LegacyFuel / cdn-fuel
Processing.GasContainerItem = 'coca_gascontainer'
Processing.VehicleGasLevel = 30 -- if vehicle fuel is equal to or above it would allow to siphon
Processing.RemainingFuel = 10 -- amount of fuel to leave in vehicle after siphoning
Processing.PlantsBreakDown = {
    plantsneeded = 1,
    baggyitem = 'cokebaggy',
    brickitem = {
        ['coke_brick'] = { -- used a default items that are already in qb shared items
            brickgiven = 1, -- amount of bricks given from the plant
            baggyamount = 50, --amount of baggys you get when a single brick is broken down
        },
        ['coke_small_brick'] = {
            brickgiven = 4,
            baggyamount = 100,
        },
    },
}

Processing.DebugPolyZones = false
Processing.TargetProperties = {
    [1] = {
        tabletarget = {
            coords = vector3(1090.22, -3195.75, -38.99),
            length = 1.2,
            width = 2.0,
            heading = 0,
            minZ = -42.99,
            maxZ = -38.99,
        },
        targeticon = 'fas fa-circle',
        targetlabel = 'Process Plants',
        targetevent = 'kevin-cokeprocessing:processplants',
    },
    [2] = {
        tabletarget = {
            coords = vector3(1092.97, -3195.75, -38.99),
            length = 1.2,
            width = 2.0,
            heading = 0,
            minZ = -42.99,
            maxZ = -38.99,
        },
        targeticon = 'fas fa-circle',
        targetlabel = 'Break Down Bricks',
        targetevent = 'kevin-cokeprocessing:breakbricks',
    },
    [3] = { -- only used if Processing.UseQbEntrance is set to false
        tabletarget = {
            coords = vector3(909.66, -1589.25, 30.29),
            length = 0.6,
            width = 1.4,
            heading = 270,
            minZ = 29.09,
            maxZ = 31.69,
        },
        targeticon = 'fas fa-circle',
        targetlabel = 'Enter',
        targetevent = 'kevin-cokeprocessing:teleport',
        coords = vector4(1088.64, -3188.04, -38.99, 182.69), -- coords for the teleports
    },
    [4] = { -- only used if Processing.UseQbEntrance is set to false
        tabletarget = {
            coords = vector3(1088.69, -3187.25, -38.99),
            length = 0.6,
            width = 1.4,
            heading = 0,
            minZ = -40.19,
            maxZ = -37.59,
        },
        targeticon = 'fas fa-circle',
        targetlabel = 'Exit',
        targetevent = 'kevin-cokeprocessing:teleport',
        coords = vector4(908.84, -1589.21, 30.28, 86.73)
    },
}