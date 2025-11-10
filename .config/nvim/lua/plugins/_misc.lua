return {
  -- helpers
  "nvim-lua/plenary.nvim",

  {
    "windwp/nvim-autopairs",
    event = { "bufreadpost", "bufwritepost", "bufnewfile" },
    dependencies = {
      { "kylechui/nvim-surround", opts = {} },
    },
    opts = {
      enable_check_bracket_line = false,
    },
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      keywords = {
        TODO = {
          alt = { "TODO", "todo", "FIX", "fix" }
        }
      }
    },
  },

  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  {
    "mbbill/undotree",
    keys = {
      { mode = "n", "<leader>u", "<cmd>UndotreeToggle<CR>" }
    }
  },

  -- DB Integration
  {
    "kristijanhusak/vim-dadbod-ui",
    lazy = true,
    cmd = { "DB", "DBUI" },
    ft = { "sql", "plsql" },
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    }
  },

  -- Build, Test, Run, Repeat
  {
    "tpope/vim-dispatch",
    cmd = "Dispatch",
  },
}
