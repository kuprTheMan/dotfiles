return {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		opts = function()
			require("gruvbox").setup({
				contrast = "hard",
				transparent_mode = false,
				italic = {
					strings = false,
					comments = true,
					folds = false,
				},
				overrides = {
					SignColumn = { link = "GruvboxBg0" },
					Normal = { bg = "#0E1018" },
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
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				mode = "tabs",
				show_buffer_close_icons = false,
				show_close_icon = false,
				always_show_bufferline = false,
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
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
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				override = function(conf)
					conf.col = -1
					conf.row = 0
					return conf
				end,
			},
			select = {
				backend = "nui",
			},
		},
	},

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
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
