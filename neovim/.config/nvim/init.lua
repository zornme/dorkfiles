require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'RRethy/nvim-base16'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
   use {
       'nvim-telescope/telescope.nvim', tag = '0.1.0',
       requires = {
           {'nvim-lua/plenary.nvim'},
           {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
       }
   }
end)

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

-- Map leader to space
vim.g.mapleader = "<Space>"

-- " F2 to trim trailing whitespace
vim.api.nvim_set_keymap('n', '<F2>', '<cmd>:%s/\\s\\+$//g<CR>', {noremap = true, silent = true})
-- " enter key to list buffers
vim.api.nvim_set_keymap('n', '<CR>', '<cmd>:ls<CR>', {noremap = true, silent = true})
-- Ctrl-P fuzzy finding
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<CR>', {noremap = true, silent = true})
-- Ctrl-G fuzzy grepping
vim.api.nvim_set_keymap('n', '<C-g>', '<cmd>lua require("telescope.builtin").live_grep()<CR>', {noremap = true, silent = true})

-- Enable persistent undo so that undo history persists across vim sessions
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undo"

-- keep swapfiles from cluttering up pwd
vim.opt.dir = os.getenv("HOME") .. "/.config/nvim/swap"

vim.opt.syntax = 'on'
vim.cmd[[colorscheme base16-tomorrow-night-eighties]]

vim.opt.wrap = false

vim.opt.number = true
vim.opt.numberwidth = 4

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.mouse = a

vim.opt.colorcolumn = "80"

-- shut the fuck up
vim.opt.visualbell = true
vim.opt.errorbells = false

-- intuitive backspacing in insert mode
vim.opt.backspace = { 'indent', 'eol', 'start' }

-- keep a longer command/search history
vim.opt.history = 1000

-- hide rather than destroy buffers
vim.opt.hidden = true

-- show last command and highlight size
vim.opt.ruler = true
vim.opt.showcmd = true

-- blink matching parentheses/brackets etc
vim.opt.showmatch = true
vim.opt.matchtime = 3

-- ignore the node_modules directory throughout vim (but especially in ctrlp)
vim.cmd[[set wildignore+=*/node_modules/*]]

vim.opt.list = true
vim.opt.listchars:append('tab:▸ ')
vim.opt.listchars:append('trail:·')

-- autoload changed files
vim.opt.autoread = true

-- Search upward for tags until reaching the home directory
vim.cmd[[set tags+=tags;$HOME]]

-- " Show blame for highlighted lines.
-- " http://robots.thoughtbot.com/post/159805638/integrating-vim-into-your-life
-- vmap <Leader>b :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
-- vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
-- vmap <Leader>h :<C-U>!hg blame -fu <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
