return {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({ options = { theme = "auto" } })
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({})
		end,
	},
}
