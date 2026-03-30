--
--
--
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "nixfmt" },
		python = { "black" },
	},
	format_on_save = {
		lsp_format = "fallback ",
	},
})
