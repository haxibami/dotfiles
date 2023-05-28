-- lsp installation & setup

local installer_status, mason = pcall(require, 'mason')
if not installer_status then
  vim.notify('Error loading mason LSP-Installer')
  return
end

local masonlspconfig_status, masonlspconfig = pcall(require, 'mason-lspconfig')
if not masonlspconfig_status then
  vim.notify('Error loading mason-lspconfig')
  return
end

local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status then
  vim.notify('Error loading lspconfig')
  return
end

local common_config = require('haxibami.lsp.config')
local server_configs = require('haxibami.lsp.servers')
local utils = require('haxibami.lsp.utils')

local servers = {
  'awk_ls',
  'astro',
  'bashls',
  'clangd',
  'cmake',
  'cssls',
  'cssmodules_ls',
  -- 'denols',
  'dockerls',
  'dotls',
  'eslint',
  'gopls',
  'hls',
  'html',
  'jsonls',
  'lemminx',
  'nil_ls',
  'ocamllsp',
  'pyright',
  'r_language_server',
  'rust_analyzer',
  'lua_ls',
  'taplo',
  'texlab',
  'tsserver',
  'vimls',
  'yamlls',
}

local masonlspconfig_options = {
  automatic_installation = true,
  ensure_installed = servers
}

mason.setup({})

masonlspconfig.setup(masonlspconfig_options)

masonlspconfig.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup(common_config)
  end,
  -- Next, you can provide targeted overrides for specific servers.
  --   ['rust_analyzer'] = function()
  --     require('rust-tools').setup {}
  --   end,

  ['clangd'] = function()
    lspconfig.clangd.setup(server_configs.clangd)
  end,
  ['denols'] = function()
    lspconfig.denols.setup(server_configs.denols)
  end,
  ['lua_ls'] = function()
    lspconfig.lua_ls.setup(server_configs.lua_ls)
  end,
  ['tsserver'] = function()
    lspconfig.tsserver.setup(server_configs.tsserver)
  end,
  ['r_language_server'] = function()
    lspconfig.r_language_server.setup(server_configs.r_language_server)
  end,
})

lspconfig['satysfi-ls'].setup {
  autostart = true
}
