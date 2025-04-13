-- Nvim Autopairs
--
return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  opts = {
    disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input", "typr" },
  } -- this is equalent to setup({}) function
}
-- vim: ts=2 sts=2 sw=2 et
