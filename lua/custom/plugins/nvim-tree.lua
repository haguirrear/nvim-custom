-- Nvim Tree
local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = false, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<M-n>', ':NvimTreeToggle<CR>', opts('Toggle tree'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      on_attach = my_on_attach,
      update_focused_file = {
        enable = true
      },
      filters = {
        dotfiles = true,
        git_ignored = true,
      },
      diagnostics = {
        enable = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
      git = {
        enable = true,
        timeout = 1000,
      }
    }
  end,
}
-- vim: ts=2 sts=2 sw=2 et
