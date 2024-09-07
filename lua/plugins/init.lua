return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    'mfussenegger/nvim-jdtls'
  },
  {
  	"nvim-treesitter/nvim-treesitter",
    -- build = ":TSUpdate",
    -- event = { "BufReadPre", "BufNewFile"},
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
        "html", "css",
        "typescript", "javascript"
  		},
  	},
    -- config = function()
    --   local treesitter = require("nvim-treesitter.configs")
    --   treesitter.setup({
    --     highlight = {
    --       enable = true,
    --     },
    --     indent  = { enable = true },
    --     ensure_installed = {
    --       "vim", "lua", "vimdoc",
    --       "html", "css",
    --       "typescript", "javascript"
    --     },
    --     incremental_selection = {
    --       enable = true,
    --       keymaps = {
    --         init_selection = "<C-space>",
    --         node_incremental = "<C-space>",
    --         scope_incremental = false,
    --         node_decremental = "<bs>",
    --       }
    --     }
    --   })
    -- end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 60,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })

      -- Set keymaps
      vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })
      vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', { silent = true })
    end,
  },
}
