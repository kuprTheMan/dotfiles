-- Set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable Netrw plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable usles providers
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- CursorHold after 250ms, made for highlight_definitions
vim.opt.updatetime = 250

--Turn on plugin in Git Reposetori
local function check_git_repo()
  local cmd = "git rev-parse --is-inside-work-tree"
  if vim.fn.system(cmd) == "true\n" then
    vim.api.nvim_exec_autocmds("User", { pattern = "InGitRepo" })
    return true
  end
end

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  callback = function()
    vim.schedule(check_git_repo)
  end,
})

-- Set title
vim.opt.title = true
function GetCurrentIconFile()
	local filename = vim.fn.expand("%:t")
	local icon = require("mini.icons").get("file", filename)
	if filename == "" then
		return ""
	end
	return icon
end
vim.o.titlestring = '%{fnamemodify(getcwd(), ":t")} %{v:lua.GetCurrentIconFile()} %{expand("%:t")}'
