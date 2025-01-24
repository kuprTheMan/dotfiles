return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
      -- stylua: ignore
      keys = {
          { ";f", "<cmd>FzfLua files<CR>", desc = "Find Files (Root Dir)" },
          { ";r", "<cmd>FzfLua live_grep<CR>", desc = "Grep (Root Dir)" },
          { ";;", function() require("fzf-lua").resume() end, desc = "Resume", },
          { "<leader>b", "<cmd>FzfLua tabs<CR>", desc = "Open tabs" },
        },
	opts = {
		async = true, -- Enable async for fzf
		defaults = {
			file_icons = true,
			git_icons = true,
			color_icons = true,
			prompt = " ",
			formatter = "path.filename_first",
		},
		fzf_opts = {
			["--no-info"] = "",
			["--info"] = "hidden",
			["--layout"] = "reverse-list",
			["--padding"] = "2%,2%,2%,2%",
		},
		winopts = {
			height = 0.8,
			width = 0.9,
			preview = {
				layout = "vertical",
				vertical = "right:50%",
				scrollbar = false,
			},
			border = "rounded",
		},
		files = {
			cwd_prompt = false,
		},
		lsp = {
			code_actions = {
				prompt = " ",
        previewer = false,
				winopts = {
					width = 0.4,
					height = 0.3,
				},
			},
		},
	},
}
