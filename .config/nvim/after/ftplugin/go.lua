vim.opt_local.expandtab = false
vim.opt_local.spell = true

vim.keymap.set("n", "<leader>dm", function()
		vim.cmd.Dispatch({ "go test -fullpath ./..." })
end)
