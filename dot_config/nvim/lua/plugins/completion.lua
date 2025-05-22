return {
  -- Optimized configuration for blink.cmp completion
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      -- Configure source priorities (this is the key improvement)
      opts.sources = opts.sources or {}
      opts.sources.default = { "lsp", "snippets", "path", "buffer" }
      
      -- Provider configuration with priorities
      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.lsp = {
        name = "LSP",
        module = "blink.cmp.sources.lsp",
        score_offset = 1000, -- Highest priority for LSP
        enabled = true,
      }
      opts.sources.providers.snippets = {
        name = "Snippets", 
        module = "blink.cmp.sources.snippets",
        score_offset = 900, -- High priority for snippets
        enabled = true,
      }
      opts.sources.providers.buffer = {
        score_offset = 200, -- Lower priority for buffer completions
      }
      
      -- Menu configuration for better display
      opts.completion = opts.completion or {}
      opts.completion.menu = opts.completion.menu or {}
      opts.completion.menu.draw = {
        columns = {
          { "kind_icon", "kind", gap = 1 },
          { "label", "label_description", gap = 1 },
        },
      }
      
      -- Fast documentation display
      opts.completion.documentation = {
        auto_show = true,
        auto_show_delay_ms = 50,
      }
      
      -- Selection behavior
      opts.completion.list = opts.completion.list or {}
      opts.completion.list.selection = {
        preselect = true,
        auto_insert = false,
      }
      
      return opts
    end,
  },
}
