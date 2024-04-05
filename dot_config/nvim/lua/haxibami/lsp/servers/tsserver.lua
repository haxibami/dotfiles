local root_pattern = require('lspconfig').util.root_pattern

local node_root_pattern = root_pattern('package.json')

return {
  root_dir = node_root_pattern,
  single_file_support = false,
  on_attach = function(client, bufnr)
    -- disable tsserver formatting if you plan on formatting via null-ls
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    --     local ts_utils = require 'nvim-lsp-ts-utils'
    --
    --     ts_utils.setup {
    --       debug = false,
    --       disable_commands = false,
    --       enable_import_on_completion = false,
    --
    --       -- import all
    --       import_all_timeout = 5000, -- ms
    --       import_all_priorities = {
    --         buffers = 4, -- loaded buffer names
    --         buffer_content = 3, -- loaded buffer content
    --         local_files = 2, -- git files or files with relative path markers
    --         same_file = 1, -- add to existing import statement
    --       },
    --       import_all_scan_buffers = 100,
    --       import_all_select_source = false,
    --
    --       -- eslint
    --       eslint_enable_code_actions = false,
    --       eslint_enable_disable_comments = false,
    --       eslint_enable_diagnostics = false,
    --
    --       -- update imports on file move
    --       update_imports_on_move = false,
    --       require_confirmation_on_move = false,
    --       watch_dir = nil,
    --
    --       -- filter diagnostics
    --       filter_out_diagnostics_by_severity = {},
    --       filter_out_diagnostics_by_code = {},
    --     }

    -- required to fix code action ranges and filter diagnostics
    -- ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    --     local opts = { silent = true }
    --     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', ':TSLspOrganize<CR>', opts)
    --     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', ':TSLspRenameFile<CR>', opts)
    --     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', ':TSLspImportAll<CR>', opts)
  end,
}
