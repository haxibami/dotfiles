-- neovim config

-- vars
local homedir = vim.env.HOME
local cachedir = homedir .. '/.cache/nvim'
local rtp = vim.opt.runtimepath

-- config

vim.opt.backupdir = cachedir
vim.opt.clipboard:prepend { 'unnamedplus' }
vim.opt.cmdheight = 2
vim.opt.directory = cachedir
vim.opt.expandtab = true
vim.opt.guifont = 'FirgeNerd Console:h12'
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.listchars = 'trail:~,extends:»,precedes:«,nbsp:%'
vim.opt.history = 10000
vim.opt.number = true
vim.opt.pumblend = 10
vim.opt.shiftwidth = 2
vim.opt.showcmd = true
vim.opt.signcolumn = 'number'
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.undodir = cachedir
vim.opt.updatetime = 250
vim.opt.wildmenu = true
vim.opt.winblend = 10

-- dein.vim setup
vim.cmd('filetype off')

-- vim.api.nvim_set_var('dein#auto_recache', 1)
vim.api.nvim_set_var('dein#lazy_rplugins', 1)
vim.api.nvim_set_var('dein#enable_notification', 1)
vim.api.nvim_set_var('dein#install_max_processes', 16)
vim.api.nvim_set_var('dein#install_message_type', 'none')

local dein_dir = homedir .. '/.cache/dein'
local dein_repo_dir = dein_dir .. '/repos/github.com/Shougo/dein.vim'

if not string.match(vim.o.runtimepath, '/dein.vim') then
  if vim.fn.isdirectory(dein_repo_dir) ~= 1 then
    os.execute('git clone https://github.com/Shougo/dein.vim ' .. dein_repo_dir)
  end
  rtp:append { '~/.cache/dein/repos/github.com/Shougo/dein.vim' }
end

if (vim.fn['dein#load_state'](dein_dir) == 1) then
  local dein_toml_dir = homedir .. '/.config/nvim'
  local dein_toml = dein_toml_dir .. '/dein.toml'
  local dein_toml_lazy = dein_toml_dir .. '/dein_lazy.toml'

  vim.fn['dein#begin'](dein_dir, { vim.fn.expand('<sfile>'), dein_toml, dein_toml_lazy })
  vim.fn['dein#load_toml'](dein_toml, { lazy = 0 })
  vim.fn['dein#load_toml'](dein_toml_lazy, { lazy = 1 })
  vim.fn['dein#end']()
  vim.fn['dein#save_state']()
end

if (vim.fn['dein#check_install']() == 1) then
  vim.fn['dein#install']()
end

vim.cmd('filetype on')

-- deinupdate pass
vim.api.nvim_create_user_command('DeinUpdate', function() return vim.fn['dein#check_update'](true) end, {})

-- plugin conf
-- not supported in lua
vim.cmd('colorscheme urara')

-- source files
require('config.filetype')

-- treesitter
require('plugin.tree-sitter')
