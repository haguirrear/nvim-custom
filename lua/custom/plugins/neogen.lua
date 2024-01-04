return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require("neogen").setup({
      enabled = true,

    })
    vim.keymap.set("n", "<Leader>dc", ":lua require('neogen').generate()<CR>",
      { desc = "Generate [d]o[c]umentation strings" })
  end,
  -- Uncomment next line if you want to follow only stable versions
  version = "*"
}
