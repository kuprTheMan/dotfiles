return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"RRethy/vim-illuminate"
	},
	build = function()
		local ts_update = require("nvim-treesitter.install").update({
			with_sync = true,
		})
		ts_update()
	end,

	-- [[ Configure Treesitter ]]
	opts = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				-- language
				"c",
				"cpp",
				"go",
				"gosum",
				"gowork",
				"gomod",
				"lua",
				"sql",
				"python",
				"nim",
				-- markup
				"vimdoc",
				"markdown",
				"markdown_inline",
				-- utility
				"csv",
				"json",
				"diff",
				"yaml",
				"dockerfile",
			},
			indent = { enable = true },
			highlight = {
				enable = true,
				disable = function(_, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = false,
			},
			fold = { enabe = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["ap"] = "@parameter.outer",
						["ip"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["as"] = "@statement.outer",
						["is"] = "@statement.inner",
						["av"] = "@assignment.outer",
						["iv"] = "@assignment.inner",
						["in"] = "@assignment.lhs",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]i"] = "@conditional.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]I"] = "@conditional.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[i"] = "@conditional.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[I"] = "@conditional.outer",
					},
				},
			},
		})
	end,
}
