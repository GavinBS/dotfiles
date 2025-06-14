return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(_, _, diagnostics_dict, _)
        local s = ' '
        for e, n in pairs(diagnostics_dict) do
          local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or ' ')
          s = s .. n .. sym
        end
        return s
      end,
    },
  },
  keys = {
    -- Switch Buffer
    { '<leader>bp', ':BufferLineCyclePrev<CR>', silent = true },
    { '<leader>bn', ':BufferLineCycleNext<CR>', silent = true },
    { '<leader>bh', ':BufferLinePick<CR>', silent = true },

    -- Close Buffer
    { '<leader>bd', ':bdelete<CR>', silent = true },
    { '<leader>bo', ':BufferLineCloseOthers<CR>', silent = true },
    { '<leader>bc', ':BufferLinePickClose<CR>', silent = true },
  },
  lazy = false,
}
