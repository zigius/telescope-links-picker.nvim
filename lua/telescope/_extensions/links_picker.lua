local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values

return require("telescope").register_extension {
  exports = {
    insert_link = function(opts)
      opts = opts or {}

      pickers.new(opts, {
          prompt_title = "links",
          finder = finders.find_files,
          sorter = conf.generic_sorter(opts),
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              vim.api.nvim_put({ "[[" .. "test text" .. "]]" }, "", false, true)
            end)
            return true
          end,
      }):find()
    end
  }
}
