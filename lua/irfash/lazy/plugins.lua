return {
  { "lewis6991/impatient.nvim" },
  { "nvim-lua/plenary.nvim" },

  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
    require("nvim-treesitter.configs").setup({
    highlight = {
    enable = true,
      additional_vim_regex_highlighting = { "markdown" },
  },
   playground = {
    enable = true,
     }

      })
  end,
  dependencies = {
  "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",
   }
   },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<C-f>",      ":Telescope find_files<CR>" },
      { "<Leader>ff", ":Telescope live_grep<CR>" },
      { "<Leader>fb", ":Telescope buffers<CR>" },
      { "<Leader>fh", ":Telescope help_tags<CR>" },
      { "<leader>gr", ":Telescope lsp_references<CR>" },
      { "<leader>gd", ":Telescope lsp_definitions<CR>" },
      { "<Leader>ds", ":Telescope lsp_document_symbols symbols=func,function,class<CR>" },
      { "<C-a>",      ":lua vim.lsp.buf.code_action()<CR>" },
      { "<Leader>p",  ":Telescope workspaces<CR>" },
    },
    dependencies = "natecraddock/workspaces.nvim",
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("workspaces")
      telescope.setup({
        extensions = {
          workspaces = {
            -- keep insert mode after selection in the picker, default is false
            keep_insert = true,
          },
        },
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = true,
  },

  {
    "nvim-tree/nvim-web-devicons",
    event = "VeryLazy"
  },

  { "ray-x/lsp_signature.nvim", config = { hint_prefix = "🧸 " } },
  { "kylechui/nvim-surround", config = true },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    -- cond = firenvim_not_active,
    config = function()
      require("irfash.plugins-backup.lualine")
    end,
  },

  {
    "VonHeikemen/lsp-zero.nvim",
    config = function()
      local lsp = require("lsp-zero")
      local cmp = require("cmp")
      local types = require("cmp.types")
      local str = require("cmp.utils.str")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("irfash.plugins-backup.lsp")
      lsp.preset("recommended")
      --lsp.nvim_workspace()
      --lsp.skip_server_setup({ "rust_analyzer" })
      lsp.setup()

      local cmp_config = lsp.defaults.cmp_config({
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<Tab>"] = cmp.mapping.confirm({
            -- this is the important line
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
          ["<C-l>"] = cmp.mapping(function(fallback)
            if luasnip and luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function(fallback)
            if luasnip and luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({

          -- { name = "copilot", group_index = 2 },
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "buffer" },
        }),
        formatting = {
          fields = {
            cmp.ItemField.Kind,
            cmp.ItemField.Abbr,
            cmp.ItemField.Menu,
          },
          format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 40,
            ellipsis_char = '...',
            -- symbol_map = { Copilot = "" }
          }),
        }
      })
      cmp.setup(cmp_config)

      require("mason-null-ls").setup({ automatic_setup = true })
    end,
    dependencies = {
      -- LSP Support
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Autocompletion
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      -- {
      --   "zbirenbaum/copilot-cmp",
      --   dependencies = {
      --     "zbirenbaum/copilot.lua",
      --     -- config = {
      --     --   suggestion = { enabled = false },
      --     --   panel = { enabled = false },
      --     -- }
      --   },
      --   config = true
      -- },

      -- Snippets
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",

      --null-ls
      "jose-elias-alvarez/null-ls.nvim",
      "jayp0521/mason-null-ls.nvim",

      -- lspkind
      "onsails/lspkind.nvim"
    },
  },
 --
 --
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = true
  },
 --
--
--
  {
    "mickael-menu/zk-nvim",
    name = "zk",
    config = function()
      require("zk").setup({ picker = "telescope" })
      require("zk.commands").add("ZkStartingPoint", function(options)
        options = vim.tbl_extend("force", { match = "§§", matchStrategy = "exact" }, options or {})
        require("zk").edit(options, { title = "§§" })
      end)
    end,
    keys = {
      {
        "<Leader>§§",
        function()
          require("zk.commands").get("ZkStartingPoint")()
        end,
      },
      {
        "<Leader>zk",
        function()
          require("zk.commands").get("ZkNotes")({ select = { "path" } })
        end,
      },
      {
        "<Leader>zb",
        function()
          require("zk.commands").get("ZkBacklinks")()
        end,
      },
      {
        "<Leader>zi",
        function()
          require("zk.commands").get("ZkLinks")()
        end,
      },
      {
        "<Leader>zt",
        function()
          require("zk.commands").get("ZkTags")({ sort = { "note-count" } })
        end,
      },
      {
        "<Leader>zn",
        function()
          require("zk.commands").get("ZkNew")({ title = vim.fn.input("Title: ") })
        end,
      },
      -- TODO: random note: :ZkNotes { sort = {"random"}, limit = 1 } (https://github.com/mickael-menu/zk-nvim/discussions/94)
    },
  },
--
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require('mini.test').setup()
    end
  },
--
--
--
--
--
--
--#############################
 {
 "numToStr/Comment.nvim",
 config = {
 toggler = {
line = "<Leader>cc",
block = "<Leader>bc",
},
opleader = {
line = "<Leader>c",
block = "<Leader>b",
},
extra = {
eol = "<Leader>ca",
},
},
},
{
"natecraddock/workspaces.nvim",
config = {
  hooks = {
  open = { "Telescope find_files" },
  },
  },
  },


   {
  "nvim-tree/nvim-tree.lua",
  config = { sync_root_with_cwd = true },
  keys = {
  {
  "<Leader>t",
  function()
  require("nvim-tree.api").tree.toggle()
  end,
  },
  },
  },

  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    config = function ()
      require("gruvbox").setup({
        transparent_mode = true,
      })
    end,
    -- {
      -- dark_variant = "moon",
      -- disable_background = true       -- In case of transparent terminals
    -- },
    init = function()
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
