return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  dependencies = {
    "JezerM/oil-lsp-diagnostics.nvim"
  },
  keys = {
    { "<leader>e", "<cmd>Oil<CR>", silent = true, desc = "Open Oil" },
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
      for line in handle:lines("*l") do
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
    require("oil").setup({
      keymaps = {
        ["<C-i>"] = "actions.select",
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
    })
  end,
}
