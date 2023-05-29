local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

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
    "yamlls"
  },
  -- auto-install configured servers (with lspconfig)
  automatic_installation = true, -- not the same as ensure_installed
})
