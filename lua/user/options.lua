-- set the options of the editor
--

vim.g.colorscheme = 'elflord'

local o = vim.opt

o.number = true
o.clipboard = 'unnamedplus'
o.mouse = 'a'
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
km('n','<C-h>','<C-w>h',opts )
km('n','<C-l>','<C-w>l',opts )
km('n','<C-j>','<C-w>j',opts )
km('n','<C-k>','<C-w>k',opts )

-- move between splits
--km('n','<C-Up>',':resize +2<CR>',opts )
--km('n','<C-Down>',':resize -2<CR>',opts )
--km('n','<C-Right>',':vertical resize +2<CR>',opts )
--km('n','<C-Left>',':vertical resize -2<CR>',opts )

--explorer split
km('n','<leader>e',':NvimTreeToggle<CR>',opts )
