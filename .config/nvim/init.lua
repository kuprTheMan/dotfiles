-- [[Core]]
require "options"
require "keymaps"
require "autocmds"

-- [[Lazy Boorstrap]]
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {

  -- [[Lazy settings]]
  install = { colorscheme = { "gruvbox" } },
  checker = {
    enabled = false,
    notify = false,
  },
  ui = { border = "rounded" },

  -- [[Plugins]]
  spec = {
    -- Helpers
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    -- Utilitty
    "LunarVim/bigfile.nvim",

    -- Colorscheme
    {
      "ellisonleao/gruvbox.nvim",
      lazy = false,
      priority = 1000,
      opts = function()
        require("gruvbox").setup {
          transparent_mode = true,
          italic = {
            strings = false,
            comments = true,
            folds = false,
          },
          overrides = {
            SignColumn = { bg = none },
          },
        }
        vim.cmd.colorscheme "gruvbox"
      end,
    },

    -- Explorer
    {
      "stevearc/oil.nvim",
      cmd = "Oil",
      keys = {
        { "<leader>e", "<cmd>Oil --float<CR>", silent = true, desc = "Open Oil" },
      },
      config = function()
        local function get_git_ignored_files_in(dir)
          local found = vim.fs.find(".git", {
            upward = true,
            path = dir,
          })
          if #found == 0 then
            return {}
          end

          local cmd = string.format(
            'git -C %s ls-files --ignored --exclude-standard --others --directory | grep -v "/.*\\/"',
            dir
          )

          local handle = io.popen(cmd)
          if handle == nil then
            return
          end

          local ignored_files = {}
          for line in handle:lines "*l" do
            line = line:gsub("/$", "")
            table.insert(ignored_files, line)
          end
          handle:close()

          return ignored_files
        end

        local cache = {}

        local function cached_get_git_ignored_files_in(dir)
          local val
          val = cache[dir]
          if val then
            return val
          end
          val = get_git_ignored_files_in(dir)
          cache[dir] = val
          return val
        end
        require("oil").setup {
          keymaps = {
            ["yp"] = {
              desc = "Copy filepath to system clipboard",
              callback = function()
                require("oil.actions").copy_entry_path.callback()
                vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
                vim.notify("Copied full path", "info", { title = "Oil" })
              end,
            },
          },
          view_options = {
            show_hidden = true,
            is_hidden_file = function(name, _)
              local ignored_files = cached_get_git_ignored_files_in(require("oil").get_current_dir())
              return vim.tbl_contains(ignored_files, name) or vim.startswith(name, ".")
            end,
          },
          default_file_explorer = false,
          lsp_file_methods = {
            autosave_changes = true,
          },
        }
      end,
    },

    -- Better Movement
    {
      "ggandor/leap.nvim",
      -- stylua: ignore
      keys = {
        { "s", mode = { "n", "x", "o" }, "<Plug>(leap-forward)" },
        { "S", mode = { "n", "o", "x" }, "<Plug>(leap-backward)" },
      },
      opts = {},
    },

    {
      "echasnovski/mini.pairs",
      event = { "BufReadPost", "BufNewFile" },
      opts = {
        modes = { insert = true, command = true },
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        skip_ts = { "string" },
        skip_unbalanced = true,
        markdown = true,
      },
    },

    {
      "echasnovski/mini.surround",
      event = { "BufReadPost", "BufNewFile" },
      recommended = true,
      opts = {
        mappings = {
          add = "gsa",
          delete = "gsd",
          find = "gsf",
          find_left = "gsF",
          highlight = "gsh",
          replace = "gsr",
          update_n_lines = "gsn",
        },
      },
    },

    -- Git
    {
      "lewis6991/gitsigns.nvim",
      dependencies = {
        "tpope/vim-rhubarb",
        {
          "tpope/vim-fugitive",
          keys = {
            { "<leader>gl", "<cmd>.GBrowse!<cr>", desc = "Copy link to current line" },
          },
        },
        {
          "mbbill/undotree",
          keys = {
            {
              mode = "n",
              "<leader>ut",
              "<cmd>UndotreeToggle<CR>",
              desc = "Open/Close UndoTree",
            },
          },
        },
      },
      event = "User InGitRepo",
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
          local gitsigns = require "gitsigns"
          local function gsmap(keys, func, desc, opts)
            opts = opts or {}
            opts.buffer = buffer
            if desc then
              desc = "GS:" .. desc
            end
            vim.keymap.set("n", keys, func, { desc = desc })
          end
          gsmap("]g", gitsigns.prev_hunk, "[G]o to [P]revious Hunk")
          gsmap("[g", gitsigns.next_hunk, "[G]it go to [N]ext Hunk")
          gsmap("<leader>gd", gitsigns.preview_hunk, "[G]it [D]iff Hunk")
          gsmap("<leader>gr", gitsigns.reset_hunk, "[G]it [R]eset hunk")
          gsmap("<leader>gu", gitsigns.undo_stage_hunk, "[G]it [U]nstage hunk")
          gsmap("<leader>gs", gitsigns.stage_hunk, "[G]it [S]tage hunk")
          gsmap("<leader>gb", gitsigns.toggle_current_line_blame, "[G]it [B]lame")
        end,
      },
    },

    {
      "folke/todo-comments.nvim",
      event = { "BufReadPost", "BufNewFile" },
      opts = {},
      -- stylua: ignore
      keys = {
        { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
        { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      },
    },

    -- {
    --   "smjonas/inc-rename.nvim",
    --   cmd = "IncRename",
    --   opts = {
    --     input_buffer_type = "dressing",
    --   },
    -- },

    -- Auto complete
    {
      "saghen/blink.cmp",
      version = "v0.*",
      event = "InsertEnter",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
      opts = {
        completion = {
          accept = {
            auto_brackets = { enabled = true },
          },
          menu = {
            draw = {
              components = {
                kind_icon = {
                  ellipsis = false,
                  text = function(ctx)
                    local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                    return kind_icon
                  end,
                  highlight = function(ctx)
                    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                    return hl
                  end,
                },
              },
            },
          },
          documentation = {
            window = {
              border = "rounded",
            },
          },
        },
        keymap = {
          preset = "super-tab",
        },
      },
    },

    {
      "ibhagwan/fzf-lua",
      cmd = "FzfLua",
      -- stylua: ignore
      keys = {
          { ";f", "<cmd>FzfLua files<CR>", desc = "Find Files (Root Dir)" },
          { ";r", "<cmd>FzfLua live_grep<CR>", desc = "Grep (Root Dir)" },
          { ";;", function() require("fzf-lua").resume() end, desc = "Resume", },
        },
    },

    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      opts = {
        options = {
          disabled_filetypes = {
            statusline = { "alpha" },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            { "filename", path = 4 },
            { "diff" },
          },
          lualine_x = { "diagnostics" },
          lualine_y = {
            "progress",
          },
          lualine_z = {
            { "location" },
          },
        },
      },
    },

    {
      "akinsho/bufferline.nvim",
      event = "VeryLazy",
      opts = {
        options = {
          mode = "tabs",
          show_buffer_close_icons = false,
          show_close_icon = false,
          always_show_bufferline = false,
        },
      },
    },

    {
      "RRethy/vim-illuminate",
      config = function()
        require("illuminate").configure {
          modes_allowlist = { "n" },
          vim.cmd [[
                augroup illuminate_augroup
                    autocmd!
                    autocmd VimEnter * hi illuminatedWordRead cterm=none gui=none guibg=#526252
                    autocmd VimEnter * hi illuminatedWordText cterm=none gui=none guibg=#525252
                    autocmd VimEnter * hi illuminatedWordWrite cterm=none gui=none guibg=#625252
                augroup END
            ]],
        }
      end,
    },

    {
      "lukas-reineke/indent-blankline.nvim",
      event = { "BufReadPost", "BufNewFile" },
      main = "ibl",
      opts = {
        indent = {
          char = "│",
        },
        scope = {
          show_start = false,
          show_end = false,
        },
      },
    },

    -- Lua
    {
      "folke/zen-mode.nvim",
      keys = { "<leader>z", "<cmd>ZenMode<cr>" },
    },

    {
      "stevearc/dressing.nvim",
      event = "VeryLazy",
      opts = {
        input = {
          override = function(conf)
            conf.col = -1
            conf.row = 0
            return conf
          end,
        },
        select = {
          backend = "nui",
        },
      },
    },

    {
      "goolord/alpha-nvim",
      event = "VimEnter",
      config = function()
        local alpha = require "alpha"
        local dashboard = require "alpha.themes.dashboard"

        -- stylua: ignore
        dashboard.section.buttons.val = {
          dashboard.button("f", "   Find file", "<cmd>lua require('fzf-lua').files()<CR>"),
          dashboard.button("r", "   Grep text", "<cmd>lua require('fzf-lua').live_grep()<CR>"),
          dashboard.button("c", "   Config", "<cmd>lua require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })<CR>"),
          dashboard.button("l", "󰒲   Lazy", "<cmd>Lazy<CR>"),
          dashboard.button("q", "   Quit", "<cmd>qa<CR>"),
        }

        dashboard.config.layout = {
          { type = "padding", val = 13 }, -- Отступ после заголовка
          dashboard.section.buttons,
        }

        alpha.setup(dashboard.config)
      end,
    },

    {
      "echasnovski/mini.icons",
      lazy = true,
      opts = {},
      init = function()
        package.preload["nvim-web-devicons"] = function()
          require("mini.icons").mock_nvim_web_devicons()
          return package.loaded["nvim-web-devicons"]
        end
      end,
    },

    -- Toggler
    {
      "monaqa/dial.nvim",
      -- stylua: ignore
      keys = {
        { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
        { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
      },
      config = function()
        local augend = require "dial.augend"
        require("dial.config").augends:register_group {
          default = {
            augend.integer.alias.decimal,
            augend.integer.alias.hex,
            augend.date.alias["%Y/%m/%d"],
            augend.constant.alias.bool,
            augend.semver.alias.semver,
            augend.constant.new { elements = { "and", "or" } },
          },
        }
      end,
    },

    {
      "stevearc/conform.nvim",
      cmd = "ConformInfo",
      keys = {
        {
          "<leader>cf",
          function()
            require("conform").format { lsp_fallback = true }
          end,
          mode = { "n", "v" },
          desc = "Format Injected Langs",
        },
      },
      opts = function()
        require("conform").setup {
          formatters_by_ft = {
            c = { "clang_format" },
            cpp = { "clang_format" },
            go = { "goimports", "gofumpt" },
            lua = { "stylua" },
          },
        }
      end,
    },

    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      build = function()
        local ts_update = require("nvim-treesitter.install").update {
          with_sync = true,
        }
        ts_update()
      end,

      -- [[ Configure Treesitter ]]
      opts = function()
        require("nvim-treesitter.configs").setup {
          ensure_installed = {
            -- language
            "c",
            "cpp",
            "go",
            "gosum",
            "gowork",
            "gomod",
            "lua",
            "sql",
            "python",
            "nim",
            -- markup
            "vimdoc",
            "markdown",
            "markdown_inline",
            -- utility
            "csv",
            "json",
            "diff",
            "yaml",
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
          },
        }
      end,
    },

    {
      "numToStr/Comment.nvim",
      event = { "BufReadPost", "BufNewFile" },
      dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
      opts = function()
        vim.g.skip_ts_context_commentstring_module = true
        require("Comment").setup {
          pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        }
      end,
    },

    -- [[DAP config]]
    {
      "leoluz/nvim-dap-go",
      ft = "go",
      config = function()
        require("dap-go").setup()
      end,
    },

    {
      "mfussenegger/nvim-dap",
      dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
      },
      event = "LspAttach",
      config = function()
        local dap = require "dap"
        local dapui = require "dapui"
        local dapmap = function(keys, func, desc)
          if desc then
            desc = "DAP:" .. desc
          end
          vim.keymap.set("n", keys, func, { desc = desc })
        end

        vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapBreakpointCondition", { text = "🟠", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapLogPoint", { text = "🟡", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "", linehl = "DebugLine", numhl = "" })
        vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "", linehl = "", numhl = "" })

        require("dapui").setup()
        require("nvim-dap-virtual-text").setup()

        dapmap("<leader>dt", dap.terminate, "Stop debugging")
        dapmap("<leader>ds", dap.continue, "Stop debugging")
        dapmap("<leader>db", dap.toggle_breakpoint, "Set breakpoint")
        dapmap("<leader>do", dap.step_out, "Set breakpoint")
        dapmap("<leader>di", dap.step_into, "Set breakpoint")
        dapmap("<leader>du", dapui.toggle, "Toggle DAP-UI")
      end,
    },

    {
      "neovim/nvim-lspconfig",
      dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
      },
    },
  },
}

-- [[LSP config]]
local on_lsp_attach = function(_, bufnr)
  local lspmap = function(keys, func, desc)
    if desc then
      desc = "LSP:" .. desc
    end
    vim.keymap.set("n", keys, func, { remap = true, buffer = bufnr, desc = desc, silent = true })
  end

  -- General LSP mappings
  lspmap("K", vim.lsp.buf.hover, "Hover Documentation")
  lspmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  lspmap("gD", vim.lsp.buf.definition, "[G]oto [D]eclaration")
  lspmap("gy", vim.lsp.buf.type_definition, "[G]oto T[y]pe Definition")
  lspmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  lspmap("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
  lspmap("[d", vim.diagnostic.goto_prev, "Go to Previous Diagnostic Message")
  lspmap("]d", vim.diagnostic.goto_next, "Go to Next Diagnostic, Message")
  lspmap("<C-u>", vim.lsp.buf.signature_help, "Signature help")
  lspmap("<leader>cd", vim.diagnostic.open_float, "Open floating diagnostic message")
  lspmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  lspmap("<leader>sl", vim.diagnostic.setloclist, "Put diagnostic to qf list")
  lspmap("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
end

-- Enable & Setup the following language servers
local servers = {
  clangd = {
    filetypes = { "c", "cpp", "h", "hpp" },
    cmd = {
      "clangd",
      "--clang-tidy",
      "--background-index",
      "--pch-storage=memory",
      "--header-insertion=never",
      "--completion-style=detailed",
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
      fallbackFlags = { "-Wextra", "-Wall", "-Wpedantic" },
    },
  },
  lua_ls = {
    Lua = {
      codeLens = {
        enable = true,
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
  gopls = {
    settings = {
      gopls = {
        codelenses = {
          test = true,
          gc_details = true,
          generate = true,
          run_govulncheck = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        gofumpt = true,
        completeUnimported = true,
        usePlaceholders = false,
        diagnosticsDelay = "250ms",
        staticcheck = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          unusedparams = true,
          framepointer = true,
          sigchanyzer = true,
          unreachable = true,
          stdversion = true,
          unusedwrite = true,
          unusedvariable = true,
          useany = true,
          nilness = true,
        },
      },
    },
  },
  pylsp = {},
  marksman = {},
  nim_langserver = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local signs = { Error = "󰚌 ", Warn = " ", Hint = "󱧡 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Ensure the servers above are installed
local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = on_lsp_attach,
      settings = servers[server_name],
      single_file_support = (servers[server_name] or {}).single_file_support,
      filetypes = (servers[server_name] or {}).filetypes,
      cmd = (servers[server_name] or {}).cmd,
      init_options = (servers[server_name] or {}).init_options,
    }
  end,
}
