return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    {
      "RRethy/vim-illuminate",
      lazy = true,
      config = function()
        require("illuminate").configure({
          delay = 250,
          modes_allowlist = { "n" },
          filetypes_denylist = {
            "fugitive",
            "oil",
            "qf",
          },
        })
      end,
    },
  },
  build = function()
    local ts_update = require("nvim-treesitter.install").update({
      with_sync = true,
    })
    ts_update()
  end,

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        -- language
        "c",
        "cpp",
        "go",
        "cmake",
        "gosum",
        "gowork",
        "gomod",
        "lua",
        "sql",
        "python",
        -- markup
        "vimdoc",
        "markdown",
        "markdown_inline",
        -- utility
        "csv",
        "json",
        "diff",
        "proto",
        "yaml",
        "make",
        "query",
        "dockerfile",
      },
      indent = { enable = true },
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      fold = { enabe = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["ap"] = "@parameter.outer",
            ["ip"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["as"] = "@statement.outer",
            ["is"] = "@statement.inner",
            ["av"] = "@assignment.outer",
            ["iv"] = "@assignment.inner",
            ["in"] = "@assignment.lhs",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]i"] = "@conditional.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]I"] = "@conditional.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[i"] = "@conditional.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[I"] = "@conditional.outer",
          },
        },
      },
    })
  end,
}
