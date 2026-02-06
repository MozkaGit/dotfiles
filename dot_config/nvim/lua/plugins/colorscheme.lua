return {
	{
		"oskarnurm/koda.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("koda").setup({
				transparent = true,
				auto = true,
				cache = true,
				colors = {
					-- USGC Palette
					bg = "#000000",
					fg = "#459A64",
					dim = "#262626",
					line = "#3C3C3C",
					keyword = "#EBBC3F",
					comment = "#484747",
					border = "#459A64",
					emphasis = "#FEFFFF",
					func = "#3376F6",
					string = "#459A64",
					const = "#ED7B3A",
					highlight = "#458ee6",
					info = "#3376F6",
					success = "#459A64",
					warning = "#F5C442",
					danger = "#CD0400",
					green = "#459A64",
					orange = "#ED7B3A",
					red = "#CD0400",
					pink = "#EA3D8D",
					cyan = "#3376F6",
				},
			})
			vim.cmd("colorscheme koda")
		end,
	},
}
