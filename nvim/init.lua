require("config.lazy")

vim.opt.mouse = ""
local modes = { "n", "i", "v", "x" }
local keys = { "<Up>", "<Down>", "<Left>", "<Right>" }

for _, mode in ipairs(modes) do
  for _, key in ipairs(keys) do
    vim.keymap.set(mode, key, "<Nop>", { noremap = true, silent = true })
  end
end
