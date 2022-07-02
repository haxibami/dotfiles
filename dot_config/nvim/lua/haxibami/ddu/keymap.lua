local util = require('haxibami.ddu.utils')
local ddu = {
  do_action = vim.fn['ddu#ui#ff#do_action'],
}

M = {}

M.ddu_ff_enter = function()
  -- set keymaps
  local bufopts = { noremap = true, silent = true, buffer = 0 }
  vim.keymap.set('n', '<CR>', function() return ddu.do_action('itemAction') end, bufopts)
  vim.keymap.set('n', '<space>', function() return ddu.do_action('toggleSelectItem') end, bufopts)
  vim.keymap.set('n', 'i', function() return ddu.do_action('openFilterWindow') end, bufopts)
  vim.keymap.set('n', '/', function() return ddu.do_action('openFilterWindow') end, bufopts)
  vim.keymap.set('n', 'p', function() return ddu.do_action('preview') end, bufopts)
  vim.keymap.set('n', 'c', function() return ddu.do_action('chooseAction') end, bufopts)
  vim.keymap.set('n', 'e', function() return ddu.do_action('itemAction', { name = 'edit' }) end, bufopts)
  vim.keymap.set('n', 'd', function() return ddu.do_action('itemAction', { name = 'delete' }) end, bufopts)
  vim.keymap.set('n', '<Esc>', function() return M.ddu_ff_exit() end, bufopts)
  vim.keymap.set('n', 'q', function() return M.ddu_ff_exit() end, bufopts)

  vim.cmd [[hi! link NormalFloat Normal]]
end

M.ddu_ff_exit = function()
  ddu.do_action('quit')
  vim.cmd [[hi! link NormalFloat Pmenu]]
end

M.ddu_ff_filter_enter = function()
  -- set keymaps
  local bufopts = { noremap = true, silent = true, buffer = 0 }
  vim.keymap.set('i', '<CR>', '<Esc><Cmd>call ddu#ui#ff#close()<CR>', bufopts)
  vim.keymap.set('i', '<Esc>', function() return vim.fn['ddu#ui#ff#close']() and M.ddu_ff_exit() end, bufopts)
  vim.keymap.set('i', '<Tab>', function() return vim.fn['ddu#ui#ff#execute']('call cursor(line(\".\")+1,0)') end, bufopts)
  vim.keymap.set('i', '<Down>', function() return vim.fn['ddu#ui#ff#execute']('call cursor(line(\".\")+1,0)') end,
    bufopts)
  vim.keymap.set('i', '<S-Tab>', function() return vim.fn['ddu#ui#ff#execute']('call cursor(line(\".\")-1,0)') end,
    bufopts)
  vim.keymap.set('i', '<Up>', function() return vim.fn['ddu#ui#ff#execute']('call cursor(line(\".\")-1,0)') end, bufopts)
  vim.keymap.set('n', '<Esc>', function() return function()
      vim.fn['ddu#ui#ff#close']()
      M.ddu_ff_exit()
    end
  end, bufopts)
  vim.keymap.set('n', 'q', function() return function()
      vim.fn['ddu#ui#ff#close']()
      M.ddu_ff_exit()
    end
  end, bufopts)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'ddu-ff' },
  callback = function() return M.ddu_ff_enter() end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'ddu-ff-filter' },
  callback = function() return M.ddu_ff_filter_enter() end,
})

vim.keymap.set('n', '<leader>ff', function() return util.find_files() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fg', function() return util.live_grep() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb', function() return util.buffers() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fh', function() return util.help_tags() end, { noremap = true, silent = true })
