return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader>ff",        "<cmd>FzfLua files<CR>",                    desc = "Find Files (Root Dir)" },
    { "<leader>fg",        "<cmd>FzfLua live_grep<CR>",                desc = "Grep (Root Dir)" },
    { "<leader>ft",        "<cmd>TodoFzfLua<CR>",                      desc = "Todo List" },
    { "<leader>fr",        function() require("fzf-lua").resume() end, desc = "Resume", },
    { "<leader>fb", "<cmd>FzfLua buffers<CR>",                     desc = "Open tabs" },
  },
  config = function()
    require("fzf-lua").register_ui_select()
  end
}
