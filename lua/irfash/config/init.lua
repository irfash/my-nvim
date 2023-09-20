-- Load Neovim options before Lazy loads plugins
require("irfash.config.options")
-- require("irfash.options")
-- Begin Lazy install and plugin setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  spec = { import = "irfash.plugins" },
})

-- Load functions next as our plugins and autocmds require them
require("irfash.config.functions")

-- Autocmds and keymaps can be loaded, lazily, after plugins
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("irfash.config.commands")
    require("irfash.config.keymaps")
  end,
})
