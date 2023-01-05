local conf = require("endpoint-previewer.config")
local db = require("endpoint-previewer.db")
local endpoints = require("endpoint-previewer.endpoints")

local M = {}

M.select_api = function(opts)
  opts = opts or {}

  local packages = endpoints.get_api_names()

  require("telescope.pickers").new(opts, {
    prompt_title = "Select a package (" .. conf.options.base_url .. ")",
    finder = require("telescope.finders").new_table {
      results = packages,
    },
    sorter = require("telescope.config").values.generic_sorter(opts),
    attach_mappings = function(fbuf)
      require("telescope.actions").select_default:replace(function()
        require("telescope.actions").close(fbuf)
        local selection = require("telescope.actions.state").get_selected_entry()
        if not selection then
          require("telescope.utils").__warn_no_selection "builtin.builtin"
          return
        end

        conf.set_endpoints({})

        print("Setting package " .. selection[1])
        conf.set_package(selection[1])
        db.set_default("package", conf.options.package)
      end)
      return true
    end
  }):find()
end


return M