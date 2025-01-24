return {
	-- Helpers
	"nvim-lua/plenary.nvim",

	-- Formatter
	{
		"stevearc/conform.nvim",
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ lsp_fallback = true })
				end,
				mode = { "n", "v" },
				desc = "Format Injected Langs",
			},
		},
		opts = function()
			require("conform").setup({
				formatters_by_ft = {
					c = { "clang_format" },
					cpp = { "clang_format" },
					go = { "goimports", "gofumpt" },
					lua = { "stylua" },
				},
			})
		end,
	},

	-- Search and Replace
	{
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		opts = { headerMaxWidth = 80 },
		keys = {
			{
				"<leader>sr",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
			},
		},
	},

	-- Better Movement
	{
		"smoka7/hop.nvim",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		config = function()
			local hop = require("hop")
			local directions = require("hop.hint").HintDirection

			hop.setup({})

			vim.keymap.set("", "s", function()
				hop.hint_char2({ current_line_only = false })
			end, { remap = true, desc = "Hop 2 characters" })

			vim.keymap.set("", "f", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
			end, { remap = true, desc = "Hop to next character (this line)" })
			vim.keymap.set("", "F", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
			end, { remap = true, desc = "Hop to previous character (this line)" })
		end,
	},

	{
		"echasnovski/mini.pairs",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
      -- stylua: ignore
      keys = {
        { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
        { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      },
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
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		opts = function()
			vim.g.skip_ts_context_commentstring_module = true
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
}
