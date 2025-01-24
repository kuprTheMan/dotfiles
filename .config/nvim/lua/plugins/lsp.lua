return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = {
			{ "j-hui/fidget.nvim", opts = {} },
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local on_lsp_attach = function(_, bufnr)
				local map = function(keys, func, desc)
					if desc then
						desc = "LSP:" .. desc
					end
					vim.keymap.set("n", keys, func, { remap = true, buffer = bufnr, desc = desc, silent = true })
				end

				-- General LSP mappings
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				map("gD", vim.lsp.buf.definition, "[G]oto [D]eclaration")
				map("gy", vim.lsp.buf.type_definition, "[G]oto T[y]pe Definition")
				map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
				map("[d", vim.diagnostic.goto_prev, "Go to Previous Diagnostic Message")
				map("]d", vim.diagnostic.goto_next, "Go to Next Diagnostic, Message")
				map("<C-u>", vim.lsp.buf.signature_help, "Signature help")
				map("<leader>cd", vim.diagnostic.open_float, "Open floating diagnostic message")
				map("<leader>ca", require("fzf-lua").lsp_code_actions, "[C]ode [A]ction")
				map("<leader>cr", require("renamer").rename, "[C]ode [R]ename")
				map("<leader>ls", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ll", vim.diagnostic.setloclist, "Put diagnostic to qf list")
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

			local signs = { Error = "󰚌 ", Warn = " ", Hint = "󱧡 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- Your existing floating preview override
			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = "rounded"
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end

			-- Ensure the servers above are installed
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_lsp_attach,
						settings = servers[server_name],
						single_file_support = (servers[server_name] or {}).single_file_support,
						filetypes = (servers[server_name] or {}).filetypes,
						cmd = (servers[server_name] or {}).cmd,
						init_options = (servers[server_name] or {}).init_options,
					})
				end,
			})
		end,
	},
}
