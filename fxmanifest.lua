fx_version 'cerulean'
game 'gta5'
author 'Samu | BuongiornoDEV'
description 'Sistema personalizzato di crafting realizzato da BuongiornoDEV'
version '1.0.0'
lua54 'yes'

client_scripts {
  'Client/**.**'
}
server_script {
  'Server/**.**'
}

shared_script {
  '@es_extended/imports.lua',
  '@ox_lib/init.lua',
  'Config.lua'
}

ui_page 'Html/index.html'

files {
  'Html/**.**',
}
