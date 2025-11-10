local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- No Space, only leader!!!
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Without clipboard
map("n", "C", '"_C')
map("n", "D", '"_D')
map("x", "p", '"_c<Esc>p')

-- Better remove actions
map("n", "dw", 'vb"_d')
map("n", "cd", "0D")
map("n", "x", '"_x')

-- Clear hlsearch
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- Copy file content
map("n", "<leader>a", "gg<S-v>G")

-- Better indenting
map("x", "<S-tab>", "<gv")
map("x", "<tab>", ">gv|")

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==")
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==")
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv")
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv")

-- Tabs
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- Funny Things
map("n", "<localleader>sc", function()
  vim.opt_local.spell = not (vim.opt_local.spell:get())
  vim.notify("spell: " .. tostring(vim.o.spell))
end)
