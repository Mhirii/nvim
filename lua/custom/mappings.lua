local M ={}

M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateLeft<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateLeft<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateLeft<CR>", "window up" }
  }
}
return M
