-- Autocompletion
--
--

require("blink.cmp").setup({
    fuzzy = {
        implementation = "lua",
        prebuilt_binaries = {
            download = false
        },
    },
    sources = {
        default = { 'lsp', 'path',  'buffer' },
    },
    keymap = {
        preset = "default",
        ['<Tab>'] = { 'select_and_accept', 'fallback' }
    },
    completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
        list = {
            selection = {
                preselect = false
            }
        }
    },
    signature = { enabled = true },
})
