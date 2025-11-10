local Path = require "plenary.path"

local M = {}

local function dotfiles_path()
  local path_from_env = vim.fn.environ().DOT
  return Path:new(path_from_env)
end

function M.find_first_present_file(fileList)
  for _, filePath in ipairs(fileList) do
    if vim.fn.filereadable(filePath) == 1 then
      return filePath
    end
  end
  return nil
end

function M.get_dotfiles_dir()
  return dotfiles_path():expand()
end

function M.resolve_relative_to_dotfiles_dir(path)
  local plenary_path = dotfiles_path()
  return (plenary_path / path):expand()
end

return M
