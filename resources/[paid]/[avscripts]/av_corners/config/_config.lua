Corners = {}
Corners.Framework = "QBCore" -- "QBCore" or "ESX"... for ESX make sure to uncomment the ESX import from fxmanifest.lua first
Corners.TargetSystem = "qb-target" -- qtarget, qb-target... For ox_target use qtarget and it will convert it automatically
Corners.GangZoneMultiplier = true -- Gang receives more money if they sell inside their gang zone?
Corners.GangMultiplier = 1.25 -- Gang will receive a 25% extra if selling inside their zone
Corners.UsingAVBoosting = true -- True if you have av_boosting installed, prevents from using 2 loops checking police count
Corners.PoliceJobName = "police" -- Police Job Name
Corners.Account = "cash" -- Account for money (bank, cash, money, depends on how the illegal money is named in your SV)
Corners.Distance = 50 -- How far can you go from the vehicle before the corner selling gets cancelled
Corners.WaitingTime = math.random(10000,15000) -- Time in miliseconds before the script picks a random client in the streets (10 - 15 seconds)
Corners.MaxBags = 5 -- Max bags player can sell per transaction
Corners.BlacklistedClasses = { -- Player can't start sell using this vehicle classes
    [7] = true, -- Super
    [8] = true, -- Motorcycles
    [10] = true, -- Industrial
    [14] = true, -- Boats, who uses boats to sell drugs?
    [15] = true, -- Helicopters... wait what?
    [18] = true, -- Emergency
    [19] = true, -- Military
}
Corners.BlacklistedPeds = { --Players won't be able to sell drugs to this peds
    [`s_f_y_cop_01`] = true,
    [`s_m_m_security_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true,
}

-- https://www.igta5.com/images/gtav-map-neighborhoods.jpg
-- https://forums.gta5-mods.com/topic/5749/reference-map-zone-names-and-zone-labels
Corners.Drugs = {
    ['meth1g'] = { -- Drug item
        label = "Meth",
        icon = "fa-solid fa-flask",
        minCops = 0, -- Min cops online to sell this specific drug
        basePrice = 75, -- Base price per bag
        maxPrice = 250, -- Max price per bag (doesn't include gang multiplier)
        zones = { -- Zones where player can start corner selling, use ALL if you want to enable sell everywhere (check weed1g example)
            ['PALETO'] = false,
            ['SANDY'] = false,
            ['MIRR'] = true,
            ['CYPRE'] = true,
            ['RANCHO'] = true,
            ['STRAW'] = true,
            ['BEACH'] = true,
            ['MORN'] = true,
            ['DAVIS'] = true,
            ['KOREAT'] = true,
        }
    },
    ['cokebaggy'] = { -- Drug item
        label = "Coke",
        icon = "fa-solid fa-gear",
        minCops = 0, -- Min cops online to sell this specific drug
        basePrice = 100, -- Base price per bag
        maxPrice = 300, -- Max price per bag (doesn't include gang multiplier)
        zones = { -- Zones where player can start corner selling, use ALL if you want to enable sell everywhere (check weed1g example)
            ['PALETO'] = false,
            ['SANDY'] = false,
            ['MIRR'] = true,
            ['CYPRE'] = true,
            ['RANCHO'] = true,
            ['STRAW'] = true,
            ['BEACH'] = true,
            ['MORN'] = true,
            ['DAVIS'] = true,
            ['KOREAT'] = true,
        }
    },
    ['ak_47_joint'] = { -- Drug item
        label = "Ak 47",
        icon = "fa-solid fa-cannabis",
        minCops = 0, -- Min cops online to sell this specific drug
        basePrice = 50, -- Base price per bag
        maxPrice = 100, -- Max price per bag (doesn't include gang multiplier)
        zones = { -- Zones where player can start corner selling, use ALL if you want to enable sell everywhere (check weed1g example)
            ['PALETO'] = false,
            ['SANDY'] = false,
            ['MIRR'] = true,
            ['CYPRE'] = true,
            ['RANCHO'] = true,
            ['STRAW'] = true,
            ['BEACH'] = true,
            ['MORN'] = true,
            ['DAVIS'] = true,
            ['KOREAT'] = true,
        }
    },
    ['blue_dream_joint'] = { -- Drug item
        label = "Blue Dream",
        icon = "fa-solid fa-cannabis",
        minCops = 0, -- Min cops online to sell this specific drug
        basePrice = 50, -- Base price per bag
        maxPrice = 100, -- Max price per bag (doesn't include gang multiplier)
        zones = { -- Zones where player can start corner selling, use ALL if you want to enable sell everywhere (check weed1g example)
            ['PALETO'] = false,
            ['SANDY'] = false,
            ['MIRR'] = true,
            ['CYPRE'] = true,
            ['RANCHO'] = true,
            ['STRAW'] = true,
            ['BEACH'] = true,
            ['MORN'] = true,
            ['DAVIS'] = true,
            ['KOREAT'] = true,
        }
    },
    ['og_kush_joint'] = { -- Drug item
        label = "OG Kush",
        icon = "fa-solid fa-cannabis",
        minCops = 0, -- Min cops online to sell this specific drug
        basePrice = 50, -- Base price per bag
        maxPrice = 100, -- Max price per bag (doesn't include gang multiplier)
        zones = { -- Zones where player can start corner selling, use ALL if you want to enable sell everywhere (check weed1g example)
            ['PALETO'] = false,
            ['SANDY'] = false,
            ['MIRR'] = true,
            ['CYPRE'] = true,
            ['RANCHO'] = true,
            ['STRAW'] = true,
            ['BEACH'] = true,
            ['MORN'] = true,
            ['DAVIS'] = true,
            ['KOREAT'] = true,
        }
    },
    ['pineapple_express_joint'] = { -- Drug item
        label = "Pineapple Express",
        icon = "fa-solid fa-cannabis",
        minCops = 0, -- Min cops online to sell this specific drug
        basePrice = 50, -- Base price per bag
        maxPrice = 100, -- Max price per bag (doesn't include gang multiplier)
        zones = { -- Zones where player can start corner selling, use ALL if you want to enable sell everywhere (check weed1g example)
            ['PALETO'] = false,
            ['SANDY'] = false,
            ['MIRR'] = true,
            ['CYPRE'] = true,
            ['RANCHO'] = true,
            ['STRAW'] = true,
            ['BEACH'] = true,
            ['MORN'] = true,
            ['DAVIS'] = true,
            ['KOREAT'] = true,
        }
    },
    ['purple_haze_joint'] = { -- Drug item
        label = "Purple Haze",
        icon = "fa-solid fa-cannabis",
        minCops = 0, -- Min cops online to sell this specific drug
        basePrice = 50, -- Base price per bag
        maxPrice = 100, -- Max price per bag (doesn't include gang multiplier)
        zones = { -- Zones where player can start corner selling, use ALL if you want to enable sell everywhere (check weed1g example)
            ['PALETO'] = false,
            ['SANDY'] = false,
            ['MIRR'] = true,
            ['CYPRE'] = true,
            ['RANCHO'] = true,
            ['STRAW'] = true,
            ['BEACH'] = true,
            ['MORN'] = true,
            ['DAVIS'] = true,
            ['KOREAT'] = true,
        }
    },
    ['white_widow_joint'] = { -- Drug item
        label = "White Widow",
        icon = "fa-solid fa-cannabis",
        minCops = 0, -- Min cops online to sell this specific drug
        basePrice = 50, -- Base price per bag
        maxPrice = 100, -- Max price per bag (doesn't include gang multiplier)
        zones = { -- Zones where player can start corner selling, use ALL if you want to enable sell everywhere (check weed1g example)
            ['PALETO'] = false,
            ['SANDY'] = false,
            ['MIRR'] = true,
            ['CYPRE'] = true,
            ['RANCHO'] = true,
            ['STRAW'] = true,
            ['BEACH'] = true,
            ['MORN'] = true,
            ['DAVIS'] = true,
            ['KOREAT'] = true,
        }
    },
    ['weed_joint'] = { -- Drug item
        label = "Weed",
        icon = "fa-solid fa-cannabis",
        minCops = 0, -- Min cops online to sell this specific drug
        basePrice = 25, -- Base price per bag
        maxPrice = 70, -- Max price per bag (doesn't include gang multiplier)
        zones = { -- Zones where player can start corner selling, use ALL if you want to enable sell everywhere (check weed1g example)
            ['PALETO'] = false,
            ['SANDY'] = false,
            ['MIRR'] = true,
            ['CYPRE'] = true,
            ['RANCHO'] = true,
            ['STRAW'] = true,
            ['BEACH'] = true,
            ['MORN'] = true,
            ['DAVIS'] = true,
            ['KOREAT'] = true,
        }
    },
    -- ['your_custom_drug_item'] = {
    --     label = "Drug",
    --     icon = "fas fa-capsules", -- Icon from fontawesome (free)
    --     minCops = 1, -- Min cops online to sell this specific drug
    --     basePrice = math.random(10,20),
    --     zones = {
    --         ['ALL'] = true, -- Players can sell anywhere
    --     }
    -- },
}