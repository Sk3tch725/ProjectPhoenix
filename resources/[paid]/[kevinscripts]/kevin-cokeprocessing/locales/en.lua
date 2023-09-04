local Translations = {
    success = {
        watered = 'Plant watered.',
        fertilized = 'Plant fertilized.',
    },
    progressbar = {
        reaping = 'Reaping crop',
        planting = 'Planting Seed...',
        removing = 'Removing...',
        watering = 'Watering...',
        fertilizing = 'Fertilizing...',
        refilling = 'Refilling',
        process_plants = 'Processing',
        add_gas = 'Adding Gas',
        breaking_down = 'Breaking Down'
    },
    warning = {
        soil_unsuitable = 'The soil doesn\'t look good to plant..',
        no_water = 'You don\'t have any water source..',
        no_food = 'You don\'t have any fertilizer..',
        can_empty = 'Can looks empty',
        not_inwater = 'You are not in water',
        can_full = 'Can appears to be full',
        not_available = 'Check back again later',
        insufficent_plants = 'Not enough plants',
        container_full = 'Container seems to be filled',
        no_container = 'You don\'t have a gas container',
        container_empty = 'You don\'t have a filed container'
    },
    target = {
        siphon_gas = 'Siphon Gas',
        check = 'Check',
        harvest = 'Harvest Plant',
        water = 'Water Plant',
        fertilize = 'Fertilize Plant',
        destroy = 'Destroy Plant',
        burn = 'Burn Plant',
    },
    status = {
        dead = 'Dead',
        alive = 'Alive',
    },
    menu = {
        plant = 'Plant : %{seedname}',
        status = 'Plant Status: %{status}',
        stage = 'Plant Stage: %{stage} ',
        health = 'Plant Health: %{health}',
        food = 'Plant Food: %{food}',
        water = 'Plant Water: %{water}',
        progress = 'Plant Progress: %{progress}',
    },
    cancel = {
        cancelled = 'Cancelled'
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})