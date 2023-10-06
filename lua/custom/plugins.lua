local overrides = require "custom.configs.overrides"
local plugins = {


  --- >>> base <<<
  { "BrunoKrugel/nvcommunity" },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        -- >> Rust Specefic
        "rust-analyzer",
        -- >> Python Specefic
        -- "black",
        -- "debugpy",
        -- "mypy",
        -- "ruff",
        -- "pyright",
        -- >> Go Specefic
        "gopls",
        -- >> TypeScript
        -- "typescript-language-server",
        "css-lsp",
        "html-lsp",
        -- "deno",
      }
    }
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",
        -- web dev
        "html",
        "css",
        "javascript",
        "typescript",
        -- "tsx",
        "json",
        -- "vue", "svelte",

        -- low level
        "c",
        -- "cpp",
        -- "cmake",
        "rust",
        "go",
        -- "zig",

        -- Note
        "org",

        -- Script
        "bash",
        "python",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "nvimtools/none-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- Overrides
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
  --

  {
    "hrsh7th/nvim-cmp",
    opts = function ()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, {name = "crates"})
      return M
    end
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"python", "go", "typescript"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  --- >>> debug <<<
  {
    "mfussenegger/nvim-dap",
    config = function (_, opts)
      require("core.utils").load_mappings("dap")
    end
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },


  --- >>> Languages <<<
  -- Rust
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },

  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require('rust-tools').setup(opts)
    end
  },

  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function (_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end
  },

-- Python
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },

  --Go 
  {
   "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function (_, opts)
      require("dap-go").setup(opts)
    end
  },

  -- Use dreamsofcode fork if the console error issue happens
  -- {
  -- "leoluz/nvim-dap-go",
  -- },

  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },

  --others
  {"elkowar/yuck.vim",
    lazy = false,
    ft = "yuck",
  },

  { "luckasRanarison/tree-sitter-hypr"},

  --- >>> LSP <<<
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require "custom.configs.lspsaga"
    end,
  },

  {
    "VidocqH/lsp-lens.nvim",
    event = "LspAttach",
    config = true,
  },

  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
  },

  --- >>> Utility <<<
  {
    "simrat39/symbols-outline.nvim",
    lazy=false,
    opts = function ()
      return require "custom.configs.symbols"
    end,
    config = function(_, opts)
      require("symbols-outline").setup(opts)
      require("core.utils").load_mappings("symbols_outline")
    end
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },

  {
    "ThePrimeagen/refactoring.nvim",
    event = "BufRead",
    config = function()
      require "custom.configs.refactoring"
    end,
  },

  {
    "nguyenvukhang/nvim-toggler",
    event = "BufReadPost",
    config = function()
      require("nvim-toggler").setup {
        remove_default_keybinds = true,
      }
    end,
  },

  --- >>> Quality of Life <<<
  {
    "code-biscuits/nvim-biscuits",
    event = "LspAttach",
    config = function()
      require "custom.configs.biscuits"
    end,
  },


  --- >>> Movement <<<
  {
    "phaazon/hop.nvim",
    event = "BufReadPost",
    branch = "v2",
    config = function()
      require "custom.configs.hop"
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  --- >>> UI <<<
  {
    "stevearc/dressing.nvim",

    event = "VeryLazy", -- FIXME: maybe lazy loadable?

    config = function(_, opts)
      require("dressing").setup(opts)
    end,

    opts = {
      default_prompt = "❯ ",
    },
  },



}


return plugins
