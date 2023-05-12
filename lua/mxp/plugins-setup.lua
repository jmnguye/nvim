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

local packer_bootstrap = ensure_packer()

-- Autocommand qui recharge neovim a chaque sauvegarde
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- packer se gere lui meme comme plugin
  use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
  use("christoomey/vim-tmux-navigator") -- gere tmux et la navigation entre les windows avec ctrl hjkl
  use("szw/vim-maximizer") -- maximize et restore la fenetre courrante
  use("tpope/vim-surround") -- pour gérer le surround par des caracteres speciaux
  use("vim-scripts/ReplaceWithRegister") -- remplace un groupe de mot par quelque chose du registre
  use("numToStr/Comment.nvim") -- raccourci pour rajouter des commentaires avec gc
  use("nvim-tree/nvim-tree.lua") -- gestionnaire de fichier
  use("kyazdani42/nvim-web-devicons") -- un pack d'icone pour vim-tree
  use("nvim-lualine/lualine.nvim") -- barre de neovim stylé
-- en prerequis il faut installer ripgrep
  use({'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }) -- pour la recherche dans les fichiers
  use({'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = { {'nvim-lua/plenary.nvim'} }}) -- telescope pour la recherche de fichier, il ya une dependenace a plenary pour les call async

  -- met en place directement la config apres avoir clone packer.nvim
  -- mettre ca a apres les lignes de chargement des plugins

  if packer_bootstrap then
    require('packer').sync()
  end
end)
