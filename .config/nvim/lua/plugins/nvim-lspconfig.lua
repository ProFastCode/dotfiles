return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {},
        ruff = {
          setup = {
            init_options = {
              settings = {
                configuration = "~/.ruff.toml",
              },
            },
          },
        },
      },
    },
  },
}
