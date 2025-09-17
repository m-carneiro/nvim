return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "zbirenbaum/copilot.lua",
            "zbirenbaum/copilot-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "rafamadriz/friendly-snippets",
            "windwp/nvim-autopairs",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()


            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                if col == 0 then return false end
                local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
                return not text:sub(1, col):match("^%s*$")
            end


            cmp.setup({
                preselect = cmp.PreselectMode.None,
                completion = { completeopt = "menu,menuone,noinsert,noselect" },
                snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() and cmp.get_selected_entry() then
                            cmp.confirm({ select = false })
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() and has_words_before() then
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
                    { name = "buffer" },
                    { name = "path" },
                    { name = "copilot", keyword_length = 3, max_item_count = 3 },
                },
            })
        end,
    }
}
