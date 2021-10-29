require 'string'
require 'lfs'

local function starts_with(str, start)
   return string.sub(str, 1, string.len(start)) == start
end

function conky_network_type ()
	local gw = conky_parse ("${gw_iface}")
	-- local gw = "wlo"
	if starts_with(gw, "en") then
		return " " .. gw
	elseif starts_with(gw, "wl") then
		return "  ${wireless_essid} " .. gw
	end
	return " ⚠ " .. gw
end

function conky_vpn ()
	str = ""
	for file in lfs.dir[[/sys/class/net/]] do
		if string.match(file, "mullvad") or file == "cw" then
			str = str .. '{"color":"#859900", "full_text": "  ' .. file .. ' "},'
		end
	end

	return str
end
