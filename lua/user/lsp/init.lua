local M = {}

local servers = {
  clangd = {},
  sumneko_lua = {
    settings = {
      Lua = {
        completion = {
          enable = true,
          callSnippet = "Replace",
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
      } } },
  vimls = {},
}

function M.setup()
  require("nvim-lsp-installer").setup {}
  require("user.lsp.installer").setup(servers)
end

return M
