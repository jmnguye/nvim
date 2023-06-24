require("mason").setup()

require("mason-lspconfig").setup({
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
	automatic_installation = true, -- not the same as ensure_installed
})

require("mason-null-ls").setup({
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
	automatic_installation = true,
})
