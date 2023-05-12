-- on definit la leader key
vim.g.mapleader = " "

-- petite fonction pour utiliser l'api set keymap
local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- supprimer un caractere sans le sauvegarder dans le registre
map("n", "x", '"_x')

-- virer le search en mode normal
map("n", "<leader>nh", ":nohl<CR>")

-- incrementer et decrementer
map("n", "<leader>+", "<C-a>") -- incrementer
map("n", "<leader>-", "<C-x>") -- decrementer

-- gestion de la window
map("n", "<leader>sv", "<C-w>v") -- split verticale
map("n", "<leader>sh", "<C-w>s") -- split horizontale
map("n", "<leader>se", "<C-w>e") -- egalise les split
map("n", "<leader>sq", "<C-w>q") -- quitte le split 

-- vim-maximizer
map("n", "<leader>sz", ":MaximizerToggle<CR>")

-- gestion des tabs
map("n", "<leader>to", ":tabnew<CR>") -- ouvre un nouveau tab 
map("n", "<leader>tq", ":tabclose<CR>") -- ferme un tab 
map("n", "<leader>tl", ":tabn<CR>") -- va au tab suivant
map("n", "<leader>th", ":tabp<CR>") -- va au tab precedent

-- rajouter un nouvel commande autre qu'echape
map("n", ";;", "<Esc>")
map("i", ";;", "<Esc>")
map("v", ";;", "<Esc>")

-- nvim-tree
map("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- cherche un fichier
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>") -- chercher du texte dans le projet
map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- cherche le contenu du texte sur lequel le curseur se situe dans le projet
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- montre le buffer actif
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
