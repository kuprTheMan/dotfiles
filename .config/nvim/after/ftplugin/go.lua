vim.opt_local.expandtab = false
vim.opt_local.spell = false

vim.keymap.set("n", "<leader>ta", function()
  vim.cmd.Dispatch{ "go test -fullpath -failfast ./..." }
end, { desc = "[T]est [A]ll Packages" })

vim.keymap.set("n", "<leader>ta", function()
  vim.cmd.Dispatch{ "go test -fullpath -failfast" .. vim.fn.expand "%:p:h" }
end, { desc = "[T]est [P]ackage" })
