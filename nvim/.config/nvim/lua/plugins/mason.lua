return {
  'mason-org/mason.nvim',

  event = { 'BufReadPost', 'BufNewFile', 'VimEnter' },
  config = function()
    require('mason').setup {
      ui = {
        border = 'rounded',
        width = 0.7,
        height = 0.7,

        -- icons = {
        --   package_installed = '✓',
        --   package_pending = '➜',
        --   package_uninstalled = '✗',
        -- },
      },
    }
  end,
}
