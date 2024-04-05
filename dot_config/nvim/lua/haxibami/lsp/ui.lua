-- lsp status viewer
-- require('fidget').setup {
--   text = {
--     spinner = 'dots',
--   },
--   window = {
--     blend = 0,
--   }
-- }

-- signs
local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn',  text = '' },
  { name = 'DiagnosticSignHint',  text = '' },
  { name = 'DiagnosticSignInfo',  text = '' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

-- local icons = {
--   Text          = ' ',
--   Method        = ' ',
--   Function      = 'ƒ ',
--   Constructor   = ' ',
--   Field         = ' ',
--   Variable      = ' ',
--   Class         = ' ',
--   Interface     = ' ',
--   Module        = ' ',
--   Property      = ' ',
--   Unit          = ' ',
--   Value         = ' ',
--   Enum          = ' ',
--   Keyword       = ' ',
--   Snippet       = ' ',
--   Color         = ' ',
--   File          = ' ',
--   Reference     = ' ',
--   Folder        = ' ',
--   EnumMember    = ' ',
--   Constant      = ' ',
--   Struct        = ' ',
--   Event         = ' ',
--   Operator      = ' ',
--   TypeParameter = ' ',
-- }
--
-- local kinds = vim.lsp.protocol.CompletionItemKind
--
-- for i, kind in ipairs(kinds) do
--   vim.lsp.protocol.CompletionItemKind[i] = icons[kind] or kind
-- end
--
-- local hoge = {
--   '', ' ', ' ', '', 'ﴲ', '[]', '', 'ﰮ', '', '襁', '', '', '練', '', '', '',
--   '', '', '', '', 'ﲀ', 'ﳤ', '', '', ''
-- }
