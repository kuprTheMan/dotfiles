return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        strikethrough = false,
        dim_inactive = false,
        contrast = "hard",
        italic = {
          strings = false,
        },
        overrides = {
          SignColumn = { link = "GruvboxBg0" },
          CursorLineNr = { link = "GruvboxYellow" },
          DiagnosticVirtualTextError = { bg = "#581b1b", fg = "#fb4934" },
          -- DiagnosticVirtualTextWarn = { link = "GruvboxGray" },
          -- DiagnosticVirtualTextInfo = { link = "GruvboxGray" },
          -- DiagnosticVirtualTextHint = { link = "GruvboxGray" },
          DiagnosticSignError = { link = "GruvboxRed" },
          DiagnosticSignWarn = { link = "GruvboxYellow" },
          DiagnosticSignInfo = { link = "GruvboxBlue" },
          DiagnosticSignHint = { link = "GruvboxAqua" },
          IlluminatedWordText = { bg = "#526252" },
          IlluminatedWordWrite = { bg = "#625252" },
          IlluminatedWordRead = { bg = "#526252" },
          SpellBad = { undercurl = true, sp = "#928374" },
          ["@keyword.directive.define.cpp"] = { link = "GruvboxOrange" },
          ["@keyword.import.cpp"] = { link = "GruvboxOrange" },
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
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      vim.cmd("highlight AlphaRed    guifg=#fb4934")
      vim.cmd("highlight AlphaGreen  guifg=#b8bb26")
      vim.cmd("highlight AlphaTeal   guifg=#83a598")
      vim.cmd("highlight AlphaYellow guifg=#fabd2f")
      vim.cmd("highlight AlphaPink   guifg=#d3869b")

      dashboard.section.header.val = {
        "    _   __                _          ",
        "   / | / /__  ____ _   __(_)___ ___  ",
        "  /  |/ / _ \\/ __ \\ | / / / __  __ \\ ",
        " / /|  /  __/ /_/ / |/ / / / / / / / ",
        "/_/ |_|\\___/\\____/|___/_/_/ /_/ /_/  ",
      }
      dashboard.section.header.opts = {
        position = "center",
        hl = {
          { { "AlphaRed", 0, -1 } },
          { { "AlphaGreen", 0, -1 } },
          { { "AlphaTeal", 0, -1 } },
          { { "AlphaYellow", 0, -1 } },
          { { "AlphaPink", 0, -1 } },
        },
      }
      -- stylua: ignore
      dashboard.section.buttons.val = {
        dashboard.button("f", "   Find file", "<cmd>lua require('fzf-lua').files()<CR>"),
        dashboard.button("r", "   Grep text", "<cmd>lua require('fzf-lua').live_grep()<CR>"),
        dashboard.button("l", "󰒲   Lazy", "<cmd>Lazy<CR>"),
        dashboard.button("q", "   Quit", "<cmd>qa<CR>"),
      }

      dashboard.config.layout = {
        { type = "padding", val = 9 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
      }

      alpha.setup(dashboard.config)
    end,
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
