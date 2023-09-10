Config                              = {}
Config.Debug                        = true

-- ## [FRAMEWORKS SUPPORTED]: ESX, QBCore
Config.Framework                    = "ESX"

-- ## [SCRIPTS SUPPORTED]: qtarget, qb-target, ox_target
Config.QTargetScript                = "qtarget"

-- ## [SCRIPTS SUPPORTED]: mythic_notify, okoknotify, pnotify, default
Config.NotificationScript           = "default"

-- ###############################################
-- MARKETS
-- ###############################################

-- ## [ITEM TYPES]: item, weapon.

-- ## [PAYMENT TYPES]: money, bank, black_money, item

-- item is mostly used for ox_inventory because money (money) is an item.

-- ## [CUSTOM CURRENCY SUPPORT]:

-- In case you have a custom currency (not item), but similar to cash, bank or black_money, you are allowed to edit tp-server_functions.lua
-- and add the custom currency you want to include in the shops. 
-- For displaying this custom currency in the shop, you have to manually add it in script.js in line 163+.

Config.Markets = {
    ['Food Market'] = {
        { item = "tuna_can",          label = "Tuna Can",              price = 1,
		description = "Canned tuna is among the healthiest, most affordable sources of protein you can buy. The fish is rich in anti-inflammatory, heart-protective omega-3 fatty acids, contains anywhere between 20 and 25 grams of protein per can, is rich in vitamin D, and is low in carbs.",
		givenAmount = 2,       type = "item",       paymentType = "money",       paymentItem = "cash"},

        { item = "corn_can",          label = "Corn Can",              price = 1,              
		description = "Each 100-gram serving of canned sweet corn contains a wealth of vitamins beneficial to good health. Corn contains almost all the B vitamins. Required for energy production, these water-soluble vitamins provide fuel for the proper functioning of your heart, cells, muscles and brain.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},

        { item = "giantbeans_can",    label = "Giant Beans Can",       price = 1,              
		description = "One popular nutritious specialty from the sunny Mediterranean region is Giant Butter Beans in Tomato Sauce, called Gigantes in Greece. It is the delicious result of extra human care in high production standards, with the use of selected white giant butter beans, sun ripened tomatoes and other natural herbs and spices according to our traditional recipe.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},

        { item = "redbeans_can",      label = "Red Beans Can",         price = 1,              
		description = "They are an excellent source of fiber, plant-based protein, and other essential nutrients, such as folate and potassium. Despite the potential for contamination, canned beans are generally safe to consume and prove to be a convenient and nutritious alternative to dried beans.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},

        { item = "peach_can",         label = "Peach Can",             price = 1,              
		description = "A new study published in the Journal of the Science of Food and Agriculture finds that canned peaches (yes, from the grocery store canned aisle) are as loaded with nutrients as fresh peaches. And in some cases, they pack more of a nutritional punch.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},

        { item = "corned_beef_can",   label = "Corned Beef Can",       price = 1,              
		description = "Corned beef is processed red meat made by brining brisket in a salt and spice solution to flavor and tenderize it. While it provides protein and nutrients like iron and vitamin B12, corned beef is relatively high in fat and sodium. It's also a source of certain compounds that may increase your risk of cancer.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},

        { item = "spam",              label = "SPAM",                  price = 1,              
		description = "Though Spam is convenient, easy to use and has a long shelf-life, it's also very high in fat, calories and sodium and low in important nutrients, such as protein, vitamins and minerals. Additionally, it's highly processed and contains preservatives like sodium nitrite that may cause several adverse health effects.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},
        
		{ item = "apple",             label = "Apple",                 price = 1,              
		description = "Apples are an incredibly nutritious fruit that offers multiple health benefits. They're rich in fiber and antioxidants. Eating them is linked to a lower risk of many chronic conditions, including diabetes, heart disease, and cancer. Apples may also promote weight loss and improve gut and brain health.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},
       
		{ item = "orange",            label = "Orange",                price = 1,              
		description = "In addition to vitamin C, oranges have other nutrients that keep your body healthy. The fiber in oranges can keep blood sugar levels in check and reduce high cholesterol to prevent cardiovascular disease. Oranges contain approximately 55 milligrams of calcium, or 6% of your daily requirement.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},
       
		{ item = "banana",            label = "Banana",                price = 1,              
		description = "Like Most Fruit, Bananas Are Very Healthy Bananas are very nutritious. They contain fiber, potassium, vitamin C, vitamin B6 and several other beneficial plant compounds. These nutrients may have a number of health benefits, such as for digestive and heart health.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},
    },

	['Weed Market'] = {
        { item = "lighter",          label = "Lighter",              price = 1,              
		description = "A lighter is a device that produces a small flame, especially one used to light cigarettes.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},

        { item = "cigarette_pack",          label = "Cigarette Pack",       price = 3,       
		description = "A pack or packet of cigarettes (also informally called fag packet in British slang; as in the idiom 'back of a fag packet' or 'fag-packet calculation') is a rectangular container, mostly of paperboard, which contains cigarettes. The pack is designed with a flavor-protective foil, paper or plastic, and sealed through a transparent airtight plastic film. By pulling the pull-tabs, the pack is opened. Hard packs can be closed again after opening, whereas soft packs cannot. ",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},

        { item = "joint",    label = "Joint",       price = 3,                      
		description = "A joint, which is commonly referred to as a spliff (which can also mean specifically a joint that has tobacco mixed with cannabis), 'doobie' or 'doob', is a rolled cannabis cigarette.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},

        { item = "bong",      label = "Bong",       price = 3,                
		description = "A bong (also known as a water pipe) is a filtration device generally used for smoking cannabis, tobacco, or other herbal substances. In the bong shown in the photo, the gas flows from the lower port on the left to the upper port on the right.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},

        { item = "choco_cannabis",         label = "Choco Cannabis",             price = 2,              
		description = "Chocolate Kush, bred by 00 Seeds, is a powerful indica strain that captures the best of its two parent strains. Mazar, with its resin-oozing buds, lends its potent full-body euphoria while its other pure indica parent passes on a pungent aroma of hashy incense and chocolate.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},

		{ item = "haze_cannabis",         label = "Haze Cannabis",             price = 3,              
		description = "Haze strains are among the most popular sativa-dominant, or nearly pure sativa hybrids. Cannabis smokers all over the world enjoy Hazes for their long-lasting, energetic head high that doesn’t glue them to the couch. They also like them for their outstanding aromas, which often blend intense spicy notes with fruity, sweet and earthy undertones.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},

		{ item = "blue_dream_cannabis",         label = "Blue Dream Cannabis",             price = 5,              
		description = "Blue Dream is a sativa-dominant hybrid marijuana strain made by crossing Blueberry with Haze. This strain produces a balanced high, along with effects such as cerebral stimulation and full-body relaxation.",
		givenAmount = 1,       type = "item",       paymentType = "money",       paymentItem = "cash"},

    },


	['Weapon Store'] = {
		{ item = "WEAPON_ASSAULTRIFLE",          label = "Assault Rifle",         price = 50,             
		description = "“This standard assault rifle boasts a large capacity magazine and long distance accuracy.”", 
		givenAmount = 1,       type = "weapon",       paymentType = "money",       paymentItem = "cash"},

        { item = "WEAPON_CARBINERIFLE",          label = "Carbine Rifle",         price = 1,              
		description = "“Combining long distance accuracy with a high capacity magazine, the Carbine Rifle can be relied on to make the hit.”", 
		givenAmount = 1,       type = "weapon",       paymentType = "money",       paymentItem = "cash"},

        { item = "WEAPON_SPECIALCARBINE",        label = "Special Carbine (SCAR)",price = 1,              
		description = "“Combining accuracy, maneuverability, firepower and low recoil, this is an extremely versatile assault rifle for any combat situation.”",
		givenAmount = 1,       type = "weapon",       paymentType = "money",       paymentItem = "cash"},

        { item = "WEAPON_ADVANCEDRIFLE",         label = "Advanced Rifle",        price = 1,              
		description = "“The most lightweight and compact of all assault rifles, without compromising accuracy and rate of fire.”",
		givenAmount = 1,       type = "weapon",       paymentType = "money",       paymentItem = "cash"},

        { item = "WEAPON_COMPACTRIFLE",          label = "Compact Rifle",         price = 1,              
		description = "“Half the size, all the power, double the recoil: there's no riskier way to say I'm compensating for something.”",
		givenAmount = 1,       type = "weapon",       paymentType = "money",       paymentItem = "cash"},

        { item = "WEAPON_SMG",                   label = "SMG (MP5)",             price = 1,              
		description = "“This is known as a good all-around submachine gun. Lightweight with an accurate sight and 30-round magazine capacity.”",
		givenAmount = 1,       type = "weapon",       paymentType = "money",       paymentItem = "cash"},

        { item = "WEAPON_COMBATPDW",             label = "Combat PDW",            price = 1,              
		description = "“Who said personal weaponry couldn't be worthy of military personnel? Thanks to our lobbyists, not Congress. Integral suppressor.”",
		givenAmount = 1,       type = "weapon",       paymentType = "money",       paymentItem = "cash"},

        { item = "WEAPON_MICROSMG",              label = "Micro SMG (UZI)",       price = 1,              
		description = "“Combines compact design with a high rate of fire at approximately 700-900 rounds per minute.”",
		givenAmount = 1,       type = "weapon",       paymentType = "money",       paymentItem = "cash"},

        { item = "WEAPON_HEAVYSHOTGUN",          label = "Heavy Shotgun",         price = 1,              
		description = "“The weapon to reach for when you absolutely need to make a horrible mess of the room. Best used near easy-wipe surfaces only.”",
		givenAmount = 1,       type = "weapon",       paymentType = "money",       paymentItem = "cash"},

        { item = "WEAPON_ASSAULTSHOTGUN",        label = "Assault Shotgun",       price = 1,              
		description = "“Fully automatic shotgun with 8 round magazine and high rate of fire.”",
		givenAmount = 1,       type = "weapon",       paymentType = "money",       paymentItem = "cash"},

		{ item = "WEAPON_SAWNOFFSHOTGUN",        label = "Sawed-Off Shotgun",     price = 1,              
		description = "“This single-barrel, sawed-off shotgun compensates for its low range and ammo capacity with devastating efficiency in close combat.”",
		givenAmount = 1,       type = "weapon",       paymentType = "money",       paymentItem = "cash"},

		{ item = "WEAPON_PUMPSHOTGUN",           label = "Pump Shotgun",          price = 1,              
		description = "“Standard shotgun ideal for short-range combat. A high-projectile spread makes up for its lower accuracy at long range.”",
		givenAmount = 1,       type = "weapon",       paymentType = "money",       paymentItem = "cash"},

        { item = "disc_ammo_pistol",             label = "Pistol Ammo (Clip)",    price = 1,              
		description = "",              
		givenAmount = 1,       type = "item",         paymentType = "money",       paymentItem = "cash"},

        { item = "disc_ammo_smg",                label = "SMG Ammo (Clip)",       price = 1,              
		description = "",              
		givenAmount = 1,       type = "item",         paymentType = "money",       paymentItem = "cash"},

        { item = "disc_ammo_rifle",              label = "Rifle Ammo (Clip)",     price = 1,              
		description = "",              
		givenAmount = 1,       type = "item",         paymentType = "money",       paymentItem = "cash"},

        { item = "disc_ammo_shotgun",            label = "Shotgun Ammo (Rounds)", price = 1,              
		description = "",              
		givenAmount = 1,       type = "item",         paymentType = "money",       paymentItem = "cash"},
    },  
}

-- ###############################################
-- MARKET ZONES
-- ###############################################

-- Peds List including ped hash: https://wiki.rage.mp/index.php?title=Peds
-- Ped hash is the first requirement on the Ped.

-- Blips: https://wiki.gtanet.work/index.php?title=Blips

-- OpenKey works only when AllowQTarget is false.
Config.OpenKey                      = "E"

-- If no Markets Zones available, you should set this to false.
Config.EnableMarketZones                = true

Config.MarketZones = {

	VineWoodHillsWeaponMarket = {
		Pos              = {x = -402.04, y = 1154.76, z = 324.92, heading = 345.52},
		ActionDistance   = 2.5,
		
		Market       = "Weapon Store",

		AllowPedSpawning = true,
		AllowQTarget     = true,

		Ped              = {
			Hash = 0x841BA933, 
			Name = "ig_g", 
			Weapon = "WEAPON_ASSAULTRIFLE",
			
		},

		Target = {
			TargetTitle   = "Purchase weapons and ammo.",
			TargetIcon    = "fas fa-gun",
		},

		AllowBlip        = true,

		BlipData         = {
			Title = "Weapon Store", 
			Colour = 40, 
			Scale = 1.0, 
			Display = 4, 
			Id = 403,
		},

	},

	VineWoodHillsFoodMarket = {
		Pos              = {x = -427.04, y = 1165.28, z = 324.92, heading = 306.32},
		ActionDistance   = 2.5,
		
		Market       = "Food Market",

		AllowPedSpawning = true,
		AllowQTarget     = true,

		Ped              = {
			Hash = 0x169BD1E1, 
			Name = "a_f_m_prolhost_01", 
			Weapon = nil,
			
		},

		Target = {
			TargetTitle   = "Purchase vegetables and cans.",
			TargetIcon    = "fas fa-hamburger",
		},

		AllowBlip        = true,

		BlipData         = {
			Title = "Food Market", 
			Colour = 40, 
			Scale = 1.0, 
			Display = 4, 
			Id = 403,
		},

	},

	VineWoodHillsWeedMarket = {
		Pos              = {x = -456.8, y = 1147.12, z = 324.92, heading = 263.12},
		ActionDistance   = 2.5,
		
		Market       = "Weed Market",

		AllowPedSpawning = true,
		AllowQTarget     = true,

		Ped              = {
			Hash = 0xC9E5F56B, 
			Name = "s_m_m_ccrew_01", 
			Weapon = nil,
			
		},

		Target = {
			TargetTitle   = "Purchase cigarettes and cannabis.",
			TargetIcon    = "fas fa-pills",
		},

		AllowBlip        = true,

		BlipData         = {
			Title = "Weed Market", 
			Colour = 40, 
			Scale = 1.0, 
			Display = 4, 
			Id = 403,
		},

	},

}

