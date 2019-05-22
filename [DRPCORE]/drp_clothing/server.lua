models = {}
RegisterServerEvent("clothes:firstspawn")
AddEventHandler("clothes:firstspawn",function()
	local source = source
	local identifier = getID("license",source)
	print(identifier)
	if models[identifier] then
		TriggerClientEvent("clothes:spawn", source, models[identifier])
	else
		local default_models = {1413662315,-781039234,1077785853,2021631368,1423699487,1068876755,2120901815,-106498753,131961260,-1806291497,1641152947,115168927,330231874,-1444213182,1809430156,1822107721,2064532783,-573920724,-782401935,808859815,-1106743555,-1606864033,1004114196,532905404,1699403886,-1656894598,1674107025,-88831029,-1244692252,951767867,1388848350,1090617681,379310561,-569505431,-1332260293,-840346158}
		models[identifier] = {
			model = default_models[math.random(1,tonumber(#default_models))],
			new = true,
			clothing = {drawables = {0,0,0,0,0,0,0,0,0,0,0,0},textures = {2,0,1,1,0,0,0,0,0,0,0,0},palette = {0,0,0,0,0,0,0,0,0,0,0,0}},
			props = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1}, textures = {-1,-1,-1,-1,-1,-1,-1,-1}},
			overlays = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}, opacity = {1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}, colours = {{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0}}},
		}
		saveModels()
		TriggerClientEvent("clothes:spawn", source, models[identifier])
	end
end)

RegisterServerEvent("DRP_Clothing:FirstSpawn")
AddEventHandler("DRP_Clothing:FirstSpawn", function()
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)

	exports["externalsql"]:DBAsyncQuery({
		string = "SELECT * FROM `character_clothing` WHERE `char_id` = :charid",
		data = {
			charid = character.charid
		}
	}, function(results)
		if json.encode(results["data"]) ~= "[]" then
			local clothing_drawables = json.decode(results["data"][1].clothing_drawables)
			local clothing_textures = json.decode(results["data"][1].clothing_textures)
			local clothing_palette = json.decode(results["data"][1].clothing_palette)
			local props_drawables = json.decode(results["data"][1].props_drawables)
			local props_textures = json.decode(results["data"][1].props_textures)
			local overlays_drawables = json.decode(results["data"][1].overlays_drawables)
			local overlays_opacity = json.decode(results["data"][1].overlays_opacity)
			local overlays_colours = json.decode(results["data"][1].overlays_colours)
			
			TriggerClientEvent("clothes:spawn", src, {cdrawables = clothing_drawables, cpalette = clothing_palette, ctextures = clothing_textures, pdrawables = props_drawables, ptextures = props_textures, odrawables = overlays_drawables, oopacity = overlays_opacity, ocolours = overlays_colours})
		else
			local default_models = {1413662315,-781039234,1077785853,2021631368,1423699487,1068876755,2120901815,-106498753,131961260,-1806291497,1641152947,115168927,330231874,-1444213182,1809430156,1822107721,2064532783,-573920724,-782401935,808859815,-1106743555,-1606864033,1004114196,532905404,1699403886,-1656894598,1674107025,-88831029,-1244692252,951767867,1388848350,1090617681,379310561,-569505431,-1332260293,-840346158}
			local randomModel = default_models[math.random(1,tonumber(#default_models))]
			clothing = {drawables = {0,0,0,0,0,0,0,0,0,0,0,0}, textures = {2,0,1,1,0,0,0,0,0,0,0,0}, palette = {0,0,0,0,0,0,0,0,0,0,0,0}}
			props = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1}, textures = {-1,-1,-1,-1,-1,-1,-1,-1}}
			overlays = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}, opacity = {1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}, colours = {{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0}}}
			exports["externalsql"]:DBAsyncQuery({
				string = "INSERT INTO `character_clothing` SET `model` = :model, `clothing_drawables` = :clothing_drawables, `clothing_textures` = :clothing_textures, `clothing_palette` = :clothing_palette, `props_drawables` = :props_drawables, `props_textures` = :props_textures, `overlays_drawables` = :overlays_drawables, `overlays_opacity` = :overlays_opacity, `overlays_colours` = :overlays_colours, `char_id` = :charid",
				data = {
					model = randomModel,
					clothing_drawables = json.encode(clothing.drawables),
					clothing_textures = json.encode(clothing.textures),
					clothing_palette = json.encode(clothing.palette),
					props_drawables = json.encode(props.drawables),
					props_textures = json.encode(props.textures),
					overlays_drawables = json.encode(overlays.drawables),
					overlays_opacity = json.encode(overlays.opacity),
					overlays_colours = json.encode(overlays.colours),
					charid = character.charid
				}
			}, function(yeet)
			end)
		end
	end)
end)

RegisterServerEvent("clothes:spawn")
AddEventHandler("clothes:spawn",function()
	local source = source
	local identifier = getID("license",source)
	TriggerClientEvent("clothes:spawn", source, models[identifier])
end)

RegisterServerEvent("clothes:loaded")
AddEventHandler("clothes:loaded",function()
	-- Give weapons etc
end)

RegisterServerEvent("clothes:save")
AddEventHandler("clothes:save",function(player_data)
	local src = source
	local character = exports["drp_id"]:GetCharacterData(src)
	exports["externalsql"]:DBAsyncQuery({
		string = "UPDATE character_clothing SET `model` = :model, `clothing_drawables` = :clothing_drawables, `clothing_textures` = :clothing_textures, `clothing_palette` = :clothing_palette, `props_drawables` = :props_drawables, `props_textures` = :props_textures, `overlays_drawables` = :overlays_drawables, `overlays_opacity` = :overlays_opacity WHERE `char_id` = :charid",
		data = {
			model = player_data.model,
			clothing_drawables = json.encode(player_data.cdrawables),
			clothing_textures = json.encode(player_data.ctextures),
			clothing_palette = json.encode(player_data.cpalette),
			props_drawables = json.encode(player_data.pdrawables),
			props_textures = json.encode(player_data.ptextures),
			overlays_drawables = json.encode(player_data.odrawables),
			overlays_opacity = json.encode(player_data.oopacity),
			-- overlays_colours = json.encode(player_data.ocolours),
			charid = character.charid
		}
	}, function(results)
	end)
end)