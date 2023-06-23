local M = {}

local binary_path = vim.fn.fnamemodify(
  vim.api.nvim_get_runtime_file("lua/linker_rpc.lua", false)[1], ":h:h") ..
"zettelkasten-linker/target/debug/zettelkasten-linker"

if vim.fn.executable(binary_path) == 0 then
  binary_path = vim.fn.fnamemodify(
        vim.api.nvim_get_runtime_file("lua/linker_rpc.lua", false)[1], ":h:h")
      .. "zettelkasten-linker/target/release/zettelkasten-linker"
end

binary_path = "/Users/daniel.zinger/.vim/plugged/telescope-links-picker.nvim/zettelkasten-linker/target/release/zettelkasten-linker"
M.binary_path = binary_path

local function start()
  if M.job_id ~= nil then return end
  P("M.binary_path start")
  P(M.binary_path)
  P("M.binary_path end")
  M.job_id = vim.fn.jobstart({ M.binary_path }, { rpc = true })
end


local function notify(method, ...)
  start()
  P(M.job_id)
  local res = vim.rpcrequest(M.job_id, "add")
  -- local res = vim.rpcrequest(M.job_id, method, ...)
  P("Add res: ")
  P(res)
  P("Add res end")
end

function M.run()
  notify('add', 1, 2)
end

return M
