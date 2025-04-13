return {
  'stevearc/oil.nvim',
  -- Optional dependencies
  dependencies = {
    -- { "echasnovski/mini.icons", version = '*', opts = {} },
    { "nvim-tree/nvim-web-devicons" },
  },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = false,
    columns = {
      "icon",
    },
  },
}
