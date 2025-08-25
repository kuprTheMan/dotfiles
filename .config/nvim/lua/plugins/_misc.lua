return {
  -- Helpers
  "nvim-lua/plenary.nvim",

  -- Better Movement
  {
    "smoka7/hop.nvim",
    keys = {
      {
        "<leader>f",
        function()
          require("hop").hint_char2({ current_line_only = false })
        end,
        { remap = true },
      },
      {
        "f",
        function()
          require("hop").hint_char1({
            require("hop.hint").HintDirection.AFTER_CURSOR,
            current_line_only = true,
          })
        end,
        { remap = true },
      },
      {
        "F",
        function()
          require("hop").hint_char1({
            require("hop.hint").HintDirection.BEFORE_CURSOR,
            current_line_only = true,
          })
        end,
        { remap = true },
      },
    },
    opts = {},
  },

  {
    "windwp/nvim-autopairs",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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
    -- stylua: ignore
    keys = {
      { "<leader>tl", "<cmd>TodoLocList<CR>", desc = "Show todo list with qf" }
    },
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

  -- Super-Replace
  -- {
  --   "MagicDuck/grug-far.nvim",
  --   cmd = "GrugFar",
  --   keys = {
  --     {
  --       "<leader>sr",
  --       function()
  --         local grug = require("grug-far")
  --         local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  --         grug.open({
  --           transient = true,
  --           prefills = {
  --             filesFilter = ext and ext ~= "" and "*." .. ext or nil,
  --           },
  --         })
  --       end,
  --       mode = { "n", "v" },
  --     },
  --   },
  --   opts = {},
  -- },

  {
    "mbbill/undotree",
    keys = {
      { mode = "n", "<leader>u", "<cmd>UndotreeToggle<CR>" }
    }
  },

  -- Hl Words
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

  -- Build, Test, Run, Repeat
  {
    "tpope/vim-dispatch",
    cmd = "Dispatch",
  },
}
