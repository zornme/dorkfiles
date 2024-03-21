return {
    {
        "RRethy/base16-nvim",
        lazy = false, -- make sure we load this during startup because it is my main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd('set termguicolors')
            vim.cmd('colorscheme base16-tomorrow-night-eighties')
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require('lualine').setup()
        end,
    }
}
