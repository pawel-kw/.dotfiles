-- Database UI for ad-hoc Snowflake/Postgres/SQLite queries inside Neovim.
-- Connection strings live in ~/.local/share/db_ui/connections.json (gitignored)
-- or via the $DBUI_DEFAULT_QUERY / g:dbs vim variable.
--
-- Snowflake URL format (requires `pip install snowflake-sqlalchemy snowflake-connector-python`):
--   snowflake://USER:PASS@ACCOUNT/DB/SCHEMA?warehouse=WH&role=ROLE
return {
  {
    'tpope/vim-dadbod',
    cmd = { 'DB', 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      'tpope/vim-dadbod',
      'kristijanhusak/vim-dadbod-completion',
    },
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    keys = {
      { '<leader>Du', '<cmd>DBUIToggle<cr>',        desc = '[D]B [U]I toggle' },
      { '<leader>Df', '<cmd>DBUIFindBuffer<cr>',    desc = '[D]B [F]ind buffer' },
      { '<leader>Da', '<cmd>DBUIAddConnection<cr>', desc = '[D]B [A]dd connection' },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_execute_on_save = 0
      vim.g.db_ui_save_location = vim.fn.stdpath('data') .. '/db_ui'
    end,
  },
}
