local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local linker_rpc = require("linker_rpc")

return require("telescope").register_extension {
  exports = {
    insert_link = function(opts)
      opts = opts or {}

      pickers.new(opts, {
        prompt_title = "links",
        finder = finders.new_oneshot_job({ "rg", "--files" }, opts),
        sorter = conf.file_sorter(opts),
        previewer = conf.file_previewer(opts),
        attach_mappings = function(prompt_bufnr, _map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            P(selection[1])

            P("result start: ")
            local res = linker_rpc.run()
            P(res)
            P("result end: ")


            -- vim.api.nvim_put({ "'" .. selection[1] .. "'," }, "", false, true)
          end)
          return true
        end,
      }):find()
    end
  }
}
