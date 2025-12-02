--
--
--

require("which-key").setup({
    spec = {
        { '<leader>s', group = '[S]earch'},
        { '<leader>t', group = '[T]oggle'},
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    }
})
