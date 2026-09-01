return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          root_markers = { "compile_commands.json", ".git" },
          cmd = {
            "clangd",
            "--background-index",
            "--query-driver=/usr/bin/avr-gcc",
          },
        },
      },
    },
  },
}
