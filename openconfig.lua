VERSION = "0.0.2"

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

function OpenSettingsCmd(bp)
	openFile(bp, "settings.json")
end

function OpenBindingsCmd(bp)
	openFile(bp, "bindings.json")
end

function OpenInitLuaCmd(bp)
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

function CdConfigCmd(bp)
	local current = getCurrentDir()
	if current and lastDir == nil then
		lastDir = current
	end

	local path = config.ConfigDir
	bp:CdCmd({ path })
	micro.InfoBar():Message("Changed directory to " .. path)
end

function CdReturnCmd(bp)
	if lastDir then
		bp:CdCmd({ lastDir })
		micro.InfoBar():Message("Returned to: " .. lastDir)
		lastDir = nil
	else
		micro.InfoBar():Error("No previous directory cached.")
	end
end

function ShowConfigPathCmd(bp)
	local path = config.ConfigDir
	micro.InfoBar():Message("Config Path: " .. path)
end

function init()
	config.MakeCommand("opensettings", OpenSettingsCmd, config.NoComplete)
	config.MakeCommand("openbindings", OpenBindingsCmd, config.NoComplete)
	config.MakeCommand("openinitlua", OpenInitLuaCmd, config.NoComplete)
	config.MakeCommand("cdconfig", CdConfigCmd, config.NoComplete)
	config.MakeCommand("cdreturn", CdReturnCmd, config.NoComplete)
	config.MakeCommand("showconfigpath", ShowConfigPathCmd, config.NoComplete)
	config.AddRuntimeFile("openconfig", config.RTHelp, "help/openconfig.md")
end
