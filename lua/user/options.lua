-- set the options of the editor
--

vim.cmd("colorscheme tokyonight")

local o = vim.opt

o.number = true
o.clipboard = 'unnamedplus'
-- o.mouse = 'a'
o.shiftwidth = 2
o.tabstop = 2
o.expandtab = true
o.splitbelow = true
o.splitright = true
o.fileencoding = 'utf-8'
o.swapfile = false
o.cursorline = true
o.cmdheight = 2
o.ignorecase = true
o.termguicolors = true
o.showtabline = 2


-- Keybinds
--

vim.g.mapleader = ' '
vim.g.localmapleader = ' '


--local opts = { noremap = true , silent = true }
local opts = { noremap = true }
local km = vim.api.nvim_set_keymap

-- move between splits
km('n', '<C-h>', '<C-w>h', opts)
km('n', '<C-l>', '<C-w>l', opts)
km('n', '<C-j>', '<C-w>j', opts)
km('n', '<C-k>', '<C-w>k', opts)

--explorer split
km('n', '<leader>e', ':NvimTreeToggle<CR>', opts)


--telescope
--
km('n', 'ff', ':Telescope find_files<CR>', opts)
km('n', 'fg', ':Telescope live_grep<CR>', opts)
km('n', 'fb', ':Telescope buffers<CR>', opts)
km('n', 'fh', ':Telescope help_tags<CR>', opts)

require('lualine').setup()
