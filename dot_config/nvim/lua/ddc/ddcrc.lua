-- ddc config

local ddc = {
  patch_global = vim.fn['ddc#custom#patch_global'];
  patch_buffer = vim.fn['ddc#custom#patch_buffer'];
  set_buffer = vim.fn['ddc#custom#set_buffer'];
}

ddc.patch_global('completionMenu', 'pum.vim')
ddc.patch_global('sources', {
  'nvim-lsp',
  'around',
  'file',
})

ddc.patch_global('sourceOptions', {
  _ = {
    matchers = { 'matcher_fuzzy' },
    sorters = { 'sorter_fuzzy' },
    converters = { 'converter_fuzzy' },
  },
  ['nvim-lsp'] = {
    mark = '',
    forceCompletionPattern = [[\.\w*|:\w*|->\w*]]
  },
  around = {
    mark = ''
  },
  file = {
    mark = '',
    isVolatile = true,
    forceCompletionPattern = [[\S/\S*]]
  }
})
-- Use Customized labels
ddc.patch_global('sourceParams', {
  ['nvim-lsp'] = {
    kindLabels = { Class = 'c' }
  },
  file = {
    disableMenu = true,
    displayFile = '',
    displayDir = '',
    displaySym = '',
    displayCwd = '',
    displayBuf = ' '
  }
})
ddc.patch_global('autoCompleteEvents', {
  'InsertEnter', 'TextChangedI', 'TextChangedP',
  'CmdlineEnter', 'CmdlineChanged',
})
vim.fn['ddc#enable']()

-- key binding
local function pum_insert(key, line)
  return function()
    if (vim.fn['pum#visible']() == 1) then
      vim.fn['pum#map#insert_relative'](line)
      return ''
    end
    return key
  end
end

vim.keymap.set('i', '<Tab>',
  function()
    if vim.fn['pum#visible']() == 1 then
      vim.fn['pum#map#insert_relative'](1)
      return ''
    end
    local col = vim.fn.col '.'
    if col <= 1 or vim.fn.getline('.'):sub(col - 1):match '%s' then
      return '<Tab>'
    else
      vim.fn['ddc#manual_complete']()
      return ''
    end
  end
  , { noremap = true, expr = true });

vim.keymap.set('i', '<S-Tab>', pum_insert('<S-Tab>', -1), { noremap = true, expr = true });

-- vim.keymap.set('i', '<Enter>', function()
--   if (vim.fn['pum#visible']() == 1) then
--     vim.fn['pum#map#confirm']()
--     return ''
--   else
--     return '<Enter>'
--   end
-- end, { noremap = true, expr = true })

-- vim.keymap.set('i', '<Esc>', function()
--   if (vim.fn['pum#visible']() == 1) then
--     vim.fn['pum#map#cancel']()
--     return ''
--   else
--     return '<Esc>'
--   end
-- end, { noremap = true, expr = true })

local prev_buffer_config

local cmdlinepost = function()
  vim.keymap.del('c', '<Tab>', { buffer = 0 })
  vim.keymap.del('c', '<S-Tab>', { buffer = 0 })
  -- restore sources
  if (prev_buffer_config ~= nil) then
    ddc.set_buffer(prev_buffer_config)
    prev_buffer_config = nil
  else
    ddc.set_buffer({})
  end
  vim.opt.wildcharm = ('<Tab>'):byte()
end

local cmdlinepre = function(mode)
  vim.opt.wildchar = ('<C-t>'):byte()
  vim.opt.wildcharm = ('<C-t>'):byte()
  vim.keymap.set('c', '<Tab>', function()
    if (vim.fn['pum#visible']() == 1) then
      vim.fn['pum#map#insert_relative'](1)
      return ''
    elseif (vim.b.ddc_cmdline_completion ~= nil) then
      vim.fn['ddc#manual_complete']()
      return ''
    else
      return [[\<C-t>]]
    end
  end
    , { noremap = true, expr = true, buffer = 0 });
  vim.keymap.set('c', '<S-Tab>', pum_insert('<S-Tab>', -1), { noremap = true, buffer = 0, expr = true });

  if (prev_buffer_config == nil) then
    prev_buffer_config = vim.fn['ddc#custom#get_buffer']()
  end
  ddc.patch_buffer('completionMenu', 'pum.vim')
  if mode == ':' then
    ddc.patch_buffer('cmdlineSources', {
      'cmdline',
      'cmdline-history',
      'around'
    })
    ddc.patch_buffer('keywordPattern', '[0-9a-zA-Z_:#]*')
  else
    ddc.patch_buffer('cmdlineSources', { 'around' })
  end

  vim.api.nvim_create_autocmd({ 'User' }, {
    pattern = { 'DDCCmdlineLeave' },
    callback = function() return cmdlinepost end,
    once = true,
  })

  vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
    buffer = 0,
    callback = function() return cmdlinepost end,
    once = true,
  })
  vim.fn['ddc#enable_cmdline_completion']()

  return mode
end

-- cmd remapping
vim.keymap.set('n', ':', function() return cmdlinepre(':') end, { expr = true });
vim.keymap.set('n', '/', function() return cmdlinepre('/') end, { expr = true });
vim.keymap.set('n', '?', function() return cmdlinepre('?') end, { expr = true });
