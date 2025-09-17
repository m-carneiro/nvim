return {
  {
	  "catppuccin/nvim",
	  name = "catppuccin",
	  priority = 1000,
	  config = function()
		  require("catppuccin").setup({
			  flavour = "mocha", -- opções: "latte", "frappe", "macchiato", "mocha"
			  transparent_background = false,
			  integrations = {
				  cmp = true,
				  gitsigns = true,
				  nvimtree = true,
				  treesitter = true,
				  telescope = true,
				  which_key = true,
				  lualine = true,
			  },
		  })
		  vim.cmd.colorscheme("catppuccin")
	  end,
  } 
}
