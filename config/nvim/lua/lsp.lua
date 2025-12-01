-- LSPs, the config was created mainly reading the docs for each lsp

-- Enabling all
vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })
vim.lsp.enable({'nixd', 'lua_ls'})
