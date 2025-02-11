local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Nothing Space, only leader!!!
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Without clipboard
map("n", "C", '"_C')
map("n", "D", '"_D')
map("x", "p", '"_c<Esc>p')

-- Better remove actions
map("n", "dw", 'vb"_d')
map("n", "cd", "0D")
map("n", "x", '"_x')

-- Split
map("n", "|", "<cmd>vsplit<CR>", opts)
map("n", "_", "<cmd>split<CR>", opts)

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

-- Move to window using the <C-w> hjkl keys
map("n", "<leader>wh", "<C-w>h", { remap = true })
map("n", "<leader>wj", "<C-w>j", { remap = true })
map("n", "<leader>wk", "<C-w>k", { remap = true })
map("n", "<leader>wl", "<C-w>l", { remap = true })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==")
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==")
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi")
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi")
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv")
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv")

-- Tabs
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
