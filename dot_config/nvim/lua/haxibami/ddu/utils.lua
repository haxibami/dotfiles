local ddu = {
  start = vim.fn['ddu#start'];
}

M = {}

M.find_files = function()
  ddu.start({
    sources = {
      { name = 'file_rec' },
    },
  })
end

M.live_grep = function()
  ddu.start({
    volatile = true,
    sources = {
      { name = 'rg',
        -- options = { matchers = {} }
      },
    },
  })
end

M.buffers = function()
  ddu.start({
    sources = {
      { name = 'buffer' },
    },
  })
end

M.help_tags = function()
  ddu.start({
    sources = {
      { name = 'help' },
    },
  })
end

return M
