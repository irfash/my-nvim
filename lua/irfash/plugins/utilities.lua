return {
  "nvim-lua/plenary.nvim", -- Required dependency for many plugins. Super useful Lua functions
  {
    "mrjones2014/legendary.nvim", -- A command palette for keymaps, commands and autocmds
    priority = 10000,
    lazy = false, -- Never lazy load this
    dependencies = "kkharji/sqlite.lua",
    init = function()
      require("legendary").keymaps({
        {
          "<C-p>",
          require("legendary").find,
          hide = true,
          description = "Open Legendary",
          mode = { "n", "v" },
        },
      })
    end,
    config = function()
      require("legendary").setup({
        select_prompt = "Legendary",
        include_builtin = false,
        include_legendary_cmds = false,
        lazy_nvim = { auto_register = true },
        which_key = { auto_register = false },
        -- Load these with the plugin to ensure they are loaded before any Neovim events
        autocmds = require("irfash.config.autocmds"),
      })
    end,
  },
  {
    "olimorris/persisted.nvim", -- Session management
    priority = 100,
    opts = {
      save_dir = Sessiondir .. "/",
      use_git_branch = true,
      silent = true,
      -- autoload = true,
      should_autosave = function()
        local excluded_filetypes = {
          -- "alpha",
          "oil",
          "lazy",
          "",
        }

        for _, filetype in ipairs(excluded_filetypes) do
          if vim.bo.filetype == filetype then return false end
        end

        return true
      end,
    },
    init = function()
      require("legendary").keymaps({
        {
          itemgroup = "Persisted",
          icon = "",
          description = "Session management...",
          keymaps = {
            {
              "<Leader>s",
              '<cmd>lua require("persisted").toggle()<CR>',
              description = "Toggle a session",
              opts = { silent = true },
            },
          },
        },
      })
      require("legendary").commands({
        {
          itemgroup = "Persisted",
          commands = {
            {
              ":Sessions",
              function() vim.cmd([[Telescope persisted]]) end,
              description = "List sessions",
            },
            {
              ":SessionSave",
              description = "Save the session",
            },
            {
              ":SessionStart",
              description = "Start a session",
            },
            {
              ":SessionStop",
              description = "Stop the current session",
            },
            {
              ":SessionLoad",
              description = "Load the last session",
            },
            {
              ":SessionDelete",
              description = "Delete the current session",
            },
          },
        },
      })
    end,
  },
  {
    "kevinhwang91/nvim-bqf", -- Better quickfix window,
    ft = "qf",
  },
  {
    "nathom/tmux.nvim", -- Navigate Tmux panes inside of neovim
    enabled = function() return os.getenv("TMUX") end,
    init = function()
      require("legendary").keymaps({
        {
          "<C-k>",
          "<cmd>lua require('tmux').move_up()<CR>",
          description = "Tmux: Move up",
        },
        {
          "<C-j>",
          "<cmd>lua require('tmux').move_down()<CR>",
          description = "Tmux: Move down",
        },
        {
          "<C-h>",
          "<cmd>lua require('tmux').move_left()<CR>",
          description = "Tmux: Move left",
        },
        {
          "<C-l>",
          "<cmd>lua require('tmux').move_right()<CR>",
          description = "Tmux: Move right",
        },
      })
    end,
  },
  {
    "dstein64/vim-startuptime", -- Profile your Neovim startup time
    cmd = "StartupTime",
    init = function()
      require("legendary").commands({
        {
          ":StartupTime",
          description = "Profile Neovim's startup time",
        },
      })
    end,
    config = function()
      vim.g.startuptime_tries = 15
      vim.g.startuptime_exe_args = { "+let g:auto_session_enabled = 0" }
    end,
  },
}
