return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },

        config = function()
            require('telescope').setup{}
            require('telescope').load_extension('fzf')
            -- Ctrl-P fuzzy finding
            vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({}))<CR>', {noremap = true, nowait = true, silent = true})

            -- Ctrl-G fuzzy grepping
            vim.api.nvim_set_keymap('n', '<C-g>', '<cmd>lua require("telescope.builtin").live_grep(require("telescope.themes").get_dropdown({}))<CR>', {noremap = true, nowait = true, silent = true})
        end,
    },
}
