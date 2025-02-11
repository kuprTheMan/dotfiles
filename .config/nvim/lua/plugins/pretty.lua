return {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		opts = function()
			require("gruvbox").setup({
				strikethrough = false,
				italic = {
					strings = false,
				},
				overrides = {
					Normal = { bg = "#1a1a1a" },
					NormalNC = { bg = "#2a2a2a" }, -- dim_inactive
					SignColumn = { link = "GruvboxBg0" },
					WinSeparator = { bg = "none" },
					CursorLineNr = { bg = "none", fg = "#d5c4a1" },
					DiagnosticVirtualTextError = { bg = "#581b1b", fg = "#fb4934" },
					-- DiagnosticVirtualTextWarn = { link = "GruvboxGray" },
					-- DiagnosticVirtualTextInfo = { link = "GruvboxGray" },
					-- DiagnosticVirtualTextHint = { link = "GruvboxGray" },
					DiagnosticSignError = { bg = "none", fg = "#fb4934" },
					DiagnosticSignWarn = { bg = "none", fg = "#fabd2f" },
					DiagnosticSignInfo = { bg = "none", fg = "#83a598" },
					DiagnosticSignHint = { bg = "none", fg = "#8ec07c" },
					IlluminatedWordText = { bg = "#526252" },
					IlluminatedWordWrite = { bg = "#625252" },
					IlluminatedWordRead = { bg = "#526252" },
					SpellBad = { undercurl = true, sp = "#928374" },
				},
			})
			vim.cmd.colorscheme("gruvbox")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				disabled_filetypes = {
					statusline = { "alpha" },
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					{ "filename", path = 4 },
					{ "diff" },
				},
				lualine_x = { "diagnostics" },
				lualine_y = {
					"progress",
				},
				lualine_z = {
					{ "location" },
				},
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = {
				show_start = false,
				show_end = false,
			},
		},
	},

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			require("alpha.term")

			dashboard.section.terminal.command = vim.fn.stdpath("config") .. "/logo"
			dashboard.section.terminal.width = 37
			dashboard.section.terminal.height = 5
			dashboard.section.terminal.opts.redraw = true
			dashboard.section.terminal.opts.window_config.zindex = 1
        -- stylua: ignore
        dashboard.section.buttons.val = {
          dashboard.button("f", "   Find file", "<cmd>lua require('fzf-lua').files()<CR>"),
          dashboard.button("r", "   Grep text", "<cmd>lua require('fzf-lua').live_grep()<CR>"),
          dashboard.button("c", "   Config", "<cmd>lua require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })<CR>"),
          dashboard.button("l", "󰒲   Lazy", "<cmd>Lazy<CR>"),
          dashboard.button("q", "   Quit", "<cmd>qa<CR>"),
        }

			dashboard.config.layout = {
				{ type = "padding", val = 8 },
				dashboard.section.terminal,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
			}

			alpha.setup(dashboard.config)
		end,
	},

	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
}
