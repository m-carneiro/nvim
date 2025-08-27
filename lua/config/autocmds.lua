local group = vim.api.nvim_create_augroup("UserAutoCmds", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  callback = function(args)
    require("conform").format({ bufnr = args.buf, lsp_fallback = true, async = false })
  end,
})


vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function() vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 150
    })
  end,
})
