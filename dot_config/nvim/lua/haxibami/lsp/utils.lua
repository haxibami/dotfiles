local merge_functions = require('haxibami.utils').merge_functions
local common_config = require('haxibami.lsp.config')

local M = {}

M.create_config = function(server_config)
  local config = vim.tbl_deep_extend('force', common_config, server_config)
  config.on_attach = merge_functions(common_config.on_attach, server_config.on_attach)

  return config
end


M.on_attach = function(fn)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      fn(client, buffer)
    end,
  })
end

return M
