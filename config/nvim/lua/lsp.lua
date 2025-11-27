-- LSPs, the config was created mainly reading the docs for each lsp

-- Enabling all
vim.lsp.config('*', { capabilities = require('cmp_nvim_lsp').default_capabilities() })
vim.lsp.enable({'nixd', 'lua_ls'})
