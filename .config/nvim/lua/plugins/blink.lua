return {
	"saghen/blink.cmp",
	version = "v0.*",
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	opts = {
		completion = {
			accept = {
				auto_brackets = { enabled = true },
			},
			menu = {
				draw = {
					components = {
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
								return kind_icon
							end,
							highlight = function(ctx)
								local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
								return hl
							end,
						},
					},
				},
			},
			documentation = {
				window = {
					border = "rounded",
				},
			},
		},
		sources = {
			default = { "lsp", "path", "snippets" },
			cmdline = {}, -- Disable complition in cmd mode
		},
		signature = { enabled = false }, -- Experimental
		keymap = {
			preset = "super-tab",
		},
	},
}
