local root_pattern = require('lspconfig').util.root_pattern

local deno_root_pattern = root_pattern('deno.json')

return {
  root_dir = deno_root_pattern,
  init_options = {
    enable = true,
    lint = false,
    unstable = true,
  },
}
