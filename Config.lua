Config = {}

Config.TipoMarker = -1
Config.ColoreMarker = { r = 255, g = 255, b = 255 }

Config.Craftings = {
    ['armeria'] = {
        posizione = vector3(16.8621, -1110.1134, 29.7970),
        job = 'armeria200',
        texture = 'general',
        ricette = {
            ['Pistola'] = {
                tempo = 5000,
                ingredienti = {
                  {item = 'steel', quantita = 3},
                  {item = 'iron', quantita = 10}
                },
                risultato = {
                  item = 'weapon_pistol',
                  quantita = 1
                }
            },
            ['Pistola MK2'] = {
                tempo = 10000,
                ingredienti = {
                    {item = 'steel', quantita = 10},
                    {item = 'iron', quantita = 15},
                },
                risultato = {
                    item = 'weapon_pistol_mk2',
                    quantita = 1
                }
            },
            ['Colpi 9mm'] = {
                tempo = 1000,
                ingredienti = {
                    {item = 'polveredasparo', quantita = 3},
                    {item = 'iron', quantita = 1}
                },
                risultato = {
                    item = 'ammo-9',
                    quantita = 5
                }
            }
        }
    },
}