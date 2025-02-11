return {
	"saghen/blink.cmp",
	version = "v0.*",
  event = "InsertEnter",
	dependencies = {
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		config = function()
			local ls = require("luasnip")
			ls.config.set_config({
				updateevents = "TextChanged,TextChangedI",
			})
			require("luasnip.loaders.from_snipmate").lazy_load()
			require("luasnip.loaders.from_lua").lazy_load({
				paths = "~/.config/nvim/snippets/",
			})
		end,
	},
	opts = {
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		snippets = { preset = "luasnip" },
		completion = {
			accept = {
				auto_brackets = { enabled = true },
			},
			menu = {
				border = "none",
				draw = {
					columns = { { "kind_icon" }, { "label", gap = 1 } },
				},
			},
			documentation = {
				window = {
					border = "single",
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
