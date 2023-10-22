
local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    -- "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "rust",
    "cpp",
    "go",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}


M.mason = {
  install_root_dir = os.getenv "HOME" .. "/.local/share/nvim/mason/bin",
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    -- "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- Rust stuff
    "rust-analyzer",

    -- Go stuff
    "gopls",

    -- Shell stuff
    "shellcheck",
    "shfmt",

    -- Python
    -- TODO: Remove mason-dap-install plugin and use the default
    "black",
    "debugpy",
    "mypy",
    "ruff",
    "pyright",
  },
}

return M
