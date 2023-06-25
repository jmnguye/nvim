require("lsp_signature").setup({
	bind = true, -- obligatoire, sinon les border ne vont pas s'enregister
	handler_opts = {
		border = "rounded",
	},
	hint_prefix = " ",
})
