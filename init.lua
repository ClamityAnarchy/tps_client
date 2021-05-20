minetest.mod_channel_join("tps")

tps_client={}
tps_client.tps=0

local hud

minetest.register_on_modchannel_message(function(channel_name, sender, message)
	if sender == "" and channel_name == "tps" and minetest.localplayer then
		tps_client.tps=message
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
		end
	end
end)
