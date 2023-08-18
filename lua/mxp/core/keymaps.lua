-- on definite la leader key
vim.g.mapleader = " "

-- petite function pour utiliser l'api set keymap
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- supprimer un character sans le sauvegarder dans le registre
map("n", "x", '"_x')

-- virer le search en mode normal
map("n", "<leader>nh", ":nohl<CR>")

-- incrementer et decrementer
map("n", "<leader>+", "<C-a>") -- incrementer
map("n", "<leader>-", "<C-x>") -- decrementer

-- gestion de la window
-- <C-w>v" -- split verticale
-- <C-w>s" -- split horizontal
-- <C-w>e" -- egalise les split
-- <C-w>q" -- quitte le split

-- vim-maximizer
map("n", "<leader>sz", ":MaximizerToggle<CR>")

-- gestion des tabs
map("n", "<leader>to", ":tabnew<CR>") -- ouvre un nouveau tab
map("n", "<leader>tq", ":tabclose<CR>") -- ferme un tab
map("n", "<leader>tl", ":tabn<CR>") -- va au tab suivant
map("n", "<leader>th", ":tabp<CR>") -- va au tab precedent

-- gestion de ligne, ajout et suppression
-- map("n", "<C-j>", "mzj:s/^\\s*\\n//i<CR>`z:noh<CR>")
-- map("n", "<C-k>", "mzk:s/^\\s*\\n//i<CR>`z:noh<CR>")
map("n", "<A-j>", ":set paste<CR>m`o<Esc>``:set nopaste<CR>")
map("n", "<A-k>", ":set paste<CR>m`O<Esc>``:set nopaste<CR>")

-- rajouter un nouvel commande autre qu'echape
map("n", ";;", "<Esc>")
map("i", ";;", "<Esc>")
map("v", ";;", "<Esc>")
map("s", ";;", "<Esc>") -- select mode maps
map("x", ";;", "<Esc>") -- visual mode maps
map("c", ";;", "<Esc>") -- command line
map("o", ";;", "<Esc>") -- operator pending mode

-- nvim-tree
map("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- cherche un fichier
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>") -- chercher du texte dans le project
map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- cherche le contenu du texte sur lequel le curseur se situe dans le project
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- montre le buffer actif
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
map("n", "<leader>??", "<cmd>Telescope keymaps<cr>")

-- lspconfig
map("n", "gh", "<cmd>Lspsaga lsp_finder<CR>") -- show definition, references
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>") -- got to declaration
map("n", "gp", "<cmd>Lspsaga peek_definition<CR>") -- on voit la def dans une window
map("n", "gd", "<cmd>Lspsaga goto_definition<CR>") -- on va a la def
map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>") -- see available code actions : la putin d'ampoule !!!
map("n", "<leader>gn", "<cmd>Lspsaga rename<CR>") -- smart rename
map("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>") -- show diagnostics for cursor
map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>") -- jump to previous diagnostic in buffer
map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>") -- jump to next diagnostic in buffer
map("n", "K", "<cmd>Lspsaga hover_doc<CR>") -- show documentation for what is under cursor
map("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>") -- affiche la doc du typage en mode fenetre
map("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>") -- va a la def du typage

-- telescope
require("telescope").setup({
	-- configure custom mappings
	defaults = {
		mappings = {
			-- ces raccourcis fonctionne en mode insert
			i = {
				["<C-k>"] = require("telescope.actions").move_selection_previous, -- move to prev result
				["<C-j>"] = require("telescope.actions").move_selection_next, -- move to next result
			},
		},
	},
})

-- deburger
map("n", "<leader>bp", "<cmd>DapToggleBreakpoint<CR>")
map("n", "<leader>db", "<cmd>lua require('dap').continue()<CR>")
--
-- require("dap-python").setup({
-- 		mappings = {
-- 			n = {
-- 				["<leader>dpr"] = require("dap-python").test_method(),
-- 			},
-- 		},
--   }
-- )

-- lspsaga
require("lspsaga").setup({
	-- keybinds for navigation in lspsaga window
	scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
})

-- completion
local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
})
