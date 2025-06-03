return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  dependencies = { 'mason-org/mason.nvim' },
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
}
