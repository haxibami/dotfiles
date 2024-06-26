-- lsp common keymaps

local utils = require('haxibami.lsp.utils')

utils.on_attach(function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '<space>D', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<space>d', function()
    vim.api.nvim_command('tab split')
    vim.lsp.buf.definition()
  end, bufopts)
  vim.keymap.set('n', '<space>h', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<space>i', function()
    vim.api.nvim_command('tab split')
    vim.lsp.buf.implementation()
  end, bufopts)
  vim.keymap.set('n', '<space>s', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>t', function()
    vim.api.nvim_command('tab split')
    vim.lsp.buf.type_definition()
  end, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>r', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
end)
