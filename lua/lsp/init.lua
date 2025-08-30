local lspconfig = require("lspconfig")
local cmp_caps = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
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

local root = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git")

lspconfig.ts_ls.setup({
  on_attach = on_attach,
  capabilities = cmp_caps,
  root_dir = root,
  single_file_support = false,
  settings = {
    typescript = {
      format = { enable = false },
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      preferences = {
        importModuleSpecifier = "non-relative",
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
        includeAutomaticOptionalChainCompletions = true,
        includeCompletionsWithSnippetText = true,
        quoteStyle = "single",
        includeModuleSpecifierPreference = "non-relative",
      },
    },
    javascript = {
      format = { enable = false },
      inlayHints = { includeInlayParameterNameHints = "all" },
      preferences = {
        importModuleSpecifier = "non-relative",
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
        quoteStyle = "single",
      },
    },
  }
})


for _, server in ipairs({ "lua_ls", "ts_ls", "gopls", "pyright", "jsonls", "yamlls" }) do
  lspconfig[server].setup({ on_attach = on_attach, capabilities = cmp_caps })
end
