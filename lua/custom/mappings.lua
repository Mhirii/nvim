local M ={}

M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateLeft<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateLeft<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateLeft<CR>", "window up" }
  }
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>", "Add Breakpoint at line"},
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open Debugging sidebar"
    }
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require('dap-go').debug_test()
      end,
      "Debug go test"
    },
    ["<leader>dgl"] = {
      function()
        require('dap-go').debug_last()
      end,
      "Debug last go test"
    }
  }
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags"
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags"
    }
  }
}

M.lspsaga = {
  n = {
    ["<leader>."] = { "<CMD>CodeActionMenu<CR>", "󰅱 Code Action" },
    ["<leader>gf"] = {
      function()
        vim.cmd "Lspsaga lsp_finder"
      end,
      " Go to definition",
    },
    ["gd"] = {
      "<CMD>Lspsaga goto_definition<CR>",
      " Go to definition",
    },
    ["<leader>lp"] = {
      "<CMD>Lspsaga peek_definition<CR>",
      " Peek definition",
    },
    ["<leader>k"] = {
      -- "<CMD>Lspsaga hover_doc<CR>",
      function()
        require("pretty_hover").hover()
      end,
      "󱙼 Hover lsp",
    },
    ["<leader>o"] = { "<CMD>Lspsaga outline<CR>", " Show Outline" },
    --  LSP
    ["gr"] = { "<CMD>Telescope lsp_references<CR>", " Lsp references" },
    ["[d"] = { "<CMD>Lspsaga diagnostic_jump_prev<CR>", " Prev Diagnostic" },
    ["]d"] = { "<CMD>Lspsaga diagnostic_jump_next<CR>", " Next Diagnostic" },
    ["<leader>qf"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "󰁨 Lsp Quickfix",
    },
  },
}

M.symbols_outline = {
  plugin = true,
  n = {
    ["<leader>s"] = {"<cmd> SymbolsOutline <CR>"}
  }
}

M.hop = {
  n = {
    ["<leader><leader>w"] = { "<cmd> HopWord <CR>", "hint all words" },
    ["<leader><leader>b"] = { "<cmd> HopWord <CR>", "hint all words" },
    ["<leader><leader>j"] = { "<cmd> HopLine <CR>", "hint line" },
    ["<leader><leader>k"] = { "<cmd> HopLine <CR>", "hint line" },
  },
}

return M
