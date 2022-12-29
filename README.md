# SAPI Preview for Neovim

A [Neovim](https://neovim.io/) plugin to browse SAPI feeds directly in the editor.

## Features

- Uses remote routes.json file to get all data
- Cache packages and endpoints in sqlite database for faster lookups
- Quickly access recent URLs 
- Switch between backend base URLs 
- Package selector to quickly switch between packages 
- Select from URLs which match the URN under the cursor 

## Requirements

- [sqlite.lua](https://github.com/kkharji/sqlite.lua) (required)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (required)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) (required)
- [jq](https://stedolan.github.io/jq/) (required)
- [xmllint](https://gnomes.pages.gitlab.gnome.org/libxml2/xmllint.html) (required)
- [curl](https://curl.se) (required)

## Installation

### [Packer.nvim](https://github.com/wbthomason/packer.nvim) 

```lua
use {
  "tlj/sapi-preview.nvim",
  {
    "kkharji/sqlite.lua",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  }
}
```

An environment variable is required to set the base urls, as they should be left out of repositories commited to github.

```bash
$ export SAPI_PREVIEW_URLS="https://url1.example;https://url2.example"
```

## Usage

Select a base url from the list defined in SAPI_PREVIEW_URLS. This will be used in subsequent lookups.
```vim
:SapiBaseUrl
```

Select a package to use when using the endpoints selector.
```vim
:SapiPackage
```

Select from a list of endpoints valid for the package. If an endpoint has a placeholder, the user will be prompted to enter a value.
```vim
:SapiEndpoints
```

Select from a list of recently used endpoints. The endpoint is not remembered by base url, so it can be used to quickly open the same endpoint across different base urls.
```vim
:SapiRecents
```

Look up current package endpoints with a placeholder with requirements matching the text the cursor is currently on.
```vim
:SapiGoto
```

Refresh the list of endpoints from the server (clear cache).
```vim
:SapiRefresh
```

### Suggested mappings

```vim
require('sapi-preview').setup()
vim.keymap.set('n', '<leader>sg', '<cmd>SapiGoto<cr>', {})
vim.keymap.set('n', '<leader>sr', '<cmd>SapiRecents<cr>', {})
vim.keymap.set('n', '<leader>se', '<cmd>SapiEndpoints<cr>', {})
vim.keymap.set('n', '<leader>su', '<cmd>SapiRefresh<cr>', {})
vim.keymap.set('n', '<leader>sp', '<cmd>SapiPackage<cr>', {})
vim.keymap.set('n', '<leader>sb', '<cmd>SapiBaseUrl<cr>', {})
```

### Database location

The default location for the sqlite3 database is `$XDG_DATA_HOME/nvim' (eq '~/.local/share/nvim/databases' on linux and MacOS).



