-- null-ls setup

local none_ls_status_ok, none_ls = pcall(require, 'null-ls')
if not none_ls_status_ok then
  vim.notify('Error loading Null-LS')
  return
end

local config = require('haxibami.lsp.config')

none_ls.setup {
  sources = {
    none_ls.builtins.formatting.biome.with({
      condition = function(utils)
        return not (utils.root_has_file { 'deps.ts', 'deno.json' } or utils.root_has_file_matches('.?prettier*'))
      end,
      filetypes = {
        'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      prefer_local = 'node_modules/.bin',
    }),

    none_ls.builtins.formatting.prettierd.with({
      filetypes = { 'yaml' },
    }),

    none_ls.builtins.formatting.prettierd.with({
      condition = function(utils)
        return utils.root_has_file_matches('.?prettier*')
      end,
      filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
    }),

    --     none_ls.builtins.formatting.dprint.with({
    --       filetypes = { 'markdown', 'markdown.mdx' },
    --     }),

    none_ls.builtins.diagnostics.markdownlint.with({
      filetypes = { 'markdown' },
    }),

    --     none_ls.builtins.formatting.ruff,

    -- none_ls.builtins.formatting.clang_format,

  },
  capabilities = config.capabilities,
  on_attach = config.on_attach,
}
