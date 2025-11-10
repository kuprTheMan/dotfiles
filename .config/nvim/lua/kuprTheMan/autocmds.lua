local autocmd = vim.api.nvim_create_autocmd

autocmd("BufEnter", {
	desc = "Rid auto comment for new string",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

autocmd("TextYankPost", {
	desc = "Highlight copied text",
	callback = function()
		vim.highlight.on_yank({ higroup = "PmenuSel", timeout = 100 })
	end,
})

autocmd("BufWinEnter", {
	desc = "Open :help with vertical split",
	pattern = { "*.txt" },
	callback = function()
		if vim.bo.filetype == "help" then
			vim.cmd.wincmd("L")
		end
	end,
})

autocmd("BufReadPost", {
	desc = "Jump to the last place you’ve visited in a file before exiting",
	callback = function()
		local ignore_ft = { "lazy" }
		local ft = vim.bo.filetype
		if not vim.tbl_contains(ignore_ft, ft) then
			local mark = vim.api.nvim_buf_get_mark(0, '"')
			local lcount = vim.api.nvim_buf_line_count(0)
			if mark[1] > 0 and mark[1] <= lcount then
				pcall(vim.api.nvim_win_set_cursor, 0, mark)
			end
		end
	end,
})
