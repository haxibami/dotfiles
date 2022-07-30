local create_config = require('haxibami.lsp.utils').create_config

local root_pattern = require('lspconfig').util.root_pattern
local function no_formatting(client)
  client.server_capabilities.documentFormattingProvider = false
end

return {
  sumneko_lua = create_config(require('haxibami.lsp.servers.lua')),
  denols = create_config(require('haxibami.lsp.servers.deno')),
  tsserver = create_config(require('haxibami.lsp.servers.ts')),
}
