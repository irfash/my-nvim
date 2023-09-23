local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--require("lazy").setup({spec =  {import = "irfash.lazy.plugins"},
require("lazy").setup({spec =  {import = "irfash.lazy.plugins"},})




-- Load functions next as our plugins and autocmds require them
-- require("irfash.config.functions")

-- Autocmds and keymaps can be loaded, lazily, after plugins
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "VeryLazy",
--   callback = function()
--     require("irfash.config.commands")
--     require("irfash.config.keymaps")
--   end,
-- })
