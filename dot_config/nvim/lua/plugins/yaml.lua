return {
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				yamlls = {
					-- Have to add this for yamlls to understand that we support line folding
					capabilities = {
						textDocument = {
							foldingRange = {
								dynamicRegistration = false,
								lineFoldingOnly = true,
							},
						},
					},
					settings = {
						redhat = { telemetry = { enabled = false } },
						yaml = {
							keyOrdering = false,
							schemas = {
								kubernetes = "/*.yaml",
							},
							format = {
								enable = true,
							},
							validate = true,
							schemaStore = {
								-- Must disable built-in schemaStore support to use
								-- schemas from SchemaStore.nvim plugin
								enable = false,
								-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
								url = "",
							},
						},
					},
				},
			},
			setup = {
				yamlls = function()
					-- Neovim < 0.10 does not have dynamic registration for formatting
					if vim.fn.has("nvim-0.10") == 0 then
						LazyVim.lsp.on_attach(function(client, _)
							client.server_capabilities.documentFormattingProvider = true
						end, "yamlls")
					end
				end,
			},
		},
	},
}
