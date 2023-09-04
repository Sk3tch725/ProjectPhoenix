Planting = {}
-- 
-- 
-- 
-- NOTHING IS BALANCED FOR ANY SERVER RANDOM NUMBERS WERE USED FOR ITEMS NEEDED/GIVEN ETC FOR TESTING SO YOU NEED TO ADJUST FOR YOUR SERVER
-- 
-- 
-- 
Planting.PoliceJobs = { -- list of police jobs that can burn the coca plants (PS burning is the same as destrying difference just being there is fire for one as a little immersion for police officers)
    'police',
    'bcso',
    'lapd',
}
Planting.WaterCanUses = 30
Planting.WaterCanItem = 'water_can'
Planting.FertilizerItem = 'fertilizer'
Planting.WaterAmount = 90 -- only when the plant is below this amount would you get the option to water plant
Planting.FoodAmount = 90 -- only when the plant is below this amount would you get the option to fertilize plant
Planting.HarvestWaterFoodAmount = 80 -- this amount is checked when harvesting the plants once the plant is not dead and is harvestable.
-- If the plant is not dead and is harvestable but the food and water is under this amount the option to harvest would not show until it is equal to or above the amount

-- 
-- Times are in minutes
Planting.GrowthRefreshTime = 10 --(minutes) time till the plant progress / stage is updated
Planting.FoodWaterRefreshTime = 4 --(minutes) time till the food and water gets updated
-- 
-- 
Planting.Colors = { --this is the progressbar colors on the menu can change to whatever color to match your hud or whatever you like https://mantine.dev/theming/colors/#default-colors
    health = '#F03E3E',
    food = '#FD7E14',
    water = '#228BE6',
    progress = '#51CF66',
}

Planting.HarvestAmount = {
    min = 3,
    max = 6,
}
Planting.PlantItem = 'coca_plant'
Planting.Plants = {
    label = 'Coca Seed',
    stage = {
        stage_a = 'bzzz_prop_seeds_004', -- stages for the plant props
        stage_b = 'bzzz_prop_seeds_006',
        stage_c = 'bzzz_prop_seeds_005',
        stage_d = 'bzzz_plant_coca_a',
        stage_e = 'bzzz_plant_coca_b',
        stage_f = 'bzzz_plant_coca_c',
    }
}

Planting.GroundHashes = { --types of ground hashes the number after is the amount that would be added to the plants progress to increase
    [2409420175]    = 1,
    [951832588]     = 1,
    [3008270349]    = 1,
    [3833216577]    = 1,
    [223086562]     = 1,
    [1333033863]    = 1,
    [4170197704]    = 1,
    [3594309083]    = 1,
    [2461440131]    = 1,
    [1109728704]    = 1,
    [2352068586]    = 1,
    [1144315879]    = 1,
    [581794674]     = 1,
    [2128369009]    = 1,
    [-461750719]    = 1,
    [-1286696947]   = 1,
}