fx_version 'adamant'
game 'gta5'

author 'Nosmakos'
description 'Titans Productions Market (ESX & QBCORE)'
version '1.1.0'

ui_page 'html/index.html'

server_scripts {
    'config.lua',
    'locales.lua',
    'server/*.lua',
}


client_scripts {
    'config.lua',
    'locales.lua',
    'client/*.lua',
}

files {
	'html/index.html',
	'html/css/*.css',


    'html/js/config.js',
    'html/js/locales/*.js',

    'html/js/script.js',

    'html/img/background.jpg',
}
