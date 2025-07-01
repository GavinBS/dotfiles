return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  opts = {
    theme = 'doom',
    disable_move = false,

    shuffle_letter = false,
    config = {

      header = {
        ' ___________.____    _____.___.____   ____.___   _____   ',
        ' \\_   _____/|    |   \\__  |   |\\   \\ /   /|   | /     \\  ',
        '  |    __)  |    |    /   |   | \\   Y   / |   |/  \\ /  \\ ',
        '  |     \\   |    |___ \\____   |  \\     /  |   /    Y    \\',
        '  \\___  /   |_______ \\/ ______|   \\___/   |___\\____|__  /',
        '      \\/            \\/\\/                              \\/ ',
      },

      center = {
        {
          icon = ' ',
          icon_hl = 'Title',
          desc = 'Find File           ',
          desc_hl = 'String',
          key = ' ',
          keymap = 'SPC s f',
          key_hl = 'Number',
          key_format = ' %s',
          action = '',
        },
        -- {
        --   icon = ' ',
        --   desc = 'Find Dotfiles',
        --   key = 'f',
        --   keymap = 'SPC f d',
        --   key_format = ' %s', -- remove default surrounding `[]`
        --   action = 'lua print(3)',
        -- },
      },

      footer = { '🚀 Welcome to FLYVIM, have a good day ☕' },
      vertical_center = false,
    },
  },
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
