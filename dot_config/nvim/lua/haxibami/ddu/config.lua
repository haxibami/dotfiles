local ddu = {
  patch_global = vim.fn['ddu#custom#patch_global'];
  alias = vim.fn['ddu#custom#alias'];
}

ddu.alias('source', 'directory_rec', 'file_external')

local lines = vim.o.lines - 6
local winh = math.floor(lines * 0.8)
local houter = math.floor((lines - winh) / 2)
local wouter = math.floor(vim.o.columns * 0.05)
local inner = 3
local winw = math.floor((vim.o.columns - wouter * 2 - inner) / 2)

ddu.patch_global({
  ui = 'ff',
  uiParams = {
    ff = {
      displaySourceName = 'short',
      prompt = '>',
      reversed = true,
      split = 'floating',
      floatingBorder = 'rounded',
      previewFloating = true,
      previewFloatingBorder = 'rounded',
      filterSplitDirection = 'floating',
      winRow = houter,
      winCol = wouter,
      winHeight = winh,
      winWidth = winw,
      previewRow = 0,
      previewCol = wouter + winw + inner,
      previewHeight = winh,
      previewWidth = winw,
      startFilter = true,
      autoAction = {
        name = 'preview'
      },
    }
  },
  kindOptions = {
    file = {
      defaultAction = 'open',
    }
  },
  sourceOptions = {
    ['_'] = {
      matchers = { 'matcher_fzf' },
      ignoreCase = true,
    },
    command_history = {
      defaultAction = 'execute'
    },
    help = {
      defaultAction = 'open',
    }
  },
  filterParams = {
    matcher_fzf = {
      highlightMatched = 'Constant'
    }
  },
  sourceParams = {
    file_external = {
      cmd = { 'fd', '.', '-H', '-E', '__pycache__', '-t', 'f' },
    },
    rg = {
      args = { '--column', '--no-heading', '--color', 'never', '--json' }
    },
    directory_rec = {
      cmd = { 'fd', '.', '-H', '-t', '-d' }
    }
  },
})

vim.api.nvim_create_autocmd('VimResized', {
  callback = function()

    local lines = vim.o.lines - 6
    local winh = math.floor(lines * 0.8)
    local houter = math.floor((lines - winh) / 2)
    local wouter = math.floor(vim.o.columns * 0.05)
    local inner = 3
    local winw = math.floor((vim.o.columns - wouter * 2 - inner) / 2)

    vim.fn['ddu#custom#patch_global']('uiParams', {
      ff = {
        winRow = houter,
        winCol = wouter,
        winHeight = winh,
        winWidth = winw,
        previewRow = 0,
        previewCol = wouter + winw + inner,
        previewHeight = winh,
        previewWidth = winw,
      }
    })
  end
})
