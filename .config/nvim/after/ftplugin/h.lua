vim.opt_local.spell = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.bo.formatprg = "clang-format"

vim.keymap.set(
  "n",
  "<leader>ch",
  "<cmd>ClangdSwitchSourceHeader<cr>",
  { desc = "Tooggle bettwen source and heade files" }
)

vim.keymap.set("n", "<leader>dm", function()
	vim.cmd.Dispatch({ "make build" })
end)

vim.keymap.set("n", "<leader>dr", function()
	vim.cmd.Dispatch({ "make run" })
end)
