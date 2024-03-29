-- s'assure que packer est installé, sinon il l'installe
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }) -- nodejs (npm) est une dependance pour certains plugins
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

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim") -- packer se gere lui meme comme plugin
	use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
	-- use("christoomey/vim-tmux-navigator") -- gere tmux et la navigation entre les windows avec ctrl hjkl
	use("szw/vim-maximizer") -- maximize et restore la split windows
	-- use("tpope/vim-surround") -- pour gérer le surround par des caracteres speciaux
	-- use("vim-scripts/ReplaceWithRegister") -- remplace un groupe de not par quelque chose du registre
	use({
		"numToStr/Comment.nvim", -- raccourci pour rajouter des commentaires avec gc
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"nvim-tree/nvim-tree.lua", -- gestionnaire de fichier
		requires = { "kyazdani42/nvim-web-devicons" }, -- un pack d'icone pour vim-tree
	})
	use({
		"nvim-lualine/lualine.nvim", -- barre status neovim style
		requires = {
			"bluz71/vim-nightfly-guicolors", -- le theme associe
			"kyazdani42/nvim-web-devicons", -- les icones de la barres
		},
	})
	-- en prerequis il faut installer ripgrep
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- pour la recherche dans les fichiers, avec un algo specifique
  -- j'ai due compiler moi meme la lib libfzf avec make, donc make est un prerequis
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.4", requires = { { "nvim-lua/plenary.nvim" } } }) -- telescope pour la recherche de fichier, il ya une dependenace a plenary pour les call async
	use({
		"hrsh7th/nvim-cmp", -- autocompletion
		requires = {
			"L3MON4D3/LuaSnip", -- motor pour l'utilisation des snippets
			"saadparwaiz1/cmp_luasnip", -- integre le plugin luasnip dans le sys de completion
			"hrsh7th/cmp-buffer", -- permet de choisir des elements du buffer pour lautocompletion
			"hrsh7th/cmp-path", -- la meme qu'au dessus, mais avec des elements du path
			"hrsh7th/cmp-nvim-lsp", -- une sorte dextended completion
			"rafamadriz/friendly-snippets", -- des snippets multi language
		},
	})
	use("williamboman/mason.nvim") -- gestion et installation serveur lsp, linters et les formatters
	use("williamboman/mason-lspconfig.nvim") -- fait le lien entre mason et nvim-lspconfig
	use("jay-babu/mason-nvim-dap.nvim") -- plugin qui fait le lien entre mason et dap
	use("neovim/nvim-lspconfig") -- configuration serveur lsp
	use({ "glepnir/lspsaga.nvim", branch = "main" }) -- ameliore lspconfig
	-- il faut installer nerdfonts dans ~/.local/share/fonts pour que cela fonctionne correctement
	use("onsails/lspkind.nvim") -- des icones a la vscode dans LSP
	use("jose-elias-alvarez/null-ls.nvim") -- permet d'injecter du code non LSP via lua
	use("jayp0521/mason-null-ls.nvim") -- bride entre mason et null-ls
	use({
		"nvim-treesitter/nvim-treesitter", -- Highlight, edit, and navigate code : parser de language
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
	use("mfussenegger/nvim-dap") -- debugging application procotole
	use({
		"mfussenegger/nvim-dap-python",
		default = { justMyCode = false },
		ft = "python",
		requires = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function(_)
			require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
		end,
	})
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }) -- ui pour dap

	-- met en place directement la config apres avoir clone packer.nvim
	-- mettre ca a apres les lignes de chargement des plugins

	if packer_bootstrap then
		require("packer").sync()
	end
end)
