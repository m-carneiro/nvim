return { 
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "bash", "javascript", "typescript", "go", "python", "json", "yaml", "markdown",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
}
