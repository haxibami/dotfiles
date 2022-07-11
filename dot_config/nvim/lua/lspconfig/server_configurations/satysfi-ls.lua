local util = require 'lspconfig.util'

return {
  default_config = {
    cmd = { 'satysfi-language-server' },
    filetypes = { 'satysfi' },
    root_dir = util.root_pattern('.git'),
    single_file_support = true,
  },
  docs = {
    description = [[
      https://github.com/monaqa/satysfi-language-server
      Language server for SATySFi.
      ]],
    default_config = {
      root_dir = [[root_pattern(".git")]],
    },
  },
}
