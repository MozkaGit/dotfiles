return {
	-- Code outline and navigation
	{
		"stevearc/aerial.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		-- Force loading for programming languages
		ft = { "go", "python", "lua", "javascript", "typescript", "rust", "c", "cpp" },
		opts = {
			backends = { "lsp", "treesitter", "markdown", "man" },
			layout = {
				min_width = 25,
				default_direction = "right",
				preserve_equality = true,
			},
			show_guides = true,
			guides = {
				mid_item = "├─",
				last_item = "└─",
				nested_top = "│ ",
				whitespace = "  ",
			},
			-- Focus on useful symbols for Go
			filter_kind = {
				"Class",
				"Constructor",
				"Enum",
				"Function",
				"Interface",
				"Module",
				"Method",
				"Struct",
				"Variable",
				"Constant",
				"Field",
				"Package",
			},
			-- Icons configuration
			icons = {
				Class = "󰠱 ",
				Constructor = " ",
				Enum = " ",
				Function = "󰊕 ",
				Interface = " ",
				Method = "󰆧 ",
				Module = " ",
				Struct = "󰙅 ",
				Variable = "󰀫 ",
				Constant = "󰏿 ",
				Field = " ",
				Package = " ",
			},
		},
		keys = {
			{ "<leader>ao", "<cmd>AerialToggle<cr>", desc = "Outline (Aerial)" },
			{ "<leader>an", "<cmd>AerialNavToggle<cr>", desc = "Outline Navigation" },
		},
	},
}
