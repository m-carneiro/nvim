return {
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = true,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
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
    end,
  },
}
