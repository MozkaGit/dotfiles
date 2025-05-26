vim.opt.ignorecase = false

vim.opt.scrolloff = 8

-- Enable OSC 52 clipboard for remote environments
if os.getenv("SSH_TTY") or os.getenv("DEVPOD") then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = function() return vim.fn.getreg('"') end,
      ["*"] = function() return vim.fn.getreg('"') end,
    },
  }
end
