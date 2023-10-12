---@type ChadrcConfig 
 local M = {}
 M.ui = {
  theme_toggle = { "tokyonight", "palenight" },
  theme = 'tokyonight',
  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "arrow",
    overriden_modules = nil,
  },
}
 M.plugins = "custom.plugins"
 M.mappings = require "custom.mappings"
 return M
