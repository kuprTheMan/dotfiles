local o = vim.o

-- ===============================
-- General
-- ===============================
o.backup = false
o.wrap = false
o.swapfile = false
o.smoothscroll = true
o.splitright = true
o.splitbelow = true
o.scrolloff = 5
o.mouse = ""
o.spelllang = "en_us"
o.clipboard = "unnamedplus"

-- ===============================
-- UTF-8
-- ===============================
o.encoding = "utf-8"
o.fileencoding = "utf-8"

-- ===============================
-- Indent&Tabs
-- ===============================
o.expandtab = true
o.cindent = true
o.smarttab = true
o.shiftwidth = 2
o.tabstop = 2

-- ===============================
-- Folding
-- ===============================
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldenable = false

-- ===============================
-- UI
-- ===============================
o.cursorline = true
o.showtabline = 0
o.termguicolors = true
o.colorcolumn = tostring(120)
o.signcolumn = "yes"
o.laststatus = 3
o.showmode = false
o.number = true
o.relativenumber = true
o.list = true
o.listchars = vim.o.listchars .. ",eol:¬"
o.fillchars = "eob: "
