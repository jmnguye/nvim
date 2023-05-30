local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

-- on active mason
mason.setup()

mason_lspconfig.setup({
	-- la liste des serveurs que mason doit installer
	ensure_installed = {
		"lua_ls",
		"tsserver",
		"html",
		"ansiblels",
		"bashls",
		"dockerls",
		"docker_compose_language_service",
		"jsonls",
		"tsserver",
		"marksman",
		"pyright",
		"sqlls",
		"lemminx",
		"yamlls",
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
		"black", -- formatter python
		"isort@5.11.5", -- formatter ajout alphabetique des imports pythons
		"shfmt", -- formatter shell
		"flake8@5.0.4", -- linter python
		"codespell", -- linter python et js pour la typo
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})
