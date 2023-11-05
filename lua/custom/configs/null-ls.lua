
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require('null-ls')
local b = null_ls.builtins

local opts = {
  sources = {
    b.code_actions.refactoring,
    b.diagnostics.codespell,

    --TypeScript
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.prettier,

    -- Python
    b.formatting.black,
    -- b.formatting.mypy,
    b.formatting.ruff,

    -- Go
    b.formatting.gofumpt,
    b.formatting.gofmt, 
    b.formatting.goimports_reviser,
    b.formatting.golines,

    -- C++
    b.formatting.clang_format,

    -- Json
    b.formatting.fixjson,

    -- Lua
    b.formatting.stylua,


    -- Shell
    b.formatting.shfmt,
    b.code_actions.shellcheck,
    b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  },
  on_attach = function (client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre",{
        group = augroup,
        buffer = bufnr,
        callback = function ()
          vim.lsp.buf.format({ bufnr = bufnr })
        end

      })
    end
  end
}

return opts
