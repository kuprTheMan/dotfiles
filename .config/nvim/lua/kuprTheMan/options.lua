local opt = vim.opt

-- ===============================
-- General
-- ===============================
opt.backup = false
opt.wrap = false
opt.swapfile = false
opt.smoothscroll = true
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 10
opt.mouse = ""
opt.spelllang = "en_us"
opt.clipboard = "unnamedplus"

-- ===============================
-- UTF-8
-- ===============================
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- ===============================
-- Indent&Tabs
-- ===============================
opt.expandtab = true
opt.cindent = true
opt.smarttab = true
opt.shiftwidth = 2
opt.tabstop = 2

-- ===============================
-- Folding
-- ===============================
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldenable = false

-- ===============================
-- UI
-- ===============================
opt.cursorline = true
opt.showtabline = 0
opt.termguicolors = true
opt.colorcolumn = tostring(120)
opt.signcolumn = "yes"
opt.laststatus = 3
opt.showmode = false
opt.number = true
opt.relativenumber = true
opt.list = true
opt.listchars:append "eol:¬"
opt.fillchars = "eob: "
