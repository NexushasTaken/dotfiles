local M = {}

-- Load a plugin
M.rtp_exist = function(mod)
  local rtp = vim.opt.runtimepath._value
  if rtp:match(mod) then
    return true
  end
  return false
end

return M
