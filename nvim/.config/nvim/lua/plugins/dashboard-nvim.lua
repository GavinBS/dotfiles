return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',

  config = function()
    local datetime = os.date '%Y-%m-%d %H:%M'
    local weekday = os.date '%A'

    require('dashboard').setup {
      theme = 'hyper',
      shortcut_type = 'letter',
      shuffle_letter = false,
      change_to_vcs_root = false,

      config = {
        header = {
          '🚀 Welcome back to FLYVIM, ☕ Have a good day',
          '',
          ' ___________.____    _____.___.____   ____.___   _____   ',
          ' \\_   _____/|    |   \\__  |   |\\   \\ /   /|   | /     \\  ',
          '  |    __)  |    |    /   |   | \\   Y   / |   |/  \\ /  \\ ',
          '  |     \\   |    |___ \\____   |  \\     /  |   /    Y    \\',
          '  \\___  /   |_______ \\/ ______|   \\___/   |___\\____|__  /',
          '      \\/            \\/\\/                              \\/ ',
          '',
        },

        disable_move = true,

        shortcut = {
          {
            icon = ' ',
            desc = 'Find File',
            group = 'Label',
            key = 'f',
            action = function()
              require('telescope.builtin').find_files()
            end,
          },
          {
            icon = '󰱼 ',
            desc = 'Live Grep',
            group = 'Label',
            key = 'g',
            action = function()
              require('telescope.builtin').live_grep()
            end,
          },
          {
            icon = ' ',
            desc = 'Neovim Config',
            group = 'Label',
            key = 'n',
            action = function()
              require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
            end,
          },
          {
            icon = ' ',
            desc = 'Help Tags',
            group = 'Label',
            key = 'h',
            action = function()
              require('telescope.builtin').help_tags()
            end,
          },
          {
            icon = '󰌶 ',
            desc = 'Keymaps',
            group = 'Label',
            key = 'm',
            action = function()
              require('telescope.builtin').keymaps()
            end,
          },
        },

        packages = { enable = true },

        project = {
          enable = true,
          limit = 5,
          icon = '📁 ',
          label = ' Recent Projects',
          action = function(path)
            require('telescope.builtin').find_files { cwd = path }
          end,
        },

        mru = {
          enable = true,
          limit = 10,
          icon = '📄 ',
          label = ' Recent Files',
          cwd_only = false,
        },

        footer = {
          '',
          '🗓  ' .. weekday .. '  ' .. datetime,
        },
      },

      hide = {
        statusline = true,
        tabline = true,
        winbar = true,
      },
    }
  end,

  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
