-- lsp common config

-- client capabilities

local capabilities = require('ddc_source_lsp').make_client_capabilities()

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.preselectSupport = true
-- capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
-- capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
-- capabilities.textDocument.completion.completionItem.deprecatedSupport = true
-- capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
-- capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     'documentation',
--     'detail',
--     'additionalTextEdits',
--   }
-- }
--
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = true,
--   lineFoldingOnly = true,
-- }

return {
  capabilities = capabilities,

  handlers = {
    ['textDocument/hover'] = function(_, result, ctx, config)
      local util = require('vim.lsp.util')
      config = config or {}
      config.focus_id = ctx.method
      if not (result and result.contents) then
        return
      end
      local markdown_lines = util.convert_input_to_markdown_lines(result.contents)
      markdown_lines = util.trim_empty_lines(markdown_lines)
      if vim.tbl_isempty(markdown_lines) then
        return
      end
      return util.open_floating_preview(markdown_lines, 'markdown', { border = 'rounded' })
    end,
  },
}
