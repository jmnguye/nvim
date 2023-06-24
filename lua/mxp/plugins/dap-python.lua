local dap_python_status, dap_python = pcall(require, "dap-python")
if not dap_python_status then
	return
end

dap_python.setup("~/.virtualenvs/debugpy/bin/python")
