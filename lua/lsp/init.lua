local lsp = require("lspconfig")
local cmp_caps = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function()
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {
      buffer = bufnr,
      silent = true
    })
  end
  map("n", "gd", vim.lsp.buf.definition)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "K", vim.lsp.buf.hover)
  map("n", "<leader>rn", vim.lsp.buf.rename)
  map("n", "<leader>ca", vim.lsp.buf.code_action)
end

for _, server in ipairs({ "lua_ls", "ts_ls", "gopls", "pyright", "jsonls", "yamlls" }) do
  lsp[server].setup({ on_attach = on_attach, capabilities = cmp_caps })
end
