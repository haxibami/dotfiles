require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  ensure_installed = {
    'astro',
    'awk',
    'bash',
    'bibtex',
    'c',
    'css',
    'git_config',
    'gitcommit',
    'gitignore',
    'go',
    'html',
    'ini',
    'javascript',
    'jsdoc',
    'json',
    'jsonc',
    'latex',
    'lua',
    'markdown',
    'markdown_inline',
    'nix',
    'ocaml',
    'python',
    'r',
    'rust',
    'scss',
    'ssh_config',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'xml',
    'yaml',
    'zathurarc',
  },

})

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.typst = {
  install_info = {
    -- url = 'https://github.com/frozolotl/tree-sitter-typst',
    url = 'https://github.com/uben0/tree-sitter-typst',
    files = { 'src/parser.c', 'src/scanner.c' },
    -- branch = 'master',                                        -- optional, default is 'master'
    generate_requires_npm = true,
    -- requires_generate_from_grammar = false,
  },
  filetype = 'typst', -- if filetype does not match the parser name
}
