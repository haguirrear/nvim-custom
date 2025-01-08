-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- preselect = cmp.PreselectMode.None, -- Ignore LSP preselected item (sometimes it is not the first one)
  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' }
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'buffer' },
  },
  window = {
    documentation = cmp.config.window.bordered(),
  }
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
--  THIS WAS BREAKING
-- cmp.setup.cmdline({ '/', '?' }, {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     {
--       name = 'buffer',
--       get_bufnrs = function()
--         local buf = vim.api.nvim_get_current_buf()
--         local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
--         if byte_size > 1024 * 1024 then -- 1 Megabyte max
--           return {}
--         end
--         return { buf }
--       end
--
--     }
--   }
-- })

-- vim: ts=2 sts=2 sw=2 et
