return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    { 'echasnovski/mini.icons', version = '*' },
    { 'L3MON4D3/LuaSnip',       version = 'v2.*' },
  },
  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',
  init = function()
    require('luasnip.loaders.from_vscode').lazy_load()

    -- Cancels snippet if go into normal mode. It works????
    vim.api.nvim_create_autocmd('ModeChanged', {
      pattern = '*',
      callback = function()
        if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
            and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require('luasnip').session.jump_active
        then
          require('luasnip').unlink_current()
        end
      end
    })
  end,

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "typr" }, vim.bo.filetype)
    end,
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    signature = {
      enabled = false,
      window = {
        show_documentation = false,
      }
    },
    keymap = {
      preset = 'enter',
      -- ['<Tab>'] = { 'fallback' },
      -- ['<S-Tab>'] = { 'fallback' },
      -- ['<CR>'] = { 'select_and_accept', 'fallback' },
    },
    cmdline = {
      keymap = {
        preset = "none"
        -- ['<CR>'] = { 'select_and_accept', 'fallback' },
      }

    },
    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
      documentation = {
        auto_show = false,
        window = {
          border = "rounded",
        }
      },
      menu = {
        border = "rounded",
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        draw = {
          -- padding = { 0, 1 },
          -- treesitter = { 'lsp' },
          columns = { { 'kind_icon' }, { 'label', "kind", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
            kind_icon = {
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
          }

          -- components = {
          --   kind_icon = {
          --     text = function(ctx)
          --       local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
          --       return kind_icon
          --     end,
          --     -- (optional) use highlights from mini.icons
          --     highlight = function(ctx)
          --       local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
          --       return hl
          --     end,
          --   },
          --   kind = {
          --     -- (optional) use highlights from mini.icons
          --     highlight = function(ctx)
          --       local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
          --       return hl
          --     end,
          --   }
          -- }
        }
      }
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
    snippets = {
      preset = 'luasnip',
      -- expand = function(snippets, _)
      --   require('luasnip').lsp_expand(snippet)
      -- end
    }
  },
  opts_extend = { "sources.default" }
}
