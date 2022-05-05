local M = {}

M.config = {
  on_attach = utils.lsp_on_attach,
  on_init = utils.lsp_on_init,
  settings = {
    Lua = {
      completion = {
        enable = true,
        callSnippet = "Replace",
      },
      runtime = {
        version = "LuaJIT",
        path = (function()
          local path = vim.split(package.path, ";")
          table.insert(path, "lua/?.lua")
          table.insert(path, "lua/?/init.lua")
          return path
        end)(),
      },
      diagnostics = {
        enable = true,
        globals = {
          "vim",
          "describe",
          "it",
          "before_each",
          "after_each",
          "awesome",
          "theme",
          "client",
          "P",
        },
      },
      workspace = {
        preloadFileSize = 400,
        library = library,
      },
    },
  },
}

return M
