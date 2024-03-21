return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local on_attach = function(_, bufnr)
                local attach_opts = { silent = true, buffer = bufnr }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, attach_opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, attach_opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, attach_opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, attach_opts)
                vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, attach_opts)
                vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, attach_opts)
                vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, attach_opts)
                vim.keymap.set("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, attach_opts)
                vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, attach_opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, attach_opts)
                vim.keymap.set("n", "so", require("telescope.builtin").lsp_references, attach_opts)
            end

            -- nvim-cmp supports additional completion capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            -- Enable the following language servers
            local servers = { "elixirls", "rust_analyzer", "pyright", "tsserver" }
            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            luasnip.config.setup({})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete({}),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = 'buffer' },
                },
            })
        end,
    },

    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({})
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()

            require("mason-lspconfig").setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function (server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                -- ["rust_analyzer"] = function ()
                --     require("rust-tools").setup {}
                -- end
            }
        end,
    },
}
