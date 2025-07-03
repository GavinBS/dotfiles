return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  opts = {
    sort = {
      sorter = 'case_sensitive',
    },
    view = {
      width = 25,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false,
    },

    auto_reload_on_write = true,
    hijack_cursor = true,
    disable_netrw = true,

    actions = { open_file = { quit_on_open = true } },
  },
  keys = {
    { '<leader>e', ':NvimTreeToggle<CR>', silent = true, desc = 'Toggle File Tree' },
  },
}
