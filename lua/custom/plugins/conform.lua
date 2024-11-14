-- setup formatters with conform

return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        graphql = { "prettier", stop_after_first = true }
      },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.graphql" },
      callback = function(args)
        print("formatting with conform")
        require("conform").format({
          bufnr = args.buf,
          timeout_ms = 5000,
          lsp_format = "fallback"
        })
      end
    })
  end
}
