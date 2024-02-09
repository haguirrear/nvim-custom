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

    vim.keymap.set("n", "<leader>z", mark.add_file, { desc = "Mark file with Harpoon" })
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle Harpoon quick menu" })

    vim.keymap.set("n", "<M-1>", function() ui.nav_file(1) end, { desc = "Go to file 1 with Harpoon" })
    vim.keymap.set("n", "<M-2>", function() ui.nav_file(2) end, { desc = "Go to file 2 with Harpoon" })
    vim.keymap.set("n", "<M-3>", function() ui.nav_file(3) end, { desc = "Go to file 3 with Harpoon" })
    vim.keymap.set("n", "<M-4>", function() ui.nav_file(4) end, { desc = "Go to file 4 with Harpoon" })

    vim.keymap.set("n", "<C-M-n>", ui.nav_next, { desc = "Go to next Harpoon file" })
    vim.keymap.set("n", "<C-M-p>", ui.nav_prev, { desc = "Go to prev Harpoon file" })

    vim.keymap.set("n", "<M-h>", function() term.gotoTerminal(1) end, { desc = "Go to Terminal" })
    vim.keymap.set("n", "<M-b>", function() tmux.gotoTerminal("{down-of}") end, { desc = "Go to Terminal below" })
  end
}
-- vim: ts=2 sts=2 sw=2 et
