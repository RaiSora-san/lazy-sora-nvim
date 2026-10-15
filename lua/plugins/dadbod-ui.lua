return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Automatically use nerd-font database icons in the drawer
      vim.g.db_ui_use_nerd_fonts = 1

      -- Show database icons next to names
      vim.g.db_ui_show_database_icon = 1

      -- Drawer layout preferences
      vim.g.db_ui_win_position = "left"
      vim.g.db_ui_winwidth = 35

      -- Force notifications to print clearly in command line
      vim.g.db_ui_force_echo_notifications = 1

      -- Automatically execute query on save (:w)
      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_table_helpers = {
        postgresql = {
          ["List"] = "SELECT * FROM \"{table}\" LIMIT 200;",
          ["Columns"] = "SELECT column_name, data_type, character_maximum_length, is_nullable, column_default FROM information_schema.columns WHERE table_schema = current_schema() AND table_name = '{table}' ORDER BY ordinal_position;",
          ["Primary Keys"] = "SELECT kcu.column_name FROM information_schema.table_constraints tc JOIN information_schema.key_column_usage kcu ON tc.constraint_name = kcu.constraint_name AND tc.table_schema = kcu.table_schema WHERE tc.table_schema = current_schema() AND tc.table_name = '{table}' AND tc.constraint_type = 'PRIMARY KEY';",
          ["Foreign Keys"] = "SELECT kcu.constraint_name, kcu.column_name, ccu.table_name AS foreign_table, ccu.column_name AS foreign_column FROM information_schema.table_constraints tc JOIN information_schema.key_column_usage kcu ON tc.constraint_name = kcu.constraint_name AND tc.table_schema = kcu.table_schema JOIN information_schema.constraint_column_usage ccu ON ccu.constraint_name = tc.constraint_name AND ccu.table_schema = tc.table_schema WHERE tc.table_schema = current_schema() AND tc.table_name = '{table}' AND tc.constraint_type = 'FOREIGN KEY';",
        },
        mysql = {
          -- 1. List: preview first 200 rows
          ["List"] = "SELECT * FROM `{table}` LIMIT 200;",

          -- 2. Columns: describe column names, types, nullability, defaults
          ["Columns"] = "SELECT COLUMN_NAME, DATA_TYPE, COLUMN_TYPE, IS_NULLABLE, COLUMN_DEFAULT, EXTRA "
            .. "FROM INFORMATION_SCHEMA.COLUMNS "
            .. "WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = '{table}' "
            .. "ORDER BY ORDINAL_POSITION;",

          -- 3. Primary Keys: list primary key columns
          ["Primary Keys"] = "SELECT COLUMN_NAME, DATA_TYPE, COLUMN_TYPE, EXTRA "
            .. "FROM INFORMATION_SCHEMA.COLUMNS "
            .. "WHERE TABLE_SCHEMA = DATABASE() "
            .. "  AND TABLE_NAME = '{table}' "
            .. "  AND COLUMN_KEY = 'PRI' "
            .. "ORDER BY ORDINAL_POSITION;",

          -- 4. Indexes: list all index definitions for the table
          ["Indexes"] = "SELECT INDEX_NAME, COLUMN_NAME, NON_UNIQUE, SEQ_IN_INDEX, INDEX_TYPE "
            .. "FROM INFORMATION_SCHEMA.STATISTICS "
            .. "WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = '{table}' "
            .. "ORDER BY INDEX_NAME, SEQ_IN_INDEX;",

          -- 5. Foreign Keys: show constraints, local columns, and target tables/columns
          ["Foreign Keys"] = [[
            SELECT
              tc.CONSTRAINT_TYPE,
              tc.CONSTRAINT_NAME,
              kcu.COLUMN_NAME,
              kcu.REFERENCED_TABLE_NAME,
              kcu.REFERENCED_COLUMN_NAME,
              rc.DELETE_RULE AS ON_DELETE,
              rc.UPDATE_RULE AS ON_UPDATE
            FROM information_schema.TABLE_CONSTRAINTS tc
            JOIN information_schema.KEY_COLUMN_USAGE kcu
              ON  kcu.CONSTRAINT_SCHEMA = tc.CONSTRAINT_SCHEMA
              AND kcu.CONSTRAINT_NAME   = tc.CONSTRAINT_NAME
              AND kcu.TABLE_NAME        = tc.TABLE_NAME
            JOIN information_schema.REFERENTIAL_CONSTRAINTS rc
              ON  rc.CONSTRAINT_SCHEMA = tc.CONSTRAINT_SCHEMA
              AND rc.CONSTRAINT_NAME   = tc.CONSTRAINT_NAME
              AND rc.TABLE_NAME        = tc.TABLE_NAME
            WHERE tc.CONSTRAINT_TYPE = 'FOREIGN KEY'
              AND tc.TABLE_SCHEMA = '{dbname}'
              AND tc.TABLE_NAME   = '{table}'
          ]],
        },
      }
    end,
  },
}
