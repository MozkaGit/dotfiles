-- Ghostty syntax highlighting - aggressive detection for all environments

-- Multiple detection strategies for maximum compatibility
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  callback = function()
    local filepath = vim.fn.expand("%:p")
    local filename = vim.fn.expand("%:t")
    
    -- Strategy 1: Specific ghostty patterns
    if filename == "config" and filepath:match("ghostty") then
      vim.bo.filetype = "ghostty"
      print("Ghostty detected: " .. filepath)
      return
    end
    
    -- Strategy 2: .ghostty extension
    if filepath:match("%.ghostty$") then
      vim.bo.filetype = "ghostty"
      return
    end
    
    -- Strategy 3: Fallback for common paths where ghostty config might be
    if filename == "config" and (
      filepath:match("/%.config/") or 
      filepath:match("/vscode/") or
      filepath:match("/home/[^/]+/%.config/")
    ) then
      -- Defer check to see if it's a ghostty config by content
      vim.defer_fn(function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, 10, false)
        for _, line in ipairs(lines) do
          if line:match("theme%s*=") or 
             line:match("font%-family%s*=") or
             line:match("background%s*=") or
             line:match("window%-decoration%s*=") then
            vim.bo.filetype = "ghostty"
            print("Ghostty detected by content analysis")
            break
          end
        end
      end, 200)
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

-- Manual commands
vim.api.nvim_create_user_command("GhosttyForce", function()
  vim.bo.filetype = "ghostty"
  setup_ghostty_syntax()
  print("Forced ghostty filetype and syntax!")
end, {})

vim.api.nvim_create_user_command("GhosttyReload", function()
  setup_ghostty_syntax()
  print("Ghostty syntax reloaded!")
end, {})

-- Auto-force for known ghostty config locations (last resort)
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local filepath = vim.fn.expand("%:p")
    if filepath:match("ghostty/config$") and vim.bo.filetype ~= "ghostty" then
      vim.defer_fn(function()
        if vim.bo.filetype == "" or vim.bo.filetype == "conf" then
          vim.bo.filetype = "ghostty"
          print("Auto-forced ghostty filetype for: " .. filepath)
        end
      end, 300)
    end
  end,
})