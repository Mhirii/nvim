local plugins = {
  {
    "illiamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "js-debug-adapter",
        "prettier",
        "typescript-language-server",

        "clangd",
        "clang-format",
        "codelldb",

        "black",
        "debugpy",
        "mypy",
        "ruff",
        "pyright",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "c",
        "cpp",
        "rust",
        "go",
        "org",
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
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                       >>> LSP <<<                        │
  --         ╰──────────────────────────────────────────────────────────╯

  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- 'nvim-tree/nvim-web-devicons'     -- optional
    },
    config = function()
      require "custom.configs.lspsaga"
    end,
  },

  {
    "VidocqH/lsp-lens.nvim",
    event = "LspAttach",
    config = true,
    enable = true,
  },

  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
  },

  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("custom.configs.lsp_signature").config()
    end,
    event = { "BufRead", "BufNew" },
  },

  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require "custom.configs.trouble"
    end,
  },
  {
    "dnlhc/glance.nvim",
    config = function()
      require "custom.configs.glance"
    end,
    cmd = { "Glance" },
    keys = {
      { "gd", "<cmd>Glance definitions<CR>", desc = "LSP Definition" },
      { "gr", "<cmd>Glance references<CR>", desc = "LSP References" },
      { "gm", "<cmd>Glance implementations<CR>", desc = "LSP Implementations" },
      { "gy", "<cmd>Glance type_definitions<CR>", desc = "LSP Type Definitions" },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = require("custom.configs.cmp").dependencies,
    opts = require("custom.configs.cmp").opts,
  },
  { "hrsh7th/cmp-cmdline" },

  {
    "jcdickinson/codeium.nvim",
    event = "InsertEnter",
    cmd = "Codeium",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = true,
  },
  --         ╭──────────────────────────────────────────────────────────╮
  --         │                  >> Quality of Life <<                   │
  --         ╰──────────────────────────────────────────────────────────╯

  {
    "ThePrimeagen/refactoring.nvim",
    event = "BufRead",
    config = function()
      require("refactoring").setup {
        prompt_func_return_type = {
          go = true,
        },
        prompt_func_param_type = {
          go = true,
        },
      }
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

  {
    "LudoPinelli/comment-box.nvim",
    config = function(_, opts)
      require("comment-box").setup(opts)
    end,

    keys = {
      {
        "<leader>bb",
        function()
          require("comment-box").ccbox()
        end,
        mode = { "n", "v" },
        desc = "Comment Box",
      },

      {
        "<leader>be",
        function()
          -- take an input:
          local input = vim.fn.input "Catalog: "
          require("comment-box").ccbox(input)
        end,
        mode = { "n", "v" },
        desc = "Left Comment Box",
      },

      {
        "<leader>bc",
        function()
          require("comment-box").lbox()
        end,
        mode = { "n", "v" },
        desc = "Left Comment Box",
      },

      {
        "<leader>bx",
        function()
          require("comment-box").catalog()
        end,
        mode = { "n", "v" },
        desc = "Comment Catalog",
      },
    },

    opts = {
      doc_width = 80, -- width of the document
      box_width = 60, -- width of the boxes
      borders = { -- symbols used to draw a box
        top = "─",
        bottom = "─",
        left = "│",
        right = "│",
        top_left = "╭",
        top_right = "╮",
        bottom_left = "╰",
        bottom_right = "╯",
      },
      line_width = 70, -- width of the lines
      line = { -- symbols used to draw a line
        line = "─",
        line_start = "─",
        line_end = "─",
      },
      outer_blank_lines = false, -- insert a blank line above and below the box
      inner_blank_lines = false, -- insert a blank line above and below the text
      line_blank_line_above = false, -- insert a blank line above the line
      line_blank_line_below = false, -- insert a blank line below the line
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("custom.configs.todo_comments").config()
    end,
    event = "BufRead",
  },

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                     >>> Movement <<<                     │
  --         ╰──────────────────────────────────────────────────────────╯

  {
    "phaazon/hop.nvim",
    event = "BufReadPost",
    branch = "v2",
    config = function()
      require "custom.configs.hop"
    end,
  },

  {
    "mrjones2014/smart-splits.nvim",
    -- For Kitty Terminal Emulator
    -- build = "./kitty/install-kittens.bash",
    keys = {
      {
        "<C-Up",
        function()
          require("smart-splits").resize_up(5)
        end,
        mode = "n",
        desc = "Resize Up",
      },
      {
        "<C-Down>",
        function()
          require("smart-splits").resize_down(5)
        end,
        mode = "n",
        desc = "Resize Down",
      },
      {
        "<C-Left>",
        function()
          require("smart-splits").resize_left(5)
        end,
        mode = "n",
        desc = "Resize Left",
      },
      {
        "<C-Right>",
        function()
          require("smart-splits").resize_right(5)
        end,
        mode = "n",
        desc = "Resize Right",
      },

      {
        "<leader>mr",
        function()
          require("smart-splits").start_resize_mode()
        end,
        mode = "n",
        desc = "Resize Mode",
      },
    },

    config = function(_, opts)
      require("smart-splits").setup()
    end,
  },

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                        >>> UI <<<                        │
  --         ╰──────────────────────────────────────────────────────────╯
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

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                    >> improvements <<                    │
  --         ╰──────────────────────────────────────────────────────────╯

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "chentoast/marks.nvim",
    keys = {
      {
        "<leader>bm",
        "<cmd> MarksToggleSigns<CR>",
        mode = "n",
        desc = "Marks",
      },
    },
    config = function(_, opts)
      require("marks").setup(opts)
      vim.cmd [[MarksToggleSigns]]
    end,
    opts = {
      default_mappings = true,
      builtin_marks = { ".", "<", ">", "^" },
      cyclic = true,
      force_write_shada = false,
      refresh_interval = 250,
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      excluded_filetypes = {},
      bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world",
        annotate = false,
      },
      mappings = {},
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    keys = require("custom.configs.ufo").keys,
    dependencies = require("custom.configs.ufo").dependencies,
    opts = require("custom.configs.ufo").opts,

    config = function(_, opts)
      require("ufo").setup(opts)
      require("ufo").openAllFolds()

      -- Better UI elements
      -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      -- vim.o.foldcolumn = "3" -- "1" is better
    end,
  },
  {
    "jghauser/fold-cycle.nvim",
    opts = {},
  },
  --         ╭──────────────────────────────────────────────────────────╮
  --         │                          Extras                          │
  --         ╰──────────────────────────────────────────────────────────╯
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitFilter" },
    config = function()
      vim.g.lazygit_floating_window_scaling_factor = 1 -- scaling factor for floating window
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                        Typescript                        │
  --         ╰──────────────────────────────────────────────────────────╯

  {
    "pmizio/typescript-tools.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "typescript", "typescriptreact" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require "custom.configs.typescript-tools"
    end,
  },
  {
    "axelvc/template-string.nvim",
    event = "InsertEnter",
    ft = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    config = true, -- run require("template-string").setup()
  },

  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    config = true,
  },
}

return plugins
