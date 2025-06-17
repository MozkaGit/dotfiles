local function setup_yaml_buffer()
	-- Basic Settings
	vim.opt_local.cursorcolumn = true
	vim.opt_local.shiftwidth = 2
	vim.opt_local.softtabstop = 2
	vim.opt_local.tabstop = 2
	vim.opt_local.expandtab = true

	-- -- Keymap for yamllint
	-- vim.keymap.set("n", "<leader>yl", function()
	-- 	vim.cmd("cexpr system('yamllint " .. vim.fn.expand("%") .. "')")
	-- 	vim.cmd("copen")
	-- end, {
	-- 	noremap = true,
	-- 	silent = true,
	-- 	buffer = 0,
	-- 	desc = "Run yamllint",
	-- })
end

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
							completion = true,
							hover = true,
							suggest = {
								parentSkeletonSelectedFirst = false,
							},
							schemas = {
								kubernetes = "**/*.yaml",
								["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
								["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
								["https://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
								["https://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
								["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
								["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*compose*.{yml,yaml}",
							},
							format = {
								enable = true,
								singleQuote = false,
								bracketSpacing = true,
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
		},
	},

	{
		"saghen/blink.cmp",
		opts = {
			sources = {
				per_filetype = {
					yaml = { "lsp", "path", "buffer" },
					yml = { "lsp", "path", "buffer" },
				},
				providers = {
					buffer = {
						opts = {
							get_bufnrs = function()
								if vim.bo.filetype == "yaml" or vim.bo.filetype == "yml" then
									local bufs = {}
									for _, win in ipairs(vim.api.nvim_list_wins()) do
										bufs[vim.api.nvim_win_get_buf(win)] = true
									end
									return vim.tbl_keys(bufs)
								end
								return vim.api.nvim_list_bufs()
							end,
						},
					},
				},
			},
			completion = {
				menu = {
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "source_name" },
							{ "kind" },
						},
					},
				},
			},
		},
	},

	{
		"LazyVim/LazyVim",
		opts = function(_, opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "yaml", "yml" },
				callback = setup_yaml_buffer,
				group = vim.api.nvim_create_augroup("YAMLConfig", { clear = true }),
			})
			return opts
		end,
	},

	{
		"DmarshalTU/yaml-jumper",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("yaml-jumper").setup({ use_smart_parser = false })
		end,
		ft = { "yaml", "yml" },
	},
}
