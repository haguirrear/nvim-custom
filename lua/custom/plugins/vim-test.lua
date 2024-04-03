return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
  },
  vim.keymap.set('n', '<leader>tn', ':TestNearest<CR>', { desc = "Test Nearest test to cursor or last nearest test" }),
  vim.keymap.set('n', '<leader>tt', ':TestFile<CR>', { desc = "Test current File or run the last file tests" }),
  vim.keymap.set('n', '<leader>ta', ':TestSuite<CR>', { desc = "Test whole Suite" }),
  vim.keymap.set('n', '<leader>tl', ':TestLast<CR>', { desc = "Test last" }),
  vim.keymap.set('n', '<leader>tv', ':TestVisit<CR>', { desc = "Test Visit" }),
  vim.cmd("let test#strategy='vimux'"),

  -- For Promt for a command in vimux
  vim.keymap.set('n', '<leader>xx', ':VimuxPromptCommand<CR>', { desc = "Prompt for a command to run in a tmux panel" }),
  vim.keymap.set('n', '<leader>xl', ':VimuxRunLastCommand<CR>', { desc = "Run Last command" }),
  vim.keymap.set('n', '<leader>xt', ':VimuxTogglePane<CR>', { desc = "Toggle Pane" }),
}
