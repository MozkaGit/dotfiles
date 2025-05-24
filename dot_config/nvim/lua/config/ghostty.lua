-- Ghostty syntax highlighting

-- Force filetype detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	callback = function()
		local filepath = vim.fn.expand("%:p")
		if filepath:match("ghostty/config") or filepath:match("%.ghostty$") then
			vim.bo.filetype = "ghostty"
		end
	end,
})

-- Function to apply ghostty syntax
local function setup_ghostty_syntax()
	vim.cmd([[
    syntax clear
    
    " IMPORTANT: Include hyphens in keyword characters
    setlocal iskeyword+=45
    
    " Define all ghostty keywords (with hyphens)
    syntax keyword ghosttyKeyword theme font-family font-family-bold font-family-italic
    syntax keyword ghosttyKeyword font-style font-size background foreground
    syntax keyword ghosttyKeyword window-decoration gtk-titlebar desktop-notifications
    syntax keyword ghosttyKeyword copy-on-select mouse-hide-while-typing
    syntax keyword ghosttyKeyword window-padding-x window-padding-y keybind
    syntax keyword ghosttyKeyword background-opacity background-blur-radius
    syntax keyword ghosttyKeyword window-height window-width maximized fullscreen
    
    " Comments
    syntax match ghosttyComment "^#.*$"
    syntax match ghosttyComment "\s#.*$"
    
    " Values after = 
    syntax match ghosttyValue "=\s*\zs.*$" contains=ghosttyComment
    
    " Link to highlight groups
    highlight! link ghosttyKeyword Keyword
    highlight! link ghosttyComment Comment
    highlight! link ghosttyValue String
    
    " Set comment string
    setlocal commentstring=#\ %s
  ]])
end

-- Apply when filetype is set
vim.api.nvim_create_autocmd("FileType", {
	pattern = "ghostty",
	callback = setup_ghostty_syntax,
})

-- Re-apply after colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		if vim.bo.filetype == "ghostty" then
			vim.defer_fn(setup_ghostty_syntax, 50)
		end
	end,
})

-- Re-apply when entering ghostty buffer
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if vim.bo.filetype == "ghostty" then
			vim.defer_fn(setup_ghostty_syntax, 10)
		end
	end,
})

-- Manual reload command
vim.api.nvim_create_user_command("GhosttyReload", function()
	setup_ghostty_syntax()
	print("Ghostty syntax reloaded!")
end, {})

-- Test command to verify iskeyword
vim.api.nvim_create_user_command("GhosttyTest", function()
	print("Current iskeyword: " .. vim.bo.iskeyword)
	print("Should include character 45 (hyphen)")
	setup_ghostty_syntax()
end, {})
