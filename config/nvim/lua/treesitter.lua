-- Highlight, edit, and navigate code
require'nvim-treesitter.configs'.setup {
    opts = {
	ensure_installed = {},
	auto_install = false,
    },
    highlight = {
        enable = true,
    },
}
