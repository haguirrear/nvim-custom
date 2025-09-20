return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      hover = {
        enabled = true,
      },
      signature = {
        enabled = true,
      },
      override = {
        -- ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        -- ["vim.lsp.util.stylize_markdown"] = true,
        -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    presets = {
      long_message_to_split = true, -- long messages will be sent to a split
      lsp_doc_border = true,
    },
    cmdline = {
      view = "cmdline"
    },
    commands = {
      history = {
        -- options for the message history that you get with `:Noice`
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {
          any = {
            { event = "notify" },
            { error = true },
            { warning = true },
            -- { event = "msg_show", kind = { "" } },
            { event = "msg_show" },
            { event = "lsp",     kind = "message" },
          },
        },
      },
      -- :Noice last
      last = {
        view = "popup",
        opts = { enter = true, format = "details" },
        filter = {
          any = {
            { event = "notify" },
            { error = true },
            { warning = true },
            -- { event = "msg_show", kind = { "" } },
            { event = "msg_show" },
            { event = "lsp",     kind = "message" },
          },
        },
        filter_opts = { count = 1 },
      },
      -- :Noice errors
      errors = {
        -- options for the message history that you get with `:Noice`
        view = "popup",
        opts = { enter = true, format = "details" },
        filter = { error = true },
        filter_opts = { reverse = true },
      },
      all = {
        -- options for the message history that you get with `:Noice`
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {},
      },
      echo = {
        -- options for the message history that you get with `:Noice`
        view = "popup",
        opts = { enter = true, format = "details" },
        { event = "msg_show", kind = { "echo" } },
      },
    },
    ---@type NoiceRouteConfig[]
    routes = {
      {
        view = "popup",
        filter = {
          event = "msg_show",
          kind = "echo",
          cmdline = "^Git?",
        },
      },
    },

  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  }
}
