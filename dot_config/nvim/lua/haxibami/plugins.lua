local packpath = vim.env.HOME .. '/.local/share/nvim/site'
local packerdir = packpath .. '/pack/packer/start/packer.nvim'

-- plugin setup
if vim.fn.isdirectory(packerdir) ~= 1 then
  os.execute('git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. packerdir)
end

vim.cmd [[packadd packer.nvim]]

local packer_user_config = vim.api.nvim_create_augroup('packer_user_config', {
  clear = false
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = packer_user_config,
  pattern = 'plugins.lua',
  command = 'PackerCompile'
})

require('packer').startup({
  function(use)
    -- core
    use 'wbthomason/packer.nvim'

    use { 'haxibami/urara.vim' }

    use {
      'xiyaowong/nvim-transparent',
      config = function()
        require('transparent').setup({
          extra_groups = { -- table/string: additional groups that should be cleared
            -- In particular, when you set it to 'all', that means all available groups
            'all'
          },
          exclude_groups = {}, -- table: groups you don't want to clear
        })
      end
    }

    use 'cocopon/iceberg.vim'

    use {
      'itchyny/lightline.vim',
      after = 'nvim-navic',
      setup = function()
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
      end
    }

    --   use {
    --     'feline-nvim/feline.nvim',
    --     config = function()
    --       -- local statusbar = require 'config.plugin.feline.statusbar'
    --       -- local winbar = require 'config.plugin.feline.winbar'
    --       require('feline').setup({
    --         components = {
    --         }
    --       })
    --     end
    --   }

    use {
      'nvim-telescope/telescope.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>tf', function() return builtin.find_files() end, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>tg', function() return builtin.live_grep() end, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>tb', function() return builtin.buffers() end, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>th', function() return builtin.help_tags() end, { noremap = true, silent = true })
      end
    }

    use 'antoinemadec/FixCursorHold.nvim'

    use {
      'lilydjwg/fcitx.vim',
      setup = function()
        vim.g.fcitx5_remote = '/usr/bin/fcitx5-remote'
      end
    }

    use 'Yggdroot/indentLine'

    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      requires = { 'haringsrob/nvim_context_vt' }
    }

    use {
      'github/copilot.vim',
      setup = function()
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_assume_mapped = true
      end,
      config = function()
        -- vim.fn doesn't work
        vim.keymap.set('i', '<C-Right>', 'copilot#Accept("<CR>")',
          { silent = true, expr = true }
        )
      end
    }

    use {
      'NvChad/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup {
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
      end
    }

    use {
      'williamboman/mason.nvim'
    }

    use {
      'williamboman/mason-lspconfig.nvim'
    }

    use {
      'neovim/nvim-lspconfig'
    }

    use {
      'tamago324/nlsp-settings.nvim',
      config = function()
        require('nlspsettings').setup({
          config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
          local_settings_dir = '.nlsp-settings',
          local_settings_root_markers_fallback = { '.git' },
          append_default_schemas = true,
          loader = 'json'
        })
      end
    }

    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = { 'nvim-lua/plenary.nvim' }
    }

    use 'vim-denops/denops.vim'

    use {
      'Shougo/pum.vim',
      config = function()
        vim.fn['pum#set_option']({
          border = 'single',
          padding = true,
          highlight_matches = 'SpellBad'
        })
        vim.api.nvim_create_autocmd({ 'User' }, {
          pattern = 'PumCompleteDone',
          callback = function()
            vim.fn['vsnip_integ#on_complete_done'](vim.g['pum#completed_item'])
          end
        })
      end
    }

    use {
      'MunifTanjim/nui.nvim'
    }

    use {
      'rcarriga/nvim-notify',
      config = function()
        require('notify').setup({
          background_colour = '#000000'
        })
      end
    }

    use({
      'folke/noice.nvim',
      config = function()
        require('noice').setup({
          lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
              ['vim.lsp.util.stylize_markdown'] = true,
              ['cmp.entry.get_documentation'] = true,
            },
          },
          -- you can enable a preset for easier configuration
          presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            command_palette = true,       -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,       -- add a border to hover docs and signature help
          },
        })
      end,
      requires = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        'MunifTanjim/nui.nvim',
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        'rcarriga/nvim-notify',
      }
    })

    use {
      'Shougo/ddc.vim',
      requires = { 'denops.vim', 'pum.vim',
        {
          'matsui54/denops-popup-preview.vim',
          config = function()
            vim.fn['popup_preview#enable']()
          end
        },
        {
          'matsui54/denops-signature_help',
          setup = function()
            vim.g.signature_help_config = {
              style = 'virtual',
              border = true
            }
          end,
          config = function()
            vim.fn['signature_help#enable']()
            require('haxibami.ddc')
          end
        },
        'Shougo/ddc-ui-pum',
        'Shougo/ddc-nvim-lsp',
        'tani/ddc-fuzzy',
        'LumaKernel/ddc-file',
        'Shougo/ddc-around',
        'Shougo/ddc-cmdline',
        'Shougo/ddc-cmdline-history',
        'Shougo/ddc-omni',
      }
    }

    use {
      'Shougo/ddu.vim',
      requires = { 'denops.vim',
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
    }

    use {
      'hrsh7th/vim-vsnip',
      requires = { 'hrsh7th/vim-vsnip-integ', 'rafamadriz/friendly-snippets' },
    }

    use 'SmiteshP/nvim-navic'

    use {
      'j-hui/fidget.nvim',
      config = function()
        require('fidget').setup({
          window = {
            blend = 0,
          }
        })
      end
    }

    use {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup()
      end
    }

    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup({
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
        })
      end
    }

    use {
      'lambdalisue/fern.vim',
      requires = {
        'lambdalisue/fern-renderer-nerdfont.vim',
        'lambdalisue/nerdfont.vim',
        'lambdalisue/glyph-palette.vim',
      },
      setup = function()
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
    }

    -- languages

    --   use {
    --     'iamcco/markdown-preview.nvim',
    --     run = 'cd app && yarn install',
    --   }

    use {
      'kat0h/bufpreview.vim',
      requires = { 'denops.vim' },
      run = 'deno task prepare'
    }

    use 'mzlogin/vim-markdown-toc'

    use 'whonore/Coqtail'

    use 'simrat39/rust-tools.nvim'

    --     use {
    --       'jalvesaq/Nvim-R',
    --       branch = 'stable'
    --     }

    use {
      'lervag/vimtex',
      setup = function()
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
      end
    }

    -- use 'woodyZootopia/novel-preview.vim'
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  }
})
