Config = Config or {}
-- 
-- 
-- 
-- NOTHING IS BALANCED FOR ANY SERVER RANDOM NUMBERS WERE USED FOR ITEMS NEEDED/GIVEN ETC FOR TESTING SO YOU NEED TO ADJUST FOR YOUR SERVER
-- 
-- 
-- 
Config.PhoneItemName = 'phone'
Config.Phone = 'qb' -- qb , gks, qs
Config.CoolDown = 10 -- 10 minutes cooldown until job can be done again
Config.SpawnedCrates = { min = 2, max = 4, } -- amount of crates that are spawned in the water
Config.AvailableRuns = 10 -- 10 runs per server restart
Config.CokePed = { -- Starting ped to get the house location etc.
    hash = `g_m_m_casrn_01`, -- this is the trevor ped
    location = vector4(583.93, 138.24, 99.47, 167.31),
    scenario = 'WORLD_HUMAN_AA_SMOKE',
}

Config.SellerPed = { -- just another way if player find this ped an would rather sell items instead of planting or whatever
    use = false, -- true / false if to use this ped or not
    hash = `mp_m_counterfeit_01`,
    location = vector4(1196.88, -3253.53, 7.1, 77.25),
    scenario = 'WORLD_HUMAN_AA_SMOKE',
    paymenttype = 'cash', -- cash / bank
    buyerableitems = {
        ['coca_seed'] = { price = 1000, },
        ['coke_small_brick'] = { price = 12000, },
        ['coke_brick'] = { price = 16700, },
    }
}

Config.SharkData = {
    use = true, -- if to use the shark to swim around the crate
    chance = 45, -- chance of the shark spawning
    health = 300,
}

Config.Items = {
    seeditem = {
        item = 'coca_seed', -- name of the plantable seed 
        crateamount = { min = 10, max = 20, } -- amount of seed you get from the drug crate
    },
    extra = {
        chance = 5, -- 20% chance to get an extra item from the crate
        item = { -- can put whatever item u think would make sense here ( only one item is selected from list)
            'coke_small_brick',
            'coke_brick',
            'cokebaggy',
        },
        itemamount = { min = 1, max = 2, } -- amount of the item given
    }
}

Config.LocationData = {
    [1] = {
        cratehash = `ba_prop_battle_case_sm_03`, -- crate that is spawned 
        cratepos = vector4(-1714.66, -1524.17, 1.04, 145.07), -- location of the crate
    },
    [2] = {
        cratehash = `ba_prop_battle_case_sm_03`,
        cratepos = vector4(-388.85, -3274.09, 1.11, 70.41),
    },
    [3] = {
        cratehash = `ba_prop_battle_case_sm_03`,
        cratepos = vector4(2053.05, -2844.38, -1.32, 71.43),
    },
    [4] = {
        cratehash = `ba_prop_battle_case_sm_03`,
        cratepos = vector4(2916.94, -1744.64, 1.51, 94.86),
    },
    [5] = {
        cratehash = `ba_prop_battle_case_sm_03`,
        cratepos = vector4(3332.82, -887.66, 0.28, 94.85),
    },
    [6] = {
        cratehash = `ba_prop_battle_case_sm_03`,
        cratepos = vector4(3311.49, 67.06, -0.57, 38.43),
    },
    [7] = {
        cratehash = `ba_prop_battle_case_sm_03`,
        cratepos = vector4(4036.89, 5266.87, -0.07, 38.54),
    },
    [8] = {
        cratehash = `ba_prop_battle_case_sm_03`,
        cratepos = vector4(1201.16, 7208.31, -0.26, 40.98),
    },
    [9] = {
        cratehash = `ba_prop_battle_case_sm_03`,
        cratepos = vector4(-1500.2, 5993.51, -0.63, 41.09),
    },
    [10] = {
        cratehash = `ba_prop_battle_case_sm_03`,
        cratepos = vector4(-388.85, -3274.09, 1.11, 70.41),
    },
}


