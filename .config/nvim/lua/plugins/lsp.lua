return {

  -- Formatter
  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    keys = {
      {
        "=",
        function()
          require("conform").format({ lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          c = { "clang_format" },
          cpp = { "clang_format" },
          go = { "goimports", "gofumpt" },
          proto = { "clang_format" },
          lua = { "stylua" },
        },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim",    opts = {} },
      { "mason-org/mason.nvim", cmd = "Mason", config = true },
    },
    config = function()
      local on_attach = function(client, bufnr)
        local map = function(keys, func, desc)
          if desc then
            desc = "LSP:" .. desc
          end
          vim.keymap.set("n", keys, func, { remap = true, buffer = bufnr, desc = desc, silent = true })
        end

        -- General LSP mappings
        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map("gy", vim.lsp.buf.type_definition, "[G]oto T[y]pe Definition")
        map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        map("grr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
        map("grn", vim.lsp.buf.rename, "[C]ode [R]ename")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("]d", vim.diagnostic.goto_next, "Go to Next Diagnostic, Message")
        map("[d", vim.diagnostic.goto_prev, "Go to Previous Diagnostic Message")
        map("<leader>D", vim.diagnostic.open_float, "Open floating diagnostic message")
        map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>wd", require("fzf-lua").diagnostics_workspace, "Find [W]orkspace [D]iagnostics")
        map("<leader>ca", require("fzf-lua").lsp_code_actions, "[C]ode [A]ction")
        map("<leader>lr", "<cmd>LspRestart<CR>", "[L]sp [R]estart")
      end

      -- Completion
      local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Diagnostic settings
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰚌 ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵 ",
          },
        },
        virtual_text = {
          severity = {
            min = vim.diagnostic.severity.ERROR,
            max = vim.diagnostic.severity.ERROR,
          },
        },
      })

      -- Your existing floating preview override
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = "single"
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      -- LSP's Settings
      local lspconfig = require "lspconfig"

      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
        capabilities = capabilities,
        on_attach = on_attach,
      }

      lspconfig.clangd.setup {
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
        },
        fallbackFlags = { "-Wextra", "-Wall", "-Wpedantic" },
        capabilities = capabilities,
        on_attach = on_attach,
      }

      lspconfig.gopls.setup {
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
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
              ST1003 = true,
            },
          },
        },
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- Ensure the servers above are installed
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = {
          -- lsp
          "clangd",
          "gopls",
          "lua_ls",
          "marksman",
        },
      }
    end,
  },
}
