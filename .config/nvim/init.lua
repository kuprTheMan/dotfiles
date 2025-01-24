-- Core
require "kuprTheMan"

require "kuprTheMan.options"
require "kuprTheMan.keymaps"
require "kuprTheMan.autocmds"

-- Lazy Boorstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	-- Lazy settings
	install = { colorscheme = { "gruvbox" } },
	checker = {
		enabled = false,
		notify = false,
	},
	change_detection = { enabled = false },
	spec = { import = "plugins" },
})
