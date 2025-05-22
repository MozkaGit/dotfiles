return {
  -- Ensure Treesitter supports all Go file types
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { 
      ensure_installed = { "go", "gomod", "gowork", "gosum" } 
    },
  },

  -- Optimized LSP configuration for Go
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              -- Essential optimizations that actually improve the experience
              usePlaceholders = true, -- Enable function signature placeholders
              completeUnimported = true, -- Suggest unimported packages
              hoverKind = "FullDocumentation", -- Show complete documentation
              experimentalPostfixCompletions = true, -- Enable postfix completions
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = false,
                rangeVariableTypes = true,
              },
              analyses = {
                assign = true,
                bools = true,
                defers = true,
                deprecated = true,
                tests = true,
                nilness = true,
                httresponse = true,
                unmarshal = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              staticcheck = true,
              semanticTokens = true,
            },
          },
          -- Enable codelens support
          on_attach = function(client, bufnr)
            if client.supports_method("textDocument/codeLens") then
              vim.lsp.codelens.refresh()
              -- Auto-refresh codelenses on file changes
              vim.api.nvim_create_autocmd({"BufEnter", "CursorHold", "InsertLeave"}, {
                buffer = bufnr,
                callback = function()
                  vim.lsp.codelens.refresh()
                end,
              })
            end
          end,
        },
      },
    },
  },

  -- Ensure Go tools are installed via Mason
  {
    "williamboman/mason.nvim",
    opts = { 
      ensure_installed = { "goimports", "gofumpt", "delve" } 
    },
  },
}
