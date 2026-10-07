-- Quality-of-life extras.
return {
  -- File explorer as a buffer (nicer than netrw).
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    },
    opts = {
      view_options = { show_hidden = true },
    },
  },

  -- Diagnostics panel.
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',              desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics' },
      { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>',      desc = 'Symbols (Trouble)' },
    },
  },

  -- Git UX (gitsigns is in init.lua; these add full-screen views).
  {
    'NeogitOrg/neogit',
    cmd = 'Neogit',
    dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>',  desc = '[G]it (Neo[g]it)' },
      { '<leader>gd', '<cmd>DiffviewOpen<cr>',  desc = '[G]it [D]iffview' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it file [H]istory' },
    },
    opts = { integrations = { diffview = true } },
  },
  { 'sindrets/diffview.nvim', cmd = { 'DiffviewOpen', 'DiffviewFileHistory' } },

  -- Lazygit launcher (needs `brew install lazygit`).
  {
    'kdheepak/lazygit.nvim',
    cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>gl', '<cmd>LazyGit<cr>', desc = '[G]it [L]azyGit' },
    },
  },

  -- TODO comments highlighting + telescope picker.
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
    keys = {
      { '<leader>st', '<cmd>TodoTelescope<cr>', desc = '[S]earch [T]odos' },
    },
  },
}
