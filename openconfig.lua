VERSION = "0.0.0"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")

local function openFile(bp, filename)
	local path = config.ConfigDir .. "/" .. filename
	local buf, err = buffer.NewBufferFromFile(path)

	if err ~= nil then
		micro.InfoBar():Error("Failed to open: " .. err)
		return
	end

	bp:OpenBuffer(buf)
end

function openSettings(bp)
	openFile(bp, "settings.json")
end

function openBindings(bp)
	openFile(bp, "bindings.json")
end

function openInitLua(bp)
	openFile(bp, "init.lua")
end

function init()
	config.MakeCommand("opensettings", openSettings, config.NoComplete)
	config.MakeCommand("openbindings", openBindings, config.NoComplete)
	config.MakeCommand("openinitlua", openInitLua, config.NoComplete)
	config.AddRuntimeFile("openconfig", config.RTHelp, "help/openconfig.md")
end
