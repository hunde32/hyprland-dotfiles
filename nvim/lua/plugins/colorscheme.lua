return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- Override LazyVim's default colorscheme loading
      colorscheme = function()
        local ok, matugen = pcall(require, "matugen-colors")
        if ok then
          matugen.apply()
        else
          -- Fallback if the matugen file hasn't been generated yet
          vim.cmd.colorscheme("habamax")
        end
      end,
    },
  },
}
