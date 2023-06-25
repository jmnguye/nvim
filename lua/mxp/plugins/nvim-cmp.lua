local cmp = require("cmp")

-- charge les friendly-snippets
require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

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
