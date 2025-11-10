vim.opt_local.expandtab = false
vim.opt_local.spell = false
vim.bo.formatprg = "gofumpt"

vim.api.nvim_buf_create_user_command(
  0,
  "GoLangCiLint",
  function(opts)
    local command = "run --fix=false --show-stats=false --output.tab.path=stdout --path-mode=abs"
    local binary = "golangci-lint"

    local core = require "kuprTheMan.functions.core"
    local config_path = core.find_first_present_file {
      "./.golangci.yml",
      "./.golangci.yaml",
      core.resolve_relative_to_dotfiles_dir "./config/.golangci.yml",
    }

    vim.cmd.Dispatch {
      "-compiler=make",
      string.format("%s %s --config %s %s", binary, command, config_path, opts.fargs[1]),
    }
  end,
  {
    nargs = 1
  }
)

vim.keymap.set("n", "<localleader>lf", "<cmd>GoLangCiLint %<cr>")

vim.keymap.set("n", "<leader>ta", function()
  vim.cmd.Dispatch { "go test -fullpath -failfast ./..." }
end, { desc = "[T]est [A]ll Packages" })

vim.keymap.set("n", "<leader>tt", function()
  vim.cmd.Dispatch { "go test -fullpath -failfast" .. vim.fn.expand "%:p:h" }
end, { desc = "[T]est [P]ackage" })
