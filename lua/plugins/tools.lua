return {
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    opts = {},
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
  },
  { "akinsho/toggleterm.nvim", version = "*", config = true },
}
