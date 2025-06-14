return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  --   -- dependencies = { "folke/snacks.nvim", lazy = true },
  keys = {
    {
      '<leader>e',
      mode = { 'n', 'v' },
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
    -- {
    -- Open in the current working directory
    --   '<leader>E',
    --   '<cmd>Yazi cwd<cr>',
    --   desc = "Open the file manager in nvim's working directory",
    -- },
  },
  opts = {
    open_for_directories = true,
    keymaps = { show_help = '<f1>' },
  },

  -- 👇 if you use `open_for_directories=true`, this is recommended
  init = function()
    -- vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
}
