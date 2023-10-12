local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require('null-ls')

local b = null_ls.builtins

local opts = {
  sources = {
    b.code_actions.refactoring,

    -- All
    b.diagnostics.codespell, -- Smart spell checker, Does not check code, checks text. (comment only probably)

    -- Python
    b.formatting.black,
    b.diagnostics.mypy,
    b.diagnostics.flake8,
    -- b.diagnostics.pylyzer,
    b.diagnostics.ruff,

    -- Go
    b.formatting.gofumpt,
    b.formatting.gofmt, -- less strict than gofumpt
    b.formatting.goimports_reviser,
    b.formatting.golines,

    -- markdown
    b.diagnostics.write_good,
    b.diagnostics.textidote, -- LaTeX + Markdown | Grammar + Style
    b.diagnostics.textlint, -- Txt + Markdown | Grammar + Style
    b.diagnostics.markdownlint, -- Markdown | Style

    -- Json
    b.formatting.fixjson,

    -- TOML
    b.formatting.taplo,

    -- Lua
    b.formatting.stylua,

    -- Shell
    b.formatting.shfmt,
    b.code_actions.shellcheck,
    b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
}
return opts
