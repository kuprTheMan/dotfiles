return {
  "kristijanhusak/vim-dadbod-ui",
  lazy = true,
  cmd = { "DB", "DBUI" },
  ft = { "sql", "plsql" },
  dependencies = {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
  }
}
