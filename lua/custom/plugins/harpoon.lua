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
    -- local term = require("harpoon.term")
    -- local tmux = require("harpoon.tmux")

    vim.keymap.set("n", "<leader>z", mark.add_file, { desc = "Mark file with Harpoon" })
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle Harpoon quick menu" })

    for i = 1, 9 do
      vim.keymap.set("n", string.format("<leader>%d", i), function() ui.nav_file(i) end,
        { desc = string.format("Go to file %d with Harpoon", i) })
    end

    vim.keymap.set("n", "<C-A-n>", ui.nav_next, { desc = "Go to next Harpoon file" })
    vim.keymap.set("n", "<C-A-p>", ui.nav_prev, { desc = "Go to prev Harpoon file" })

    -- vim.keymap.set("n", "<A-h>", function() term.gotoTerminal(1) end, { desc = "Go to Terminal" })
    -- vim.keymap.set("n", "<A-b>", function() tmux.gotoTerminal("{down-of}") end, { desc = "Go to Terminal below" })
  end
}
-- vim: ts=2 sts=2 sw=2 et
