local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.typst = {
  install_info = {
    url = 'https://github.com/SeniorMars/tree-sitter-typst', -- local path or git repo
    files = { 'src/parser.c', 'src/scanner.c' },             -- note that some parsers also require src/scanner.c or src/scanner.cc
    branch = 'main',                                         -- optional, default is 'master'
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = 'typst', -- if filetype does not match the parser name
}

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  },
  ensure_installed = {
    'bash',
    'c',
    'css',
    'go',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'latex',
    'lua',
    'nix',
    'ocaml',
    'python',
    'r',
    'rust',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
}
