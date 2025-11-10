return {
  {
    "lewis6991/gitsigns.nvim",
    event = "User InGitRepo",
    dependencies = {
      "tpope/vim-fugitive",
      keys = {
        { "<leader>gy", "<cmd>.GBrowse!<cr>", desc = "Copy link to current line" },
        { "<leader>gg", "<cmd>Gedit :<cr>", desc = "Open fugitive UI window" },
        { "<leader>gl", "<cmd>Git log --graph<cr>", desc = "Show git log" },
        { "<leader>gps", "<cmd>Git push", desc = "Push commit" },
        { "<leader>gpl", "<cmd>Git pull", desc = "Pull commits" },
      },
      dependencies = {
        "tpope/vim-rhubarb",
        "shumphrey/fugitive-gitlab.vim"
      }
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
      end,
    },
  },
}
