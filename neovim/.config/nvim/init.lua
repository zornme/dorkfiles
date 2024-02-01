-- bootstrap lazy.vim for plugin management
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "plugins" },
    'mbbill/undotree',
    { 'nvim-lualine/lualine.nvim',
    config = function()
        require('lualine').setup()
    end
},
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- Ctrl-P fuzzy finding
            vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({}))<CR>', {noremap = true, nowait = true, silent = true})
            -- Ctrl-G fuzzy grepping
            vim.api.nvim_set_keymap('n', '<C-g>', '<cmd>lua require("telescope.builtin").live_grep(require("telescope.themes").get_dropdown({}))<CR>', {noremap = true, nowait = true, silent = true})
        end
    },
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },

})

require('telescope').load_extension('fzf')

require('nvim-treesitter.configs').setup {
    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
