-- ~/.config/nvim/lua/plugins/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Tema
  {
    "AlexvZyl/nordic.nvim",
    priority = 1000,
    config = function()
      require("nordic").load()
    end
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({ options = { theme = "auto" } })
    end
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({})
    end
  },

  -- DEPENDÊNCIA BASE para Telescope
  { "nvim-lua/plenary.nvim" },

  -- Telescope (busca)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
    end
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("gitsigns").setup() end
  },

  -- Which-Key
  {
    "folke/which-key.nvim",
    config = function() require("which-key").setup() end
  },

  -- Comentários
  {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup() end
  },

  -- Terminal embutido
  { "akinsho/toggleterm.nvim", version = "*", config = true },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua","vim","vimdoc","bash","javascript","typescript","go","python","json","yaml","markdown"
        },
        highlight = { enable = true },
        indent    = { enable = true },
      })
    end
  },

  -- LSP + Completion
  { "williamboman/mason.nvim", config = function() require("mason").setup() end },
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
          { name = "nvim_lsp" }, { name = "luasnip" },
          { name = "buffer"   }, { name = "path"    },
        }
      })
    end
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          json = { "jq" },
          go = { "gofmt", "goimports" },
          yaml = { "prettierd", "prettier" },
          markdown = { "prettierd", "prettier" },
        },
      })
    end
  },

}, {
  -- <<< OPÇÕES GLOBAIS DO LAZY >>>
  git = {
    url_format = "git@github.com:%s.git", -- usa SSH nos clones
    timeout = 120,
  },
})

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "ts_ls", "gopls", "pyright", "jsonls", "yamlls" },
  automatic_installation = true,
})

vim.schedule(function() require("lsp") end)
