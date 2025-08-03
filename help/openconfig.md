# Open Config Plugin

**Open Config** is a plugin that makes it easy to open and work with
configuration files located in micro's config directory, such as
`settings.json`, `bindings.json`, and `init.lua`.

## Features

This plugin provides convenient commands for accessing micro's config files
and managing the working directory:

- `opensettings` - Open `settings.json`
- `openbindings` - Open `bindings.json`
- `openinitlua` - Open `init.lua`
- `cdconfig` - Change the current working directory to micro's config
  directory
- `cdreturn` - Return to the previous working directory
- `showconfigpath` - Show the config directory path in the InfoBar

These files are typically located in your micro config directory:
`~/.config/micro/` or platform-specific equivalent.

## Usage

### `open*` commands

Use the following commands to quickly open config files:

```
opensettings
openbindings
openinitlua
```

No key bindings are assigned by default.

### `cdconfig` and `cdreturn`

Use `cdconfig` to change the current working directory to micro’s config
directory.  
This affects commands such as:

- `> pwd`
- `> open` (file path completion)

```
cdconfig
```

To return to the previously cached directory, use:

```
cdreturn
```

### `showconfigpath`

Displays the path to micro's config directory in the InfoBar.

Helpful when you need to copy or inspect the path.

```
showconfigpath
```
