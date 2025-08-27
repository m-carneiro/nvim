local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

map("n", "<leader>w", "<cmd>w<CR>", opts)
map("n", "<leader>q", "<cmd>q<CR>", opts)
map("n", "<A-j>", ":m .+1<CR>==", opts) -- mover linha pra baixo
map("n", "<A-k>", ":m .-2<CR>==", opts) -- mover linha pra cima

map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
map("t", "<Esc>", [[<C-\><C-n>]], opts)

map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<leader>dl", "<cmd>Telescope diagnostic<CR>", opts)

map({ "n", "v" }, "<leader>f", function()
  require("conform").format({ lsp_fallback = true, async = false })
end, opts)


map("n", "<leader>tt", ":ToggleTerm<CR>", otps)
