local lspconfig = require("lspconfig")

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- on configure chaque ensure_installed
lspconfig["pyright"].setup({
	capabilities = capabilities,
})

lspconfig["tsserver"].setup({
	capabilities = capabilities,
})

lspconfig["html"].setup({
	capabilities = capabilities,
})

lspconfig["ansiblels"].setup({
	capabilities = capabilities,
})

lspconfig["bashls"].setup({
	capabilities = capabilities,
})

lspconfig["dockerls"].setup({
	capabilities = capabilities,
})

lspconfig["docker_compose_language_service"].setup({
	capabilities = capabilities,
})

lspconfig["jsonls"].setup({
	capabilities = capabilities,
})

lspconfig["tsserver"].setup({
	capabilities = capabilities,
})

lspconfig["marksman"].setup({
	capabilities = capabilities,
})

lspconfig["sqlls"].setup({
	capabilities = capabilities,
})

lspconfig["lemminx"].setup({
	capabilities = capabilities,
})

lspconfig["yamlls"].setup({
	capabilities = capabilities,
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
