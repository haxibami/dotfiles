require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    disable = {
    }
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
