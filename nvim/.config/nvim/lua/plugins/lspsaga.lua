return {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  -- cmd = 'Lspsaga',
  opts = {},
  keys = {
    { '<leader>ld', ':Lspsaga goto_definition<CR>' },

    { '<leader>lr', ':Lspsaga rename<CR>' },

    { '<leader>lc', ':Lspsaga code_action<CR>' },

    { '<leader>lh', ':Lspsaga hover_doc<CR>' },

    { '<leader>lf', ':Lspsaga finder<CR>' },

    { '<leader>ln', ':Lspsaga diagnostic_jump_next<CR>' },
    { '<leader>lp', ':Lspsaga diagnostic_jump_prev<CR>' },
  },
  -- lazy = false,
}
