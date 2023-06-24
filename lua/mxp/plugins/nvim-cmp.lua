local cmp = require'cmp'

-- charge les friendly-snippets
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),

	-- on configure la provenance des sources
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- lsp
		{ name = "nvim_lsp_signature_help" }, -- signature
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- texte contenus dans le buffer courant
		{ name = "path" }, -- pareil mais avec le path
	}),

	formatting = {
		format = require("lspkind").cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})
