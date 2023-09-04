
fx_version 'cerulean'

author 'KevinGirardx'
game 'gta5'

shared_script {
	'@ox_lib/init.lua',
	'@qb-core/shared/locale.lua',
	'locales/en.lua',
    'locales/*.lua',
	'shared/*.lua',
}

client_scripts {
	'client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}

lua54 'yes'
data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_plant_coca_a.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_prop_seeds_000.ytyp'

escrow_ignore { 
    'client/*.lua',
	'server/server.lua',
    'server/planting.lua',
    'config.lua',
	'shared/*.lua',
	'locales/*.lua',
}
dependency '/assetpacks'