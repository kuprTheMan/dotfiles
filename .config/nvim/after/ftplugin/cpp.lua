vim.opt_local.spell = true

vim.keymap.set(
  "n",
  "<leader>ch",
  "<cmd>ClangdSwitchSourceHeader<cr>",
  { desc = "Tooggle bettwen source and heade files" }
)
