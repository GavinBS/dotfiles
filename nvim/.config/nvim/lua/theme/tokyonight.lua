return {
  'folke/tokyonight.nvim',
  priority = 1000,
  opts = {
    style = 'night',
    transparent = true,
    styles = {
      comments = { italic = true },
    },
  },

  config = function(_, opts)
    require('tokyonight').setup(opts)
    vim.cmd.colorscheme 'tokyonight'
  end,
}
