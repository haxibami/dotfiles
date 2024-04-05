-- lsp installation & setup

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
local create_config = require('haxibami.lsp.utils').create_config

-- local servers = {
--   'astro',
--   'awk_ls',
--   'bashls',
--   'clangd',
--   'cmake',
--   'cssls',
--   'cssmodules_ls',
--   -- 'denols',
--   'dockerls',
--   'dotls',
--   'eslint',
--   'gopls',
--   'hls',
--   'html',
--   'jsonls',
--   'lemminx',
--   'lua_ls',
--   'nil_ls',
--   'ocamllsp',
--   'pylyzer',
--   'r_language_server',
--   'ruff',
--   'rust_analyzer',
--   'taplo',
--   'texlab',
--   'tsserver',
--   'typst_lsp',
--   'vimls',
--   'yamlls',
-- }

local server_file = vim.split(vim.fn.glob(vim.fn.stdpath('config') .. '/lua/haxibami/lsp/servers/*.lua'), '\n')

local handlers = function()
  local setup_fn = {
    function(server_name)
      lspconfig[server_name].setup(common_config)
    end,
  }

  for _, server in ipairs(server_file) do
    local server_name = server:match('^.*/(.*)%.lua$')
    setup_fn[server_name] = function()
      local server_config = create_config(require('haxibami.lsp.servers.' .. server_name))
      lspconfig[server_name].setup(server_config)
    end
  end

  return setup_fn
end

masonlspconfig.setup_handlers(handlers())

lspconfig['satysfi-ls'].setup {
  autostart = true
}
