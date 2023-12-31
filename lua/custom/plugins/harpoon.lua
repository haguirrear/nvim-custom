-- Harpoon
--
return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    local term = require("harpoon.term")
    local tmux = require("harpoon.tmux")

    vim.keymap.set("n", "<leader>m", mark.add_file)
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

    vim.keymap.set("n", "<M-1>", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<M-2>", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<M-3>", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<M-4>", function() ui.nav_file(4) end)

    vim.keymap.set("n", "<C-M-n>", ui.nav_next)
    vim.keymap.set("n", "<C-M-p>", ui.nav_prev)

    vim.keymap.set("n", "<M-h>", function() term.gotoTerminal(1) end)
    vim.keymap.set("n", "<M-b>", function() tmux.gotoTerminal("{down-of}") end)
  end
}
-- vim: ts=2 sts=2 sw=2 et
