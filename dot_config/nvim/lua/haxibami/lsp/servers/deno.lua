local root_pattern = require('lspconfig').util.root_pattern

local deno_root_pattern = root_pattern('deno.json', 'deps.ts')

return {
  root_dir = deno_root_pattern,
  settings = {
    enable = true,
    lint = true,
    unstable = true,
  },
}
