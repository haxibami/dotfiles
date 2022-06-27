local lspconfig = require('lspconfig')

local lsp_installer = require('nvim-lsp-installer')

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<space>h', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>d', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local node_root_dir = lspconfig.util.root_pattern('package.json', 'node_modules')
local buf_name = vim.api.nvim_buf_get_name(0)
local current_buf = vim.api.nvim_get_current_buf()
local is_node_repo = node_root_dir(buf_name, current_buf) ~= nil

-- lsp server setup
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

  local opts = {}
  opts.on_attach = on_attach
  opts.capabilities = capabilities

  -- per server configurations
  if server.name == 'ccls' then
    opts.init_options = {
      compilationDatabaseDirectory = 'build';
      index = {
        threads = 0;
      };
      clang = {
        excludeArgs = { '-frounding-math' };
      };
    };
    opts.offset_encoding = 'utf-8';
  end

  if server.name == 'sumneko_lua' then
    opts.settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
        },
        format = {
          enable = true,
          -- Put format options here
          -- NOTE: the value should be STRING!!
          defaultConfig = {
            indent_style = 'space',
            indent_size = '2',
            quote_style = 'single',
          }
        },
      }
    }
  end

  if server.name == 'tsserver' or server.name == 'eslint' then
    opts.autostart = is_node_repo
  elseif server.name == 'denols' then
    opts.autostart = not (is_node_repo)
    opts.init_options = { lint = true, unstable = true, }
  end

  lspconfig[server.name].setup(opts)
  -- vim.cmd [[ do User LspAttachBuffers ]]

end

local null_ls = require('null-ls')
null_ls.setup {
  sources = {
    -- use prettier
    null_ls.builtins.formatting.prettier.with {
      condition = function(utils)
        return utils.has_file { '.prettierrc', '.prettierrc.js' }
      end,
      prefer_local = 'node_modules/.bin',
    },
    -- use markdownlint
    null_ls.builtins.diagnostics.markdownlint,
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

vim.diagnostic.config({
  update_in_insert = true,
  -- virtual_text = false,
})

vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd InsertEnter * lua vim.diagnostic.config({virtual_text = false})]]
vim.cmd [[autocmd InsertLeave * lua vim.diagnostic.config({virtual_text = true})]]

local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end
