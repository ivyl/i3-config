require 'string'
require 'lfs'

local function starts_with(str, start)
   return string.sub(str, 1, string.len(start)) == start
end

function conky_cpu_temp()
	local k10temp = conky_parse("${hwmon k10temp temp 1}")
	if k10temp ~= "" then
		return k10temp
	else
		return conky_parse("${hwmon coretemp temp 1}")
	end
end

function conky_network_type()
	local gw = conky_parse("${gw_iface}")

	if starts_with(gw, "en") then
		return " " .. gw
	elseif starts_with(gw, "wl") then
		local strength = tonumber(conky_parse("${wireless_link_qual_perc " .. gw .. " }"))
		return " ${wireless_essid " .. gw .. "} ".. strength .. "%"
	end
	return "⚠ " .. gw
end

SYSCLASSNET = ""
WGS = ""

function conky_vpn()
	local str = ""
	local current_interfaces = ""
	local wg_interfaces = ""

	for interface in lfs.dir("/sys/class/net") do
		current_interfaces =  current_interfaces .. interface
	end

	if current_interfaces ~= SYSCLASSNET then
		SYSCLASSNET = current_interfaces

		local handle = io.popen("wg show interfaces")
		if handle ~= nil then
			wg_interfaces = handle:read("*a")
			handle:close()
		end

		for wg in wg_interfaces:gmatch("%S+") do
			str = str .. '{"color":"#859900", "full_text": "  ' .. wg .. ' "},'
		end
		WGS = str
	end

	return WGS
end

function local_battery_icon(percent)
	if percent > 80 then
		return ""
	elseif percent > 60 then
		return ""
	elseif percent > 40 then
		return ""
	elseif percent > 15 then
		return ""
	else
		return ""
	end
end

function conky_battery_icon()
	return local_battery_icon(tonumber(conky_parse("$battery_percent")))
end

function conky_audio_icon()
	local port_desc = conky_parse("$pa_sink_active_port_description")
	if port_desc == "Headset" then
		return " "
	elseif port_desc == "Headphones" or port_desc == "Analog Output" then
		return ""
	elseif port_desc == "Speaker" then
		return ""
	end
	return conky_parse("$pa_sink_active_port_description")
end
