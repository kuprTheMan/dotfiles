return {
	-- Helpers
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",

	-- Better Movement
	{
		"ggandor/leap.nvim",
      -- stylua: ignore
      keys = {
        { "s", mode = { "n", "x", "o" }, "<Plug>(leap-forward)" },
        { "S", mode = { "n", "o", "x" }, "<Plug>(leap-backward)" },
      },
		opts = {},
	},

	{
		"echasnovski/mini.pairs",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			modes = { insert = true, command = true },
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			skip_ts = { "string" },
			skip_unbalanced = true,
			markdown = true,
		},
	},

	{
		"echasnovski/mini.surround",
		event = { "BufReadPost", "BufNewFile" },
		recommended = true,
		opts = {
			mappings = {
				add = "gsa",
				delete = "gsd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
				update_n_lines = "gsn",
			},
		},
	},

	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
      -- stylua: ignore
      keys = {
        { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
        { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      },
	},

	{
		"ibhagwan/fzf-lua",
		cmd = "FzfLua",
      -- stylua: ignore
      keys = {
          { ";f", "<cmd>FzfLua files<CR>", desc = "Find Files (Root Dir)" },
          { ";r", "<cmd>FzfLua live_grep<CR>", desc = "Grep (Root Dir)" },
          { ";;", function() require("fzf-lua").resume() end, desc = "Resume", },
        },
	},

	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				modes_allowlist = { "n" },
				vim.cmd([[
                augroup illuminate_augroup
                    autocmd!
                    autocmd VimEnter * hi illuminatedWordRead cterm=none gui=none guibg=#526252
                    autocmd VimEnter * hi illuminatedWordText cterm=none gui=none guibg=#525252
                    autocmd VimEnter * hi illuminatedWordWrite cterm=none gui=none guibg=#625252
                augroup END
            ]]),
			})
		end,
	},

	-- Lua
	{
		"folke/zen-mode.nvim",
		keys = { "<leader>z", "<cmd>ZenMode<cr>" },
	},

	-- Toggler
	{
		"monaqa/dial.nvim",
      -- stylua: ignore
      keys = {
        { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
        { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
      },
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
					augend.constant.new({ elements = { "and", "or" } }),
				},
			})
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		opts = function()
			vim.g.skip_ts_context_commentstring_module = true
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
}
