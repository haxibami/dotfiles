local merge_functions = require('haxibami.utils').merge_functions
local common_config = require('haxibami.lsp.config')

local M = {}

M.create_config = function(server_config)
  local config = vim.tbl_deep_extend('force', common_config, server_config)
  config.on_attach = merge_functions(common_config.on_attach, server_config.on_attach)

  return config
end

return M
