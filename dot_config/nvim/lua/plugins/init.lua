return {

  -- core
  --   {
  --     'haxibami/urara.vim',
  --     lazy = false,
  --     priority = 1000,
  --     config = function()
  --       vim.cmd([[colorscheme urara]])
  --     end,
  --   },


  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      overrides = function(colors)
        return {
          -- update kanagawa to handle new treesitter highlight captures
          ['@string.regexp'] = { link = '@string.regex' },
          ['@variable.parameter'] = { link = '@parameter' },
          ['@exception'] = { link = '@exception' },
          ['@string.special.symbol'] = { link = '@symbol' },
          ['@markup.strong'] = { link = '@text.strong' },
          ['@markup.italic'] = { link = '@text.emphasis' },
          ['@markup.heading'] = { link = '@text.title' },
          ['@markup.raw'] = { link = '@text.literal' },
          ['@markup.quote'] = { link = '@text.quote' },
          ['@markup.math'] = { link = '@text.math' },
          ['@markup.environment'] = { link = '@text.environment' },
          ['@markup.environment.name'] = { link = '@text.environment.name' },
          ['@markup.link.url'] = { link = 'Special' },
          ['@markup.link.label'] = { link = 'Identifier' },
          ['@comment.note'] = { link = '@text.note' },
          ['@comment.warning'] = { link = '@text.warning' },
          ['@comment.danger'] = { link = '@text.danger' },
          ['@diff.plus'] = { link = '@text.diff.add' },
          ['@diff.minus'] = { link = '@text.diff.delete' },
        }
      end,
    },
    config = function()
      vim.cmd([[colorscheme kanagawa-dragon]])
    end,
  },

  -- 'cocopon/iceberg.vim',

  {
    'xiyaowong/transparent.nvim',
    opts = {
      extra_groups = { -- table/string: additional groups that should be cleared
        -- In particular, when you set it to 'all', that means all available groups
        'all',
      },
      exclude_groups = {}, -- table: groups you don't want to clear
    },
  },

  {
    'itchyny/lightline.vim',
    dependencies = { 'SmiteshP/nvim-navic', 'haxibami/urara.vim' },
    init = function()
      vim.g.lightline = {
        colorscheme = 'urara',
        active = {
          left = {
            { 'mode', 'paste' }, { 'readonly', 'filename', 'modified' }
          },
          right = {
            { 'lineinfo' }, { 'percent' }, { 'fileformat', 'filetype' }
          }
        },
      }
    end,
    lazy = false,
    priority = 1000,
  },

  {
    'folke/neodev.nvim',
    opts = {}
  },

  {
    'nvim-telescope/telescope.nvim',
    keys = {
      { '<leader>tf',
        function()
          require('telescope.builtin').find_files()
        end,
        { noremap = true, silent = true }
      },
      { '<leader>tg',
        function()
          require('telescope.builtin').live_grep()
        end,
        { noremap = true, silent = true }
      },
      { '<leader>tb',
        function()
          require('telescope.builtin').buffers()
        end,
        { noremap = true, silent = true }
      },
      { '<leader>th',
        function()
          require('telescope.builtin').help_tags()
        end,
        { noremap = true, silent = true }
      },
    },
  },

  { 'nvim-lua/plenary.nvim', lazy = true },

  {
    'nvim-telescope/telescope-file-browser.nvim',
  },

  'antoinemadec/FixCursorHold.nvim',

  {
    'h-hg/fcitx.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' }
  },

  {
    'Yggdroot/indentLine',
    config = function() vim.g.indentLine_conceallevel = 0 end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldenable = false
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    init = function()
      -- PERF: no need to load the plugin, if we only need its queries for mini.ai
      local plugin = require('lazy.core.config').spec.plugins['nvim-treesitter']
      local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
      local enabled = false
      if opts.textobjects then
        for _, mod in ipairs({ 'move', 'select', 'swap', 'lsp_interop' }) do
          if opts.textobjects[mod] and opts.textobjects[mod].enable then
            enabled = true
            break
          end
        end
      end
      if not enabled then
        require('lazy.core.loader').disable_rtp_plugin('nvim-treesitter-textobjects')
      end
    end,
  },

  {
    'zbirenbaum/copilot.lua',
    lazy = false,
    -- cmd = 'Copilot',
    build = ':Copilot auth',
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = '<C-Right>',
          dismiss = '<C-left>'
        }
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
        -- typst = false
      },
    },
  },

  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      filetypes = { '*' },
      user_default_options = {
        RGB      = true,         -- #RGB hex codes
        RRGGBB   = true,         -- #RRGGBB hex codes
        names    = true,         -- "Name" codes like Blue oe blue
        RRGGBBAA = true,         -- #RRGGBBAA hex codes
        rgb_fn   = true,         -- CSS rgb() and rgba() functions
        hsl_fn   = true,         -- CSS hsl() and hsla() functions
        mode     = 'background', -- Set the display mode.
      },
      buftypes = {}
    }
  },

  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {}
  },

  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      automatic_installation = true,
      ensure_installed = {
        -- 'astro',
        'awk_ls',
        'bashls',
        'clangd',
        'cmake',
        'cssls',
        'cssmodules_ls',
        -- 'denols',
        'dockerls',
        'dotls',
        'eslint',
        'gopls',
        'hls',
        'html',
        'jsonls',
        'lemminx',
        'lua_ls',
        'nil_ls',
        'ocamllsp',
        -- 'pylyzer',
        'r_language_server',
        'ruff_lsp',
        'rust_analyzer',
        'taplo',
        'texlab',
        'tsserver',
        'typst_lsp',
        'vimls',
        'yamlls',
      }
    }
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = 'folke/neodev.nvim',
    config = function()
      require('haxibami.lsp')
    end,
  },

  {
    'tamago324/nlsp-settings.nvim',
    opts = {
      config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
      local_settings_dir = '.nlsp-settings',
      local_settings_root_markers_fallback = { '.git' },
      append_default_schemas = true,
      loader = 'json'
    }
  },

  {
    'nvimtools/none-ls.nvim',
    config = function()
      require('haxibami.lsp.null-ls')
    end,
  },

  { 'vim-denops/denops.vim', lazy = true },

  {
    'matsui54/denops-popup-preview.vim',
    config = function()
      vim.fn['popup_preview#enable']()
    end,
    dependencies = { 'vim-denops/denops.vim' }
  },
  {
    'matsui54/denops-signature_help',
    init = function()
      vim.g.signature_help_config = {
        winblend = 10,
      }
    end,
    config = function()
      vim.fn['signature_help#enable']()
    end,
    dependencies = { 'vim-denops/denops.vim', 'ddc.vim' }
  },

  {
    'Shougo/pum.vim',
    config = function()
      vim.fn['pum#set_option']({
        border = 'single',
        padding = true,
        highlight_matches = 'SpellBad',
      })
      --       vim.api.nvim_create_autocmd({ 'User' }, {
      --         pattern = 'PumCompleteDone',
      --         callback = function()
      --           vim.fn['vsnip_integ#on_complete_done'](vim.g['pum#completed_item'])
      --         end
      --       })
    end
  },

  'MunifTanjim/nui.nvim',

  {
    'rcarriga/nvim-notify',
    keys = {
      {
        '<leader>un',
        function()
          require('notify').dismiss({ silent = true, pending = true })
        end,
        desc = 'Dismiss all Notifications',
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      background_colour = '#000000',
    },
  },

  {
    'folke/noice.nvim',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
        progress = {
          enabled = true,
          format = {
            '{data.progress.message} ',
            '({data.progress.percentage}%) ',
            { '{spinner} ',              hl_group = 'NoiceLspProgressSpinner' },
            { '{data.progress.title} ',  hl_group = 'NoiceLspProgressTitle' },
            { '{data.progress.client} ', hl_group = 'NoiceLspProgressClient' },
          },
        }
      },
      views = {
        mini = {
          win_options = {
            winblend = 0
          }
        }
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
    }
  },

  {
    'Shougo/ddc.vim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
      require('haxibami.ddc')
    end,
    dependencies = {
      'Shougo/pum.vim',
      'Shougo/ddc-ui-pum',
      'Shougo/ddc-source-lsp',
      'tani/ddc-fuzzy',
      'LumaKernel/ddc-file',
      'Shougo/ddc-around',
      'Shougo/ddc-cmdline',
      'Shougo/ddc-cmdline-history',
      'Shougo/ddc-omni',
    }
  },

  {
    'Shougo/ddu.vim',
    dependencies = {
      'Shougo/ddu-ui-ff',
      -- 'Shougo/ddu-ui-filer',
      'Shougo/ddu-commands.vim',
      'Shougo/ddu-kind-file',
      'shun/ddu-source-buffer',
      'matsui54/ddu-source-command_history',
      'matsui54/ddu-source-file_external',
      'Shougo/ddu-source-file',
      'Shougo/ddu-source-file_old',
      'Shougo/ddu-source-file_rec',
      'matsui54/ddu-source-help',
      'shun/ddu-source-rg',
      'yuki-yano/ddu-filter-fzf',
      'Shougo/ddu-filter-matcher_substring',
    },
  },

  --   {
  --     'hrsh7th/vim-vsnip',
  --     dependencies = { 'hrsh7th/vim-vsnip-integ', 'rafamadriz/friendly-snippets' },
  --   },

  --  {
  --    'j-hui/fidget.nvim',
  --    tag = 'legacy',
  --    opts = {
  --      text = {
  --        spinner = 'dots',
  --      },
  --      window = {
  --        blend = 0,
  --        relative = 'win',
  --        zindex = 100
  --      },
  --      fmt = {
  --        max_messages = 2,
  --      }
  --    },
  --  },

  --   {
  --     'linrongbin16/lsp-progress.nvim',
  --     event = { 'VimEnter' },
  --     dependencies = { 'nvim-tree/nvim-web-devicons' },
  --     --     config = function()
  --     --       require('lsp-progress').setup()
  --     --     end
  --   },

  {
    'windwp/nvim-autopairs',
    opts = {}
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add          = { hl = 'GitAddSign', text = '│', numhl = 'GitAddSign', linehl = 'GitAddSign' },
        change       = { hl = 'GitChangeSign', text = '│', numhl = 'GitChangeSign', linehl = 'GitChangeSign' },
        delete       = { hl = 'GitDeleteSign', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitDeleteSign' },
        topdelete    = { hl = 'GitDeleteSign', text = '‾', numhl = 'GitDeleteSign', linehl = 'GitDeleteSign' },
        changedelete = {
          hl = 'GitChangeDeleteSignSign',
          text = '~',
          numhl = 'GitChangeDeleteSign',
          linehl = 'GitChangeDeleteSign'
        },
      },
    }
  },

  {
    'lambdalisue/fern.vim',
    dependencies = {
      'lambdalisue/fern-renderer-nerdfont.vim',
      'lambdalisue/nerdfont.vim',
      'lambdalisue/glyph-palette.vim',
    },
    init = function()
      vim.keymap.set('n', '<C-E>', ':Fern . -reveal=% -drawer -toggle -width=40<CR>',
        { noremap = true }
      )
    end,
    config = function()
      vim.g['fern#default_hidden'] = 1
      vim.g['fern#renderer'] = 'nerdfont'
      local my_glyph_palette = vim.api.nvim_create_augroup('my-glyph-palette', {
        clear = false
      })
      vim.api.nvim_create_autocmd('FileType', {
        group = my_glyph_palette,
        pattern = { 'fern', 'nerdtree', 'startify' },
        callback = function()
          vim.fn['glyph_palette#apply']()
        end
      })
    end
  },

  -- languages

  {
    'kat0h/bufpreview.vim',
    dependencies = { 'vim-denops/denops.vim' },
    build = 'deno task prepare',
    ft = { 'markdown' },
  },

  'mzlogin/vim-markdown-toc',

  {
    'whonore/Coqtail',
    ft = { 'coq' },
  },

  {
    'simrat39/rust-tools.nvim',
    ft = { 'rust' },
  },

  --     {
  --       'jalvesaq/Nvim-R',
  --       branch = 'stable'
  --     },

  {
    'lervag/vimtex',
    init = function()
      -- viewer & synctex
      vim.g.vimtex_view_general_viewer = 'zathura'
      vim.g.vimtex_view_general_options = '-x \"nvr +%{line} %{input}\" --synctex-forward @line:0:@tex @pdf'
      vim.g.vimtex_compiler_progname = 'nvr'
      -- compiler
      vim.g.vimtex_compiler_latexmk = {
        build_dir = 'latexbuild'
      }
      vim.g.vimtex_compiler_latexmk_engines = { _ = 'lualatex' }
      vim.g.latex_latexmk_options = '-pdflua'
      -- syntax highlighting
      vim.g.vimtex_syntax_conceal_disable = 1
      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        cites = 0,
        fancy = 1,
        greek = 1,
        ['math_bounds'] = 0,
        ['math_delimiters'] = 1,
        ['math_fracs'] = 1,
        ['math_super_sub'] = 1,
        ['math_symbols'] = 1,
        ['sections'] = 0,
        ['styles'] = 0
      }
    end,
    ft = { 'tex' },
  },

  { 'kaarmu/typst.vim', ft = { 'typst' } },
  -- 'woodyZootopia/novel-preview.vim'
}
