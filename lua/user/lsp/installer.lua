local lsp_installer_servers = require "nvim-lsp-installer.servers"
local utils = require "user.lsp.utils"
local lspconfig = require "lspconfig"


local M = {}

function M.setup(servers)

  for name, opts in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(name)
    utils.info("Checking " .. server.name)
    if server_available then
      if not server:is_installed() then
        utils.info("Installing " .. server.name)
        server:install()
      end
    end
    if type(opts) == "function" then
      opts()
    else
      local client = lspconfig[name]
      client.setup {
        flags = { debounce_text_changes = 150 },
        cmd = opts.cmd or client.cmd,
        filetypes = opts.filetypes or client.filetypes,
        on_attach = opts.on_attach or utils.lsp_on_attach,
        on_init = opts.on_init or utils.lsp_on_init,
        handlers = opts.handlers or client.handlers,
        root_dir = opts.root_dir or client.root_dir,
        capabilities = opts.capabilities or client.capabilities,
        settings = opts.settings or {},
      }
    end
  end
end

return M
