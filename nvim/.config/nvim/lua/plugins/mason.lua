return {
  'mason-org/mason.nvim',
  event = { 'BufReadPost', 'BufNewFile', 'VimEnter' },
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },

  config = function()
    require('mason').setup {
      ui = {
        border = 'rounded',
        width = 0.7,
        height = 0.7,
      },
    }

    require('mason-lspconfig').setup {
      ensure_installed = {
        'lua_ls',
        'basedpyright',
        'bashls',
        'postgres_lsp',
        'html',
        'cssls',
        'docker_compose_language_service',
      },
    }

    require('mason-tool-installer').setup {
      ensure_installed = {
        'stylua',
        'black',
        'isort',
        'jq',
        'shfmt',
        'beautysh',
      },
      auto_update = false,
      run_on_start = true,
    }
  end,
}
