local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

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

autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
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
