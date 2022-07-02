-- utils

local M = {}

--- @vararg function|nil
M.merge_functions = function(...)
  local fns = { ... }
  return function(...)
    for _, fn in ipairs(fns) do
      if fn ~= nil then
        fn(...)
      end
    end
  end
end

return M
