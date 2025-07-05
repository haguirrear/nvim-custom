-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gr', require('custom.helpers.telescope_pickers').prettyLspReferences, '[G]oto [R]eferences')
  nmap('gI', require('custom.helpers.telescope_pickers').prettyLspImplementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ds', require('custom.helpers.telescope_pickers').prettyDocumentSymbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation" })

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  -- Attach nvim-navic (Breadcrumbs)
  local navic = require("nvim-navic")
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

-- document existing key chains
-- require('which-key').register {
--   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
--   ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
--   ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
--   ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
--   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
--   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
--   ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
--   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
--   ['<leader>x'] = { name = 'E[X]ecute', _ = 'which_key_ignore' },
--   ['<leader>R'] = { name = '[R]request', _ = 'which_key_ignore' },
--   ['<leader>b'] = { name = '[b]uffers', _ = 'which_key_ignore' },
-- }

require("which-key").add({
  { "<leader>b", group = "[B]uffers" },
  { "<leader>c", group = "[C]ode" },
  { "<leader>d", group = "[D]ocument" },
  { "<leader>g", group = "[G]it" },
  { "<leader>h", group = "Git [H]unk" },
  { "<leader>r", group = "[R]ename" },
  { "<leader>s", group = "[S]earch" },
  { "<leader>t", group = "[T]oggle" },
  { "<leader>w", group = "[W]orkspace" },
  { "<leader>x", group = "E[X]ecute" },
  {
    mode = "v",
    { "<leader>",  desc = "VISUAL <leader>" },
    { "<leader>h", group = "Git [H]unk" }
  }

})

-- UI customizations

local border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },
}
--
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
-- require('which-key').register({
--   ['<leader>'] = { name = 'VISUAL <leader>' },
--   ['<leader>h'] = { 'Git [H]unk' },
-- }, { mode = 'v' })

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  gopls = {
    verboseOutput = true,
    logLevel = "debug",
  },
  pyright = {
    pyright = {
      autoImportCompletion = true,
      -- This is managed by ruff
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
        typeCheckingMode = "off",
        -- autoSearchPaths = true,
        -- diagnosticMOde = "openFilesOnly",
        -- useLibraryCodeForTypes = true,
      },
    },
  },
  -- For Linting and formatting
  ruff = {},
  -- rust_analyzer = {},:warnings
  -- tsserver = {
  --   -- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "html" }
  -- },
  html = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
  cssls = {},
  tailwindcss = {},
  emmet_language_server = {},
  htmx = {},
  jsonls = {},
  -- phpactor = {},
  sqlls = {},
  terraformls = {},
  templ = {},
  graphql = {},
  astro = {},
  lemminx = {},
  groovyls = {
    filetypes = { "groovy", "groovity" }
  },
  yamlls = {
    validate = true,
    format = {
      enable = true,
    },
    schemas = {},
    schemaStore = {
      enable = true,
    },
  },
  -- java_language_server = {},
  jdtls = {},
  elixirls = {},
  ts_ls = {},
  denols = {},
  taplo = {},
  csharp_ls = {},
}

-- For Deno
vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- Setup neovim lua configuration
require('neodev').setup()

-- Old nvim-cmp capabilities
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- This includes the lsp basic capablities
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    if server_name == "jdtls" then
      return
    end

    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,


  ["ts_ls"] = function()
    local nvim_lsp = require('lspconfig')
    nvim_lsp["ts_ls"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers["ts_ls"],
      root_dir = nvim_lsp.util.root_pattern("package.json"),
      single_file_support = false
    }
  end,

  ["denols"] = function()
    local nvim_lsp = require('lspconfig')
    nvim_lsp["denols"].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers["denols"],
      root_dir = nvim_lsp.util.root_pattern("deno.json"),
    }
  end,

  ["gopls"] = function()
    local nvim_lsp = require('lspconfig')

    -- Search for the mise gopls and prioritize it if found
    local get_gopls = function()
      local all = vim.fn.systemlist("which -a gopls 2>/dev/null")
      for _, p in pairs(all) do
        if p:match("mise") and vim.fn.executable(p) == 1 then
          return { p }
        end
      end

      return nil
    end

    local config = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers["gopls"],
      cmd = { vim.fn.exepath("gopls") },
      filetypes = (servers["gopls"] or {}).filetypes,
    }
    local cmd = get_gopls()
    if cmd then
      config.cmd = cmd
    end

    nvim_lsp["gopls"].setup(config)
  end
}



-- For python
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})

return {
  on_attach = on_attach,
  capabilities = capabilities
}

-- vim: ts=2 sts=2 sw=2 et
