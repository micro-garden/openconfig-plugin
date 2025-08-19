VERSION = "0.0.3"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local os = import("os")

local function openFile(bp, filename)
	local path = config.ConfigDir .. "/" .. filename
	local buf, err = buffer.NewBufferFromFile(path)

	if err ~= nil then
		micro.InfoBar():Error("Failed to open: " .. err)
		return
	end

	bp:OpenBuffer(buf)
end

function OpenSettings(bp)
	openFile(bp, "settings.json")
end

function OpenBindings(bp)
	openFile(bp, "bindings.json")
end

function OpenInitLua(bp)
	openFile(bp, "init.lua")
end

local function getCurrentDir()
	local wd, err = os.Getwd()
	if err ~= nil then
		micro.InfoBar:Error("Getwd failed")
		return nil
	else
		return wd
	end
end

local lastDir = nil

function CdConfig(bp)
	local current = getCurrentDir()
	if current and lastDir == nil then
		lastDir = current
	end

	local path = config.ConfigDir
	bp:CdCmd({ path })
	micro.InfoBar():Message("Changed directory to " .. path)
end

function CdReturn(bp)
	if lastDir then
		bp:CdCmd({ lastDir })
		micro.InfoBar():Message("Returned to: " .. lastDir)
		lastDir = nil
	else
		micro.InfoBar():Error("No previous directory cached.")
	end
end

function ShowConfigPath(bp)
	local path = config.ConfigDir
	micro.InfoBar():Message("Config Path: " .. path)
end

function init()
	config.MakeCommand("opensettings", OpenSettings, config.NoComplete)
	config.MakeCommand("openbindings", OpenBindings, config.NoComplete)
	config.MakeCommand("openinitlua", OpenInitLua, config.NoComplete)
	config.MakeCommand("cdconfig", CdConfig, config.NoComplete)
	config.MakeCommand("cdreturn", CdReturn, config.NoComplete)
	config.MakeCommand("showconfigpath", ShowConfigPath, config.NoComplete)
	config.AddRuntimeFile("openconfig", config.RTHelp, "help/openconfig.md")
end
