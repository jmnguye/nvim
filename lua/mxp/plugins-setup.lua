-- s'assure que packer est installé, sinon il l'installe
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
-- Autocommand qui rechearge neovim a chaque sauvegarde
local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return require('packer').startup(function(use)
  use("wbthomason/packer.nvim")
  -- use 'wbthomason/packer.nvim' -- packer se gere lui meme comme plugin
  use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
  -- use { "bluz71/vim-nightfly-colors", as = "nightfly" }
  -- met en place directement la config apres avoir clone packer.nvim
  -- mettre ca a apres les lignes de chargement des plugins

  if packer_bootstrap then
    require('packer').sync()
  end
end)
