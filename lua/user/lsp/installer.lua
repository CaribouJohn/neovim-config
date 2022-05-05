local lsp_installer_servers = require "nvim-lsp-installer.servers"

_G.dump = function(...)
  print(vim.inspect(...))
end

_G.prequire = function(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  end
  return nil
end

local utils = {}

function utils.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function utils.log(msg, hl, name)
  name = name or "Neovim"
  hl = hl or "Todo"
  vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function utils.warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function utils.error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function utils.info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

local util = require 'lspconfig/util'

local M = {}

function M.setup(servers, options)
  for server_name, _ in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)

    if server_available then
      server:on_ready(function()
        local opts = vim.tbl_deep_extend("force", options, servers[server.name] or {})
        if server.name == 'sumneko_lua' then
          opts.settings = {
            Lua = { diagnostics = { globals = { 'vim' } } }
          }
        end
        if server.name == 'solargraph' then
          opts.cmd = {
            "solargraph",
            "stdio"
          }
          opts.filetypes = {
            "ruby"
          }
          opts.root_dir = util.root_pattern("Gemfile", ".git");
          opts.flags = {
            debounce_text_changes = 150
          }
          opts.settings = {
            solargraph = {
              autoformat = true,
              completion = true,
              diagnostic = true,
              folding = true,
              references = true,
              rename = true,
              symbols = true
            }
          }
        end
        server:setup(opts)
      end)

      if not server:is_installed() then
        utils.info("Installing " .. server.name)
        server:install()
      end
    else
      utils.error(server)
    end
  end
end

return M
