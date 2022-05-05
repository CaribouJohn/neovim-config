
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

utils.lsp_on_attach = function(client,bufnr)
  if client.resolved_capabilities.code_lens then
    vim.cmd [[
    augroup CodeLens
      au!
      au CursorHold,CursorHoldI * lua vim.lsp.codelens.refresh()
    augroup END
    ]]
  end
  require("user.lsp.keymaps").setup(client,bufnr)
end

utils.lsp_on_init = function()
  print "Language Server Client successfully started!"
end

return utils;
