# Dependencies

* qbcore
* qb-target
* ox_lib https://overextended.github.io/docs/ox_lib/
* https://bzzz.tebex.io/package/5073805  (FREE DOWNLOAD)
* https://bzzz.tebex.io/package/5437764  (FREE DOWNLOAD)

# INSTALLATION    PS IF YOU ALREADY HAVE WEEDPROCESSNG SOME ITEMS MAY BE DUPLICATE SO ADJUST ACCORDING IF YOU DO

# Run the plants.sql file that is in the main directory of processing

# Once you have downloaded the 2 files from the bzzz tebex, grab all of the files within the stream folders of each and copy them over to the stream folder that is in the coke processing.
- The stream folder in cokeprocessing should now look like this after coping the files:
https://cdn.discordapp.com/attachments/1024564936745160744/1137097557634453554/image.png

# Go to your qb-core > shared > items.lua and add the following items:

```lua
	-- Kevin CokeProcessing Items --
	['coca_seed'] 				 		 = {['name'] = 'coca_seed', 			    		['label'] = 'Coca Seeds', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'coca_seed.png',  					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['coca_plant'] 				 		 = {['name'] = 'coca_plant', 			    		['label'] = 'Coca Plant', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'coca_plant.png',  					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['coca_gascontainer'] 				 = {['name'] = 'coca_gascontainer', 			    ['label'] = 'Gas Container', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'coca_gascontainer.png',  			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
    ['fertilizer'] 				 = {['name'] = 'fertilizer', 			     	['label'] = 'Fertilizer', 					['weight'] = 0, 		['type'] = 'item', 	['image'] = 'fertilizer.png',  			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['water_can'] 				 		 = {['name'] = 'water_can', 			     		['label'] = 'Water Can', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'water_can.png',  					['unique'] = true, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},

```

# Copy the image files from the images folder and paste them in the following within your inventory > qb/lj/ps inventory > html > images

# qb/lj-inventory/html/js/app.js (Line 577 - 650) you can search for stickynote and you will see where it needs to be placed

```js
    } else if (itemData.name == "coca_gascontainer") {
        $(".item-info-title").html("<p>" + itemData.label + "</p>");
        $(".item-info-description").html(
            "</span></p><p><strong>Gas Filled: </b> " + "<a style=\"font-size:bold;color:green\">" +
            itemData.info.gasfilled +"</a>"
        );
    } else if (itemData.name == "water_can") {
        $(".item-info-title").html("<p>" + itemData.label + "</p>");
        $(".item-info-description").html(
            "<p><strong>Uses Remaining: </strong><span>" + "<a style=\"font-size:11px;color:#00CDF7\">" +
            itemData.info.uses + "</a>"
        );
```

# If you use qb-shops add the following to the Config.Products under ["hardware"] you may need to adjust the number of the table an slot to match your shops item amount
```lua
    [18] = {
        name = "coca_gascontainer",
        price = 500,
        amount = 100,
        info = {
            gasfilled = false
        },
        type = "item",
        slot = 18,
    },
    [19] = {
        name = "water_can",
        price = 500,
        amount = 50,
        info = {
            uses = 20 -- change to whatever you have set in the config for the Planting.WaterCanUses
        },
        type = "item",
        slot = 19,
    },
    [20] = {
        name = "fertilizer",
        price = 500,
        amount = 50,
        info = {},
        type = "item",
        slot = 20,
    },
```