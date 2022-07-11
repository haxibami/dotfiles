-- lsp installation & setup

local installer_status, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not installer_status then
  vim.notify('Error loading LSP-Installer')
  return
end

local server_configs = require('haxibami.lsp.servers')
local utils = require('haxibami.lsp.utils')

local servers = {
  'awk_ls',
  'bashls',
  'ccls',
  'cssls',
  'cssmodules_ls',
  'denols',
  'eslint',
  'gopls',
  'hls',
  'html',
  'jsonls',
  'lemminx',
  'ocamllsp',
  'pyright',
  'r_language_server',
  'rust_analyzer',
  'sumneko_lua',
  'taplo',
  'texlab',
  'tsserver',
  'vimls',
  'yamlls',
}

local options = {
  automatic_installation = true,
  ensure_installed = servers
}

lsp_installer.setup(options)

for _, server in ipairs(lsp_installer.get_installed_servers()) do
  local setup_fn = server_configs[server.name] or utils.default_setup
  setup_fn(server)
end

require('lspconfig')['satysfi-ls'].setup {
  autostart = true
}
