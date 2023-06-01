local lsp_signature_status, lsp_signature = pcall(require, "lsp_signature")
if not lsp_signature_status then
	return
end

lsp_signature.setup({
	bind = true, -- obligatoire, sinon les border ne vont pas s'enregister
	handler_opts = {
		border = "rounded",
	},
	hint_prefix = " ",
})
