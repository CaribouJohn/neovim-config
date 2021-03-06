local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path,
  }

  print "Installing packer close and reopen neovim..."
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
 augroup packer_user_config
   autocmd!
   autocmd BufWritePost plugins.lua source <afile> | PackerSync
 augroup end
]]


local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use "windwp/nvim-autopairs"
  use "numToStr/Comment.nvim"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "BurntSushi/ripgrep"
  use "folke/tokyonight.nvim"
  use "jacoborus/tender.vim"
  use { "EdenEast/nightfox.nvim", tag = "v1.0.0" }
  use "savq/melange"
  use "AndrewRadev/bufferize.vim"

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    opt = true,
    event = "BufRead",
    run = ":TSUpdate",
    config = function()
      require("user.treesitter").setup()
    end,
    requires = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
  }

  --
  -- WhichKey
  use {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("user.whichkeyconfig").setup()
    end,
  }
  -- LSP
  use {
    "neovim/nvim-lspconfig",
    opt = true,
    event = "BufReadPre",
    wants = { "nvim-lsp-installer" },
    config = function()
      require("user.lsp").setup()
    end,
    requires = {
      "williamboman/nvim-lsp-installer",
    },
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Lua
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use "McAuleyPenney/tidy.nvim"

  --cmp
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  --use 'petertriho/cmp-git'

  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'

  use 'L3MON4D3/Luasnip'
  use 'rafamadriz/friendly-snippets'

  --use 'lewis6991/gitsigns.nvim'

  use {
    "Acksld/nvim-neoclip.lua",
    requires = 'nvim-telescope/telescope.nvim',
    config = function()
      require('neoclip').setup{}
    end,
  }
  vim.opt.completeopt = { "menu" , "menuone" , "noselect" }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
