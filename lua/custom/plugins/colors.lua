-- Here we will install colroschemes
--

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      -- transparent_background = true,
      -- custom_highlights = function(colors)
      --   return {
      --     LineNr = { fg = colors.overlay0 }, -- Color for absolute line numbers
      --     CursorLine = { bg = colors.surface0 },
      --     -- BlinkCmpKind = { fg = colors.flamingo },
      --   }
      -- end
    }
  },
  { 'rose-pine/neovim', name = 'rose-pine' },
}
-- vim: ts=2 sts=2 sw=2 et
