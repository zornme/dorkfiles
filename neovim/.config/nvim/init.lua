-- bootstrap lazy.vim for plugin management
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- and now for my silly little settings
-- Enable persistent undo so that undo history persists across vim sessions
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undo"

-- keep swapfiles from cluttering up pwd
vim.opt.dir = os.getenv("HOME") .. "/.config/nvim/swap"

vim.opt.syntax = 'on'

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

vim.opt.hlsearch = false

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

require("lazy").setup("plugins")
