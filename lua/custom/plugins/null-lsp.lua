-- Null lsp only for certain formattings
--

return {
  'jose-elias-alvarez/null-ls.nvim',
  config = function()
    null_ls = require("null-ls")

    -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    -- local format_on_save = true

    -- function ToggleAutoformat()
    --   format_on_save = not format_on_save
    --   print("Autoformatting on save is " .. (format_on_save and "enabled" or "disabled"))
    -- end

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.prettier,
      }
    })
  end,
  requires = { "nvim-lua/plenary.nvim" },

}


-- vim: ts=2 sts=2 sw=2 et
