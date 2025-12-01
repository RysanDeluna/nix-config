-- Autocompletion
--
--

require("blink.cmp").setup({
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
})
