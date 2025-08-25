return {
  "saghen/blink.cmp",
  version = '*',
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    config = function()
      local ls = require("luasnip")
      ls.config.set_config({
        updateevents = "TextChanged,TextChangedI",
      })
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
      list = { max_items = 30 },
      menu = {
        border = "none",
        draw = {
          columns = { { "label", gap = 1 }, { "kind" } },
        },
      },
      documentation = {
        window = { border = "single" },
      },
    },
    sources = {
      default = { "lsp", "snippets", "path" },
      per_filetype = {
        sql = { "dadbod", "buffer" },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },
    cmdline = { enabled = false }, -- Disable complition in cmd mode
    signature = {
      enabled = true,
      window = { border = "single" },
    },
    keymap = {
      preset = "super-tab",
    },
  },
}
