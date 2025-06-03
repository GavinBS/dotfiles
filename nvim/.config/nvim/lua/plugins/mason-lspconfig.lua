return {
  'mason-org/mason-lspconfig.nvim',
  dependencies = { 'mason-org/mason.nvim' },
  config = function()
    require('mason-lspconfig').setup {
      ensure_installed = {
        'lua_ls',
        'basedpyright',
        'bashls',
      },
    }
  end,
}
