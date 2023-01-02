local M = {}

local function lualib_installed(lib_name)
  local res, _ = pcall(require, lib_name)
  return res
end

local required_plugins = {
  {
    name = "sqlite",
    url = "[sqlite.lua](https://github.com/kkharji/sqlite.lua)",
  },
  {
    name = "plenary",
    url = "[plenary.nvim](https://github.com/nvim-lua/plenary.nvim)",
  },
  {
    name = "telescope",
    url = "[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)",
  },
}

local required_executables = {
  {
    name = "curl",
    url = "[curl](https://curl.se)",
  },
  {
    name = "jq",
    url = "[jq](https://stedolan.github.io/jq/)",
  },
  {
    name = "xmllint",
    url = "[xmllint](https://gnomes.pages.gitlab.gnome.org/libxml2/xmllint.html)",
  },
}

M.check = function()
  vim.fn["health#report_start"] "Checking for required plugins"

  for _, p in pairs(required_plugins) do
    if lualib_installed(p.name) then
      vim.fn["health#report_ok"](p.url .. " is installed.")
    else
      vim.fn["health#report_error"](p.url .. " not found.")
    end
  end

  vim.fn["health#report_start"] "Checking for required executables"
  for _, e in pairs(required_executables) do
    if vim.fn.executable(e.name) == 0 then
      vim.fn["health#report_error"](e.url .. " not found.")
    else
      local handle = io.popen(e.name .. " --version 2>&1")
      local result = handle:read "*a"
      handle:close()
      local version = vim.split(result, "\n")[1]
      vim.fn["health#report_ok"](e.url .. " is installed (" .. version .. ").")
    end
  end
end

return M
