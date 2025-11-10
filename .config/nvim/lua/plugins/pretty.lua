return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("solarized-osaka").setup({
        transparent = false,
        lualine_bold = true,
      })
      vim.cmd.colorscheme("solarized-osaka")
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
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
        char = "┊",
        tab_char = "┊",
      },
      scope = {
        show_start = false,
        show_end = false,
      },
    },
  },

  {
    "echasnovski/mini.icons",
    lazy = true,
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    opts = {},
  },
}
