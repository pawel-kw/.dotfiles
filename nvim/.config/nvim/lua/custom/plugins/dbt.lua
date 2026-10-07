-- dbt: jinja-aware SQL highlighting + light wrappers around the CLI.
-- For Snowflake query execution, see databases.lua (dadbod-ui).
return {
  -- Jinja templating used in dbt models. Treesitter has 'jinja' parser
  -- (loaded via init.lua), but this plugin gives a more reliable filetype
  -- and snippet experience for *.sql files containing {{ ref(...) }}.
  {
    'Glench/Vim-Jinja2-Syntax',
    ft = { 'jinja', 'jinja.html', 'sql' },
  },

  -- dbt CLI integration: :DbtRun, :DbtTest, :DbtCompile on the model under cursor.
  -- Activates only inside dbt projects (presence of dbt_project.yml).
  {
    'PedramNavid/dbtpal',
    ft = { 'sql', 'md', 'yaml' },
    keys = {
      { '<leader>drm', '<cmd>DbtRun<cr>',     desc = '[D]bt [R]un current [M]odel' },
      { '<leader>dra', '<cmd>DbtRunAll<cr>',  desc = '[D]bt [R]un [A]ll' },
      { '<leader>dtm', '<cmd>DbtTest<cr>',    desc = '[D]bt [T]est current [M]odel' },
      { '<leader>dC',  '<cmd>DbtCompile<cr>', desc = '[D]bt [C]ompile' },
    },
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('dbtpal').setup({
        path_to_dbt = 'dbt',
        path_to_dbt_project = '',
        path_to_dbt_profiles_dir = vim.fn.expand('$HOME') .. '/.dbt',
        extended_path_search = true,
        protect_compiled_files = true,
      })
      require('telescope').load_extension('dbtpal')
    end,
  },
}
