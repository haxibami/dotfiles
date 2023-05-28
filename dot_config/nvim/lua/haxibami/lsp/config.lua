local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

capabilities.textDocument.foldingRange = {
  dynamicRegistration = true, -- ?
  lineFoldingOnly = true,
}

return {
  on_attach = function(client, bufnr)
    --     if client.server_capabilities.documentSymbolProvider then
    --       require('nvim-navic').attach(client, bufnr)
    --     end
    -- Enable omnifunc
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<space>D', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<space>d', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<space>h', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<space>i', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>t', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)

    vim.api.nvim_create_autocmd('CursorHold', {
      pattern = '*',
      callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
      end
    })

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function()
        vim.lsp.buf.format()
      end
    })

    vim.api.nvim_create_autocmd('InsertEnter', {
      pattern = '*',
      callback = function()
        vim.diagnostic.config({ virtual_text = false })
      end
    })

    vim.api.nvim_create_autocmd('InsertLeave', {
      pattern = '*',
      callback = function()
        vim.diagnostic.config({ virtual_text = true })
      end
    })
  end,
  capabilities = capabilities,
  handlers = {
    ['textDocument/hover'] = function(_, result, ctx, config)
      local util = require 'vim.lsp.util'
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
