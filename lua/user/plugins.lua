

local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then 
  PACKER_BOOTSTRAP = fn.system {
    "git","clone","--depth","1","https://github.com/wbthomason/packer.nvim",install_path,
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


local status_ok , packer = pcall(require , "packer")
if not status_ok then
   return
end

packer.init {
  display= {
    open_fn = function()
      return require("packer.util").float {border = "rounded"}
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
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
