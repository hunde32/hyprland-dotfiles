return {
  "xiyaowong/transparent.nvim",
  lazy = false, -- Load immediately on startup
  config = function()
    require("transparent").setup({
      -- Add extra UI components to make transparent
      extra_groups = {
        "NormalFloat",
        "NvimTreeNormal",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "TelescopeNormal",
        "TelescopeBorder",
        "WhichKeyFloat",
        "LazyNormal",
        "MasonNormal",
      },
    })
  end,
}
