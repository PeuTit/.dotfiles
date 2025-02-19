local M = {}

function M.map(mode, lhs, rhs, opts)
  local default_opts = { noremap = true, silent = true }

  if opts then
    vim.keymap.set(mode, lhs, rhs, opts)
  else
    vim.keymap.set(mode, lhs, rhs, default_opts)
  end
end

return M
