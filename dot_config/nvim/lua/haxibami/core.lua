-- vars
local homedir = vim.env.HOME
local cachedir = homedir .. '/.cache/nvim'

-- base
vim.opt.backupdir = cachedir
vim.opt.clipboard:prepend { 'unnamedplus' }
vim.opt.cmdheight = 2
vim.opt.directory = cachedir
vim.opt.expandtab = true
vim.opt.guifont = 'FirgeNerd Console:h12'
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.laststatus = 2
-- vim.opt.list = true
-- vim.opt.listchars = 'trail:~,extends:»,precedes:«,nbsp:%'
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
vim.opt.list = false

-- configuration relying on plugins
vim.cmd('colorscheme urara')
