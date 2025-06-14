return {
  'mason-org/mason.nvim',
  event = { 'BufReadPost', 'BufNewFile', 'VimEnter' },
  dependencies = {
    {
      'mason-org/mason-lspconfig.nvim',

      config = function()
        require('mason-lspconfig').setup {
          ensure_installed = {
            'lua_ls',
            'basedpyright',
            'bashls',
            'postgres_lsp',
            'html',
            'cssls',
          },
        }
      end,
    },

    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      config = function()
        require('mason-tool-installer').setup {
          ensure_installed = {
            'stylua',
            'black',
            'isort',
            'jq',
            'shfmt',
          },
          auto_update = false,
          run_on_start = true,
        }
      end,
    },
  },

  opts = {
    ui = {
      border = 'rounded',
      width = 0.7,
      height = 0.7,
    },
  },
}
