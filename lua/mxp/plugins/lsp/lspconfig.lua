local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

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

-- require("lsp_signature").setup({
-- 	bind = true, -- This is mandatory, otherwise border config won't get registered.
-- 	handler_opts = {
-- 		border = "rounded",
-- 	},
-- })
