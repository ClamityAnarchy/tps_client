tps_client = {}
minetest.mod_channel_join("tps")

local hud, ping_hud

minetest.register_on_modchannel_message(function(channel_name, sender, message)
	if sender == "" and channel_name == "tps" and minetest.localplayer then
		tps_client.tps = tonumber(message)
		tps_client.ping = 0
		if hud then
			minetest.localplayer:hud_change(hud, "text", message)
		else
			hud = minetest.localplayer:hud_add({
				hud_elem_type = "text",
				position = {x = 1, y = 1},
				alignment = {x = -1, y = -1},
				offset = {x = -25, y = -25},
				text = message,
				number = 0xFFFFFF,
			})
			ping_hud = minetest.localplayer:hud_add({
				hud_elem_type = "text",
				position = {x = 1, y = 1},
				alignment = {x = -1, y = -1},
				offset = {x = -50, y = -25},
				text = "0",
				number = 0xFFF800,
			})
		end
	end
end)

minetest.register_globalstep(function(dtime)
	if tps_client.ping then
		tps_client.ping = tps_client.ping + dtime
		minetest.localplayer:hud_change(ping_hud, "text", tostring(math.floor(tps_client.ping * 1000)))
	end
end)
