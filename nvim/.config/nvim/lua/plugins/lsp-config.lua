return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "phpactor", "yamlls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      -- load snippet capabilities for lsp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- setup the language servers specified in ensure_installed array
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.phpactor.setup({
        capabilities = capabilities,
        root_dir = function(_)
          return vim.loop.cwd()
        end,
        init_options = {
          ["language_server_phpstan.enabled"] = false,
          ["language_server_psalm.enabled"] = false,
        },
      })
      lspconfig.yamlls.setup({})
      -- setup the keybinds
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
