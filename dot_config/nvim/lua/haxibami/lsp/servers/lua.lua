return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        -- optsake the server aware of Neovim runtime files
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
      }
    }
  }
}
