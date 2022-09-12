-- null-ls setup

local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
  vim.notify('Error loading Null-LS')
  return
end

local config = require('haxibami.lsp.config')

null_ls.setup {
  sources = {
    -- use prettier
    null_ls.builtins.formatting.prettier.with {
      filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'css', 'scss', 'less',
        'html', 'yaml', 'markdown', 'graphql', 'handlebars' },
      condition = function(utils)
        return not (utils.has_file { 'deps.ts' })
      end,
      prefer_local = 'node_modules/.bin',
    },
    -- use markdownlint
    null_ls.builtins.diagnostics.markdownlint,

    null_ls.builtins.formatting.black,

    -- null_ls.builtins.formatting.clang_format,

  },
  capabilities = config.capabilities,
  on_attach = config.on_attach,
}
