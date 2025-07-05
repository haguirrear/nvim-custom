-- setup formatters with conform

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      graphql = { "prettier", stop_after_first = true },
      javascript = {
        "prettier",
        -- stop_after_first = true,
        -- extra_args = {
        --   "--semi", "true",
        -- }
      },
      css = {
        "prettier"
      },
      typescript = { "prettier" },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      -- if not vim.g.format_is_enabled or not vim.b[bufnr].format_is_enabled then
      if not vim.g.format_is_enabled then
        print("not formatting with conform")
        return
      end
      print("formatting with conform")
      return { timeout_ms = 500, lsp_format = "fallback" }
    end
    -- Customize formatters
    -- formatters = {
    --   shfmt = {
    --     prepend_args = { "-i", "2" },
    --   },
    -- },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,

  -- config = function()
  --   require("conform").setup({
  --     format_on_save = function(bufnr)
  --       -- Disable with a global or buffer-local variable
  --       if not vim.g.format_is_enabled or not vim.b[bufnr].format_is_enabled then
  --         return
  --       end
  --       return { timeout_ms = 500, lsp_format = "fallback" }
  --     end,
  --     formatters_by_ft = {
  --       graphql = { "prettier", stop_after_first = true },
  --       javascript = {
  --         "prettier",
  --         -- stop_after_first = true,
  --         -- extra_args = {
  --         --   "--semi", "true",
  --         -- }
  --       },
  --       typescript = { "prettier" },
  --     },
  --   })
  --
  --   -- vim.api.nvim_create_autocmd("BufWritePre", {
  --   --   pattern = { "*.graphql", "*.js", "*.ts" },
  --   --   callback = function(args)
  --   --     print("formatting with conform")
  --   --     require("conform").format({
  --   --       bufnr = args.buf,
  --   --       timeout_ms = 5000,
  --   --       lsp_format = "fallback"
  --   --     })
  --   --   end
  --   -- })
  -- end
}
