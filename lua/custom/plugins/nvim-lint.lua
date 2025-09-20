return {
  "mfussenegger/nvim-lint",
  dependencies = {
    "williamboman/mason.nvim",
  },
  enabled = false,
  config = function()
    local lint = require "lint"

    lint.linters_by_ft = {
      python = { "mypy" }
    }

    -- mypy_opts = {
    --   -- "--strict",
    --   -- "--check-untyped-defs",
    -- }
    --
    -- for _, arg in ipairs(mypy_opts) do
    --   table.insert(lint.linters.mypy.args, arg)
    -- end

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()

        -- You can call `try_lint` with a linter name or a list of names to always
        -- run specific linters, independent of the `linters_by_ft` configuration
        -- require("lint").try_lint("cspell")
      end,
    })

    local function runLint()
      require("lint").try_lint()
    end

    vim.keymap.set("n", "<leader>l", runLint, { noremap = true, desc = "Run Linter (Python)" })
    -- vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>lua require('lint').try_lint()<CR>",
    --   { noremap = true, desc = "Run Linter (Python)" })
  end
}
