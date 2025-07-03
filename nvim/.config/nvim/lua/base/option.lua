local o = vim.o
local opt = vim.opt

-- Make line numbers default
o.number = true
o.relativenumber = true

-- visual line wrapping
o.wrap = true

-- indent
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.autoindent = true

-- ture color
o.termguicolors = true

-- Enable mouse mode, can be useful for resizing splits for example!
o.mouse = 'a'

o.showmode = false

opt.laststatus = 3

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)

-- Enable break indent
o.breakindent = true

-- Save undo history
o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true

-- Keep signcolumn on by default
o.signcolumn = 'yes'

-- Decrease update time
o.updatetime = 250

-- Decrease mapped sequence wait time
o.timeoutlen = 300

-- Configure how new splits should be opened
o.splitright = true
o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `opt` instead of `o`.
--  It is very similar to `o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
o.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
o.inccommand = 'split'

-- Show which line your cursor is on
o.cursorline = true

o.colorcolumn = '80'

-- Minimal number of screen lines to keep above and below the cursor.
o.scrolloff = 0

o.confirm = true

o.hlsearch = false
