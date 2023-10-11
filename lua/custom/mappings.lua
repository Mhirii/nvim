local M = {}

M.general = {
  n = {
    -- ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    -- ["<C-l>"] = { "<cmd> TmuxNavigateLeft<CR>", "window right" },
    -- ["<C-j>"] = { "<cmd> TmuxNavigateLeft<CR>", "window down" },
    -- ["<C-k>"] = { "<cmd> TmuxNavigateLeft<CR>", "window up" },

    ["<C-h>"] = { "<C-w>h", "Window left" },
    ["<C-l>"] = { "<C-w>l", "Window right" },
    ["<C-j>"] = { "<C-w>j", "Window down" },
    ["<C-k>"] = { "<C-w>k", "Window up" },
  },
}

M.Telescope = {
  n = {
    ["<leader>fk"] = { "<CMD>Telescope keymaps<CR>", " Find keymaps" },
    ["<leader>fs"] = { "<CMD>Telescope lsp_document_symbols<CR>", " Find document symbols" },
    ["<leader>fr"] = { "<CMD>Telescope frecency<CR>", " Recent files" },
    ["<leader>rf"] = {
      function()
        require("telescope").extensions.refactoring.refactors()
      end,
      " Refactor",
    },
    ["<leader>fc"] = {
      "<CMD>Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<CR>",
      " Find current file",
    },
  },
}

M.text = {
  i = {
    -- Move line up and down
    ["<C-Up>"] = { "<CMD>m .-2<CR>==", "󰜸 Move line up" },
    ["<C-Down>"] = { "<CMD>m .+1<CR>==", "󰜯 Move line down" },

    -- Navigate
    ["<A-Left>"] = { "<ESC>I", " Move to beginning of line" },
    ["<A-Right>"] = { "<ESC>A", " Move to end of line" },
    ["<A-d>"] = { "<ESC>diw", " Delete word" },
    ["<S-CR>"] = {
      function()
        vim.cmd "normal o"
      end,
      " New line",
    },
  },

  n = {
    ["<C-Up>"] = { "<CMD>m .-2<CR>==", "󰜸 Move line up" },
    ["<C-Down>"] = { "<CMD>m .+1<CR>==", "󰜯 Move line down" },
    ["<leader>ra"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "󰑕 LSP rename",
    },
  },

  -- hello
  -- hello
  v = {
    ["<C-Up>"] = { ":m'<-2<CR>gv=gv", "󰜸 Move selection up", opts = { silent = true } },
    ["<C-Down>"] = { ":m'>+1<CR>gv=gv", "󰜯 Move selection down", opts = { silent = true } },
    ["<Home>"] = { "gg", "Home" },
    ["<End>"] = { "G", "End" },
    ["y"] = { "y`]", "Yank and move to end" },
    -- Indent backward/forward:
    ["<"] = { "<gv", " Ident backward", opts = { silent = false } },
    [">"] = { ">gv", " Ident forward", opts = { silent = false } },

    ["<C-Left>"] = { "<ESC>_", "󰜲 Move to beginning of line" },
    ["<C-Right>"] = { "<ESC>$", "󰜵 Move to end of line" },
  },

  c = {
    -- Autocomplete for brackets:
    ["("] = { "()<left>", "Auto complete (", opts = { silent = false } },
    ["<"] = { "<><left>", "Auto complete <", opts = { silent = false } },
    ['"'] = { '""<left>', [[Auto complete "]], opts = { silent = false } },
    ["'"] = { "''<left>", "Auto complete '", opts = { silent = false } },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Add Breakpoint at line" },
    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open Debugging sidebar",
    },
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require("dap-python").test_method()
      end,
    },
  },
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require("dap-go").debug_test()
      end,
      "Debug go test",
    },
    ["<leader>dgl"] = {
      function()
        require("dap-go").debug_last()
      end,
      "Debug last go test",
    },
  },
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags",
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags",
    },
  },
}

M.lspsaga = {
  n = {
    ["<leader>."] = { "<CMD>CodeActionMenu<CR>", "󰅱 Code Action" },
    ["<leader>gf"] = {
      function()
        vim.cmd "Lspsaga finder"
      end,
      " Go to definition",
    },
    ["gd"] = { "<CMD>Lspsaga goto_definition<CR>", " Go to definition" },
    ["<leader>lp"] = { "<CMD>Lspsaga peek_definition<CR>", " Peek definition" },
    ["<leader>k"] = {
      "<CMD>Lspsaga hover_doc<CR>",
      -- function()
      --   require("pretty_hover").hover()
      -- end,
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
    ["<leader>s"] = { "<cmd> SymbolsOutline <CR>" },
  },
}

M.hop = {
  n = {
    ["<leader><leader>w"] = { "<cmd> HopWord <CR>", "hint all words" },
    ["<leader><leader>b"] = { "<cmd> HopWord <CR>", "hint all words" },
    ["<leader><leader>j"] = { "<cmd> HopLine <CR>", "hint line" },
    ["<leader><leader>k"] = { "<cmd> HopLine <CR>", "hint line" },
  },
}

M.development = {
  n = {
    ["<leader>i"] = {
      function()
        require("nvim-toggler").toggle()
      end,
      "󰌁 Invert text",
    },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      " Lsp formatting",
    },
    ["<leader>bi"] = {
      function()
        require("nvim-biscuits").toggle_biscuits()
      end,
      "󰆘 Toggle context",
    },
    ["<A-p>"] = { "<CMD>Colortils picker<CR>", " Delete word" },
  },
}

M.window = {
  n = {
    ["<leader><leader>h"] = { "<CMD>vs <CR>", "󰤼 Vertical split", opts = { nowait = true } },
    ["<leader><leader>v"] = { "<CMD>sp <CR>", "󰤻 Horizontal split", opts = { nowait = true } },
  },
}

M.fold = {
  n = {
    ["<leader>a"] = {
      function()
        require("fold-cycle").toggle_all()
      end,
      "󰴋 Toggle folder",
    },
    ["<leader>fp"] = {
      function()
        require("fold-preview").toggle_preview()
      end,
      "󱞊 Fold preview",
    },
    ["<leader>fe"] = { "<CMD> UfoEnableFold <CR>", "Enable UFO folds" },
    ["<leader>fd"] = { "<CMD> UfoDisableFold <CR>", "Disable UFO folds" },
  },
}

M.refactor = {

  n = {
    ["<leader>rr"] = {
      function()
        require("refactoring").select_refactor()
      end,
      "List Refactorings",
    },
    ["<leader>re"] = { "<cmd> Refactor extract<CR>", "Extract To Function" },
    ["<leader>rv"] = { "<cmd> Refactor extract_var<CR>", "Extract To Variable" },
    ["<leader>rb"] = { "<cmd> Refactor extract_block<CR>", "Extract To Block" },
    ["<leader>rg"] = { "<cmd> Refactor extract_block_to_file<CR>", "Extract Block To File" },
    ["<leader>rw"] = { "<cmd> Refactor refactor_names<CR>", "Refactor names" },
    ["<leader>rf"] = { "<cmd> Refactor extract_to_file<CR>", "Extract to file" },
    ["<leader>ri"] = { "<cmd> Refactor inline_var<CR>", "Inline Variable" },
  },

  v = {
    ["<leader>rr"] = {
      function()
        require("refactoring").select_refactor()
      end,
      "List Refactorings",
    },
    ["<leader>re"] = { "<cmd> Refactor extract<CR>", "Extract To Function" },
    ["<leader>rv"] = { "<cmd> Refactor extract_var<CR>", "Extract To Variable" },
    ["<leader>rb"] = { "<cmd> Refactor extract_block<CR>", "Extract To Block" },
    ["<leader>rg"] = { "<cmd> Refactor extract_block_to_file<CR>", "Extract Block To File" },
    ["<leader>rn"] = { "<cmd> Refactor refactor_names<CR>", "Refactor names" },
    ["<leader>rf"] = { "<cmd> Refactor extract_to_file<CR>", "Extract to file" },
    ["<leader>ri"] = { "<cmd> Refactor inline_var<CR>", "Inline Variable" },
  },
}

return M
