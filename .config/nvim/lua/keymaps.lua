local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Without clipboard
map("n", "C", '"_C')
map("n", "D", '"_D')
map("x", "p", '"_c<Esc>p')

-- Better remove actions
map("n", "dw", 'vb"_d')
map("n", "x", '"_x')

-- Split
map("n", "\\", ":split<CR>", opts)
map("n", "|", ":vsplit<CR>", opts)

-- Clear hlsearch
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- Select All
map("n", "<leader>a", "gg<S-v>G")

-- Better indenting
map("x", "<S-tab>", "<gv")
map("x", "<tab>", ">gv|")

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { remap = true })
map("n", "<C-j>", "<C-w>j", { remap = true })
map("n", "<C-k>", "<C-w>k", { remap = true })
map("n", "<C-l>", "<C-w>l", { remap = true })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==")
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==")
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi")
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi")
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv")
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv")

-- tabs
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "L", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "H", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Exit terminal mode with Esc
map("t", "<esc><esc>", "<C-\\><C-n>", { nowait = true })
