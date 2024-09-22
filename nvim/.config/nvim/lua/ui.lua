local M = {}

M.floating_window_options = {
  winblend = 10,
}

--- Sets common options on a floating window
--- @param window_id integer
function M.set_float_options(window_id)
  for option, value in pairs(M.floating_window_options) do
    vim.wo[window_id][option] = value
  end
end

return M
