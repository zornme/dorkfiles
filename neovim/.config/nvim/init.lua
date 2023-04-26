require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'mbbill/undotree'
    use 'neovim/nvim-lspconfig'
    use 'RRethy/nvim-base16'
    use 'sheerun/vim-polyglot'
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
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- nvim-cmp for completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp', -- for completion from LSP
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
            'onsails/lspkind-nvim',
        },
    }
end)

local cmp = require'cmp'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require('cmp')
cmp.setup {
    snippet = {
        expand = function(args)
            -- For `vsnip` user.
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        -- { name = 'buffer' },
        -- { name = 'path' },
    }),

    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),

        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },

    formatting = {
        format = require("lspkind").cmp_format({
            with_text = true,
            menu = {
                nvim_lsp = "[LSP]",
            },
        }),
    },
}

require('lualine').setup()

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

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig').elixirls.setup{
    cmd = { "/Users/matt.zorn/bin/elixir-ls/language_server.sh" },
    capabilities = capabilities,
}

require'lspconfig'.pyright.setup{
    capabilities = capabilities,
}

-- Map leader to space
vim.g.mapleader = "<Space>"

-- " F2 to trim trailing whitespace
vim.api.nvim_set_keymap('n', '<F2>', '<cmd>:%s/\\s\\+$//g<CR>', {noremap = true, silent = true})
-- " enter key to list buffers
vim.api.nvim_set_keymap('n', '<CR>', '<cmd>:ls<CR>', {noremap = true, silent = true})
-- Ctrl-P fuzzy finding
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({}))<CR>', {noremap = true, nowait = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<CR>', {noremap = true, nowait = true, silent = true})
-- Ctrl-G fuzzy grepping
-- vim.api.nvim_set_keymap('n', '<C-g>', '<cmd>lua require("telescope.builtin").live_grep(require("telescope.themes").get_dropdown({}))<CR>', {noremap = true, nowait = true, silent = true})

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

-- " Show blame for highlighted lines.
-- " http://robots.thoughtbot.com/post/159805638/integrating-vim-into-your-life
-- vmap <Leader>b :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
-- vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
-- vmap <Leader>h :<C-U>!hg blame -fu <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
