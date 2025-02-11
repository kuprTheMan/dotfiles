return {
	{
		"lewis6991/gitsigns.nvim",
		event = "User InGitRepo",
		dependencies = {
			"tpope/vim-rhubarb",
			{
				"tpope/vim-fugitive",
				keys = {
					{ "<leader>gl", "<cmd>.GBrowse!<cr>", desc = "Copy link to current line" },
				},
			},
		},
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "󰍴" },
				topdelete = { text = "󰍴" },
				changedelete = { text = "~" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "󰍴" },
				topdelete = { text = "󰍴" },
				changedelete = { text = "~" },
			},
			on_attach = function(buffer)
				local gitsigns = require("gitsigns")
				local function map(keys, func, desc, opts)
					opts = opts or {}
					opts.buffer = buffer
					if desc then
						desc = "GS:" .. desc
					end
					vim.keymap.set("n", keys, func, { desc = desc })
				end
				map("]g", gitsigns.prev_hunk, "[G]o to [P]revious Hunk")
				map("[g", gitsigns.next_hunk, "[G]it go to [N]ext Hunk")
				map("<leader>gd", gitsigns.preview_hunk, "[G]it [D]iff Hunk")
				map("<leader>gr", gitsigns.reset_hunk, "[G]it [R]eset hunk")
				map("<leader>gu", gitsigns.undo_stage_hunk, "[G]it [U]nstage hunk")
				map("<leader>gs", gitsigns.stage_hunk, "[G]it [S]tage hunk")
				map("<leader>gb", gitsigns.toggle_current_line_blame, "[G]it [B]lame")
			end,
		},
	},
}
