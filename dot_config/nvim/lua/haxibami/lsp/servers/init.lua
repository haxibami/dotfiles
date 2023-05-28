local create_config = require('haxibami.lsp.utils').create_config

local root_pattern = require('lspconfig').util.root_pattern
local function no_formatting(client)
  client.server_capabilities.documentFormattingProvider = false
end

return {
  clangd = create_config(require('haxibami.lsp.servers.clangd')),
  lua_ls = create_config(require('haxibami.lsp.servers.lua')),
  denols = create_config(require('haxibami.lsp.servers.deno')),
  tsserver = create_config(require('haxibami.lsp.servers.ts')),
  r_language_server = create_config(require('haxibami.lsp.servers.r')),
}
