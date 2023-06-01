-- s'assure que packer est installé, sinon il l'installe
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
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

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim") -- packer se gere lui meme comme plugin
	use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
	use("christoomey/vim-tmux-navigator") -- gere tmux et la navigation entre les windows avec ctrl hjkl
	use("szw/vim-maximizer") -- maximize et restore la fenetre courrante
	use("tpope/vim-surround") -- pour gérer le surround par des caracteres speciaux
	use("vim-scripts/ReplaceWithRegister") -- remplace un groupe de not par quelque chose du registre
	use("numToStr/Comment.nvim") -- raccourci pour rajouter des commentaires avec gc
	use("nvim-tree/nvim-tree.lua") -- gestionnaire de fichier
	use("kyazdani42/nvim-web-devicons") -- un pack d'icone pour vim-tree
	use("nvim-lualine/lualine.nvim") -- barre de neovim stylé
	-- en prerequis il faut installer ripgrep
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- pour la recherche dans les fichiers
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.1", requires = { { "nvim-lua/plenary.nvim" } } }) -- telescope pour la recherche de fichier, il ya une dependenace a plenary pour les call async
	use("hrsh7th/nvim-cmp") -- autocompletion
	use("hrsh7th/cmp-buffer") -- permet de choisir des elements du buffer pour lautocompletion
	use("hrsh7th/cmp-path") -- la meme qu'au dessus, mais avec des elements du path
	use("L3MON4D3/LuaSnip") -- motor pour l'utilisation des snippets
	use("saadparwaiz1/cmp_luasnip") -- l'autocompletion
	use("rafamadriz/friendly-snippets") -- des snippets multi language
	use("williamboman/mason.nvim") -- gestion et installation serveur lsp, linters et les formatters
	use("williamboman/mason-lspconfig.nvim") -- fait le lien entre mason et nvim-lspconfig
	use("neovim/nvim-lspconfig") -- configuration serveur lsp
	use("hrsh7th/cmp-nvim-lsp") -- une sorte dextended completion
	use({ "glepnir/lspsaga.nvim", branch = "main" }) -- ameliore lspconfig
	-- il faut installer nerdfonts dans ~/.local/share/fonts pour que cela fonctionne correctement
	use("onsails/lspkind.nvim") -- des icones a la vscode
	use("jose-elias-alvarez/null-ls.nvim") -- permet d'injecter du code non LSP via lua
	use("jayp0521/mason-null-ls.nvim") -- bride entre mason et null-ls
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	}) -- lspsaga semble se plaindre sans ce plugin, sert a creer des parsers
	-- le binaire treesitter se trouve https://github.com/tree-sitter/tree-sitter/releases
	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags
	use("ray-x/lsp_signature.nvim") -- pour la signature des functions

	-- met en place directement la config apres avoir clone packer.nvim
	-- mettre ca a apres les lignes de chargement des plugins

	if packer_bootstrap then
		require("packer").sync()
	end
end)
