local create_setup = require('haxibami.lsp.utils').create_setup

local root_pattern = require('lspconfig').util.root_pattern
local function no_formatting(client)
  client.server_capabilities.documentFormattingProvider = false
end

return {
  ccls = create_setup(require('haxibami.lsp.servers.ccls')),
  sumneko_lua = create_setup(require('haxibami.lsp.servers.lua')),
  denols = create_setup(require('haxibami.lsp.servers.deno')),
  tsserver = create_setup(require('haxibami.lsp.servers.ts')),
}
