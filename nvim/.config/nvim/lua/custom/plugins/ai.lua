-- Optional AI assistants. Disabled by default to avoid surprise network calls.
-- Set vim.g.enable_ai = true in init.lua (or as the first line of a sourced file)
-- to enable, then `:Lazy sync`.
local enable = vim.g.enable_ai == true
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    cond = enable,
    opts = {
      suggestion = { enabled = true, auto_trigger = true },
      panel = { enabled = false },
    },
  },
  {
    'olimorris/codecompanion.nvim',
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    cond = enable,
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
    opts = {},
  },
}
