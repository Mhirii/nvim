local overrides = require "custom.configs.overrides"
local plugins = {

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                       >> base <<<                        │
  --         ╰──────────────────────────────────────────────────────────╯
  { "BrunoKrugel/nvcommunity" },

  {
    "williamboman/mason.nvim",
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
      "williamboman/mason.nvim",
    },
    config = function()
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
    dependencies = require("custom.configs.cmp").dependencies,
    opts = require("custom.configs.cmp").opts,
  },

  { "hrsh7th/cmp-cmdline" },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "python", "go", "typescript" },
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                       >>> debug <<<                      │
  --         ╰──────────────────────────────────────────────────────────╯
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("core.utils").load_mappings "dap"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
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
    end,
  },

  { -- nvim-dap virtual text
    "theHamsta/nvim-dap-virtual-text",
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup(opts)
    end,
    opts = {},
  },

  { -- nvim-dap installer MAYBE
    "jay-babu/mason-nvim-dap.nvim",

    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },

    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        "codelldb", -- Rust, C/C++
        "python",
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    },
  },

  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                    >>> Languages <<<                     │
  --         ╰──────────────────────────────────────────────────────────╯
  -- Rust
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end,
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
      require("core.utils").load_mappings "dap_python"
    end,
  },

  -- Python indent (follows the PEP8 style)
  { "Vimjas/vim-python-pep8-indent", ft = { "python" } },

  -- Python-related text object
  { "jeetsukumaran/vim-pythonsense", ft = { "python" } },

  --Go

  -- {
  --  "dreamsofcode-io/nvim-dap-go",
  --   ft = "go",
  --   dependencies = "mfussenegger/nvim-dap",
  --   config = function (_, opts)
  --     require("dap-go").setup(opts)
  --   end
  -- },

  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings "gopher"
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },

  --others
  { "elkowar/yuck.vim", lazy = false, ft = "yuck" },

  { "luckasRanarison/tree-sitter-hypr" },

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                       >>> LSP <<<                        │
  --         ╰──────────────────────────────────────────────────────────╯
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
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

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                    >>> Treesitter <<<                    │
  --         ╰──────────────────────────────────────────────────────────╯
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "<leader>jj",
        function()
          require("treesj").toggle()
        end,
        mode = "n",
        desc = "Toggle Treesitter Unjoin",
      },
      {
        "<leader>js",
        function()
          require("treesj").split()
        end,
        mode = "n",
        desc = "Treesitter Split",
      },
      {
        "<leader>jl",
        function()
          require("treesj").join()
        end,
        mode = "n",
        desc = "Treesitter Join Line",
      },
    },
    config = function(_, opts)
      require("treesj").setup(opts)
    end,
    opts = {
      use_default_keymaps = false,
    },
  },

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                     >>> Utility <<<                      │
  --         ╰──────────────────────────────────────────────────────────╯
  {
    "simrat39/symbols-outline.nvim",
    lazy = false,
    opts = function()
      return require "custom.configs.symbols"
    end,
    config = function(_, opts)
      require("symbols-outline").setup(opts)
      require("core.utils").load_mappings "symbols_outline"
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
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

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                 >>> Quality of Life <<<                  │
  --         ╰──────────────────────────────────────────────────────────╯
  {
    "code-biscuits/nvim-biscuits",
    event = "LspAttach",
    config = function()
      require "custom.configs.biscuits"
    end,
  },

  { -- Better quickfix window including telescope integration, code view etc.
    -- TODO: improve this
    "kevinhwang91/nvim-bqf",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
      },
      { -- OPTIONAL for fuzzy searching TODO: Replace MAYBE
        "junegunn/fzf",
        build = function()
          vim.fn["fzf#install"]()
        end,
      },
      {
        "yorickpeterse/nvim-pqf",
      },
    },

    keys = require("custom.configs.nvim-bqf").keys,
    opts = require("custom.configs.nvim-bqf").opts,

    config = function(_, opts) -- TODO: add hlgroups
      require("bqf").setup(opts)
      -- Better UI in quickfix window:
      -- https://github.com/kevinhwang91/nvim-bqf/tree/c920a55c6153766bd909e474b7feffa9739f07e8#format-new-quickfix
      -- https://github.com/kevinhwang91/nvim-bqf/tree/c920a55c6153766bd909e474b7feffa9739f07e8#rebuild-syntax-for-quickfix
    end,
  },

  { -- Note this plugin is written as dependency of quickfix plugins
    -- Prettier quickfix window
    "yorickpeterse/nvim-pqf",

    dependencies = {
      "kevinhwang91/nvim-bqf",
    },

    config = function(_, opts)
      require("pqf").setup(opts)
    end,

    opts = {
      signs = {
        error = "E",
        warning = "W",
        info = "I",
        hint = "H",
      },

      -- By default, only the first line of a multi line message will be shown.
      -- When this is true, multiple lines will be shown for an entry, separated by a space
      show_multiple_lines = false,

      -- How long filenames in the quickfix are allowed to be. 0 means no limit.
      -- Filenames above this limit will be truncated from the beginning with [...]
      max_filename_length = 0,
    },
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
    "gelguy/wilder.nvim",
    build = ":UpdateRemotePlugins",
  },

  --         ╭──────────────────────────────────────────────────────────╮
  --         │                     >>> Folding <<<                      │
  --         ╰──────────────────────────────────────────────────────────╯
  { -- Folding. The fancy way
    "kevinhwang91/nvim-ufo",

    -- event = "VeryLazy",
    keys = require("custom.configs.ufo").keys,
    dependencies = require("custom.configs.ufo").dependencies,
    opts = require("custom.configs.ufo").opts,

    config = function(_, opts)
      require("ufo").setup(opts)

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
    "christoomey/vim-tmux-navigator",
    lazy = false,
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
      -- This plugin enables by default
      -- So we toggle it to reanable it (because we only have a toggling function)
      vim.cmd [[MarksToggleSigns]]
    end,

    opts = {
      -- whether to map keybinds or not. default true
      default_mappings = true,
      -- which builtin marks to show. default {}
      builtin_marks = { ".", "<", ">", "^" },
      -- whether movements cycle back to the beginning/end of buffer. default true
      cyclic = true,
      -- whether the shada file is updated after modifying uppercase marks. default false
      force_write_shada = false,
      -- how often (in ms) to redraw signs/recompute mark positions.
      -- higher values will have better performance but may cause visual lag,
      -- while lower values may cause performance penalties. default 150.
      refresh_interval = 250,
      -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
      -- marks, and bookmarks.
      -- can be either a table with all/none of the keys, or a single number, in which case
      -- the priority applies to all marks.
      -- default 10.
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      -- disables mark tracking for specific filetypes. default {}
      excluded_filetypes = {},
      -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
      -- sign/virttext. Bookmarks can be used to group together positions and quickly move
      -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
      -- default virt_text is "".
      bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world",
        -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
        -- defaults to false.
        annotate = false,
      },
      mappings = {},
    },
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

}

--TODO: cmp

return plugins
