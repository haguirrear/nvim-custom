-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim: ts=2 sts=2 sw=2 et
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
vim.keymap.set('n', 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Custom keymaps
vim.keymap.set('n', '<leader>m', ':NvimTreeToggle<CR>', { desc = 'nvim-tree: Toggle tree' })
vim.keymap.set('n', '<ESC>', ":noh <CR>", { desc = "Clear highlights" })

-- Terminal
vim.keymap.set('t', '<C-x>', '<C-\\><C-n>',
  { noremap = true, silent = true, desc = "Exit terminal mode into normal mode" })


-- Movement
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Go half page down", noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Go half page up", noremap = true })

-- Buffers
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Go to prev buffer" })
vim.keymap.set("n", "<leader>bk", ":%bd|e#<CR>", { desc = "Close all buffers except current" })

-- Paste without reseting paste register
require("which-key").add({
  { "<leader>p", "\"_dP", desc = "Paste without reseting paste register", mode = "x", noremap = true }
})

-- Toggle line numbers
function ToggleLineNumbers()
  if not vim.wo.relativenumber then
    print("Setting relative number")
    vim.wo.relativenumber = true
    vim.wo.nu = true
  else
    print("Setting absolute number")
    vim.wo.number = true
    vim.wo.relativenumber = false
  end
end

vim.keymap.set('n', '<leader>tm', ':lua ToggleLineNumbers()<CR>',
  { desc = "Toggle line numbers", noremap = true, silent = true })

-- vim: ts=2 sts=2 sw=2 et
