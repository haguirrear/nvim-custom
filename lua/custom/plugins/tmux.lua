-- tmux.lua
--
-- Use tmux movements to jump between windows
return {
  "nathom/tmux.nvim",
  config = function()
    -- Movement
    local map = vim.api.nvim_set_keymap
    map("n", "<C-h>", [[<cmd>lua require('tmux').move_left()<cr>]], { desc = "Move left with tmux" })
    map("n", "<C-j>", [[<cmd>lua require('tmux').move_down()<cr>]], { desc = "Move down with tmux" })
    map("n", "<C-k>", [[<cmd>lua require('tmux').move_up()<cr>]], { desc = "Move up with tmux" })
    map("n", "<C-l>", [[<cmd>lua require('tmux').move_right()<cr>]], { desc = "Move right with tmux" })
  end
}

-- vim: ts=2 sts=2 sw=2 et
