return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'auto',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_b = { 'branch', 'diff' },
      lualine_x = {
        'filesize',
        'encoding',
        'filetype',
      },
    },
  },
}
