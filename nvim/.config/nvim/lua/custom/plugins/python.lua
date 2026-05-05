-- Python: virtualenv selector + DAP for debugging.
-- LSP (basedpyright + ruff) and formatter (ruff_format) are configured in init.lua.
return {
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python',
    },
    lazy = false,
    keys = {
      { '<leader>vs', '<cmd>VenvSelect<cr>', desc = '[V]env [S]elect' },
    },
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap-python',
      'theHamsta/nvim-dap-virtual-text',
    },
    keys = {
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: toggle [B]reakpoint' },
      { '<leader>dc', function() require('dap').continue() end, desc = 'Debug: [C]ontinue' },
      { '<leader>dn', function() require('dap').step_over() end, desc = 'Debug: step [N]ext' },
      { '<leader>di', function() require('dap').step_into() end, desc = 'Debug: step [I]nto' },
      { '<leader>do', function() require('dap').step_out() end, desc = 'Debug: step [O]ut' },
      { '<leader>du', function() require('dapui').toggle() end, desc = 'Debug: toggle [U]I' },
    },
    config = function()
      local dap, dapui = require('dap'), require('dapui')
      dapui.setup()
      require('nvim-dap-virtual-text').setup({})
      -- Use whichever python is on PATH (venv-selector activates project venvs).
      require('dap-python').setup('python')
      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
      dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
    end,
  },
}
