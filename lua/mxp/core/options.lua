local opt = vim.opt -- on se creer une petite variable pour plus de simplicité

-- la numeroration des lignes
opt.number = true

-- tabulation et indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- wrap
opt.wrap = false

-- recherche
opt.ignorecase = true
opt.smartcase = true

-- ligne du curseur
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "light"
opt.signcolumn = "yes" -- affiche la column des signs

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard : on demande a neovim d'utiliser le systeme comme tampon de copie
opt.clipboard:append("unnamedplus")

-- split fenetre
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-") -- rajoute le character - comme faisant partie d'un not

-- element de completion
opt.completeopt = "menu,menuone,noselect"

-- wrap word
opt.wrap = true
