fx_version 'adamant'
game 'gta5'

description 'Created for Wolfpack'
version '3.0'

files {
    '*.html',
    'assets/**/*.*',
    'assets/**/**/*.*'
}

loadscreen 'index.html'
loadscreen_manual_shutdown 'yes'

client_scripts {
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

lua54 "yes"