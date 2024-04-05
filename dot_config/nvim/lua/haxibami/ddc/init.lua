-- ddc config

local ddc = {
  patch_buffer = vim.fn['ddc#custom#patch_buffer'],
  set_buffer = vim.fn['ddc#custom#set_buffer'],
  get_buffer = vim.fn['ddc#custom#get_buffer'],
  load_config = vim.fn['ddc#custom#load_config'],
}

ddc.load_config(vim.fn.stdpath('config') .. '/lua/haxibami/ddc/config.ts')

vim.fn['ddc#enable']()

-- key binding
local function pum_insert(key, line)
  return function()
    if (vim.fn['pum#visible']() == true) then
      vim.fn['pum#map#insert_relative'](line)
      return ''
    end
    return key
  end
end

vim.keymap.set('i', '<Tab>',
  function()
    if vim.fn['pum#visible']() == true then
      vim.fn['pum#map#insert_relative'](1)
      return ''
      --     elseif (vim.fn['vsnip#available'](1) == 1) then
      --       return '<Plug>(vsnip-expand-or-jump)'
    end
    local col = vim.fn.col '.'
    if col <= 1 or vim.fn.getline('.'):sub(col - 1):match '%s' then
      local key = vim.api.nvim_replace_termcodes('<Tab>', true, false, true)
      return vim.api.nvim_feedkeys(key, 'n', true)
    else
      vim.fn['ddc#map#manual_complete']()
      return ''
    end
  end
  , { noremap = true, expr = false });

vim.keymap.set('i', '<S-Tab>', function()
  if (vim.fn['pum#visible']() == true) then
    vim.fn['pum#map#insert_relative'](-1)
    return ''
    --   elseif (vim.fn['vsnip#jumpable'](-1) == 1) then
    --     return '<Plug>(vsnip-jump-prev)'
  end
  local key = vim.api.nvim_replace_termcodes('<S-Tab>', true, false, true)
  return vim.api.nvim_feedkeys(key, 'n', true)
end
, { noremap = true, expr = false });

vim.keymap.set('i', '<C-k>', function()
  if (vim.fn['pum#visible']() == true) then
    vim.fn['pum#map#confirm']()
    return ''
  else
    local key = vim.api.nvim_replace_termcodes('<C-k>', true, false, true)
    return vim.api.nvim_feedkeys(key, 'n', true)
  end
end, { noremap = true, expr = false })

---- vim.keymap.set('i', '<Esc>', function()
----   if (vim.fn['pum#visible']() == true) then
----     vim.fn['pum#map#cancel']()
----     return ''
----   else
----     return '<Esc>'
----   end
---- end, { noremap = true, expr = false })

local prev_buffer_config

local cmdlinepost = function()
  vim.keymap.del('c', '<Tab>', { buffer = 0 })
  vim.keymap.del('c', '<S-Tab>', { buffer = 0 })
  -- restore sources
  if (prev_buffer_config ~= nil) then
    ddc.set_buffer(prev_buffer_config)
    prev_buffer_config = nil
    --   else
    --     ddc.set_buffer(vim.empty_dict())
  end
end

local cmdlinepre = function(mode)
  vim.keymap.set('c', '<Tab>', function()
    if (vim.fn['pum#visible']() == true) then
      vim.fn['pum#map#insert_relative'](1)
      return ''
    elseif (vim.b.ddc_cmdline_completion ~= nil) then
      vim.fn['ddc#map#manual_complete']()
      return ''
    end
  end
  , { noremap = true, expr = true, buffer = 0 });
  vim.keymap.set('c', '<S-Tab>', pum_insert('<S-Tab>', -1), { noremap = true, buffer = 0, expr = true });

  if (prev_buffer_config == nil) then
    prev_buffer_config = vim.fn['ddc#custom#get_buffer']()
  end
  if mode == ':' then
    --     ddc.patch_buffer('cmdlineSources', {
    --       'cmdline',
    --       'cmdline-history',
    --       'around',
    --       'file',
    --     })
    -- ddc.patch_buffer('keywordPattern', '[0-9a-zA-Z_:#]*')
    ddc.patch_buffer('filterParams', {
      matcher_fuzzy = {
        splitMode = 'word'
      }
    })
    ddc.patch_buffer('sourceOptions', {
      cmdline = {
        forceCompletionPattern = [[[\w@:~._-]/[\w@:~._-]*]],
        keywordPattern = [[[\w@:~._-]*]],
      }
    })
  else
    --     ddc.patch_buffer('cmdlineSources', { 'around' })
    ddc.patch_buffer('filterParams', {
      matcher_fuzzy = {
        splitMode = 'character'
      }
    })
    ddc.patch_buffer('sourceOptions', {
      around = {
        minAutoCompleteLength = 1,
      }
    })
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

-- vim.keymap.set('s', '<Tab>', function()
--   if (vim.fn['vsnip#available'](1) == 1) then
--     return '<Plug>(vsnip-expand-or-jump)'
--   else
--     return '<Tab>'
--   end
-- end, { noremap = true, expr = true });
--
-- vim.keymap.set('s', '<S-Tab>', function()
--   if (vim.fn['vsnip#jumpable'](-1) == 1) then
--     return '<Plug>(vsnip-jump-prev)'
--   else
--     return '<S-Tab>'
--   end
-- end, { noremap = true, expr = true });
